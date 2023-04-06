Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB086D9878
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbjDFNoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:44:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F044ED0;
        Thu,  6 Apr 2023 06:44:33 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3364htp0024114;
        Thu, 6 Apr 2023 08:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 references : in-reply-to : subject : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=5bFDxbXiiLoaMbW5JpL8PgkkhsE7clmakbFGXOUN41A=;
 b=OofkicqbGqjedmcDFweVvoH8+ZyWK1H86oEERF3+3Q/e9rfAk1fH00wybN+/dgi5r0GC
 nLUsKbJx7BScHJzOh2rx63Aci3m+mdkMNCoTozZYMfJWN0Tgs8ePtx1rBooDCSHGW7WN
 ZcSYnYJQ3r55VOxeRpt4xXG7qsdFcaG7GGy1dAMKlShBCzEtOpp5CA2Nj5M+Bpogot0d
 g/E6Vd7Mou8xli8xudIIFvtfxa/Sj9TxTMrWMQJ6ht+nJqZ57zrRC+EStun4UKxdz7oU
 oD0tXZQyUWvo4tVd7duL7ZnBYUAOjc5adS/wStgktGiIqStEs49G503OOiRPYEiSg5YE 5Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pph1r8xb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 08:44:01 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 6 Apr
 2023 08:43:59 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Apr 2023 08:43:59 -0500
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.90.238.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 614A3478;
        Thu,  6 Apr 2023 13:43:59 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     'Amit Kumar Mahapatra' <amit.kumar-mahapatra@amd.com>,
        <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <michal.simek@amd.com>,
        <linux-arm-kernel@lists.infradead.org>, <amitrkcian2002@gmail.com>,
        <patches@opensource.cirrus.com>, <vitalyr@opensource.cirrus.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com> <20230406065336.10980-2-amit.kumar-mahapatra@amd.com>
In-Reply-To: <20230406065336.10980-2-amit.kumar-mahapatra@amd.com>
Subject: RE: [PATCH V7 1/7] spi: Add stacked and parallel memories support in SPI core
Date:   Thu, 6 Apr 2023 14:43:59 +0100
Message-ID: <007c01d9688d$d770c670$86525350$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQHcX4YAkkSgem6hFPQNr+252Mc4ewHcdKwBrwlz3qA=
X-Proofpoint-ORIG-GUID: 7unyActiRJguzsUdNM4jPvxQ7WFl6q0t
X-Proofpoint-GUID: 7unyActiRJguzsUdNM4jPvxQ7WFl6q0t
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Sent: Thursday, April 6, 2023 7:54 AM
> To: broonie@kernel.org; tudor.ambarus@linaro.org;
> pratyush@kernel.org; michael@walle.cc; miquel.raynal@bootlin.com;
> richard@nod.at; vigneshr@ti.com
> Cc: git@amd.com; sbinding@opensource.cirrus.com; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> mtd@lists.infradead.org; nicolas.ferre@microchip.com;
> alexandre.belloni@bootlin.com; claudiu.beznea@microchip.com;
> michal.simek@amd.com; linux-arm-kernel@lists.infradead.org;
> amitrkcian2002@gmail.com; Amit Kumar Mahapatra <amit.kumar-
> mahapatra@amd.com>
> Subject: [PATCH V7 1/7] spi: Add stacked and parallel memories
support
> in SPI core
> 
> For supporting multiple CS the SPI device need to be aware of all
the CS
> values. So, the "chip_select" member in the spi_device structure is
now
> an
> array that holds all the CS values.
> 
> spi_device structure now has a "cs_index_mask" member. This acts as
an
> index to the chip_select array. If nth bit of spi->cs_index_mask is
set
> then the driver would assert spi->chip_select[n].
> 
> In parallel mode all the chip selects are asserted/de-asserted
> simultaneously and each byte of data is stored in both devices, the
even
> bits in one, the odd bits in the other. The split is automatically
handled
> by the GQSPI controller. The GQSPI controller supports a maximum of
> two
> flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag
> bit is
> added in the spi controntroller flags, through ctlr->flags the spi
core
> will make sure that the controller is capable of handling multiple
chip
> selects at once.
> 
> For supporting multiple CS via GPIO the cs_gpiod member of the
> spi_device
> structure is now an array that holds the gpio descriptor for each
> chipselect.
> 
> Multi CS support using GPIO is not tested due to unavailability of
> necessary hardware setup.
> 
> Multi CS configuration with one native CS and one GPIO CS is not
> supported
> as this configuration could not be tested due to unavailability of
> necessary hardware setup.

