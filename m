Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79505723426
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 02:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjFFAsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 20:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjFFAso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:48:44 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2B0102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 17:48:40 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id deb617af-0403-11ee-a9de-005056bdf889;
        Tue, 06 Jun 2023 03:48:36 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 6 Jun 2023 03:48:36 +0300
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: max14001: New driver
Message-ID: <ZH6CZJCBTXrsUErm@surfacebook>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
 <20230605130755.92642-3-kimseer.paller@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605130755.92642-3-kimseer.paller@analog.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jun 05, 2023 at 09:07:55PM +0800, Kim Seer Paller kirjoitti:
> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.

First question, why don't you use regmap SPI?

...

> +static int max14001_read(void *context, unsigned int reg_addr,
> +					unsigned int *data)

Strange indentation.

> +{
> +	struct max14001_state *st = context;
> +	u16 tx = 0;

Redundant assignment.

> +	int ret;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->spi_tx_buffer,
> +			.len = 2,
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->spi_rx_buffer,
> +			.len = 2,
> +		},
> +	};
> +
> +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);

> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));

This is strange. Why this monsteur construct with bitrev16() is used?

According to the datasheet, the bit stream is LE16, where 10 LSB is data,
5 MSB is address and bit 11 is R/W.

> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;

> +	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_DATA_MASK;

Ditto.

> +	return 0;
> +}

> +static int max14001_write(void *context, unsigned int reg_addr,
> +					unsigned int data)
> +{
> +	struct max14001_state *st = context;
> +	u16 tx = 0;

Redundant assignment.

> +	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
> +	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
> +	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
> +
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(tx));
> +
> +	return spi_write(st->spi, &st->spi_tx_buffer, 2);

sizeof() ?

> +}

...

> +			return dev_err_probe(&spi->dev, PTR_ERR(vref),
> +					     "Failed to get vref regulator");

With

	struct device *dev = &spi->dev;

this and other calls in this function can be made neater.

-- 
With Best Regards,
Andy Shevchenko


