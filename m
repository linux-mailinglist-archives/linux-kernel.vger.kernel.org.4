Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C37430B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjF2Wrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjF2Wrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:47:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522782D62
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:47:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso785437a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688078857; x=1690670857;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe3VVXTfhgmERH1S3UFzICDsEYP3JUpoba49zyue3wg=;
        b=2oFt/dcy5+q/NbyQi+6QdLEFNbr7Ti0x8ZAp8dzndz3Qkorsa5hlW8S57gLu8Xbdl+
         sR+RzbOWoxcoG5pXm772EM78wEqbOkeIIq28nphj0VM0praWSztFXaSBBhbWdKU+rvkg
         ho2G3LxdJv/iiV9mGaJnFry3WnRHNdJ5P8wuQHg7Iy2ahDfIZsGzOy0NYbyQZbvLVwGb
         S+zSeMe5Wa0XUT3JK4iqr7KJHNNEwNyA1zi6tHVhIGX+nZVCmmhpEFJ/crNVHRO/kRdi
         2g7ZVPjjJ5mFDSASAmZOtuqbcLGUySZwLC7vy6SwJ9WC6PeD9q/ObgICdHSJF2tDCI+2
         je3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688078857; x=1690670857;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe3VVXTfhgmERH1S3UFzICDsEYP3JUpoba49zyue3wg=;
        b=koy2C8K3i2axJojkweSIZxEg+qFWEZhBIfMb5kotCYjvnldRU1xF3J4OjJuNcx0SMD
         7n0d7PRxZUHvAVDXcBTIJ2bwuDqIc580cysFsShV1d+IQL7qZBVP+3e/uj5/CM6AKS+3
         HV19ubO7FzPzKpgckOTJAh3Zboi+J89wC6Wq+MVmvgmEoNmEhUKvKdMpcbN7BRO8Z2Ha
         EzPjtlD6g4h1xZxPVXKxvdPOdXJ1ZE2T1iKCqsMOFnSi4Q0ZzJ9xvHT3jtuynfHvYS3y
         sUmODd41LrWksBFcbKWHZ6YGhkKVSo/jHOGOnpsjgsxxM+EqKOPMjApYgRWkM4qMeyH4
         gvQA==
X-Gm-Message-State: ABy/qLY4uE/rCWJuQRhcoLeRL9rbkD3t3bML/qx6PJ1YVs7V90rBl/l2
        r4hQcqYe3ev4hOqv3HLZtAzgXw==
X-Google-Smtp-Source: APBJJlFbx9RlKoS6dssRYz/4odvb3GoqJS1qn6+WFNmyB2yiZ/XTdROQ0PudTL/+h23SeGYb8Al7Aw==
X-Received: by 2002:a17:90b:1bca:b0:261:110e:30c1 with SMTP id oa10-20020a17090b1bca00b00261110e30c1mr1571242pjb.4.1688078856616;
        Thu, 29 Jun 2023 15:47:36 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a005d00b0025645ce761dsm3149983pjb.35.2023.06.29.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:47:35 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:47:35 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Jun 2023 15:37:11 PDT (-0700)
