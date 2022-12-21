Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C947A652CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiLUGCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLUGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:55 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE821EC78
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:40 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so9759175pgh.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxb84ytAPFYreSOdPkhL3PM7KemIvxiY/1J13wK332c=;
        b=UjDk03Xng4Fdh5jRhus2wH9UUuHAQyoFWmA2K42x+nWA7pqpImyeM0Kt2r5uZQ0hXF
         vw9C9qsE1YdAAUSnNHaCc8Btp8sLRss51PLxbbpIe2YiycY8rITES89MtLAHVNd5vzum
         zGGUeuc8OrQQuOqapwjOl9rPfBtU6BXem5qzstlBpIJRxC5vKgsT8Aa2Tbc/O4Yq1HpW
         fQrUq/T9UadAmhL9DW39kwVKpbD21TMHt+o17qb5vLqtU5IWH1CCmhnY3HPHlm59W9pz
         VaxdRz/9zO3jznGR0DfTxjUts8mfxb+KUgaHEh0h5ET7bku0Tn1IK4kfxOUW4IgjFYM4
         cjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxb84ytAPFYreSOdPkhL3PM7KemIvxiY/1J13wK332c=;
        b=038AtODNL8FnJErGhObYRAQKsc5dY6vbOlcCC8PmpuZN5+wYpL7O+mTsytaDcN+aSu
         ZrRYABIM7DqTQzZNSUsOJWqwWvOAkJEeOBje5MjPHjxRLHyoujrlgUJlBR/W8IijI+vD
         x2GeIEoktAe3+WQceA73XkULe771n2fX+LwPKJbuHBedLaoc+q54V63zr4hRijXEovmM
         vszTGrKpL0tp8Y0RxmatSvZETfifV+Sqya9II6gOCpG7NRlInoWqCNMpn9z6JcP7fBFz
         f/iU++gWa/l4irL61Lqa1+k3AJK5sYCYBjQ+Ygs15nYY8wcxESqehufF8B5pgwgaql5g
         E0LA==
X-Gm-Message-State: AFqh2kqPgMNKWBK8nowjLbwrkUwi5PWaa0YFE9KG7uHrqufRbPIi1gTw
        E+NCsPQDyRnAU4AD9bfrVns=
X-Google-Smtp-Source: AMrXdXtMQNG4MLPAQuAxM6F8pv2SymackH14UvCmmp2Lj0VLowO3NVPJe1mW7SvC4gzZLgCzhayhhQ==
X-Received: by 2002:aa7:81d4:0:b0:56e:a7a7:35a0 with SMTP id c20-20020aa781d4000000b0056ea7a735a0mr1036849pfn.25.1671602500364;
        Tue, 20 Dec 2022 22:01:40 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:39 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 6/7] maple_tree: refine ma_state init from mas_start()
Date:   Wed, 21 Dec 2022 14:00:57 +0800
Message-Id: <20221221060058.609003-7-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221060058.609003-1-vernon2gm@gmail.com>
References: <20221221060058.609003-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mas->node is an MAS_START, there are three cases, and they
all assign different values to mas->node and mas->offset. So
there is no need to set them to a default value before updating.

Update them directly to make them easier to understand and for
better readability.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b3a215dd961e..5911211c8557 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1329,7 +1329,7 @@ static void mas_node_count(struct ma_state *mas, int count)
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
  *
- * If mas->node == MAS_START, then set the min, max, depth, and offset to
+ * If mas->node == MAS_START, then set the min, max and depth to
  * defaults.
  *
  * Return:
@@ -1343,22 +1343,22 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 	if (likely(mas_is_start(mas))) {
 		struct maple_enode *root;
 
-		mas->node = MAS_NONE;
 		mas->min = 0;
 		mas->max = ULONG_MAX;
 		mas->depth = 0;
-		mas->offset = 0;
 
 		root = mas_root(mas);
 		/* Tree with nodes */
 		if (likely(xa_is_node(root))) {
 			mas->depth = 1;
 			mas->node = mte_safe_root(root);
+			mas->offset = 0;
 			return NULL;
 		}
 
 		/* empty tree */
 		if (unlikely(!root)) {
+			mas->node = MAS_NONE;
 			mas->offset = MAPLE_NODE_SLOTS;
 			return NULL;
 		}
-- 
2.34.1

