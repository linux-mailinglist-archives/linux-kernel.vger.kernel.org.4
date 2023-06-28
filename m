Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F0740AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjF1IMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjF1IIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:08:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C753A87
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:06:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8063aa2e1so19760055ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687939617; x=1690531617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0By+FF+rGXXCgPIa+pNPe3WykMAyZs5vfqaT+achZz4=;
        b=i/niiM00dTBFqUbEK3rieg0A6WXfEy03LYPbyVVh01etA/CKeJ0PjivF90apN+HhyU
         HeQw9oG3I/n4WmTzGSz4phfPUR9z9PGYsZX+lN4HlnHY7mQZv9W1hBuLmb5kd6TbKDFe
         ta8lSfKVD4ZWNUtSt3D3ycweSgoC2flRn9IkAk+5tzNQd/Fn/tb26WEONtwCLk1h+PDV
         pfv53sgOFV8hUKkfiONpJfMJu72hh9AhmjlmDAxaW/I9MbERuX0GHBkkzSfjsys+RtjI
         FHWLB06197JeF5IIe7Up9okZqNabN7s7E/73jv7nr/UQbJepgwkaA8bfO5+qmYtjTD7r
         K80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939617; x=1690531617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0By+FF+rGXXCgPIa+pNPe3WykMAyZs5vfqaT+achZz4=;
        b=LHsvW2dT2li14pBpO0xzVCtZvtDJSetSbahOJDYrTF+uJd858AwxUKRBwcAEHEy/O0
         4dwizv1FR3LAW70AgkWYr2AWNwgLfCqsl8t9GBcQPS5iwL+zUgwTpp6l+KdZnHjSDFcm
         B/uC0rD59SQworMGZdGTn/xj6+/idt5tEDuJAv8ubuLE6uhv873tOUFh8HYSmFwPB2JI
         taXNXVmGZpC7pOAAe3nXfsy30Eeg2hllgWZcYZSjxQhFPOdI6HsnjguaIFo/iOB+VHMB
         6XPQU61rKnsu2kEBpvrAMsT278bt3adDERYH0IjAtwczeA1vntAkzGlC8w+qyaxMrCRS
         gn6w==
X-Gm-Message-State: AC+VfDyASH/S31HzVbtLeg0zRgIONtVWMXyJHop6dY7KSmCsIevV/fWs
        2GohH/4kzBRW0X3dgv12/3CfnLRroFytiPT5EVsFgA==
X-Google-Smtp-Source: ACHHUZ4+EQgGpYZBChxbpJnmew+64neAGFcXxlFtpsafzMYQAYKBzioIORokEkJaecac1vca1g9GzA==
X-Received: by 2002:a17:902:dac3:b0:1b6:c139:9b23 with SMTP id q3-20020a170902dac300b001b6c1399b23mr8794103plx.26.1687937831748;
        Wed, 28 Jun 2023 00:37:11 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jj6-20020a170903048600b001b8021fbcd2sm4836988plb.280.2023.06.28.00.37.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Jun 2023 00:37:11 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 1/4] maple_tree: add test for mas_wr_modify() fast path
Date:   Wed, 28 Jun 2023 15:36:54 +0800
Message-Id: <20230628073657.75314-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
References: <20230628073657.75314-1-zhangpeng.00@bytedance.com>
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

Add tests for all cases of mas_wr_append() and mas_wr_slot_store().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9939be34e516..9f60e0c4cc8c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1157,6 +1157,71 @@ static noinline void __init check_ranges(struct maple_tree *mt)
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

