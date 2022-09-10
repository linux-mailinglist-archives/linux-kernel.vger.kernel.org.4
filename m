Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CC5B45F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIJKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIJKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 06:53:21 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358317549B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 03:53:18 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 1134 invoked from network); 10 Sep 2022 12:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1662807195; bh=ySIT/E9Gt09cmxMpPlzE5Vy+axb5DVXkBXG6cqkUlbA=;
          h=Subject:To:Cc:From;
          b=pSjJ7yhl30zGLZHJaOwWzCg+aLFhNWRw7QMA74OmvSSmzKvUzNEmgRZa0vfLk8FuC
           NenomNaZwQstKZhrLYzHm9u8bQbd9y4ckNEeDJ4opuD6XJO4xnOIpnOueIT/XaLJ7M
           Ky4jgg/D88SkfoZHxycdGNSej9fezo46aBXd0ddE=
Received: from ip-137-21.ds.pw.edu.pl (HELO [192.168.3.133]) (olek2@wp.pl@[194.29.137.21])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tsbogend@alpha.franken.de>; 10 Sep 2022 12:53:15 +0200
Message-ID: <794a2039-cdf7-2676-482f-9913a8949647@wp.pl>
Date:   Sat, 10 Sep 2022 12:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Content-Language: en-US
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
 <20220707143930.GA14693@alpha.franken.de>
From:   Aleksander Bajkowski <olek2@wp.pl>
In-Reply-To: <20220707143930.GA14693@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-WP-MailID: d28ee153a6549419ec426d4a137f785b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000C [geMU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi THomas,

On 7/7/22 16:39, Thomas Bogendoerfer wrote:
[...]
>> Or can you point me to the code in
>> drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
>> interrupts on VPE 1 (is it simply unmask_mips_irq)?
> 
> IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
> on the same CPU. I've checked MIPS MT specs and it's possible do
> modify CP0 registers between VPEs. Using that needs changes in
> irq-mips-cpu.c. But mabye that's not woth the effort as probably
> all SMP cabable platforms have some multi processort capable
> interrupt controller implemented.
> 
> I thought about another way solve the issue. By introducing a
> new function in smp-mt.c which sets the value of the interrupt
> mask for the secondary CPU, which is then used in vsmp_init_secondary().
> Not sure if this is worth the effort compared to a .boot_secondary
> override.


Enabling interrupts on the second VPE using hotplug will be accepted
upstream? Below is a sample patch.

Unfortunately, this is not a generic solution. If in the future there
are more platforms that require a similar patch, this can be converted
into some generic solution.

--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -335,6 +336,18 @@ static const struct irq_domain_ops irq_domain_ops = {
 	.map = icu_map,
 };
 
+static int lantiq_cpu_starting(unsigned int cpu)
+{
+	/*
+	 * MIPS CPU startup function vsmp_init_secondary() will only enable some of
+	 *  the interrupts for the second CPU/VPE. Fix this during hotplug.
+	 */
+	if (cpu > 0)
+		set_c0_status(ST0_IM);
+
+	return 0;
+}
+
 int __init icu_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct device_node *eiu_node;
@@ -410,6 +423,10 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	}
 	of_node_put(eiu_node);
 
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LANTIQ_STARTING,
+				  "arch/mips/lantiq:starting",
+				  lantiq_cpu_starting, NULL);
+
 	return 0;
 }
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_RISCV_STARTING,
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_LANTIQ_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,


Best regards,
Aleksander
