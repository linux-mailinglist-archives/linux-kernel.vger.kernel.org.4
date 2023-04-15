Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973F6E2DF5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDOAhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DB49F0;
        Fri, 14 Apr 2023 17:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8190A60F7D;
        Sat, 15 Apr 2023 00:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D894DC433EF;
        Sat, 15 Apr 2023 00:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681519017;
        bh=/FvunurOUXjKA1bZtALkwzMRkXzUOWo4NOiLECjObgE=;
        h=From:To:Cc:Subject:Date:From;
        b=IBRhM0OGouexVSlXuuNEfrRtYXsAcZ49RsAW/2qVjyfavR4wLgGijDU2l4uHHZ2AE
         BsRX3zQUcusJhxOztjcRL9o82BhZRDmHJKUbrCOS4s8TGUqDrAd7KsQ21AWbGU39TI
         39YNIUX7P0Vu9tTeqIJ78+B/XKLNqFnwM3DEUHi/P2rMCEJw2W2YjmMKPZg2Zs6F/Y
         ISJJY9rR0aLGrJz1CFOpJyQiE1TSFxyXEOUiPeqoJWmbTkRgPruT/SVi+FruzdRwoZ
         fU2I5/ZCkXZXLY5jZKPxiaD/lcdU2+d2ZSIlHK5YMbvohiF8eF9f8kDK/hk0WPbo+U
         Yqlw4Y2bB2oZA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] scsi: ufs: remove ufshcd_hold asynchronously
Date:   Fri, 14 Apr 2023 17:36:54 -0700
Message-ID: <20230415003654.3832806-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
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

If ufshcd_hold() returns EAGAIN during queuecommand, scsi will get an error and
resubmit the request along with other commands. This can increase the chance of
reording write IOs, even it's sequential.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/ufs/core/ufs-sysfs.c     |  2 +-
 drivers/ufs/core/ufshcd-crypto.c |  2 +-
 drivers/ufs/core/ufshcd-priv.h   |  2 +-
 drivers/ufs/core/ufshcd.c        | 63 +++++++++++---------------------
 include/ufs/ufshcd.h             |  2 +-
 5 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 883f0e44b54e..cdf3d5f2b77b 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -168,7 +168,7 @@ static ssize_t auto_hibern8_show(struct device *dev,
 	}
 
 	pm_runtime_get_sync(hba->dev);
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	ahit = ufshcd_readl(hba, REG_AUTO_HIBERNATE_IDLE_TIMER);
 	ufshcd_release(hba);
 	pm_runtime_put_sync(hba->dev);
diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 198360fe5e8e..f2c4422cab86 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -24,7 +24,7 @@ static int ufshcd_program_key(struct ufs_hba *hba,
 	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
 	int err = 0;
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 	if (hba->vops && hba->vops->program_key) {
 		err = hba->vops->program_key(hba, cfg, slot);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f8507a5e4..73c5d98f4387 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -84,7 +84,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 			    u8 **buf, bool ascii);
 
-int ufshcd_hold(struct ufs_hba *hba, bool async);
+void ufshcd_hold(struct ufs_hba *hba);
 void ufshcd_release(struct ufs_hba *hba);
 
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 37e178a9ac47..8ae29cf5be3e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1178,7 +1178,7 @@ static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
 	bool timeout = false, do_last_check = false;
 	ktime_t start;
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	/*
 	 * Wait for all the outstanding tasks/transfer requests.
@@ -1299,7 +1299,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 	}
 
 	/* let's not get into low power until clock scaling is completed */
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 out:
 	return ret;
@@ -1636,7 +1636,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 		goto out;
 
 	ufshcd_rpm_get_sync(hba);
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 	hba->clk_scaling.is_enabled = value;
 
@@ -1750,17 +1750,15 @@ static void ufshcd_ungate_work(struct work_struct *work)
  * ufshcd_hold - Enable clocks that were gated earlier due to ufshcd_release.
  * Also, exit from hibern8 mode and set the link as active.
  * @hba: per adapter instance
- * @async: This indicates whether caller should ungate clocks asynchronously.
  */
-int ufshcd_hold(struct ufs_hba *hba, bool async)
+void ufshcd_hold(struct ufs_hba *hba)
 {
-	int rc = 0;
 	bool flush_result;
 	unsigned long flags;
 
 	if (!ufshcd_is_clkgating_allowed(hba) ||
 	    !hba->clk_gating.is_initialized)
-		goto out;
+		return;
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	hba->clk_gating.active_reqs++;
 
@@ -1777,15 +1775,10 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 */
 		if (ufshcd_can_hibern8_during_gating(hba) &&
 		    ufshcd_is_link_hibern8(hba)) {
-			if (async) {
-				rc = -EAGAIN;
-				hba->clk_gating.active_reqs--;
-				break;
-			}
 			spin_unlock_irqrestore(hba->host->host_lock, flags);
 			flush_result = flush_work(&hba->clk_gating.ungate_work);
 			if (hba->clk_gating.is_suspended && !flush_result)
-				goto out;
+				return;
 			spin_lock_irqsave(hba->host->host_lock, flags);
 			goto start;
 		}
@@ -1816,12 +1809,6 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 */
 		fallthrough;
 	case REQ_CLKS_ON:
-		if (async) {
-			rc = -EAGAIN;
-			hba->clk_gating.active_reqs--;
-			break;
-		}
-
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
 		flush_work(&hba->clk_gating.ungate_work);
 		/* Make sure state is CLKS_ON before returning */
@@ -1833,8 +1820,6 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		break;
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
-out:
-	return rc;
 }
 EXPORT_SYMBOL_GPL(ufshcd_hold);
 
@@ -2066,7 +2051,7 @@ static void ufshcd_exit_clk_gating(struct ufs_hba *hba)
 	ufshcd_remove_clk_gating_sysfs(hba);
 
 	/* Ungate the clock if necessary. */
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	hba->clk_gating.is_initialized = false;
 	ufshcd_release(hba);
 
@@ -2461,7 +2446,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_UIC_CMD)
 		return 0;
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
@@ -2915,11 +2900,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 
 	hba->req_abort_count = 0;
 
