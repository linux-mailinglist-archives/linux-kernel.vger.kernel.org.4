Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A171FB64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjFBHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjFBHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:54:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16D1A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:54:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b034ca1195so8834545ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685692447; x=1688284447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qN5IJXyn5VJIlxZlQKMd5j0PC5dVod7lJR5xLLQiyk=;
        b=DN+DM58DdgoV9FCQEn2L2Ee0umqXsCmAlN/5VriCaaB3AbhKoop5Gxcp9Mz2St/Flu
         GEJtT6c5cPrGmIKzKZFsDGC/Zp2gPrPeOUYxUhiBpGnJsxx75efukFTRI9nBpjus/DHi
         sFI5/mVTBP5NpxGZ3JNoOi5lxQUJA+fMaSenPlpydHDWok7Lha4W6mLuLQyT1VVH0GVF
         XdqujabuPB+y1/u2P5cZWYSgfQhrkHhJ9ljHkObKZlBi4SFou+Q/+5qqA/tXP9AUK8/J
         i5kHx4DFaxFx57TGO14gjmdCpBNLQLRT+omnN2hYxwTA6uvr8Bakku9hvmKrMSeRAWzg
         V0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685692447; x=1688284447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qN5IJXyn5VJIlxZlQKMd5j0PC5dVod7lJR5xLLQiyk=;
        b=JfoGjSc4y0kJ9yZZn2qI2MtMwt+NBkOIg5OkpgKNxLKBvrQbZUG+0GX6XM0+0nZF0J
         DwQ+qVMy+5SCb1DFp1oCFTGtIOhVu2cxt24Ul7g/am6Yf7MMrBBAZJoAw9vAuiwCFWPc
         krL/Ss8ArQdPzdOhFdnQFHeBKdLJqtvuXcRR4VTsGshoNfehFGDZiZQXlFi8OapJd/OO
         Fz7H3K2/lQ0XJVefH+27UdZWqJJxuSqok/9ojuPtBj+P0J+pqa7H3d23SS4545lEEbFB
         ijek6PZoFOMpvkZD6UJGrGCLuBiETFGeFi4tlVBWSw/Te2E7BzFTFPLOcQX6ywqmpTaZ
         68kA==
X-Gm-Message-State: AC+VfDxaLTiQpywKShqXfaZJmaUwjOXQ5Gp5gzFWxMCzw7CPuU5ulJnE
        L78w6aN9X3OOOdg1K464v/d9Eg==
X-Google-Smtp-Source: ACHHUZ53ehwSk4haaBXFMX05NoPqN+dnPkMcH1Lo4l+C4lW9evtditALWlWWfyKyMQpT3i68UvlN5w==
X-Received: by 2002:a17:902:da90:b0:1b1:a4e2:a2ce with SMTP id j16-20020a170902da9000b001b1a4e2a2cemr834040plx.20.1685692446988;
        Fri, 02 Jun 2023 00:54:06 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ac94b33ab1sm636572pli.304.2023.06.02.00.54.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Jun 2023 00:54:06 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/2] maple_tree: add a fast path case in mas_wr_slot_store()
Date:   Fri,  2 Jun 2023 15:53:53 +0800
Message-Id: <20230602075353.5917-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
References: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the new range overwrites three ranges and does not touch the
boundaries on both sides, the number of entries will not be increased,
so we can just update the pivots as a fast path. However, it may
introduce potential risks in RCU mode (although it can pass the test),
because it updates two pivots. We only enable it in non-RCU mode for now.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cfd9fad308a2..ec82441ca3e8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4100,23 +4100,32 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
 	unsigned char offset = mas->offset;
+	void __rcu **slots = wr_mas->slots;
 	bool gap = false;
 
-	if (wr_mas->offset_end - offset != 1)
-		return false;
-
-	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
-	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
+	gap |= !mt_slot_locked(mas->tree, slots, offset);
+	gap |= !mt_slot_locked(mas->tree, slots, offset + 1);
 
-	if (mas->index == wr_mas->r_min) {
-		/* Overwriting the range and over a part of the next range. */
-		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
-		wr_mas->pivots[offset] = mas->last;
-	} else {
-		/* Overwriting a part of the range and over the next range */
-		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
+	if (wr_mas->offset_end - offset == 1) {
+		if (mas->index == wr_mas->r_min) {
+			/* Overwriting the range and a part of the next one */
+			rcu_assign_pointer(slots[offset], wr_mas->entry);
+			wr_mas->pivots[offset] = mas->last;
+		} else {
+			/* Overwriting a part of the range and the next one */
+			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
+			wr_mas->pivots[offset] = mas->index - 1;
+			mas->offset++; /* Keep mas accurate. */
+		}
+	} else if (!mt_in_rcu(mas->tree)) {
+		/* Overwriting three ranges, but don't touch the boundaries */
+		gap |= !mt_slot_locked(mas->tree, slots, offset + 2);
+		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
 		wr_mas->pivots[offset] = mas->index - 1;
+		wr_mas->pivots[offset + 1] = mas->last;
 		mas->offset++; /* Keep mas accurate. */
+	} else {
+		return false;
 	}
 
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-- 
2.20.1

