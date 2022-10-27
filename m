Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4460F349
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiJ0JL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiJ0JKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824033E05
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC6A62241
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98911C433D6;
        Thu, 27 Oct 2022 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861820;
        bh=zp9jCk1x9mMPKUMofhmNDKb/B6OS0vNsjs0MayLTObk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgRnxcFuM+GC5HpDv7O08U+jkxy925ZBzfR7QZASyT1JrQU5jN80evdxlsJtt+r67
         X8mlb5Ktl4xrLCIT6GPHnNc9hCnZjsmue+uhpL3Hv1Ns5Xe5C3rGBhr9vEDkU+/LkD
         0MSYGmCEkmN6mHSX5SkTrCPIpKeq9//mNv8zT/PVTYj6euEDPHKQvYwSnTSZsCazho
         vrixGmxA9MRgEYxEFRYkuSEfW+mXFeVGbZzrbZpE2wXTMjML/EaaVGQOyS0S15Pqyq
         8Ys61D5koM158bVgpSBTupr/WDSQSxscfI4I+cCoC0ISp2k+WGDQK2hc46+FlxIXOA
         /mh6sBYCfYGPA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 06/15] habanalabs: add support for graceful hard reset
Date:   Thu, 27 Oct 2022 12:09:58 +0300
Message-Id: <20221027091007.664797-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Calling hl_device_reset() for a hard reset will lead to a quite
immediate device reset and to killing user process.
For resets that follow errors, it disables the option to debug the
errors on both the device side and the user application side.

This patch adds a 'graceful hard reset' option and a new
hl_device_cond_reset() function.
Under some conditions, mainly if there is no user process or if he is
not registered to driver notifications, this function will execute hard
reset as usual.
Otherwise, the reset will be postponed and a notification will be sent
to user, to let him perform post-error actions and then to release the
device, after which reset will take place.

If device is not released by user in some defined time, a watchdog work
will execute the reset in any case.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 141 ++++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h |  14 +-
 2 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b71303ba11d0..bcd959924971 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -16,7 +16,9 @@
 
 #include <trace/events/habanalabs.h>
 
-#define HL_RESET_DELAY_USEC		10000	/* 10ms */
+#define HL_RESET_DELAY_USEC			10000	/* 10ms */
+
+#define HL_DEVICE_RELEASE_WATCHDOG_TIMEOUT_SEC	5
 
 enum dma_alloc_type {
 	DMA_ALLOC_COHERENT,
@@ -387,7 +389,7 @@ bool hl_ctrl_device_operational(struct hl_device *hdev,
 static void hpriv_release(struct kref *ref)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
-	bool device_is_idle = true;
+	bool reset_device, device_is_idle = true;
 	struct hl_fpriv *hpriv;
 	struct hl_device *hdev;
 
@@ -404,14 +406,20 @@ static void hpriv_release(struct kref *ref)
 	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	/* No need for idle status check if device is going to be reset in any case */
-	if (!hdev->reset_upon_device_release && hdev->pdev && !hdev->pldm)
+	/* Device should be reset if reset-upon-device-release is enabled, or if there is a pending
+	 * reset that waits for device release.
+	 */
+	reset_device = hdev->reset_upon_device_release || hdev->reset_info.watchdog_active;
+
+	/* Unless device is reset in any case, check idle status and reset if device is not idle */
+	if (!reset_device && hdev->pdev && !hdev->pldm)
 		device_is_idle = hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 							HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL);
-
-	if (!device_is_idle)
+	if (!device_is_idle) {
 		dev_err(hdev->dev, "device not idle after user context is closed (0x%llx_%llx)\n",
 			idle_mask[1], idle_mask[0]);
+		reset_device = true;
+	}
 
 	/* We need to remove the user from the list to make sure the reset process won't
 	 * try to kill the user process. Because, if we got here, it means there are no
@@ -426,9 +434,10 @@ static void hpriv_release(struct kref *ref)
 	list_del(&hpriv->dev_node);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
-	if (!device_is_idle || hdev->reset_upon_device_release) {
+	if (reset_device) {
 		hl_device_reset(hdev, HL_DRV_RESET_DEV_RELEASE);
 	} else {
+		/* Scrubbing is handled within hl_device_reset(), so here need to do it directly */
 		int rc = hdev->asic_funcs->scrub_device_mem(hdev);
 
 		if (rc)
@@ -695,6 +704,20 @@ static void device_hard_reset_pending(struct work_struct *work)
 	}
 }
 
+static void device_release_watchdog_func(struct work_struct *work)
+{
+	struct hl_device_reset_work *device_release_watchdog_work =
+				container_of(work, struct hl_device_reset_work, reset_work.work);
+	struct hl_device *hdev = device_release_watchdog_work->hdev;
+	u32 flags;
+
+	dev_dbg(hdev->dev, "Device wasn't released in time. Initiate device reset.\n");
+
+	flags = device_release_watchdog_work->flags | HL_DRV_RESET_FROM_WD_THR;
+
+	hl_device_reset(hdev, flags);
+}
+
 /*
  * device_early_init - do some early initialization for the habanalabs device
  *
@@ -813,11 +836,14 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cb_mgr;
 	}
 
-	INIT_DELAYED_WORK(&hdev->device_reset_work.reset_work,
-			device_hard_reset_pending);
+	INIT_DELAYED_WORK(&hdev->device_reset_work.reset_work, device_hard_reset_pending);
 	hdev->device_reset_work.hdev = hdev;
 	hdev->device_fini_pending = 0;
 
+	INIT_DELAYED_WORK(&hdev->device_release_watchdog_work.reset_work,
+				device_release_watchdog_func);
+	hdev->device_release_watchdog_work.hdev = hdev;
+
 	mutex_init(&hdev->send_cpu_message_lock);
 	mutex_init(&hdev->debug_lock);
 	INIT_LIST_HEAD(&hdev->cs_mirror_list);
@@ -1367,8 +1393,8 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
-			reset_upon_device_release = false, schedule_hard_reset = false,
-			skip_wq_flush, delay_reset;
+			reset_upon_device_release = false, schedule_hard_reset = false, delay_reset,
+			from_dev_release, from_watchdog_thread;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	struct hl_ctx *ctx;
 	int i, rc;
@@ -1381,8 +1407,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hard_reset = !!(flags & HL_DRV_RESET_HARD);
 	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
 	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
-	skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
+	from_dev_release = !!(flags & HL_DRV_RESET_DEV_RELEASE);
 	delay_reset = !!(flags & HL_DRV_RESET_DELAY);
+	from_watchdog_thread = !!(flags & HL_DRV_RESET_FROM_WD_THR);
 
 	if (!hard_reset && !hdev->asic_prop.supports_compute_reset) {
 		hard_instead_soft = true;
@@ -1439,6 +1466,23 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		spin_unlock(&hdev->reset_info.lock);
 
+		/* Cancel the device release watchdog work if required.
+		 * In case of reset-upon-device-release while the release watchdog work is
+		 * scheduled, do hard-reset instead of compute-reset.
+		 */
+		if ((hard_reset || from_dev_release) && hdev->reset_info.watchdog_active) {
+			hdev->reset_info.watchdog_active = 0;
+			if (!from_watchdog_thread)
+				cancel_delayed_work_sync(
+						&hdev->device_release_watchdog_work.reset_work);
+
+			if (from_dev_release) {
+				flags |= HL_DRV_RESET_HARD;
+				flags &= ~HL_DRV_RESET_DEV_RELEASE;
+				hard_reset = true;
+			}
+		}
+
 		if (delay_reset)
 			usleep_range(HL_RESET_DELAY_USEC, HL_RESET_DELAY_USEC << 1);
 
@@ -1474,7 +1518,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		return 0;
 	}
 
-	cleanup_resources(hdev, hard_reset, fw_reset, skip_wq_flush);
+	cleanup_resources(hdev, hard_reset, fw_reset, from_dev_release);
 
 kill_processes:
 	if (hard_reset) {
@@ -1735,6 +1779,73 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	return rc;
 }
 
+/*
+ * hl_device_cond_reset() - conditionally reset the device.
+ * @hdev: pointer to habanalabs device structure.
+ * @reset_flags: reset flags.
+ * @event_mask: events to notify user about.
+ *
+ * Conditionally reset the device, or alternatively schedule a watchdog work to reset the device
+ * unless another reset precedes it.
+ */
+int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask)
+{
+	struct hl_ctx *ctx = NULL;
+
+	/* Device release watchdog is only for hard reset */
+	if (!(flags & HL_DRV_RESET_HARD) && hdev->asic_prop.allow_inference_soft_reset)
+		goto device_reset;
+
+	/* F/W reset cannot be postponed */
+	if (flags & HL_DRV_RESET_BYPASS_REQ_TO_FW)
+		goto device_reset;
+
+	/* Device release watchdog is relevant only if user exists and gets a reset notification */
+	if (!(event_mask & HL_NOTIFIER_EVENT_DEVICE_RESET)) {
+		dev_err(hdev->dev, "Resetting device without a reset indication to user\n");
+		goto device_reset;
+	}
+
+	ctx = hl_get_compute_ctx(hdev);
+	if (!ctx || !ctx->hpriv->notifier_event.eventfd)
+		goto device_reset;
+
+	/* Schedule the device release watchdog work unless reset is already in progress or if the
+	 * work is already scheduled.
+	 */
+	spin_lock(&hdev->reset_info.lock);
+	if (hdev->reset_info.in_reset) {
+		spin_unlock(&hdev->reset_info.lock);
+		goto device_reset;
+	}
+
+	if (hdev->reset_info.watchdog_active)
+		goto out;
+
+	hdev->device_release_watchdog_work.flags = flags;
+	dev_dbg(hdev->dev, "Device is going to be reset in %u sec unless being released\n",
+		hdev->device_release_watchdog_timeout_sec);
+	schedule_delayed_work(&hdev->device_release_watchdog_work.reset_work,
+				msecs_to_jiffies(hdev->device_release_watchdog_timeout_sec * 1000));
+	hdev->reset_info.watchdog_active = 1;
+out:
+	spin_unlock(&hdev->reset_info.lock);
+
+	hl_notifier_event_send_all(hdev, event_mask);
+
+	hl_ctx_put(ctx);
+
+	return 0;
+
+device_reset:
+	if (event_mask)
+		hl_notifier_event_send_all(hdev, event_mask);
+	if (ctx)
+		hl_ctx_put(ctx);
+
+	return hl_device_reset(hdev, flags);
+}
+
 static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64 event_mask)
 {
 	mutex_lock(&notifier_event->lock);
@@ -1932,6 +2043,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->asic_funcs->state_dump_init(hdev);
 
+	hdev->device_release_watchdog_timeout_sec = HL_DEVICE_RELEASE_WATCHDOG_TIMEOUT_SEC;
+
 	hdev->memory_scrub_val = MEM_SCRUB_DEFAULT_VAL;
 	hl_debugfs_add_device(hdev);
 
@@ -2152,6 +2265,8 @@ void hl_device_fini(struct hl_device *hdev)
 		}
 	}
 
