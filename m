Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC97066B02C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjAOJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjAOJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:40:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E456C167
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:40:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E0060C6E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 09:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E198C433EF;
        Sun, 15 Jan 2023 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673775637;
        bh=tQzNZbpetX3J4fWHQu3mEiBGxmL7g/pgTL4aro/R18I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rn2bghSjkINX34iAROb/oXoYK7IUV6bthpcwdJoLhvwpU7T2yRbPOeTFBYZzGJal5
         kKeqXEFWGUCy+ikCW3EV9cvdVitQn/CHAgV2+cALF6EfSX531tb1CIjyfhYsRBwIZN
         E7ELZU88POwQ7bX3DahQ4vZqknh0RjnlDcREm6DCqpYRmmOMEJmjEWCtPfvKVn/v3c
         5pSj2votBNpoy/MHZa8SW/L4ddkuLax5GWkpSu3R33MT2TdQAgTRq8vYteEpmQOX84
         D9tqVhzjJ4Rx+SwnKgUgpOYLc1oZPQHDqHoOVTAF/Hmkd8FhEFn/d2YYrRM+7ns4eq
         n+o05NvkXW3gQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 5/5] habanalabe/gaudi2: add cfg base when displaying razwi addresses
Date:   Sun, 15 Jan 2023 11:40:26 +0200
Message-Id: <20230115094026.289766-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230115094026.289766-1-ogabbay@kernel.org>
References: <20230115094026.289766-1-ogabbay@kernel.org>
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

Captured addresses of low b/w razwi information contains only the
offset from the cfg base. To make it more user readable, add the cfg
base to it.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 32a824766f24..8c0cbd3b4a0c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7137,23 +7137,24 @@ static void gaudi2_razwi_rr_lbw_shared_printf_info(struct hl_device *hdev,
 			u64 rtr_mstr_if_base_addr, bool is_write, char *name,
 			enum gaudi2_engine_id id, u64 *event_mask)
 {
-	u32 razwi_addr, razwi_xy;
+	u64 razwi_addr = CFG_BASE;
+	u32 razwi_xy;
 	u16 eng_id = id;
 	u8 rd_wr_flag;
 
 	if (is_write) {
-		razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI);
+		razwi_addr += RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI);
 		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AW_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_WRITE;
 	} else {
-		razwi_addr = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
+		razwi_addr += RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI);
 		razwi_xy = RREG32(rtr_mstr_if_base_addr + RR_SHRD_LBW_AR_RAZWI_XY);
 		rd_wr_flag = HL_RAZWI_READ;
 	}
 
 	hl_handle_razwi(hdev, razwi_addr, &eng_id, 1, rd_wr_flag | HL_RAZWI_LBW, event_mask);
 	dev_err_ratelimited(hdev->dev,
-				"%s-RAZWI SHARED RR LBW %s error, mstr_if 0x%llx, captured address 0x%x Initiator coordinates 0x%x\n",
+				"%s-RAZWI SHARED RR LBW %s error, mstr_if 0x%llx, captured address 0x%llX Initiator coordinates 0x%x\n",
 				name, is_write ? "WR" : "RD", rtr_mstr_if_base_addr, razwi_addr,
 						razwi_xy);
 }
@@ -7665,19 +7666,19 @@ static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u
 							u64 *event_mask)
 {
 	u16 engines[HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR], num_of_eng;
-	u32 razwi_addr;
+	u64 razwi_addr = CFG_BASE;
 	u8 rd_wr_flag;
 
 	num_of_eng = gaudi2_get_razwi_initiators(rtr_id, &engines[0]);
 
 	if (is_write) {
-		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_ADDR);
+		razwi_addr += RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_ADDR);
 		rd_wr_flag = HL_RAZWI_WRITE;
 
 		/* Clear set indication */
 		WREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AW_SET, 0x1);
 	} else {
-		razwi_addr = RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_ADDR);
+		razwi_addr += RREG32(rtr_ctrl_base_addr + DEC_RAZWI_LBW_AR_ADDR);
 		rd_wr_flag = HL_RAZWI_READ;
 
 		/* Clear set indication */
@@ -7687,7 +7688,7 @@ static void gaudi2_razwi_unmapped_addr_lbw_printf_info(struct hl_device *hdev, u
 	hl_handle_razwi(hdev, razwi_addr, &engines[0], num_of_eng, rd_wr_flag | HL_RAZWI_LBW,
 			event_mask);
 	dev_err_ratelimited(hdev->dev,
-		"RAZWI PSOC unmapped LBW %s error, rtr id %u, address %#x\n",
+		"RAZWI PSOC unmapped LBW %s error, rtr id %u, address 0x%llX\n",
 		is_write ? "WR" : "RD", rtr_id, razwi_addr);
 
 	dev_err_ratelimited(hdev->dev,
-- 
2.25.1