Subject:     Re: [PATCH v2 10/10] RISC-V: provide a Kconfig option to disable parsing "riscv,isa"
In-Reply-To: <20230629-angled-gallantly-8fe7451a25fa@spud>
CC:     ajones@ventanamicro.com, Conor Dooley <conor.dooley@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        Evan Green <evan@rivosinc.com>, sunilvl@ventanamicro.com,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-d1fcf69b-9925-42ec-aa8f-eb3a25eaafe1@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 14:44:18 PDT (-0700), Conor Dooley wrote:
> On Thu, Jun 29, 2023 at 02:16:49PM -0700, Palmer Dabbelt wrote:
>> On Thu, 29 Jun 2023 13:20:55 PDT (-0700), Conor Dooley wrote:
>> > On Thu, Jun 29, 2023 at 03:53:08PM +0200, Andrew Jones wrote:
>> > > On Thu, Jun 29, 2023 at 12:39:51PM +0100, Conor Dooley wrote:
>> > > > On Thu, Jun 29, 2023 at 11:31:33AM +0200, Andrew Jones wrote:
>> > > > > On Thu, Jun 29, 2023 at 09:28:56AM +0100, Conor Dooley wrote:
>> > > > > > As it says on the tin, provide a Kconfig option to disabling parsing the
>> > > > > > "riscv,isa" devicetree property. Hide the option behind NONPORTABLE so
>> > > > > > that only those willing to keep the pieces enable it, and make sure the
>> > > > > > default kernel contains the fallback code.
>> > > > > > > > > Suggested-by: Palmer Dabbelt <palmer@rivosinc.com>
>> > > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> > > > > > ---
>> > > > > >  arch/riscv/Kconfig             | 16 ++++++++++++++++
>> > > > > >  arch/riscv/kernel/cpu.c        |  3 +++
>> > > > > >  arch/riscv/kernel/cpufeature.c |  2 +-
>> > > > > >  3 files changed, 20 insertions(+), 1 deletion(-)
>> > > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > > > > index 1d39efe2b940..0e1909ac5947 100644
>> > > > > > --- a/arch/riscv/Kconfig
>> > > > > > +++ b/arch/riscv/Kconfig
>> > > > > > @@ -291,6 +291,22 @@ config NONPORTABLE
>> > > > > >  > > >  	  If unsure, say N.
>> > > > > >  > > > +config NO_RISCV_ISA_FALLBACK
>> > > > > > +	bool "Permit falling back to parsing riscv,isa for extension support"
>> > > > > > +	depends on NONPORTABLE
>> > > > > > +	help
>> > > > > > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
>> > > > > > +	  replaced by a list of explicitly defined strings. For compatibility
>> > > > > > +	  with existing platforms, the kernel will fall back to parsing the
>> > > > > > +	  "riscv,isa" property if the replacements are not found.
>> > > > > > +
>> > > > > > +	  Selecting Y here will result in a kernel without this fallback, and
>> > > > > > +	  will not work on platforms where the devicetree does not contain the
>> > > > > > +	  replacement 	  properties of "riscv,isa-base" and
>> > > > >                      ^ spacing issue
>> > > > > Huh, weird. Given the tab followed by spaces, it must have snuck
>> > > in
>> > > > during reflow of the text after some rewording.
>> > > > Wonder how I missed it, given that...
>> 
>> I sometimes end up with these when reflowing in vim, the Kconfig help text
>> indent confuses things (though many things confuse whatever vim reflowing
>> I'm using, so I should probably find something better).
>
> I did it by hand, I have no excuses.
>
>> > > > > Should we also have a kernel command line option, 'isa_fallback', where
>> > > > > without this config the command line option is not necessary to fallback,
>> > > > > but, with this config, no fallback will be done unless 'isa_fallback' is
>> > > > > provided?
>> > > > > I don't know, maybe I have the wrong end of the stick but it
>> > > feels a bit
>> > > > premature for something that may never not be hidden behind NONPORTABLE?
>> > > > Perhaps that could be left for a point in time where the default value
>> > > > of the symbol changes, or the dependency on NONPORTABLE is removed?
>> > > >
>> 
>> I agree it might not be worth the work, but looks like that's done...
>
> Well, whether I did it or not doesn't mean it has to be included in the
> series. The work wasn't all that much to be honest.
>
>> > > With the command line option, we could consider dropping NONPORTABLE (but
>> > > still default off this config). What I'm thinking is that if we want to
>> > > encourage the adoption of the new format, then there should be a bit of
>> > > pain when it's not used, but not enough pain to risk rebellion. So,
>> > > 
>> > >  * defconfig builds will silently/painlessly fallback
>> > > 
>> > >  * builds that want to encourage adoption enable this config and will
>> > >    fail to boot when they don't get what they want and don't have the
>> > >    command line option
>> > > 
>> > >  * users still working through the growing pains can manage when
>> > >    the boot fails, and when it doesn't, with the command line
>> > 
>> > So, something like the following squashed in? I inverted the config
>> > option, seemed more natural that way.
>> > 
>> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> > index d910fba25f2c..6c0d0bc06048 100644
>> > --- a/Documentation/admin-guide/kernel-parameters.txt
>> > +++ b/Documentation/admin-guide/kernel-parameters.txt
>> > @@ -5437,6 +5437,13 @@
>> >  			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
>> >  			CPUs.
>> > +	riscv_isa_fallback [RISCV]
>> > +			Fall back to detecting extension support using the
>> > +			"riscv,isa" property on devicetree systems when the
>> > +			replacement properties are not found, on kernels where
>> > +			RISCV_ISA_FALLBACK is not enabled. See the Kconfig entry
>> > +			for RISCV_ISA_FALLBACK.
>> > +
>> >  	ro		[KNL] Mount root device read-only on boot
>> >  	rodata=		[KNL]
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 0370713ad965..a9a473b67182 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -291,22 +291,6 @@ config NONPORTABLE
>> >  	  If unsure, say N.
>> > -config NO_RISCV_ISA_FALLBACK
>> > -	bool "Permit falling back to parsing riscv,isa for extension support"
>> > -	depends on NONPORTABLE
>> > -	help
>> > -	  Parsing the "riscv,isa" devicetree property has been deprecated and
>> > -	  replaced by a list of explicitly defined strings. For compatibility
>> > -	  with existing platforms, the kernel will fall back to parsing the
>> > -	  "riscv,isa" property if the replacements are not found.
>> > -
>> > -	  Selecting Y here will result in a kernel without this fallback, and
>> > -	  will not work on platforms where the devicetree does not contain the
>> > -	  replacement properties of "riscv,isa-base" and "riscv,isa-extensions".
>> > -	  Please see the dt-binding, located at
>> > -	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
>> > -	  on the replacement properties.
>> > -
>> >  choice
>> >  	prompt "Base ISA"
>> >  	default ARCH_RV64I
>> > @@ -857,6 +841,24 @@ config XIP_PHYS_ADDR
>> >  	  be linked for and stored to.  This address is dependent on your
>> >  	  own flash usage.
>> > +config RISCV_ISA_FALLBACK
>> > +	bool "Permit falling back to parsing riscv,isa for extension support by default"
>> > +	default y
>> 
>> I think the only risk here is that randconfig will result in systems that
>> don't boot, but we're already stuck with no meaningful base requirements.
>> Fixing that is a way bigger hurdle than this, so IMO it's fine.
>
> Maybe I'm way off here, but I didn't think that we had to be worried
> about randconfigs not booting, as it was a testing tool?

IIRC at least some ports had randconfigs that booted, there was just 
some standard set of drivers always built in.  We're a long way from 
that, though, so whatever.

>> > +	help
>> > +	  Parsing the "riscv,isa" devicetree property has been deprecated and
>> > +	  replaced by a list of explicitly defined strings. For compatibility
>> > +	  with existing platforms, the kernel will fall back to parsing the
>> > +	  "riscv,isa" property if the replacements are not found.
>> > +
>> > +	  Selecting N here will result in a kernel that does not use the
>> > +	  fallback, unless the commandline "riscv_isa_fallback" parameter is
>> > +	  present.
>> > +
>> > +	  Please see the dt-binding, located at
>> > +	  Documentation/devicetree/bindings/riscv/extensions.yaml for details
>> > +	  on the replacement properties of "riscv,isa-base" and
>> > +	  "riscv,isa-extensions".
>> > +
>> >  endmenu # "Boot options"
>> >  config BUILTIN_DTB
>> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> > index e3cda14a486b..52fa607a1691 100644
>> > --- a/arch/riscv/include/asm/hwcap.h
>> > +++ b/arch/riscv/include/asm/hwcap.h
>> > @@ -81,6 +81,7 @@ struct riscv_isa_ext_data {
>> >  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>> >  extern const size_t riscv_isa_ext_count;
>> > +extern bool riscv_isa_fallback_cmdline;
>> > 
>> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> > index 86a1d98b8b3b..1e4cbdedc7fc 100644
>> > --- a/arch/riscv/kernel/cpu.c
>> > +++ b/arch/riscv/kernel/cpu.c
>> > @@ -81,7 +81,7 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
>> >  	return 0;
>> >  old_interface:
>> > -	if (IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK))
>> > +	if (!IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) && !riscv_isa_fallback_cmdline)
>> >  		return -ENODEV;
>> >  	if (of_property_read_string(node, "riscv,isa", &isa)) {
>> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> > index f6fb18d2af84..5d848b7c1dde 100644
>> > --- a/arch/riscv/kernel/cpufeature.c
>> > +++ b/arch/riscv/kernel/cpufeature.c
>> > @@ -471,6 +471,14 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>> >  	return 0;
>> >  }
>> > +bool __initdata riscv_isa_fallback_cmdline = false;
>> > +static int __init riscv_isa_fallback_setup(char *__unused)
>> 
>> Maybe it's better to support =true and =false here?  Not sure it matters,
>> we're already down a rabbit hole ;)
>
> Dunno, not implemented a cmdline param before. Seemed "cleaner" to check
> for presence, don't really care so I'll adapt to w/e.
>
>> > +{
>> > +	riscv_isa_fallback_cmdline = true;
>> > +	return 1;
>> > +}
>> > +early_param("riscv_isa_fallback", riscv_isa_fallback_setup);
>> 
>> IMO it's cleaner to just set the default based on the Kconfig, that way
>> there's only one thing to check.  We're already duplicating the "check both
>> Kconfig and cmdline" logic twice, there's probably going to be others
>> eventually.
>
> Sure.
>
>> > +
>> >  void __init riscv_fill_hwcap(void)
>> >  {
>> >  	char print_str[NUM_ALPHA_EXTS + 1];
>> > @@ -490,7 +498,7 @@ void __init riscv_fill_hwcap(void)
>> >  	} else {
>> >  		int ret = riscv_fill_hwcap_from_ext_list(isa2hwcap);
>> > -		if (ret && !IS_ENABLED(CONFIG_NO_RISCV_ISA_FALLBACK)) {
>> > +		if (ret && (IS_ENABLED(CONFIG_RISCV_ISA_FALLBACK) || riscv_isa_fallback_cmdline)) {
>> >  			pr_info("Falling back to deprecated \"riscv,isa\"\n");
>> >  			riscv_fill_hwcap_from_isa_string(isa2hwcap);
>> >  		}
>> 
>> I haven't read the whole patch set, but at least having a nice error for why
>> probing didn't happen seems like the right way to go here.  IIUC this is
>> just silent when ISA string fallbacks are disabled and the new properties
>> aren't there.
>> 
>
>> Sorry in advance if it's just somewhere outside the diff, though.
>
> It sorta is. You'll actually not even reach this code if probing fails.
> Because riscv_early_of_processor_hartid(), which is called super early
> on in of_parse_and_init_cpus(), checks whether there are any valid
> harts (including checking for sufficient extension support to run a
> kernel) we will hit a BUG() during setup_smp() & blow up really early:
>
> [    0.000000] Linux version 6.4.0-rc1-00096-ge0097d2c62d5-dirty (conor@spud) (ClangBuiltLinux clang version 15.0.7 (/stuff/brsdk/llvm/clang 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a), ClangBuiltLinux LLD 15.0.7) #1 SMP PREEMPT @666
> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> [    0.000000] SBI specification v0.3 detected
> [    0.000000] SBI implementation ID=0x1 Version=0x10000
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI SRST extension detected
> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '115200n8')
> [    0.000000] printk: bootconsole [ns16550a0] enabled
> [    0.000000] printk: debug: skip boot console de-registration.
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x00000000bfc00000..0x00000000bfffffff (4096 KiB) nomap non-reusable region@BFC00000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfbfffff]
> [    0.000000]   node   0: [mem 0x00000000bfc00000-0x00000000bfffffff]
> [    0.000000]   node   0: [mem 0x0000001040000000-0x000000107fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000107fffffff]
> [    0.000000] SBI HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:174!
> [    0.000000] Kernel BUG [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00096-ge0097d2c62d5-dirty #1
> [    0.000000] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> [    0.000000] epc : of_parse_and_init_cpus+0x16c/0x16e
> [    0.000000]  ra : of_parse_and_init_cpus+0x9a/0x16e
> [    0.000000] epc : ffffffff80c04e0a ra : ffffffff80c04d38 sp : ffffffff81603e20
> [    0.000000]  gp : ffffffff8182d658 tp : ffffffff81613f80 t0 : 000000000000006e
> [    0.000000]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffff81603e80
> [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.000000]  a5 : 0000000000001fff a6 : 0000000000001fff a7 : ffffffff816148b0
> [    0.000000]  s2 : 0000000000000001 s3 : ffffffff81492a4c s4 : ffffffff81a4b090
> [    0.000000]  s5 : ffffffff81506030 s6 : 0000000000000040 s7 : 0000000000000000
> [    0.000000]  s8 : 00000000bfb6f046 s9 : 0000000000000001 s10: 0000000000000000
> [    0.000000]  s11: 00000000bf389700 t3 : 0000000000000000 t4 : 0000000000000000
> [    0.000000]  t5 : ffffffff824dd188 t6 : ffffffff824dd187
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.000000] [<ffffffff80c04e0a>] of_parse_and_init_cpus+0x16c/0x16e
> [    0.000000] [<ffffffff80c04c96>] setup_smp+0x1e/0x26
> [    0.000000] [<ffffffff80c03ffe>] setup_arch+0x6e/0xb2
> [    0.000000] [<ffffffff80c00384>] start_kernel+0x72/0x400
> [    0.000000] Code: 80e7 4a00 a603 0009 b795 1097 ffe5 80e7 92c0 9002 (9002) 715d 
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception in interrupt

Thanks, I guess we can add a warning independently of these changes.

https://lore.kernel.org/r/20230629223502.1924-1-palmer@rivosinc.com/
