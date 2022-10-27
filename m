Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0A60F355
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiJ0JLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiJ0JKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1337424
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1995EB8255A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F9CC433D6;
        Thu, 27 Oct 2022 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861832;
        bh=CL2E2hze9JVQV1r9qVwQtOZ9wYZoyKE/msP/qwJKrLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WG84I6hClR8cpPgghIFsQpX8Cu4RcQwFv1kBkDGk2ax+zRU0kXXeB3NZvtDslVd0y
         mWMF25+BXjU/2Ee+aghyhhvgdSUUuYRliloKrgjo6yIGQxqCvO6cySmSvCwWC8Uqit
         vtL6eQSPMIWlC2eiI3brAu9LMpLBMZlxafP96F14Gyr/0f/QjYrKAT/gioeBfD2c54
         xUfYDZigyi9euWkQAcyHEUVDcOEuhYNNDHPaCiyPp6ku+MXDQRdu4gWeXgqzb7QfDg
         IP3EqpIVQkGvj5vcTwU81eSNHh6AgJkMBDilukFjPl7r4c9rV3QlKCbOA8ByjGJm5b
         RmG2UTAY7Dafg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 15/15] habanalabs: remove redundant gaudi2_sec asic type
Date:   Thu, 27 Oct 2022 12:10:07 +0300
Message-Id: <20221027091007.664797-15-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

As Gaudi2 has a single PCI id, the secured asic type is redundant.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 3 ---
 drivers/misc/habanalabs/common/habanalabs.h | 2 --
 drivers/misc/habanalabs/common/mmu/mmu.c    | 1 -
 drivers/misc/habanalabs/common/sysfs.c      | 2 --
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 2 +-
 5 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index cb8ecc17bba1..3ea1ee1ec8ef 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -748,9 +748,6 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi2_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI2", sizeof(hdev->asic_name));
 		break;
-	case ASIC_GAUDI2_SEC:
-		gaudi2_set_asic_funcs(hdev);
-		strscpy(hdev->asic_name, "GAUDI2 SEC", sizeof(hdev->asic_name));
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bfaaa9daa750..7d191f388953 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1192,7 +1192,6 @@ struct hl_dec {
  * @ASIC_GAUDI: Gaudi device (HL-2000).
  * @ASIC_GAUDI_SEC: Gaudi secured device (HL-2000).
  * @ASIC_GAUDI2: Gaudi2 device.
- * @ASIC_GAUDI2_SEC: Gaudi2 secured device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
@@ -1200,7 +1199,6 @@ enum hl_asic_type {
 	ASIC_GAUDI,
 	ASIC_GAUDI_SEC,
 	ASIC_GAUDI2,
-	ASIC_GAUDI2_SEC,
 };
 
 struct hl_cs_parser;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 589179f8cd41..67d3e70cf571 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -635,7 +635,6 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 		hl_mmu_v1_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		break;
 	case ASIC_GAUDI2:
-	case ASIC_GAUDI2_SEC:
 		/* MMUs in Gaudi2 are always host resident */
 		hl_mmu_v2_hr_set_funcs(hdev, &hdev->mmu_func[MMU_HR_PGT]);
 		break;
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 36e9814139d1..c924fc994bd9 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -248,8 +248,6 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI2:
 		str = "GAUDI2";
 		break;
-	case ASIC_GAUDI2_SEC:
-		str = "GAUDI2 SEC";
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 22f5445fe71c..03f8cf9bb136 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -3969,7 +3969,7 @@ static void gaudi2_init_firmware_loader(struct hl_device *hdev)
 	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
 	fw_loader->dram_bar_id = DRAM_BAR_ID;
 
-	if (hdev->asic_type == ASIC_GAUDI2 || hdev->asic_type == ASIC_GAUDI2_SEC)
+	if (hdev->asic_type == ASIC_GAUDI2)
 		fw_loader->cpu_timeout = GAUDI2_CPU_TIMEOUT_USEC;
 	else /* ASIC_GAUDI2_FPGA */
 		fw_loader->cpu_timeout = GAUDI2_FPGA_CPU_TIMEOUT;
-- 
2.25.1

