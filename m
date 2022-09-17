Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4C85BB6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIQHYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:09 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723CE41D14
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220917072401epoutp03ede988bfb6a221ea701b07d0613c5324~VlPqCZeZY1103511035epoutp03c
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220917072401epoutp03ede988bfb6a221ea701b07d0613c5324~VlPqCZeZY1103511035epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399441;
        bh=ld0pLQgQWwivgiMuA7b/lAdhy1p1R8eW5UBQBUnhI9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5qghSUjxgqvnAvrQF/7iQHokrJIycrCVArFCFG5+NUPLKgjn+HD8LTyFLEz9Ulqn
         ml47Eo1Iwwg7C11OdchQBX+ggSWm2f+W+Nxysz+JN2cXcBlPL+Q8T2++7oyvYJAmA+
         9jDIXMA/93Q12v9OM5HRvJgN6IQ9uVE6HUgIUarI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220917072400epcas1p3eccbd6d3d5ba874dd10602a06f4d5666~VlPpfEd7w0623006230epcas1p3Q;
        Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MV2Vk6q6fz4x9Pq; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.ED.07691.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p2ae33a31333089ea7b10844e42e14323b~VlPnefG1-1789517895epcas1p2s;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp14dbd1a9aaa9dad63885c465cf2aed7b2~VlPndm3VD0556805568epsmtrp1d;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a38-0cdff70000021e0b-7c-6325760ebd18
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.45.14392.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip2556e4aee8624dce1117620409974d5bc~VlPnLHRFw2357323573epsmtip2f;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 09/13] trinity: Add request and pm feature
Date:   Sat, 17 Sep 2022 16:23:52 +0900
Message-Id: <20220917072356.2255620-10-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTV5evTDXZYMkjU4u/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xo1ZLxkLrq9lrLi4cCV7A+OvXsYuRk4OCQETiXXfnrB3MXJx
        CAnsYJR4vOI4C4TziVHixcWbUJlvjBKzvs9hhWl58OE9G4gtJLCXUeLKHBOIos+MEoufLGQG
        SbAJqErMnLGGHcQWESiXaN54AsxmFsiReHKnCaxGWMBWYtnyf2CDWIDqd198CHYTr4CNRPf2
        BhYQmxPIvrmpiQUiLihxcuYTFog58hLNW2czgyyWEPjJLvFr+homiOtcJNoetUDZwhKvjm9h
        h7ClJF72t0HZ2RJTOhaxQNgFEueebwUaxAFkG0tcXJECYjILaEqs36UPUaEosfP3XEaItXwS
        7772sEJU80p0tAlBlChJLPlzGGq4hMTUGd+gDvCQOLf/OiMkqPoZJRo3V09glJ+F5JlZSJ6Z
        hbB4ASPzKkax1ILi3PTUYsMCE3isJufnbmIEp0wtix2Mc99+0DvEyMTBeIhRgoNZSYRX1VMl
        WYg3JbGyKrUoP76oNCe1+BCjKTB4JzJLiSbnA5N2Xkm8oYmlgYmZkbGJhaGZoZI4r542Y7KQ
        QHpiSWp2ampBahFMHxMHp1QDU5VyRPSK34ukfq0IZ3/as/6L5boVuycrCSqYsNbffSIt0bvB
        tffv/py9ui9/fuGxeJZ7XaZLf2moBd+NJvPf21xeTZ3ywPfSBLasrBn+v07F7LnQ4N3kZxUg
        s+dYR5eJlpjLti2Tn1l+jir8IzJNLW0v13vt7ZwFabzvJjeJq8RtnWP2TV0wKrZQZr6j9iJt
        piPMxu137AUKnu67FJVi8Xnmw+4/J8uKfhx8dU+rqv6e/ccLYctkatm29z5kPWe4jv3Tsedc
        Mlk7pZRs1iUrtd+tjOu4tfqPW4Ga6W6dlquqJvzRe4+53hVeZ8GqzPR/ycQ4xpB/rPcLDx9S
        vNXQN2fv6tUBQp7HHovwWqVuUWIpzkg01GIuKk4EAB7HAfkiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqyQfMxDou/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvjxqyXjAXX1zJWXFy4kr2B8VcvYxcj
        J4eEgInEgw/v2boYuTiEBHYzStx694gVIiEhsenecuYuRg4gW1ji8OFiiJqPjBIXzs0Ca2YT
        UJWYOWMNO4gtIlArcfDofGYQm1mgQGL205ksILawgK3EsuX/2EBsFqD63RcfgvXyCthIdG9v
        AKvhBLJvbmoCs4UErCVmT5/LBFEjKHFy5hMWiJnyEs1bZzNPYOSfhSQ1C0lqASPTKkbJ1ILi
        3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4PDW0tzBuH3VB71DjEwcjIcYJTiYlUR4VT1VkoV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgOtywelft8inK
        TqG7gzZfs6+XFD4mn/K/935gR9qRcNfzqvd3si24c6uzKqRgY1LyWY7VFyzS5Fb/9tV0XKbq
        d3/Pk997hd3fB/WzsZbsWZDes359oNljl4tRSzd1vnGxrDnw7fCrE31fJx5YtDV7gfZ59ycq
        bJ9qTa4aTvvdEpvqtuSMPYPFW6e5UeJ/7qQ/Tco/dOvX9lmdftsCxK7Yzc58bO08YVmZ8Vkp
        +Ts3Q3/HfQ54+9vxTPiD0kVmHdePf6kXuOAgtWrP9J87GS5pr1n+pXnbWSmJ2b0tfivtWiQD
        5XJivYW2sf77EJYkPv1CqviL93x2QQZ5z6+GzrWP9D79eUlkyIPPb6wLxK6KmCixFGckGmox
        FxUnAgAiiCaO3gIAAA==
