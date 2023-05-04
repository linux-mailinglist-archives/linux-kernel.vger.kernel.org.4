Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B266F6334
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 05:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEDDPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 23:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEDDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 23:14:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46926A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 20:14:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so33813a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 20:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683170074; x=1685762074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbPYIto4VB8PDltW6IF9xK2OGAqqGXQQrWkkItyQ7bQ=;
        b=jAriokYZi5Z7BExhmGU/HVnBTY/QZkyPLl/xu3NBLVCCyKB7e1mTttjDqgtmTMubuF
         E/1cwMS+TZ6Ny7VLFC1Ft7NSrpmy16F/ZpEfiLhAWBTku6jfFpCLnXiBZbXUJAwW17HW
         5k8Z07uMYaksRmxDRBAlpSHvhKeUHZii8et2CC1KEMYxmLSZfs/ApniiKpb3sdVeAvk/
         qfYgQzLiVEjzntB4AwcJxpX/nbX3qC2mnb4UfbJIjADYjzyEJcTi/ZtGlvW6BHY0ODPu
         ZDmlaoTeyUPKBysuz7heK1A3v5QfP8W6mesTLdtOyG5Yx3unnIoJc4kAQue75nRX731q
         FicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683170074; x=1685762074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbPYIto4VB8PDltW6IF9xK2OGAqqGXQQrWkkItyQ7bQ=;
        b=TAk7PmfwxiAfrp4crUGy2/bh2K0EPch4zB5rlH3RjpR/orokieHtvmeeJ6YLB1dRM5
         F6xBdojHGjo+lnzC4Ztri845DamcESwpTs/m5BApH5SamAl9pXKo5yiFzizpBcV7QWVi
         HeknUq9hVaBmgEqvRBicuRisRIGgEHu8mT0JA02TNpvdQf98fzQd282oIRWbDXd1bL4b
         vhi6u2nO+EAXrVehehLseOUB8YNMzWi3gVmr3aVog61Tzw2O1RC97DujEFgGDsfQNVc/
         3DuQnpGrePqRmAiK0wHsrodbyZ6MHJGCHpux9sisl4AZthvN/N7XLAoqr16a3kXORMTL
         5b+Q==
X-Gm-Message-State: AC+VfDy+pxUvjDg8UxES5hYEp2UZYvlD0NiJv0iOL6R9qPNrO0zjr7bd
        thb3O1isAKz8JTMCZ+DgBsCQzw==
X-Google-Smtp-Source: ACHHUZ6r8kN3MgA8b2V+WIU5T8RQV5qChxp0w8/DRs6oq/rJE4yt3Jai4GFOqdSMEHo8pxqoP7Vc5w==
X-Received: by 2002:a17:90a:7565:b0:247:42bf:380e with SMTP id q92-20020a17090a756500b0024742bf380emr837685pjk.4.1683170074005;
        Wed, 03 May 2023 20:14:34 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090aba9400b0023b4d4ca3a9sm10160834pjr.50.2023.05.03.20.14.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 May 2023 20:14:33 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] maple_tree: Fix potential out-of-bounds access in mas_wr_end_piv()
Date:   Thu,  4 May 2023 11:14:22 +0800
Message-Id: <20230504031422.47506-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the pivots array may be out of bounds. Fix it by changing the
code to ensure that the index of the pivots does not go out of bounds.
It is difficult to assess user-visible impact.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 110a36479dced..5a49327444d76 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4263,11 +4263,13 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 {
-	while ((wr_mas->mas->last > wr_mas->end_piv) &&
-	       (wr_mas->offset_end < wr_mas->node_end))
-		wr_mas->end_piv = wr_mas->pivots[++wr_mas->offset_end];
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
 
-	if (wr_mas->mas->last > wr_mas->end_piv)
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
 		wr_mas->end_piv = wr_mas->mas->max;
 }
 
@@ -4424,7 +4426,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas->end_piv = wr_mas->r_max;
 	mas_wr_end_piv(wr_mas);
 
 	if (!wr_mas->entry)
-- 
2.20.1

