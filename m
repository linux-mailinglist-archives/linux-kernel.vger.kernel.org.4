Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D77085D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjERQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjERQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:19:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ABE130;
        Thu, 18 May 2023 09:19:39 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IDWKW9001364;
        Thu, 18 May 2023 11:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=cxVbN3zOfPxro3t0XffvGtCCDSW9fmRPhBh6j+UVQ1s=;
 b=jmQzZx7PT2J8DvkgayPW4cNlPUCOy9ofguTi2Kls+oi/H53CazBYQiIIYtY7JP0pftcx
 xv0+YzZHsGS1OG3WyNGXIvvWLNFfM96J4I1v4qGWEgwNSMWOWOmAzs4+yivQh2Oaq8af
 ER0IDfxzLO1MKMS/bKv2+wWal2AFXrAW413zeHFhHdWcF88sNxmlrrETqkNXCWAYmy3+
 uKWcbljNkBa7V68t4f8c4ZKYIyOq2TF1DF5xRl5ouFDTXAVk3NI+g/3TZfa1opXBoBTO
 CLgxnX0JR0mp+pGSQ9v2qgx3fbUHBwqI+ebDPRS5EHabbZRC/EoCmacbNyjkYmhyftBp ig== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qj7y175yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 11:19:08 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 11:19:06 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 11:19:06 -0500
Received: from [198.90.238.250] (unknown [198.90.238.250])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D5F46B38;
        Thu, 18 May 2023 16:19:05 +0000 (UTC)
Message-ID: <534fc206-0680-9d4d-66b1-4b5cb4beef3b@opensource.cirrus.com>
Date:   Thu, 18 May 2023 17:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V8 1/7] spi: Add stacked and parallel memories support in
 SPI core
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "michael@walle.cc" <michael@walle.cc>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@microchip.com" <claudiu.beznea@microchip.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
 <20230511073134.41180-2-amit.kumar-mahapatra@amd.com>
 <b9edd6c8-87fa-fa6f-33e4-85809f0430cb@opensource.cirrus.com>
 <BN7PR12MB2802B6F1E1EEFE415338C1D9DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <BN7PR12MB2802B6F1E1EEFE415338C1D9DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GZ29TW3lINCDYq5o98pzzm9IgCiZdHhK
X-Proofpoint-ORIG-GUID: GZ29TW3lINCDYq5o98pzzm9IgCiZdHhK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/05/2023 06:47, Mahapatra, Amit Kumar wrote:
> Hello Stefan,
>
>> -----Original Message-----
>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>> Sent: Thursday, May 11, 2023 10:20 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
>> michael@walle.cc
>> Cc: git (AMD-Xilinx) <git@amd.com>; linux-spi@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@microchip.com; Simek, Michal <michal.simek@amd.com>;
>> linux-arm-kernel@lists.infradead.org; amitrkcian2002@gmail.com
>> Subject: Re: [PATCH V8 1/7] spi: Add stacked and parallel memories support in
>> SPI core
>>
>> Hi,
>>
>> On 11/05/2023 08:31, Amit Kumar Mahapatra wrote:
>>> For supporting multiple CS the SPI device need to be aware of all the
>>> CS values. So, the "chip_select" member in the spi_device structure is
>>> now an array that holds all the CS values.
>>>
>>> spi_device structure now has a "cs_index_mask" member. This acts as an
>>> index to the chip_select array. If nth bit of spi->cs_index_mask is
>>> set then the driver would assert spi->chip_select[n].
>>>
>>> In parallel mode all the chip selects are asserted/de-asserted
>>> simultaneously and each byte of data is stored in both devices, the
>>> even bits in one, the odd bits in the other. The split is
>>> automatically handled by the GQSPI controller. The GQSPI controller
>>> supports a maximum of two flashes connected in parallel mode. A
>>> SPI_CONTROLLER_MULTI_CS flag bit is added in the spi controntroller
>>> flags, through ctlr->flags the spi core will make sure that the
>>> controller is capable of handling multiple chip selects at once.
>>>
>>> For supporting multiple CS via GPIO the cs_gpiod member of the
>>> spi_device structure is now an array that holds the gpio descriptor
>>> for each chipselect.
>>>
>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>>> ---
>>> CS GPIO is not tested on our hardware but it has been tested by
>>> @Stefan
>>> https://lore.kernel.org/all/3f148a0c-8885-0425-28f4-2a53937a388f@opens
>>> ource.cirrus.com/ Stefan, could you please provide your Tested-by tag
>>> for this patch
>> I tried testing this patch, but I got a build failure in drivers/spi/spi-dw-mmio.c
>> when I use this patch on the spi for-next branch.
>>
>> (If I disable this driver, the patch works fine)
>>
>> Thanks,
>>
>> Stefan
> Thank you for testing.
> https://github.com/torvalds/linux/commit/2c8606040a808aa01d2d9e4f5b9332e87bb66377
> this patch is causing build failure. As this patch is using the old interface( i.e., spi->chip_select)
> for accessing the chip_select variable so, build failure is observed on applying my patch series
> on top of this. I have already sent the below patch to fix this issue by replacing the spi->chip_select
> references with new set/get APIs & it's been acked as well.
> https://lore.kernel.org/all/20230515133553.46mownenmclcauec@mobilestation/
>
> If possible, could please retest by first applying the fix patch
> https://lore.kernel.org/all/20230515133553.46mownenmclcauec@mobilestation/
> on spi for-next branch followed by this patch series.
>
> If it works fine, then please provide your Tested-by tag for this patch.
>
> Regards,
> Amit

