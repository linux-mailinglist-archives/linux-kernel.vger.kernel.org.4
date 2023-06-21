Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71600737958
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFUCt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFUCt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:49:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCE10C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687315765; x=1718851765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0zflA3tprr4dANxBLyGkK7sp29/Tso1ozZZZAy9qPM=;
  b=J+E/v6R9XaEjgCyDmLmikbkJ/bZMmWcSX2wXCHmv2Li3km1d0IrGeznY
   SnXSGqfvx2Qh+Ic1K8MPGWvnI9Seg3XqbMiDj/8txyXj8lWLc2k5/v4Dv
   ZgLjFRbscGY4346gy72gyrIBCeMw/dLkYzxyGbff78HaZp0MJk1TvhhDi
   8/VRVeIWnqdl9SFNg1BaLffmtu16/geYQWorHhDfrRCrDAy3PtJrAQhxE
   Cn5vfVsyoJnCUA8u10gwMrSxNklAjk01xQQbeEFVWoshNI3FEyP2Fg3Bw
   J1R2+0H8hXYSbHXecuUEWKgeldHpGN5tiv+/ozTJShuf3kefLLjKV/APm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357541231"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="357541231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804183050"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="804183050"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 19:49:24 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v1 1/2] firmware: stratix10-svc: Support up to N SVC clients
Date:   Wed, 21 Jun 2023 10:48:56 +0800
Message-Id: <20230621024856.1392244-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

This fixes the SVC Time-out issue on Intel's firmware SVC mailbox service
when more than 1 client driver sends SMC commands concurrently. A thread
is created now per channel. Current stratix10-svc driver supports N
channels. Thread synchronization with mutex is used to prevent more
than one thread from calling SMC command. The time-out are adjusted
to cater for multiple drivers.

In the old implementation, the respective SVC client drivers like
intel_fcs and stratix10-soc sends a SMC command
and this triggers a single thread at the stratix10-svc driver.
Upon receiving a callback, the caller driver sends
stratix10-svc-done and it stops the thread without waiting
for the other SMC commands to complete.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/firmware/stratix10-svc.c | 181 ++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 62 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 80f4e2d14e04..ca713f39107e 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -33,9 +33,9 @@
  * service layer will return error to FPGA manager when timeout occurs,
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
-#define SVC_NUM_DATA_IN_FIFO			32
+#define SVC_NUM_DATA_IN_FIFO			8
 #define SVC_NUM_CHANNEL				3
-#define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
+#define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	2000
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 
 /* stratix10 service layer clients */
@@ -125,14 +125,11 @@ struct stratix10_svc_data {
  * @dev: device
  * @chans: array of service channels
  * @num_chans: number of channels in 'chans' array
- * @num_active_client: number of active service client
  * @node: list management
  * @genpool: memory pool pointing to the memory region
- * @task: pointer to the thread task which handles SMC or HVC call
- * @svc_fifo: a queue for storing service message data
  * @complete_status: state for completion
- * @svc_fifo_lock: protect access to service message data queue
  * @invoke_fn: function to issue secure monitor call or hypervisor call
+ * @sdm_lock: a mutex lock to allow only one pending sdm message per client
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -141,14 +138,12 @@ struct stratix10_svc_controller {
 	struct device *dev;
 	struct stratix10_svc_chan *chans;
 	int num_chans;
-	int num_active_client;
 	struct list_head node;
 	struct gen_pool *genpool;
-	struct task_struct *task;
-	struct kfifo svc_fifo;
 	struct completion complete_status;
-	spinlock_t svc_fifo_lock;
 	svc_invoke_fn *invoke_fn;
+	/* Enforces atomic command sending to SDM */
+	struct mutex *sdm_lock;
 };
 
 /**
@@ -156,6 +151,9 @@ struct stratix10_svc_controller {
  * @ctrl: pointer to service controller which is the provider of this channel
  * @scl: pointer to service client which owns the channel
  * @name: service client name associated with the channel
+ * @task: pointer to the thread task which handles SMC or HVC call
+ * @svc_fifo: a queue for storing service message data
+ * @svc_fifo_lock: protect access to service message data queue
  * @lock: protect access to the channel
  *
  * This struct is used by service client to communicate with service layer, each
@@ -165,6 +163,11 @@ struct stratix10_svc_chan {
 	struct stratix10_svc_controller *ctrl;
 	struct stratix10_svc_client *scl;
 	char *name;
+	struct task_struct *task;
+	struct kfifo svc_fifo;
+	/* Access protection to the message data queue */
+	spinlock_t svc_fifo_lock;
+	/* Access protection to the channel */
 	spinlock_t lock;
 };
 
