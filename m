Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04DD60F345
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiJ0JK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiJ0JKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB6F10059
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09439B8255B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E26C433D6;
        Thu, 27 Oct 2022 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861817;
        bh=dQF2+43kff3gQF+6a/Xx6YbAFvzuGAzfM4cCujcupLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z5KcJGJ438pv+d34ILDz0V04vC4I9oPn7Hmkz1CPuZVp3/KS86bdeE50TbOFOYcAo
         lg4joZa9GLUa0HVww7Y7CBEPM4jhwygoBRb7EUXxz9H9uV1SL0Zx3OeKCWCNMuX0Jh
         PGOmyI6m95dE8ghv/V9vqMb+e3aTUDI+2tnkurxzEwmY12p6m5fCks+Pq9zrIXWrDI
         FZMMb+iyWD9mx05rnD+7qgpdI3udnzTIQKyB0caKKT9QtE6wNLjpp0xAAjff+23xiB
         hL263s8UaSIY6cgH0SpsFGpBFB0+CxneWqHlO09dWk7XlohRR26A+qRGnoiZHr4Tel
         pv0md0Z6AK7uA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 04/15] habanalabs: fix user mappings calculation in case of page fault
Date:   Thu, 27 Oct 2022 12:09:56 +0300
Message-Id: <20221027091007.664797-4-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

As there are 2 types of user mappings, pmmu and hmmu, calculate
only the relevant mappings for the requested type.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0026fe42b3d2..0e88396744a1 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2305,8 +2305,13 @@ static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 	}
 
 	mutex_lock(&ctx->mem_hash_lock);
-	hash_for_each(ctx->mem_hash, i, hnode, node)
-		pgf_info->num_of_user_mappings++;
+	hash_for_each(ctx->mem_hash, i, hnode, node) {
+		vm_type = hnode->ptr;
+		if (((*vm_type == VM_TYPE_USERPTR) && is_pmmu) ||
+				((*vm_type == VM_TYPE_PHYS_PACK) && !is_pmmu))
+			pgf_info->num_of_user_mappings++;
+
+	}
 
 	if (!pgf_info->num_of_user_mappings)
 		goto finish;
-- 
2.25.1