I've tested this chain on a released laptop (HP EliteBook 840 G9)
which uses
SPI to interface to 2 amps, one amp uses a native CS and the other
uses a
GPIO CS, and I noticed that when using this chain, the second amp no
longer
works.

Thanks,
Stefan Binding

> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
> mahapatra@amd.com>
> ---
>  drivers/spi/spi.c       | 226
++++++++++++++++++++++++++++------------
>  include/linux/spi/spi.h |  32 ++++--
>  2 files changed, 183 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9036d7a50674..04d7322170c4 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev,
> void *data)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_device *new_spi = data;
> +	int idx, nw_idx;
> 
> -	if (spi->controller == new_spi->controller &&
> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi,
0))
> -		return -EBUSY;
> +	if (spi->controller == new_spi->controller) {
> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX;
> nw_idx++) {
> +				if ((idx != 0 &&
!spi_get_chipselect(spi,
> idx)) ||
> +				    (nw_idx != 0 &&
> !spi_get_chipselect(spi, nw_idx))) {
> +					continue;
> +				} else if (spi_get_chipselect(spi,
idx) ==
> +				    spi_get_chipselect(new_spi,
nw_idx))
> {
> +					dev_err(dev,
> +						"chipselect %d already
> in use\n",
> +
> 	spi_get_chipselect(new_spi, nw_idx));
> +					return -EBUSY;
> +				}
> +			}
> +		}
> +	}
>  	return 0;
>  }
> 
> @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device
> *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> -	int status;
> +	int status, idx;
> 
>  	/*
>  	 * We need to make sure there's no other device with this
> @@ -638,8 +652,6 @@ static int __spi_add_device(struct spi_device
> *spi)
>  	 */
>  	status = bus_for_each_dev(&spi_bus_type, NULL, spi,
> spi_dev_check);
>  	if (status) {
> -		dev_err(dev, "chipselect %d already in use\n",
> -				spi_get_chipselect(spi, 0));
>  		return status;
>  	}
> 
> @@ -649,8 +661,10 @@ static int __spi_add_device(struct spi_device
> *spi)
>  		return -ENODEV;
>  	}
> 
> -	if (ctlr->cs_gpiods)
> -		spi_set_csgpiod(spi, 0, ctlr-
> >cs_gpiods[spi_get_chipselect(spi, 0)]);
> +	if (ctlr->cs_gpiods) {
> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +			spi_set_csgpiod(spi, idx, ctlr-
> >cs_gpiods[spi_get_chipselect(spi, idx)]);
> +	}
> 
>  	/*
>  	 * Drivers may modify this initial i/o setup, but will
> @@ -690,13 +704,15 @@ int spi_add_device(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> -	int status;
> +	int status, idx;
> 
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n",
> spi_get_chipselect(spi, 0),
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +		/* Chipselects are numbered 0..max; validate. */
> +		if (spi_get_chipselect(spi, idx) >=
ctlr->num_chipselect) {
> +			dev_err(dev, "cs%d >= max %d\n",
> spi_get_chipselect(spi, idx),
> +				ctlr->num_chipselect);
> +			return -EINVAL;
> +		}
>  	}
> 
>  	/* Set the bus ID string */
> @@ -713,12 +729,15 @@ static int spi_add_device_locked(struct
> spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> +	int idx;
> 
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n",
> spi_get_chipselect(spi, 0),
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +		/* Chipselects are numbered 0..max; validate. */
> +		if (spi_get_chipselect(spi, idx) >=
ctlr->num_chipselect) {
> +			dev_err(dev, "cs%d >= max %d\n",
> spi_get_chipselect(spi, idx),
> +				ctlr->num_chipselect);
> +			return -EINVAL;
> +		}
>  	}
> 
>  	/* Set the bus ID string */
> @@ -966,58 +985,118 @@ static void spi_res_release(struct
> spi_controller *ctlr, struct spi_message *mes
>  static void spi_set_cs(struct spi_device *spi, bool enable, bool
force)
>  {
>  	bool activate = enable;
> +	u32 cs_num = __ffs(spi->cs_index_mask);
> +	int idx;
> 
>  	/*
> -	 * Avoid calling into the driver (or doing delays) if the chip
select
> -	 * isn't actually changing from the last time this was called.
> +	 * In parallel mode all the chip selects are
asserted/de-asserted
> +	 * at once
>  	 */
> -	if (!force && ((enable && spi->controller->last_cs ==
> spi_get_chipselect(spi, 0)) ||
> -		       (!enable && spi->controller->last_cs !=
> spi_get_chipselect(spi, 0))) &&
> -	    (spi->controller->last_cs_mode_high == (spi->mode &
> SPI_CS_HIGH)))
> -		return;
> -
> -	trace_spi_set_cs(spi, activate);
> -
> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0)
: -1;
> -	spi->controller->last_cs_mode_high = spi->mode &
> SPI_CS_HIGH;
> -
> -	if ((spi_get_csgpiod(spi, 0) ||
!spi->controller->set_cs_timing)
> && !activate)
> -		spi_delay_exec(&spi->cs_hold, NULL);
> -
> -	if (spi->mode & SPI_CS_HIGH)
> -		enable = !enable;
> +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) ==
> SPI_PARALLEL_CS_MASK) {
> +		spi->controller->last_cs_mode_high = spi->mode &
> SPI_CS_HIGH;
> +
> +		if ((spi_get_csgpiod(spi, 0) || !spi->controller-
> >set_cs_timing) && !activate)
> +			spi_delay_exec(&spi->cs_hold, NULL);
> +
> +		if (spi->mode & SPI_CS_HIGH)
> +			enable = !enable;
> +
> +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi,
1)) {
> +			if (!(spi->mode & SPI_NO_CS)) {
> +				/*
> +				 * Historically ACPI has no means of
the
> GPIO polarity and
> +				 * thus the SPISerialBus() resource
> defines it on the per-chip
> +				 * basis. In order to avoid a chain of
> negations, the GPIO
> +				 * polarity is considered being Active
> High. Even for the cases
> +				 * when _DSD() is involved (in the
> updated versions of ACPI)
> +				 * the GPIO CS polarity must be
defined
> Active High to avoid
> +				 * ambiguity. That's why we use
enable,
> that takes SPI_CS_HIGH
> +				 * into account.
> +				 */
> +				if (has_acpi_companion(&spi->dev)) {
> +					for (idx = 0; idx <
> SPI_CS_CNT_MAX; idx++)
> +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> +
> !enable);
> +				} else {
> +					for (idx = 0; idx <
> SPI_CS_CNT_MAX; idx++)
> +						/* Polarity handled by
> GPIO library */
> +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> +
> activate);
> +				}
> +			}
> +			/* Some SPI masters need both GPIO CS &
> slave_select */
> +			if ((spi->controller->flags &
> SPI_MASTER_GPIO_SS) &&
> +			    spi->controller->set_cs)
> +				spi->controller->set_cs(spi, !enable);
> +		} else if (spi->controller->set_cs) {
> +			spi->controller->set_cs(spi, !enable);
> +		}
> 
> -	if (spi_get_csgpiod(spi, 0)) {
> -		if (!(spi->mode & SPI_NO_CS)) {
> -			/*
> -			 * Historically ACPI has no means of the GPIO
> polarity and
> -			 * thus the SPISerialBus() resource defines it
on
> the per-chip
> -			 * basis. In order to avoid a chain of
negations,
> the GPIO
> -			 * polarity is considered being Active High.
Even
> for the cases
> -			 * when _DSD() is involved (in the updated
> versions of ACPI)
> -			 * the GPIO CS polarity must be defined Active
> High to avoid
> -			 * ambiguity. That's why we use enable, that
> takes SPI_CS_HIGH
> -			 * into account.
> -			 */
> -			if (has_acpi_companion(&spi->dev))
> -
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
> +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1)
||
> +		    !spi->controller->set_cs_timing) {
> +			if (activate)
> +				spi_delay_exec(&spi->cs_setup, NULL);
>  			else
> -				/* Polarity handled by GPIO library */
> -
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
> +				spi_delay_exec(&spi->cs_inactive,
> NULL);
>  		}
> -		/* Some SPI masters need both GPIO CS & slave_select
> */
> -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> -		    spi->controller->set_cs)
> +	} else {
> +		/*
> +		 * Avoid calling into the driver (or doing delays) if
the
> chip select
> +		 * isn't actually changing from the last time this was
> called.
> +		 */
> +		if (!force && ((enable && spi->controller->last_cs ==
> +				spi_get_chipselect(spi, cs_num)) ||
> +				(!enable && spi->controller->last_cs
!=
> +				 spi_get_chipselect(spi, cs_num))) &&
> +		    (spi->controller->last_cs_mode_high ==
> +		     (spi->mode & SPI_CS_HIGH)))
> +			return;
> +
> +		trace_spi_set_cs(spi, activate);
> +
> +		spi->controller->last_cs = enable ?
> spi_get_chipselect(spi, cs_num) : -1;
> +		spi->controller->last_cs_mode_high = spi->mode &
> SPI_CS_HIGH;
> +
> +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) && !activate)
> +			spi_delay_exec(&spi->cs_hold, NULL);
> +
> +		if (spi->mode & SPI_CS_HIGH)
> +			enable = !enable;
> +
> +		if (spi_get_csgpiod(spi, cs_num)) {
> +			if (!(spi->mode & SPI_NO_CS)) {
> +				/*
> +				 * Historically ACPI has no means of
the
> GPIO polarity and
> +				 * thus the SPISerialBus() resource
> defines it on the per-chip
> +				 * basis. In order to avoid a chain of
> negations, the GPIO
> +				 * polarity is considered being Active
> High. Even for the cases
> +				 * when _DSD() is involved (in the
> updated versions of ACPI)
> +				 * the GPIO CS polarity must be
defined
> Active High to avoid
> +				 * ambiguity. That's why we use
enable,
> that takes SPI_CS_HIGH
> +				 * into account.
> +				 */
> +				if (has_acpi_companion(&spi->dev))
> +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> +
> !enable);
> +				else
> +					/* Polarity handled by GPIO
> library */
> +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> +
> activate);
> +			}
> +			/* Some SPI masters need both GPIO CS &
> slave_select */
> +			if ((spi->controller->flags &
> SPI_MASTER_GPIO_SS) &&
> +			    spi->controller->set_cs)
> +				spi->controller->set_cs(spi, !enable);
> +		} else if (spi->controller->set_cs) {
>  			spi->controller->set_cs(spi, !enable);
> -	} else if (spi->controller->set_cs) {
> -		spi->controller->set_cs(spi, !enable);
> -	}
> +		}
> 
> -	if (spi_get_csgpiod(spi, 0) ||
!spi->controller->set_cs_timing) {
> -		if (activate)
> -			spi_delay_exec(&spi->cs_setup, NULL);
> -		else
> -			spi_delay_exec(&spi->cs_inactive, NULL);
> +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) {
> +			if (activate)
> +				spi_delay_exec(&spi->cs_setup, NULL);
> +			else
> +				spi_delay_exec(&spi->cs_inactive,
> NULL);
> +		}
>  	}
>  }
> 
> @@ -2246,8 +2325,8 @@ static void of_spi_parse_dt_cs_delay(struct
> device_node *nc,
>  static int of_spi_parse_dt(struct spi_controller *ctlr, struct
spi_device
> *spi,
>  			   struct device_node *nc)
>  {
> -	u32 value;
> -	int rc;
> +	u32 value, cs[SPI_CS_CNT_MAX] = {0};
> +	int rc, idx;
> 
>  	/* Mode (clock phase/polarity/etc.) */
>  	if (of_property_read_bool(nc, "spi-cpha"))
> @@ -2320,13 +2399,21 @@ static int of_spi_parse_dt(struct
> spi_controller *ctlr, struct spi_device *spi,
>  	}
> 
>  	/* Device address */
> -	rc = of_property_read_u32(nc, "reg", &value);
> -	if (rc) {
> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
> +						 SPI_CS_CNT_MAX);
> +	if (rc < 0 || rc > ctlr->num_chipselect) {
>  		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property
> (%d)\n",
>  			nc, rc);
>  		return rc;
> +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
> +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> +		dev_err(&ctlr->dev, "SPI controller doesn't support
multi
> CS\n");
> +		return -EINVAL;
>  	}
> -	spi_set_chipselect(spi, 0, value);
> +	for (idx = 0; idx < rc; idx++)
> +		spi_set_chipselect(spi, idx, cs[idx]);
> +	/* By default set the spi->cs_index_mask as 1 */
> +	spi->cs_index_mask = 0x01;
> 
>  	/* Device speed */
>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> @@ -3907,7 +3994,8 @@ static int __spi_validate(struct spi_device
> *spi, struct spi_message *message)
>  	 * cs_change is set for each transfer.
>  	 */
>  	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
> SPI_CS_WORD) ||
> -					  spi_get_csgpiod(spi, 0))) {
> +					  spi_get_csgpiod(spi, 0) ||
> +					  spi_get_csgpiod(spi, 1))) {
>  		size_t maxsize;
>  		int ret;
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 873ced6ae4ca..6453b246e0af 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -19,6 +19,11 @@
>  #include <linux/acpi.h>
>  #include <linux/u64_stats_sync.h>
> 
> +/* Max no. of CS supported per spi device */
> +#define SPI_CS_CNT_MAX 2
> +
> +/* chip select mask */
> +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
>  struct dma_chan;
>  struct software_node;
>  struct ptp_system_timestamp;
> @@ -166,6 +171,7 @@ extern void
> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>   *	deasserted. If @cs_change_delay is used from @spi_transfer,
> then the
>   *	two delays will be added up.
>   * @pcpu_statistics: statistics for the spi_device
> + * @cs_index_mask: Bit mask of the active chipselect(s) in the
> chipselect array
>   *
>   * A @spi_device is used to interchange data between an SPI slave
>   * (usually a discrete chip) and CPU memory.
> @@ -181,7 +187,7 @@ struct spi_device {
>  	struct spi_controller	*controller;
>  	struct spi_controller	*master;	/* Compatibility layer
*/
>  	u32			max_speed_hz;
> -	u8			chip_select;
> +	u8			chip_select[SPI_CS_CNT_MAX];
>  	u8			bits_per_word;
>  	bool			rt;
>  #define SPI_NO_TX	BIT(31)		/* No transmit wire */
> @@ -202,7 +208,7 @@ struct spi_device {
>  	void			*controller_data;
>  	char			modalias[SPI_NAME_SIZE];
>  	const char		*driver_override;
> -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio
desc
> */
> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/*
Chip
> select gpio desc */
>  	struct spi_delay	word_delay; /* Inter-word delay */
>  	/* CS delays */
>  	struct spi_delay	cs_setup;
> @@ -212,6 +218,13 @@ struct spi_device {
>  	/* The statistics */
>  	struct spi_statistics __percpu	*pcpu_statistics;
> 
> +	/* Bit mask of the chipselect(s) that the driver need to use
from
> +	 * the chipselect array.When the controller is capable to
handle
> +	 * multiple chip selects & memories are connected in parallel
> +	 * then more than one bit need to be set in cs_index_mask.
> +	 */
> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
> +
>  	/*
>  	 * likely need more hooks for more protocol options affecting
> how
>  	 * the controller talks to each chip, like:
> @@ -268,22 +281,22 @@ static inline void *spi_get_drvdata(const
> struct spi_device *spi)
> 
>  static inline u8 spi_get_chipselect(const struct spi_device *spi,
u8 idx)
>  {
> -	return spi->chip_select;
> +	return spi->chip_select[idx];
>  }
> 
>  static inline void spi_set_chipselect(struct spi_device *spi, u8
idx, u8
> chipselect)
>  {
> -	spi->chip_select = chipselect;
> +	spi->chip_select[idx] = chipselect;
>  }
> 
>  static inline struct gpio_desc *spi_get_csgpiod(const struct
spi_device
> *spi, u8 idx)
>  {
> -	return spi->cs_gpiod;
> +	return spi->cs_gpiod[idx];
>  }
> 
>  static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx,
struct
> gpio_desc *csgpiod)
>  {
> -	spi->cs_gpiod = csgpiod;
> +	spi->cs_gpiod[idx] = csgpiod;
>  }
> 
>  /**
> @@ -388,6 +401,8 @@ extern struct spi_device
> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   * @bus_lock_spinlock: spinlock for SPI bus locking
>   * @bus_lock_mutex: mutex for exclusion of multiple callers
>   * @bus_lock_flag: indicates that the SPI bus is locked for
exclusive use
> + * @multi_cs_cap: indicates that the SPI Controller can
assert/de-assert
> + *	more than one chip select at once.
>   * @setup: updates the device mode and clocking records used by a
>   *	device's SPI controller; protocol code may call this.  This
>   *	must fail if an unrecognized or unsupported mode is requested.
> @@ -554,6 +569,11 @@ struct spi_controller {
>  #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx
> */
> 
>  #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select
> slave */
> +	/*
> +	 * The spi-controller has multi chip select capability and can
> +	 * assert/de-assert more than one chip select at once.
> +	 */
> +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
> 
>  	/* Flag indicating if the allocation of this struct is devres-
> managed */
>  	bool			devm_allocated;
> --
> 2.17.1