@@ -382,13 +385,14 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
  */
 static int svc_normal_to_secure_thread(void *data)
 {
-	struct stratix10_svc_controller
-			*ctrl = (struct stratix10_svc_controller *)data;
-	struct stratix10_svc_data *pdata;
-	struct stratix10_svc_cb_data *cbdata;
+	struct stratix10_svc_chan *chan =  (struct stratix10_svc_chan *)data;
+	struct stratix10_svc_controller	*ctrl = chan->ctrl;
+	struct stratix10_svc_data *pdata = NULL;
+	struct stratix10_svc_cb_data *cbdata = NULL;
 	struct arm_smccc_res res;
 	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
 	int ret_fifo = 0;
+	bool sdm_lock_owned = false;
 
 	pdata =  kmalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -410,12 +414,12 @@ static int svc_normal_to_secure_thread(void *data)
 	a6 = 0;
 	a7 = 0;
 
-	pr_debug("smc_hvc_shm_thread is running\n");
+	pr_debug("%s: %s: Thread is running!\n", __func__, chan->name);
 
 	while (!kthread_should_stop()) {
-		ret_fifo = kfifo_out_spinlocked(&ctrl->svc_fifo,
+		ret_fifo = kfifo_out_spinlocked(&chan->svc_fifo,
 						pdata, sizeof(*pdata),
-						&ctrl->svc_fifo_lock);
+						&chan->svc_fifo_lock);
 
 		if (!ret_fifo)
 			continue;
@@ -424,6 +428,16 @@ static int svc_normal_to_secure_thread(void *data)
 			 (unsigned int)pdata->paddr, pdata->command,
 			 (unsigned int)pdata->size);
 
+		/* SDM can only process one command at a time */
+		if (!sdm_lock_owned) {
+			/* Must not do mutex re-lock */
+			pr_debug("%s: %s: Thread is waiting for mutex!\n",
+				 __func__, chan->name);
+			mutex_lock(ctrl->sdm_lock);
+		}
+
+		sdm_lock_owned = true;
+
 		switch (pdata->command) {
 		case COMMAND_RECONFIG_DATA_CLAIM:
 			svc_thread_cmd_data_claim(ctrl, pdata, cbdata);
@@ -538,8 +552,8 @@ static int svc_normal_to_secure_thread(void *data)
 			pr_warn("it shouldn't happen\n");
 			break;
 		}
-		pr_debug("%s: before SMC call -- a0=0x%016x a1=0x%016x",
-			 __func__,
+		pr_debug("%s: %s: before SMC call -- a0=0x%016x a1=0x%016x",
+			 __func__, chan->name,
 			 (unsigned int)a0,
 			 (unsigned int)a1);
 		pr_debug(" a2=0x%016x\n", (unsigned int)a2);
@@ -548,8 +562,8 @@ static int svc_normal_to_secure_thread(void *data)
 		pr_debug(" a5=0x%016x\n", (unsigned int)a5);
 		ctrl->invoke_fn(a0, a1, a2, a3, a4, a5, a6, a7, &res);
 
-		pr_debug("%s: after SMC call -- res.a0=0x%016x",
-			 __func__, (unsigned int)res.a0);
+		pr_debug("%s: %s: after SMC call -- res.a0=0x%016x",
+			 __func__, chan->name, (unsigned int)res.a0);
 		pr_debug(" res.a1=0x%016x, res.a2=0x%016x",
 			 (unsigned int)res.a1, (unsigned int)res.a2);
 		pr_debug(" res.a3=0x%016x\n", (unsigned int)res.a3);
@@ -564,6 +578,8 @@ static int svc_normal_to_secure_thread(void *data)
 			cbdata->kaddr2 = NULL;
 			cbdata->kaddr3 = NULL;
 			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
+			mutex_unlock(ctrl->sdm_lock);
+			sdm_lock_owned = false;
 			continue;
 		}
 
@@ -637,7 +653,9 @@ static int svc_normal_to_secure_thread(void *data)
 
 		}
 	}
