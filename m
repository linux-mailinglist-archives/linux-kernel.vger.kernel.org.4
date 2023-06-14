Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5172202A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjFEHxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjFEHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:52:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BAFE;
        Mon,  5 Jun 2023 00:52:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E4360CA3;
        Mon,  5 Jun 2023 07:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4705C433D2;
        Mon,  5 Jun 2023 07:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951540;
        bh=yBiT4mxHKmSHjOsitTHks5NBiBZF6lEHvoFmYOMaJQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxlJXJzaiHFXGBxJ+3tnOaIwsHOcmBQRRh5EGNcbRya5i1LNu7aFjKL1phYIdl/pa
         MFA9hRlskO1+d06SUQuu5jdDZAtMY7bos07XWlNuf+9w//hqbPri2qmuW6DoB0w16Q
         9xELBcbSfBQXEoEg8STU5ZhFa+RTkypNOW4WtA+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.32
Date:   Mon,  5 Jun 2023 09:52:15 +0200
Message-ID: <2023060513-platinum-scrooge-6daf@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023060510-espionage-handyman-d919@gregkh>
References: <2023060510-espionage-handyman-d919@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 902a6b598c73..a0c3d8809e93 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 31
+SUBLEVEL = 32
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..66da9e2b19ab 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -246,7 +246,7 @@ static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 {
 	struct bio *bio;
 
-	if (rq->cmd_flags & REQ_POLLED) {
+	if (rq->cmd_flags & REQ_POLLED && (nr_vecs <= BIO_INLINE_VECS)) {
 		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
 
 		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9eb968e14d31..a80d7c62bdfe 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -41,16 +41,20 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 
+	/*
+	 * calling test_bit() prior to test_and_set_bit() is intentional,
+	 * it avoids dirtying the cacheline if the queue is already active.
+	 */
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
+		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
+		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
-		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
 	} else {
-		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
+		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
-		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	}
 
 	users = atomic_inc_return(&hctx->tags->active_queues);
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c17bd845f5fc..f8d2bba9173d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -249,9 +249,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static int amd_pstate_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static int amd_pstate_update_freq(struct cpufreq_policy *policy,
+				  unsigned int target_freq, bool fast_switch)
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -270,26 +269,50 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
 				     cpudata->max_freq);
 
-	cpufreq_freq_transition_begin(policy, &freqs);
-	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
-	cpufreq_freq_transition_end(policy, &freqs, false);
+	WARN_ON(fast_switch && !policy->fast_switch_enabled);
+	/*
+	 * If fast_switch is desired, then there aren't any registered
+	 * transition notifiers. See comment for
+	 * cpufreq_enable_fast_switch().
+	 */
+	if (!fast_switch)
+		cpufreq_freq_transition_begin(policy, &freqs);
+
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, fast_switch);
+
+	if (!fast_switch)
+		cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
 }
 
+static int amd_pstate_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	return amd_pstate_update_freq(policy, target_freq, false);
+}
+
+static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
+				  unsigned int target_freq)
+{
+	return amd_pstate_update_freq(policy, target_freq, true);
+}
+
 static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
 	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, lowest_nonlinear_perf;
+		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned int target_freq;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
@@ -306,6 +329,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	target_freq = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = target_freq;
+
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 	cpufreq_cpu_put(policy);
 }
@@ -517,6 +544,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -608,6 +636,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 737f36e7a903..5904a679d351 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -274,7 +274,8 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 	int idx, count, flags = 0, sz, buf_sz;
 	ffa_value_t partition_info;
 
-	if (!buffer || !num_partitions) /* Just get the count for now */
+	if (drv_info->version > FFA_VERSION_1_0 &&
+	    (!buffer || !num_partitions)) /* Just get the count for now */
 		flags = PARTITION_INFO_GET_RETURN_COUNT_ONLY;
 
 	mutex_lock(&drv_info->rx_lock);
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e3af86f06c63..3e8e5f4ffa59 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -882,7 +882,7 @@ config GPIO_F7188X
 	help
 	  This option enables support for GPIOs found on Fintek Super-I/O
 	  chips F71869, F71869A, F71882FG, F71889F and F81866.
-	  As well as Nuvoton Super-I/O chip NCT6116D.
+	  As well as Nuvoton Super-I/O chip NCT6126D.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called f7188x-gpio.
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 9effa7769bef..f54ca5a1775e 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -48,7 +48,7 @@
 /*
  * Nuvoton devices.
  */
-#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
+#define SIO_NCT6126D_ID		0xD283  /* NCT6126D chipset ID */
 
 #define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
 
@@ -62,7 +62,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
-	nct6116d,
+	nct6126d,
 };
 
 static const char * const f7188x_names[] = {
@@ -74,7 +74,7 @@ static const char * const f7188x_names[] = {
 	"f81866",
 	"f81804",
 	"f81865",
-	"nct6116d",
+	"nct6126d",
 };
 
 struct f7188x_sio {
@@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define f7188x_gpio_out_mode(base) ((base) + 3)
 
-#define f7188x_gpio_dir_invert(type)	((type) == nct6116d)
-#define f7188x_gpio_data_single(type)	((type) == nct6116d)
+#define f7188x_gpio_dir_invert(type)	((type) == nct6126d)
+#define f7188x_gpio_data_single(type)	((type) == nct6126d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
@@ -274,7 +274,7 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
 	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
 };
 
-static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
+static struct f7188x_gpio_bank nct6126d_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
 	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
 	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
@@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
 	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
 	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
 	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
+	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -490,9 +490,9 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
 		data->bank = f81865_gpio_bank;
 		break;
-	case nct6116d:
-		data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
-		data->bank = nct6116d_gpio_bank;
+	case nct6126d:
+		data->nr_bank = ARRAY_SIZE(nct6126d_gpio_bank);
+		data->bank = nct6126d_gpio_bank;
 		break;
 	default:
 		return -ENODEV;
@@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81865_ID:
 		sio->type = f81865;
 		break;
-	case SIO_NCT6116D_ID:
+	case SIO_NCT6126D_ID:
 		sio->device = SIO_LD_GPIO_NUVOTON;
-		sio->type = nct6116d;
+		sio->type = nct6126d;
 		break;
 	default:
 		pr_info("Unsupported Fintek device 0x%04x\n", devid);
@@ -569,7 +569,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	}
 
 	/* double check manufacturer where possible */
-	if (sio->type != nct6116d) {
+	if (sio->type != nct6126d) {
 		manid = superio_inw(addr, SIO_FINTEK_MANID);
 		if (manid != SIO_FINTEK_ID) {
 			pr_debug("Not a Fintek device at 0x%08x\n", addr);
@@ -581,7 +581,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	err = 0;
 
 	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)addr);
-	if (sio->type != nct6116d)
+	if (sio->type != nct6126d)
 		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index a78e80f9f65c..e32bd990800d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1083,6 +1083,9 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
 		return false;
 
+	if (adev->asic_type < CHIP_RAVEN)
+		return false;
+
 	/*
 	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is generally
 	 * risky to do any special firmware-related preparations for entering
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 871f481f8432..88a9ece7f464 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2402,8 +2402,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
-	else
+	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
+	if (!adev->in_s0ix && !adev->in_s3)
+		return 0;
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
@@ -2424,6 +2426,9 @@ static int amdgpu_pmops_resume(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	if (!adev->in_s0ix && !adev->in_s3)
+		return 0;
+
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
 		adev->no_hw_access = true;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index e459fb542b83..1f6e006c51c4 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -792,8 +792,11 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
 
-	rxe_cleanup_task(&qp->req.task);
-	rxe_cleanup_task(&qp->comp.task);
+	if (qp->req.task.func)
+		rxe_cleanup_task(&qp->req.task);
+
+	if (qp->comp.task.func)
+		rxe_cleanup_task(&qp->comp.task);
 
 	/* flush out any receive wr's or pending requests */
 	if (qp->req.task.func)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 8fdd3afe5998..afdddfced7e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1225,6 +1225,14 @@ static inline void link_status_user_format(u64 lstat,
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = cgx_get_lmac_type(cgx, lmac_id);
+
+	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
+		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
+			linfo->lmac_type_id, cgx->cgx_id, lmac_id);
+		strncpy(linfo->lmac_type, "Unknown", LMACTYPE_STR_LEN - 1);
+		return;
+	}
+
 	lmac_string = cgx_lmactype_string[linfo->lmac_type_id];
 	strncpy(linfo->lmac_type, lmac_string, LMACTYPE_STR_LEN - 1);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 821c78bab373..a3daca44f74b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -340,6 +340,7 @@ struct mlx5_eswitch {
 	}  params;
 	struct blocking_notifier_head n_head;
 	struct dentry *dbgfs;
