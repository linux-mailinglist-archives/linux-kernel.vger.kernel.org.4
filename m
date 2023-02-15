Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E2697C94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjBONBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjBONBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:01:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7ACA3B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CF261B94
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6819BC4339B;
        Wed, 15 Feb 2023 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676466076;
        bh=gjHAHHqwYm8o1x992R2kWv27BpeHlDcrRDtNIB6oM0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0VoQz6vcJRMvwJmX8jY9JYLJ6IEQOqKG5hN5MD23CQx5K1TPX4HjelS4VNioCyw3
         rRxumsiccf2phYjGDdQoD3SeM5AZmc6cvjwZOvxHWTc7NiBmbiL8nPtDgsnB1Jq3VH
         JAYDeL/C0k2JAfyi1BNJVf4BvguAmuyg/PmI++jrkzaYSGIN8RysFq6bJzEuLGj04Q
         HT0tIBlddiEC6XTcvgm7A2hdOIx6kcZAuIlkjEwzBSYfje5AnZ3Aq+bpjPsBy105BX
         37oYXOxUG6vwUT06gEDFQ/0EXnoWg6kDAOGQfeO58yaYtOsG3XL1eXaETFTDTIozDq
         APgN5Cqa7Mg9g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] kasan: mark addr_has_metadata __always_inline
Date:   Wed, 15 Feb 2023 14:00:56 +0100
Message-Id: <20230215130058.3836177-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215130058.3836177-1-arnd@kernel.org>
References: <20230215130058.3836177-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

When the compiler decides not to inline this function, objtool
complains about incorrect UACCESS state:

mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix objdump/objtool typo
---
 mm/kasan/kasan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3231314e071f..9377b0789edc 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -297,7 +297,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
 		<< KASAN_SHADOW_SCALE_SHIFT);
 }
 
-static inline bool addr_has_metadata(const void *addr)
+static __always_inline bool addr_has_metadata(const void *addr)
 {
 	return (kasan_reset_tag(addr) >=
 		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
@@ -316,7 +316,7 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
-static inline bool addr_has_metadata(const void *addr)
+static __always_inline bool addr_has_metadata(const void *addr)
 {
 	return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
 }
-- 
2.39.1

