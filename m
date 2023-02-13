Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE216951B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjBMUR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjBMURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:17:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563022035
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3FC5B8190B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 20:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F11C4339C;
        Mon, 13 Feb 2023 20:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676319438;
        bh=+ov1IKoCTOaJSuscjijW4FneyMOAtU2ocacidL8uLO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPZqmvffbWatcePstvpSuvWBpKutSLY0XVmjxuNZJe02BL4L9Pn0cm/lA4Nzb3BW+
         3Pl0sKhpgfPfj8SzouF/F3eN93k69UnQId0rHT420HItVyuY1SJYJpiUITtc//q+Yj
         9WUH7QTC7lVB+d7B2XH+jlvjswLqpP7AEi7YGSmYkpeMEPS1Dt5fWMuFQyi4ZVO/Uf
         Cu9WSvpk81emKbYzaBoMO0dkDPv7kJZ63Gb+yBZsOuS8HLs7sm1Vp7ZH8WEoEoVhfu
         1is5S1K7oNwUgaVB1ZKN/74FQhQNZ+/tM96CTMlyv4kjqVZkDnT57arizFZxy3czo2
         dgBLbA5oS5IUA==
Received: by pali.im (Postfix)
        id E7EA8687; Mon, 13 Feb 2023 21:17:15 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:17:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] powerpc/85xx: p2020: Move i8259 code into own
 function
Message-ID: <20230213201715.at64fowda2xgertt@pali>
References: <20221224211425.14983-1-pali@kernel.org>
 <20221224211425.14983-5-pali@kernel.org>
 <0953ffd2-dddc-2706-66ab-d6913eff19df@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0953ffd2-dddc-2706-66ab-d6913eff19df@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2023 20:06:27 Christophe Leroy wrote:
> 
> 
> Le 24/12/2022 à 22:14, Pali Rohár a écrit :
> > Splits mpic and i8259 initialization codes into separate functions.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >   arch/powerpc/platforms/85xx/p2020.c | 37 ++++++++++++++++-------------
> >   1 file changed, 21 insertions(+), 16 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
> > index d65d4c88ac47..b8584bf307b0 100644
> > --- a/arch/powerpc/platforms/85xx/p2020.c
> > +++ b/arch/powerpc/platforms/85xx/p2020.c
> > @@ -45,6 +45,7 @@
> >   #ifdef CONFIG_MPC85xx_DS
> >   
> >   #ifdef CONFIG_PPC_I8259
> > +
> >   static void mpc85xx_8259_cascade(struct irq_desc *desc)
> >   {
> >   	struct irq_chip *chip = irq_desc_get_chip(desc);
> > @@ -55,27 +56,13 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
> >   	}
> >   	chip->irq_eoi(&desc->irq_data);
> >   }
> > -#endif	/* CONFIG_PPC_I8259 */
> >   
> > -static void __init mpc85xx_ds_pic_init(void)
> > +static void __init mpc85xx_8259_init(void)
> >   {
> > -	struct mpic *mpic;
> > -#ifdef CONFIG_PPC_I8259
> >   	struct device_node *np;
> >   	struct device_node *cascade_node = NULL;
> >   	int cascade_irq;
> > -#endif
> > -
> > -	mpic = mpic_alloc(NULL, 0,
> > -		  MPIC_BIG_ENDIAN |
> > -		  MPIC_SINGLE_DEST_CPU,
> > -		0, 256, " OpenPIC  ");
> > -
> > -	BUG_ON(mpic == NULL);
> > -	mpic_init(mpic);
> >   
> > -#ifdef CONFIG_PPC_I8259
> > -	/* Initialize the i8259 controller */
> >   	for_each_node_by_type(np, "interrupt-controller")
> >   	    if (of_device_is_compatible(np, "chrp,iic")) {
> >   		cascade_node = np;
> > @@ -93,13 +80,31 @@ static void __init mpc85xx_ds_pic_init(void)
> >   		return;
> >   	}
> >   
> > -	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
> > +	DBG("i8259: cascade mapped to irq %d\n", cascade_irq);
> >   
> >   	i8259_init(cascade_node, 0);
> >   	of_node_put(cascade_node);
> >   
> >   	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
> > +}
> > +
> >   #endif	/* CONFIG_PPC_I8259 */
> > +
> > +static void __init mpc85xx_ds_pic_init(void)
> > +{
> > +	struct mpic *mpic;
> > +
> > +	mpic = mpic_alloc(NULL, 0,
> > +		  MPIC_BIG_ENDIAN |
> > +		  MPIC_SINGLE_DEST_CPU,
> > +		0, 256, " OpenPIC  ");
> > +
> > +	BUG_ON(mpic == NULL);
> > +	mpic_init(mpic);
> > +
> > +#ifdef CONFIG_PPC_I8259
> 
> Ca we minimise number of #ifdef CONFIG_PPC_I8259 by using 
> IS_ENABLED(CONFIG_PPC_I8259) inside if/else ?
> 
> > +	mpc85xx_8259_init();
> > +#endif

Ok, I can change code to:

+if (IS_ENABLED(CONFIG_PPC_I8259))
+    mpc85xx_8259_init();

I guess it should be equivalent.

> >   }
> >   
> >   #ifdef CONFIG_PCI
