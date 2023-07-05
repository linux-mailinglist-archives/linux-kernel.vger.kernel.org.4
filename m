Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182FD748257
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjGEKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGEKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:41:41 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0C123
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:41:40 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 84d40c27-1b20-11ee-abf4-005056bdd08f;
        Wed, 05 Jul 2023 13:41:38 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 5 Jul 2023 13:41:37 +0300
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
Message-ID: <ZKVI4XPbPXfzQa9J@surfacebook>
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com>
 <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 22, 2023 at 12:33:39PM +0100, Fabrizio Castro kirjoitti:
> The RZ/V2M SoC comes with the Clocked Serial Interface (CSI)
> IP, which is a master/slave SPI controller.
> 
> This commit adds a driver to support CSI master mode.

Submitting Patches recommends to use imperative voice.

...

+ bits.h

> +#include <linux/clk.h>
> +#include <linux/count_zeros.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>

...

> +#define CSI_CKS_MAX		0x3FFF

If it's limited by number of bits, i would explicitly use that information as
(BIT(14) - 1).

...

> +#define CSI_MAX_SPI_SCKO	8000000

Units?
Also, HZ_PER_MHZ?

...

> +static const unsigned char x_trg[] = {
> +	0, 1, 1, 2, 2, 2, 2, 3,
> +	3, 3, 3, 3, 3, 3, 3, 4,
> +	4, 4, 4, 4, 4, 4, 4, 4,
> +	4, 4, 4, 4, 4, 4, 4, 5
> +};
> +
> +static const unsigned char x_trg_words[] = {
> +	1,  2,  2,  4,  4,  4,  4,  8,
> +	8,  8,  8,  8,  8,  8,  8,  16,
> +	16, 16, 16, 16, 16, 16, 16, 16,
> +	16, 16, 16, 16, 16, 16, 16, 32
> +};

Why do you need tables? At the first glance these values can be easily
calculated from indexes.

...

> +	rzv2m_csi_reg_write_bit(csi, CSI_CNT, CSI_CNT_CSIRST, assert);
> +
> +	if (assert) {

	If (!assert)
		return 0;

> +		return readl_poll_timeout(csi->base + CSI_MODE, reg,
> +					  !(reg & CSI_MODE_CSOT), 0,
> +					  CSI_EN_DIS_TIMEOUT_US);
> +	}
> +
> +	return 0;

...

> +	rzv2m_csi_reg_write_bit(csi, CSI_MODE, CSI_MODE_CSIE, enable);
> +
> +	if (!enable && wait)

In the similar way.

> +		return readl_poll_timeout(csi->base + CSI_MODE, reg,
> +					  !(reg & CSI_MODE_CSOT), 0,
> +					  CSI_EN_DIS_TIMEOUT_US);
> +
> +	return 0;

...

> +		for (i = 0; i < csi->words_to_transfer; i++)
> +			writel(buf[i], csi->base + CSI_OFIFO);

writesl()?

...

> +		for (i = 0; i < csi->words_to_transfer; i++)
> +			buf[i] = (u16)readl(csi->base + CSI_IFIFO);

readsl()?

...

> +		for (i = 0; i < csi->words_to_transfer; i++)
> +			buf[i] = (u8)readl(csi->base + CSI_IFIFO);

readsl()?

...

Yes, in read cases you would need carefully handle the buffer data.
Or drop the idea if it looks too monsterous.

...

> +	ret = rzv2m_csi_wait_for_interrupt(csi, CSI_INT_TREND, CSI_CNT_TREND_E);

> +

Unneeded blank line.

> +	if (ret == -ETIMEDOUT)
> +		csi->errors |= TX_TIMEOUT_ERROR;

...

> +	struct rzv2m_csi_priv *csi = (struct rzv2m_csi_priv *)data;

From/to void * does not need an explicit casting in C.

...

> +	/* Setup clock polarity and phase timing */
> +	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
> +				!(spi->mode & SPI_CPOL));
> +	rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
> +				!(spi->mode & SPI_CPHA));

Is it a must to do in a sequential writes?

...

> +	bool tx_completed = csi->txbuf ? false : true;
> +	bool rx_completed = csi->rxbuf ? false : true;

Ternaries are redundant in the above.

...

> +	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;

SPI_MODE_X_MASK

...

> +	controller->dev.of_node = pdev->dev.of_node;

device_set_node();

-- 
With Best Regards,
Andy Shevchenko


