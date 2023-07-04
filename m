Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08C747511
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGDPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjGDPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0877E6D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593686117E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 15:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DFDC433C9;
        Tue,  4 Jul 2023 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688483647;
        bh=L1RT2m6C1+fjrGRPpTQjzSDDvX4IBJkdX2ph7y1XPZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgPS4osKR4bnvs+mM5BG085keduX6PaSi+MZun8+2JXB2kz4+0iDl5Xvv6I/b1AUi
         gnBMWWjpuj9wlfDpQPut+jcyXksFVVOhNZPW0/W7nnH6eh+BN4Np4BbGykh6J86OxI
         zYHyOreP04CqeqwhGl8ispClVgfasElP/vt6I12nJoT3Vp8jtUUQpCNWnHQzFPixEG
         Utt+luEMi33WVEDzMgjybjMq0dKxQ3EbnmEmeFie1S5Hk3tlXUvJsd//neQdscyQvG
         Fye8R0k1YwugZHEO9qr3LqG2VAF9g/NHbFd7jOqA9PVe3/AD0v+QFTXAC9cOVJs73x
         89+fudOwtgE7g==
Date:   Tue, 4 Jul 2023 17:14:03 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Hanks Chen <hanks.chen@mediatek.com>,
        Cheng-Yuh.Wu@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Message-ID: <ZKQ3O5yL7WuRga0N@lpieralisi>
References: <20230704123436.127449-1-lpieralisi@kernel.org>
 <86ttujwxb1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ttujwxb1.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 03:44:50PM +0100, Marc Zyngier wrote:
