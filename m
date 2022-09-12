Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5319E5B5A80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiILMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiILMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:53:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97EC2F016
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:53:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r18so19932859eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=nGTCVwpa7FHGhxIcMI2gWYkmXzWyO3MNsUyuvcbNiH8=;
        b=E3vd1eoWlsMgyS4fO3gF6lpMkL0/Gbh09VKXtTgw6dcnjm/+FK2cT/goyin0Upse5m
         USygGaqAA/xLQYgbrabJlO8b2ZyV7dqqxl3rPysJ2+xX+vPvYb/xEGNnGBQpnmq6FCiz
         t26z7fAtFKCMxkEXaZDszAttM7HTHT/ftp1RtQ70IFEjwEXsYGhKP9Yrje3xNF/YkZgd
         3URRTNuLErXfYQmHRQPk4ULz60EIQqzVGC52fgvVN+Iv2mp2S9GQVM2hBQ7thefoTuby
         HHXrbgWashbhBWBKvXDX3pxhx3b/3lemsWc//gsFas9P3Umsl7tnQ4d3/IBD7HCI/6Pj
         ZrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nGTCVwpa7FHGhxIcMI2gWYkmXzWyO3MNsUyuvcbNiH8=;
        b=gP9/ew20WrJ1Nh9OCcUrARKGpRlHKDy30rpSf9oGyD5VSsQLdHOYlHBNydf9b/Rqmw
         2KNBjvqWHDXYooOQstO+XcK1GTs2SvUIGwLh2l5qm1GIgBM/4h9tC8oAQzaA9mUA41I3
         CBteqzNREqBQfoEa2UMGHjKEarTuxdP7i7eAl3k0SJA8YCg0kWJsB/1zldvlSfeOvwlF
         Sp5hRzGStZye+QWc0gf2ZBPtOdjU5Prvtui5cmgJhKFpkXjZbuL4/86FsOvP0/eDfY+N
         i8uZoMTrMSEJK5VPIxWD/v3yE38IoNxhk0Jenrx4swgRWnjXSjL6P/0fs2dN38EPrIRt
         +p3Q==
X-Gm-Message-State: ACgBeo08dxBe53ErwC6gsfW1FBUu7EYSJq4gTsd0ffHtaOdJqv1ToPV0
        ZEs0M3tZG1/f9P2ut5cAR0G40lEyAeIeew==
X-Google-Smtp-Source: AA6agR7YwflFmuaYz3R9twMlYnvrAzH38CVXZZBObZF9qSFEPO3iQb8syyTOKCC0F59QZaaWNem0mA==
X-Received: by 2002:a17:907:6d9b:b0:731:1135:dc2d with SMTP id sb27-20020a1709076d9b00b007311135dc2dmr18922488ejc.76.1662987182115;
        Mon, 12 Sep 2022 05:53:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7cac4000000b0044ee2869ef7sm5760869edt.4.2022.09.12.05.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 05:53:01 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] XArray: Fix xas_create_range() when lower multi-order entry present
Date:   Mon, 12 Sep 2022 12:46:47 +0000
Message-Id: <20220912124647.17164-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220912124647.17164-1-richard.weiyang@gmail.com>
References: <20220912124647.17164-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is already an lower order entry present, xas_create_range()
would face two problems:

  * When new_order is roundup(order, XA_CHUNK_SHIFT), it would go up and
    access root->parent
  * When there is holes in lower order range, no proper entry is created

This patch tries to fix this issue by adjust to proper next_index if we
found a multi-order entry. And then look up.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/test_xarray.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c      | 21 +++++++++++++++---
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..2cf2cd8471a8 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1482,6 +1482,59 @@ static noinline void check_create_range_5(struct xarray *xa,
 	xa_destroy(xa);
 }
 