+	bool paired[MLX5_MAX_PORTS];
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 5235b5a7b963..433cdd0a2cf3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2827,6 +2827,9 @@ static int mlx5_esw_offloads_devcom_event(int event,
 		    mlx5_eswitch_vport_match_metadata_enabled(peer_esw))
 			break;
 
+		if (esw->paired[mlx5_get_dev_index(peer_esw->dev)])
+			break;
+
 		err = mlx5_esw_offloads_set_ns_peer(esw, peer_esw, true);
 		if (err)
 			goto err_out;
@@ -2838,14 +2841,18 @@ static int mlx5_esw_offloads_devcom_event(int event,
 		if (err)
 			goto err_pair;
 
+		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = true;
+		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = true;
 		mlx5_devcom_set_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS, true);
 		break;
 
 	case ESW_OFFLOADS_DEVCOM_UNPAIR:
-		if (!mlx5_devcom_is_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS))
+		if (!esw->paired[mlx5_get_dev_index(peer_esw->dev)])
 			break;
 
 		mlx5_devcom_set_paired(devcom, MLX5_DEVCOM_ESW_OFFLOADS, false);
+		esw->paired[mlx5_get_dev_index(peer_esw->dev)] = false;
+		peer_esw->paired[mlx5_get_dev_index(esw->dev)] = false;
 		mlx5_esw_offloads_unpair(peer_esw);
 		mlx5_esw_offloads_unpair(esw);
 		mlx5_esw_offloads_set_ns_peer(esw, peer_esw, false);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 09ed6e5fa6c3..ef5e61708df3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -36,39 +36,33 @@ enum mlxsw_thermal_trips {
 	MLXSW_THERMAL_TEMP_TRIP_HOT,
 };
 
