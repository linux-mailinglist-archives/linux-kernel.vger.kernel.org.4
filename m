Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E357772F049
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbjFMXlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjFMXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D3C172A;
        Tue, 13 Jun 2023 16:39:48 -0700 (PDT)
Message-ID: <20230613224545.902376621@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yamwFyBvrdZRw7MmNaK/oFEbdYjxMOiCQipNsVidBdY=;
        b=cWEYDV+dY5cYnXMn2IADOGSloCc3OH/wIBg2KCcN3a1GBDYZK5rpVXHTSZSSIN/yhfKD9K
        8XlUkdVuOUDM59G936HR6j4FbZOl2H5DewIOODAfyBkMcjXYqaEOYz/MpDOMYJNz57yWmE
        pQuBR5WiKkJFnGdKlDddnv9zw7hZeJIARpezajt4Bxgjut4M5LbDIuiqMY9bB9AEE/tjF2
        M3UtuoWNv4dZOFpHAQNjDR5yhYPWMZDbscvMZlYp80E0Kn79G2MbnY46KVamXyOzw6l6qg
        nQzjxn74Ci53FU7fX+qNLFBzEJ36NVdF92GK9x6ZIJWM70t4Jn1qeXdK4q0VTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yamwFyBvrdZRw7MmNaK/oFEbdYjxMOiCQipNsVidBdY=;
        b=4Jqf4+d+0ak1Fk64uiL4SdD5UndpKcuYFGikhaVTmOBL0kGv65OkEbKG0c8uYhV9hqzAUy
        LBd8FLWl65qGHGAQ==
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
Subject: [patch 17/17] x86/fpu: Move FPU initialization into arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the FPU during the early boot process is a pointless
exercise. Early boot is convoluted and fragile enough.

Nothing requires that the FPU is set up early. It has to be initialized
before fork_init() because the task_struct size depends on the FPU register
buffer size.

Move the initialization to arch_cpu_finalize_init() which is the perfect
place to do so.

No functional change.

This allows to remove quite some of the custom early command line parsing,
but that's subject to the next installment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1604,8 +1604,6 @@ static void __init early_identify_cpu(st
 
 	sld_setup(c);
 
-	fpu__init_system();
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
@@ -2287,8 +2285,6 @@ void cpu_init(void)
 
 	doublefault_init_cpu_tss();
 
-	fpu__init_cpu();
-
 	if (is_uv_system())
 		uv_cpu_init();
 
@@ -2304,6 +2300,7 @@ void cpu_init_secondary(void)
 	 */
 	cpu_init_exception_handling();
 	cpu_init();
+	fpu__init_cpu();
 }
 #endif
 
@@ -2396,6 +2393,13 @@ void __init arch_cpu_finalize_init(void)
 			'0' + (boot_cpu_data.x86 > 6 ? 6 : boot_cpu_data.x86);
 	}
 
+	/*
+	 * Must be before alternatives because it might set or clear
+	 * feature bits.
+	 */
+	fpu__init_system();
+	fpu__init_cpu();
+
 	alternative_instructions();
 
 	if (IS_ENABLED(CONFIG_X86_64)) {