-	err = ufshcd_hold(hba, true);
-	if (err) {
-		err = SCSI_MLQUEUE_HOST_BUSY;
-		goto out;
-	}
+	ufshcd_hold(hba);
 	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
 		(hba->clk_gating.state != CLKS_ON));
 
@@ -3246,7 +3227,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 
 	BUG_ON(!hba);
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
@@ -3320,7 +3301,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
@@ -3416,7 +3397,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		return -EINVAL;
 	}
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 	mutex_lock(&hba->dev_cmd.lock);
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
@@ -4234,7 +4215,7 @@ int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 	uic_cmd.command = UIC_CMD_DME_SET;
 	uic_cmd.argument1 = UIC_ARG_MIB(PA_PWRMODE);
 	uic_cmd.argument3 = mode;
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	ret = ufshcd_uic_pwr_ctrl(hba, &uic_cmd);
 	ufshcd_release(hba);
 
@@ -4341,7 +4322,7 @@ void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit)
 	if (update &&
 	    !pm_runtime_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
 		ufshcd_rpm_get_sync(hba);
-		ufshcd_hold(hba, false);
+		ufshcd_hold(hba);
 		ufshcd_auto_hibern8_enable(hba);
 		ufshcd_release(hba);
 		ufshcd_rpm_put_sync(hba);
@@ -4934,7 +4915,7 @@ static int ufshcd_verify_dev_init(struct ufs_hba *hba)
 	int err = 0;
 	int retries;
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	mutex_lock(&hba->dev_cmd.lock);
 	for (retries = NOP_OUT_RETRIES; retries > 0; retries--) {
 		err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_NOP,
@@ -6217,14 +6198,14 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		ufshcd_setup_vreg(hba, true);
 		ufshcd_config_vreg_hpm(hba, hba->vreg_info.vccq);
 		ufshcd_config_vreg_hpm(hba, hba->vreg_info.vccq2);
-		ufshcd_hold(hba, false);
+		ufshcd_hold(hba);
 		if (!ufshcd_is_clkgating_allowed(hba))
 			ufshcd_setup_clocks(hba, true);
 		ufshcd_release(hba);
 		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM : UFS_RUNTIME_PM;
 		ufshcd_vops_resume(hba, pm_op);
 	} else {
-		ufshcd_hold(hba, false);
+		ufshcd_hold(hba);
 		if (ufshcd_is_clkscaling_supported(hba) &&
 		    hba->clk_scaling.is_enabled)
 			ufshcd_suspend_clkscaling(hba);
@@ -6877,7 +6858,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
 		return PTR_ERR(req);
 
 	req->end_io_data = &wait;
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 
 	spin_lock_irqsave(host->host_lock, flags);
 
@@ -7114,7 +7095,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 		cmd_type = DEV_CMD_TYPE_NOP;
 		fallthrough;
 	case UPIU_TRANSACTION_QUERY_REQ:
-		ufshcd_hold(hba, false);
+		ufshcd_hold(hba);
 		mutex_lock(&hba->dev_cmd.lock);
 		err = ufshcd_issue_devman_upiu_cmd(hba, req_upiu, rsp_upiu,
 						   desc_buff, buff_len,
@@ -7180,7 +7161,7 @@ int ufshcd_advanced_rpmb_req_handler(struct ufs_hba *hba, struct utp_upiu_req *r
 	u16 ehs_len;
 
 	/* Protects use of hba->reserved_slot. */
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	mutex_lock(&hba->dev_cmd.lock);
 	down_read(&hba->clk_scaling_lock);
 
@@ -7415,7 +7396,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 
 	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);
 
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	/* If command is already aborted/completed, return FAILED. */
 	if (!(test_bit(tag, &hba->outstanding_reqs))) {
@@ -9396,7 +9377,7 @@ static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 	 * If we can't transition into any of the low power modes
 	 * just gate the clocks.
 	 */
-	ufshcd_hold(hba, false);
+	ufshcd_hold(hba);
 	hba->clk_gating.is_suspended = true;
 
 	if (ufshcd_is_clkscaling_supported(hba))
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 25aab8ec4f86..673729cf5697 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1364,7 +1364,7 @@ void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 			    u8 **buf, bool ascii);
 
-int ufshcd_hold(struct ufs_hba *hba, bool async);
+void ufshcd_hold(struct ufs_hba *hba);
 void ufshcd_release(struct ufs_hba *hba);
 
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value);
-- 
2.40.0.634.g4ca3ef3211-goog

