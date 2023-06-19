Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB5735DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFSTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjFSTsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:48:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22184106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a9b0ec6f4cso3545220fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687204082; x=1689796082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0dmLLpmIMRF1k1aMIq7tNvIf5lsQA7RrW08jbWY0mM=;
        b=DBz89qyma+c1XWpvulINuvqmdg5heNPLjf34UDNWz1zQ8GslTGBiiAiJat3zSApPvu
         JzWYUgDd6EL8zPpDSzRt5/fDkjIs2bABqjjStClNfsYsg/RIA24zL7j9MiR9HQrH9iP5
         BtegVqpmYp85SvV8FMUqddLJPVudrSb0Yr6regGbr6vlfvqWppXUWB4Z5VasnCCY+LlV
         5ZSDmpfBz/YNSl6US1fMHPvmB4u73ee2CPxmNasgC8ayWmrPlX97PVkgojzW1EkFmxBF
         MzHwrXbrF8Om9AS66SLqFzKHy2fCVI1CqtAY+UGqZ/Dpovwql4DCDMlPl234BeaRTGi0
         d/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204082; x=1689796082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0dmLLpmIMRF1k1aMIq7tNvIf5lsQA7RrW08jbWY0mM=;
        b=A4OsyETGTNmR93PPhFtOUNlk7UyFwGI3CKeOcieQvTZ/nmfRv/9N9REvLs3spJ4kuO
         Lc4mujOFML45Fzjm7mVFMZxRcRRib/+cszm3XRRmBcmHjuFSH6OOLPZDtWfbXNnu8IOb
         DQuKNO1BOrl6OBtrh9qdInpj/ykIzjcDq2kDAqKIC8pDBHZfA3UcP0epNHDJMHFUjYXw
         j0UicQFhjqNKsfYpel4316dGPSNNVP5Q22Ih6JkRXrAuyYmjam9RoB1gne7ocjKKml90
         TnO3eGnAv5/aggIS5NYgfSs9PhLf6qTH8/k1f9HHnR3lXawTHszEnqe02wWmvHu4OH5k
         XRdQ==
X-Gm-Message-State: AC+VfDwxHJ4+Wd3dLse1LgOogJ3V9JCbLLfqlt9trFv3Kk2cHYwN9nSt
        X8XOS5WHZttQnSLB/kKGTKtxpju2kg==
X-Google-Smtp-Source: ACHHUZ6UmAfmR6UFd/TRB3s123ybFuiNTbYHih5C34LACCuiZaG5SfL2UBHlUpJ9mUSfYOivqwcJdA==
X-Received: by 2002:a05:6870:5253:b0:1a3:365:a8d5 with SMTP id o19-20020a056870525300b001a30365a8d5mr7019311oai.48.1687204082588;
        Mon, 19 Jun 2023 12:48:02 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870f10e00b001a9e4167444sm250939oac.44.2023.06.19.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:48:02 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/2] x86/syscall/compat: Remove ia32_unistd.h
Date:   Mon, 19 Jun 2023 15:47:45 -0400
Message-Id: <20230619194745.80552-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619194745.80552-1-brgerst@gmail.com>
References: <20230619194745.80552-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header is now just a wrapper for unistd_32_ia32.h.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_64_compat.S   |  1 -
 arch/x86/include/asm/ia32_unistd.h | 11 -----------
 arch/x86/include/asm/seccomp.h     |  2 +-
 arch/x86/kernel/signal_32.c        |  2 +-
 4 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 70150298f8bd..353a3425fbf6 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -7,7 +7,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/errno.h>
-#include <asm/ia32_unistd.h>
 #include <asm/thread_info.h>
 #include <asm/segment.h>
 #include <asm/irqflags.h>
diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
deleted file mode 100644
index 7bcb82951c11..000000000000
--- a/arch/x86/include/asm/ia32_unistd.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_IA32_UNISTD_H
-#define _ASM_X86_IA32_UNISTD_H
-
-/*
- * This file contains the system call numbers of the ia32 compat ABI,
- * this is for the kernel only.
- */
-#include <asm/unistd_32_ia32.h>
-
-#endif /* _ASM_X86_IA32_UNISTD_H */
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index fef16e398161..42bcd42d70d1 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -9,7 +9,7 @@
 #endif
 
 #ifdef CONFIG_COMPAT
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 #define __NR_seccomp_read_32		__NR_ia32_read
 #define __NR_seccomp_write_32		__NR_ia32_write
 #define __NR_seccomp_exit_32		__NR_ia32_exit
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..cb7988712762 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -34,7 +34,7 @@
 #include <asm/gsseg.h>
 
 #ifdef CONFIG_IA32_EMULATION
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-- 
2.40.1

