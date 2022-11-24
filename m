Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC756378D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiKXM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKXM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:27:21 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C63E1231;
        Thu, 24 Nov 2022 04:27:18 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AOCRDTZ079477;
        Thu, 24 Nov 2022 06:27:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669292833;
        bh=SN3A480hLH9/xFyeEh4nC192XrVXgPw2SpoFbAmw7hI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IFnEQtg5tR7fdJKp0gqRGQ7KSZ60kpRoUrULs4W85K5/UNEsnEJ7d3FqeKS4dbxDF
         GwklJlet1VyK6c7LJfJeVPugAlhpAnaEw9OoalzsKY/SHvY0fHUDLW8qd2rH2dGzKt
         y3S3qgp1D85P/zRVzK3EWKlvgnX52aHpRw8zpGw0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AOCRDVa078716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Nov 2022 06:27:13 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 24
 Nov 2022 06:27:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 24 Nov 2022 06:27:12 -0600
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AOCRAd0023476;
        Thu, 24 Nov 2022 06:27:11 -0600
Message-ID: <88b6dab2-87b1-34ef-b267-43933d79ab8e@ti.com>
Date:   Thu, 24 Nov 2022 17:57:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        <greg.malysa@timesys.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221123211705.126900-1-nathan.morrison@timesys.com>
 <9e5264fa-db1a-ed96-5fd8-cbfa4694b8bd@ti.com>
 <Y39XFzYJL3EmxSFF@sirena.org.uk>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <Y39XFzYJL3EmxSFF@sirena.org.uk>
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

Hi Mark,
Thanks for your clarification.

On 24/11/22 17:05, Mark Brown wrote:
> On Thu, Nov 24, 2022 at 12:16:10PM +0530, Dhruva Gole wrote:
>> On 24/11/22 02:47, Nathan Barrett-Morrison wrote:
> 
>>> +	/* Maximum baud divisor */
>>> +	if (div > CQSPI_REG_CONFIG_BAUD_MASK)
> 
>> I don't think comparing "greater than" with a MASK is atall a good idea.
> 
> Why - it's checking that the calculated divisor can actually fit in the
> relevant register field which seems like a totally normal thing to do?
okay, it makes sense in the sense that it will cap the div rate to
0xF.

> 
>> Again, I don't fully understand your situation is as in
>> what is the peripheral you are using. So please elaborate on that.
> 
> As far as I can tell the issue here is that the device is asking for a
> rate which requires a larger divisor than the controller can support but
> the driver doesn't do any bounds checking so it just writes the
> calculated divisor out to the hardware, corrupting any adjacent fields.
but, I am not sure it would anyway corrupt any adjacent bits,

The code
reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB

does mask the div value to ensure bits ONLY in 
CQSPI_REG_CONFIG_BAUD_MASK region are set and nothing else right?
> 
> In this context the SPI controller is a peripheral within the SoC.
Ah okay, my understanding was that one would call a peripheral something
that is connected via a SPI Bus to the SPI controller.
> 
>> Importantly, I would suggest that you _NEVER_ compare ANY value to a
>> MASK Macro. MASK Macros are meant to MASK bits.
> 
> It's very common to also use masks to identify when values have
> overflowed the values that can be written to a field.
okay, this does make sense when the code doesn't mask the values before
modifying the registers.

However as I showed above, there is a masking done of div before setting 
the bits in the reg.

I agree there is the other justification to use the BAUD_MASK macro to 
cap the div value to maximum if it is larger than maximum. However as 
you said as well,
This will fix the overflow of the divisor but it means that we'll be
generating a faster clock than the device asked for which might lead to
problems.

I believe a simple warning is enough, and better not touch the div 
variable because it seems unnecessary. We already have a mask to take 
care of masking the appropriate bits.

As the commit said,

"can exceed the peripheral's maximum in some circumstances.
This will prevent it."
The prevent it part does not seem to be special to his patch, because 
anyway we were masking the bits so the value wont exceed as such in
register.


-- 
Thanks and Regards,
Dhruva Gole