-struct mlxsw_cooling_states {
+struct mlxsw_thermal_trip {
+	int	type;
+	int	temp;
+	int	hyst;
 	int	min_state;
 	int	max_state;
 };
 
-static const struct thermal_trip default_thermal_trips[] = {
+static const struct mlxsw_thermal_trip default_thermal_trips[] = {
 	{	/* In range - 0-40% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_NORM,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{
-		/* In range - 40-100% PWM */
-		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{	/* Warning */
-		.type		= THERMAL_TRIP_HOT,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
-	},
-};
-
-static const struct mlxsw_cooling_states default_cooling_states[] = {
-	{
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= 0,
 		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 	},
 	{
+		/* In range - 40-100% PWM */
+		.type		= THERMAL_TRIP_ACTIVE,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
-	{
+	{	/* Warning */
+		.type		= THERMAL_TRIP_HOT,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HOT,
 		.min_state	= MLXSW_THERMAL_MAX_STATE,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
@@ -84,8 +78,7 @@ struct mlxsw_thermal;
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	int module; /* Module or gearbox number */
 	u8 slot_index;
 };
@@ -105,8 +98,7 @@ struct mlxsw_thermal {
 	struct thermal_zone_device *tzdev;
 	int polling_delay;
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
 };
 
@@ -143,9 +135,9 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 static void
 mlxsw_thermal_module_trips_reset(struct mlxsw_thermal_module *tz)
 {
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = 0;
 }
 
 static int
@@ -187,12 +179,12 @@ mlxsw_thermal_module_trips_update(struct device *dev, struct mlxsw_core *core,
 	 * by subtracting double hysteresis value.
 	 */
 	if (crit_temp >= MLXSW_THERMAL_MODULE_TEMP_SHIFT)
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp -
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp -
 					MLXSW_THERMAL_MODULE_TEMP_SHIFT;
 	else
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = emerg_temp;
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = emerg_temp;
 
 	return 0;
 }
@@ -209,11 +201,11 @@ static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &thermal->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0) {
 			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
@@ -267,6 +259,61 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
+static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
+				       int trip,
+				       enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = thermal->trips[trip].type;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int *p_temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = thermal->trips[trip].temp;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	thermal->trips[trip].temp = temp;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int *p_hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	*p_hyst = thermal->trips[trip].hyst;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	thermal->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
@@ -275,6 +322,11 @@ static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
+	.get_trip_type	= mlxsw_thermal_get_trip_type,
+	.get_trip_temp	= mlxsw_thermal_get_trip_temp,
+	.set_trip_temp	= mlxsw_thermal_set_trip_temp,
+	.get_trip_hyst	= mlxsw_thermal_get_trip_hyst,
+	.set_trip_hyst	= mlxsw_thermal_set_trip_hyst,
 };
 
 static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
@@ -289,11 +341,11 @@ static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &tz->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0)
 			goto err_thermal_zone_bind_cooling_device;
@@ -381,10 +433,74 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
+static int
+mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
+				   enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = tz->trips[trip].type;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
+				   int trip, int *p_temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = tz->trips[trip].temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
+				   int trip, int temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	tz->trips[trip].temp = temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
+				   int *p_hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	*p_hyst = tz->trips[trip].hyst;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
+				   int hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	tz->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
@@ -414,6 +530,11 @@ static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_get_max_state(struct thermal_cooling_device *cdev,
@@ -495,8 +616,7 @@ mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
 			 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-							module_tz->trips,
+	module_tz->tzdev = thermal_zone_device_register(tz_name,
 							MLXSW_THERMAL_NUM_TRIPS,
 							MLXSW_THERMAL_TRIP_MASK,
 							module_tz,
@@ -540,8 +660,6 @@ mlxsw_thermal_module_init(struct device *dev, struct mlxsw_core *core,
 	module_tz->parent = thermal;
 	memcpy(module_tz->trips, default_thermal_trips,
 	       sizeof(thermal->trips));
-	memcpy(module_tz->cooling_states, default_cooling_states,
-	       sizeof(thermal->cooling_states));
 	/* Initialize all trip point. */
 	mlxsw_thermal_module_trips_reset(module_tz);
 	/* Read module temperature and thresholds. */
@@ -637,8 +755,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
 			 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-						gearbox_tz->trips,
+	gearbox_tz->tzdev = thermal_zone_device_register(tz_name,
 						MLXSW_THERMAL_NUM_TRIPS,
 						MLXSW_THERMAL_TRIP_MASK,
 						gearbox_tz,
@@ -695,8 +812,6 @@ mlxsw_thermal_gearboxes_init(struct device *dev, struct mlxsw_core *core,
 		gearbox_tz = &area->tz_gearbox_arr[i];
 		memcpy(gearbox_tz->trips, default_thermal_trips,
 		       sizeof(thermal->trips));
-		memcpy(gearbox_tz->cooling_states, default_cooling_states,
-		       sizeof(thermal->cooling_states));
 		gearbox_tz->module = i;
 		gearbox_tz->parent = thermal;
 		gearbox_tz->slot_index = area->slot_index;
@@ -812,7 +927,6 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	thermal->core = core;
 	thermal->bus_info = bus_info;
 	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
-	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
 	thermal->line_cards[0].slot_index = 0;
 
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);
@@ -862,8 +976,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
-						      thermal->trips,
+	thermal->tzdev = thermal_zone_device_register("mlxsw",
 						      MLXSW_THERMAL_NUM_TRIPS,
 						      MLXSW_THERMAL_TRIP_MASK,
 						      thermal,
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index a50235fdf7d9..055e4ca5b3b5 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -179,6 +179,7 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_CNTL		  20
 #define VSC8502_RGMII_RX_DELAY_MASK	  0x0070
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
+#define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index f778e4f8b508..7bd940baec59 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -527,14 +527,27 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
  *  * 2.0 ns (which causes the data to be sampled at exactly half way between
  *    clock transitions at 1000 Mbps) if delays should be enabled
  */
-static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
-				   u16 rgmii_rx_delay_mask,
-				   u16 rgmii_tx_delay_mask)
+static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
+				     u16 rgmii_rx_delay_mask,
+				     u16 rgmii_tx_delay_mask)
 {
 	u16 rgmii_rx_delay_pos = ffs(rgmii_rx_delay_mask) - 1;
 	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
 	u16 reg_val = 0;
-	int rc;
+	u16 mask = 0;
+	int rc = 0;
+
+	/* For traffic to pass, the VSC8502 family needs the RX_CLK disable bit
+	 * to be unset for all PHY modes, so do that as part of the paged
+	 * register modification.
+	 * For some family members (like VSC8530/31/40/41) this bit is reserved
+	 * and read-only, and the RX clock is enabled by default.
+	 */
+	if (rgmii_cntl == VSC8502_RGMII_CNTL)
+		mask |= VSC8502_RGMII_RX_CLK_DISABLE;
+
+	if (phy_interface_is_rgmii(phydev))
+		mask |= rgmii_rx_delay_mask | rgmii_tx_delay_mask;
 
 	mutex_lock(&phydev->lock);
 
@@ -545,10 +558,9 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_tx_delay_pos;
 
-	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
-			      rgmii_cntl,
-			      rgmii_rx_delay_mask | rgmii_tx_delay_mask,
-			      reg_val);
+	if (mask)
+		rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
+				      rgmii_cntl, mask, reg_val);
 
 	mutex_unlock(&phydev->lock);
 
@@ -557,19 +569,11 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 
 static int vsc85xx_default_config(struct phy_device *phydev)
 {
-	int rc;
-
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 
-	if (phy_interface_mode_is_rgmii(phydev->interface)) {
-		rc = vsc85xx_rgmii_set_skews(phydev, VSC8502_RGMII_CNTL,
-					     VSC8502_RGMII_RX_DELAY_MASK,
-					     VSC8502_RGMII_TX_DELAY_MASK);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
+	return vsc85xx_update_rgmii_cntl(phydev, VSC8502_RGMII_CNTL,
+					 VSC8502_RGMII_RX_DELAY_MASK,
+					 VSC8502_RGMII_TX_DELAY_MASK);
 }
 
 static int vsc85xx_get_tunable(struct phy_device *phydev,
@@ -1766,13 +1770,11 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phy_interface_is_rgmii(phydev)) {
-		ret = vsc85xx_rgmii_set_skews(phydev, VSC8572_RGMII_CNTL,
-					      VSC8572_RGMII_RX_DELAY_MASK,
-					      VSC8572_RGMII_TX_DELAY_MASK);
-		if (ret)
-			return ret;
-	}
+	ret = vsc85xx_update_rgmii_cntl(phydev, VSC8572_RGMII_CNTL,
+					VSC8572_RGMII_RX_DELAY_MASK,
+					VSC8572_RGMII_TX_DELAY_MASK);
+	if (ret)
+		return ret;
 
 	ret = genphy_soft_reset(phydev);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index df0833890e55..8a613e150a02 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -767,7 +767,7 @@ struct iwl_wowlan_status_v12 {
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
 
 /**
- * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * struct iwl_wowlan_info_notif_v1 - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
@@ -785,7 +785,7 @@ struct iwl_wowlan_status_v12 {
  * @station_id: station id
  * @reserved2: reserved
  */
-struct iwl_wowlan_info_notif {
+struct iwl_wowlan_info_notif_v1 {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -803,6 +803,39 @@ struct iwl_wowlan_info_notif {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_wowlan_info_notif - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @reserved1: reserved
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @reserved2: reserved
+ */
+struct iwl_wowlan_info_notif {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 reserved1;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
  * @wake_packet_length: wakeup packet length
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index bbdda3e1ff3f..c876e81437fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2011,6 +2011,12 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 {
 	u32 i;
 
+	if (!data) {
+		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
+		status = NULL;
+		return;
+	}
+
 	if (len < sizeof(*data)) {
 		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
 		status = NULL;
@@ -2698,10 +2704,15 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_d3_data *d3_data = data;
 	u32 len;
 	int ret;
+	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
+						      PROT_OFFLOAD_GROUP,
+						      WOWLAN_INFO_NOTIFICATION,
+						      IWL_FW_CMD_VER_UNKNOWN);
+
 
 	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
-		struct iwl_wowlan_info_notif *notif = (void *)pkt->data;
+		struct iwl_wowlan_info_notif *notif;
 
 		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
 			/* We might get two notifications due to dual bss */
@@ -2710,10 +2721,32 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 			break;
 		}
 
+		if (wowlan_info_ver < 2) {
+			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
+
+			notif = kmemdup(notif_v1,
+					offsetofend(struct iwl_wowlan_info_notif,
+						    received_beacons),
+					GFP_ATOMIC);
+
+			if (!notif)
+				return false;
+
+			notif->tid_tear_down = notif_v1->tid_tear_down;
+			notif->station_id = notif_v1->station_id;
+
+		} else {
+			notif = (void *)pkt->data;
+		}
+
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
 						len);
+
+		if (wowlan_info_ver < 2)
+			kfree(notif);
+
 		if (d3_data->status &&
 		    d3_data->status->wakeup_reasons & IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT)
 			/* We are supposed to get also wake packet notif */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 67653b3e1a35..3109114cec6f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1484,18 +1484,19 @@ static void rtw8852c_5m_mask(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
-	u8 pri_ch = chan->primary_channel;
+	u8 pri_ch = chan->pri_ch_idx;
 	bool mask_5m_low;
 	bool mask_5m_en;
 
 	switch (chan->band_width) {
 	case RTW89_CHANNEL_WIDTH_40:
 		mask_5m_en = true;
-		mask_5m_low = pri_ch == 2;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		mask_5m_en = ((pri_ch == 3) || (pri_ch == 4));
-		mask_5m_low = pri_ch == 4;
+		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
+			     pri_ch == RTW89_SC_20_LOWEST;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
 		break;
 	default:
 		mask_5m_en = false;
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 0acc0b622129..dc9803e1a4b9 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -245,24 +245,29 @@ static const struct pci_device_id pmf_pci_ids[] = {
 	{ }
 };
 
-int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+static void amd_pmf_set_dram_addr(struct amd_pmf_dev *dev)
 {
 	u64 phys_addr;
 	u32 hi, low;
 
-	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
+	phys_addr = virt_to_phys(dev->buf);
+	hi = phys_addr >> 32;
+	low = phys_addr & GENMASK(31, 0);
+
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
+	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+}
 
+int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
+{
 	/* Get Metrics Table Address */
 	dev->buf = kzalloc(sizeof(dev->m_table), GFP_KERNEL);
 	if (!dev->buf)
 		return -ENOMEM;
 
-	phys_addr = virt_to_phys(dev->buf);
-	hi = phys_addr >> 32;
-	low = phys_addr & GENMASK(31, 0);
+	INIT_DELAYED_WORK(&dev->work_buffer, amd_pmf_get_metrics);
 
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_HIGH, 0, hi, NULL);
-	amd_pmf_send_cmd(dev, SET_DRAM_ADDR_LOW, 0, low, NULL);
+	amd_pmf_set_dram_addr(dev);
 
 	/*
 	 * Start collecting the metrics data after a small delay
@@ -273,6 +278,18 @@ int amd_pmf_init_metrics_table(struct amd_pmf_dev *dev)
 	return 0;
 }
 
+static int amd_pmf_resume_handler(struct device *dev)
+{
+	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
+
+	if (pdev->buf)
+		amd_pmf_set_dram_addr(pdev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_pmf_pm, NULL, amd_pmf_resume_handler);
+
 static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 {
 	int ret;
@@ -414,6 +431,7 @@ static struct platform_driver amd_pmf_driver = {
 		.name = "amd-pmf",
 		.acpi_match_table = amd_pmf_acpi_ids,
 		.dev_groups = amd_pmf_driver_groups,
+		.pm = pm_sleep_ptr(&amd_pmf_pm),
 	},
 	.probe = amd_pmf_probe,
 	.remove = amd_pmf_remove,
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7fa68dc4e938..009ba186652a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -936,6 +936,11 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 		if (ret)
 			goto pin_unwind;
 
+		if (!pfn_valid(phys_pfn)) {
+			ret = -EINVAL;
+			goto pin_unwind;
+		}
+
 		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn);
 		if (ret) {
 			if (put_pfn(phys_pfn, dma->prot) && do_accounting)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 20ca1613f2e3..cc5ed2cf25f6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1567,6 +1567,16 @@ static inline void skb_copy_hash(struct sk_buff *to, const struct sk_buff *from)
 	to->l4_hash = from->l4_hash;
 };
 
+static inline int skb_cmp_decrypted(const struct sk_buff *skb1,
+				    const struct sk_buff *skb2)
+{
+#ifdef CONFIG_TLS_DEVICE
+	return skb2->decrypted - skb1->decrypted;
+#else
+	return 0;
+#endif
+}
+
 static inline void skb_copy_decrypted(struct sk_buff *to,
 				      const struct sk_buff *from)
 {
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 84f787416a54..054d7911bfc9 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -71,7 +71,6 @@ struct sk_psock_link {
 };
 
 struct sk_psock_work_state {
-	struct sk_buff			*skb;
 	u32				len;
 	u32				off;
 };
@@ -105,7 +104,7 @@ struct sk_psock {
 	struct proto			*sk_proto;
 	struct mutex			work_mutex;
 	struct sk_psock_work_state	work_state;
-	struct work_struct		work;
+	struct delayed_work		work;
 	struct rcu_work			rwork;
 };
 
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index bf5654ce711e..51857117ac09 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -249,6 +249,10 @@ struct inet_sock {
 	__be32			mc_addr;
 	struct ip_mc_socklist __rcu	*mc_list;
 	struct inet_cork_full	cork;
+	struct {
+		__u16 lo;
+		__u16 hi;
+	}			local_port_range;
 };
 
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
diff --git a/include/net/ip.h b/include/net/ip.h
index 144bdfbb25af..acec504c469a 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -76,6 +76,7 @@ struct ipcm_cookie {
 	__be32			addr;
 	int			oif;
 	struct ip_options_rcu	*opt;
+	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
 	char			priority;
@@ -96,6 +97,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
+	ipcm->protocol = inet->inet_num;
 }
 
 #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
@@ -340,7 +342,8 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
 	} \
 }
 
-void inet_get_local_port_range(struct net *net, int *low, int *high);
+void inet_get_local_port_range(const struct net *net, int *low, int *high);
+void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
 
 #ifdef CONFIG_SYSCTL
 static inline bool inet_is_local_reserved_port(struct net *net, unsigned short port)
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 813c93499f20..ad0bafc877d4 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -383,22 +383,4 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
-static inline void page_pool_ring_lock(struct page_pool *pool)
-	__acquires(&pool->ring.producer_lock)
-{
-	if (in_serving_softirq())
-		spin_lock(&pool->ring.producer_lock);
-	else
-		spin_lock_bh(&pool->ring.producer_lock);
-}
-
-static inline void page_pool_ring_unlock(struct page_pool *pool)
-	__releases(&pool->ring.producer_lock)
-{
-	if (in_serving_softirq())
-		spin_unlock(&pool->ring.producer_lock);
-	else
-		spin_unlock_bh(&pool->ring.producer_lock);
-}
-
 #endif /* _NET_PAGE_POOL_H */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b70b241ce71..0744717f5caa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1467,6 +1467,8 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 }
 
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
+void __tcp_cleanup_rbuf(struct sock *sk, int copied);
+
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
@@ -2291,6 +2293,14 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
 #endif /* CONFIG_BPF_SYSCALL */
 
+#ifdef CONFIG_INET
+void tcp_eat_skb(struct sock *sk, struct sk_buff *skb);
+#else
+static inline void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
+{
+}
+#endif
+
 int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 			  struct sk_msg *msg, u32 bytes, int flags);
 #endif /* CONFIG_NET_SOCK_MSG */
diff --git a/include/net/tls.h b/include/net/tls.h
index 154949c7b0c8..c36bf4c50027 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -124,6 +124,7 @@ struct tls_strparser {
 	u32 mark : 8;
 	u32 stopped : 1;
 	u32 copy_mode : 1;
+	u32 mixed_decrypted : 1;
 	u32 msg_ready : 1;
 
 	struct strp_msg stm;
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 07a4cb149305..e682ab628dfa 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -162,6 +162,8 @@ struct in_addr {
 #define MCAST_MSFILTER			48
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
+#define IP_LOCAL_PORT_RANGE		51
+#define IP_PROTOCOL			52
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index f597fe0db9f8..1d249d839819 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -987,6 +987,34 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
+	/* Make sure the cmd is valid before doing anything */
+	switch (cmd) {
+	case HCIGETDEVLIST:
+	case HCIGETDEVINFO:
+	case HCIGETCONNLIST:
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+	case HCISETSCAN:
+	case HCISETAUTH:
+	case HCISETENCRYPT:
+	case HCISETPTYPE:
+	case HCISETLINKPOL:
+	case HCISETLINKMODE:
+	case HCISETACLMTU:
+	case HCISETSCOMTU:
+	case HCIINQUIRY:
+	case HCISETRAW:
+	case HCIGETCONNINFO:
+	case HCIGETAUTHINFO:
+	case HCIBLOCKADDR:
+	case HCIUNBLOCKADDR:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9b203d8660e4..2396c99bedea 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -133,6 +133,29 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_get);
 #define recycle_stat_add(pool, __stat, val)
 #endif
 
+static bool page_pool_producer_lock(struct page_pool *pool)
+	__acquires(&pool->ring.producer_lock)
+{
+	bool in_softirq = in_softirq();
+
+	if (in_softirq)
+		spin_lock(&pool->ring.producer_lock);
+	else
+		spin_lock_bh(&pool->ring.producer_lock);
+
+	return in_softirq;
+}
+
+static void page_pool_producer_unlock(struct page_pool *pool,
+				      bool in_softirq)
+	__releases(&pool->ring.producer_lock)
+{
+	if (in_softirq)
+		spin_unlock(&pool->ring.producer_lock);
+	else
+		spin_unlock_bh(&pool->ring.producer_lock);
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
@@ -511,8 +534,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)
 {
 	int ret;
-	/* BH protection not needed if current is serving softirq */
-	if (in_serving_softirq())
+	/* BH protection not needed if current is softirq */
+	if (in_softirq())
 		ret = ptr_ring_produce(&pool->ring, page);
 	else
 		ret = ptr_ring_produce_bh(&pool->ring, page);
@@ -570,7 +593,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
-		if (allow_direct && in_serving_softirq() &&
+		if (allow_direct && in_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
 			return NULL;
 
@@ -615,6 +638,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count)
 {
 	int i, bulk_len = 0;
+	bool in_softirq;
 
 	for (i = 0; i < count; i++) {
 		struct page *page = virt_to_head_page(data[i]);
@@ -633,7 +657,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		return;
 
 	/* Bulk producer into ptr_ring page_pool cache */
-	page_pool_ring_lock(pool);
+	in_softirq = page_pool_producer_lock(pool);
 	for (i = 0; i < bulk_len; i++) {
 		if (__ptr_ring_produce(&pool->ring, data[i])) {
 			/* ring full */
@@ -642,7 +666,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 		}
 	}
 	recycle_stat_add(pool, ring, i);
-	page_pool_ring_unlock(pool);
+	page_pool_producer_unlock(pool, in_softirq);
 
 	/* Hopefully all pages was return into ptr_ring */
 	if (likely(i == bulk_len))
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 53d0251788aa..9e0f69451563 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -480,8 +480,6 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		msg_rx = sk_psock_peek_msg(psock);
 	}
 out:
-	if (psock->work_state.skb && copied > 0)
-		schedule_work(&psock->work);
 	return copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
@@ -623,42 +621,33 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 
 static void sk_psock_skb_state(struct sk_psock *psock,
 			       struct sk_psock_work_state *state,
-			       struct sk_buff *skb,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
 	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
-		state->skb = skb;
 		state->len = len;
 		state->off = off;
-	} else {
-		sock_drop(psock->sk, skb);
 	}
 	spin_unlock_bh(&psock->ingress_lock);
 }
 
 static void sk_psock_backlog(struct work_struct *work)
 {
-	struct sk_psock *psock = container_of(work, struct sk_psock, work);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct sk_psock *psock = container_of(dwork, struct sk_psock, work);
 	struct sk_psock_work_state *state = &psock->work_state;
 	struct sk_buff *skb = NULL;
+	u32 len = 0, off = 0;
 	bool ingress;
-	u32 len, off;
 	int ret;
 
 	mutex_lock(&psock->work_mutex);
-	if (unlikely(state->skb)) {
-		spin_lock_bh(&psock->ingress_lock);
-		skb = state->skb;
+	if (unlikely(state->len)) {
 		len = state->len;
 		off = state->off;
-		state->skb = NULL;
-		spin_unlock_bh(&psock->ingress_lock);
 	}
-	if (skb)
-		goto start;
 
-	while ((skb = skb_dequeue(&psock->ingress_skb))) {
+	while ((skb = skb_peek(&psock->ingress_skb))) {
 		len = skb->len;
 		off = 0;
 		if (skb_bpf_strparser(skb)) {
@@ -667,7 +656,6 @@ static void sk_psock_backlog(struct work_struct *work)
 			off = stm->offset;
 			len = stm->full_len;
 		}
-start:
 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
 		do {
@@ -677,22 +665,28 @@ static void sk_psock_backlog(struct work_struct *work)
 							  len, ingress);
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
-					sk_psock_skb_state(psock, state, skb,
-							   len, off);
+					sk_psock_skb_state(psock, state, len, off);
+
+					/* Delay slightly to prioritize any
+					 * other work that might be here.
+					 */
+					if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
+						schedule_delayed_work(&psock->work, 1);
 					goto end;
 				}
 				/* Hard errors break pipe and stop xmit. */
 				sk_psock_report_error(psock, ret ? -ret : EPIPE);
 				sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
-				sock_drop(psock->sk, skb);
 				goto end;
 			}
 			off += ret;
 			len -= ret;
 		} while (len);
 
-		if (!ingress)
+		skb = skb_dequeue(&psock->ingress_skb);
+		if (!ingress) {
 			kfree_skb(skb);
+		}
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
@@ -733,7 +727,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	INIT_LIST_HEAD(&psock->link);
 	spin_lock_init(&psock->link_lock);
 
-	INIT_WORK(&psock->work, sk_psock_backlog);
+	INIT_DELAYED_WORK(&psock->work, sk_psock_backlog);
 	mutex_init(&psock->work_mutex);
 	INIT_LIST_HEAD(&psock->ingress_msg);
 	spin_lock_init(&psock->ingress_lock);
@@ -785,11 +779,6 @@ static void __sk_psock_zap_ingress(struct sk_psock *psock)
 		skb_bpf_redirect_clear(skb);
 		sock_drop(psock->sk, skb);
 	}
-	kfree_skb(psock->work_state.skb);
-	/* We null the skb here to ensure that calls to sk_psock_backlog
-	 * do not pick up the free'd skb.
-	 */
-	psock->work_state.skb = NULL;
 	__sk_psock_purge_ingress_msg(psock);
 }
 
@@ -808,7 +797,6 @@ void sk_psock_stop(struct sk_psock *psock)
 	spin_lock_bh(&psock->ingress_lock);
 	sk_psock_clear_state(psock, SK_PSOCK_TX_ENABLED);
 	sk_psock_cork_free(psock);
-	__sk_psock_zap_ingress(psock);
 	spin_unlock_bh(&psock->ingress_lock);
 }
 
@@ -822,7 +810,8 @@ static void sk_psock_destroy(struct work_struct *work)
 
 	sk_psock_done_strp(psock);
 
-	cancel_work_sync(&psock->work);
+	cancel_delayed_work_sync(&psock->work);
+	__sk_psock_zap_ingress(psock);
 	mutex_destroy(&psock->work_mutex);
 
 	psock_progs_drop(&psock->progs);
@@ -937,7 +926,7 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	}
 
 	skb_queue_tail(&psock_other->ingress_skb, skb);
-	schedule_work(&psock_other->work);
+	schedule_delayed_work(&psock_other->work, 0);
 	spin_unlock_bh(&psock_other->ingress_lock);
 	return 0;
 }
@@ -989,10 +978,8 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 		err = -EIO;
 		sk_other = psock->sk;
 		if (sock_flag(sk_other, SOCK_DEAD) ||
-		    !sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
-			skb_bpf_redirect_clear(skb);
+		    !sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
 			goto out_free;
-		}
 
 		skb_bpf_set_ingress(skb);
 
@@ -1017,22 +1004,23 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 			spin_lock_bh(&psock->ingress_lock);
 			if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 				skb_queue_tail(&psock->ingress_skb, skb);
-				schedule_work(&psock->work);
+				schedule_delayed_work(&psock->work, 0);
 				err = 0;
 			}
 			spin_unlock_bh(&psock->ingress_lock);
-			if (err < 0) {
-				skb_bpf_redirect_clear(skb);
+			if (err < 0)
 				goto out_free;
-			}
 		}
 		break;
 	case __SK_REDIRECT:
+		tcp_eat_skb(psock->sk, skb);
 		err = sk_psock_skb_redirect(psock, skb);
 		break;
 	case __SK_DROP:
 	default:
 out_free:
+		skb_bpf_redirect_clear(skb);
+		tcp_eat_skb(psock->sk, skb);
 		sock_drop(psock->sk, skb);
 	}
 
@@ -1048,7 +1036,7 @@ static void sk_psock_write_space(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
-			schedule_work(&psock->work);
+			schedule_delayed_work(&psock->work, 0);
 		write_space = psock->saved_write_space;
 	}
 	rcu_read_unlock();
@@ -1077,8 +1065,7 @@ static void sk_psock_strp_read(struct strparser *strp, struct sk_buff *skb)
 		skb_dst_drop(skb);
 		skb_bpf_redirect_clear(skb);
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
-		if (ret == SK_PASS)
-			skb_bpf_set_strparser(skb);
+		skb_bpf_set_strparser(skb);
 		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
 		skb->sk = NULL;
 	}
@@ -1180,12 +1167,11 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 	int ret = __SK_DROP;
 	int len = skb->len;
 
-	skb_get(skb);
-
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		len = 0;
+		tcp_eat_skb(sk, skb);
 		sock_drop(sk, skb);
 		goto out;
 	}
@@ -1209,10 +1195,19 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	int copied;
 
 	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
 		return;
-	sock->ops->read_skb(sk, sk_psock_verdict_recv);
+	copied = sock->ops->read_skb(sk, sk_psock_verdict_recv);
+	if (copied >= 0) {
+		struct sk_psock *psock;
+
+		rcu_read_lock();
+		psock = sk_psock(sk);
+		psock->saved_data_ready(sk);
+		rcu_read_unlock();
+	}
 }
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index a68a7290a3b2..d38267201892 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1624,9 +1624,10 @@ void sock_map_close(struct sock *sk, long timeout)
 		rcu_read_unlock();
 		sk_psock_stop(psock);
 		release_sock(sk);
-		cancel_work_sync(&psock->work);
+		cancel_delayed_work_sync(&psock->work);
 		sk_psock_put(sk, psock);
 	}
+
 	/* Make sure we do not recurse. This is a bug.
 	 * Leak the socket instead of crashing on a stack overflow.
 	 */
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7152ede18f11..916075e00d06 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -117,7 +117,7 @@ bool inet_rcv_saddr_any(const struct sock *sk)
 	return !sk->sk_rcv_saddr;
 }
 
-void inet_get_local_port_range(struct net *net, int *low, int *high)
+void inet_get_local_port_range(const struct net *net, int *low, int *high)
 {
 	unsigned int seq;
 
@@ -130,6 +130,27 @@ void inet_get_local_port_range(struct net *net, int *low, int *high)
 }
 EXPORT_SYMBOL(inet_get_local_port_range);
 
+void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
+{
+	const struct inet_sock *inet = inet_sk(sk);
+	const struct net *net = sock_net(sk);
+	int lo, hi, sk_lo, sk_hi;
+
+	inet_get_local_port_range(net, &lo, &hi);
+
+	sk_lo = inet->local_port_range.lo;
+	sk_hi = inet->local_port_range.hi;
+
+	if (unlikely(lo <= sk_lo && sk_lo <= hi))
+		lo = sk_lo;
+	if (unlikely(lo <= sk_hi && sk_hi <= hi))
+		hi = sk_hi;
+
+	*low = lo;
+	*high = hi;
+}
+EXPORT_SYMBOL(inet_sk_get_local_port_range);
+
 static bool inet_use_bhash2_on_bind(const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -316,7 +337,7 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 ports_exhausted:
 	attempt_half = (sk->sk_reuse == SK_CAN_REUSE) ? 1 : 0;
 other_half_scan:
-	inet_get_local_port_range(net, &low, &high);
+	inet_sk_get_local_port_range(sk, &low, &high);
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	if (high - low < 4)
 		attempt_half = 0;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f0750c06d5ff..e8734ffca85a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1022,7 +1022,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 
-	inet_get_local_port_range(net, &low, &high);
+	inet_sk_get_local_port_range(sk, &low, &high);
 	high++; /* [32768, 60999] -> [32768, 61000[ */
 	remaining = high - low;
 	if (likely(remaining > 1))
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6e19cad154f5..a7fd035b5b4f 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -317,7 +317,14 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			ipc->tos = val;
 			ipc->priority = rt_tos2priority(ipc->tos);
 			break;
-
+		case IP_PROTOCOL:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
+				return -EINVAL;
+			val = *(int *)CMSG_DATA(cmsg);
+			if (val < 1 || val > 255)
+				return -EINVAL;
+			ipc->protocol = val;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -922,6 +929,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_CHECKSUM:
 	case IP_RECVFRAGSIZE:
 	case IP_RECVERR_RFC4884:
+	case IP_LOCAL_PORT_RANGE:
 		if (optlen >= sizeof(int)) {
 			if (copy_from_sockptr(&val, optval, sizeof(val)))
 				return -EFAULT;
@@ -1364,6 +1372,20 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(inet->min_ttl, val);
 		break;
 
+	case IP_LOCAL_PORT_RANGE:
+	{
+		const __u16 lo = val;
+		const __u16 hi = val >> 16;
+
+		if (optlen != sizeof(__u32))
+			goto e_inval;
+		if (lo != 0 && hi != 0 && lo > hi)
+			goto e_inval;
+
+		inet->local_port_range.lo = lo;
+		inet->local_port_range.hi = hi;
+		break;
+	}
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1742,6 +1764,12 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MINTTL:
 		val = inet->min_ttl;
 		break;
+	case IP_LOCAL_PORT_RANGE:
+		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
+		break;
+	case IP_PROTOCOL:
+		val = inet_sk(sk)->inet_num;
+		break;
 	default:
 		sockopt_release_sock(sk);
 		return -ENOPROTOOPT;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index af03aa8a8e51..86197634dcf5 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -530,6 +530,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipcm_init_sk(&ipc, inet);
+	/* Keep backward compat */
+	if (hdrincl)
+		ipc.protocol = IPPROTO_RAW;
 
 	if (msg->msg_controllen) {
 		err = ip_cmsg_send(sk, msg, &ipc, false);
@@ -597,7 +600,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1fb67f819de4..021a8bf6a189 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1570,7 +1570,7 @@ static int tcp_peek_sndq(struct sock *sk, struct msghdr *msg, int len)
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void __tcp_cleanup_rbuf(struct sock *sk, int copied)
+void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool time_to_ack = false;
@@ -1772,7 +1772,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
 		tcp_flags = TCP_SKB_CB(skb)->tcp_flags;
 		used = recv_actor(sk, skb);
-		consume_skb(skb);
 		if (used < 0) {
 			if (!copied)
 				copied = used;
@@ -1786,14 +1785,6 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 			break;
 		}
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
-
-	tcp_rcv_space_adjust(sk);
-
-	/* Clean up data we have read: This will do ACK frames. */
-	if (copied > 0)
-		__tcp_cleanup_rbuf(sk, copied);
-
 	return copied;
 }
 EXPORT_SYMBOL(tcp_read_skb);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e9547467edb..5f93918c063c 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -11,6 +11,24 @@
 #include <net/inet_common.h>
 #include <net/tls.h>
 
+void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tcp;
+	int copied;
+
+	if (!skb || !skb->len || !sk_is_tcp(sk))
+		return;
+
+	if (skb_bpf_strparser(skb))
+		return;
+
+	tcp = tcp_sk(sk);
+	copied = tcp->copied_seq + skb->len;
+	WRITE_ONCE(tcp->copied_seq, copied);
+	tcp_rcv_space_adjust(sk);
+	__tcp_cleanup_rbuf(sk, skb->len);
+}
+
 static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 			   struct sk_msg *msg, u32 apply_bytes, int flags)
 {
@@ -174,14 +192,34 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
+static bool is_next_msg_fin(struct sk_psock *psock)
+{
+	struct scatterlist *sge;
+	struct sk_msg *msg_rx;
+	int i;
+
+	msg_rx = sk_psock_peek_msg(psock);
+	i = msg_rx->sg.start;
+	sge = sk_msg_elem(msg_rx, i);
+	if (!sge->length) {
+		struct sk_buff *skb = msg_rx->skb;
+
+		if (skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+			return true;
+	}
+	return false;
+}
+
 static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  struct msghdr *msg,
 				  size_t len,
 				  int flags,
 				  int *addr_len)
 {
+	struct tcp_sock *tcp = tcp_sk(sk);
+	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
-	int copied;
+	int copied = 0;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len, addr_len);
@@ -194,8 +232,43 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		return tcp_recvmsg(sk, msg, len, flags, addr_len);
 
 	lock_sock(sk);
+
+	/* We may have received data on the sk_receive_queue pre-accept and
+	 * then we can not use read_skb in this context because we haven't
+	 * assigned a sk_socket yet so have no link to the ops. The work-around
+	 * is to check the sk_receive_queue and in these cases read skbs off
+	 * queue again. The read_skb hook is not running at this point because
+	 * of lock_sock so we avoid having multiple runners in read_skb.
+	 */
+	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
+		tcp_data_ready(sk);
+		/* This handles the ENOMEM errors if we both receive data
+		 * pre accept and are already under memory pressure. At least
+		 * let user know to retry.
+		 */
+		if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
+			copied = -EAGAIN;
+			goto out;
+		}
+	}
+
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	/* The typical case for EFAULT is the socket was gracefully
+	 * shutdown with a FIN pkt. So check here the other case is
+	 * some error on copy_page_to_iter which would be unexpected.
+	 * On fin return correct return code to zero.
+	 */
+	if (copied == -EFAULT) {
+		bool is_fin = is_next_msg_fin(psock);
+
+		if (is_fin) {
+			copied = 0;
+			seq++;
+			goto out;
+		}
+	}
+	seq += copied;
 	if (!copied) {
 		long timeo;
 		int data;
@@ -233,6 +306,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		copied = -EAGAIN;
 	}
 out:
+	WRITE_ONCE(tcp->copied_seq, seq);
+	tcp_rcv_space_adjust(sk);
+	if (copied > 0)
+		__tcp_cleanup_rbuf(sk, copied);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return copied;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2eaf47e23b22..956d6797c76f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -243,7 +243,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		int low, high, remaining;
 		unsigned int rand;
 
-		inet_get_local_port_range(net, &low, &high);
+		inet_sk_get_local_port_range(sk, &low, &high);
 		remaining = (high - low) + 1;
 
 		rand = get_random_u32();
@@ -1806,7 +1806,7 @@ EXPORT_SYMBOL(__skb_recv_udp);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 try_again:
 	skb = skb_recv_udp(sk, MSG_DONTWAIT, &err);
@@ -1825,10 +1825,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 EXPORT_SYMBOL(udp_read_skb);
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index f44b99f7ecdc..33852fc38ad9 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -791,7 +791,8 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		if (!proto)
 			proto = inet->inet_num;
-		else if (proto != inet->inet_num)
+		else if (proto != inet->inet_num &&
+			 inet->inet_num != IPPROTO_RAW)
 			return -EINVAL;
 
 		if (proto > 255)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index cb4325b8ebb1..857cddd9d82e 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1559,9 +1559,6 @@ static const struct nla_policy ct_nla_policy[CTA_MAX+1] = {
 
 static int ctnetlink_flush_iterate(struct nf_conn *ct, void *data)
 {
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status))
-		return 0;
-
 	return ctnetlink_filter_match(ct, data);
 }
 
@@ -1631,11 +1628,6 @@ static int ctnetlink_del_conntrack(struct sk_buff *skb,
 
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
-		nf_ct_put(ct);
-		return -EBUSY;
-	}
-
 	if (cda[CTA_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_ID]);
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 17185200079d..bc3d08bd7cef 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8325,7 +8325,7 @@ static int sctp_get_port_local(struct sock *sk, union sctp_addr *addr)
 		int low, high, remaining, index;
 		unsigned int rover;
 
-		inet_get_local_port_range(net, &low, &high);
+		inet_sk_get_local_port_range(sk, &low, &high);
 		remaining = (high - low) + 1;
 		rover = prandom_u32_max(remaining) + low;
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 0e840a0c3437..17737a65c643 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -165,6 +165,11 @@ static inline bool tls_strp_msg_ready(struct tls_sw_context_rx *ctx)
 	return ctx->strp.msg_ready;
 }
 
