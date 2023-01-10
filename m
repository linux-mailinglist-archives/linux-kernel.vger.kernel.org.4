Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D0663A21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjAJHp3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 02:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjAJHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:45:24 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFE17595;
        Mon,  9 Jan 2023 23:45:22 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8E3BE24E2EE;
        Tue, 10 Jan 2023 15:45:21 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 15:45:18 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 15:45:18 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 15:45:18 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Topic: [PATCH v3 2/3] hwrng: starfive - Add TRNG driver for StarFive
 SoC
Thread-Index: AQHZJEs120dGRuhRZEeUeBz460sZNq6WvwSAgACGdNA=
Date:   Tue, 10 Jan 2023 07:45:17 +0000
Message-ID: <3f7e4e82d42d4c1791afa346f8b62870@EXMBX168.cuchost.com>
References: <20230109165249.110279-1-jiajie.ho@starfivetech.com>
 <20230109165249.110279-3-jiajie.ho@starfivetech.com>
 <Y70WgbySlio6cjew@gondor.apana.org.au>
In-Reply-To: <Y70WgbySlio6cjew@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.190.108.220]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: 10 January, 2023 3:41 PM
> To: JiaJie Ho <jiajie.ho@starfivetech.com>
> Cc: Olivia Mackall <olivia@selenic.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Emil Renner
> Berthing <kernel@esmil.dk>; Conor Dooley <conor.dooley@microchip.com>;
> linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v3 2/3] hwrng: starfive - Add TRNG driver for StarFive
> SoC
> 
> On Tue, Jan 10, 2023 at 12:52:48AM +0800, Jia Jie Ho wrote:
> >
> > +static irqreturn_t starfive_trng_irq(int irq, void *priv) {
> > +	u32 status;
> > +	struct starfive_trng *trng = (struct starfive_trng *)priv;
> > +
> > +	status = readl(trng->base + STARFIVE_ISTAT);
> > +	if (status & STARFIVE_ISTAT_RAND_RDY) {
> > +		writel(STARFIVE_ISTAT_RAND_RDY, trng->base +
> STARFIVE_ISTAT);
> > +		complete(&trng->random_done);
> > +	}
> > +
> > +	if (status & STARFIVE_ISTAT_SEED_DONE) {
> > +		writel(STARFIVE_ISTAT_SEED_DONE, trng->base +
> STARFIVE_ISTAT);
> > +		complete(&trng->reseed_done);
> > +	}
> > +
> > +	if (status & STARFIVE_ISTAT_LFSR_LOCKUP) {
> > +		writel(STARFIVE_ISTAT_LFSR_LOCKUP, trng->base +
> STARFIVE_ISTAT);
> > +		/* SEU occurred, reseeding required*/
> > +		writel(STARFIVE_CTRL_EXEC_RANDRESEED, trng->base +
> STARFIVE_CTRL);
> 
> This could occur at the same time as a GENE_RANDNUM write so perhaps
> you should add some locking?
> 

I'll add those in the next version.

> > +	ret = devm_request_irq(&pdev->dev, irq, starfive_trng_irq, 0, pdev-
> >name,
> > +			       (void *)trng);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, irq,
> > +				     "Failed to register interrupt handler\n");
> 
> ...
> 
> > +	init_completion(&trng->random_done);
> > +	init_completion(&trng->reseed_done);
> 
> These completion initialisations should be moved above the IRQ registration
> because you should always be prepared to get spurious interrupts.
> 

Will update these too.

> Otherwise the patch looks good.
> 

Thanks again for reviewing the patch and providing the useful feedbacks.

Best regards,
Jia Jie