X-CMS-MailID: 20220917072358epcas1p2ae33a31333089ea7b10844e42e14323b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p2ae33a31333089ea7b10844e42e14323b
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p2ae33a31333089ea7b10844e42e14323b@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements request and PM features.

trinity requests are created by ioctl, and it's invoked by the
scheduler. Each request is prepared to run on the NPU including
segment allocation and command setup. Requests are managed by
the command structure, which keeps inforamtion of the request to
manage its lifecycle.

Power management operations are also provided, it works
suspend mode with pm_runtime_allow and pm_runtime_forbid.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity.c             |  62 +++
 drivers/misc/trinity/trinity_vision2_drv.c | 605 +++++++++++++++++++++
 2 files changed, 667 insertions(+)

diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 0fb5ccf9f035..0463140c0ae6 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -664,6 +664,23 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
  */
 int trinity_release(struct inode *inode, struct file *file)
 {
+	struct trinity_driver *drv;
+
+	drv = file->private_data;
+
+	trinity_stat_app_set_status(drv, TRINITY_APP_STATUS_TERMINATED);
+	/* block newly incoming requests */
+	trinity_sched_suspend(drv);
+
+	/* wait already submitted requests */
+	if (drv->desc->drain_reqs)
+		drv->desc->drain_reqs(drv);
+
+	/* deregister models owned by this device handle */
+	trinity_deregister_models_owned(drv);
+
+	trinity_sched_resume(drv);
+
 	return 0;
 }
 
@@ -735,6 +752,27 @@ int trinity_open(struct inode *inode, struct file *f)
 	return 0;
 }
 