+static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
+{
+	return ctx->strp.mixed_decrypted;
+}
+
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac2..bf69c9d6d06c 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1007,20 +1007,14 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_buff *skb = tls_strp_msg(sw_ctx);
 	struct strp_msg *rxm = strp_msg(skb);
-	int is_decrypted = skb->decrypted;
-	int is_encrypted = !is_decrypted;
-	struct sk_buff *skb_iter;
-	int left;
-
-	left = rxm->full_len - skb->len;
-	/* Check if all the data is decrypted already */
-	skb_iter = skb_shinfo(skb)->frag_list;
-	while (skb_iter && left > 0) {
-		is_decrypted &= skb_iter->decrypted;
-		is_encrypted &= !skb_iter->decrypted;
-
-		left -= skb_iter->len;
-		skb_iter = skb_iter->next;
+	int is_decrypted, is_encrypted;
+
+	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
+		is_decrypted = skb->decrypted;
+		is_encrypted = !is_decrypted;
+	} else {
+		is_decrypted = 0;
+		is_encrypted = 0;
 	}
 
 	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 955ac3e0bf4d..da95abbb7ea3 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -29,34 +29,50 @@ static void tls_strp_anchor_free(struct tls_strparser *strp)
 	struct skb_shared_info *shinfo = skb_shinfo(strp->anchor);
 
 	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
