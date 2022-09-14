Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1115B7E48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiINB0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiINB03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:26:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838B6B8C4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:26:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v4so12913192pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oGFQWiD9fL+FNWNuvlZs6HygR4mXZaszrHMNFbJR28M=;
        b=Z9G+QLsfasWj+mAHLkqoHE7cyRvkZr7aPERz1zimh2bMLEqN6EGIVQfihP+zULoMn8
         hmybiwRR5Xi4ouSU0e5fTvUObcxaDnSCy4uKdKer6dWvgUV1cph3eLihOt898zNZkHka
         CpNJOWFKyfGQeYtmb5NBjc0qxMfwD743gUUGxZRK2Vw1w+Hu5+140Lqy2yvJ8mdFjqKF
         kKUZNCkwTK/T8dfZe63eSmQIe+lNk5mtpXSYv2XHJ4r2fPCK4vkF2UXg7W2OpQ8gtchU
         NrOlFJhAB+ldli5jbiknat8yu6J//x8Tv9QvA8gPwVibXrOW1NpNdScpD1yjc8VPKkzo
         hcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oGFQWiD9fL+FNWNuvlZs6HygR4mXZaszrHMNFbJR28M=;
        b=wQ9xdzlpbD2GdcWGDiHQBYi7hlCEqSC5JFuozicOVH387L39eAsAtfigzYCwMoKYoJ
         X1dBp6sOLZpiC1cfg+zPRM3cWPlOFKwKUDLCJXmCvdYn4rhWx+p9v1ZcYldrUKHG1F17
         KO2rGkOgap/1OHpBQPRmAk6bn2QW5CcuRiPA2DqB56Y0gXq837mPjdRX5apSTBGspCYp
         AisYTOIKDFSGtBmOtxXstjdMDy649aDYWt3BENFV6gtvhqTPv3UWxD1jumIuAVQmmppY
         ECgtmNLkk9YtdL/FJVyKPJJuPU+R/N/ai0ODdDQHeDyRmX9/Z5FPS/Ia1KEnowlrC5iH
         np3g==
X-Gm-Message-State: ACgBeo2mARtusLUNKfrsVROUHKofVHHONwvw4Apxzw4UWE/Idf4mzUEa
        QwqOeQs0GQO+QoCJqiNlb2k=
X-Google-Smtp-Source: AA6agR5Xd07MDO/3cCT8qLGefsCo0EhfpkYGDJ2VrdGeyIqE0XoMrJgDBFxXaHwG6EEgOkhIFi+eAA==
X-Received: by 2002:a05:6a00:1f05:b0:540:6552:dfbf with SMTP id be5-20020a056a001f0500b005406552dfbfmr29551303pfb.65.1663118786757;
        Tue, 13 Sep 2022 18:26:26 -0700 (PDT)
Received: from octofox.metropolis (c-24-130-93-68.hsd1.ca.comcast.net. [24.130.93.68])
        by smtp.gmail.com with ESMTPSA id x1-20020aa79a41000000b00536b2483aedsm6873603pfj.199.2022.09.13.18.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 18:26:26 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add FDPIC and static PIE support for noMMU
Date:   Tue, 13 Sep 2022 18:26:10 -0700
Message-Id: <20220914012610.2734108-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define ELFOSABI_XTENSA_FDPIC and Use is as an OSABI tag in the ELF
header to distinguish FDPIC ELF files from regular ELF files.
Define ELF_FDPIC_PLAT_INIT and put executable map, interpreter map and
executable dynamic section addresses into registers a4..a6.
Update start_thread macro to preserve register values in the current
register window.
Add definitions for PTRACE_GETFDPIC, PTRACE_GETFDPIC_EXEC and
PTRACE_GETFDPIC_INTERP.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/elf.h         | 11 +++++++++++
 arch/xtensa/include/asm/processor.h   |  3 +++
 arch/xtensa/include/uapi/asm/ptrace.h |  4 ++++
 fs/Kconfig.binfmt                     |  2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/elf.h b/arch/xtensa/include/asm/elf.h
index 9c21897c6992..ffcf1ada19c6 100644
--- a/arch/xtensa/include/asm/elf.h
+++ b/arch/xtensa/include/asm/elf.h
@@ -93,6 +93,10 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 #define elf_check_arch(x) ( ( (x)->e_machine == EM_XTENSA )  || \
 			    ( (x)->e_machine == EM_XTENSA_OLD ) )
 
+#define ELFOSABI_XTENSA_FDPIC 65
+#define elf_check_fdpic(x) ((x)->e_ident[EI_OSABI] == ELFOSABI_XTENSA_FDPIC)
+#define ELF_FDPIC_CORE_EFLAGS 0
+
 /*
  * These are used to set parameters in the core dumps.
  */
@@ -164,6 +168,13 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 		(_r)->areg[14] = 0; (_r)->areg[15] = 0; \
 	} while (0)
 
+#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr, dynamic_addr) \
+	do { \
+		(_r)->areg[4] = _exec_map_addr; \
+		(_r)->areg[5] = _interp_map_addr; \
+		(_r)->areg[6] = dynamic_addr; \
+	} while (0)
+
 typedef struct {
 	xtregs_opt_t	opt;
 	xtregs_user_t	user;
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 76bc63127c66..b75ba16ec080 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -205,9 +205,12 @@ struct thread_struct {
 #define start_thread(regs, new_pc, new_sp) \
 	do { \
 		unsigned long syscall = (regs)->syscall; \
+		unsigned long current_aregs[16]; \
+		memcpy(current_aregs, (regs)->areg, sizeof(current_aregs)); \
 		memset((regs), 0, sizeof(*(regs))); \
 		(regs)->pc = (new_pc); \
 		(regs)->ps = USER_PS_VALUE; \
+		memcpy((regs)->areg, current_aregs, sizeof(current_aregs)); \
 		(regs)->areg[1] = (new_sp); \
 		(regs)->areg[0] = 0; \
 		(regs)->wmask = 1; \
diff --git a/arch/xtensa/include/uapi/asm/ptrace.h b/arch/xtensa/include/uapi/asm/ptrace.h
index 50db3e0a6341..9115e86ebc75 100644
--- a/arch/xtensa/include/uapi/asm/ptrace.h
+++ b/arch/xtensa/include/uapi/asm/ptrace.h
@@ -37,6 +37,10 @@
 #define PTRACE_SETXTREGS	19
 #define PTRACE_GETHBPREGS	20
 #define PTRACE_SETHBPREGS	21
+#define PTRACE_GETFDPIC		22
+
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
 
 #ifndef __ASSEMBLY__
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 21e154516bf2..9d131a54226f 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
-	depends on ARM || ((M68K || SUPERH) && !MMU)
+	depends on ARM || ((M68K || SUPERH || XTENSA) && !MMU)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.30.2

