Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4946B72829E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjFHOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbjFHOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABE30C3;
        Thu,  8 Jun 2023 07:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D62B264E20;
        Thu,  8 Jun 2023 14:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A036C433A0;
        Thu,  8 Jun 2023 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234278;
        bh=7ZPyZ9apG1M05E0n0MB6gFR/gnPXwymtgzxIDVjhPog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyb/aRQonk8gbaoHdI0/Cb4ItgDLwxIK+DRpbx0KcKc6rNJ6Rpj7K2KQKpzmumDnE
         WdoNs13V76MCdMdX41tTHvhd5gocZxNMJEERi+nfhLvD9G4pTxmLMApimqHyX0L624
         t4x+22sxF1nQMKsXUZNPeEion4PCNsIBz8S6PkOgZJ9Qxtcjj2th9w1H4u/onrZWcR
         YwxVkKN4TQA7V4Fl4JLvBPwXVE6EZ6t49WjXaMMKaPucewyNKER1YTMUKrXUqI2n5k
         VGJi/w9oqzpuvrSUmQueff5KNiMOeypROw8NYKdqqIjd158V/EnZqu6id2PKTe1LUF
         4J3jIFYyTWWcg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v7 01/11] Revert "[PATCH] uml: export symbols added by GCC hardened"
Date:   Thu,  8 Jun 2023 23:24:18 +0900
Message-Id: <20230608142428.256985-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608142428.256985-1-masahiroy@kernel.org>
References: <20230608142428.256985-1-masahiroy@kernel.org>
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

This reverts commit cead61a6717a9873426b08d73a34a325e3546f5d.

It exported __stack_smash_handler and __guard, while they may not be
defined by anyone.

The code *declares* __stack_smash_handler and __guard. It does not
create weak symbols. When the stack-protector is disabled, they are
left undefined, but yet exported.

If a loadable module tries to access non-existing symbols, bad things
(a page fault, NULL pointer dereference, etc.) will happen. So, the
current code is wrong.

If the code were written as follows, it would *define* them as weak
symbols so modules would be able to get access to them.

  void (*__stack_smash_handler)(void *) __attribute__((weak));
  EXPORT_SYMBOL(__stack_smash_handler);

  long __guard __attribute__((weak));
  EXPORT_SYMBOL(__guard);

In fact, modpost forbids exporting undefined symbols. It shows an error
message if it detects such a mistake.

  ERROR: modpost: "..." [...] was exported without definition

Unfortunately, it is checked only when the code is built as modular.
The problem described above has been unnoticed for a long time because
arch/um/os-Linux/user_syms.c is always built-in.

With a planned change in Kbuild, exporting undefined symbols will always
result in a build error instead of a run-time error. It is a good thing,
but we need to fix the breakage in advance.

One fix is to *define* weak symbols as shown above. An alternative is
to export them conditionally as follows:

  #ifdef CONFIG_STACKPROTECTOR
  extern void __stack_smash_handler(void *);
  EXPORT_SYMBOL(__stack_smash_handler);

  external long __guard;
  EXPORT_SYMBOL(__guard);
  #endif

This is what other architectures do; EXPORT_SYMBOL(__stack_chk_guard)
is guarded by #ifdef CONFIG_STACKPROTECTOR.

However, adding the #ifdef guard is not sensible because UML cannot
enable the stack-protector in the first place! (Please note UML does
not select HAVE_STACKPROTECTOR in Kconfig.)

So, the code is already broken (and unused) in multiple ways.

Just remove.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v7:
  - New patch

 arch/um/os-Linux/user_syms.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 9b62a9d352b3..a310ae27b479 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -37,13 +37,6 @@ EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
 #endif
 
-/* Export symbols used by GCC for the stack protector. */
-extern void __stack_smash_handler(void *) __attribute__((weak));
-EXPORT_SYMBOL(__stack_smash_handler);
-
-extern long __guard __attribute__((weak));
-EXPORT_SYMBOL(__guard);
-
 #ifdef _FORTIFY_SOURCE
 extern int __sprintf_chk(char *str, int flag, size_t len, const char *format);
 EXPORT_SYMBOL(__sprintf_chk);
-- 
2.39.2

