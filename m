Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC16FECAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbjEKHXY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 03:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbjEKHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:23:02 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA11A2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:22:34 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1px0d2-000aVW-T1; Thu, 11 May 2023 09:22:20 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1px0d2-003MJK-M2; Thu, 11 May 2023 09:22:20 +0200
Message-ID: <3c76bea5e45a5ae9ea58b3ff87f9971955a3a021.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] irqchip/jcore-aic: Fix missing allocation of IRQ
 descriptors
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Date:   Thu, 11 May 2023 09:22:20 +0200
In-Reply-To: <479a18513b9d8c6e8ccb96093a0f0dd7@kernel.org>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
         <479a18513b9d8c6e8ccb96093a0f0dd7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.220
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason!

On Thu, 2023-05-11 at 07:56 +0100, Marc Zyngier wrote:
> On 2023-05-10 17:33, John Paul Adrian Glaubitz wrote:
> > The initialization function for the J-Core AIC aic_irq_of_init() is
> > currently missing the call to irq_alloc_descs() which allocates and
> > initializes all the IRQ descriptors. Add missing function call and
> > return the error code from irq_alloc_descs() in case the allocation
> > fails.
> > 
> > Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > ---
> >  drivers/irqchip/irq-jcore-aic.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-jcore-aic.c 
> > b/drivers/irqchip/irq-jcore-aic.c
> > index 5f47d8ee4ae3..b9dcc8e78c75 100644
> > --- a/drivers/irqchip/irq-jcore-aic.c
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node 
> > *node,
> >  	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> >  	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> >  	struct irq_domain *domain;
> > +	int ret;
> > 
> >  	pr_info("Initializing J-Core AIC\n");
> > 
> > @@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct 
> > device_node *node,
> >  	jcore_aic.irq_unmask = noop;
> >  	jcore_aic.name = "AIC";
> > 
> > +	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
> > +			      of_node_to_nid(node));
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, 
> > min_irq,
> >  				       &jcore_aic_irqdomain_ops,
> >  				       &jcore_aic);
> 
> [- Jason]
> 
> It really begs the question: how has it ever been working before?

Users already used a locally patched kernel to work around this problem.

> Is there any plan to modernise the port and get it to allocate
> irq_descs on demand, as we do on most architectures?

Yes, there are plans to modernize the port. We're first working on upstreaming
all kinds of patches that have been queuing up over the time.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