-	shinfo->frag_list = NULL;
+	if (!strp->copy_mode)
+		shinfo->frag_list = NULL;
 	consume_skb(strp->anchor);
 	strp->anchor = NULL;
 }
 
-/* Create a new skb with the contents of input copied to its page frags */
-static struct sk_buff *tls_strp_msg_make_copy(struct tls_strparser *strp)
+static struct sk_buff *
+tls_strp_skb_copy(struct tls_strparser *strp, struct sk_buff *in_skb,
+		  int offset, int len)
 {
-	struct strp_msg *rxm;
 	struct sk_buff *skb;
-	int i, err, offset;
+	int i, err;
 
-	skb = alloc_skb_with_frags(0, strp->stm.full_len, TLS_PAGE_ORDER,
+	skb = alloc_skb_with_frags(0, len, TLS_PAGE_ORDER,
 				   &err, strp->sk->sk_allocation);
 	if (!skb)
 		return NULL;
 
-	offset = strp->stm.offset;
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		WARN_ON_ONCE(skb_copy_bits(strp->anchor, offset,
+		WARN_ON_ONCE(skb_copy_bits(in_skb, offset,
 					   skb_frag_address(frag),
 					   skb_frag_size(frag)));
 		offset += skb_frag_size(frag);
 	}
 
-	skb_copy_header(skb, strp->anchor);
+	skb->len = len;
+	skb->data_len = len;
+	skb_copy_header(skb, in_skb);
+	return skb;
+}
+
+/* Create a new skb with the contents of input copied to its page frags */
+static struct sk_buff *tls_strp_msg_make_copy(struct tls_strparser *strp)
+{
+	struct strp_msg *rxm;
+	struct sk_buff *skb;
+
+	skb = tls_strp_skb_copy(strp, strp->anchor, strp->stm.offset,
+				strp->stm.full_len);
+	if (!skb)
+		return NULL;
+
 	rxm = strp_msg(skb);
 	rxm->offset = 0;
 	return skb;
@@ -180,22 +196,22 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
 	for (i = 0; i < shinfo->nr_frags; i++)
 		__skb_frag_unref(&shinfo->frags[i], false);
 	shinfo->nr_frags = 0;
+	if (strp->copy_mode) {
+		kfree_skb_list(shinfo->frag_list);
+		shinfo->frag_list = NULL;
+	}
 	strp->copy_mode = 0;
+	strp->mixed_decrypted = 0;
 }
 
-static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
-			   unsigned int offset, size_t in_len)
+static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
+				struct sk_buff *in_skb, unsigned int offset,
+				size_t in_len)
 {
-	struct tls_strparser *strp = (struct tls_strparser *)desc->arg.data;
-	struct sk_buff *skb;
-	skb_frag_t *frag;
 	size_t len, chunk;
+	skb_frag_t *frag;
 	int sz;
 
-	if (strp->msg_ready)
-		return 0;
-
-	skb = strp->anchor;
 	frag = &skb_shinfo(skb)->frags[skb->len / PAGE_SIZE];
 
 	len = in_len;
@@ -208,19 +224,26 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 					   skb_frag_size(frag),
 					   chunk));
 
