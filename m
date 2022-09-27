Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1A5EC733
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiI0PFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiI0PFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:05:15 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0967169
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:05:12 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1odC8z-00CKej-Rp
        for linux-kernel@vger.kernel.org; Tue, 27 Sep 2022 17:05:09 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from [2a01:4f8:10a:f402::1:2]
        by yawp.biot.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1odC8c-00CKd0-AK; Tue, 27 Sep 2022 17:04:46 +0200
Message-ID: <64b7e467-485a-91db-82fb-3204f8ccf877@biot.com>
Date:   Tue, 27 Sep 2022 17:04:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] spi: Add support for the Airoha EN7523 SoC SPI
 controller
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
References: <20220927113229.1214224-1-bert@biot.com>
 <20220927113229.1214224-3-bert@biot.com> <YzLrMHVU3mTJVVh6@sirena.org.uk>
From:   Bert Vermeulen <bert@biot.com>
In-Reply-To: <YzLrMHVU3mTJVVh6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 14:23, Mark Brown wrote:

Hi Mark,

Thanks for reviewing.

> On Tue, Sep 27, 2022 at 01:32:28PM +0200, Bert Vermeulen wrote:
> 
>>  
>> +config SPI_AIROHA_EN7523
>> +	bool "Airoha EN7523 SPI controller support"
> 
> Why not tristate?
> 
>> +	depends on ARCH_AIROHA
> 
> I don't see a reason we couldn't have an || COMPILE_TEST here to improve
> coverage?
> 
>> +	default ARCH_AIROHA

In both cases, because SPi boot flash is the only way to boot this SoC 
that I know of. However as you say this may not be the case on different 
SoCs, and indeed I believe this SPI core is in lots of stuff already.

So I'll fix this, and also address your other comments.

> It's unusual to default a SPI controller on, they tend not to be ultra
> critical like a clock driver or similar can be?
> 
>> +static void __iomem *iobase;
> 
> This should be driver data rather than a global, your current SoC might
> only have one controller but some other model might build two and it's
> fairly trivial to do.
> 
>> +static void opfifo_write(u32 cmd, u32 len)
>> +{
>> +	u32 tmp = ((cmd & 0x1f) << 9) | (len & 0x1ff);
>> +
>> +	writel(tmp, REG(ENSPI_MANUAL_OPFIFO_WDATA));
>> +
>> +	/* Wait for room in OPFIFO */
>> +	while (readl(REG(ENSPI_MANUAL_OPFIFO_FULL)))
>> +		cpu_relax();
>> +
> 
> Some sort of timeout would be good with these loops, if things go wrong
> we'll just lock up which isn't good.
> 
>> +       ret = clk_prepare_enable(clk);
>> +       if (ret)
>> +               return ret;
> 
> Nothing ever reverses this unless clk_set_rate() fails.
> 
>> +	ret = clk_set_rate(clk, 40000000);
>> +	if (ret) {
>> +		clk_disable_unprepare(clk);
>> +		return ret;
>> +	}
> 
> Could this be pushed into DT via the clock bindings?  The hard coded
> number might need to vary by SoC.
> 
>> +static int xfer_read(struct spi_transfer *xfer)
>> +{
>> +	int opcode;
>> +	uint8_t *buf = xfer->rx_buf;
>> +
>> +	switch (xfer->rx_nbits) {
>> +	case SPI_NBITS_SINGLE:
>> +		opcode = OP_INS;
>> +		break;
>> +	case SPI_NBITS_DUAL:
>> +		opcode = OP_IND;
>> +		break;
>> +	}
> 
> This should have a default case that returns an error.
> 
>> +static int transfer_one_message(struct spi_controller *ctrl, struct spi_message *msg)
>> +{
>> +	struct spi_transfer *xfer;
>> +	int next_xfer_is_rx = 0;
>> +
>> +	manual_begin_cmd();
>> +	set_cs(0);
> 
> The driver should not be setting chip select itself, it should just
> provide the set_cs() operation to the core and let the core worry about
> when to call it.
> 
>> +	ctrl->transfer_one_message = transfer_one_message;
>> +	err = devm_spi_register_controller(&pdev->dev, ctrl);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Could not register SPI controller\n");
>> +		return -ENODEV;
>> +	}
> 
> Don't discard the error code that registeration returned, include it in
> the log message and pass it back to the caller.


-- 
Bert Vermeulen
bert@biot.com
