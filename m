Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AED6DD0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDKEKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKEKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:10:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C655B1BC8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:10:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w11so6642615plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681186218; x=1683778218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JQC2S3AsB/qfFz4i+cFB5iM5W1998ocJck2gmcRviY=;
        b=c+OhbwPDKLL1YNc5EklJLAoqBP4lWpvwS3T5ff8jGJ5C+odIS/4hjxEOVVxtvZVEwv
         jiUDUhhQFVa+X70eGWbAkz8hgQkj4ZBGKssBaI95xPjXCpulKL6LgTwL6hbYH/EoPiwm
         WKlzj64HS5Q6+cZt67J5vP9bvpFKVLRHoQRRINLir3+/TTRVTqe5clr/DAnpV9pbNsJj
         y2p5bEQZocHzfMafDtq+qVDlL8oYMJI1S6ND5+uU5I+IF3uxtMdsZX+hBn3qBT3fAjOq
         BIyYESuShEQBUZNrUVcTHkf8mjIbPBVlZevxF0/E/FjfhM/LjIhx2Yo70YBfK1OKN/tb
         +aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681186218; x=1683778218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JQC2S3AsB/qfFz4i+cFB5iM5W1998ocJck2gmcRviY=;
        b=XDCSuvAn8pwa4eqmu1xoD0LliZY2O0NVz/SBCK1fvkqJi0phtuW6HNhHuxoNUMvWsc
         PbOENxqLWxP0rr0orsYLZ6WkIzZtvkL7EZFb8TLdUYusYcKmUO2OreZkXOln5iN1j8He
         YNBeRSL+nQt1lYEnaEOBhlEwceQOu9AkpZ1cWxdaYbnZMC7X1+y0dJgRoE0YqzbmFA79
         hiiGS/nAqJvB7ybolYV0UGIbXcYWaJ+6Vzj9gtq/2BENb8b6sMKB2FCpN8Z50Bjp/JoP
         Hqpoi3E3h8YPRnYpXeZhVjbwiSVLHNHsURTGrvWQRh0oN1U/DmnBHYxm8B106PoNf8pp
         t4+g==
X-Gm-Message-State: AAQBX9dnjfauyqh2GYJQjydDylHMrAZIvmmufFttmOC0qA2Frk4PhWEx
        2C7LjIBlaYiwqllG6sioEhnNyw==
X-Google-Smtp-Source: AKy350YaascfuG3f5vp+LTeX4R8cU9ivYMglUHZYxbSxDrmF2F15n2Y5K8ooV7egX1jfHL8UCEo8tg==
X-Received: by 2002:a17:902:fa48:b0:1a6:4480:dfed with SMTP id lb8-20020a170902fa4800b001a64480dfedmr4852064plb.49.1681186218323;
        Mon, 10 Apr 2023 21:10:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b00198f36a8941sm5567317plo.221.2023.04.10.21.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Apr 2023 21:10:18 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/2] maple_tree: Add a test case to check maple_alloc
Date:   Tue, 11 Apr 2023 12:10:05 +0800
Message-Id: <20230411041005.26205-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230411041005.26205-1-zhangpeng.00@bytedance.com>
References: <20230411041005.26205-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case to check whether the number of maple_alloc structures is
actually equal to mas->alloc->total.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/maple.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 4c89ff333f6f..9286d3baa12d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -55,6 +55,28 @@ struct rcu_reader_struct {
 	struct rcu_test_struct2 *test;
 };
 
+static int get_alloc_node_count(struct ma_state *mas)
+{
+	int count = 1;
+	struct maple_alloc *node = mas->alloc;
+
+	if (!node || ((unsigned long)node & 0x1))
+		return 0;
+	while (node->node_count) {
+		count += node->node_count;
+		node = node->slot[0];
+	}
+	return count;
+}
+
+static void check_mas_alloc_node_count(struct ma_state *mas)
+{
+	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
+	mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
+	MT_BUG_ON(mas->tree, get_alloc_node_count(mas) != mas->alloc->total);
+	mas_destroy(mas);
+}
+
 /*
  * check_new_node() - Check the creation of new nodes and error path
  * verification.
@@ -69,6 +91,8 @@ static noinline void check_new_node(struct maple_tree *mt)
 
 	MA_STATE(mas, mt, 0, 0);
 
+	check_mas_alloc_node_count(&mas);
+
 	/* Try allocating 3 nodes */
 	mtree_lock(mt);
 	mt_set_non_kernel(0);
-- 
2.20.1

