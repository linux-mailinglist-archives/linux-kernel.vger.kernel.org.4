Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDF602EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJROhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJROhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:37:35 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F1C96E5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:37:32 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so16985798fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxRDfZMZNrc4Ncufu2OP6FjO8vztVdFebuxiKHWlA2Q=;
        b=IesgMLLddS1QPfhoLPNJVx4s10lcBRp58iLxN5IWwLtS5ouroGSk6ErRCv47bpTnQb
         nTkApuzustKs8UvzcCrl9WfTdyxSReP8AzxAQQsB1hrSO/HUKAEJL3fQQ5+Q9YOpAZW1
         x6ZQ3lKO2xwhg5ycyZXUgTxltifG6vgyyVlWh9VWFhi+jFeT32tSEINkJT7RpR0zr3x8
         7Ouizwv6R0GCfTdTXk96Dt3xt2ZxVYMQYdDVNnmMmfOL3QDDzoSChbMVvF/ucZ0f43G7
         N+cq+Xdt8gSOjk5Q1NOs2/thDjDR4lR3kxwHr+1Cy1OR4WagqY0YOmHE4h4Wijomg4qd
         FLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxRDfZMZNrc4Ncufu2OP6FjO8vztVdFebuxiKHWlA2Q=;
        b=Q44+awcJTjTFWjl+qoGhQ3QIwZ7nWnz/YT+b77LjecbBYTXSL8xN6UIbaphJU0TBUZ
         8PN6av7r+UkH8ovYAHlC55JLjQB00vrSZ8UuvNwcPt3oaihicAxS2gb5yJkO/9C7nh2e
         80cwrVLXke+5iGhwZo4e+ySqwFRULdo5+ToCIrCbv84Zs0diD4tO/GhM4zaFaqbDITpU
         I8jf4pJkL/8TaLenoEZ4l/ExNrceazp5u9wUv4OkFyWUU5zQiH310nbMYs0knKsUTKBX
         aotUcdExFCHyhesrFTEFx4jo5C+/VZmdP8OOZ02Gkote00Vv/MPRydtdf5QKt+JaId8o
         bHJQ==
X-Gm-Message-State: ACrzQf2v2Xbt6is1MSRcsWK+rXyUEFxJ3QEW3IJt2yzZX2NNR2fcpOUO
        cHjBuXrTkaCFsjrelj3R6tB/trIVBLs=
X-Google-Smtp-Source: AMsMyM5jWiVxvssbV3zG/lktM++02RGskrzqfA9/a5geOMf8Q86oo8UTPwpX36EzA4QgTIb/MLENwA==
X-Received: by 2002:a05:6870:538d:b0:136:3cc4:78fa with SMTP id h13-20020a056870538d00b001363cc478famr18790732oan.278.1666103840488;
        Tue, 18 Oct 2022 07:37:20 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm6232454oao.56.2022.10.18.07.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:37:19 -0700 (PDT)
Date:   Tue, 18 Oct 2022 07:35:09 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
Message-ID: <Y065nbfVQwZhwt51@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com>
 <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com>
 <mvmlepdb66h.fsf@suse.de>
 <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:50:31PM +0200, Geert Uytterhoeven wrote:
> Hi Andreas,
> 
> On Tue, Oct 18, 2022 at 3:41 PM Andreas Schwab <schwab@suse.de> wrote:
> > On Okt 18 2022, Geert Uytterhoeven wrote:
> > > Moreover, this cannot be used on all systems.  E.g. on Icicle Kit with
> > > Microchip PolarFire SoC, CONFIG_NR_CPUS needs to be larger than 4,
> > > as the system has actually 5 CPU cores (1xE51 and 4xU54), but Linux
> > > runs only on 4 of them.  So you cannot use FORCE_NR_CPUS=y.
> >
> > But does Linux acually see the E51 core?  On the Hifive boards it is
> > disabled in the device tree, and the cpu probing just skips it,
> > effectively resulting in only four cpus.
> 
> The E51 is indeed disabled in DT.
> The CPU parts of arch/riscv/boot/dts/sifive/fu540-c000.dtsi and
> arch/riscv/boot/dts/microchip/mpfs.dtsi arre very similar.
> Do you get 4 CPUs on Hifive with CONFIG_NR_CPUS=4?
> 
> Gr{oetje,eeting}s,

Hi Geert, Andreas,

Thanks for pointing that. Indeed, it should be disabled in
allmodconfig.

Linus also asked to make this option depending on CONFIG_EXPERT.
So, I'm working on a patch.

From general considerations, NR_CPUS defines length of cpumasks,
per-cpu arrays etc. If it's impossible to boot Linux on a specific
core, we don't need to reserve memory for all that. In other words,
number of possible CPUs in your example should be equal to 4.

When FORCE_NR_CPUS=y, the boot code still parses DT/ACPI tables for
actual numbers of CPUs, and if it doesn't equal to NR_CPUS, prints
a message in syslog. 

For those who choose FORCE_NR_CPUS, it's required to set NR_CPUS
to a value that matches to what's parsed from DT.

Can you please look at the draft below that disables FORCE_NR_CPUS
in allmodconfig? If it's OK with you, I'll send a patch. If you think
that there are architectures where it's not possible to set correct
NR_CPUS at compile time for some reason, I'll add ARCH_UNFORCE_NR_CPUS
option.

Thanks,
Yury
---
 lib/Kconfig | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9bbf8a4b2108..578cee3593d7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -528,15 +528,33 @@ config CPUMASK_OFFSTACK
 	  them on the stack.  This is a bit more expensive, but avoids
 	  stack overflow.
 
+choice
+	prompt "Number of CPUs detection"
+	default UNFORCE_NR_CPUS
+        depends on SMP && EXPERT
+	help
+	  Select between boot-time and compile-time detection of number
+	  of CPUs. If it's possible to provide exact number of CPUs at
+	  compile-time, kernel code may be optimized better.
+
+	  For general-purpose kernel, choose "boot time" option.
+
+config UNFORCE_NR_CPUS
+	bool "Detect number of CPUs at boot time"
+	help
+	  Choose it if you build general-purpose kernel and want to rely
+	  on kernel to detect actual number of CPUs.
+
 config FORCE_NR_CPUS
        bool "NR_CPUS is set to an actual number of CPUs"
-       depends on SMP
        help
          Say Yes if you have NR_CPUS set to an actual number of possible
          CPUs in your system, not to a default value. This forces the core
          code to rely on compile-time value and optimize kernel routines
          better.
 
+endchoice
+
 config CPU_RMAP
 	bool
 	depends on SMP
-- 
2.34.1

