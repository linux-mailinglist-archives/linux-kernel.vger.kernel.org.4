Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1405B5BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiILODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiILOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:02:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3746932AB9;
        Mon, 12 Sep 2022 07:02:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oXk1M-0007Yg-04; Mon, 12 Sep 2022 16:02:44 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0D555C1291; Mon, 12 Sep 2022 16:02:34 +0200 (CEST)
Date:   Mon, 12 Sep 2022 16:02:34 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aleksander Bajkowski <olek2@wp.pl>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Message-ID: <20220912140233.GA9366@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org>
 <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
 <794a2039-cdf7-2676-482f-9913a8949647@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794a2039-cdf7-2676-482f-9913a8949647@wp.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 12:53:40PM +0200, Aleksander Bajkowski wrote:
> Hi THomas,
> 
> On 7/7/22 16:39, Thomas Bogendoerfer wrote:
> [...]
> >> Or can you point me to the code in
> >> drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
> >> interrupts on VPE 1 (is it simply unmask_mips_irq)?
> > 
> > IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
> > on the same CPU. I've checked MIPS MT specs and it's possible do
> > modify CP0 registers between VPEs. Using that needs changes in
> > irq-mips-cpu.c. But mabye that's not woth the effort as probably
> > all SMP cabable platforms have some multi processort capable
> > interrupt controller implemented.
> > 
> > I thought about another way solve the issue. By introducing a
> > new function in smp-mt.c which sets the value of the interrupt
> > mask for the secondary CPU, which is then used in vsmp_init_secondary().
> > Not sure if this is worth the effort compared to a .boot_secondary
> > override.
> 
> 
> Enabling interrupts on the second VPE using hotplug will be accepted
> upstream? Below is a sample patch.

as this is just another hack, below is what I prefer.

Thomas.

commit 15853dc9e6d213558acbf961f98e9f77b4b61db2
Author: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Mon Sep 12 15:59:44 2022 +0200

    my lantiq approach

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index c731082a0c42..1cc4f56b57f6 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -84,6 +84,16 @@ void __init plat_mem_setup(void)
 	__dt_setup_arch(dtb);
 }
 
+#if defined(CONFIG_MIPS_MT_SMP)
+extern const struct plat_smp_ops vsmp_smp_ops;
+static struct plat_smp_ops lantiq_smp_ops;
+
+static void lantiq_init_secondary(void)
+{
+	set_c0_status(ST0_IM);
+}
+#endif
+
 void __init prom_init(void)
 {
 	/* call the soc specific detetcion code and get it to fill soc_info */
@@ -95,7 +105,13 @@ void __init prom_init(void)
 	prom_init_cmdline();
 
 #if defined(CONFIG_MIPS_MT_SMP)
-	if (register_vsmp_smp_ops())
+
+	if (cpu_has_mipsmt) {
+		lantiq_smp_ops = vsmp_smp_ops;
+		lantiq_smp_ops.init_secondary = lantiq_init_secondary;
+		register_smp_ops(&lantiq_smp_ops);
+	} else {
 		panic("failed to register_vsmp_smp_ops()");
+	}
 #endif
 }

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
