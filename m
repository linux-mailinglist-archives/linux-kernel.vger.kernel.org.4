Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F80627CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiKNLtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiKNLsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:48:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093C26570
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E0CDB80E72
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E91DC43470;
        Mon, 14 Nov 2022 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426339;
        bh=88jaPx4iCX4zMvSz58mQ2Zj5p3k63uCxoL6FcunYz3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivICbmQi7wHzNyqcXXy2gBkoVBoBCTmkhvCzCikjByib4s8RaoY1lW4WmY9i9fJB5
         fYZtyMMcxvFxBADEGFKQdsa3WruxjgLmBiWGmXivBeRy8kLTjLOmEAweToWxhQ6yz+
         x0LdG1T+pvu8StRDeYlGH0Tdyy/ePWCQ/Sv+rDu7l45RUSDts6OddVrDlDVLJAdfl8
         +GmcClU8zPprpmtMhRrIPMLXfJ8PvLzwBu49jJzmOaY+cmjBFdgkwJ1Rc5viBYm/GK
         /AbTQVDinVxn/OvJ40QkgSYd9IXHHQ9KE/H5v6KLBpoVlHLMGb92iJ1uONOwOTZGtC
         5+9YnP17R7gUg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Liska <mliska@suse.cz>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 42/46] mm/kasan, lto: Mark kasan mem{cpy,move,set} as __used
Date:   Mon, 14 Nov 2022 12:43:40 +0100
Message-Id: <20221114114344.18650-43-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liska <mliska@suse.cz>

gcc doesn't always recognize that memcpy/set/move called through
__builtins are referenced because the reference happens too late in the
RTL expansion phase. This can make LTO to drop them, leading to
undefined symbols. Mark them as __used to avoid that.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 mm/kasan/shadow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 0e3648b603a6..94c98feea9c8 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -39,7 +39,7 @@ bool __kasan_check_write(const volatile void *p, unsigned int size)
 EXPORT_SYMBOL(__kasan_check_write);
 
 #undef memset
-void *memset(void *addr, int c, size_t len)
+__used void *memset(void *addr, int c, size_t len)
 {
 	if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
 		return NULL;
@@ -49,7 +49,7 @@ void *memset(void *addr, int c, size_t len)
 
 #ifdef __HAVE_ARCH_MEMMOVE
 #undef memmove
-void *memmove(void *dest, const void *src, size_t len)
+__used void *memmove(void *dest, const void *src, size_t len)
 {
 	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
 	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
@@ -60,7 +60,7 @@ void *memmove(void *dest, const void *src, size_t len)
 #endif
 
 #undef memcpy
-void *memcpy(void *dest, const void *src, size_t len)
+__used void *memcpy(void *dest, const void *src, size_t len)
 {
 	if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) ||
 	    !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
-- 
2.38.1

