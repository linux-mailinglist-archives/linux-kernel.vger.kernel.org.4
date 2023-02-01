Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD679E72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjAXQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjAXQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:20:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F947ED2;
        Tue, 24 Jan 2023 08:20:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98639CE1B8B;
        Tue, 24 Jan 2023 16:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07B1C4339C;
        Tue, 24 Jan 2023 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674577235;
        bh=aRLiN9Rsyo8xPFa8GOCkbKbw7dV6SfkqfYAeFSOYgxs=;
        h=From:Date:Subject:To:Cc:From;
        b=TkpOI/0NiTk9z0rTfC8nrx1Ojrb6PP4q7le9SEAX2GQ4NoY5apmkKcg4VHqkOwJgR
         1OpwJOgNpEpizlVRD022aIEsKCtcQ0oeWTE7u3QkRM1HrKfKTPfkEOYZXd+kpWrffc
         N11FIhuT26UeoZjxBjOJCeMIZB45upexUvxNNzUhmGK7uEeaCxyDSngYIiKevM0mdt
         FM0hGzkbQZ9+cCaeegyCRb+ON4GPSaE42/4A1GAoNNKhBC1OnlWF/3Q/R57rYijeme
         JKBfQXXbXmWb1SFBaWkQBJz6UWLqX7kKxq/SofWpnV4dVYfLvVgqq8tLRvfCLk1GB2
         zaZZWtxhTgJew==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 24 Jan 2023 09:19:28 -0700
Subject: [PATCH] powerpc/vdso: Filter clang's auto var init zero enabler
 when linking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230123-qunused-argument-auto-var-init-v1-1-ec06051f0d87@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA8F0GMC/x2NywqDMBAAf0Vy7oImhT5+pfSwmo3uwbXdTUQQ/
 72xx2FgZndGymTu2exOaWXjRSp0l8YNE8pIwLGy860PbecDfIsUowioY5lJMmDJC6yowMIZ7ki
 3R4wphmtyNdKjEfSKMkxnZkbLpKf4KCXe/ufX+zh+zp4/vokAAAA=
To:     masahiroy@kernel.org
Cc:     ndesaulniers@google.com, nicolas@fjasle.eu, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, trix@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2880; i=nathan@kernel.org;
 h=from:subject:message-id; bh=aRLiN9Rsyo8xPFa8GOCkbKbw7dV6SfkqfYAeFSOYgxs=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMkXWINyeA+F8bKssp4xy9m+wDLkyhX3o7Ltp+8rvrjmfWO5
 zc2PHaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAil/IY/pc/nP5YeJHor5Xfj5ZwLr
 h2f1fXFI7l3kpvWLb4ZWRyOtkw/E8/W/55xqu1mxcWv3vcfvTh5Ff3Z5x1suudJLjjZ2hKrTk3AA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 7bbf02b875b5 ("kbuild: Stop using '-Qunused-arguments' with
clang"), the PowerPC vDSO shows the following error with clang-13 and
older when CONFIG_INIT_STACK_ALL_ZERO is enabled:

  clang: error: argument unused during compilation: '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang' [-Werror,-Wunused-command-line-argument]

clang-14 added a change to make sure this flag never triggers
-Wunused-command-line-argument, so it is fixed with newer releases. For
older releases that the kernel still supports building with, just filter
out this flag, as has been done for other flags.

Fixes: b174f4c26aa3 ("powerpc/vdso: Improve linker flags")
Fixes: 7bbf02b875b5 ("kbuild: Stop using '-Qunused-arguments' with clang")
Link: https://github.com/llvm/llvm-project/commit/ca6d5813d17598cd180995fb3bdfca00f364475f
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This should be the last flag that needs to be filtered (famous last
words...) but if any more come up, we should really just explore
switching the PowerPC vDSO to linking with $(LD) like every other part
of the kernel; for now, I hope this is fine.

Cheers,
Nathan
---
 Makefile                          | 4 +++-
 arch/powerpc/kernel/vdso/Makefile | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index cf30a8b6463e..0406f37fd7a2 100644
--- a/Makefile
+++ b/Makefile
@@ -912,7 +912,9 @@ ifdef CONFIG_INIT_STACK_ALL_ZERO
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
 ifdef CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER
 # https://github.com/llvm/llvm-project/issues/44842
-KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+CC_AUTO_VAR_INIT_ZERO_ENABLER := -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+export CC_AUTO_VAR_INIT_ZERO_ENABLER
+KBUILD_CFLAGS	+= $(CC_AUTO_VAR_INIT_ZERO_ENABLER)
 endif
 endif
 
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 7e69e87fbf74..d2a1dc0956d5 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -56,7 +56,7 @@ ccflags-y := -fno-common -fno-builtin
 ldflags-y := -Wl,--hash-style=both -nostdlib -shared -z noexecstack
 ldflags-$(CONFIG_LD_IS_LLD) += $(call cc-option,--ld-path=$(LD),-fuse-ld=lld)
 # Filter flags that clang will warn are unused for linking
-ldflags-y += $(filter-out $(CC_FLAGS_FTRACE) -Wa$(comma)%, $(KBUILD_CFLAGS))
+ldflags-y += $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRACE) -Wa$(comma)%, $(KBUILD_CFLAGS))
 
 CC32FLAGS := -m32
 LD32FLAGS := -Wl,-soname=linux-vdso32.so.1

---
base-commit: a778c9dd138b4f4410779705b444d58ce6f8fc44
change-id: 20230123-qunused-argument-auto-var-init-8ae79ddfd34f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

