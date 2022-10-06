Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09F5F6285
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJFIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJFIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF2923F8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6EC9618A9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4ECC433B5;
        Thu,  6 Oct 2022 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044606;
        bh=XP1Q0fsPmNxynEtZKDS6Qpih0eeE9b5zftsLB0wPzCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJ6NL+5lHMzyL8HCPhoGCSYolsPcvwy1001/Kz1h5IIBdubKmEiBPjGcwOpSd7yj8
         ykOpuAklA70Wwu6OkyN9rx13e+xhSo8pUcY1TxCrla1BsPstmT2AktmAmzaENthKbp
         7OMd1Ey1e+8A9BryySVBN8v7C1qDfEwOgsyZevaiWZTzFe1JMNmuQaRQLPvN87p/sd
         4uFkOlMF+twT2/m6jlxZAqP/32gkzfI+ZS+EAWXGv/Mg8pzkMmZqSzRTWK8EZH3fR6
         cQValT0Y4/7EL5190RGbQxOqzNS6HKkX59ZtTnqvq6Q4lisKvuRyjdMVZHYU/XM6sF
         i12Udg0y+oYuA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 10/13] habanalabs: handle HBM MMU when capturing page fault data
Date:   Thu,  6 Oct 2022 11:23:05 +0300
Message-Id: <20221006082308.1266716-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

In case of HBM MMU page fault, capture its relevant mappings.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 29 ++++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e9b373a8cdad..b8b32285720d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2273,15 +2273,20 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 			num_of_engines * sizeof(u16));
 	hdev->captured_err_info.razwi.flags = flags;
 }
-static void hl_capture_user_mappings(struct hl_device *hdev)
+static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 {
 	struct page_fault_info *pgf_info = &hdev->captured_err_info.pgf_info;
+	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	struct hl_vm_hash_node *hnode;
 	struct hl_userptr *userptr;
+	enum vm_type *vm_type;
 	struct hl_ctx *ctx;
 	u32 map_idx = 0;
 	int i;
 
+	/* Reset previous session count*/
+	pgf_info->num_of_user_mappings = 0;
+
 	ctx = hl_get_compute_ctx(hdev);
 	if (!ctx) {
 		dev_err(hdev->dev, "Can't get user context for user mappings\n");
@@ -2290,7 +2295,7 @@ static void hl_capture_user_mappings(struct hl_device *hdev)
 
 	mutex_lock(&ctx->mem_hash_lock);
 	hash_for_each(ctx->mem_hash, i, hnode, node)
-	pgf_info->num_of_user_mappings++;
+		pgf_info->num_of_user_mappings++;
 
 	if (!pgf_info->num_of_user_mappings)
 		goto finish;
@@ -2300,17 +2305,25 @@ static void hl_capture_user_mappings(struct hl_device *hdev)
 	 */
 	vfree(pgf_info->user_mappings);
 	pgf_info->user_mappings =
-			vmalloc(pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping));
+			vzalloc(pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping));
 	if (!pgf_info->user_mappings) {
 		pgf_info->num_of_user_mappings = 0;
 		goto finish;
 	}
 
 	hash_for_each(ctx->mem_hash, i, hnode, node) {
-		userptr = hnode->ptr;
-		pgf_info->user_mappings[map_idx].dev_va = hnode->vaddr;
-		pgf_info->user_mappings[map_idx].size = userptr->size;
-		map_idx++;
+		vm_type = hnode->ptr;
+		if ((*vm_type == VM_TYPE_USERPTR) && (is_pmmu)) {
+			userptr = hnode->ptr;
+			pgf_info->user_mappings[map_idx].dev_va = hnode->vaddr;
+			pgf_info->user_mappings[map_idx].size = userptr->size;
+			map_idx++;
+		} else if ((*vm_type == VM_TYPE_PHYS_PACK) && (!is_pmmu)) {
+			phys_pg_pack = hnode->ptr;
+			pgf_info->user_mappings[map_idx].dev_va = hnode->vaddr;
+			pgf_info->user_mappings[map_idx].size = phys_pg_pack->total_size;
+			map_idx++;
+		}
 	}
 finish:
 	mutex_unlock(&ctx->mem_hash_lock);
@@ -2326,5 +2339,5 @@ void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is
 	hdev->captured_err_info.pgf_info.pgf.timestamp = ktime_to_ns(ktime_get());
 	hdev->captured_err_info.pgf_info.pgf.addr = addr;
 	hdev->captured_err_info.pgf_info.pgf.engine_id = eng_id;
-	hl_capture_user_mappings(hdev);
+	hl_capture_user_mappings(hdev, is_pmmu);
 }
-- 
2.25.1

