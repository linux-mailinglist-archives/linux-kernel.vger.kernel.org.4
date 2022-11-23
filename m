Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECCC63628E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiKWO6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbiKWO6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D74A04D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:58:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74DA8B8206A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B162C433D7;
        Wed, 23 Nov 2022 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215488;
        bh=0FpoG7TNgKpMIOeeiZ2LDMQ1UkGGWvOoskQGRTo+O8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn103SN13FL6X3tMRiwTcV+3EQ3XZkU9x3OixrMnfh1rLW2ljkFZ8DXfPyhWFrCBg
         3NyxGWYVvB912M9LroJeaodoALHi+9KGbtHSqHNM6cA1da3ZiDyJwSqEUkPFF6aUFd
         mhTdexZK6FOlOcm5fuWkObqnYjc1xKww4q/k+G7L3IQbb8XynRS0vOBPdYs0EYBG+i
         l7W3eOSFHs9ikpbhXXTx5SeS3okSSO7RrzK7mhIftc8dM3YBeNRc+Vl1Z5VjWT4S0M
         TvE4Gm1pidouDEIaM0M19CN2vWLGAr5j/ps4CDv7tUCc+HYyuT2iQ1fPxfhcpd7tK5
         UFnt6qvYmJmmA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 2/8] habanalabs: add RMWREG32_SHIFTED to set a val within a mask
Date:   Wed, 23 Nov 2022 16:57:55 +0200
Message-Id: <20221123145801.542029-2-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

This is similar to RMWREG32, but the given 'val' is already shifted
according to the mask.
This allows several 'ORed' vals and masks to be set at once
The patch also fixes wrong usage of RMWREG32 by replacing
it with RMWREG32_SHIFTED

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 10 +++-------
 drivers/misc/habanalabs/gaudi2/gaudi2.c     |  6 +++---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e7f89868428d..0329a0980bb7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2498,13 +2498,9 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 #define WREG32_AND(reg, and) WREG32_P(reg, 0, and)
 #define WREG32_OR(reg, or) WREG32_P(reg, or, ~(or))
 
-#define RMWREG32(reg, val, mask)				\
-	do {							\
-		u32 tmp_ = RREG32(reg);				\
-		tmp_ &= ~(mask);				\
-		tmp_ |= ((val) << __ffs(mask));			\
-		WREG32(reg, tmp_);				\
-	} while (0)
+#define RMWREG32_SHIFTED(reg, val, mask) WREG32_P(reg, val, ~(mask))
+
+#define RMWREG32(reg, val, mask) RMWREG32_SHIFTED(reg, (val) << __ffs(mask), mask)
 
 #define RREG32_MASK(reg, mask) ((RREG32(reg) & mask) >> __ffs(mask))
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index a33a9072fca4..e793fb2bdcbe 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -5052,7 +5052,7 @@ static int gaudi2_pci_mmu_init(struct hl_device *hdev)
 	mmu_base = mmPMMU_HBW_MMU_BASE;
 	stlb_base = mmPMMU_HBW_STLB_BASE;
 
-	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
+	RMWREG32_SHIFTED(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
 		(0 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_HOP_SHIFT) |
 		(5 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_SHIFT) |
 		(4 << PMMU_HBW_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_SHIFT) |
@@ -5068,7 +5068,7 @@ static int gaudi2_pci_mmu_init(struct hl_device *hdev)
 
 	if (PAGE_SIZE == SZ_64K) {
 		/* Set page sizes to 64K on hop5 and 16M on hop4 + enable 8 bit hops */
-		RMWREG32(mmu_base + MMU_STATIC_MULTI_PAGE_SIZE_OFFSET,
+		RMWREG32_SHIFTED(mmu_base + MMU_STATIC_MULTI_PAGE_SIZE_OFFSET,
 			FIELD_PREP(DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP5_PAGE_SIZE_MASK, 4) |
 			FIELD_PREP(DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK, 3) |
 			FIELD_PREP(
@@ -5116,7 +5116,7 @@ static int gaudi2_dcore_hmmu_init(struct hl_device *hdev, int dcore_id,
 	RMWREG32(mmu_base + MMU_STATIC_MULTI_PAGE_SIZE_OFFSET, 5 /* 64MB */,
 			MMU_STATIC_MULTI_PAGE_SIZE_HOP4_PAGE_SIZE_MASK);
 
-	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
+	RMWREG32_SHIFTED(stlb_base + STLB_HOP_CONFIGURATION_OFFSET,
 		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_HOP_MASK, 0) |
 		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_SMALL_P_MASK, 3) |
 		FIELD_PREP(DCORE0_HMMU0_STLB_HOP_CONFIGURATION_FIRST_LOOKUP_HOP_LARGE_P_MASK, 3) |
-- 
2.25.1

