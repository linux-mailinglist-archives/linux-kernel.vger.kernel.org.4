Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8965FCEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjAFIkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAFIjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:39:51 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F7F30;
        Fri,  6 Jan 2023 00:39:49 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDiG4-00EV7i-2e; Fri, 06 Jan 2023 16:39:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Jan 2023 16:39:24 +0800
Date:   Fri, 6 Jan 2023 16:39:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] hwrng: starfive - Add TRNG driver for StarFive SoC
Message-ID: <Y7fePDme5E3yhPhQ@gondor.apana.org.au>
References: <20221228071103.91797-1-jiajie.ho@starfivetech.com>
 <20221228071103.91797-3-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228071103.91797-3-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:11:02PM +0800, Jia Jie Ho wrote:
>
> +static int starfive_trng_cmd(struct starfive_trng *trng, u32 cmd)
> +{
> +	int ret;
> +
> +	ret = starfive_trng_wait_idle(trng);
> +	if (ret)
> +		return -ETIMEDOUT;
> +
> +	switch (cmd) {
> +	case STARFIVE_CTRL_EXEC_NOP:
> +		writel(cmd, trng->base + STARFIVE_CTRL);
> +		break;
> +	case STARFIVE_CTRL_GENE_RANDNUM:
> +		reinit_completion(&trng->random_done);
> +		writel(cmd, trng->base + STARFIVE_CTRL);
> +		ret = wait_for_completion_timeout(&trng->random_done, 3000);

Please don't use a constant jiffies value, because it may vary
in length.  Instead use a constant millisecond value and convert
it to jiffies.

> +static irqreturn_t starfive_trng_irq(int irq, void *priv)
> +{
> +	u32 status;
> +	struct starfive_trng *trng = (struct starfive_trng *)priv;
> +
> +	status = readl(trng->base + STARFIVE_ISTAT);
> +	if (status & STARFIVE_ISTAT_RAND_RDY) {
> +		writel(STARFIVE_ISTAT_RAND_RDY, trng->base + STARFIVE_ISTAT);
> +		complete(&trng->random_done);
> +	}
> +
> +	if (status & STARFIVE_ISTAT_SEED_DONE) {
> +		writel(STARFIVE_ISTAT_SEED_DONE, trng->base + STARFIVE_ISTAT);
> +		complete(&trng->reseed_done);
> +	}
> +
> +	if (status & STARFIVE_ISTAT_LFSR_LOCKUP) {
> +		writel(STARFIVE_ISTAT_LFSR_LOCKUP, trng->base + STARFIVE_ISTAT);
> +		starfive_trng_cmd(trng, STARFIVE_CTRL_EXEC_RANDRESEED);

You should not sleep in an IRQ handler.

> +static int starfive_trng_read(struct hwrng *rng, void *buf, size_t max, bool wait)

You should respect the wait argument and not do polling/sleeping
if it is false.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