+static void trinity_common_init(struct device *dev)
+{
+	trinity_model_htable_init(dev);
+
+	if (trinity_debug_init() < 0)
+		dev_warn(dev, "Unable to initialize debugfs\n");
+
+	if (trinity_sched_init(dev) < 0)
+		dev_warn(dev, "Unable to initialize scheduler\n");
+
+	if (trinity_dma_init(dev) < 0)
+		dev_warn(dev, "Failed to init DMA memory\n");
+}
+
+static void trinity_common_exit(struct device *dev)
+{
+	trinity_dma_exit(dev);
+	trinity_debug_exit();
+	trinity_sched_exit(dev);
+}
+
 /**
  * trinity_create_node() - Create trinity node
  *
@@ -868,9 +906,27 @@ int trinity_probe(struct platform_device *pdev, const struct trinity_desc *desc)
 	mutex_init(&drv->lock);
 	INIT_WORK(&drv->work_stop, desc->stop_reqs);
 
+	trinity_common_init(dev);
+
+	err = trinity_sysfs_init(drv);
+	if (err < 0) {
+		dev_err(dev, "failed to initialize sysfs for a trinity device");
+		goto err_cleanup_common;
+	}
+
+	err = trinity_debug_add(drv);
+	if (err < 0) {
+		dev_err(dev,
+			"failed to add a debugging feature to the trinity device");
+		trinity_sysfs_cleanup(drv);
+		goto err_cleanup_common;
+	}
+	trinity_stat_init(drv);
+
 	return 0;
 
 err_cleanup_common:
+	trinity_common_exit(dev);
 	devm_free_irq(dev, drv->irq, &drv->mdev);
 
 err_cleanup:
@@ -895,6 +951,12 @@ int trinity_remove(struct platform_device *pdev,
 	struct trinity_driver *drv = platform_get_drvdata(pdev);
 	struct device *dev = drv_to_dev_ptr(drv);
 
+	trinity_stat_fini(drv);
+	trinity_debug_remove(drv);
+	trinity_sysfs_cleanup(drv);
+
+	trinity_common_exit(dev);
+
 	ida_free(&dev_nrs, drv->dev_id);
 	devm_free_irq(dev, drv->irq, &drv->mdev);
 	devm_kfree(dev, drv);
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 70b8b6fd5843..3dd89920cdf5 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/hashtable.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/utsname.h>
 
 #include "trinity_common.h"
@@ -151,6 +152,9 @@ static void triv2_idu_setup(struct trinity_driver *drv);
 static void triv2_idu_unset(struct trinity_driver *drv);
 static int32_t triv2_idu_set(struct trinity_driver *drv,
 			struct trinity_ioctl_idu *config);
+static void triv2_handle_cmd_done(struct trinity_driver *drv,
+				  struct triv2_cmd *cmd, bool timeout);
+static void triv2_setup_buffers(struct trinity_driver *drv);
 
 /**
  * triv2_get_state() - Get state (TRINITY_STATE_READY/TRINITY_STATE_PAUSE) of the device.
@@ -212,6 +216,31 @@ static void triv2_set_state(const struct trinity_driver *drv,
 	}
 }
 
+/**
+ * triv2_sync_segt_entries() - synchronize the segment table entries
+ */
+static int triv2_sync_segt_entries(const struct trinity_driver *drv,
+				   struct triv2_req *req)
+{
+#ifdef ARM
+	struct trinity_input *input = &(req->req.input);
+	int i;
+
+	/* flush all caches for heavy models */
+	if (req->total_segment_size > TRIV2_CACHE_FLUSH_THRESHOLD ||
+		/* cannot handle external segments for kernel requests */
+		req->kernel != NULL) {
+		flush_cache_all();
+		return 0;
+	}
+
+	for (i = 0; i < input->config.num_segments; ++i)
+		__cpuc_flush_dcache_area(req->seg_import[i].addr,
+					 req->seg_import[i].buf->size);
+#endif
+	return 0;
+}
+
 static void triv2_wakeup_cp(const struct trinity_driver *drv)
 {
 	void *addr =
@@ -220,36 +249,552 @@ static void triv2_wakeup_cp(const struct trinity_driver *drv)
 	trinity_set_bit(BIT_SET_SEND_EVT1, addr);
 }
 