-
+	pr_debug("%s: %s: Exit thread\n", __func__, chan->name);
+	if (sdm_lock_owned)
+		mutex_unlock(ctrl->sdm_lock);
 	kfree(cbdata);
 	kfree(pdata);
 
@@ -699,7 +717,7 @@ static int svc_get_sh_memory(struct platform_device *pdev,
 
 	/* smc or hvc call happens on cpu 0 bound kthread */
 	sh_memory_task = kthread_create_on_node(svc_normal_to_secure_shm_thread,
-					       (void *)sh_memory,
+						(void *)sh_memory,
 						cpu_to_node(cpu),
 						"svc_smc_hvc_shm_thread");
 	if (IS_ERR(sh_memory_task)) {
@@ -897,7 +915,6 @@ struct stratix10_svc_chan *stratix10_svc_request_channel_byname(
 
 	spin_lock_irqsave(&chan->lock, flag);
 	chan->scl = client;
-	chan->ctrl->num_active_client++;
 	spin_unlock_irqrestore(&chan->lock, flag);
 
 	return chan;
@@ -916,7 +933,6 @@ void stratix10_svc_free_channel(struct stratix10_svc_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flag);
 	chan->scl = NULL;
-	chan->ctrl->num_active_client--;
 	module_put(chan->ctrl->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flag);
 }
@@ -947,24 +963,24 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 		return -ENOMEM;
 
 	/* first client will create kernel thread */
-	if (!chan->ctrl->task) {
-		chan->ctrl->task =
+	if (!chan->task) {
+		chan->task =
 			kthread_create_on_node(svc_normal_to_secure_thread,
-					      (void *)chan->ctrl,
-					      cpu_to_node(cpu),
-					      "svc_smc_hvc_thread");
-			if (IS_ERR(chan->ctrl->task)) {
+					       (void *)chan,
+					       cpu_to_node(cpu),
+					       "svc_smc_hvc_thread");
+			if (IS_ERR(chan->task)) {
 				dev_err(chan->ctrl->dev,
 					"failed to create svc_smc_hvc_thread\n");
 				kfree(p_data);
 				return -EINVAL;
 			}
-		kthread_bind(chan->ctrl->task, cpu);
-		wake_up_process(chan->ctrl->task);
+		kthread_bind(chan->task, cpu);
+		wake_up_process(chan->task);
 	}
 
-	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
-		 p_msg->payload, p_msg->command,
+	pr_debug("%s: %s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
+		 chan->name, p_msg->payload, p_msg->command,
 		 (unsigned int)p_msg->payload_length);
 
 	if (list_empty(&svc_data_mem)) {
@@ -999,12 +1015,16 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 	p_data->arg[2] = p_msg->arg[2];
 	p_data->size = p_msg->payload_length;
 	p_data->chan = chan;
-	pr_debug("%s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n", __func__,
-	       (unsigned int)p_data->paddr, p_data->command,
-	       (unsigned int)p_data->size);
-	ret = kfifo_in_spinlocked(&chan->ctrl->svc_fifo, p_data,
+	pr_debug("%s: %s: put to FIFO pa=0x%016x, cmd=%x, size=%u\n",
+		 __func__,
+		 chan->name,
+		 (unsigned int)p_data->paddr,
+		 p_data->command,
+		 (unsigned int)p_data->size);
+
+	ret = kfifo_in_spinlocked(&chan->svc_fifo, p_data,
 				  sizeof(*p_data),
-				  &chan->ctrl->svc_fifo_lock);
+				  &chan->svc_fifo_lock);
 
 	kfree(p_data);
 
@@ -1025,12 +1045,21 @@ EXPORT_SYMBOL_GPL(stratix10_svc_send);
  */
 void stratix10_svc_done(struct stratix10_svc_chan *chan)
 {
-	/* stop thread when thread is running AND only one active client */
-	if (chan->ctrl->task && chan->ctrl->num_active_client <= 1) {
-		pr_debug("svc_smc_hvc_shm_thread is stopped\n");
-		kthread_stop(chan->ctrl->task);
-		chan->ctrl->task = NULL;
+	/* stop thread when thread is running */
+	if (chan->task) {
+		if (!IS_ERR(chan->task)) {
+			struct task_struct *task_to_stop = chan->task;
+
+			chan->task = NULL;
+			pr_debug("%s: %s: svc_smc_hvc_shm_thread is stopping\n",
+				 __func__, chan->name);
+			kthread_stop(task_to_stop);
+		}
+
+		chan->task = NULL;
 	}
+	pr_debug("%s: %s: svc_smc_hvc_shm_thread has stopped\n",
+		 __func__, chan->name);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_done);
 
@@ -1068,8 +1097,8 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	pmem->paddr = pa;
 	pmem->size = s;
 	list_add_tail(&pmem->node, &svc_data_mem);
-	pr_debug("%s: va=%p, pa=0x%016x\n", __func__,
-		 pmem->vaddr, (unsigned int)pmem->paddr);
+	pr_debug("%s: %s: va=%p, pa=0x%016x\n", __func__,
+		 chan->name, pmem->vaddr, (unsigned int)pmem->paddr);
 
 	return (void *)va;
 }
@@ -1089,7 +1118,7 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {
 			gen_pool_free(chan->ctrl->genpool,
-				       (unsigned long)kaddr, pmem->size);
+				     (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
 			return;
@@ -1105,6 +1134,23 @@ static const struct of_device_id stratix10_svc_drv_match[] = {
 	{},
 };
 
+static DEFINE_MUTEX(mailbox_lock);
+
+static void stratix10_svc_free_channels(struct stratix10_svc_controller *ctrl)
+{
+	int i;
+
+	for (i = 0; i < SVC_NUM_CHANNEL; i++) {
+		if (ctrl->chans[i].task) {
+			kthread_stop(ctrl->chans[i].task);
+			ctrl->chans[i].task = NULL;
+		}
+
+		if (&ctrl->chans[i].svc_fifo)
+			kfifo_free(&ctrl->chans[i].svc_fifo);
+	}
+}
+
 static int stratix10_svc_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1152,35 +1198,50 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	controller->dev = dev;
 	controller->num_chans = SVC_NUM_CHANNEL;
-	controller->num_active_client = 0;
 	controller->chans = chans;
 	controller->genpool = genpool;
-	controller->task = NULL;
 	controller->invoke_fn = invoke_fn;
 	init_completion(&controller->complete_status);
 
+	/* This mutex is used to block threads from utilizing
+	 * SDM to prevent out of order command tx
+	 */
+	controller->sdm_lock = &mailbox_lock;
+
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
-	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
-	if (ret) {
-		dev_err(dev, "failed to allocate FIFO\n");
-		goto err_destroy_pool;
-	}
-	spin_lock_init(&controller->svc_fifo_lock);
 
 	chans[0].scl = NULL;
 	chans[0].ctrl = controller;
 	chans[0].name = SVC_CLIENT_FPGA;
 	spin_lock_init(&chans[0].lock);
+	ret = kfifo_alloc(&chans[0].svc_fifo, fifo_size, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to allocate FIFO 0\n");
+		return ret;
+	}
+	spin_lock_init(&chans[0].svc_fifo_lock);
 
 	chans[1].scl = NULL;
 	chans[1].ctrl = controller;
 	chans[1].name = SVC_CLIENT_RSU;
 	spin_lock_init(&chans[1].lock);
+	ret = kfifo_alloc(&chans[1].svc_fifo, fifo_size, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to allocate FIFO 1\n");
+		return ret;
+	}
+	spin_lock_init(&chans[1].svc_fifo_lock);
 
 	chans[2].scl = NULL;
 	chans[2].ctrl = controller;
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
+	ret = kfifo_alloc(&chans[2].svc_fifo, fifo_size, GFP_KERNEL);
+	if (ret) {
+		dev_err(dev, "failed to allocate FIFO 2\n");
+		return ret;
+	}
+	spin_lock_init(&chans[2].svc_fifo_lock);
 
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
@@ -1227,7 +1288,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 err_unregister_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
-	kfifo_free(&controller->svc_fifo);
+	stratix10_svc_free_channels(controller);
 err_destroy_pool:
 	gen_pool_destroy(genpool);
 	return ret;
@@ -1241,11 +1302,7 @@ static int stratix10_svc_drv_remove(struct platform_device *pdev)
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 
-	kfifo_free(&ctrl->svc_fifo);
-	if (ctrl->task) {
-		kthread_stop(ctrl->task);
-		ctrl->task = NULL;
-	}
+	stratix10_svc_free_channels(ctrl);
 	if (ctrl->genpool)
 		gen_pool_destroy(ctrl->genpool);
 	list_del(&ctrl->node);
-- 
2.25.1

