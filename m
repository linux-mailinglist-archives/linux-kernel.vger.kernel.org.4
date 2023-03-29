Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2F6CF244
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjC2SiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2SiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:38:04 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04195FF5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:37:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680115076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z4DPZvfjlbyZR04Gs5VqWFFoeLvvcar/vhfVx7MEdnM=;
        b=tIO3PhiOR2emercQwp44M6baOhhxEcQzHduTG2CPuKla6sVHmxWnHM9YWmEeKX28DgvZCV
        9A+wF0Dv2nb8xskHclLbAXuQUuMRdY7xvjnkSyquQNWXMA6uaxWiNQqgVyLwJFW+XmE4Iy
        wvEeIkQDa8WA5AxpvHMez3p9xsgBnf0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 1/5] kasan: drop empty tagging-related defines
Date:   Wed, 29 Mar 2023 20:37:44 +0200
Message-Id: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

mm/kasan/kasan.h provides a number of empty defines for a few
arch-specific tagging-related routines, in case the architecture code
didn't define them.

The original idea was to simplify integration in case another architecture
starts supporting memory tagging. However, right now, if any of those
routines are not provided by an architecture, Hardware Tag-Based KASAN
won't work.

Drop the empty defines, as it would be better to get compiler errors
rather than runtime crashes when adding support for a new architecture.

Also drop empty hw_enable_tagging_sync/async/asymm defines for
!CONFIG_KASAN_HW_TAGS case, as those are only used in mm/kasan/hw_tags.c.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index a61eeee3095a..b1895526d02f 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -395,28 +395,6 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 
-#ifndef arch_enable_tagging_sync
-#define arch_enable_tagging_sync()
-#endif
-#ifndef arch_enable_tagging_async
-#define arch_enable_tagging_async()
-#endif
-#ifndef arch_enable_tagging_asymm
-#define arch_enable_tagging_asymm()
-#endif
-#ifndef arch_force_async_tag_fault
-#define arch_force_async_tag_fault()
-#endif
-#ifndef arch_get_random_tag
-#define arch_get_random_tag()	(0xFF)
-#endif
-#ifndef arch_get_mem_tag
-#define arch_get_mem_tag(addr)	(0xFF)
-#endif
-#ifndef arch_set_mem_tag_range
-#define arch_set_mem_tag_range(addr, size, tag, init) ((void *)(addr))
-#endif
-
 #define hw_enable_tagging_sync()		arch_enable_tagging_sync()
 #define hw_enable_tagging_async()		arch_enable_tagging_async()
 #define hw_enable_tagging_asymm()		arch_enable_tagging_asymm()
@@ -430,10 +408,6 @@ void kasan_enable_tagging(void);
 
 #else /* CONFIG_KASAN_HW_TAGS */
 
-#define hw_enable_tagging_sync()
-#define hw_enable_tagging_async()
-#define hw_enable_tagging_asymm()
-
 static inline void kasan_enable_tagging(void) { }
 
 #endif /* CONFIG_KASAN_HW_TAGS */
-- 
2.25.1