+	cancel_delayed_work_sync(&hdev->device_release_watchdog_work.reset_work);
+
 	/* Disable PCI access from device F/W so it won't send us additional
 	 * interrupts. We disable MSI/MSI-X at the halt_engines function and we
 	 * can't have the F/W sending us interrupts after that. We need to
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c8347eac09ed..bfaaa9daa750 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -191,6 +191,9 @@ enum hl_mmu_enablement {
  *
  * - HL_DRV_RESET_DELAY
  *       Set if a delay should be added before the reset
+ *
+ * - HL_DRV_RESET_FROM_WD_THR
+ *       Set if the caller is the device release watchdog thread
  */
 
 #define HL_DRV_RESET_HARD		(1 << 0)
@@ -201,6 +204,7 @@ enum hl_mmu_enablement {
 #define HL_DRV_RESET_BYPASS_REQ_TO_FW	(1 << 5)
 #define HL_DRV_RESET_FW_FATAL_ERR	(1 << 6)
 #define HL_DRV_RESET_DELAY		(1 << 7)
+#define HL_DRV_RESET_FROM_WD_THR	(1 << 8)
 
 /*
  * Security
@@ -3009,6 +3013,7 @@ struct hl_error_info {
  *                          same cause.
  * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
  *                         complete instead.
+ * @watchdog_active: true if a device release watchdog work is scheduled.
  */
 struct hl_reset_info {
 	spinlock_t	lock;
@@ -3019,12 +3024,11 @@ struct hl_reset_info {
 	u8		in_compute_reset;
 	u8		needs_reset;
 	u8		hard_reset_pending;
-
 	u8		curr_reset_cause;
 	u8		prev_reset_trigger;
 	u8		reset_trigger_repeated;
-
 	u8		skip_reset_on_timeout;
+	u8		watchdog_active;
 };
 
 /**
@@ -3040,6 +3044,8 @@ struct hl_reset_info {
  * @dev_ctrl: related kernel device structure for the control device
  * @work_heartbeat: delayed work for CPU-CP is-alive check.
  * @device_reset_work: delayed work which performs hard reset
+ * @device_release_watchdog_work: watchdog work that performs hard reset if user doesn't release
+ *                                device upon certain error cases.
  * @asic_name: ASIC specific name.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
@@ -3149,6 +3155,7 @@ struct hl_reset_info {
  *                   indicates which decoder engines are binned-out
  * @edma_binning: contains mask of edma engines that is received from the f/w which
  *                   indicates which edma engines are binned-out
+ * @device_release_watchdog_timeout_sec: device release watchdog timeout value in seconds.
  * @id: device minor.
  * @id_control: minor of the control device.
  * @cdev_idx: char device index. Used for setting its name.
@@ -3218,6 +3225,7 @@ struct hl_device {
 	struct device			*dev_ctrl;
 	struct delayed_work		work_heartbeat;
 	struct hl_device_reset_work	device_reset_work;
+	struct hl_device_reset_work	device_release_watchdog_work;
 	char				asic_name[HL_STR_MAX];
 	char				status[HL_DEV_STS_MAX][HL_STR_MAX];
 	enum hl_asic_type		asic_type;
@@ -3312,6 +3320,7 @@ struct hl_device {
 	u32				high_pll;
 	u32				decoder_binning;
 	u32				edma_binning;
+	u32				device_release_watchdog_timeout_sec;
 	u16				id;
 	u16				id_control;
 	u16				cdev_idx;
@@ -3551,6 +3560,7 @@ void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
 int hl_device_reset(struct hl_device *hdev, u32 flags);
+int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 int hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_utilization(struct hl_device *hdev, u32 *utilization);
-- 
2.25.1

