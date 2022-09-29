Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F35EFDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiI2TJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiI2TJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:09:39 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 12:09:35 PDT
Received: from sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA32AC3;
        Thu, 29 Sep 2022 12:09:33 -0700 (PDT)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 1aa38a8c;
        Thu, 29 Sep 2022 21:02:51 +0200 (CEST)
Date:   Thu, 29 Sep 2022 21:02:51 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     "Sven Peter" <sven@svenpeter.dev>
Cc:     konrad.dybcio@somainline.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, towinchenmi@gmail.com,
        marcan@marcan.st, alyssa@rosenzweig.io, tglx@linutronix.de,
        maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <0dd4f0ad-62bd-42c3-9518-41675c7ffda8@app.fastmail.com>
        (sven@svenpeter.dev)
Subject: Re: [PATCH v2 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
References: <20220929144039.40011-1-konrad.dybcio@somainline.org>
 <20220929144039.40011-2-konrad.dybcio@somainline.org> <0dd4f0ad-62bd-42c3-9518-41675c7ffda8@app.fastmail.com>
Message-ID: <d3cf1dd1add16afe@bloch.sibelius.xs4all.nl>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 29 Sep 2022 16:50:24 +0200
> From: "Sven Peter" <sven@svenpeter.dev>
> 
> On Thu, Sep 29, 2022, at 16:40, Konrad Dybcio wrote:
> > Add support for A7-A11 SoCs by if-ing out some features only present
> > on:
> >
> > * A11 & newer (implementation-defined IPI & UNCORE registers)
> > * A11[1] & newer (fast IPI support).
> >
> > Also, annotate IPI regs support in the aic struct so that the driver
> > can tell whether the SoC supports these, as they are written to,
> > even if fast IPI is disabled. This in turn causes a crash on older
> > platforms, as the implemention-defined registers either do
> > something else or are not supposed to be touched - definitely not a
> > NOP though.
> >
> > [1] A11 is supposed to use this feature, but it currently doesn't work
> > for reasons unknown and hence remains disabled. It can easily be enabled
> > on A11 only, as there is a SoC-specific compatible in the DT with a
> > fallback to apple,aic, so that the interrupt controller gets to probe
> > regardless of whether IPI Sn_... registers are used or not.
> > That said, it is not yet necessary, especially with only one core up,
> > and it has worked a-ok so far.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> > Changes since v1:
> > - remove EL2 register check (dts change covered this)
> > - use static_branch instead of ifs
> > - rename "uncore2 registers" to "uncore registers" in added code and
> > update the commit message accordingly
> > - create a "legacy" config struct for pre-A11 targets
> > - rewrite the commit message a bit to match actual status
> >
> >  drivers/irqchip/irq-apple-aic.c | 56 ++++++++++++++++++++++++---------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> > index 1c2813ad8bbe..cdef99bfcfb3 100644
> > --- a/drivers/irqchip/irq-apple-aic.c
> > +++ b/drivers/irqchip/irq-apple-aic.c
> > @@ -229,6 +229,7 @@
> >  #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
> > 
> >  static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
> > +static DEFINE_STATIC_KEY_TRUE(has_uncore_regs);
> > 
> >  struct aic_info {
> >  	int version;
> > @@ -246,6 +247,7 @@ struct aic_info {
> > 
> >  	/* Features */
> >  	bool fast_ipi;
> > +	bool uncore_regs;
> >  };
> > 
> >  static const struct aic_info aic1_info = {
> > @@ -253,6 +255,8 @@ static const struct aic_info aic1_info = {
> > 
> >  	.event		= AIC_EVENT,
> >  	.target_cpu	= AIC_TARGET_CPU,
> > +
> > +	.uncore_regs	= true,
> >  };
> > 
> >  static const struct aic_info aic1_fipi_info = {
> > @@ -264,6 +268,13 @@ static const struct aic_info aic1_fipi_info = {
> >  	.fast_ipi	= true,
> >  };
> > 
> > +static const struct aic_info aic1_legacy_info = {
> > +	.version	= 1,
> > +
> > +	.event		= AIC_EVENT,
> > +	.target_cpu	= AIC_TARGET_CPU,
> > +};
> > +
> >  static const struct aic_info aic2_info = {
> >  	.version	= 2,
> > 
> > @@ -273,6 +284,10 @@ static const struct aic_info aic2_info = {
> >  };
> > 
> >  static const struct of_device_id aic_info_match[] = {
> > +	{
> > +		.compatible = "apple,s5l8960x-aic",
> > +		.data = &aic1_legacy_info,
> > +	},
> 
> Maybe I'm confused but shouldn't this be the apple,aic fallback and
> uncore_regs should be enabled for e.g. t8103-aic then?

In principle, no.  Several Linux kernels shipped with a apple_aic
irqchip driver that assumes the presence of the "uncore" registers for
"apple,aic".  And that means the "apple,aic" shouldn't be used to
represent the interrupt controllers on SoCs with older cores that
don't have those uncore registers.

That said, given that there was no support for these older SoCs in
those Linux kernels anyway, one could argue that the existing
"apple,aic" support is unused and that we can redefine it to mean that
the uncore registers are there.  I agree that would be a bit more
logical.

> >  	{
> >  		.compatible = "apple,t8103-aic",
> >  		.data = &aic1_fipi_info,
> > @@ -524,12 +539,14 @@ static void __exception_irq_entry 
> > aic_handle_fiq(struct pt_regs *regs)
> >  	 * we check for everything here, even things we don't support yet.
> >  	 */
> > 
> > -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> > -		if (static_branch_likely(&use_fast_ipi)) {
> > -			aic_handle_ipi(regs);
> > -		} else {
> > -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
> > -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> > +	if (static_branch_likely(&use_fast_ipi)) {
> > +		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> > +			if (static_branch_likely(&use_fast_ipi)) {
> > +				aic_handle_ipi(regs);
> > +			} else {
> > +				pr_err_ratelimited("Fast IPI fired. Acking.\n");
> > +				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> > +			}
> 
> This doesn't make much sense:
> 
> if (A) {
>     if (B) {
>         if (A) { // A is already guaranteed to be true here, why check it again?
>             // ...
>         } else {
>             // how can this ever be reached then?
>         }
>     }
> }
> 
> >  		}
> >  	}
> > 
> > @@ -566,12 +583,14 @@ static void __exception_irq_entry 
> > aic_handle_fiq(struct pt_regs *regs)
> >  					  AIC_FIQ_HWIRQ(irq));
> >  	}
> > 
> > -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == 
> > UPMCR0_IMODE_FIQ &&
> > -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
> > -		/* Same story with uncore PMCs */
> > -		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> > -		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> > -				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> > +	if (static_branch_likely(&has_uncore_regs)) {
> > +		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) ==
> > +			UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & 
> > UPMSR_IACT)) {
> > +			/* Same story with uncore PMCs */
> > +			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
> > +			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> > +					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> > +		}
> >  	}
> >  }
> > 
> > @@ -944,7 +963,8 @@ static int aic_init_cpu(unsigned int cpu)
> >  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
> > 
> >  	/* Pending Fast IPI FIQs */
> > -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> > +	if (static_branch_likely(&use_fast_ipi))
> > +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> > 
> >  	/* Timer FIQs */
> >  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
> > @@ -965,8 +985,9 @@ static int aic_init_cpu(unsigned int cpu)
> >  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
> > 
> >  	/* Uncore PMC FIQ */
> > -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> > -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> > +	if (static_branch_likely(&has_uncore_regs))
> > +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> > +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> > 
> >  	/* Commit all of the above */
> >  	isb();
> > @@ -1125,6 +1146,11 @@ static int __init aic_of_ic_init(struct 
> > device_node *node, struct device_node *p
> >  	else
> >  		static_branch_disable(&use_fast_ipi);
> > 
> > +	if (irqc->info.uncore_regs)
> > +		static_branch_enable(&has_uncore_regs);
> > +	else
> > +		static_branch_disable(&has_uncore_regs);
> > +
> >  	irqc->info.die_stride = off - start_off;
> > 
> >  	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
> > -- 
> > 2.30.2
> 
> 
> Sven
> 
> 