-		sz = tls_rx_msg_size(strp, strp->anchor);
-		if (sz < 0) {
-			desc->error = sz;
-			return 0;
-		}
-
-		/* We may have over-read, sz == 0 is guaranteed under-read */
-		if (sz > 0)
-			chunk =	min_t(size_t, chunk, sz - skb->len);
-
 		skb->len += chunk;
 		skb->data_len += chunk;
 		skb_frag_size_add(frag, chunk);
+
+		sz = tls_rx_msg_size(strp, skb);
+		if (sz < 0)
+			return sz;
+
+		/* We may have over-read, sz == 0 is guaranteed under-read */
+		if (unlikely(sz && sz < skb->len)) {
+			int over = skb->len - sz;
+
+			WARN_ON_ONCE(over > chunk);
+			skb->len -= over;
+			skb->data_len -= over;
+			skb_frag_size_add(frag, -over);
+
+			chunk -= over;
+		}
+
 		frag++;
 		len -= chunk;
 		offset += chunk;
@@ -247,15 +270,99 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 		offset += chunk;
 	}
 
-	if (strp->stm.full_len == skb->len) {
+read_done:
+	return in_len - len;
+}
+
+static int tls_strp_copyin_skb(struct tls_strparser *strp, struct sk_buff *skb,
+			       struct sk_buff *in_skb, unsigned int offset,
+			       size_t in_len)
+{
+	struct sk_buff *nskb, *first, *last;
+	struct skb_shared_info *shinfo;
+	size_t chunk;
+	int sz;
+
+	if (strp->stm.full_len)
+		chunk = strp->stm.full_len - skb->len;
+	else
+		chunk = TLS_MAX_PAYLOAD_SIZE + PAGE_SIZE;
+	chunk = min(chunk, in_len);
+
+	nskb = tls_strp_skb_copy(strp, in_skb, offset, chunk);
+	if (!nskb)
+		return -ENOMEM;
+
+	shinfo = skb_shinfo(skb);
+	if (!shinfo->frag_list) {
+		shinfo->frag_list = nskb;
+		nskb->prev = nskb;
+	} else {
+		first = shinfo->frag_list;
+		last = first->prev;
+		last->next = nskb;
+		first->prev = nskb;
+	}
+
+	skb->len += chunk;
+	skb->data_len += chunk;
+
+	if (!strp->stm.full_len) {
+		sz = tls_rx_msg_size(strp, skb);
+		if (sz < 0)
+			return sz;
+
+		/* We may have over-read, sz == 0 is guaranteed under-read */
+		if (unlikely(sz && sz < skb->len)) {
+			int over = skb->len - sz;
+
+			WARN_ON_ONCE(over > chunk);
+			skb->len -= over;
+			skb->data_len -= over;
+			__pskb_trim(nskb, nskb->len - over);
+
+			chunk -= over;
+		}
+
+		strp->stm.full_len = sz;
+	}
+
+	return chunk;
+}
+
+static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
+			   unsigned int offset, size_t in_len)
+{
+	struct tls_strparser *strp = (struct tls_strparser *)desc->arg.data;
+	struct sk_buff *skb;
+	int ret;
+
+	if (strp->msg_ready)
+		return 0;
+
+	skb = strp->anchor;
+	if (!skb->len)
+		skb_copy_decrypted(skb, in_skb);
+	else
+		strp->mixed_decrypted |= !!skb_cmp_decrypted(skb, in_skb);
+
+	if (IS_ENABLED(CONFIG_TLS_DEVICE) && strp->mixed_decrypted)
+		ret = tls_strp_copyin_skb(strp, skb, in_skb, offset, in_len);
+	else
+		ret = tls_strp_copyin_frag(strp, skb, in_skb, offset, in_len);
+	if (ret < 0) {
+		desc->error = ret;
+		ret = 0;
+	}
+
+	if (strp->stm.full_len && strp->stm.full_len == skb->len) {
 		desc->count = 0;
 
 		strp->msg_ready = 1;
 		tls_rx_msg_ready(strp);
 	}
 
-read_done:
-	return in_len - len;
+	return ret;
 }
 
 static int tls_strp_read_copyin(struct tls_strparser *strp)
