Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB67466B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGDA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:57:33 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 17:57:32 PDT
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80956137
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:57:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688431928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9PvMF+hM/tczQlWv3CZcoKeqGsQQ6VNHOk9FPhNfzNc=;
        b=QYXS2UfB9fTOuQpIwrkK8of/jfOc1fLqLKs6PHdxgbFg8nLcpk3/ConRj1BiU7j0WCo28n
        daS2Mm1suhkZfCV9ZqOjFCpyOONbNFubKyg6htLLwJBilt9OjYbjTlOpmT57JWEevu0M2T
        nWPQm6VALEzldSnhheqDa/Q0KUbBky0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan: fix type cast in memory_is_poisoned_n
Date:   Tue,  4 Jul 2023 02:52:05 +0200
Message-Id: <8c9e0251c2b8b81016255709d4ec42942dcaf018.1688431866.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Commit bb6e04a173f0 ("kasan: use internal prototypes matching gcc-13
builtins") introduced a bug into the memory_is_poisoned_n implementation:
it effectively removed the cast to a signed integer type after applying
KASAN_GRANULE_MASK.

As a result, KASAN started failing to properly check memset, memcpy,
and other similar functions.

Fix the bug by adding the cast back (through an additional signed integer
variable to make the code more readable).

Fixes: bb6e04a173f0 ("kasan: use internal prototypes matching gcc-13 builtins")
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 5b4c97baa656..4d837ab83f08 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -130,9 +130,10 @@ static __always_inline bool memory_is_poisoned_n(const void *addr, size_t size)
 	if (unlikely(ret)) {
 		const void *last_byte = addr + size - 1;
 		s8 *last_shadow = (s8 *)kasan_mem_to_shadow(last_byte);
+		s8 last_accessible_byte = (unsigned long)last_byte & KASAN_GRANULE_MASK;
 
 		if (unlikely(ret != (unsigned long)last_shadow ||
-			(((long)last_byte & KASAN_GRANULE_MASK) >= *last_shadow)))
+			     last_accessible_byte >= *last_shadow))
 			return true;
 	}
 	return false;
-- 
2.25.1

