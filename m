Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED047298FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbjFIMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbjFIME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:04:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C1185
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:04:35 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51452556acdso543718a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686312274; x=1688904274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6we1XLVpJvFDKToAtCSdGG7AESFIveH8POVJHK7ygw=;
        b=PC+79P6zld1xHv0iEHUypxLnb5f8t146nEumIY8vCPreM6HtGZs171xPu43YSEfAf/
         8tXWLXLwlc9ooEQ0fJ6wWh/m089QFWFXnDemDLdCN5bCHqmnsrgAp5e+NsT6yw3mkXir
         ONjMHZPTMPaCQHufwndsdcuzCIi3Z/SyDW63FuzJnKgNWFlnvj7rSG5G+1t0nZda0KAK
         lJ80H5jIzAP1DLiE7cyVTtFL1ZkvrkP/2cU6O8ZxpsMwaVfyV5TyCHDVztVhJftPdBjD
         VQj+jNKOkuTjUvSwWOZbkIWpLkhLxZJ7dtq0gV1dqRvurp41kzdhjk9GF0xDSl4gljnC
         iOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312274; x=1688904274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6we1XLVpJvFDKToAtCSdGG7AESFIveH8POVJHK7ygw=;
        b=M6FZGKd0AnvfmmoZo4qmplVsKRppDRBjSu1Z7G0t1SoupaUtBx6ftcYvXDwmX1aUmo
         Cquq5icrbBKHg8WqFZ84NJL1TasdGhWrtSrZByhtxQ1V8aLHcqGJx3t3QBrNPA091eM4
         UDdenEWQ5b+3ZugBg9o4LYpNmb+k17dKy9k1gMBfp2lrHvZkoAVeDTB8bUKnjjs9wWRX
         plj2FDk+w3vPXdK5jlhTuwY3D5LdB+mnJ9w2acKKyupbpdXgk4jUhG0dlzzaOwIYr6QU
         c4oKpcXmw1NjU+Rb0juU68UaNlbMVboT6KGc9iROVY3z93qffYSb43B0Lk+TMrDAPkAv
         ow2Q==
X-Gm-Message-State: AC+VfDxRpsb5ziyRzVx8ZM299xgT3Eb7i3gAI8UKa3pKNj2zzhdO6shz
        /5qScELYqPdYmj6QDbx3vK+caw==
X-Google-Smtp-Source: ACHHUZ4c7S/hhzd9J/cuoih1FnFVo/eBjSB6PM9tKj0JZeYoff2Wj+X+185zSOQly4NC+px2oyVHDw==
X-Received: by 2002:a17:90b:164c:b0:259:c73:65e6 with SMTP id il12-20020a17090b164c00b002590c7365e6mr816107pjb.23.1686312274507;
        Fri, 09 Jun 2023 05:04:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id v12-20020a65568c000000b00514256c05c2sm2619168pgs.7.2023.06.09.05.04.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jun 2023 05:04:34 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 1/3] maple_tree: add test for mas_wr_modify() fast path
Date:   Fri,  9 Jun 2023 20:03:45 +0800
Message-Id: <20230609120347.63936-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
References: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
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

Add tests for all cases of mas_wr_append() and mas_wr_slot_store().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 15d7b7bce7d6..9403472af3d7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1159,6 +1159,71 @@ static noinline void __init check_ranges(struct maple_tree *mt)
 	MT_BUG_ON(mt, !mt_height(mt));
 	mtree_destroy(mt);
 
+	/* Check in-place modifications */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	/* Append to the start of last range */
+	mt_set_non_kernel(50);
+	for (i = 0; i <= 500; i++) {
+		val = i * 5 + 1;
+		val2 = val + 4;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Append to the last range without touching any boundaries */
+	for (i = 0; i < 10; i++) {
+		val = val2 + 5;
+		val2 = val + 4;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Append to the end of last range */
+	val = val2;
+	for (i = 0; i < 10; i++) {
+		val += 5;
+		MT_BUG_ON(mt, mtree_test_store_range(mt, val, ULONG_MAX,
+						     xa_mk_value(val)) != 0);
+	}
+
+	/* Overwriting the range and over a part of the next range */
+	for (i = 10; i < 30; i += 2) {
+		val = i * 5 + 1;
+		val2 = val + 5;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/* Overwriting a part of the range and over the next range */
+	for (i = 50; i < 70; i += 2) {
+		val2 = i * 5;
+		val = val2 - 5;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/*
+	 * Expand the range, only partially overwriting the previous and
+	 * next ranges
+	 */
+	for (i = 100; i < 130; i += 3) {
+		val = i * 5 - 5;
+		val2 = i * 5 + 1;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	/*
+	 * Expand the range, only partially overwriting the previous and
+	 * next ranges, in RCU mode
+	 */
+	mt_set_in_rcu(mt);
+	for (i = 150; i < 180; i += 3) {
+		val = i * 5 - 5;
+		val2 = i * 5 + 1;
+		check_store_range(mt, val, val2, xa_mk_value(val), 0);
+	}
+
+	MT_BUG_ON(mt, !mt_height(mt));
+	mt_validate(mt);
+	mt_set_non_kernel(0);
+	mtree_destroy(mt);
+
 	/* Test rebalance gaps */
 	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
 	mt_set_non_kernel(50);
-- 
2.20.1