@@ -315,15 +422,19 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	return 0;
 }
 
-static bool tls_strp_check_no_dup(struct tls_strparser *strp)
+static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 {
 	unsigned int len = strp->stm.offset + strp->stm.full_len;
-	struct sk_buff *skb;
+	struct sk_buff *first, *skb;
 	u32 seq;
 
-	skb = skb_shinfo(strp->anchor)->frag_list;
-	seq = TCP_SKB_CB(skb)->seq;
+	first = skb_shinfo(strp->anchor)->frag_list;
+	skb = first;
+	seq = TCP_SKB_CB(first)->seq;
 
+	/* Make sure there's no duplicate data in the queue,
+	 * and the decrypted status matches.
+	 */
 	while (skb->len < len) {
 		seq += skb->len;
 		len -= skb->len;
@@ -331,6 +442,8 @@ static bool tls_strp_check_no_dup(struct tls_strparser *strp)
 
 		if (TCP_SKB_CB(skb)->seq != seq)
 			return false;
+		if (skb_cmp_decrypted(first, skb))
+			return false;
 	}
 
 	return true;
@@ -411,7 +524,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 			return tls_strp_read_copy(strp, true);
 	}
 
-	if (!tls_strp_check_no_dup(strp))
+	if (!tls_strp_check_queue_ok(strp))
 		return tls_strp_read_copy(strp, false);
 
 	strp->msg_ready = 1;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 70eb3bc67126..5b19b6c53a2c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2552,7 +2552,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_buff *skb;
-	int err, copied;
+	int err;
 
 	mutex_lock(&u->iolock);
 	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
@@ -2560,10 +2560,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (!skb)
 		return err;
 
-	copied = recv_actor(sk, skb);
-	kfree_skb(skb);
-
-	return copied;
+	return recv_actor(sk, skb);
 }
 
 /*
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 07a4cb149305..4b7f2df66b99 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -162,6 +162,7 @@ struct in_addr {
 #define MCAST_MSFILTER			48
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
+#define IP_LOCAL_PORT_RANGE		51
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 687249d99b5f..0465ddc81f35 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -193,7 +193,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
+	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) \
 		  $< -o $@ \
 		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
