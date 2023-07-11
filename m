Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D8D74E58C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGKDzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGKDzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB841BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3e1152c23so3678792b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047713; x=1691639713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIlxgDREFu6LlOiulF242HoL+hhnsQmd+OCvzSb0WTY=;
        b=CmxeKRs4gLnyTQYT+priT1hS2JdubJC5Dw/d7haZ/eUhfQ5DQq8hVuNMfRYn0YrKfY
         Ere1opP+H09ay1uUCmD9kh4UFVcpIbi2SR7/v45hmGGedCsFMQP3NOr8I/oahWOEG28L
         FHyHWHEStwZS08cCmBqv+KoceYbwE0k6jnZbqJUp6YvpwzUaFpP3wuoCSAXRC90ZVPbe
         k/DY6/mOEVsGugOyMCCTxcwo56s6Afhsnl9I6hbNxTGvNYu938n6abLjmyi171Pg75zw
         ytktelZVA+im/0Vpnwlp4JUajcIfcJ3I6n3qCfLCrBjvPngSvJou6nOA9Hu6O7kxYWyl
         bFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047713; x=1691639713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIlxgDREFu6LlOiulF242HoL+hhnsQmd+OCvzSb0WTY=;
        b=IriQrcCcKfMCrHpcn4R5EAAFHg5fyWd1xMVQUvSEPoEuEw6/zVfgFOePKiobm+W9tW
         u8+EDPAWE4999kDcAWYYq99wiSEgEcdsCqLeaRA4dkGxziM3RKmjokLbnVpuIREfEBA3
         WqueCksmAZSRAtzYCqMBUBrG2nsRqULZNXYJBmbojJS4eTThj6yjsHeChUBvdM+hrgg2
         96FFTC/QK9YwC5kpv9MEafTb5F9JBPKnDnvn90ErjOGzdvJmSj15GiuX5DbbeWhVyiB6
         kO1ou1XjtnTVRAzkhfjlCvp/rnJUot/M/HRN8yYysDQpecUXrj8q+h0mx/vkIWA+7ADs
         g5xw==
X-Gm-Message-State: ABy/qLbaFSHgEhLlHM9zcm2HlUtTmJdXiSUKY3OO95Ec+rvpn3cf+tY4
        B8507gCAF6uZ5NvAn27zuNVMgw==
X-Google-Smtp-Source: APBJJlFAdlFH4yOpWh33A5jHeiNI5op1t/pJadGZ9w0dOd23WdGLfmf+wGdZ+cMymmOd7GxyhBWwlg==
X-Received: by 2002:a05:6358:9929:b0:134:c984:ab87 with SMTP id w41-20020a056358992900b00134c984ab87mr13040684rwa.4.1689047713510;
        Mon, 10 Jul 2023 20:55:13 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:13 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 5/8] maple_tree: make mas_validate_limits() check root node and node limit
Date:   Tue, 11 Jul 2023 11:54:41 +0800
Message-Id: <20230711035444.526-6-zhangpeng.00@bytedance.com>
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

Update mas_validate_limits() to check root node, check node limit pivot
if there is enough room for it to exist and check data_end. Remove the
check for child existence as it is done in mas_validate_child_slot().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f750ebef595f..072532fa18ee 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7146,7 +7146,9 @@ static void mas_validate_child_slot(struct ma_state *mas)
 }
 
 /*
- * Validate all pivots are within mas->min and mas->max.
+ * Validate all pivots are within mas->min and mas->max, check metadata ends
+ * where the maximum ends and ensure there is no slots or pivots set outside of
+ * the end of the data.
  */
 static void mas_validate_limits(struct ma_state *mas)
 {
@@ -7156,26 +7158,15 @@ static void mas_validate_limits(struct ma_state *mas)
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
@@ -7198,6 +7189,13 @@ static void mas_validate_limits(struct ma_state *mas)
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

