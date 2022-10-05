Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D310D5F5980
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJESEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJESDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:03:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779057172C;
        Wed,  5 Oct 2022 11:03:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so5981222pls.9;
        Wed, 05 Oct 2022 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iroUAKdZ7R5Gx/z/KE5xhjM/Ew8lqKEyV5onJIu1MHY=;
        b=PIZwg3d0nAqXGCHGip9wpna0F2Rq/W9uZxN7XaeU73FBRauDrwoRGXRkihEuzQ2Fmj
         +8lBXmjefIoKl6B1WKFOLC1dAS3BqACPb+YgeUCRA5PYSduG8UnZBOjq2+jh1rVRc+hh
         csj0HpN3+6Fy9tmHtYNYQBKgSf/uTRmMOUWsDLvFQ+MQRA1psom1e8m54Vy6VYYdqC8A
         S3Bv5I6D3Z9jOE+HSoLYHjLwmIC4QZ3VNvh7AVl2SQC64Atje1J1AdlpNCfpW7liChLB
         8HUzvPnEkYb+RyJrdCMB1YJCUfUNLD6IKt2XY73Fk5NCCYaia2pHQJOxD6LCExHNm4rJ
         vEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iroUAKdZ7R5Gx/z/KE5xhjM/Ew8lqKEyV5onJIu1MHY=;
        b=PnGVGW7o2HWbM2Fc8yksX/J0agGLGUTvCtnbdi4UczyjSmg5OfBH50oPsormJVP9l2
         HWLfNMFLkOKbOyhf0bx/77+z4yrlFVBFNIRpCbuUlm8lVDGq8ce8Rg0FDi6BqeOiXTFw
         Pojrryv8QieT2STNSuXpL/FQIjXM8InIJlMuQs1g2bK/9IQPlI89CH9g7dBEXdjPXg/Z
         WFr9+SXAshQNjYPvDAPuI7VRkU1vUxlOXTMkhIINp3Uzq+CTDYDTi44g3Lzz0PMw6kJS
         dc2X2Eyuj+WK4bXo0U0rHey4uX+ujgKzw5x1vZt+W7eArzc2dB+xJiJkmlpR5WHD8Nzf
         +h2g==
X-Gm-Message-State: ACrzQf1uIhZxFvcGqae5ls8XIeU/IjLCv4+N/pJf128XnVWnLxxRxTiM
        5w5aZ9Zljekgsx4FVlcLyUc=
X-Google-Smtp-Source: AMsMyM7sKKoKZPF7OajApXBcH9gnY/xelKkIALaQi5/UQI5v92qoBDhlVKNCJ1myXqDizlCR9tzFmw==
X-Received: by 2002:a17:90b:38cb:b0:203:100:bb53 with SMTP id nn11-20020a17090b38cb00b002030100bb53mr944531pjb.107.1664993034172;
        Wed, 05 Oct 2022 11:03:54 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001788494b764sm10674639plc.231.2022.10.05.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:53 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: mempool: extract common initialization code
Date:   Wed,  5 Oct 2022 11:03:38 -0700
Message-Id: <20221005180341.1738796-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221005180341.1738796-1-shy828301@gmail.com>
References: <20221005180341.1738796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the common initialization code to __mempool_init() and
__mempool_create().  This will make adding mempool bulk init
code easier.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/mempool.c | 57 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 96488b13a1ef..ba32151f3843 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -176,9 +176,10 @@ void mempool_destroy(mempool_t *pool)
 }
 EXPORT_SYMBOL(mempool_destroy);
 
-int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		      mempool_free_t *free_fn, void *pool_data,
-		      gfp_t gfp_mask, int node_id)
+static inline int __mempool_init(mempool_t *pool, int min_nr,
+				 mempool_alloc_t *alloc_fn,
+				 mempool_free_t *free_fn, void *pool_data,
+				 gfp_t gfp_mask, int node_id)
 {
 	spin_lock_init(&pool->lock);
 	pool->min_nr	= min_nr;
@@ -208,6 +209,14 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 
 	return 0;
 }
+
+int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
+		      mempool_free_t *free_fn, void *pool_data,
+		      gfp_t gfp_mask, int node_id)
+{
+	return __mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+			      gfp_mask, node_id);
+}
 EXPORT_SYMBOL(mempool_init_node);
 
 /**
@@ -227,12 +236,31 @@ EXPORT_SYMBOL(mempool_init_node);
 int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		 mempool_free_t *free_fn, void *pool_data)
 {
-	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
-				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
+	return __mempool_init(pool, min_nr, alloc_fn, free_fn,
+			      pool_data, GFP_KERNEL, NUMA_NO_NODE);
 
 }
 EXPORT_SYMBOL(mempool_init);
 
+static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+				   mempool_free_t *free_fn, void *pool_data,
+				   gfp_t gfp_mask, int node_id)
+{
+	mempool_t *pool;
+
+	pool = kzalloc_node(sizeof(*pool), gfp_mask, node_id);
+	if (!pool)
+		return NULL;
+
+	if (__mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+			   gfp_mask, node_id)) {
+		kfree(pool);
+		return NULL;
+	}
+
+	return pool;
+}
+
 /**
  * mempool_create - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
@@ -252,8 +280,8 @@ EXPORT_SYMBOL(mempool_init);
 mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	return mempool_create_node(min_nr, alloc_fn, free_fn, pool_data,
-				   GFP_KERNEL, NUMA_NO_NODE);
+	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+				GFP_KERNEL, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(mempool_create);
 
@@ -261,19 +289,8 @@ mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 			       mempool_free_t *free_fn, void *pool_data,
 			       gfp_t gfp_mask, int node_id)
 {
-	mempool_t *pool;
-
-	pool = kzalloc_node(sizeof(*pool), gfp_mask, node_id);
-	if (!pool)
-		return NULL;
-
-	if (mempool_init_node(pool, min_nr, alloc_fn, free_fn, pool_data,
-			      gfp_mask, node_id)) {
-		kfree(pool);
-		return NULL;
-	}
-
-	return pool;
+	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+				gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_create_node);
 
-- 
2.26.3

