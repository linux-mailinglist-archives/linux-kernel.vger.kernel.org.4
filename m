Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE455B9209
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIOBK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIOBKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:10:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48A8A1FD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:10:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so17823678edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=aMjqf7mnhRYGv1Je1W14udsabzQsxRLS4f5yjXnVbXw=;
        b=j7PnvzDDSFojXXrNn8bqbWIVyhHQsJ7kQUPGCPcPeQVcmrBT3rdiLjoHkxtFNwN7te
         e5XW89RRYtB1+mBn8ZmB679Wdy/eWgfXQqey2bpUtlnovOIzSIrPR2XhfN+YaVpm0qyW
         gjQbNzntJqMYw8qcIJIl5L6l7A8zO+I9b1Rba0oJxYHXHKo/dq/3PU/PB9xNDidIdPJV
         lQbt3vfR8vZ+i8hL7w1PEWMcINyUZFmyG9k9I0tAtVrhg4hQjH1DLjcvij570DORwXub
         pZjlqn7dhFjyxmkHC27wVjJ2PrakXWQiNwV7gtnc3YJskYT2q8f7aMEXySDGWA9KqdvO
         CiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aMjqf7mnhRYGv1Je1W14udsabzQsxRLS4f5yjXnVbXw=;
        b=c6b7VDQkIUti+2q/yUzODDmXY3T7qlq/Xxp0Y2IvmIqJTuWw2lPb4MrWQw1M4HawhI
         5CdmE88+JhfQp8pKjuVaR6kFkDrmsalfTiH7XQTCM/8myEvQ95HqpijPuoeTwjCM2XeN
         O9pd8eX6ZvxsDtmRiwgmyDkim2Pg47ppnKLIcBdRyRcLEiEKDn6+jDxFPepomZ6zWE2B
         dR4MQU8z4i90OlQqL5fvAX+k0t8rudUF5AVq7wSmbv4CUMNsBHkwxiTmS59U5s73mWPR
         v564dc+iAJF8iyGhxbPqJMfCPHl4K+wsENGwQIvlA5J1x1bs2OMIiQ1xuyHS8fryDJLY
         Nswg==
X-Gm-Message-State: ACgBeo1M0vdxk8Q6lk9BIitbD027FeTFGWpT7uOGBRoD5P6Y0X9vtdaj
        DjlWr1730cvCg1EU8ZHaGYe6WN5QhFfUTQ==
X-Google-Smtp-Source: AA6agR5w2ZW1mUe/XFUbzN+9Ai0OT8F+ylM2TNPUNKgVmlT0UmBrMw6CYJQpPktQgq8hrTOKZ29zSA==
X-Received: by 2002:a05:6402:500d:b0:440:9bc5:d0c1 with SMTP id p13-20020a056402500d00b004409bc5d0c1mr32779688eda.202.1663204218953;
        Wed, 14 Sep 2022 18:10:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o15-20020a170906768f00b0077826b92d99sm8478836ejm.12.2022.09.14.18.10.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2022 18:10:18 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org, richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch v2 2/2] XArray: Fix xas_create_range() when lower multi-order entry present
Date:   Thu, 15 Sep 2022 01:09:57 +0000
Message-Id: <20220915010957.25506-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220915010957.25506-1-richard.weiyang@gmail.com>
References: <20220912124647.17164-1-richard.weiyang@gmail.com>
 <20220915010957.25506-1-richard.weiyang@gmail.com>
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
found a multi-order entry.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2:
  * guard result check with rcu lock
  * instead of continue the iteration on multi-order entry, xas_set() the
    index to let xas_create() restart
  * put hole in each possible position
---
 lib/test_xarray.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c      | 22 +++++++++++++---
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..5ec9c19ad65e 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1482,6 +1482,70 @@ static noinline void check_create_range_5(struct xarray *xa,
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
+		unsigned long hole;
+
+		for (hole = 0; hole < (1 << next_order); hole += 1 << order) {
+			XA_STATE(load_xas, xa, 0);
+			XA_STATE_ORDER(xas, xa, 0, next_order);
+
+			for (index = 0; index < (1 << next_order);
+					index += 1 << order) {
+				if (index == hole)
+					continue;
+				xa_store_order(xa, index, order,
+					xa_mk_index(index), GFP_KERNEL);
+			}
+
+			// [hole, hole + (1 << order) - 1] is empty now
+			xas_set(&load_xas, hole);
+			rcu_read_lock();
+			xas_load(&load_xas);
+			XA_BUG_ON(xa, load_xas.xa_node == NULL);
+			XA_BUG_ON(xa, load_xas.xa_node->shift == 0);
+			rcu_read_unlock();
+
+			xas_set(&load_xas, hole + (1 << order) - 1);
+			rcu_read_lock();
+			xas_load(&load_xas);
+			XA_BUG_ON(xa, load_xas.xa_node == NULL);
+			XA_BUG_ON(xa, load_xas.xa_node->shift == 0);
+			rcu_read_unlock();
+
+			do {
+				xas_lock(&xas);
+				xas_create_range(&xas);
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			// [hole, hole + (1 << order) - 1] is created now
+			xas_set(&load_xas, hole);
+			rcu_read_lock();
+			xas_load(&load_xas);
+			XA_BUG_ON(xa, load_xas.xa_node == NULL);
+			XA_BUG_ON(xa, load_xas.xa_node->shift != 0);
+			rcu_read_unlock();
+
+			xas_set(&load_xas, hole + (1 << order) - 1);
+			rcu_read_lock();
+			xas_load(&load_xas);
+			XA_BUG_ON(xa, load_xas.xa_node == NULL);
+			XA_BUG_ON(xa, load_xas.xa_node->shift != 0);
+			rcu_read_unlock();
+
+			xa_destroy(xa);
+		}
+	}
+}
+
 static noinline void check_create_range(struct xarray *xa)
 {
 	unsigned int order;
@@ -1515,6 +1579,7 @@ static noinline void check_create_range(struct xarray *xa)
 	}
 
 	check_create_range_3();
+	check_create_range_6(xa);
 }
 
 static noinline void __check_store_range(struct xarray *xa, unsigned long first,
diff --git a/lib/xarray.c b/lib/xarray.c
index ed50a26d97a3..8b3df256b407 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -694,6 +694,7 @@ void xas_create_range(struct xa_state *xas)
 	unsigned long index = xas->xa_index;
 	unsigned char shift = xas->xa_shift;
 	unsigned char sibs = xas->xa_sibs;
+	struct xa_node *node;
 
 	xas->xa_index |= ((sibs + 1UL) << shift) - 1;
 	if (xas_is_node(xas) && xas->xa_node->shift == xas->xa_shift)
@@ -709,14 +710,29 @@ void xas_create_range(struct xa_state *xas)
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
+			xas_set(xas, next_index - 1);
+			continue;
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