Tested-by: Stefan Binding <sbinding@opensource.cirrus.com>

>>> ---
>>>    drivers/spi/spi.c       | 231 ++++++++++++++++++++++++++++------------
>>>    include/linux/spi/spi.h |  32 ++++--
>>>    2 files changed, 189 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
>>> 9291b2a0e887..a793e56f6a21 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev, void
>> *data)
>>>    {
>>>    	struct spi_device *spi = to_spi_device(dev);
>>>    	struct spi_device *new_spi = data;
>>> +	int idx, nw_idx;
>>>
>>> -	if (spi->controller == new_spi->controller &&
>>> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
>>> -		return -EBUSY;
>>> +	if (spi->controller == new_spi->controller) {
>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX;
>> nw_idx++) {
>>> +				if ((idx != 0 && !spi_get_chipselect(spi, idx)) ||
>>> +				    (nw_idx != 0 && !spi_get_chipselect(spi,
>> nw_idx))) {
>>> +					continue;
>>> +				} else if (spi_get_chipselect(spi, idx) ==
>>> +				    spi_get_chipselect(new_spi, nw_idx)) {
>>> +					dev_err(dev,
>>> +						"chipselect %d already in
>> use\n",
>>> +						spi_get_chipselect(new_spi,
>> nw_idx));
>>> +					return -EBUSY;
>>> +				}
>>> +			}
>>> +		}
>>> +	}
>>>    	return 0;
>>>    }
>>>
>>> @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device *spi)
>>>    {
>>>    	struct spi_controller *ctlr = spi->controller;
>>>    	struct device *dev = ctlr->dev.parent;
>>> -	int status;
>>> +	int status, idx;
>>>
>>>    	/*
>>>    	 * We need to make sure there's no other device with this @@ -638,8
>>> +652,6 @@ static int __spi_add_device(struct spi_device *spi)
>>>    	 */
>>>    	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
>>>    	if (status) {
>>> -		dev_err(dev, "chipselect %d already in use\n",
>>> -				spi_get_chipselect(spi, 0));
>>>    		return status;
>>>    	}
>>>
>>> @@ -649,8 +661,13 @@ static int __spi_add_device(struct spi_device *spi)
>>>    		return -ENODEV;
>>>    	}
>>>
>>> -	if (ctlr->cs_gpiods)
>>> -		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi,
>> 0)]);
>>> +	if (ctlr->cs_gpiods) {
>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>> +			if (!(idx != 0 && !spi_get_chipselect(spi, idx)))
>>> +				spi_set_csgpiod(spi, idx,
>>> +						ctlr-
>>> cs_gpiods[spi_get_chipselect(spi, idx)]);
>>> +		}
>>> +	}
>>>
>>>    	/*
>>>    	 * Drivers may modify this initial i/o setup, but will @@ -690,13
>>> +707,15 @@ int spi_add_device(struct spi_device *spi)
>>>    {
>>>    	struct spi_controller *ctlr = spi->controller;
>>>    	struct device *dev = ctlr->dev.parent;
>>> -	int status;
>>> +	int status, idx;
>>>
>>> -	/* Chipselects are numbered 0..max; validate. */
>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>>> -			ctlr->num_chipselect);
>>> -		return -EINVAL;
>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>> +		/* Chipselects are numbered 0..max; validate. */
>>> +		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
>>> +			dev_err(dev, "cs%d >= max %d\n",
>> spi_get_chipselect(spi, idx),
>>> +				ctlr->num_chipselect);
>>> +			return -EINVAL;
>>> +		}
>>>    	}
>>>
>>>    	/* Set the bus ID string */
>>> @@ -713,12 +732,15 @@ static int spi_add_device_locked(struct spi_device
>> *spi)
>>>    {
>>>    	struct spi_controller *ctlr = spi->controller;
>>>    	struct device *dev = ctlr->dev.parent;
>>> +	int idx;
>>>
>>> -	/* Chipselects are numbered 0..max; validate. */
>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>>> -			ctlr->num_chipselect);
>>> -		return -EINVAL;
>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>> +		/* Chipselects are numbered 0..max; validate. */
>>> +		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
>>> +			dev_err(dev, "cs%d >= max %d\n",
>> spi_get_chipselect(spi, idx),
>>> +				ctlr->num_chipselect);
>>> +			return -EINVAL;
>>> +		}
>>>    	}
>>>
>>>    	/* Set the bus ID string */
>>> @@ -966,58 +988,122 @@ static void spi_res_release(struct spi_controller
>> *ctlr, struct spi_message *mes
>>>    static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>>>    {
>>>    	bool activate = enable;
>>> +	u32 cs_num = 0;
>>> +	int idx;
>>>
>>>    	/*
>>> -	 * Avoid calling into the driver (or doing delays) if the chip select
>>> -	 * isn't actually changing from the last time this was called.
>>> +	 * In parallel mode all the chip selects are asserted/de-asserted
>>> +	 * at once
>>>    	 */
>>> -	if (!force && ((enable && spi->controller->last_cs ==
>> spi_get_chipselect(spi, 0)) ||
>>> -		       (!enable && spi->controller->last_cs !=
>> spi_get_chipselect(spi, 0))) &&
>>> -	    (spi->controller->last_cs_mode_high == (spi->mode &
>> SPI_CS_HIGH)))
>>> -		return;
>>> -
>>> -	trace_spi_set_cs(spi, activate);
>>> +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) ==
>> SPI_PARALLEL_CS_MASK) {
>>> +		spi->controller->last_cs_mode_high = spi->mode &
>> SPI_CS_HIGH;
>>> +
>>> +		if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing)
>> && !activate)
>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>> +
>>> +		if (spi->mode & SPI_CS_HIGH)
>>> +			enable = !enable;
>>> +
>>> +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1)) {
>>> +			if (!(spi->mode & SPI_NO_CS)) {
>>> +				/*
>>> +				 * Historically ACPI has no means of the GPIO
>> polarity and
>>> +				 * thus the SPISerialBus() resource defines it
>> on the per-chip
>>> +				 * basis. In order to avoid a chain of
>> negations, the GPIO
>>> +				 * polarity is considered being Active High.
>> Even for the cases
>>> +				 * when _DSD() is involved (in the updated
>> versions of ACPI)
>>> +				 * the GPIO CS polarity must be defined Active
>> High to avoid
>>> +				 * ambiguity. That's why we use enable, that
>> takes SPI_CS_HIGH
>>> +				 * into account.
>>> +				 */
>>> +				if (has_acpi_companion(&spi->dev)) {
>>> +					for (idx = 0; idx < SPI_CS_CNT_MAX;
>> idx++)
>>> +
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>> +
>> !enable);
>>> +				} else {
>>> +					for (idx = 0; idx < SPI_CS_CNT_MAX;
>> idx++)
>>> +						/* Polarity handled by GPIO
>> library */
>>> +
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>> +
>> activate);
>>> +				}
>>> +			}
>>> +			/* Some SPI masters need both GPIO CS &
>> slave_select */
>>> +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
>>> +			    spi->controller->set_cs)
>>> +				spi->controller->set_cs(spi, !enable);
>>> +		} else if (spi->controller->set_cs) {
>>> +			spi->controller->set_cs(spi, !enable);
>>> +		}
>>>
>>> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
>>> -	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
>>> +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1) ||
>>> +		    !spi->controller->set_cs_timing) {
>>> +			if (activate)
>>> +				spi_delay_exec(&spi->cs_setup, NULL);
>>> +			else
>>> +				spi_delay_exec(&spi->cs_inactive, NULL);
>>> +		}
>>> +	} else {
>>>
>>> -	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
>> !activate)
>>> -		spi_delay_exec(&spi->cs_hold, NULL);
>>> +		if (spi->cs_index_mask)
>>> +			cs_num = ffs(spi->cs_index_mask) - 1;
>>>
>>> -	if (spi->mode & SPI_CS_HIGH)
>>> -		enable = !enable;
>>> +		/*
>>> +		 * Avoid calling into the driver (or doing delays) if the chip
>> select
>>> +		 * isn't actually changing from the last time this was called.
>>> +		 */
>>> +		if (!force && ((enable && spi->controller->last_cs ==
>>> +				spi_get_chipselect(spi, cs_num)) ||
>>> +				(!enable && spi->controller->last_cs !=
>>> +				 spi_get_chipselect(spi, cs_num))) &&
>>> +		    (spi->controller->last_cs_mode_high ==
>>> +		     (spi->mode & SPI_CS_HIGH)))
>>> +			return;
>>> +
>>> +		trace_spi_set_cs(spi, activate);
>>> +
>>> +		spi->controller->last_cs = enable ? spi_get_chipselect(spi,
>> cs_num) : -1;
>>> +		spi->controller->last_cs_mode_high = spi->mode &
>> SPI_CS_HIGH;
>>> +
>>> +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
>>> set_cs_timing) && !activate)
>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>> +
>>> +		if (spi->mode & SPI_CS_HIGH)
>>> +			enable = !enable;
>>> +
>>> +		if (spi_get_csgpiod(spi, cs_num)) {
>>> +			if (!(spi->mode & SPI_NO_CS)) {
>>> +				/*
>>> +				 * Historically ACPI has no means of the GPIO
>> polarity and
>>> +				 * thus the SPISerialBus() resource defines it
>> on the per-chip
>>> +				 * basis. In order to avoid a chain of
>> negations, the GPIO
>>> +				 * polarity is considered being Active High.
>> Even for the cases
>>> +				 * when _DSD() is involved (in the updated
>> versions of ACPI)
>>> +				 * the GPIO CS polarity must be defined Active
>> High to avoid
>>> +				 * ambiguity. That's why we use enable, that
>> takes SPI_CS_HIGH
>>> +				 * into account.
>>> +				 */
>>> +				if (has_acpi_companion(&spi->dev))
>>> +
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
>>> +								 !enable);
>>> +				else
>>> +					/* Polarity handled by GPIO library */
>>> +
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
>>> +								 activate);
>>> +			}
>>> +			/* Some SPI masters need both GPIO CS &
>> slave_select */
>>> +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
>>> +			    spi->controller->set_cs)
>>> +				spi->controller->set_cs(spi, !enable);
>>> +		} else if (spi->controller->set_cs) {
>>> +			spi->controller->set_cs(spi, !enable);
>>> +		}
>>>
>>> -	if (spi_get_csgpiod(spi, 0)) {
>>> -		if (!(spi->mode & SPI_NO_CS)) {
>>> -			/*
>>> -			 * Historically ACPI has no means of the GPIO polarity
>> and
>>> -			 * thus the SPISerialBus() resource defines it on the
>> per-chip
>>> -			 * basis. In order to avoid a chain of negations, the
>> GPIO
>>> -			 * polarity is considered being Active High. Even for
>> the cases
>>> -			 * when _DSD() is involved (in the updated versions of
>> ACPI)
>>> -			 * the GPIO CS polarity must be defined Active High to
>> avoid
>>> -			 * ambiguity. That's why we use enable, that takes
>> SPI_CS_HIGH
>>> -			 * into account.
>>> -			 */
>>> -			if (has_acpi_companion(&spi->dev))
>>> -
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
>>> +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
>>> set_cs_timing) {
>>> +			if (activate)
>>> +				spi_delay_exec(&spi->cs_setup, NULL);
>>>    			else
>>> -				/* Polarity handled by GPIO library */
>>> -
>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>>> +				spi_delay_exec(&spi->cs_inactive, NULL);
>>>    		}
>>> -		/* Some SPI masters need both GPIO CS & slave_select */
>>> -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
>>> -		    spi->controller->set_cs)
>>> -			spi->controller->set_cs(spi, !enable);
>>> -	} else if (spi->controller->set_cs) {
>>> -		spi->controller->set_cs(spi, !enable);
>>> -	}
>>> -
>>> -	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
>>> -		if (activate)
>>> -			spi_delay_exec(&spi->cs_setup, NULL);
>>> -		else
>>> -			spi_delay_exec(&spi->cs_inactive, NULL);
>>>    	}
>>>    }
>>>
>>> @@ -2246,8 +2332,8 @@ static void of_spi_parse_dt_cs_delay(struct
>> device_node *nc,
>>>    static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>    			   struct device_node *nc)
>>>    {
>>> -	u32 value;
>>> -	int rc;
>>> +	u32 value, cs[SPI_CS_CNT_MAX] = {0};
>>> +	int rc, idx;
>>>
>>>    	/* Mode (clock phase/polarity/etc.) */
>>>    	if (of_property_read_bool(nc, "spi-cpha")) @@ -2320,13 +2406,21 @@
>>> static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>    	}
>>>
>>>    	/* Device address */
>>> -	rc = of_property_read_u32(nc, "reg", &value);
>>> -	if (rc) {
>>> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
>>> +						 SPI_CS_CNT_MAX);
>>> +	if (rc < 0 || rc > ctlr->num_chipselect) {
>>>    		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
>>>    			nc, rc);
>>>    		return rc;
>>> +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
>>> +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
>>> +		dev_err(&ctlr->dev, "SPI controller doesn't support multi
>> CS\n");
>>> +		return -EINVAL;
>>>    	}
>>> -	spi_set_chipselect(spi, 0, value);
>>> +	for (idx = 0; idx < rc; idx++)
>>> +		spi_set_chipselect(spi, idx, cs[idx]);
>>> +	/* By default set the spi->cs_index_mask as 1 */
>>> +	spi->cs_index_mask = 0x01;
>>>
>>>    	/* Device speed */
>>>    	if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
>>> -3905,7 +3999,8 @@ static int __spi_validate(struct spi_device *spi, struct
>> spi_message *message)
>>>    	 * cs_change is set for each transfer.
>>>    	 */
>>>    	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
>> SPI_CS_WORD) ||
>>> -					  spi_get_csgpiod(spi, 0))) {
>>> +					  spi_get_csgpiod(spi, 0) ||
>>> +					  spi_get_csgpiod(spi, 1))) {
>>>    		size_t maxsize;
>>>    		int ret;
>>>
>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
>>> cfe42f8cd7a4..d0f9a9a8b6d8 100644
>>> --- a/include/linux/spi/spi.h
>>> +++ b/include/linux/spi/spi.h
>>> @@ -19,6 +19,11 @@
>>>    #include <linux/acpi.h>
>>>    #include <linux/u64_stats_sync.h>
>>>
>>> +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX 2
>>> +
>>> +/* chip select mask */
>>> +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
>>>    struct dma_chan;
>>>    struct software_node;
>>>    struct ptp_system_timestamp;
>>> @@ -166,6 +171,7 @@ extern void
>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>     *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
>>>     *	two delays will be added up.
>>>     * @pcpu_statistics: statistics for the spi_device
>>> + * @cs_index_mask: Bit mask of the active chipselect(s) in the
>>> + chipselect array
>>>     *
>>>     * A @spi_device is used to interchange data between an SPI slave
>>>     * (usually a discrete chip) and CPU memory.
>>> @@ -181,7 +187,7 @@ struct spi_device {
>>>    	struct spi_controller	*controller;
>>>    	struct spi_controller	*master;	/* Compatibility layer */
>>>    	u32			max_speed_hz;
>>> -	u8			chip_select;
>>> +	u8			chip_select[SPI_CS_CNT_MAX];
>>>    	u8			bits_per_word;
>>>    	bool			rt;
>>>    #define SPI_NO_TX		BIT(31)		/* No transmit wire */
>>> @@ -212,7 +218,7 @@ struct spi_device {
>>>    	void			*controller_data;
>>>    	char			modalias[SPI_NAME_SIZE];
>>>    	const char		*driver_override;
>>> -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
>>> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select
>> gpio desc */
>>>    	struct spi_delay	word_delay; /* Inter-word delay */
>>>    	/* CS delays */
>>>    	struct spi_delay	cs_setup;
>>> @@ -222,6 +228,13 @@ struct spi_device {
>>>    	/* The statistics */
>>>    	struct spi_statistics __percpu	*pcpu_statistics;
>>>
>>> +	/* Bit mask of the chipselect(s) that the driver need to use from
>>> +	 * the chipselect array.When the controller is capable to handle
>>> +	 * multiple chip selects & memories are connected in parallel
>>> +	 * then more than one bit need to be set in cs_index_mask.
>>> +	 */
>>> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
>>> +
>>>    	/*
>>>    	 * likely need more hooks for more protocol options affecting how
>>>    	 * the controller talks to each chip, like:
>>> @@ -278,22 +291,22 @@ static inline void *spi_get_drvdata(const struct
>>> spi_device *spi)
>>>
>>>    static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
>>>    {
>>> -	return spi->chip_select;
>>> +	return spi->chip_select[idx];
>>>    }
>>>
>>>    static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8
>> chipselect)
>>>    {
>>> -	spi->chip_select = chipselect;
>>> +	spi->chip_select[idx] = chipselect;
>>>    }
>>>
>>>    static inline struct gpio_desc *spi_get_csgpiod(const struct spi_device *spi,
>> u8 idx)
>>>    {
>>> -	return spi->cs_gpiod;
>>> +	return spi->cs_gpiod[idx];
>>>    }
>>>
>>>    static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct
>> gpio_desc *csgpiod)
>>>    {
>>> -	spi->cs_gpiod = csgpiod;
>>> +	spi->cs_gpiod[idx] = csgpiod;
>>>    }
>>>
>>>    /**
>>> @@ -398,6 +411,8 @@ extern struct spi_device
>> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>>     * @bus_lock_spinlock: spinlock for SPI bus locking
>>>     * @bus_lock_mutex: mutex for exclusion of multiple callers
>>>     * @bus_lock_flag: indicates that the SPI bus is locked for
>>> exclusive use
>>> + * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
>>> + *	more than one chip select at once.
>>>     * @setup: updates the device mode and clocking records used by a
>>>     *	device's SPI controller; protocol code may call this.  This
>>>     *	must fail if an unrecognized or unsupported mode is requested.
>>> @@ -564,6 +579,11 @@ struct spi_controller {
>>>    #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
>>>
>>>    #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must
>> select slave */
>>> +	/*
>>> +	 * The spi-controller has multi chip select capability and can
>>> +	 * assert/de-assert more than one chip select at once.
>>> +	 */
>>> +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
>>>
>>>    	/* Flag indicating if the allocation of this struct is devres-managed */
>>>    	bool			devm_allocated;
