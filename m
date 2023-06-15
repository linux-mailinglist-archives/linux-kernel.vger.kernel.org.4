Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B286731997
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245751AbjFONKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245160AbjFONKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:10:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5619123
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b5251e5774so916795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834647; x=1689426647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZGxNZsIpnMBQhUNXCsRmhhDB1lIsi8lU2hwxHUwfjk=;
        b=bB1QL+mmf56nkMSsfv598qN2fllo5bMGUfYXT445+ukRmpKPsuk9VT0wAtXq00tXeY
         WeK6VnfC6+czbq/PAw1qbKx7hPjEooLS3/e1llNQeBCEMEXRS3MUgv6jIThk9gqloXRU
         BsnD43Jj3AIUQNECtE2YygfsbaSk9n7L1Bh6WyE0EiLSeyCxZFUvNDtPlPA0X8aPjihM
         RATB0sV7gU9LvQ64TF2MqqfgGgXt9z292CVR1zak0IJpJq+TIO1K7agY+R8kNbQ+AGBP
         eaBkO0j8yCfFJSwgITxQoJek7mvOUQ92gsgUJAtfhMEvls0y8GeNKpYUifxw40BfhDrj
         UAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834647; x=1689426647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZGxNZsIpnMBQhUNXCsRmhhDB1lIsi8lU2hwxHUwfjk=;
        b=bxc5LxB7vTM0RO/5SqGwPgO+UG0srM6nUssKHdWowD0il1R3Tq4grX6+AonTKlNIWc
         EWwEzVpSSdvPp/lb3WmT2542P1hqgAReb1/mKeIihUTo9kZF37lzGQ+euRnRP52krvZc
         wEbR0Rwe0JfWIepDPOU3E4bThGF/ceZesqOyV3SEvb0/+hQKQ/CQOMb6XI2hjYFn3KwN
         UGfIFXhp1hdqIY6tZYqsWqjCWtBNWSbxtT41sbwkwtFrXeBj3w5US+VrbfQb8sz2+YDR
         hCfRe0HnUAIaqlLJz+sPlGi4ojLww2P2K0J2G2ARQK6mkcD61+kO7g0VW5uNaLEHDI+I
         0baQ==
X-Gm-Message-State: AC+VfDwZ1+zgX3KXMj16OuQghg9MQkFS/9RA7rgw99I6zvWjoBHTCiBx
        LJofBhzcCYTC0RwtllMUECkDNx3EZ/Pu4WVYFWA=
X-Google-Smtp-Source: ACHHUZ77QznaSKTOxUniU+ofsuaOVvEBwnEahJwvt9I8exZIRYa7o7wYFzGK+enMy1u1bh5l88rW+w==
X-Received: by 2002:a17:902:c20d:b0:1b5:253f:d05f with SMTP id 13-20020a170902c20d00b001b5253fd05fmr279675pll.29.1686834647381;
        Thu, 15 Jun 2023 06:10:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:46 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 6/8] maple_tree: update mt_validate()
Date:   Thu, 15 Jun 2023 21:08:57 +0800
Message-Id: <20230615130859.21858-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using mas_first_entry() to find the leftmost leaf, use a
simple loop instead. Remove an unneeded check for root node. To make
the error message more accurate, check pivots first and then slots,
because checking slots depend on the node limit pivot to break the loop.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6c9b62e41605..becb4c224e57 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7256,21 +7256,22 @@ void mt_validate(struct maple_tree *mt)
 	if (!mas_searchable(&mas))
 		goto done;
 
-	mas_first_entry(&mas, mas_mn(&mas), ULONG_MAX, mte_node_type(mas.node));
+	while (!mte_is_leaf(mas.node))
+		mas_descend(&mas);
+
 	while (!mas_is_none(&mas)) {
 		MAS_WARN_ON(&mas, mte_dead_node(mas.node));
-		if (!mte_is_root(mas.node)) {
-			end = mas_data_end(&mas);
-			if (MAS_WARN_ON(&mas,
-					(end < mt_min_slot_count(mas.node)) &&
-					(mas.max != ULONG_MAX))) {
-				pr_err("Invalid size %u of %p\n", end,
-				       mas_mn(&mas));
-			}
+		end = mas_data_end(&mas);
+		if (MAS_WARN_ON(&mas,
+				(end < mt_min_slot_count(mas.node)) &&
+				(mas.max != ULONG_MAX))) {
+			pr_err("Invalid size %u of %p\n", end,
+				mas_mn(&mas));
 		}
+
 		mas_validate_parent_slot(&mas);
-		mas_validate_child_slot(&mas);
 		mas_validate_limits(&mas);
+		mas_validate_child_slot(&mas);
 		if (mt_is_alloc(mt))
 			mas_validate_gaps(&mas);
 		mas_dfs_postorder(&mas, ULONG_MAX);
-- 
2.20.1