> Lorenzo,
> 
> On Tue, 04 Jul 2023 13:34:36 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > GIC700 erratum 2941627 may cause GIC-700 missing SPIs wake
> > requests when SPIs are deactivated while targeting a
> > sleeping CPU - ie a CPU for which the redistributor:
> > 
> > GICR_WAKER.ProcessorSleep == 1
> > 
> > This runtime situation can happen if an SPI that has been
> > activated on a core is retargeted to a different core, it
> > becomes pending and the target core subsequently enters a
> > power state quiescing the respective redistributor.
> > 
> > When this situation is hit, the de-activation carried out
> > on the core that activated the SPI (through either ICC_EOIR1_EL1
> > or ICC_DIR_EL1 register writes) does not trigger a wake
> > requests for the sleeping GIC redistributor even if the SPI
> > is pending.
> > 
> > Fix the erratum by de-activating the SPI using the
> 
> s/Fix/ Work around/
> 
> > redistributor GICD_ICACTIVER register if the runtime
> > conditions require it (ie the IRQ was retargeted between
> > activation and de-activation).
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  Documentation/arm64/silicon-errata.rst |  3 ++
> >  drivers/irqchip/irq-gic-v3.c           | 71 +++++++++++++++++++++++++-
> >  2 files changed, 73 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> > index 9e311bc43e05..e77c57a0adf8 100644
> > --- a/Documentation/arm64/silicon-errata.rst
> > +++ b/Documentation/arm64/silicon-errata.rst
> > @@ -141,6 +141,9 @@ stable kernels.
> >  | ARM            | MMU-500         | #841119,826419  | N/A                         |
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  +----------------+-----------------+-----------------+-----------------------------+
> > +| ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
> > ++----------------+-----------------+-----------------+-----------------------------+
> > ++----------------+-----------------+-----------------+-----------------------------+
> >  | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
> >  +----------------+-----------------+-----------------+-----------------------------+
> >  | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index a605aa79435a..a0a9ccf23742 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -68,6 +68,8 @@ struct gic_chip_data {
> >  static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
> >  static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
> >  
> > +static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
> > +
> >  static struct gic_chip_data gic_data __read_mostly;
> >  static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
> >  
> > @@ -591,10 +593,35 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
> >  	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> >  }
> >  
> > +static bool gic_arm64_erratum_2941627_needed(struct irq_data *d)
> > +{
> > +	if (!static_branch_unlikely(&gic_arm64_2941627_erratum))
> > +		return false;
> > +
> > +	/*
> > +	 * The workaround is needed if the IRQ is an SPI and
> > +	 * the target cpu is different from the one we are
> > +	 * executing on.
> > +	 */
> > +	return !((gic_irq_in_rdist(d)) || gic_irq(d) >= 8192 ||
> > +		  cpumask_equal(irq_data_get_effective_affinity_mask(d),
> > +				cpumask_of(smp_processor_id())));
> 
> I dislike this statement for multiple reasons:
> 
> - it is written as a negation, making it harder than strictly
>   necessary to parse as it is the opposite of the comment above

Yes, I agree.

> - gic_irq_in_rdist() and gic_irq(d) >= 8192 are two ways of checking
>   the interrupt range -- maybe we should just do that
> 
> - cpumask_equal() is *slow* if you have more that 64 CPUs, something
>   that is increasingly common -- a better option would be to check
>   whether the current CPU is in the mask or not, which would be enough
>   as we only have a single affinity bit set
> 
> - smp_processor_id() can check for preemption, which is pointless
>   here, as we're doing things under the irq_desc raw spinlock.

These are valid points and there is no reason why this should not be
rewritten as you suggest below.

> I would expect something like:
> 
> 	enum gic_intid_range range = get_intid_range(d);
> 
> 	return (range == SGI_RANGE || range == ESPI_RANGE) &&
> 	       !cpumask_test_cpu(raw_smp_processor_id(),
> 				 irq_data_get_effective_affinity_mask(d));

It should work (and it is easier to read in the process), thanks.

> > +}
> > +
> >  static void gic_eoi_irq(struct irq_data *d)
> >  {
> >  	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
> >  	isb();
> > +
> > +	if (gic_arm64_erratum_2941627_needed(d)) {
> > +		/*
> > +		 * Make sure the GIC stream deactivate packet
> > +		 * issued by ICC_EOIR1_EL1 has completed before
> > +		 * deactivating through GICD_IACTIVER.
> > +		 */
> > +		dsb(sy);
> > +		gic_poke_irq(d, GICD_ICACTIVER);
> > +	}
> >  }
> >  
> >  static void gic_eoimode1_eoi_irq(struct irq_data *d)
> > @@ -605,7 +632,11 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
> >  	 */
> >  	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
> >  		return;
> > -	gic_write_dir(gic_irq(d));
> > +
> > +	if (!gic_arm64_erratum_2941627_needed(d))
> > +		gic_write_dir(gic_irq(d));
> > +	else
> > +		gic_poke_irq(d, GICD_ICACTIVER);
> >  }
> >  
> >  static int gic_set_type(struct irq_data *d, unsigned int type)
> > @@ -1796,6 +1827,25 @@ static bool gic_enable_quirk_nvidia_t241(void *data)
> >  	return true;
> >  }
> >  
> > +static bool gic_enable_quirk_arm64_2941627(void *data)
> > +{
> > +	/*
> > +	 * If CPUidle is not enabled the erratum runtime
> > +	 * conditions can't be hit, since that requires:
> > +	 *
> > +	 * - A core entering a deep power state with
> > +	 *   the associated GIC redistributor asleep
> > +	 *   and an IRQ active and pending targeted at it
> > +	 * - A different core handling the IRQ and
> > +	 *   related GIC operations at the same time
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_CPU_IDLE))
> > +		return false;
> 
> Could this still hit on a system that traps WFI to EL3 and uses this
> as a way to enter a low-power mode?

That's a valid point, I have not thought about that. If there are set-ups
where this is allowed (and I think it *is* architecturally allowed with
EL3 saving/restoring context and entering a deep power state - if you
asked I suspect you have something concrete in mind :)) this "optimization"
must be removed since we can still hit the bug; that's what I shall do
for v2.

Thanks,
Lorenzo
