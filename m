Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2CC74E592
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGKD4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjGKDzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F0E59
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:17 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-635eb5b0320so35857276d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047716; x=1691639716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB6Zk8yx2k+1HDLx/vyMhcB3cYhsChcAv55Bv4rEWns=;
        b=LSWgQLIm1PFWUmQi+43SqOstxpJoc3S5KiF0uBqZBj+yhFOyw31mF12pOmarXSQTwl
         ftLznRUeQW71nK3PQ10DqNTXANC+OzuxYtBuC6dEParOiiStsUCAqTUuuFV87HYUI7ju
         uOT3WQoFhn8iH8thH0rnasi0ozRlnz9v4G5nx3FuT0HEGBIojQ/P+EgU7XeHHOcdTwEh
         rl+muaqKcxNVqi50mRjNkFJGUYhKZNbiZ5e5AgdmWuRmWeKMzDDYIM9TwleGcI9Tyy4U
         r/iL1UYkK2+O5mX+8p+GRA3Z6xTt3Qt+4LVhqHd9F8RAsfoU1ZlSZcV1hsh0tp7hekj6
         kCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047716; x=1691639716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB6Zk8yx2k+1HDLx/vyMhcB3cYhsChcAv55Bv4rEWns=;
        b=dNkbFa0iHFpWhkvce60hePIg2/M3RCIcwL6K+Baz+IQIyuoYrjPpfhsJ612E7oZFMe
         EWBR6P+ukm4Ua5AqN4GLKNvB0DlfxNcNClPbSakWtD5sYL7ydarQRuYxpfBuyGn5J71m
         fVWWcvO0VND7kPCkU2XSBDBc9ZhfZGFO1dXaNgH0Xb3sdVpBul40f22Ip3vweTc2sAB7
         RQ12hngk5udDIr3l6FWxZ98Zglir0opwaqyKkX9+qUGkQW8n34lHSN6lNKrf9LVZvkth
         vjg1Ud5w6DZHVgrPrSbzZM2S+92SqPxFPjugMRdBTzzG1Se1Irhr1gNdLvvcf4T/d5Ya
         Vldg==
X-Gm-Message-State: ABy/qLZxi7vOJ7nxpM+foN4CxiSGMo/9rVJGRCsJrWB6Q3EJDmSW3+G1
        nR9DLoHTqerH7t51bVECLqEMF7D+MnHp4GkNCEo=
X-Google-Smtp-Source: APBJJlEnW9Zfp2okquSeGO/JAFM7vrs2pnSVclOfwaHYw3+NqS7kqVlvETzZeA0RLZFxlJazP5po8w==
X-Received: by 2002:a0c:e28c:0:b0:635:de52:8385 with SMTP id r12-20020a0ce28c000000b00635de528385mr13630151qvl.65.1689047716426;
        Mon, 10 Jul 2023 20:55:16 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:16 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 6/8] maple_tree: update mt_validate()
Date:   Tue, 11 Jul 2023 11:54:42 +0800
Message-Id: <20230711035444.526-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 lib/maple_tree.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 072532fa18ee..1ad11799e197 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7270,21 +7270,20 @@ void mt_validate(struct maple_tree *mt)
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
+		if (MAS_WARN_ON(&mas, (end < mt_min_slot_count(mas.node)) &&
+				(mas.max != ULONG_MAX))) {
+			pr_err("Invalid size %u of %p\n", end, mas_mn(&mas));
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

