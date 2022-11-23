Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0BB636293
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiKWO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiKWO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245E3C6F4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CD461D53
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C63C433D6;
        Wed, 23 Nov 2022 14:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215494;
        bh=H4E+ornN4yLvnr16yeufh7PPylH/iBSEDCkhqnKmsoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9+eXjDSC1R4nNd9Jwt7t686RyYH8lusBKyNYUEynnIAYBRHXwe7tUjzf9oVBF/bh
         SwsOwvlRxMjMk/zVHL7E2vspGvflxzlrjv39SeMzwj9++c7AAauNlg/sWdjORASZok
         48Fhn6J3OKtyCsOcXw0xg4sEzWYBECXwG2Aa7sl8Dxd1iDnULk2gJaZ5oCnIYeR1i5
         il0yPsso+LMMXkh2RJMHJHGOWlsBICoUnQgZQVjK7sxfmQvqrFW3rvXRl34sm9hRWe
         GYcBU6SpC+94s5T6+DNzuyE78f74Poj6dWzQ+K5Zl5EoNsijatlOBCH/n2WLAPCzHQ
         1Q1vquHlsWpPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 7/8] habanalabs: fail driver load if EEPROM errors detected
Date:   Wed, 23 Nov 2022 16:58:00 +0200
Message-Id: <20221123145801.542029-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123145801.542029-1-ogabbay@kernel.org>
References: <20221123145801.542029-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

In case EEPROM is not burned, firmware sets default EEPROM values.
As this is not valid in production, driver should fail load upon any
EEPROM error reported by firmware.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 23 ++++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cf8147e43833..228b92278e48 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -617,16 +617,12 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 	if (sts_val & CPU_BOOT_DEV_STS0_ENABLED)
 		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
-	/* All warnings should go here in order not to reach the unknown error validation */
 	if (err_val & CPU_BOOT_ERR0_EEPROM_FAIL) {
-		dev_warn(hdev->dev,
-			"Device boot warning - EEPROM failure detected, default settings applied\n");
-		/* This is a warning so we don't want it to disable the
-		 * device
-		 */
-		err_val &= ~CPU_BOOT_ERR0_EEPROM_FAIL;
+		dev_err(hdev->dev, "Device boot error - EEPROM failure detected\n");
+		err_exists = true;
 	}
 
+	/* All warnings should go here in order not to reach the unknown error validation */
 	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED) {
 		dev_warn(hdev->dev,
 			"Device boot warning - Skipped DRAM initialization\n");
@@ -2532,7 +2528,7 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 					struct fw_load_mgr *fw_loader)
 {
 	struct cpu_dyn_regs *dyn_regs;
-	int rc;
+	int rc, fw_error_rc;
 
 	dev_info(hdev->dev,
 		"Loading %sfirmware to device, may take some time...\n",
@@ -2632,14 +2628,17 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 
 	hl_fw_dynamic_update_linux_interrupt_if(hdev);
 
-	return 0;
-
 protocol_err:
-	if (fw_loader->dynamic_loader.fw_desc_valid)
-		fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
+	if (fw_loader->dynamic_loader.fw_desc_valid) {
+		fw_error_rc = fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
 				le32_to_cpu(dyn_regs->cpu_boot_err1),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
+
+		if (fw_error_rc)
+			return fw_error_rc;
+	}
+
 	return rc;
 }
 
-- 
2.25.1

