Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA667359C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjASKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjASKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364651C7F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69073615A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F227CC433EF;
        Thu, 19 Jan 2023 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124433;
        bh=lE8cxHa+majFz2bt4UMSv6xjfGunkNiy3qsn64CriFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQkDGq4G0nT2lune2DeaPF7nwC0uKX4nOyFBHtyW+nVpkDNLiRDP2cU03qRUiqCWL
         sgerjwEGgdBh2nQBZuU9VMGD1UZZVThC4SUmbbXA4SRQNeVczHu0B+13xLC63eJ1fP
         Qr19qsnl6AccQ6mCQP9WHjZFCpMOB3klDblvRgfMGsk2L2oxPbIn1bYEQw3m1kuSgg
         rgQpQWaXacWzFAKLsTTcNDZSfirQvqsnGrHLdpnlgr6WykBoKYRd7/XP6ZDjMuUoqh
         09QQbZUiTGBw61mUE89M/yZU5jqXFXE9OM00Iqmwsq+8p975vmFhq5CfbQxPgGUypG
         dI+0Tbw+Tv1hQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 07/10] habanalabs: enhance info printed on FW load errors
Date:   Thu, 19 Jan 2023 12:33:36 +0200
Message-Id: <20230119103339.718430-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
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

From: Moti Haimovski <mhaimovski@habana.ai>

This commit enhances the following error messages to also provide the
type of error occurred, this in order to ease debugging of errors
detected during firmware-load.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index ef228087ef55..da892d8fb3d6 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -335,7 +335,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 			dev_dbg(hdev->dev, "Device CPU packet timeout (0x%x) due to FW reset\n",
 					tmp);
 		else
-			dev_err(hdev->dev, "Device CPU packet timeout (0x%x)\n", tmp);
+			dev_err(hdev->dev, "Device CPU packet timeout (status = 0x%x)\n", tmp);
 		hdev->device_cpu_disabled = true;
 		goto out;
 	}
@@ -1346,8 +1346,7 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 		break;
 	default:
 		dev_err(hdev->dev,
-			"Device boot progress - Invalid status code %d\n",
-			status);
+			"Device boot progress - Invalid or unexpected status code %d\n", status);
 		break;
 	}
 }
@@ -1377,8 +1376,8 @@ int hl_fw_wait_preboot_ready(struct hl_device *hdev)
 		pre_fw_load->wait_for_preboot_timeout);
 
 	if (rc) {
-		dev_err(hdev->dev, "CPU boot ready status timeout\n");
 		detect_cpu_boot_status(hdev, status);
+		dev_err(hdev->dev, "CPU boot ready timeout (status = %d)\n", status);
 
 		/* If we read all FF, then something is totally wrong, no point
 		 * of reading specific errors
@@ -2427,7 +2426,7 @@ static int hl_fw_dynamic_wait_for_boot_fit_active(struct hl_device *hdev,
 		hdev->fw_poll_interval_usec,
 		dyn_loader->wait_for_bl_timeout);
 	if (rc) {
-		dev_err(hdev->dev, "failed to wait for boot\n");
+		dev_err(hdev->dev, "failed to wait for boot (status = %d)\n", status);
 		return rc;
 	}
 
@@ -2454,7 +2453,7 @@ static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
 		hdev->fw_poll_interval_usec,
 		fw_loader->cpu_timeout);
 	if (rc) {
-		dev_err(hdev->dev, "failed to wait for Linux\n");
+		dev_err(hdev->dev, "failed to wait for Linux (status = %d)\n", status);
 		return rc;
 	}
 
@@ -2793,7 +2792,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 
 	if (rc) {
 		dev_dbg(hdev->dev,
-			"No boot fit request received, resuming boot\n");
+			"No boot fit request received (status = %d), resuming boot\n", status);
 	} else {
 		rc = hdev->asic_funcs->load_boot_fit_to_device(hdev);
 		if (rc)
@@ -2816,7 +2815,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 
 		if (rc) {
 			dev_err(hdev->dev,
-				"Timeout waiting for boot fit load ack\n");
+				"Timeout waiting for boot fit load ack (status = %d)\n", status);
 			goto out;
 		}
 
@@ -2894,7 +2893,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 
 		if (rc) {
 			dev_err(hdev->dev,
-				"Failed to get ACK on skipping BMC, %d\n",
+				"Failed to get ACK on skipping BMC (status = %d)\n",
 				status);
 			WREG32(msg_to_cpu_reg, KMD_MSG_NA);
 			rc = -EIO;
@@ -2921,7 +2920,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 				"Device reports FIT image is corrupted\n");
 		else
 			dev_err(hdev->dev,
-				"Failed to load firmware to device, %d\n",
+				"Failed to load firmware to device (status = %d)\n",
 				status);
 
 		rc = -EIO;
-- 
2.25.1

