Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E9744D2A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGBKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:04:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA789E54;
        Sun,  2 Jul 2023 03:04:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv4MR54xHz6D9BC;
        Sun,  2 Jul 2023 18:01:23 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:04:13 +0100
Date:   Sun, 2 Jul 2023 18:04:09 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kim Seer Paller <kimseer.paller@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <Michael.Hennerich@analog.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] iio: adc: max14001: New driver
Message-ID: <20230702180315.00003dbe@Huawei.com>
In-Reply-To: <20230622143227.30147-2-kimseer.paller@analog.com>
References: <20230622143227.30147-1-kimseer.paller@analog.com>
        <20230622143227.30147-2-kimseer.paller@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 22:32:27 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306211545.7b6CdqsL-lkp@intel.com/

Hi, 

Two outstanding comments that I think I raised in earlier reviews..

Jonathan

> diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> new file mode 100644
> index 000000000000..a21ebcde71fa
> --- /dev/null
> +++ b/drivers/iio/adc/max14001.c

...

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
> +	/*
> +	 * Convert transmit buffer to big-endian format and reverse transmit
> +	 * buffer to align with the LSB-first input on SDI port.
> +	 */
> +	st->spi_tx_buffer = cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK,
> +								reg_addr)));
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Align received data from the receive buffer, reversing and reordering
> +	 * it to match the expected MSB-first format.
> +	 */
> +	*data = (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffer))) &
> +							MAX14001_DATA_MASK;
> +
These sequences still confuse me a lot because I'd expect the values in tx
to have the opposite operations applied to those for rx and that's not the
case.

Let's take a le system. 
tx = cpu_to_be16(bitrev16(x))
   = cpu_to_be16((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8));
   = __bitrev8(x & 0xff) | (__bitrev8(x >> 8) << 8)
or swap all the bits in each byte, but don't swap the bytes.

rx = cpu_to_be16(bitrev16(x))
   = be16_to_cpu(((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)_
   = __bitrev8(x & 0xff) | __bitrev(x >> 8)
   
also swap all the bits in each byte, but don't swap the bytes.

So it is the reverse because the bytes swaps unwind themselves somewhat.
For a be system cpu_to_be16 etc are noop.
tx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
rx = (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)

So in this case swap all 16 bits.

Now, given I'd expected them to be reversed for the tx vs rx case.
E.g.
tx = cpu_to_be16(bitrev16(x))
As above.
For rx, le host
rx = bitrev16(be16_to_cpu(x))
   = __bitrev8((x >> 8) & 0xff) << 8) |  __bitrev8((((x & 0xff) << 8) >> 8)
same as above (if you swap the two terms I think.

For be the be16_to_cpu is a noop again, so it's just bitrev16(x) as expected.

Hence if I've understood this correctly you could reverse the terms so that
it was 'obvious' you were doing the opposite for the tx term vs the rx one
without making the slightest bit of difference....
   
hmm. Might be worth doing simply to avoid questions.


> +	return 0;
> +}
> +static int max14001_reg_update(struct max14001_state *st,
> +				unsigned int reg_addr,
> +				unsigned int mask,
> +				unsigned int val)
> +{
> +	int ret;
> +	unsigned int reg_data;
> +
> +	/* Enable SPI Registers Write */
> +	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> +	if (ret)
> +		return ret;
> +
> +	ret = max14001_read(st, reg_addr, &reg_data);
> +	if (ret)
> +		return ret;
> +
> +	reg_data |= FIELD_PREP(mask, val);

This is still a problem if the compiler happens to fail to figure out
that mask is a compile time constant.  Given it only ever takes one value
I'd suggest either calling the FIELD_PREP at the caller, or just 
pushing all this code inline so that you can put the definition
inline.

> +
> +	ret = max14001_write(st, reg_addr, reg_data);
> +	if (ret)
> +		return ret;
> +
> +	/* Write Verification Register */
> +	ret = max14001_write_verification_reg(st, reg_addr);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable SPI Registers Write */
> +	return max14001_write(st, MAX14001_WEN, 0);
> +}


