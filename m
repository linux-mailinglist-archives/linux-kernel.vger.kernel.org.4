Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34903674B19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjATEoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjATEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD15C1320
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97263B82065
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C116C433F1;
        Thu, 19 Jan 2023 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124428;
        bh=y54ewbml1I4iFRDzazMX+Ve/HbnFguugCrugXNOrHeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifGCLFuPCxkREqmkyJPhT6JVtvFnq8wI7JKLv2sTXHA7la7b5rn2wOBkBhEbuauSA
         fDEFlIEyqaR9+IL1qEMdNBytfQNfllvB/LhXPf2JM4WqzaRjGjGF17HUCbt64gp5O1
         SAQaQbl8iLcAqM6cLVkM7DnOH+S+e5FCw7HD8kKDhKdbx0cjpLqilrGMHOl0l6t0Oj
         2tlxWTF+Kx5TkgaJKg0t3vNcIt/vlgJMloL+bZR5WP1t0muf4s9yy3kxWLly1htGgW
         +2ZKD6I+ncu8R+KpDV41q89LxZ6gyDuqiuWjuIwAjU02o1Gg+TXS1FL4TenibKn5ke
         akV9aTWaJM4tw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 03/10] habanalabs: block soft-reset on an unusable device
Date:   Thu, 19 Jan 2023 12:33:32 +0200
Message-Id: <20230119103339.718430-3-ogabbay@kernel.org>
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

From: Koby Elbaz <kelbaz@habana.ai>

A device with status malfunction indicates that it can't be used.
In such a case we do not support certain reset types, e.g.,
all kinds of soft-resets (compute reset, inference soft-reset),
and reset upon device release.

A hard-reset is the only way that an unusable device can change its
status. All other reset procedures can't put the device in a reset
procedure, which might ultimately cause the device to change its
status, unintentionally, to become operational again.

Such a scenario has recently occurred, when a user requested
a hard-reset while another heavy user workload was ongoing (reset
request is queued).
Since the workload couldn't finish within reset's timeout limits, the
reset has failed and set a device status malfunction.
Eventually, when the user released the FD, an unsuccessful soft-reset
occurred, hence followed by an additional hard-reset that changed the
ASICs status back to be operational.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 2b6971463f12..9a9c494b08a4 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1425,8 +1425,8 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
-			reset_upon_device_release = false, schedule_hard_reset = false, delay_reset,
-			from_dev_release, from_watchdog_thread;
+			reset_upon_device_release = false, schedule_hard_reset = false,
+			delay_reset, from_dev_release, from_watchdog_thread;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	struct hl_ctx *ctx;
 	int i, rc;
@@ -1443,12 +1443,17 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	delay_reset = !!(flags & HL_DRV_RESET_DELAY);
 	from_watchdog_thread = !!(flags & HL_DRV_RESET_FROM_WD_THR);
 
+	if (!hard_reset && (hl_device_status(hdev) == HL_DEVICE_STATUS_MALFUNCTION)) {
+		dev_dbg(hdev->dev, "soft-reset isn't supported on a malfunctioning device\n");
+		return 0;
+	}
+
 	if (!hard_reset && !hdev->asic_prop.supports_compute_reset) {
 		hard_instead_soft = true;
 		hard_reset = true;
 	}
 
-	if (hdev->reset_upon_device_release && (flags & HL_DRV_RESET_DEV_RELEASE)) {
+	if (hdev->reset_upon_device_release && from_dev_release) {
 		if (hard_reset) {
 			dev_crit(hdev->dev,
 				"Aborting reset because hard-reset is mutually exclusive with reset-on-device-release\n");
-- 
2.25.1

