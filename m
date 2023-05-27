Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1752F7131AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbjE0Bmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbjE0Bmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:42:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B56E63
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2a87b9daso1195967b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685151740; x=1687743740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaDACvZxwdpKtf7kTBQLIF7ZNxT8GRJ6++BKiL/JB9M=;
        b=jVuYAdq3YuUoT9q0ptR3Y7gogUCPfBKK+uzhCs3nYmVmC0ZcHgwMRd0F7jOf1hYEoN
         iVHyunZrSLGRZ/SUtKN1NZqFCsyZzudfiz0JVDxVcWLyOc754sGNrSqCni0+0DMifrdR
         CX1zK1B4IcAFWXPw6yd7iZFlWLLQa05o6HrVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685151740; x=1687743740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaDACvZxwdpKtf7kTBQLIF7ZNxT8GRJ6++BKiL/JB9M=;
        b=l2d/4GJ+wp6oaYSrRE/DyTn9XFh4hb1cO8tMJiNLhe6dEiPGi1nicSzeMLdR5pxdeC
         SpCz/bTXUKy0i8CbidyZe6iGvzjLBLWG+uPwBs3reEzrZ2vatQALOqSUYcxBH793fUsi
         eq/YXwm2RHphK2Xf2Rm7rysdMRjIUspS2XQ4nSerKkuvOOpcJ9drWpkiOcsJnpXR18Zf
         XuvGXK3LEu9+y1tRoOr7/V9ViGUblbfp7OK+XaxiWKvifWhizEtsIOGUw1v/VzD9fCXD
         uPCQNyCWQZiNtwhASgRXidGxmFuWfYhbR4dXFl0w8SxxaDdhHc877Mt7zlbfOmdk0y0f
         fmWg==
X-Gm-Message-State: AC+VfDyco5kdWzpnFrshnuuu3Fb6d4TnAd2QsciIcPfUZ7EiGVdtuT37
        ix2KAr7mPKHEhGUgA2ivrBb0NA==
X-Google-Smtp-Source: ACHHUZ7idAUslgayGvplEniRBtJYBCvMASeKUJDKY3K4A2M46AA1VPt7NOcvpx5WEYfIrIw0exEmRA==
X-Received: by 2002:a05:6a00:2409:b0:63b:8778:99e4 with SMTP id z9-20020a056a00240900b0063b877899e4mr5910255pfh.2.1685151739708;
        Fri, 26 May 2023 18:42:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4015:7255:c79a:26d7])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79199000000b0063b8ddf77f7sm3202440pfa.211.2023.05.26.18.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:42:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 02/10] watchdog/hardlockup: HAVE_NMI_WATCHDOG must implement watchdog_hardlockup_probe()
Date:   Fri, 26 May 2023 18:41:32 -0700
Message-ID: <20230526184139.2.Ic6ebbf307ca0efe91f08ce2c1eb4a037ba6b0700@changeid>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230527014153.2793931-1-dianders@chromium.org>
References: <20230527014153.2793931-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there is one arch (sparc64) that selects HAVE_NMI_WATCHDOG
without selecting HAVE_HARDLOCKUP_DETECTOR_ARCH. Because of that one
architecture, we have some special case code in the watchdog core to
handle the fact that watchdog_hardlockup_probe() isn't implemented.

Let's implement watchdog_hardlockup_probe() for sparc64 and get rid of
the special case.

As a side effect of doing this, code inspection tells us that we could
fix a minor bug where the system won't properly realize that NMI
watchdogs are disabled. Specifically, on powerpc if
CONFIG_PPC_WATCHDOG is turned off the arch might still select
CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH which selects
CONFIG_HAVE_NMI_WATCHDOG. Since CONFIG_PPC_WATCHDOG was off then
nothing will override the "weak" watchdog_hardlockup_probe() and we'll
fallback to looking at CONFIG_HAVE_NMI_WATCHDOG.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Though this does fix a minor bug, I didn't mark this as "Fixes"
because it's super minor. One could also argue that this wasn't a bug
at all but simply was never an implemented feature. The code that
added some amount of dynamicness here was commit a994a3147e4c
("watchdog/hardlockup/perf: Implement init time detection of perf")
which, as per the title, was only intending to make "perf"
dynamic. The old NMI watchdog presumably has never been handled
dynamically.

 arch/Kconfig            |  3 ++-
 arch/sparc/kernel/nmi.c |  5 +++++
 kernel/watchdog.c       | 13 -------------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 64d771855ecd..b4f6387b12fe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -428,7 +428,8 @@ config HAVE_NMI_WATCHDOG
 	bool
 	help
 	  The arch provides a low level NMI watchdog. It provides
-	  asm/nmi.h, and defines its own arch_touch_nmi_watchdog().
+	  asm/nmi.h, and defines its own watchdog_hardlockup_probe() and
+	  arch_touch_nmi_watchdog().
 
 config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	bool
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 9d9e29b75c43..17cdfdbf1f3b 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -65,6 +65,11 @@ void arch_touch_nmi_watchdog(void)
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
+int __init watchdog_hardlockup_probe(void)
+{
+	return 0;
+}
+
 static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
 {
 	int this_cpu = smp_processor_id();
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 4b9e31edb47f..62230f5b8878 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -217,19 +217,6 @@ void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
  */
 int __weak __init watchdog_hardlockup_probe(void)
 {
-	/*
-	 * If CONFIG_HAVE_NMI_WATCHDOG is defined then an architecture
-	 * is assumed to have the hard watchdog available and we return 0.
-	 */
-	if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
-		return 0;
-
-	/*
-	 * Hardlockup detectors other than those using CONFIG_HAVE_NMI_WATCHDOG
-	 * are required to implement a non-weak version of this probe function
-	 * to tell whether they are available. If they don't override then
-	 * we'll return -ENODEV.
-	 */
 	return -ENODEV;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

