Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4F651360
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiLSTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLSTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:39:37 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E915DB3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:36 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fu10so9223891qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZHz7dDTw8Ksq2JLKQ71WSi/6Vw+cLGW5ToUQoZGyic=;
        b=PobARCqXZzIf5C3c9dhDtGHrG/sBorJB+WvRC9cdgl29mi7e1LmmejW0yGkzR39ANX
         HmJcdcxPi7DXjgkNIEBAHuu9XdWEWx7rGCF9JhRdYEPpw+Xu60+idRmMNL6fEfESIr0N
         PgVN0DATM03q6FNQBwSAvRntEGRQOECJjI9T9JRlHgZOpjpUoRzOAp0awOh7CXlbCuuQ
         LiZ7u5biKe/GiZ1sqH98OncaYL2LosrGFvJpC8vKNubojqVwO3RRSEJDGmJ0f+ujASiy
         EKWaNscLGZqnb0AGk3NUfpZwy4lvv7tgR2QOaOSJToy74NGzAArX7mETghdoAdaAu/GV
         LakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZHz7dDTw8Ksq2JLKQ71WSi/6Vw+cLGW5ToUQoZGyic=;
        b=GaV/7MiWZQG+AaWwBDQeHY6gqqKXq93TborZysbu0eQo6Fdn3nCjI3jKu+zf8It2QV
         JZKQQf9tBi8YHEZxwiVEz9mZikkpWM9tNIZIb+PvGzL05GlWea8OywNjrhnFDfJgIFxO
         OGxOJQo/l7ZU8rn82Pij/0OttNfC3oQEEGlxmGDbjG+GeqC+um5/uWFN7Lf1d3jTIyJl
         pmmF0jv/fzII5v96S/dx2eAXGxs6Vlmvu06YZ9DFK2srkY8sYIqoW1TIwsibNBhcmQ8C
         kyYrOgBEsjsyy4or+AWpGshkdCKTrhG2UX+UaDp5RTd+g1rkGNGoHOgT6V2N5F2g9Vi9
         +Fqw==
X-Gm-Message-State: ANoB5pm8fLn3eNitQIPZFLZslA52Ul9b44ksMrkaqQ0ipiv/7aRezUUB
        r7UyeRznUWBAhnCjxG9W5fGg1rVT4Q==
X-Google-Smtp-Source: AA0mqf4YfKMUl330YnWBrbEBBcyAO3mA1V1/x63eowtcpmhw7GT7lttjeV5u9BPNewSx0dEASE2oUw==
X-Received: by 2002:ac8:1085:0:b0:3a5:4b28:f4b0 with SMTP id a5-20020ac81085000000b003a54b28f4b0mr49409233qtj.68.1671478775130;
        Mon, 19 Dec 2022 11:39:35 -0800 (PST)
Received: from citadel.. (075-134-122-108.res.spectrum.com. [75.134.122.108])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a269900b006fc447eebe5sm7654130qkp.27.2022.12.19.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:39:34 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/2] x86/signal/compat: Move sigaction_compat_abi() to signal_64.c
Date:   Mon, 19 Dec 2022 14:39:04 -0500
Message-Id: <20221219193904.190220-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219193904.190220-1-brgerst@gmail.com>
References: <20221219193904.190220-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile        |  1 -
 arch/x86/kernel/signal_64.c     | 13 +++++++++++++
 arch/x86/kernel/signal_compat.c | 15 ---------------
 3 files changed, 13 insertions(+), 16 deletions(-)
 delete mode 100644 arch/x86/kernel/signal_compat.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 96d51bbc2bd4..dd61752f4c96 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -45,7 +45,6 @@ obj-y			+= head$(BITS).o
 obj-y			+= ebda.o
 obj-y			+= platform-quirks.o
 obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
-obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 9eea4e8f12ee..13a1e6083837 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -382,6 +382,19 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 }
 #endif /* CONFIG_X86_X32_ABI */
 
+#ifdef CONFIG_COMPAT
+void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
+{
+	if (!act)
+		return;
+
+	if (in_ia32_syscall())
+		act->sa.sa_flags |= SA_IA32_ABI;
+	if (in_x32_syscall())
+		act->sa.sa_flags |= SA_X32_ABI;
+}
+#endif /* CONFIG_COMPAT */
+
 /*
 * If adding a new si_code, there is probably new data in
 * the siginfo.  Make sure folks bumping the si_code
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
deleted file mode 100644
index c4e9b85f1869..000000000000
--- a/arch/x86/kernel/signal_compat.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/compat.h>
-#include <linux/uaccess.h>
-#include <linux/ptrace.h>
-
-void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact)
-{
-	if (!act)
-		return;
-
-	if (in_ia32_syscall())
-		act->sa.sa_flags |= SA_IA32_ABI;
-	if (in_x32_syscall())
-		act->sa.sa_flags |= SA_X32_ABI;
-}
-- 
2.38.1

