Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026BA68E00F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjBGSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjBGSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:31:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80593E619;
        Tue,  7 Feb 2023 10:31:40 -0800 (PST)
Date:   Tue, 07 Feb 2023 18:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675794699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVEgpFbb89uzvDqj2F2KafQpfVwF9UZkdx+Dy5o27Xs=;
        b=xWxxwEF56n+vzZ7Hfo98TIKuzn4XgZ/gKHTOEez57a6yNeAcNM/JaIF4U7vBcMOhExqGZD
        Bl7vF7WsTy2EWTZrSiKnSmBktQXNERtUAh2McEpXIMxoQGqEZB75hK5WGGfscLZxQ9dtMR
        ntmyAz56wgM2cpLh42dD2JXSY4rFVsA2kaLk8nntnUtZfHii8EiT+JhnlU1QGvuGCHCYgi
        z6XMuB28f6oKjiD5Z6JzMS+SEH9WkbdMKUvfjvbRmmEwLj0G2lXmcCaKItSqAaqHOhkzf5
        tCJHmcpxqqb7JHtEKsmhWzo/G2eSvmdTb9mIfwX5t7rFgWqdE3Q14Q6x44H/qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675794699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pVEgpFbb89uzvDqj2F2KafQpfVwF9UZkdx+Dy5o27Xs=;
        b=xQj148jzhHqYfaC15qJwzFxpzA9NVUEfDX08P24c1k0ZJlRuuNh+8JGBNoEjIX7iARzNtd
        P66QcJNNLYHYr6DA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu
Cc:     kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y+IsCWQdXEr8d9Vy@linutronix.de>
References: <Y+IsCWQdXEr8d9Vy@linutronix.de>
MIME-Version: 1.0
Message-ID: <167579469870.4906.6486562892768142110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     877cff5296faa6ef312f8002216bbf73bea006c7
Gitweb:        https://git.kernel.org/tip/877cff5296faa6ef312f8002216bbf73bea006c7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 07 Feb 2023 11:46:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Feb 2023 18:20:41 +01:00

x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu

The 64bit register constrains in __arch_hweight64() cannot be
fulfilled in a 32-bit build. The function is only declared but not used
within vclock_gettime.c and gcc does not care. LLVM complains and
aborts. Reportedly because it validates extended asm even if latter
would get compiled out, see

  https://lore.kernel.org/r/Y%2BJ%2BUQ1vAKr6RHuH@dev-arch.thelio-3990X

i.e., a long standing design difference between gcc and LLVM.

Move the "fake a 32 bit kernel configuration" bits from vclock_gettime.c
into a common header file. Use this from vclock_gettime.c and vgetcpu.c.

  [ bp: Add background info from Nathan. ]

Fixes: 92d33063c081a ("x86/vdso: Provide getcpu for x86-32.")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/Y+IsCWQdXEr8d9Vy@linutronix.de
---
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h | 25 +++++++++++++++++-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c   | 27 +------------------
 arch/x86/entry/vdso/vdso32/vgetcpu.c          |  1 +-
 3 files changed, 27 insertions(+), 26 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vdso32/fake_32bit_build.h

diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
new file mode 100644
index 0000000..db1b15f
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef CONFIG_X86_64
+
+/*
+ * in case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
+ * configuration
+ */
+#undef CONFIG_64BIT
+#undef CONFIG_X86_64
+#undef CONFIG_COMPAT
+#undef CONFIG_PGTABLE_LEVELS
+#undef CONFIG_ILLEGAL_POINTER_VALUE
+#undef CONFIG_SPARSEMEM_VMEMMAP
+#undef CONFIG_NR_CPUS
+#undef CONFIG_PARAVIRT_XXL
+
+#define CONFIG_X86_32 1
+#define CONFIG_PGTABLE_LEVELS 2
+#define CONFIG_PAGE_OFFSET 0
+#define CONFIG_ILLEGAL_POINTER_VALUE 0
+#define CONFIG_NR_CPUS 1
+
+#define BUILD_VDSO32_64
+
+#endif
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 283ed9d..86981de 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -1,29 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
 #define BUILD_VDSO32
-
-#ifdef CONFIG_X86_64
-
-/*
- * in case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
- * configuration
- */
-#undef CONFIG_64BIT
-#undef CONFIG_X86_64
-#undef CONFIG_COMPAT
-#undef CONFIG_PGTABLE_LEVELS
-#undef CONFIG_ILLEGAL_POINTER_VALUE
-#undef CONFIG_SPARSEMEM_VMEMMAP
-#undef CONFIG_NR_CPUS
-#undef CONFIG_PARAVIRT_XXL
-
-#define CONFIG_X86_32 1
-#define CONFIG_PGTABLE_LEVELS 2
-#define CONFIG_PAGE_OFFSET 0
-#define CONFIG_ILLEGAL_POINTER_VALUE 0
-#define CONFIG_NR_CPUS 1
-
-#define BUILD_VDSO32_64
-
-#endif
-
+#include "fake_32bit_build.h"
 #include "../vclock_gettime.c"
diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vdso32/vgetcpu.c
index b777f84..3a9791f 100644
--- a/arch/x86/entry/vdso/vdso32/vgetcpu.c
+++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
@@ -1,2 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "fake_32bit_build.h"
 #include "../vgetcpu.c"
