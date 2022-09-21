Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767F25BF69E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIUGtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIUGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:49:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850580F65
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:49:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n6-20020a5b0486000000b006aff8dc9865so4357255ybp.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=R7mLhdnkpSWx07KdbnpYvlSWhqKvplSmM8S6hCP/A6E=;
        b=SvxxdhkutiBwatlIyB1WrSrKCx/UD17Mw+sKYbN1Em4M5urEbUWsgjL93//tE4gvaz
         HfdxXh7xWgF56JPLAoTSnIajItHtsWosnH8qR+zINNkog4Oh5IThuDFllVY++aBb1Ymk
         Jx8oS0LUIqaHGs/mnbVgVcFuDxWgFeBtwnGrkSeIjikQ/Cs/JRGLCntNwHb2KPlDM0Yv
         eFcp657plxspWH9oODwWUsw4oGmvMEDBxIQCg2KRzKmJcQCSMvcys6JxQrsAokedHGHa
         xEA+4VHK+aed7rD1kE0yJDceBUk+fRaN+F/j5ejPlkDAwke/CZO1PuVL31ZosM/1dq5H
         RQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=R7mLhdnkpSWx07KdbnpYvlSWhqKvplSmM8S6hCP/A6E=;
        b=TakR6mZBcM7yCmO055anTba+jWmiAOZLvAdTD+OzqDhA0PnFcVlrbKgk8+QOFyDUUO
         58fLWxQsQxa+gtWrCHUecKj9+JhsPGERAeSNNosdFkcqHxaj6SlygAA7x5tCkB3+oAHK
         XHzrmC8NENlXicTDRW8cN1EUctPhAjoa2MIWcAnH2dZTGydFd0kmWYMJRBojSPwT4YY/
         LYObtXudhTu3Kkg2BeRjzerI0qGN1xBUkxiIXmv48+eZIBKuZ8FwHRXLZnkxv3MIfr4W
         gUCbQB6r7VCkozarkG/CBarmwdIm9xD4fu0vhMIUhWfTY/4K3Mho/X5A2/vhuWBwUUvd
         UKMw==
X-Gm-Message-State: ACrzQf0/e7JTVe4dJamtrGAYpPboMk+a5POnQCkwaNn5JPNAO9KSzEW/
        YGJz2gFNwRjhlXhZCfvg2plII0gWp53pUg==
X-Google-Smtp-Source: AMsMyM7IKZr1FZGN1anvYMjPXabjkwJx1WCS7IaYHdoWhcsRR9VwYYuuTyxmWdE9VQuy10DklIL3Qgb2ImUSOA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:cb12:0:b0:6a9:20c6:81ca with SMTP id
 b18-20020a25cb12000000b006a920c681camr23239620ybg.79.1663742942481; Tue, 20
 Sep 2022 23:49:02 -0700 (PDT)
Date:   Wed, 21 Sep 2022 14:48:55 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921064855.2841607-1-davidgow@google.com>
Subject: [PATCH v2] arch: um: Mark the stack non-executable to fix a binutils warning
From:   David Gow <davidgow@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Gow <davidgow@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        Lukas Straub <lukasstraub2@web.de>,
        Randy Dunlap <rdunlap@infradead.org>
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

Since binutils 2.39, ld will print a warning if any stack section is
executable, which is the default for stack sections on files without a
.note.GNU-stack section.

This was fixed for x86 in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments"),
but remained broken for UML, resulting in several warnings:

/usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

Link both the VDSO and vmlinux with -z noexecstack, fixing the warnings
about .note.GNU-stack sections. In addition, pass --no-warn-rwx-segments
to dodge the remaining warnings about LOAD segments with RWX permissions
in the kallsyms objects. (Note that this flag is apparently not
available on lld, so hide it behind a test for BFD, which is what the
x86 patch does.)

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
---

Note that this still doesn't seem to be working properly with make
LLVM=1. It doesn't appear to break anything, and still is an improvement
for gcc, so seems worthwhile anyway...

Changes since v1:
http://lists.infradead.org/pipermail/linux-um/2022-August/004234.html
- Pass the -z noexecstack and --no-warn-rwx-segments flags as LDFLAGS,
  rather than as CFLAGS via -Wl
- Check that --no-warn-rwx-segments exists with the ld-option function
  (Thanks Richard)
- Add Lukas and Randy's tags.


 arch/um/Makefile          | 8 ++++++++
 arch/x86/um/vdso/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f2fe63bfd819..f1d4d67157be 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -132,10 +132,18 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
+# Avoid binutils 2.39+ warnings by marking the stack non-executable and
+# ignorning warnings for the kallsyms sections.
+LDFLAGS_EXECSTACK = -z noexecstack
+ifeq ($(CONFIG_LD_IS_BFD),y)
+LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
+endif
+
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export LDFLAGS_vmlinux := $(LDFLAGS_EXECSTACK)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 8c0396fd0e6f..6fbe97c52c99 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -65,7 +65,7 @@ quiet_cmd_vdso = VDSO    $@
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
 GCOV_PROFILE := n
 
 #
-- 
2.37.3.968.ga6b4b080e4-goog

