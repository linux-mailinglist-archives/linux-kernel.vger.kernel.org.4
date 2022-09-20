Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312B65BE657
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiITMxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiITMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:52:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EAF6C130
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF20FB828C8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF55C433B5;
        Tue, 20 Sep 2022 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663678372;
        bh=FrhyU9ETGMmlSFTHEe5/naG0UUpl6RjK4o78FmkiBXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tvRdHJhAuSVgvYBE4sVGPu4ON68b+/0c82SLbL0HG0UOgK0+ImHFWwRyfJnOdz3Mc
         eHgeAs6UsMj1ddFJVVJ17ROvJgNJG+1vCInNgBNC4fUA+hHVbug4ajpg7HhBFDRZ91
         UMGrRLj399ZEf2UAxTM5u4KJQ4nD+J60aKC4kAdUf/8MCXFAP+vnsGnDcBPDiWomI2
         bGoMAzpi4ChMYffRjOVSnVLb7ZrkbrzLLWvFhwuzxnnyNmqjsKjU3VGufCzNMYrVvl
         1CuNVe8XtTcYHR2WCwRad6xaj2ZZQkiWTxW6zt1DyQn6BeN0ZHQYEE3ALZsyCQqnb3
         RsgrPanTXnCww==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/4] habanalabs: remove some f/w descriptor validations
Date:   Tue, 20 Sep 2022 15:52:43 +0300
Message-Id: <20220920125245.161233-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125245.161233-1-ogabbay@kernel.org>
References: <20220920125245.161233-1-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

To be forward-backward compatible with the firmware in the initial
communication during preboot, we need to remove the validation of the
header size. This will allow us to add more fields to the
lkd_fw_comms_desc structure.

Instead of the validation of the header size, we just print warning
when some mismatch in descriptor has been revealed, and we calculate
the CRC base on descriptor size reported by the firmware instead of
calculating it ourselves.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 43 +++++++-------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 26a7529083e1..2de6a9bd564d 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1900,50 +1900,36 @@ static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
 	u64 addr;
 	int rc;
 
-	if (le32_to_cpu(fw_desc->header.magic) != HL_COMMS_DESC_MAGIC) {
-		dev_err(hdev->dev, "Invalid magic for dynamic FW descriptor (%x)\n",
+	if (le32_to_cpu(fw_desc->header.magic) != HL_COMMS_DESC_MAGIC)
+		dev_warn(hdev->dev, "Invalid magic for dynamic FW descriptor (%x)\n",
 				fw_desc->header.magic);
-		return -EIO;
-	}
 
-	if (fw_desc->header.version != HL_COMMS_DESC_VER) {
-		dev_err(hdev->dev, "Invalid version for dynamic FW descriptor (%x)\n",
+	if (fw_desc->header.version != HL_COMMS_DESC_VER)
+		dev_warn(hdev->dev, "Invalid version for dynamic FW descriptor (%x)\n",
 				fw_desc->header.version);
-		return -EIO;
-	}
 
 	/*
-	 * calc CRC32 of data without header.
+	 * Calc CRC32 of data without header. use the size of the descriptor
+	 * reported by firmware, without calculating it ourself, to allow adding
+	 * more fields to the lkd_fw_comms_desc structure.
 	 * note that no alignment/stride address issues here as all structures
-	 * are 64 bit padded
+	 * are 64 bit padded.
 	 */
-	data_size = sizeof(struct lkd_fw_comms_desc) -
-					sizeof(struct comms_desc_header);
 	data_ptr = (u8 *)fw_desc + sizeof(struct comms_desc_header);
-
-	if (le16_to_cpu(fw_desc->header.size) != data_size) {
-		dev_err(hdev->dev,
-			"Invalid descriptor size 0x%x, expected size 0x%zx\n",
-				le16_to_cpu(fw_desc->header.size), data_size);
-		return -EIO;
-	}
+	data_size = le16_to_cpu(fw_desc->header.size);
 
 	data_crc32 = hl_fw_compat_crc32(data_ptr, data_size);
-
 	if (data_crc32 != le32_to_cpu(fw_desc->header.crc32)) {
-		dev_err(hdev->dev,
-			"CRC32 mismatch for dynamic FW descriptor (%x:%x)\n",
-					data_crc32, fw_desc->header.crc32);
+		dev_err(hdev->dev, "CRC32 mismatch for dynamic FW descriptor (%x:%x)\n",
+			data_crc32, fw_desc->header.crc32);
 		return -EIO;
 	}
 
 	/* find memory region to which to copy the image */
 	addr = le64_to_cpu(fw_desc->img_addr);
 	region_id = hl_get_pci_memory_region(hdev, addr);
-	if ((region_id != PCI_REGION_SRAM) &&
-			((region_id != PCI_REGION_DRAM))) {
-		dev_err(hdev->dev,
-			"Invalid region to copy FW image address=%llx\n", addr);
+	if ((region_id != PCI_REGION_SRAM) && ((region_id != PCI_REGION_DRAM))) {
+		dev_err(hdev->dev, "Invalid region to copy FW image address=%llx\n", addr);
 		return -EIO;
 	}
 
@@ -1960,8 +1946,7 @@ static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
 					fw_loader->dynamic_loader.fw_image_size,
 					region);
 	if (rc) {
-		dev_err(hdev->dev,
-			"invalid mem transfer request for FW image\n");
+		dev_err(hdev->dev, "invalid mem transfer request for FW image\n");
 		return rc;
 	}
 
-- 
2.25.1

