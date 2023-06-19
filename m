Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE38E734F33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFSJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFSJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:10:43 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663039E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:10:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:b30c:87ec:6d02:5999])
        by laurent.telenet-ops.be with bizsmtp
        id AxAe2A0034R9QC301xAevg; Mon, 19 Jun 2023 11:10:38 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qBAuE-0096JT-4j;
        Mon, 19 Jun 2023 11:10:38 +0200
Date:   Mon, 19 Jun 2023 11:10:38 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4-rc7
In-Reply-To: <20230619084641.3909582-1-geert@linux-m68k.org>
Message-ID: <8e673d4-9748-1e3c-998-346ee1742ac2@linux-m68k.org>
References: <CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com> <20230619084641.3909582-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4-rc7[1] to v6.4-rc6[3], the summaries are:
>  - build errors: +1/-5

   + {standard input}: Error: branch to a symbol in another ISA mode: 5023, 5028 => 5017, 5023, 5028, 5012

mips-gcc1[12]/micro32r2{,el}_defconfig

Not exactly a new problem, but we got two new of these while compiling
arch/mips/kernel/smp-cps.o, due to the addition of two gcc12 builds.

I could reproduce this with micro32r2_defconfig on next-20230691 using
gcc-12.3.0 from kernel.org crosstool.

In arch/mips/kernel/smp-cps.c:

     static void cps_init_secondary(void)
     {
 	    int core = cpu_core(&current_cpu_data);

 	    /* Disable MT - we only want to run 1 TC per VPE */
 	    if (cpu_has_mipsmt)
 		    dmt();

 	    ...
     }

"make arch/mips/kernel/smp-cps.s" shows cps_init_secondary() is compiled
with the following ISA settings:

         .set    nomips16
         .set    micromips

while arch/mips/include/asm/mipsmtregs.h has:

     static inline unsigned int dmt(void)
     {
 	    int res;

 	    __asm__ __volatile__(
 	    "       .set    push                                            \n"
 	    "       .set    mips32r2                                        \n"
 	    "       .set    noat                                            \n"
 	    "       .word   0x41610BC1                      # dmt $1        \n"
 	    "       ehb                                                     \n"
 	    "       move    %0, $1                                          \n"
 	    "       .set    pop                                             \n"
 	    : "=r" (res));

 	    instruction_hazard();

 	    return res;
     }

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/858fd168a95c5b9669aac8db6c14a9aeab446375/ (151 out of 160 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
