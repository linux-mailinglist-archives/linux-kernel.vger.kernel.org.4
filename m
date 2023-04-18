Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0F6E612F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDRMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDRMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:24:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5E4C28;
        Tue, 18 Apr 2023 05:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4125A630F2;
        Tue, 18 Apr 2023 12:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6D4C4339B;
        Tue, 18 Apr 2023 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681820637;
        bh=Pl7qe1hAnrP+LtVJ6K+2U2pcxRX/WcQvra5GGhz/u6E=;
        h=From:To:Cc:Subject:Date:From;
        b=ZV5ApDRAANpiHhaO421exFkJL+f9/cyKqYJDClXnFpP78N6NHpc5acuTMCnwrO5U+
         yCTXwgMlGU294bLFzBnsTvW3IrY/19mThftD5ndrMlJF6WfhoILio9vlCt7Xtl3H3n
         yxin7yexwPHB8ClnOsuilIDEhl6Knw7pBX6Lxn3YKFksCb7LiI2zNV2oKJ3p7kXrzh
         dwCdXOKtbHDSI+YXtuQ2bxjqFmFODE550Wu4Imp9G7LCmBAXbmV4kExNEd5urcqEpn
         Tl3FCJUTPuqIFgPZhQWwitBhAmTa3+jTd6FZ3UCq5z8j/nO74a7RlVmBXr0WmgKjhn
         khRNdTpQgffaQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        kasan-dev@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] [v2] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for clang-14
Date:   Tue, 18 Apr 2023 14:23:35 +0200
Message-Id: <20230418122350.1646391-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some unknown -mllvm options (i.e. those starting with the letter "h")
don't cause an error to be returned by clang, so the cc-option helper
adds the unknown hwasan-kernel-mem-intrinsic-prefix=1 flag to CFLAGS
with compilers that are new enough for hwasan but too old for this option.

This causes a rather unreadable build failure:

fixdep: error opening file: scripts/mod/.empty.o.d: No such file or directory
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:252: scripts/mod/empty.o] Error 2
fixdep: error opening file: scripts/mod/.devicetable-offsets.s.d: No such file or directory
make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 2

Add a version check to only allow this option with clang-15, gcc-13
or later versions.

Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
Link: https://lore.kernel.org/all/CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use one-line version check for both clang and gcc, clarify changelog text
---
 scripts/Makefile.kasan | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index c186110ffa20..390658a2d5b7 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -69,7 +69,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
 		$(instrumentation_flags)
 
 # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
+ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
 CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
+endif
 
 endif # CONFIG_KASAN_SW_TAGS
 
-- 
2.39.2

