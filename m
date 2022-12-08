Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A3647294
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLHPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLHPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866EE7B55F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9019461F80
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDBAC433C1;
        Thu,  8 Dec 2022 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512444;
        bh=hRUULdwh0l7BEJjOmnNp0uUoNa+TpzM9RCP8BRzI1PM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj50EHYBf/MVDPCuuge4TfzxjTEU6HVtHZazQE5F3vO6O6VgasIIYDqUCZPLhguXV
         Wynzvg/2/BHxkM9zZBMfsxQrIY9I/DE5wnf54fTHPPX5y/WKBR/Kaq8PHTXWWSqG9T
         JCkI6d+JkbzViD/uHETkiFb6SoRUApkmHUfKkWD1Uk9llXG5DwtLDeIs8Dd46IIpDo
         z3YgIwCsuxOsw6wqU1VUVxF/Pum36MwbhJY22gcBsCfF62RhOiuiASGNHRMGjBQPNl
         7BdgaGckNQpjPU1Q/xkXh6AoVdEag+0p8F/JWGqtLrPd5KEKdk3aajrnQINUDHbhv6
         XtOrrxSZfOneg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/26] habanalabs: use dev_dbg() when hl_mmap_mem_buf_get() fails
Date:   Thu,  8 Dec 2022 17:13:31 +0200
Message-Id: <20221208151350.1833823-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

As hl_mmap_mem_buf_get() is called also from IOCTLs which can have a
bad handle from user, modify the print for "no match to handle" to use
dev_dbg().
Calls to this function which are not dependent on user, already have an
error print when the function fails.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index e652db601f0e..92d20ed465b4 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -25,8 +25,7 @@ struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u64 handle)
 	buf = idr_find(&mmg->handles, lower_32_bits(handle >> PAGE_SHIFT));
 	if (!buf) {
 		spin_unlock(&mmg->lock);
-		dev_warn(mmg->dev,
-			 "Buff get failed, no match to handle %#llx\n", handle);
+		dev_dbg(mmg->dev, "Buff get failed, no match to handle %#llx\n", handle);
 		return NULL;
 	}
 	kref_get(&buf->refcount);
-- 
2.25.1

