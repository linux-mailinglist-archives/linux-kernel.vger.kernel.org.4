Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58273431C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbjFQSnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjFQSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:43:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749519A3;
        Sat, 17 Jun 2023 11:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D176068B;
        Sat, 17 Jun 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF395C433C8;
        Sat, 17 Jun 2023 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687027415;
        bh=LRULk4mes9NANweteBZ1y+o5E8Q624eGUCGdZJ3yDhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a7gZZLfwAnjG/hRsQeBlH62Js7tfOXFQmrzzQ/7FpkYyqY8dT//Wi7GqlFZ1PcunT
         RX7GCJGBbXvjpZR//XEnz25wH24d3rn5hoASU0hvFaT4dBVTk+FpDkJ8Q/8jaEsAVw
         eI9/I6rk9Zg4AZZAsMD9NcdUapzhNYBGgGA5k0Of8vDuOEkNRN/NsXPVfw47FhccyY
         AIyS8C8dUcxkyffEXPkhWb9tbmKkkSOHHLnxUmF4DQKSDeZjw2lYgKhC12TknO8X/3
         1Et5ltpFO8sw5wRS2mwEiZM02c5bGrvV64zvvKqHuQ2+XSrh46lrhVofZxOzUNwW/2
         YGBzx/O3QMNXw==
Date:   Sat, 17 Jun 2023 19:43:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <Michael.Hennerich@analog.com>, <andy.shevchenko@gmail.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: adc: max14001: New driver
Message-ID: <20230617194318.1a9b0e9c@jic23-huawei>
In-Reply-To: <20230614004857.134980-2-kimseer.paller@analog.com>
References: <20230614004857.134980-1-kimseer.paller@analog.com>
        <20230614004857.134980-2-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 08:48:57 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Build tests showed up a set of warnings we need to deal with.

Jonathan


> +
> +static int max14001_read(void *context, unsigned int reg_addr, unsigned int *data)
> +{
> +	struct max14001_state *st = context;
> +	int ret;
> +
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->spi_tx_buffer,
> +			.len = sizeof(st->spi_tx_buffer),
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->spi_rx_buffer,
> +			.len = sizeof(st->spi_rx_buffer),
> +		},
> +	};
> +
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_ADDR_MASK,
> +								reg_addr)));

This gives an endian warning with sparse.

drivers/iio/adc/max14001.c:81:29: warning: incorrect type in initializer (different base types)
drivers/iio/adc/max14001.c:81:29:    expected unsigned short [usertype] __x
drivers/iio/adc/max14001.c:81:29:    got restricted __be16 [usertype]
drivers/iio/adc/max14001.c:81:27: warning: incorrect type in assignment (different base types)
drivers/iio/adc/max14001.c:81:27:    expected restricted __be16 [usertype] spi_tx_buffer
drivers/iio/adc/max14001.c:81:27:    got int
drivers/iio/adc/max14001.c:97:29: warning: incorrect type in initializer (different base types)
drivers/iio/adc/max14001.c:97:29:    expected unsigned short [usertype] __x
drivers/iio/adc/max14001.c:97:29:    got restricted __be16 [usertype]
drivers/iio/adc/max14001.c:97:27: warning: incorrect type in assignment (different base types)
drivers/iio/adc/max14001.c:97:27:    expected restricted __be16 [usertype] spi_tx_buffer
drivers/iio/adc/max14001.c:97:27:    got int

Using a forced cast and adding a comment is probably fine to fix this...  Bit reversing
a big endian value is not going to be common enough to warrant anything clever.

> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_DATA_MASK;
But it got me looking.  Seems a bit odd that this isn't a direct reverse of what
is done on the tx bfufer.
e.g.
	be16_to_cpu(bitrev16(st->spi_rx_buffer))

I'm struggling to figure out enough of the datasheet to understand this.
Perhaps you could add some comments on the logic?


> +
> +	return 0;
> +}
> +
> +static int max14001_write(void *context, unsigned int reg_addr, unsigned int data)
> +{
> +	struct max14001_state *st = context;
> +
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(
> +			FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) |
> +			FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> +			FIELD_PREP(MAX14001_DATA_MASK, data)));
> +
> +	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
> +}
