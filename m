Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363F4699C84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBPSmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:42:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E330646174;
        Thu, 16 Feb 2023 10:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92AD7B8293F;
        Thu, 16 Feb 2023 18:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8645EC433D2;
        Thu, 16 Feb 2023 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676572921;
        bh=+sMmN2IJBomErQJnP8GjKXcy2h70Xrt73RBGKymR0H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VModKb3fOKbOeGAfrMtcxWG8Hr22AYe+0gtAQb49CSGfCviRThwkBpO8fFnnwUTSV
         E4hgXNUKfEN+clH4h03E1aufyNQSj1mSnq9Vo29Kl5bJ5GqVEXWFIw1p5asDpvsioC
         JBvLRlQLFKtSrt0jAdGj0RnHQLW07q9G/u/tUU6dMjMJGte6KKw3VKLH5O2qq3YmXT
         1H/Hq7Um9b66v+XQUlM04J510C4wS4Nlvj1PntzoSiTqVG8CV1ErpLQg67WmsfQ9G5
         ZAEVlFxb2/JEE+olKEpmHAVug71xwO3+q2dEqxmcS6shyfVGKxKtuT5r0pyLprf9Xh
         vuADtQm3K08UA==
Date:   Thu, 16 Feb 2023 10:41:57 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        juri.lelli@redhat.com, dalias@libc.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, peterz@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        x86@kernel.org, jiaxun.yang@flygoat.com,
        linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com,
        guoren@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        kernel@xen0n.name, will@kernel.org, vschneid@redhat.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        ysato@users.sourceforge.jp, chenhuacai@kernel.org,
        linux@armlinux.org.uk, linux-csky@vger.kernel.org,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        bcm-kernel-feedback-list@broadcom.com, mgorman@suse.de,
        mattst88@gmail.com, linux-xtensa@linux-xtensa.org,
        paulmck@kernel.org, richard.henderson@linaro.org,
        npiggin@gmail.com, ink@jurassic.park.msu.ru, rostedt@goodmis.org,
        loongarch@lists.linux.dev, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, jgross@suse.com,
        chris@zankel.net, tsbogend@alpha.franken.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        bp@alien8.de, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: [PATCH v2.1 04/24] arm64/cpu: Mark cpu_die() __noreturn
Message-ID: <20230216184157.4hup6y6mmspr2kll@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <e47fc487980d5330e6059ac6e16416bec88cda0e.1676358308.git.jpoimboe@kernel.org>
 <14274f04-2991-95bd-c29b-07e86e8755c1@linaro.org>
 <Y+zZgZIP7RPIgyQf@FVFF77S0Q05N>
 <20230215194538.aiiris3uabnuvkkg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230215194538.aiiris3uabnuvkkg@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_die() doesn't return.  Annotate it as such.  By extension this also
makes arch_cpu_idle_dead() noreturn.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/smp.h | 2 +-
 arch/arm64/kernel/smp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index fc55f5a57a06..5733a31bab08 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -100,7 +100,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 extern int __cpu_disable(void);
 
 extern void __cpu_die(unsigned int cpu);
-extern void cpu_die(void);
+extern void __noreturn cpu_die(void);
 extern void cpu_die_early(void);
 
 static inline void cpu_park_loop(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4e8327264255..d5d09a18b4f8 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -361,7 +361,7 @@ void __cpu_die(unsigned int cpu)
  * Called from the idle thread for the CPU which has been shutdown.
  *
  */
-void cpu_die(void)
+void __noreturn cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
 	const struct cpu_operations *ops = get_cpu_ops(cpu);
-- 
2.39.1

