Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0200E6615C1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjAHONR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 Jan 2023 09:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjAHONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:13:14 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D475DFBA;
        Sun,  8 Jan 2023 06:13:09 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E0DCB24DC94;
        Sun,  8 Jan 2023 22:13:05 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 8 Jan
 2023 22:13:05 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Sun, 8 Jan 2023 22:13:05 +0800
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
Subject: RE: [PATCH v2 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Thread-Topic: [PATCH v2 2/3] hwrng: starfive - Add TRNG driver for StarFive
 SoC
Thread-Index: AQHZGoveBWEVWeSp5UqGtlmGFQKs8K6QmY4AgAQHL+A=
Date:   Sun, 8 Jan 2023 14:13:05 +0000
Message-ID: <75798088d1cd41dd94dafe67179761d9@EXMBX168.cuchost.com>
References: <20221228071103.91797-1-jiajie.ho@starfivetech.com>
 <20221228071103.91797-3-jiajie.ho@starfivetech.com>
 <Y7fePDme5E3yhPhQ@gondor.apana.org.au>
In-Reply-To: <Y7fePDme5E3yhPhQ@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.6.8]
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
> Sent: 6 January, 2023 4:39 PM
> To: JiaJie Ho <jiajie.ho@starfivetech.com>
> Cc: Olivia Mackall <olivia@selenic.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Emil Renner
> Berthing <kernel@esmil.dk>; Conor Dooley <conor.dooley@microchip.com>;
> linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v2 2/3] hwrng: starfive - Add TRNG driver for StarFive
> SoC
> 
> On Wed, Dec 28, 2022 at 03:11:02PM +0800, Jia Jie Ho wrote:
> >
> > +static int starfive_trng_cmd(struct starfive_trng *trng, u32 cmd) {
> > +	int ret;
> > +
> > +	ret = starfive_trng_wait_idle(trng);
> > +	if (ret)
> > +		return -ETIMEDOUT;
> > +
> > +	switch (cmd) {
> > +	case STARFIVE_CTRL_EXEC_NOP:
> > +		writel(cmd, trng->base + STARFIVE_CTRL);
> > +		break;
> > +	case STARFIVE_CTRL_GENE_RANDNUM:
> > +		reinit_completion(&trng->random_done);
> > +		writel(cmd, trng->base + STARFIVE_CTRL);
> > +		ret = wait_for_completion_timeout(&trng->random_done,
> 3000);
> 
> Please don't use a constant jiffies value, because it may vary in length.
> Instead use a constant millisecond value and convert it to jiffies.
> 

I'll fix this in next version.

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
> > +		starfive_trng_cmd(trng,
> STARFIVE_CTRL_EXEC_RANDRESEED);
> 
> You should not sleep in an IRQ handler.
> 

Will fix this too.

> > +static int starfive_trng_read(struct hwrng *rng, void *buf, size_t
> > +max, bool wait)
> 
> You should respect the wait argument and not do polling/sleeping if it is false.

I'll add this in the next version.

Thanks for reviewing this patch.

Best regards,
Jia Jie