+static noinline void check_create_range_6(struct xarray *xa)
+{
+	unsigned long index = 0;
+	unsigned int order, next_order;
+
+	order = 2 * XA_CHUNK_SHIFT - 2;
+
+	for (next_order = order + 1; next_order <= roundup(order, XA_CHUNK_SHIFT) + 1;
+			next_order++) {
+		XA_STATE(load_xas, xa, 0);
+		XA_STATE_ORDER(xas, xa, 0, next_order);
+
+		for (index = 0; index < (1 << next_order); index += 1 << order) {
+			if (index == 0)
+				continue;
+			xa_store_order(xa, index, order, xa_mk_index(index), GFP_KERNEL);
+		}
+
+		// [0, (1 << order) - 1] is empty now
+		rcu_read_lock();
+		xas_load(&load_xas);
+		XA_BUG_ON(xa, load_xas.xa_node == NULL);
+		XA_BUG_ON(xa, load_xas.xa_node->shift == 0);
+		rcu_read_unlock();
+
+		xas_set(&load_xas, (1 << order) - 1);
+		rcu_read_lock();
+		xas_load(&load_xas);
+		XA_BUG_ON(xa, load_xas.xa_node == NULL);
+		XA_BUG_ON(xa, load_xas.xa_node->shift == 0);
+		rcu_read_unlock();
+
+		do {
+			xas_lock(&xas);
+			xas_create_range(&xas);
+			xas_unlock(&xas);
+		} while (xas_nomem(&xas, GFP_KERNEL));
+
+		// [0, (1 << order) - 1] is created now
+		xas_set(&load_xas, 0);
+		XA_BUG_ON(xa, xas_load(&load_xas) != NULL);
+		XA_BUG_ON(xa, load_xas.xa_node == NULL);
+		XA_BUG_ON(xa, load_xas.xa_node->shift != 0);
+
+		xas_set(&load_xas, (1 << order) - 1);
+		XA_BUG_ON(xa, xas_load(&load_xas) != NULL);
+		XA_BUG_ON(xa, load_xas.xa_node == NULL);
+		XA_BUG_ON(xa, load_xas.xa_node->shift != 0);
+
+		xa_destroy(xa);
+	}
+}
+
 static noinline void check_create_range(struct xarray *xa)
 {
 	unsigned int order;
@@ -1515,6 +1568,7 @@ static noinline void check_create_range(struct xarray *xa)
 	}
 
 	check_create_range_3();
+	check_create_range_6(xa);
 }
 
 static noinline void __check_store_range(struct xarray *xa, unsigned long first,
diff --git a/lib/xarray.c b/lib/xarray.c
index 326b73bb9811..3f9a630ef788 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -708,6 +708,7 @@ void xas_create_range(struct xa_state *xas)
 	unsigned long index = xas->xa_index;
 	unsigned char shift = xas->xa_shift;
 	unsigned char sibs = xas->xa_sibs;
+	struct xa_node *node;
 
 	xas->xa_index |= ((sibs + 1UL) << shift) - 1;
 	if (xas_is_node(xas) && xas->xa_node->shift == xas->xa_shift)
@@ -723,14 +724,28 @@ void xas_create_range(struct xa_state *xas)
 			goto success;
 		xas->xa_index -= XA_CHUNK_SIZE;
 
+		node = xas->xa_node;
+		if (node->shift) {
+			unsigned long next_index = xas->xa_index >> node->shift;
+
+			next_index &= ~XA_CHUNK_MASK;
+			next_index += xas->xa_offset;
+			next_index <<= node->shift;
+
+			if (next_index <= (index & ~XA_CHUNK_MASK))
+				goto success;
+
+			xas->xa_index = next_index - 1;
+		}
+
 		for (;;) {
-			struct xa_node *node = xas->xa_node;
-			if (node->shift >= shift)
-				break;
 			xas->xa_node = xa_parent_locked(xas->xa, node);
+			if (!xas->xa_node)
+				break;
 			xas->xa_offset = node->offset - 1;
 			if (node->offset != 0)
 				break;
+			node = xas->xa_node;
 		}
 	}
 
-- 
2.33.1

