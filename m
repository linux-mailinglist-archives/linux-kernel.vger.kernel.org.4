Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD2637280
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKXGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:46:26 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C19EE2A;
        Wed, 23 Nov 2022 22:46:23 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AO6kEAC006669;
        Thu, 24 Nov 2022 00:46:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669272374;
        bh=k8oQc928q/IqwtNyVn+bggppZAISVnv0DtJUajNDPD0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cCv0OazLFQW/Qh11HgvlAggM1vs1wrtQE+sF7RWxZMMJ9DM9UNmBeKn0lFNWt01oo
         k5qeIygjvuRfR+7QV6IUqpMU5aBr/y0lp3bPiNWfgDemFBf9ukfBN7vBOGXp83rvA+
         YSogSwJI1owyXPqu5z22PVsfvv1wJbpUwrSegww4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AO6kEqh079461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Nov 2022 00:46:14 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 24
 Nov 2022 00:46:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 24 Nov 2022 00:46:13 -0600
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AO6kB47119711;
        Thu, 24 Nov 2022 00:46:12 -0600
Message-ID: <9e5264fa-db1a-ed96-5fd8-cbfa4694b8bd@ti.com>
Date:   Thu, 24 Nov 2022 12:16:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Content-Language: en-US
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
CC:     <greg.malysa@timesys.com>, Mark Brown <broonie@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221123211705.126900-1-nathan.morrison@timesys.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20221123211705.126900-1-nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,
Thanks for your contribution.
However, there are a few issues that I would like you to address.

On 24/11/22 02:47, Nathan Barrett-Morrison wrote:
> While bringing up the cadence-quadspi driver on a customer board,
> I discovered that the baud divisor calculation can exceed the
> peripheral's maximum in some circumstances.  This will prevent it.
What is the peripheral's maximum? Is the peripheral a flash?
Please define what you mean by "some circumstances".

> 
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>   drivers/spi/spi-cadence-quadspi.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 447230547945..250575fb7b0e 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1119,6 +1119,10 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
>   	/* Recalculate the baudrate divisor based on QSPI specification. */
>   	div = DIV_ROUND_UP(ref_clk_hz, 2 * cqspi->sclk) - 1;
>   
> +	/* Maximum baud divisor */
> +	if (div > CQSPI_REG_CONFIG_BAUD_MASK)

I don't think comparing "greater than" with a MASK is atall a good idea.

> +		div = CQSPI_REG_CONFIG_BAUD_MASK;
I would not encourage this either.


> +
>   	reg = readl(reg_base + CQSPI_REG_CONFIG);
>   	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
>   	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;

Either come up with a better MACRO, or if what I understand
is correct, the peripheral's max value will depend, well
on the _peripheral_ in which case it is that "peripheral" driver's
responsibility to properly tell the controller what to do.


Again, I don't fully understand your situation is as in
what is the peripheral you are using. So please elaborate on that.

Importantly, I would suggest that you _NEVER_ compare ANY value to a
MASK Macro. MASK Macros are meant to MASK bits.



-- 
Thanks and Regards,
Dhruva Gole
