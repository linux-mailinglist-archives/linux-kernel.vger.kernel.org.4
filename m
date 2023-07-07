Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8B74AE92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGGKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjGGKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252B2119
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66872d4a141so1314841b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724687; x=1691316687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsMt13COde274ttCMoaZF2YE95cjQIf4f286siNaW/E=;
        b=XtBGxnqToLGpm+wz6UZHE9Z3Yyxmjqg7q/72evlzQgOrt67p/JLRMjJAMrFv64XiNW
         ZfNIFHx8T6s60FA+P6V7/qQ/4y1QQs0E/n5KE/7dmVz96wUjBNbODxKCxTfFaJ9jLt2H
         laFNuDh3JK1SqIMoLaYkBZW1pM75vCISZxsvdxkPotXveDzGUwaBGWVWnIyP7Z0I7RCR
         zgII0JY9Fk1buneVD/uJGvPj4QSx+CBBeH9ivoDSr3ms/fjZUANEfKwaROGQINSOs2Xk
         zQlMEdoB+G418aYhQibOq/MhMhBWs4Saqurzw5bMTc1VTdZiJ693s6MQD+BFBUaoxYYe
         3QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724687; x=1691316687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsMt13COde274ttCMoaZF2YE95cjQIf4f286siNaW/E=;
        b=gZfyM/iH54zwli1xNpDQ6RstQnkWpz5JQcXrtE7Y3D8YgH4H0OKuB/H9yc/2Ps+zej
         xVDC17tWUkJOfpt6WVInwzwvvn/R4m2Su29H2G+rDcQmRO1ayWSK1TX1NLAmHO8zT5fR
         xAYLyO3mdMszs3nJ4T6m2sRWyrPVlyMgkV0I8IfAP2GNjYeXENXCfBtWiZcSNlcEvAPr
         5LZMAdQbvis7gf96gfeJbQf6BHjgnDydOrdDQd7YtSmF0NF9UuRcnuzbpMhmTk7aREKX
         reNofrHijjnvUyebpSA1ig+glF6cSoUd8L1F+roqpO7onbHHxSFY4zMqM0IRVwqK3oMN
         hsFw==
X-Gm-Message-State: ABy/qLbKEDbEKqSMNMpgElnKmBcksd9q+daL5+MiXL2GjxumSWGE/3JG
        bIYWBYJMYdAibZFLivURxH+5ng==
X-Google-Smtp-Source: APBJJlF0ImEh0lWSBujHgiGl3Eem6V0jD/6IH2Qzj54mjY4tPYvtVOMeeD3PwEtW49AKgrd4d9B+5A==
X-Received: by 2002:a05:6a00:c89:b0:668:711a:7d93 with SMTP id a9-20020a056a000c8900b00668711a7d93mr4048082pfv.19.1688724686695;
        Fri, 07 Jul 2023 03:11:26 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:26 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 5/8] maple_tree: make mas_validate_limits() check root node and node limit
Date:   Fri,  7 Jul 2023 18:10:54 +0800
Message-Id: <20230707101057.29326-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

Update mas_validate_limits() to check root node, check node limit pivot
if there is enough room for it to exist and check data_end. Remove the
check for child existence as it is done in mas_validate_child_slot().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 88d6373f37b0..e84a042b6d84 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7148,26 +7148,15 @@ static void mas_validate_limits(struct ma_state *mas)
 	void __rcu **slots = ma_slots(mte_to_node(mas->node), type);
 	unsigned long *pivots = ma_pivots(mas_mn(mas), type);
 
-	/* all limits are fine here. */
-	if (mte_is_root(mas->node))
-		return;
-
 	for (i = 0; i < mt_slots[type]; i++) {
 		unsigned long piv;
 
 		piv = mas_safe_pivot(mas, pivots, i, type);
 
-		if (!piv && (i != 0))
-			break;
-
-		if (!mte_is_leaf(mas->node)) {
-			void *entry = mas_slot(mas, slots, i);
-
-			if (!entry)
-				pr_err("%p[%u] cannot be null\n",
-				       mas_mn(mas), i);
-
-			MT_BUG_ON(mas->tree, !entry);
+		if (!piv && (i != 0)) {
+			pr_err("Missing node limit pivot at %p[%u]",
+			       mas_mn(mas), i);
+			MAS_WARN_ON(mas, 1);
 		}
 
 		if (prev_piv > piv) {
@@ -7190,6 +7179,13 @@ static void mas_validate_limits(struct ma_state *mas)
 		if (piv == mas->max)
 			break;
 	}
+
+	if (mas_data_end(mas) != i) {
+		pr_err("node%p: data_end %u != the last slot offset %u\n",
+		       mas_mn(mas), mas_data_end(mas), i);
+		MT_BUG_ON(mas->tree, 1);
+	}
+
 	for (i += 1; i < mt_slots[type]; i++) {
 		void *entry = mas_slot(mas, slots, i);
 
-- 
2.20.1

