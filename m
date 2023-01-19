Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380C5673596
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjASKel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjASKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9357AA2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1717B6150F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96140C433D2;
        Thu, 19 Jan 2023 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124426;
        bh=zCn0+FxOgluTzh9mp8AEc04/dR7sl4nBKH1sy19i2qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVH9D75RSaqahVubv4DuNEKdORjhjPAPXEASnIYsPtVT+MWm0w9gh3I1JOCaQESDu
         HJa7cK1G5X8YvRNV59+mKrni/JaswuJKUESXcTcHRAmuqw4Fk25YFLVsjtMfGLhZiB
         zh9BuF9tj44UEc6Q8MCbZ7faCVmvccX8xg2C1X+bFoNfyRnvsr6ZneZ/4rUt0GtZ9g
         +ityftW2XOMFbyF/T0GRwnqYVQ7hESEgTxhNaE4jSPNZGnDBuEx+JXc5lYZsJVKdpq
         CnUHf2H5IpJZbnFHmSCZW9qds0nYelVZD2j7nHVqX9IvtkrMKBcuMYIjTCV+8to9HV
         Gw1UbQsmNpMCw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 02/10] habanalabs/gaudi2: print page fault axi transaction id
Date:   Thu, 19 Jan 2023 12:33:31 +0200
Message-Id: <20230119103339.718430-2-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

AXI transaction id holds information about the initiator which caused
the page fault. In the future it will be translated automatically by
driver to an initiator name.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 8c0cbd3b4a0c..72e08c1eae22 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -8287,7 +8287,7 @@ static int gaudi2_handle_hif_fatal(struct hl_device *hdev, u16 event_type, u64 i
 static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool is_pmmu,
 					u64 *event_mask)
 {
-	u32 valid, val;
+	u32 valid, val, axid_l, axid_h;
 	u64 addr;
 
 	valid = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_ACCESS_PAGE_ERROR_VALID));
@@ -8300,8 +8300,11 @@ static void gaudi2_handle_page_error(struct hl_device *hdev, u64 mmu_base, bool
 	addr <<= 32;
 	addr |= RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE_VA));
 
-	dev_err_ratelimited(hdev->dev, "%s page fault on va 0x%llx\n",
-				is_pmmu ? "PMMU" : "HMMU", addr);
+	axid_l = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_FAULT_ID_LSB));
+	axid_h = RREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_FAULT_ID_MSB));
+
+	dev_err_ratelimited(hdev->dev, "%s page fault on va 0x%llx, transaction id 0x%llX\n",
+				is_pmmu ? "PMMU" : "HMMU", addr, ((u64)axid_h << 32) + axid_l);
 	hl_handle_page_fault(hdev, addr, 0, is_pmmu, event_mask);
 
 	WREG32(mmu_base + MMU_OFFSET(mmDCORE0_HMMU0_MMU_PAGE_ERROR_CAPTURE), 0);
-- 
2.25.1

