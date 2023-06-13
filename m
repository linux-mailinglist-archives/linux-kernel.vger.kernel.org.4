Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9272F057
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjFMXll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbjFMXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46D2120;
        Tue, 13 Jun 2023 16:39:47 -0700 (PDT)
Message-ID: <20230613224545.841685728@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mdLair9MyWDVqPCo3VYZYQwXMBzE274L3lUc1PUjYzw=;
        b=tvknF4JQcwX0lM5O4DZTQuc30Yg9yiLzqRi4X2iQXF/rYttRwxZcIK6EcdK55DoYlMxRE5
        P0mkYs/iQ/cjRO8mk7MV5JkV9ZuQJgcw6JUtB19cZ9EwRnDimk9Xo7AZ4YRq3EGrHOt5Vb
        DNs4nYJlWr7TOx07NfCBW8Nrn51ARUbYjrw+8SDW/PGmeyNd2IDUAJhiC+0QYh3J9YfV+0
        /f5g54ndBGu+vtkKj+HwXcVCPNpr9uulVNkO8WM/YoNZsNhpzWGKWCdvrsa3VYL1p1Fo92
        IXzaQeVfRZJ2lNBrphRMdwLF4GZBfuZ5ZhQbSHtQVs0QBCTVHkh6rWWIAukLVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mdLair9MyWDVqPCo3VYZYQwXMBzE274L3lUc1PUjYzw=;
        b=weToH2Qa1SQqSJH8nQz8yPWHP67Y8ikgQP8AOS2+GL2sffNVONPBGYNLIgL4AGgEn4bpWa
        yxpMUxbA/N9sffBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 16/17] x86/fpu: Mark init functions __init
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in keeping them around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/init.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -53,7 +53,7 @@ void fpu__init_cpu(void)
 	fpu__init_cpu_xstate();
 }
 
-static bool fpu__probe_without_cpuid(void)
+static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
 	u16 fsw, fcw;
@@ -71,7 +71,7 @@ static bool fpu__probe_without_cpuid(voi
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static void fpu__init_system_early_generic(void)
+static void __init fpu__init_system_early_generic(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {

