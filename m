Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663C6978C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjBOJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjBOJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:15:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BAD1C580
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 606E7B81DD3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F5C433EF;
        Wed, 15 Feb 2023 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676452514;
        bh=y7cRkpJo09cGA0dkXsSsNSqsjGzXn7zaL3SZgVnqhDk=;
        h=From:To:Cc:Subject:Date:From;
        b=AUqnqPEahiAxrb0RqO+5l9ghbt0rDwjtL3IygPOI7nTrg+eUwn37hXxWnpUQCuKiX
         LWX7o+FYS/mGpvEY6i9wttSPeLH71n2+y9xe4xycq1YJ/wIxEKLAfvxmlh9Ipfn6PC
         rGlgvBaFe2p5zO0MZE6RkWyAzE2BdBzRwcXPvewrLPXdk7Y6I13jFAUbfHfte1PutH
         zQPBQtEtT2qLBrNnGzxhT6oZZ4V46CnS1htnGkgoJz35WXA0JCZNrkeVYxpUrCo68f
         YvvupsLYlN+qumTyiZ2BpxGvDlaLH2ShHOJDwfzviLpmhYIB8ryEFU3Eev11h+c2RL
         qTPgF1xvxpQeQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
Date:   Wed, 15 Feb 2023 10:14:48 +0100
Message-Id: <20230215091503.1490152-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building a kcsan enabled kernel for x86_64 with gcc-11 results in a lot
of build warnings or errors without CONFIG_CONSTRUCTORS:

x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/copy_mc.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/cpu.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/csum-partial_64.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/csum-wrappers_64.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/insn-eval.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/insn.o'
x86_64-linux-ld: error: unplaced orphan section `.ctors.65436' from `arch/x86/lib/misc.o'

The same thing has been reported for mips64. I can't reproduce it for
any other compiler version, so I don't know if constructors are always
required here or if this is a gcc-11 specific implementation detail.

I see no harm in always enabling constructors here, and this reliably
fixes the build warnings for me.

Link: https://lore.kernel.org/lkml/202204181801.r3MMkwJv-lkp@intel.com/T/
Cc: Kees Cook <keescook@chromium.org>
See-also: 3e6631485fae ("vmlinux.lds.h: Keep .ctors.* with .ctors")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.kcsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 4dedd61e5192..609ddfc73de5 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -14,6 +14,7 @@ menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
 	depends on DEBUG_KERNEL && !KASAN
+	select CONSTRUCTORS
 	select STACKTRACE
 	help
 	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
-- 
2.39.1

