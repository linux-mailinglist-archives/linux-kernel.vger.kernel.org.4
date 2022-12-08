Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6412647297
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiLHPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiLHPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACFEA13E7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9281CE24BE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EAC433C1;
        Thu,  8 Dec 2022 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512440;
        bh=T/DDDDeU3/Lr3ifPweQ7tEM8IZx5N7efjB+ixRabz8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cry0nHF3yRK4KLjyJ583haf6ZtojFTh/hh4b1wNT/Nal57AQdF3R0V2d20gBztXu1
         j43Q+DTyJD7Ij3rwPnsoqJDeeSuATapGeIAFnyCubh8zmLd7WrMCfC15D4tEpBEctk
         ClxRcs2mdq2CfNktLPgLU25EPlzUI+2484s4LkBO7BIUGdUcvDBle/tpS/ba0IOloM
         hZwL4k8it6DXMz89b0kJGMWJFR0XxynESumIbf4lynd4cQGeED8+kHMHDJG5y7H8Xr
         IuFxKKnYWGRmvpiY+oVJ0I6rOvO1s2K9PVNdQlfWD9Q1GcoAsvrRHUg629QU4DoGDP
         Xjvsg948yu7Dw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 04/26] habanalabs: abort waiting user threads upon error
Date:   Thu,  8 Dec 2022 17:13:28 +0200
Message-Id: <20221208151350.1833823-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

User should close the FD when being notified about an error, after
which a device reset takes place.

However, if the user has pending threads that wait for completions,
the device release won't be called and eventually the watchdog timeout
will expire, leading to hard reset and killing the user process.

To avoid it, abort such waiting threads right after the error
notification, and block following waiting operations.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 28 +++++++++++++++++--
 drivers/misc/habanalabs/common/device.c       |  2 ++
 drivers/misc/habanalabs/common/habanalabs.h   |  1 +
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ea0e5101c10e..cf3b82efc65c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1117,6 +1117,27 @@ void hl_release_pending_user_interrupts(struct hl_device *hdev)
 	wake_pending_user_interrupt_threads(interrupt);
 }
 
+static void force_complete_cs(struct hl_device *hdev)
+{
+	struct hl_cs *cs;
+
+	spin_lock(&hdev->cs_mirror_lock);
+
+	list_for_each_entry(cs, &hdev->cs_mirror_list, mirror_node) {
+		cs->fence->error = -EIO;
+		complete_all(&cs->fence->completion);
+	}
+
+	spin_unlock(&hdev->cs_mirror_lock);
+}
+
+void hl_abort_waitings_for_completion(struct hl_device *hdev)
+{
+	force_complete_cs(hdev);
+	force_complete_multi_cs(hdev);
+	hl_release_pending_user_interrupts(hdev);
+}
+
 static void job_wq_completion(struct work_struct *work)
 {
 	struct hl_cs_job *job = container_of(work, struct hl_cs_job,
@@ -3489,14 +3510,15 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
+	struct hl_device *hdev = hpriv->hdev;
 	union hl_wait_cs_args *args = data;
 	u32 flags = args->in.flags;
 	int rc;
 
-	/* If the device is not operational, no point in waiting for any command submission or
-	 * user interrupt
+	/* If the device is not operational, or if an error has happened and user should release the
+	 * device, there is no point in waiting for any command submission or user interrupt.
 	 */
-	if (!hl_device_operational(hpriv->hdev, NULL))
+	if (!hl_device_operational(hpriv->hdev, NULL) || hdev->reset_info.watchdog_active)
 		return -EBUSY;
 
 	if (flags & HL_WAIT_CS_FLAGS_INTERRUPT)
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 1453f2ec72d9..92721111b652 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1865,6 +1865,8 @@ int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask)
 
 	hl_ctx_put(ctx);
 
+	hl_abort_waitings_for_completion(hdev);
+
 	return 0;
 
 device_reset:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9e42d0e9ce33..7fb45610ad0c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3791,6 +3791,7 @@ void hl_dec_fini(struct hl_device *hdev);
 void hl_dec_ctx_fini(struct hl_ctx *ctx);
 
 void hl_release_pending_user_interrupts(struct hl_device *hdev);
+void hl_abort_waitings_for_completion(struct hl_device *hdev);
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			struct hl_hw_sob **hw_sob, u32 count, bool encaps_sig);
 
-- 
2.25.1

