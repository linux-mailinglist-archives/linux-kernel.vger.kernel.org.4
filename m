Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F365604BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiJSPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiJSPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56017426;
        Wed, 19 Oct 2022 08:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5160EB824B0;
        Wed, 19 Oct 2022 15:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A20C4347C;
        Wed, 19 Oct 2022 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193842;
        bh=JRwAyHnjrSY03iEK2UKGtcgr2ehNnH9vwZJpBiLAoiY=;
        h=Date:From:To:Cc:Subject:From;
        b=rdDLnjfbZF01xbQOhru7EnqH+Ewbk9fsNyDOUpL3Y4xRw0b61GJ5SXvEcKn7qZm10
         i9gOgMcvjdqZAL0zhZqN2Xiq4OweM8IcwJKC4hvgllOmamT3Gzbcb9Z1KroSX2dQfm
         ZlZrsCHoT+Ww2bSM6WN9Elic9hpx8qkl8iGcWjhW8u83fxwyER1+rVZiVEH+A0RU0O
         /cVQ5LIXHJ2Tmx3KYx7V6KVawsnV610LmNyHjNnk6s4EylkQpiar/HVBxXkJgIosQG
         IdaeuMuso4QH2fIZGUO4mDxYu+6je++vaRD+fSerOnaNpRrVF3YniHhsA4v9LtE4Id
         PGa/VPMFLXDlQ==
Date:   Wed, 19 Oct 2022 08:37:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: -Wmacro-redefined in include/linux/fortify-string.h
Message-ID: <Y1AZr01X1wvg5Klu@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am seeing the following set of warnings when building an x86_64
configuration that has CONFIG_FORTIFY_SOURCE=y and CONFIG_KMSAN=y:

  In file included from scripts/mod/devicetable-offsets.c:3:
  In file included from ./include/linux/mod_devicetable.h:13:
  In file included from ./include/linux/uuid.h:12:
  In file included from ./include/linux/string.h:253:
  ./include/linux/fortify-string.h:496:9: error: 'memcpy' macro redefined [-Werror,-Wmacro-redefined]
  #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
          ^
  ./arch/x86/include/asm/string_64.h:17:9: note: previous definition is here
  #define memcpy __msan_memcpy
          ^
  In file included from scripts/mod/devicetable-offsets.c:3:
  In file included from ./include/linux/mod_devicetable.h:13:
  In file included from ./include/linux/uuid.h:12:
  In file included from ./include/linux/string.h:253:
  ./include/linux/fortify-string.h:500:9: error: 'memmove' macro redefined [-Werror,-Wmacro-redefined]
  #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
          ^
  ./arch/x86/include/asm/string_64.h:73:9: note: previous definition is here
  #define memmove __msan_memmove
          ^
  2 errors generated.

I can see that commit ff901d80fff6 ("x86: kmsan: use __msan_ string
functions where possible.") appears to include a fix up for this warning
with memset() but not memcpy() or memmove(). If I apply a similar fix up
like so:

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 4029fe368a4f..718ee17b31e3 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -493,6 +493,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
  * __struct_size() vs __member_size() must be captured here to avoid
  * evaluating argument side-effects further into the macro layers.
  */
+#ifndef CONFIG_KMSAN
 #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
 		__struct_size(p), __struct_size(q),			\
 		__member_size(p), __member_size(q),			\
@@ -501,6 +502,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		__struct_size(p), __struct_size(q),			\
 		__member_size(p), __member_size(q),			\
 		memmove)
+#endif
 
 extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
 __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)

Then the instances of -Wmacro-redefined disappear but the fortify tests
no longer pass for somewhat obvious reasons:

  warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memcpy.c
  warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
  warning: unsafe memcpy() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memcpy.c
  warning: unsafe memmove() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memmove.c
  warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
  warning: unsafe memmove() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memmove.c
  warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memset.c
  warning: unsafe memcpy() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memcpy.c
  warning: unsafe memmove() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memmove.c
  warning: unsafe memset() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memset.c

Should CONFIG_KMSAN depend on CONFIG_FORTIFY_SOURCE=n like so? It seems
like the two features are incompatible if I am reading ff901d80fff6
correctly.

diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
index b2489dd6503f..6a681621e3c5 100644
--- a/lib/Kconfig.kmsan
+++ b/lib/Kconfig.kmsan
@@ -11,7 +11,7 @@ config HAVE_KMSAN_COMPILER
 config KMSAN
 	bool "KMSAN: detector of uninitialized values use"
 	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
-	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
+	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN && !FORTIFY_SOURCE
 	select STACKDEPOT
 	select STACKDEPOT_ALWAYS_INIT
 	help

or is there a different obvious fix that I am missing?

Cheers,
Nathan
