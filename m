Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616866E1E49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDNIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDNIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6A6E9F;
        Fri, 14 Apr 2023 01:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16EE9644E4;
        Fri, 14 Apr 2023 08:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48916C433EF;
        Fri, 14 Apr 2023 08:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681460997;
        bh=ZTCTGs1pRDDeWJeFuWw6MUiRlW5oe3Xoqp/dtRXoY0o=;
        h=From:To:Cc:Subject:Date:From;
        b=MAc0WdvtaHTQOVtkR71fygSK181HZrRel+3IJliSMjR6cKg5dK5tzRhJDo1C1DnAE
         hRdOVKQ2Ip5CbFSmSU84TD3LjP7ZdbPWd1iGEkvtwgrXmdrDrxZL24zdDQq+t+5R+e
         aBVFLXTpI+fCGZ3onY6KnK+j5ZusS2MaxSB+PvBvc3oEf6H0ezQa+ujnG4ohFqS2/X
         K3N4MPlM3l668EE6yYNPGiaLVybR+oBVjQjHPIMuXLoVCdfMrdS7JE3jrGlZiCg4Bn
         INujmut/VQNgRi7hYKV5qlcf99alLjF5ILdUr25hqG42/inaD3nS1f2NgXnfW4/B0X
         uMTHV4E9s7kmQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for clang-14
Date:   Fri, 14 Apr 2023 10:29:27 +0200
Message-Id: <20230414082943.1341757-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Unknown -mllvm options don't cause an error to be returned by clang, so
the cc-option helper adds the unknown hwasan-kernel-mem-intrinsic-prefix=1
flag to CFLAGS with compilers that are new enough for hwasan but too
old for this option. This causes a rather unreadable build failure:

fixdep: error opening file: scripts/mod/.empty.o.d: No such file or directory
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:252: scripts/mod/empty.o] Error 2
fixdep: error opening file: scripts/mod/.devicetable-offsets.s.d: No such file or directory
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 2

Add a version check to only allow this option with clang-15, gcc-13
or later versions.

Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There is probably a better way to do this than to add version checks,
but I could not figure it out.
---
 scripts/Makefile.kasan | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index c186110ffa20..2cea0592e343 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -69,7 +69,12 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 		$(instrumentation_flags)
 
 # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
+ifeq ($(call clang-min-version, 150000),y)
 CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+endif
+ifeq ($(call gcc-min-version, 130000),y)
+CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+endif
 
 endif # CONFIG_KASAN_SW_TAGS
 
-- 
2.39.2