+static void triv2_cancel_reqs(struct trinity_driver *drv)
+{
+	struct triv2_cmd_info *info;
+	struct triv2_cmd *cmd;
+	unsigned long flags;
+	int slot;
+
+	info = TRIV2_DRV_GET_CMD_INFO(drv);
+	spin_lock_irqsave(&info->lock, flags);
+
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	while (slot < TRIV2_MAX_CMDSLOTS) {
+		cmd = TRIV2_GET_CMD_FROM_SLOT(info, slot);
+		triv2_handle_cmd_done(drv, cmd, true);
+		slot = find_next_bit(info->bitmap, TRIV2_MAX_CMDSLOTS,
+				     slot + 1);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
+static void triv2_drain_reqs(struct trinity_driver *drv)
+{
+	struct triv2_cmd_info *info;
+	unsigned long flags;
+	int cur_retries, max_retries = 1000; /* 1-sec */
+	int slot;
+
+	cur_retries = 0;
+	info = TRIV2_DRV_GET_CMD_INFO(drv);
+retry:
+	spin_lock_irqsave(&info->lock, flags);
+
+	/* wait until all bits are unset */
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	if (slot < TRIV2_MAX_CMDSLOTS) {
+		spin_unlock_irqrestore(&info->lock, flags);
+
+		usleep_range(900, 1100);
+		if (cur_retries++ < max_retries)
+			goto retry;
+
+		spin_lock_irqsave(&info->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
 static void triv2_reset(struct trinity_driver *drv)
 {
+	struct device *dev = drv_to_dev_ptr(drv);
 	struct triv2_pdata *pdata = drv->pdata;
 
 	mutex_lock(&pdata->drv->lock);
 
+	/* block runtime pm suspend */
+	pm_runtime_forbid(dev);
+
+	/* block new incoming requests first */
+	trinity_sched_suspend(drv);
+
 	triv2_cancel_reqs(pdata->drv);
 	msleep(100);
 
 	triv2_setup_buffers(drv);
 	triv2_idu_unset(drv);
 
+	/* resume scheduler */
+	trinity_sched_resume(drv);
+
+	pm_runtime_allow(dev);
+
 	mutex_unlock(&pdata->drv->lock);
 }
 
+/**
+ * triv2_run_trigger() - trigger memory-mapped register for inference running
+ */
+static void triv2_run_trigger(const struct trinity_driver *drv, int slot)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_req *t_req = cmd_info->reqs[slot];
+
+	if (!t_req) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to find the corresponding req");
+		return;
+	}
+
+	if (triv2_sync_segt_entries(drv, t_req) < 0)
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to sync the segment table");
+
+	/* sync the current bitmap */
+	iowrite32(*cmd_info->bitmap,
+		trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+				OFFSET_NPU_CMD_REQ));
+
+	t_req->req.stat->scheduled = ktime_get();
+	t_req->req.stat->completed = 0;
+	t_req->req.scheduled = true;
+	t_req->req.timeout = false;
+
+	/* trigger the event (we do not assume that IDU always accepts this event) */
+	triv2_wakeup_cp(drv);
+}
+
+static void triv2_clear_cmd(struct trinity_driver *drv, struct triv2_req *req,
+			    struct triv2_cmd *cmd)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+
+	cmd_info->reqs[req->cmd_slot] = NULL;
+	clear_bit(req->cmd_slot, cmd_info->bitmap);
+	req->cmd_slot = -1;
+
+	memset(cmd, '\x00', sizeof(struct triv2_cmd));
+}
+
+static void triv2_handle_cmd_done(struct trinity_driver *drv,
+				  struct triv2_cmd *cmd, bool timeout)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_req *t_req;
+	struct trinity_req *req;
+	uint32_t slot = cmd->slot;
+	int64_t time_diff;
+
+	t_req = cmd_info->reqs[slot];
+	if (!t_req) {
+		dev_err(dev, "Failed to find the req\n");
+		return;
+	}
+
+	req = &(t_req->req);
+	req->stat->completed = ktime_get();
+	req->stat->status = TRINITY_REQ_STATUS_FINISHED;
+
+	time_diff = TIME_DIFF_US(req->stat->completed, req->stat->scheduled);
+	if (time_diff < 0) {
+		dev_warn(dev, "Detected invalid inference time of request\n");
+	} else {
+		req->stat->prev_time = (uint32_t)time_diff;
+		req->stat->prev_cycles = cmd->total_cycles;
+		req->stat->num_runs++;
+		req->stat->total_time += req->stat->prev_time;
+	}
+
+	t_req->total_cycles = cmd->total_cycles;
+	t_req->profile_offset = cmd->profile_offset;
+
+	triv2_clear_cmd(drv, t_req, cmd);
+
+	/* notify to the scheduler */
+	trinity_sched_notify(req, timeout);
+
+	/* notify to the caller */
+	if (!req->is_kernel)
+		complete_all(&req->complete);
+}
+
+static void triv2_handle_timeout(struct trinity_driver *drv,
+				 struct trinity_req *req)
+{
+	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	struct triv2_cmd *cmd;
+	struct triv2_req *t;
+	unsigned long flags;
+
+	t = TRIV2_GET_REQ(req);
+
+	spin_lock_irqsave(&cmd_info->lock, flags);
+	if (t->cmd_slot >= 0) {
+		/* Timeout! check whether it's not handled in irq handler */
+		cmd = TRIV2_GET_CMD_FROM_SLOT(cmd_info, t->cmd_slot);
+		triv2_handle_cmd_done(drv, cmd, true);
+	}
+	spin_unlock_irqrestore(&cmd_info->lock, flags);
+}
+
+/**
+ * triv2_stop_reqs() - stop the submitted reqs to the driver
+ *
+ * In case of already-executed req, each device needs to determine the policy
+ * depending its capability to terminate the running one.
+ */
+static void triv2_stop_reqs(struct work_struct *work)
+{
+	struct trinity_driver *drv;
+
+	drv = container_of(work, struct trinity_driver, work_stop);
+	if (drv == NULL)
+		return;
+
+	triv2_cancel_reqs(drv);
+}
+
+static void triv2_handle_irq_cmds(struct trinity_driver *drv)
+{
+	struct triv2_cmd_info *info;
+	struct triv2_cmd *cmd;
+	unsigned long flags;
+	int slot;
+
+	info = TRIV2_DRV_GET_CMD_INFO(drv);
+	spin_lock_irqsave(&info->lock, flags);
+
+	/** Search the bitmap to find the completed CMDs */
+	slot = find_first_bit(info->bitmap, TRIV2_MAX_CMDSLOTS);
+	while (slot < TRIV2_MAX_CMDSLOTS) {
+		cmd = TRIV2_GET_CMD_FROM_SLOT(info, slot);
+		if (cmd->status == STATUS_CMD_DONE)
+			triv2_handle_cmd_done(drv, cmd, false);
+		slot = find_next_bit(info->bitmap, TRIV2_MAX_CMDSLOTS,
+				     slot + 1);
+	}
+
+	spin_unlock_irqrestore(&info->lock, flags);
+}
+
+/**
+ * triv2_handle_irq() - An IRQ handler to be called when a registered IRQ (IRQ_OUT) occurs.
+ */
+static irqreturn_t triv2_handle_irq(int irq_no, void *dev_id)
+{
+	struct miscdevice *_mdev;
+	struct trinity_driver *drv;
+	void __iomem *addr;
+	uint32_t interrupt;
+	uint32_t reg;
+
+	_mdev = (struct miscdevice *)dev_id;
+	drv = container_of(_mdev, struct trinity_driver, mdev);
+
+	/**
+	 * Verify that the IRQ is actually from the NPU
+	 * This is required as IRQ_SHARED is used when setting up IRQ
+	 */
+	addr = trinity_get_iomem_addr(drv->mmreg_vaddr[2],
+				      OFFSET_CBOX_EXT_IRQ_STA);
+	reg = ioread32(addr);
+
+	interrupt = reg & MASK_CP_SWI_STA;
+	if (interrupt == 0)
+		return IRQ_NONE;
+
+	/** Clear the interrupt first */
+	addr = trinity_get_iomem_addr(drv->mmreg_vaddr[2],
+				      OFFSET_CBOX_CP_SWI_CLR);
+	iowrite32(1, addr);
+
+	triv2_handle_irq_cmds(drv);
+	return IRQ_HANDLED;
+}
+
+/**
+ * triv2_prepare_req() - evaluate the physical address of entries in the segment table
+ */
+static int32_t triv2_prepare_req(struct trinity_driver *drv,
+				 struct trinity_req *req)
+{
+	struct triv2_req *t = TRIV2_GET_REQ(req);
+	struct trinity_input *input = &(req->input);
+	struct trinity_hwmem_import *segt_import = &(input->import_info);
+	int32_t *segtable_dbuffd_base;
+	uint32_t *segtable_extra_base;
+	int ret, i;
+
+	if (input->config.num_segments == 0)
+		return -EINVAL;
+
+	if (input->config.num_segments > TRIV2_MAX_SEGMENTS)
+		return -ERANGE;
+
+	t->seg_import = kcalloc(input->config.num_segments,
+				sizeof(struct trinity_hwmem_import),
+				GFP_KERNEL);
+	if (!t->seg_import)
+		return -ENOMEM;
+
+	/* dmabuf fd to be resolved */
+	segtable_dbuffd_base = segt_import->addr;
+	/* extra value (e.g., offset or size) */
+	segtable_extra_base = segt_import->addr + HALF_PAGE_SIZE;
+
+#ifdef ARM
+	/* sync segment table */
+	__cpuc_flush_dcache_area(input->import_info.addr,
+				 input->import_info.buf->size);
+#endif
+
+	for (i = 0; i < input->config.num_segments; ++i) {
+		struct trinity_hwmem_import *import;
+		int32_t fd = segtable_dbuffd_base[i];
+		dma_addr_t daddr;
+
+		if (fd < 0) {
+			uint32_t idx = (uint32_t)((fd + 1) * -1);
+			struct triv2_kernel_req *kreq;
+
+			/* it's for kernel input/output */
+			if (!req->is_kernel) {
+				req->is_kernel = true;
+				kreq = kzalloc(sizeof(*kreq), GFP_KERNEL);
+				if (!kreq) {
+					ret = -ENOMEM;
+					goto err;
+				}
+				t->kernel = kreq;
+			}
+
+			kreq = t->kernel;
+			if (idx < TRIV2_MAX_TENSORS) {
+				kreq->in_seg_idx[idx] = i;
+				kreq->in_seg_size[idx] = segtable_extra_base[i];
+				t->total_segment_size += kreq->in_seg_size[idx];
+			} else if (idx < TRIV2_MAX_TENSORS * 2) {
+				idx -= TRIV2_MAX_TENSORS;
+				kreq->out_seg_idx[idx] = i;
+				kreq->out_seg_size[idx] =
+					segtable_extra_base[i];
+				t->total_segment_size +=
+					kreq->out_seg_size[idx];
+			} else {
+				dev_err(drv_to_dev_ptr(drv),
+					"Invalid external segment (idx: %u)",
+					idx);
+				ret = -EINVAL;
+				goto err;
+			}
+			continue;
+		}
+
+		import = &(t->seg_import[i]);
+		ret = trinity_hwmem_import_dmabuf_begin(drv_to_dev_ptr(drv), fd,
+							import);
+		if (ret) {
+			dev_err(drv_to_dev_ptr(drv),
+				"%d-th segment with fd (%d) seems invalid: %d",
+				i, fd, ret);
+			goto err;
+		}
+
+		t->total_segment_size += import->buf->size;
+
+		/** @todo Use a local ptr variable */
+		daddr = import->dma_addr;
+		daddr += segtable_extra_base[i];
+
+		iowrite32(TRIV2_IDU_ADDR(daddr),
+			  segt_import->addr + i * sizeof(u32));
+	}
+
+	/* set the dma address of DSPM (reserved index: TRIV2_MAX_SEGMENTS - 1) */
+	if (drv->dspm > 0) {
+		struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+
+		iowrite32(TRIV2_IDU_ADDR(pdata->idu_dsp.dspm),
+			  segt_import->addr +
+				  (TRIV2_MAX_SEGMENTS - 1) * sizeof(u32));
+	}
+
+	return 0;
+
+err:
+	kfree(t->seg_import);
+	t->seg_import = NULL;
+	return ret;
+}
+
+/**
+ * triv2_prepare_cmd() - Prepare command info. for the target req before invoking
+ */
+static int32_t triv2_prepare_cmd(struct trinity_driver *drv,
+				 struct trinity_req *req)
+{
+	struct triv2_cmd_info *cmd_info;
+	struct triv2_cmd cmd = { 0 };
+	struct triv2_req *t;
+
+	const struct trinity_model *model = req->model;
+	const struct trinity_input *input = &req->input;
+
+	int32_t slot;
+	struct iommu_domain *domain;
+	phys_addr_t paddr;
+	unsigned long flags;
+
+	/** Note that the program base is not behind iommu */
+	domain = iommu_get_domain_for_dev(drv_to_dev_ptr(drv));
+
+	paddr = trinity_get_paddr(domain, model->import_info.dma_addr);
+	cmd.prog_addr = TRIV2_IDU_ADDR(paddr);
+	cmd.prog_addr += model->config.program_offset_addr;
+	cmd.prog_size = model->config.program_size;
+
+	paddr = trinity_get_paddr(domain, input->import_info.dma_addr);
+	cmd.segt_addr = TRIV2_IDU_ADDR(paddr);
+	cmd.num_visa = model->config.num_visa_insts;
+
+	cmd.priority = input->config.priority;
+	cmd.input_mode = input->config.input_mode;
+	cmd.output_mode = input->config.output_mode;
+
+	/** Find a empty cmd slot in bitmap (need a spin lock) */
+	cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	t = TRIV2_GET_REQ(req);
+
+	spin_lock_irqsave(&cmd_info->lock, flags);
+
+	slot = find_first_zero_bit(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
+	if (slot < TRIV2_MAX_CMDSLOTS) {
+		set_bit(slot, cmd_info->bitmap);
+		cmd_info->reqs[slot] = t;
+		t->cmd_slot = slot;
+	}
+
+	spin_unlock_irqrestore(&cmd_info->lock, flags);
+
+	/** Will be retried (rely on platform device's scheduling) */
+	if (slot >= TRIV2_MAX_CMDSLOTS)
+		return -EBUSY;
+
+	cmd.slot = slot;
+	cmd.status = STATUS_CMD_READY;
+
+	memcpy(cmd_info->buf.addr + slot * sizeof(struct triv2_cmd), &cmd,
+		    sizeof(struct triv2_cmd));
+
+	return slot;
+}
+
+/**
+ * triv2_invoke_req() - Invoke a req on the device. Note that all configurations
+ * required by running should be done before invocation of this function.
+ */
+static int32_t triv2_invoke_req(struct trinity_driver *drv,
+				struct trinity_req *req, void *sched_data)
+{
+	enum trinity_output_mode mode;
+	int32_t slot;
+
+	mode = req->input.config.output_mode;
+	slot = triv2_prepare_cmd(drv, req);
+	if (slot < 0)
+		return slot;
+
+	if (mode == TRINITY_OUTPUT_HW || mode == TRINITY_OUTPUT_CPU_POLL ||
+	    mode == TRINITY_OUTPUT_CPU_INTR) {
+		triv2_run_trigger(drv, slot);
+	} else {
+		dev_err(drv_to_dev_ptr(drv), "Invalid output mode: %d\n", mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct trinity_req *triv2_alloc_req(struct trinity_driver *drv)
+{
+	struct triv2_req *t_req;
+
+	t_req = kzalloc(sizeof(struct triv2_req), GFP_KERNEL);
+	if (!t_req)
+		return NULL;
+
+	t_req->cmd_slot = -1;
+
+	if (atomic_fetch_inc(&drv->active_reqs) == 0)
+		trinity_wait_ready(drv);
+
+	return &(t_req->req);
+}
+
+static void triv2_dealloc_req(struct trinity_driver *drv,
+			struct trinity_req *req)
+{
+	struct triv2_req *t_req = TRIV2_GET_REQ(req);
+
+	if (atomic_dec_return(&drv->active_reqs) == 0)
+		trinity_set_pause(drv);
+
+	if (t_req->seg_import) {
+		struct trinity_hwmem_import *import;
+		uint32_t i;
+
+		for (i = 0; i < req->input.config.num_segments; i++) {
+			import = &(t_req->seg_import[i]);
+			if (import->addr)
+				trinity_hwmem_import_dmabuf_end(import);
+		}
+		kfree(t_req->seg_import);
+	}
+
+	kfree(t_req->kernel);
+	kfree(t_req);
+}
+
+static long triv2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	struct trinity_driver *drv = f->private_data;
+	struct device *dev = drv_to_dev_ptr(drv);
+	long ret;
+
+	pm_runtime_forbid(dev);
+
+	ret = trinity_ioctl(f, cmd, arg);
+
+	pm_runtime_allow(dev);
+
+	return ret;
+}
+
 static int triv2_open(struct inode *inode, struct file *f)
 {
+	struct miscdevice *miscdev;
+	struct trinity_driver *drv;
+	struct device *dev;
 	int ret;
 
+	miscdev = (struct miscdevice *)f->private_data;
+	drv = container_of(miscdev, struct trinity_driver, mdev);
+	dev = drv_to_dev_ptr(drv);
+
+	pm_runtime_forbid(dev);
+
 	ret = trinity_open(inode, f);
 
+	pm_runtime_allow(dev);
+
 	return ret;
 }
 
 static int triv2_release(struct inode *inode, struct file *f)
 {
+	struct trinity_driver *drv = f->private_data;
+	struct device *dev = drv_to_dev_ptr(drv);
 	int ret;
 
+	pm_runtime_forbid(dev);
+
 	ret = trinity_release(inode, f);
 
+	pm_runtime_allow(dev);
+
 	return ret;
 }
 
@@ -515,6 +1060,7 @@ static int32_t triv2_init_pdata(struct trinity_driver *drv)
 	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
 	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
 
+	mutex_init(&pdata->prof_lock);
 	spin_lock_init(&cmd_info->lock);
 	/* init cmd bitmap */
 	bitmap_zero(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
@@ -657,6 +1203,64 @@ static struct trinity_desc triv2_desc = {
 	.dealloc_req = triv2_dealloc_req,
 	.prepare_req = triv2_prepare_req,
 	.invoke_req = triv2_invoke_req,
+	/* etc. */
+	.handle_timeout = triv2_handle_timeout,
+	.stop_reqs = triv2_stop_reqs,
+	.drain_reqs = triv2_drain_reqs,
+	.handle_irq = triv2_handle_irq,
+};
+
+static int triv2_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int triv2_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int triv2_runtime_suspend(struct device *dev)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	mutex_lock(&drv->lock);
+
+	/* 1) Ensure that the scheduler was suspended */
+	trinity_sched_suspend(drv);
+
+	/* 2) Set pause state if it's in ready state */
+	if (triv2_get_state(drv) == TRINITY_STATE_READY)
+		triv2_set_state(drv, TRINITY_STATE_PAUSE);
+
+	mutex_unlock(&drv->lock);
+
+	return 0;
+}
+
+static int triv2_runtime_resume(struct device *dev)
+{
+	struct trinity_driver *drv = dev_get_drvdata(dev);
+
+	mutex_lock(&drv->lock);
+
+	/* 1) Restore IDU setup */
+	triv2_setup_buffers(drv);
+	triv2_idu_setup(drv);
+
+	/* 2) Resume the req scheduler */
+	trinity_sched_resume(drv);
+
+	mutex_unlock(&drv->lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops triv2_dev_pm_ops = {
+	// clang-format off
+	SET_SYSTEM_SLEEP_PM_OPS(triv2_suspend, triv2_resume)
+	SET_RUNTIME_PM_OPS(triv2_runtime_suspend, triv2_runtime_resume, NULL)
+	// clang-format on
 };
 
 static const struct of_device_id trinity_match[] = {
@@ -734,6 +1338,7 @@ static struct platform_driver trinity_triv2 = {
 			.name = "triv2",
 			.owner = THIS_MODULE,
 			.of_match_table = of_match_ptr(trinity_match),
+			.pm = &triv2_dev_pm_ops,
 		},
 };
 
-- 
2.25.1

