Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64864FE65
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiLRKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 05:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiLRKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 05:19:31 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EEDEE3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:30 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a9so6393815pld.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 02:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvPBeK/uQOTkS5bCd9KHq/uJNQrs6bRmNyv7cBW90YM=;
        b=cRiTctr0c+Y3PZWbi7kGhJ+34MYU3MF+KKnkl+m0yvYmeh883ce+JGBji2dZkDL2Wo
         hjL9TAemPLQTDRquzBzZeh7gEX9K3HNYkHV9ZLZRDL/TKyUe+k5cg4kICjxEiUuvvHzT
         /vjo03Bq5Fa77BDp79CFdE+HJdkWVffsveAnjyPESBtjDEWf9g6LV007LJr9icmfaraT
         gHoQiwsNbbjf8JegEPhFcZi7XGz0hJeLpj0Vp09qF6fDBlDkBxajEVETAzGafjUiRTKy
         mugTC9WZqfGT42wqXkQrr+4GNPLFab7/vpOtwly1RRFOOudqMFYz5g8lbt3jqqjaOK5W
         tGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvPBeK/uQOTkS5bCd9KHq/uJNQrs6bRmNyv7cBW90YM=;
        b=pafbpO8AJf9TK1B87KpiGAhXLxsnLM+9RmdUP718yjlcG0V/XDDyoylBlczNVT3dtV
         HVMMxqkaW39WCP5qdWJ7dSmfAWHEnSDjudAc2JThQgtyttpW6kXFIOeLYdZ9AQdE3hfL
         KAIvSEHWpp8CaF/kG4T3wOQQiLV6znmE/sbSWtgZfd8DL17CvpKtoLOPtrJ8y9khtdKB
         yBhL9eJLhe5c1y1A1lQKVtvqvN5G6vXA94N28WXu3b0W2nfM51Dm4BU87WCVJ7AWE7Pf
         y0Wa4PdM2xE2PuIALX8LTmv9jQPkBSVSm/aQAT5ijxaCzSitMuo/8ogUwD7berSugvTD
         VZCA==
X-Gm-Message-State: ANoB5pklci6xQQuLQGaqOSAlPZvdx6GIh5GX6QMPo7eKNqk0BG6tdbnZ
        eDht9CFjUV1Ij8psDfDaFo0=
X-Google-Smtp-Source: AA0mqf6JsU6eO2pxoS+w8HrBGNWmgAWd/51Yb3PiWN6hBjoaQOTnmocm7rbasPDj7XkU/fiBlRC6nw==
X-Received: by 2002:a17:902:b618:b0:189:af28:fd8d with SMTP id b24-20020a170902b61800b00189af28fd8dmr37386097pls.1.1671358770040;
        Sun, 18 Dec 2022 02:19:30 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm4789791plb.53.2022.12.18.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:19:29 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from action_page_types
Date:   Sun, 18 Dec 2022 19:18:58 +0900
Message-Id: <20221218101901.373450-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221218101901.373450-1-42.hyeyoo@gmail.com>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Naoya [1], identify_page_state() is never
called when handling memory error on a slab page.

Clean this up before moving PG_slab flag to page_type in later patch.

[1] https://lore.kernel.org/linux-mm/Y2s+dnBsHAJu19ob@hyeyoo/#r

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/memory-failure.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c77a9e37e27e..74ad1db989e3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -783,7 +783,6 @@ static const char *action_name[] = {
 static const char * const action_page_types[] = {
 	[MF_MSG_KERNEL]			= "reserved kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
-	[MF_MSG_SLAB]			= "kernel slab page",
 	[MF_MSG_DIFFERENT_COMPOUND]	= "different compound page after locking",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
@@ -1146,7 +1145,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 #define mlock		(1UL << PG_mlocked)
 #define lru		(1UL << PG_lru)
 #define head		(1UL << PG_head)
-#define slab		(1UL << PG_slab)
 #define reserved	(1UL << PG_reserved)
 
 static struct page_state error_states[] = {
@@ -1156,13 +1154,6 @@ static struct page_state error_states[] = {
 	 * PG_buddy pages only make a small fraction of all free pages.
 	 */
 
-	/*
-	 * Could in theory check if slab page is free or if we can drop
-	 * currently unused objects without touching them. But just
-	 * treat it as standard kernel for now.
-	 */
-	{ slab,		slab,		MF_MSG_SLAB,	me_kernel },
-
 	{ head,		head,		MF_MSG_HUGE,		me_huge_page },
 
 	{ sc|dirty,	sc|dirty,	MF_MSG_DIRTY_SWAPCACHE,	me_swapcache_dirty },
@@ -1189,7 +1180,6 @@ static struct page_state error_states[] = {
 #undef mlock
 #undef lru
 #undef head
-#undef slab
 #undef reserved
 
 /*
-- 
2.32.0

