Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42C5BD406
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiISRqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISRp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:45:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F133D5BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:45:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso257993757b3.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=PKu0ljoFnQHIVcfEdQ+Ybwv+0gUXFz3XYuciSgp3qWg=;
        b=luk6DOvV6LFTWCbZhs1jzNg0sUPXjpsXxtYi72o5Hq02AsL6hMVNKwcNXXfaFr6TG7
         Ua6yHpWwpe4LlndgiFaWAKg9OXUCMJAMO9yBbIpAxlNSv7W4cp56mi2BZ09WTECscSuT
         lGpybwfKtkTjeFUuvRkQ+NScUQ4DccHLk7TG2Xy8xzI2qsli2NMb5xrRaDPPyB4ahhYJ
         W0zdz4ac7AlnkN9m4KZR4sqvF5iOJ5cucxVm28azQQcvOYxMWeJXbzw0kESMn7YaPueg
         RM4Xw9bBNG1jM0phke0BzgLYcJ5+HIvCbYb2XSETooua/Mx03pUeWi4qmscrv62nfKlu
         F8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=PKu0ljoFnQHIVcfEdQ+Ybwv+0gUXFz3XYuciSgp3qWg=;
        b=ldAp2Cjmv2eNedOvegI+VKdV3v2WeOvyIdw6B2+CFkgrUQgVv8DOkuMna+nJJAmMZh
         /GSGUKJ8adSORp2/gO/wFZqZ/XS5v3X22I21H1nqoWX0UAysU2OwaqFJRBQ8kUQhUGc1
         3hvxGDLyPKqHa+KNTaRsQFTa6L5clMOfR3+6XhNiuLE/ReaMt263wNh/2imJwGucz2sz
         pSTyK28YA7V+mLkFW1DHJ8DvOyKz6JP2jzo1rCGBYg+hOHsRgMquAfFNcX1k6cxyzL2e
         WlSpjPKz+PlKJ8KELbhOxtoO6SRsd+YtvfWibRsaDrKpA8nop0radQARnUTTO+CZDa0q
         xuMA==
X-Gm-Message-State: ACrzQf2JnID7S+0o+G0LY3t3Wv3yT5Jgs2Mf9wvZoOy038DiSK5COJRd
        a4z5niPvLUfDOfncy//lZ6FVcT3HPPlRFj0+PvQ=
X-Google-Smtp-Source: AMsMyM4fwUmSVIg3ujsHJWyzu3hU2W+uKibbsvMQlGqxE4x+PE3kBbqFOa+cEosOMwaGQ6Hjhk7WX0XUfQyzwvK8yGU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:2923:f5c9:c5a4:11b5])
 (user=ndesaulniers job=sendgmr) by 2002:a81:6a07:0:b0:348:c973:d2a2 with SMTP
 id f7-20020a816a07000000b00348c973d2a2mr16207386ywc.375.1663609555128; Mon,
 19 Sep 2022 10:45:55 -0700 (PDT)
Date:   Mon, 19 Sep 2022 10:45:47 -0700
In-Reply-To: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
Mime-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663609547; l=3328;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=Pnx8FAPeseVXdLH6uhA0b1eLRdAedgT/4Q3UMuOJNF8=;
 b=tdlA4sKRv7MinmRq5+YHLSBvUqEaAOvk9h098+TSyRhu39EnO42vonlXrehoFf6FZbr+F791BgPf
 R8cU2QiZBms8h9i674Peuhq/Drlc9K8Va38hFBY9t+z+gJix6jH+
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220919174547.3730737-1-ndesaulniers@google.com>
Subject: [PATCH v4] Makefile.debug: re-enable debug info for .S files
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey reported that the fraction of unknown filename instances in
kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
to assembler defined symbols, which regressed as a result of:

commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")

In that commit, I allude to restoring debug info for assembler defined
symbols in a follow up patch, but it seems I forgot to do so in

commit a66049e2cf0e ("Kbuild: make DWARF version a choice")

Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
Reported-by: Alexey Alexandrov <aalexand@google.com>
Reported-by: Bill Wendling <morbo@google.com>
Reported-by: Greg Thelen <gthelen@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v3 -> v4:
* Break out into its own patch.
* Move addition of debug-flags-y to DEBUG_CFLAGS and KBUILD_AFLAGS up
  grouping the -gdwarf-* handling together.

 lib/Kconfig.debug      |  4 +++-
 scripts/Makefile.debug | 18 +++++++++---------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d6c80c..d3e5f36bb01e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -264,8 +264,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
 	select DEBUG_INFO
+	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
 	help
-	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
+	  if using clang without clang's integrated assembler, and gdb 7.0+.
 
 	  If you have consumers of DWARF debug info that are not ready for
 	  newer revisions of DWARF, you may wish to choose this or have your
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 26d6a9d97a20..d6aecd78b942 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -4,15 +4,15 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
 endif
 
-ifndef CONFIG_AS_IS_LLVM
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
-endif
-
-ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
-dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
-dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
-DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
+debug-flags-$(CONFIG_DEBUG_INFO_DWARF4)	+= -gdwarf-4
+debug-flags-$(CONFIG_DEBUG_INFO_DWARF5)	+= -gdwarf-5
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_AS_IS_GNU),yy)
+# Clang does not pass -g or -gdwarf-* option down to GAS.
+# Add -Wa, prefix to explicitly specify the flags.
+KBUILD_AFLAGS	+= $(addprefix -Wa$(comma), $(debug-flags-y))
 endif
+DEBUG_CFLAGS	+= $(debug-flags-y)
+KBUILD_AFLAGS	+= $(debug-flags-y)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
@@ -27,5 +27,5 @@ KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 endif
 
-KBUILD_CFLAGS += $(DEBUG_CFLAGS)
+KBUILD_CFLAGS	+= $(DEBUG_CFLAGS)
 export DEBUG_CFLAGS
-- 
2.37.3.968.ga6b4b080e4-goog

