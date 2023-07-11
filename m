Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26E74E591
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGKD4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGKDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B4E5C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b89b75dc1cso40859145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047710; x=1691639710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trWG5ZcTEhQeGdiIh695WKCYOeE3HbrZ9Lquw5Sy0DA=;
        b=RBwCD953n8uZsMTFBTHHBrqSeGPAwgTiNB4mn19QAWfXCNEYcpGV1kO3pwrVNg8yiO
         4ChpEv1ST7jhjL5P3juHp3AxjrYpZOoUZVhD2YQEdnop9cODo0HrY8a0kzrHUNaUIvkj
         O1spSqlg3rieSeSLBfw8jVSeQ+y/GqBPmyB5Avs2d2g6U18ZtSVO+yG2hZ8l0KZkCgPf
         9sjA0l8IF0bLaMPCEax3vXMEOqTK9Cbi/czByHRMN1o+xEe1N1f+PJx1K+l/9/PeL/cF
         /WpOb15CGoZm3QwOcSnNOf9bHQ47bs7GLBz7f6r8m2UpoVAIMjkZhz0huGnDN+G6zPf1
         oDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047710; x=1691639710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trWG5ZcTEhQeGdiIh695WKCYOeE3HbrZ9Lquw5Sy0DA=;
        b=LmK3u0j4pqpDSWkauYFSd+kh27Jm7LHXLDEOVQWQpYKDYQ+NTPHZ/YigeRrTw0recJ
         rukRUlLKMqa4gPmTYAXgaMrv2AgmdA7xNbdqhHCa30DrjZZ5yX5CoXoQDiLyQJziPmVZ
         rWiEcgGnkjTnp21wgfcUPcAKdlBmW0vP6k7QkQBkk1bPKd3aRPeo22621e37PI1mj6AJ
         smdrZ/cx5WBd3CgNdm9PDxGLPWtb8QONKgz1948bgzv3/VvOLXwaGf0DXge9Tj9aLOQN
         B+KYOcM9YhFRO8ygPuV4B+OgsJPyE4cLfJeLpyFVc6sCiuaG4tnfaDW+N0EqMHrWPwAs
         L25g==
X-Gm-Message-State: ABy/qLYxcPOtXS9kVa0YJoY1eSeH06CVCOV8Zm1+2HAb4tUoVaHNioAy
        OHHJigHkBDwzIzDtmwEY9oWCkw==
X-Google-Smtp-Source: APBJJlGAHImLe3JwZyPyDVH1VXMjy9vrBysT74mOvTPUwjlmymGLtnOZwnAIUkbTS+FLwMQi0gLuzg==
X-Received: by 2002:a17:903:2441:b0:1b8:a39e:ff4b with SMTP id l1-20020a170903244100b001b8a39eff4bmr26118175pls.32.1689047710631;
        Mon, 10 Jul 2023 20:55:10 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:10 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 4/8] maple_tree: fix mas_validate_child_slot() to check last missed slot
Date:   Tue, 11 Jul 2023 11:54:40 +0800
Message-Id: <20230711035444.526-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
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

Don't break the loop before checking the last slot. Also here check if
non-leaf nodes are missing children.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a5776fab1875..f750ebef595f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7119,11 +7119,12 @@ static void mas_validate_child_slot(struct ma_state *mas)
 
 	for (i = 0; i < mt_slots[type]; i++) {
 		child = mas_slot(mas, slots, i);
-		if (!pivots[i] || pivots[i] == mas->max)
-			break;
 
-		if (!child)
-			break;
+		if (!child) {
+			pr_err("Non-leaf node lacks child at %p[%u]\n",
+			       mas_mn(mas), i);
+			MT_BUG_ON(mas->tree, 1);
+		}
 
 		if (mte_parent_slot(child) != i) {
 			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
@@ -7138,6 +7139,9 @@ static void mas_validate_child_slot(struct ma_state *mas)
 			       mte_to_node(mas->node));
 			MT_BUG_ON(mas->tree, 1);
 		}
+
+		if (i < mt_pivots[type] && pivots[i] == mas->max)
+			break;
 	}
 }
 
-- 
2.20.1

