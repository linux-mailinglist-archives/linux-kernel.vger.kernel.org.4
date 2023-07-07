Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0474AABD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjGGFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:47:19 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B872172B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 22:47:18 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b06777596cso1436640fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 22:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688708837; x=1691300837;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=18JEHmCNriSXCt9lwVG1gdY95Ti8XFVzzNrMetTB3RE=;
        b=ogFntHJ6RxrAEPFVudPEAa0C385HOnOfUwce+99Yasx8myU/rGAYtZSCGU0Eg6ka2k
         fStAVEM215dE6taLQkpDCoVzX0gIBP50UI7H/XkVpcsDVTA90x0Sfgrc4Ft2KYz7AnKq
         RxFnRYV+MZVB5aSMSp7mFQQgunJ/v4Uemk3OuBWv+DLXyb9MDeP9aiPq6kNgqIUxOG+a
         +0WgAyvP2+nS43sXwUu2x16ezvod9el2VwCAHh4JvXyafuZMbmq/OVfpGtGrGZC6rlKD
         y0iO3BSK7iCLTf2qyZz3acrM6pKF7ZgTFb9VwN7JFN4JGrV+Sc8V38KYbGMY0lg1tGLm
         l+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688708837; x=1691300837;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18JEHmCNriSXCt9lwVG1gdY95Ti8XFVzzNrMetTB3RE=;
        b=azEY5jpU1rIOP7du+63RJXO1k0fOAtELM83jdUfanDN1p/XXxTcG52qnIhWflq1UFN
         H8LSWcw4dM1lORqQHB9wwhoW2bcNDRJToyNb7lTbwxN2JPtupwA3Pz7I/C8Vv8achhlx
         iR2ZVAuR1JR7SLzgvp71brf5ZJB6tjCvbk/HLeCVf9r/YkR2WicFJNPW5P1WmLys0G0f
         aUimo0qIbchbFIajPttfTZ3ZMb9HUEw6prSnS7SBmqqkjU2TYL0UROWQ3QCPEVPUWXMU
         eWpjWKMwHgPp37Y+wTMf6+0BirXB7j2LukJu05rCXfYO36KALz32YstWzaJ//tS/Os18
         PqQg==
X-Gm-Message-State: ABy/qLZ8V4ywfmk8FdZV8O1PDrlTr+mJssr2kYW/A3Z7M+pP186VbsBy
        ckrKTBfDL9nweF/Vxe0a//1hMQ==
X-Google-Smtp-Source: APBJJlHUM5/Nf9hH+y4tg3FzZmGqyw1ddyEvNg72h5Yn0LMsT5qA1AMEzfyr6IZEBbt4CHH90jrmOg==
X-Received: by 2002:a05:6870:d20e:b0:17a:c7ff:ccf5 with SMTP id g14-20020a056870d20e00b0017ac7ffccf5mr4889304oac.32.1688708837341;
        Thu, 06 Jul 2023 22:47:17 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090ad31000b00263fc1ef1aasm710558pju.10.2023.07.06.22.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 22:47:16 -0700 (PDT)
Subject: [PATCH] module: Ignore RISC-V mapping symbols too
Date:   Thu,  6 Jul 2023 22:40:01 -0700
Message-ID: <20230707054007.32591-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     mcgrof@kernel.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V has an extended form of mapping symbols that we use to encode
the ISA when it changes in the middle of an ELF.  This trips up modpost
as a build failure, I haven't yet verified it yet but I believe the
kallsyms difference should result in stacks looking sane again.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I'm not sure about a fixes here, the breakage comes from a binutils change
that's pretty much independent from the kernel.

Plumbing in through the RISC-V-specific switch is also a bit ugly, but I'm not
sure just dropping everyone's "$"-prefixed symbols is a good idea -- the rest
of this is sort of half-way arch-specific, though, so maybe that's the way to
go?  I figure it's easier to delete stuff than add it, though.
---
 include/linux/module_symbol.h | 12 +++++++++++-
 kernel/module/kallsyms.c      |  8 +++++++-
 scripts/mod/modpost.c         |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 7ace7ba30203..5b799942b243 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -3,12 +3,22 @@
 #define _LINUX_MODULE_SYMBOL_H
 
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
-static inline int is_mapping_symbol(const char *str)
+static inline int is_mapping_symbol(const char *str, int is_riscv)
 {
 	if (str[0] == '.' && str[1] == 'L')
 		return true;
 	if (str[0] == 'L' && str[1] == '0')
 		return true;
+	/*
+	 * RISC-V defines various special symbols that start with "$".  The
+	 * mapping symbols, which exist to differentiate between incompatible
+	 * instruction encodings when disassembling, show up all over the place
+	 * and are generally not meant to be treated like other symbols.  So
+	 * just ignore any of the special symbols.
+	 */
+	if (is_riscv)
+		return str[0] == '$';
+
 	return str[0] == '$' &&
 	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
 	       && (str[2] == '\0' || str[2] == '.');
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index ef73ae7c8909..1e988e542c5d 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -12,6 +12,12 @@
 #include <linux/bsearch.h>
 #include "internal.h"
 
+#ifdef CONFIG_RISCV
+#define IS_RISCV 1
+#else
+#define IS_RISCV 0
+#endif
+
 /* Lookup exported symbol in given range of kernel_symbols */
 static const struct kernel_symbol *lookup_exported_symbol(const char *name,
 							  const struct kernel_symbol *start,
@@ -289,7 +295,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * and inserted at a whim.
 		 */
 		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
-		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_RISCV))
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..7c71429d6502 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
 
 	if (!name || !strlen(name))
 		return 0;
-	return !is_mapping_symbol(name);
+	return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
 }
 
 /* Look up the nearest symbol based on the section and the address */
-- 
2.41.0

