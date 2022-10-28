Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5F61165F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ1PxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1PxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:53:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FF40BCA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 130so5110161pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RapN0FTxN0zsMZ08z7ppgL1l1wyHKn49LaZIgsPjjY=;
        b=g57PKyGkXUSjFuuJXbpUb8o0hZzb0pSDdLmQ0suvld/9O/Q0Zr2XM4eDKPqyJWUUoQ
         jFOg2gH9teVe2ny/kt7qB+WwYLlxnEGRwnB/2ntgiH0GEayB4vdVH0fPGykEr/b5VFdC
         ZenFcOnYoxGAKrORcvhogQoYs7mJaA2v5uNt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RapN0FTxN0zsMZ08z7ppgL1l1wyHKn49LaZIgsPjjY=;
        b=LzurDVQXy9QpSez8R+9vT3ljX1h6Psj2RM+6exr795qJDhYFoL1oOQtvz0dnsjj7Hz
         YE9/wcOtR5P984HajKgsTo7LaFcwRJTIYPZvxyKfZ3Oe3R8Gu6TwMUiDylVkzplOtT63
         vV+89X/qTerZ4+IEvQTQwLrV/WIq120M/88uY6nSOGiVj6TUXH/F3Xih6rxPuidroO/d
         /VpPZG42/Ptk3jgfejYtlqCi1hhYzHgBofNx8Pbsj6CjFu/zbBEhWewF/jKwNy2NLuCw
         i06i4vobQEPl26Dk2+VozUGu1V+PvA4fmEDEQs2fFEJL62a3JODWoSHyUm8yYyJP3zGI
         BWDw==
X-Gm-Message-State: ACrzQf19wVSRD1dtTsJwgwjWfRXVHq8aCBiWxmRYMjNwDDAS3qeNB4TK
        Pkpt31/S22JTNTJkMoytTmG4rg==
X-Google-Smtp-Source: AMsMyM6AI4VTAtK8hxaa4lpLNKTA8GWdsFpVy9579gMbjiE7P/0qXp5nawV03T22J+f7cp7qn8CF/Q==
X-Received: by 2002:a65:5c0c:0:b0:46e:f582:7378 with SMTP id u12-20020a655c0c000000b0046ef5827378mr195653pgr.120.1666972386070;
        Fri, 28 Oct 2022 08:53:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00000400b0053e4baecc14sm3024810pfk.108.2022.10.28.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:53:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4] mempool: Do not use ksize() for poisoning
Date:   Fri, 28 Oct 2022 08:53:01 -0700
Message-Id: <20221028154823.you.615-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; h=from:subject:message-id; bh=GsDEuQtQBehTnbCGH+DSrMKEOKg+OzR12RyNGPx7PEg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjW/rde6AlUoHw2yv4ICZYBd0pOTO/KK1WOZNXH+JX McX6voGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1v63QAKCRCJcvTf3G3AJofhEA CPPoNca2ZmUW3btRJPcPRFmWI7syDPpe2FAISaMnR9iRv/QVVTD2mr455X1lyFOIYVhH4DTPcux+k0 sEZhsoukzUH9IruZbDUxIZcGHWrfx/Ql1K37O73ygMV70nplbn0vsXXhL9Bjrql8yQbhHLhZB55F7E uhzIVjJtt1WmWjZmCTkLfnqBh0khW0nPBGZmGA2H8xKj9rGWfkdvQOvRxmAjInn+8tS1C8G3qvg4Aa x5A3uD40YTYb39yrB35KCZAZ3AAK/2HpRGJXhDRwf+KKr8UBuv/ZKwtl0uc8EGrxqzTd0wvij78ORU 7Sp32tJUDTVHixO5mf0u4ualW4epFWQEJyBRmLDhTeYjIaY59F7v8mGkmOCgBTB6e1ynLDErk+7dPt LgA5q/TAD19RDO1H/20IYnaYsJAwh9u1lQb5DF2q1gVxOcIwmG1rMq5qPRsLJMn5hXja9JSWCNLgWg CgZtaGq7G5e++BP2sgPYHw3+vxGhm8hcCXsoU/+8xrs52MwdkOjAVgk+WRdHSfzvPd60b5ELHZRNCx SOCaxipTY6GG0e+TsCJgtR3Ne8+0sDA5MVEFh+582MNGSECHMJwUwpRwYMscwr7BYrWg+WQcWUp7GR aq9xH/OtBDw7g+ImGw8UfnkI2o8xpvMAt98io1m6aisddmYX9/ZSMM6PmfYQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing appears to be using ksize() within the kmalloc-backed mempools
except the mempool poisoning logic. Use the actual pool size instead
of the ksize() to avoid needing any special handling of the memory as
needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
Cc: David Rientjes <rientjes@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This replaces mempool-use-kmalloc_size_roundup-to-match-ksize-usage.patch
v4: add review/ack tags, explicitly call out subject change
v3: https://lore.kernel.org/lkml/20221025233421.you.825-kees@kernel.org/
v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
---
 mm/mempool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 96488b13a1ef..54204065037d 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -58,7 +58,7 @@ static void check_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
 	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
-		__check_element(pool, element, ksize(element));
+		__check_element(pool, element, (size_t)pool->pool_data);
 	} else if (pool->free == mempool_free_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -81,7 +81,7 @@ static void poison_element(mempool_t *pool, void *element)
 {
 	/* Mempools backed by slab allocator */
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
-		__poison_element(element, ksize(element));
+		__poison_element(element, (size_t)pool->pool_data);
 	} else if (pool->alloc == mempool_alloc_pages) {
 		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
@@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_unpoison_range(element, __ksize(element));
+		kasan_unpoison_range(element, (size_t)pool->pool_data);
 	else if (pool->alloc == mempool_alloc_pages)
 		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
 				     false);
-- 
2.34.1

