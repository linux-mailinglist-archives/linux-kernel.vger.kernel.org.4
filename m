Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DE716971
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjE3Q1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjE3Q0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC0E65;
        Tue, 30 May 2023 09:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E1562CB9;
        Tue, 30 May 2023 16:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76EC4339B;
        Tue, 30 May 2023 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463947;
        bh=fL/fxkcSbE2WBgSh2PWCwsaLzxbnaI3bIl28lIQY5bE=;
        h=From:To:Cc:Subject:References:Date:From;
        b=bhy25DayRFhbTobWE70KgPRtN0CZdzu3y7heoUr9DLMSwNevRKUD8UClYEutMRIbG
         OO6TYZtEl2f3tXcMa1150+Q8sIwZFj7R0NWCJ3SjWILsU+AIikhrwM3VtMqxPlbCKn
         Zg3jBnRDPr6FP69umRnow7LP3rJKfJwLoaSQQ3NpOg1GzIQzX0kW0BqTZglXjtqFXj
         9t4gpLLGgqgFWWgkQ8C4TJAc1+LvXHnrFSQ0nQzGXHWs5QapdtEdBxKuTI+EnYUNJ8
         u7JkeYn5eqEumJEKZwIE5x+ug+EyNg7+qVR0hh2mlN6+5oL0KGxtGLxOcI4k4wAA/b
         J6BSe7SGOwxuQ==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>,
        <sbinding@opensource.cirrus.com>, <git@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>
Subject: Re: [PATCH V8 1/7] spi: Add stacked and parallel memories support
 in SPI core
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
        <20230511073134.41180-2-amit.kumar-mahapatra@amd.com>
Date:   Tue, 30 May 2023 18:25:43 +0200
Message-ID: <mafs0bki16b20.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

I did not get a chance to look at all the old comments in the previous
versions. So apologies in advance if I comment something that has
already been mentioned before.

On Thu, May 11 2023, Amit Kumar Mahapatra wrote:

> For supporting multiple CS the SPI device need to be aware of all the CS
> values. So, the "chip_select" member in the spi_device structure is now an
> array that holds all the CS values.
>
> spi_device structure now has a "cs_index_mask" member. This acts as an
> index to the chip_select array. If nth bit of spi->cs_index_mask is set
> then the driver would assert spi->chip_select[n].
>
> In parallel mode all the chip selects are asserted/de-asserted
> simultaneously and each byte of data is stored in both devices, the even
> bits in one, the odd bits in the other. The split is automatically handled
> by the GQSPI controller. The GQSPI controller supports a maximum of two
> flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag bit is
> added in the spi controntroller flags, through ctlr->flags the spi core

Typo: s/controntroller/controller/

> will make sure that the controller is capable of handling multiple chip
> selects at once.
>
> For supporting multiple CS via GPIO the cs_gpiod member of the spi_device
> structure is now an array that holds the gpio descriptor for each
> chipselect.

General comment: For large changes, it is useful to describe a
high-level overview of your new design so reviewers and future readers
can get a mental model of what is going on. I did not see anything of
that sort in this series.

>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> CS GPIO is not tested on our hardware but it has been tested by @Stefan
> https://lore.kernel.org/all/3f148a0c-8885-0425-28f4-2a53937a388f@opensource.cirrus.com/
> Stefan, could you please provide your Tested-by tag for this patch
> ---
>  drivers/spi/spi.c       | 231 ++++++++++++++++++++++++++++------------
>  include/linux/spi/spi.h |  32 ++++--
>  2 files changed, 189 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>
> index 9291b2a0e887..a793e56f6a21 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev, void *data)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
>  	struct spi_device *new_spi = data;
> +	int idx, nw_idx;
>
> -	if (spi->controller == new_spi->controller &&
> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
> -		return -EBUSY;
> +	if (spi->controller == new_spi->controller) {
> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
> +				if ((idx != 0 && !spi_get_chipselect(spi, idx)) ||
> +				    (nw_idx != 0 && !spi_get_chipselect(spi, nw_idx))) {

Hmm, from what I can understand, spi->chipselect[i] gives the
corresponding physical CS for logical CS i. So for example, if both old
and new devices map logical CS 1 to physical CS 0, this would not detect
the conflict.

What exactly are you trying to do here?

> +					continue;
> +				} else if (spi_get_chipselect(spi, idx) ==
> +				    spi_get_chipselect(new_spi, nw_idx)) {
> +					dev_err(dev,
> +						"chipselect %d already in use\n",
> +						spi_get_chipselect(new_spi, nw_idx));
> +					return -EBUSY;
> +				}
> +			}
> +		}
> +	}
>  	return 0;
>  }
>
> @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> -	int status;
> +	int status, idx;
>
>  	/*
>  	 * We need to make sure there's no other device with this
> @@ -638,8 +652,6 @@ static int __spi_add_device(struct spi_device *spi)
>  	 */
>  	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
>  	if (status) {
> -		dev_err(dev, "chipselect %d already in use\n",
> -				spi_get_chipselect(spi, 0));

Nitpick: No need for the braces around if anymore.

>  		return status;
>  	}
>
> @@ -649,8 +661,13 @@ static int __spi_add_device(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>
> -	if (ctlr->cs_gpiods)
> -		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi, 0)]);
> +	if (ctlr->cs_gpiods) {
> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +			if (!(idx != 0 && !spi_get_chipselect(spi, idx)))

Again, I don't get why you do this. This would simply fail for any
device that maps logical CS 1 to physical CS 0.

> +				spi_set_csgpiod(spi, idx,
> +						ctlr->cs_gpiods[spi_get_chipselect(spi, idx)]);
> +		}
> +	}
>
>  	/*
>  	 * Drivers may modify this initial i/o setup, but will
> @@ -690,13 +707,15 @@ int spi_add_device(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> -	int status;
> +	int status, idx;
>
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +		/* Chipselects are numbered 0..max; validate. */
> +		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
> +			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
> +				ctlr->num_chipselect);
> +			return -EINVAL;
> +		}

Since this function is doing a bunch of sanity checks, I think you
should also make sure multiple logical CS don't map to the same physical
CS. For example, make sure that spi->chip_select[0] !=
spi->chip_select[1] and so on.

>  	}
>
>  	/* Set the bus ID string */
> @@ -713,12 +732,15 @@ static int spi_add_device_locked(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr = spi->controller;
>  	struct device *dev = ctlr->dev.parent;
> +	int idx;
>
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
> +		/* Chipselects are numbered 0..max; validate. */
> +		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
> +			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
> +				ctlr->num_chipselect);
> +			return -EINVAL;
> +		}

As adding a new device gets more complex, we should stop duplicating
code between here and spi_add_device(). So you should either move this
code to another function and call it from both places or add a new
parameter called "locked" and merge spi_add_device() and
spi_add_device_locked(). I do not have string preferences for either,
but I do like the latter a bit more.

>  	}
>
>  	/* Set the bus ID string */
> @@ -966,58 +988,122 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
>  static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  {
>  	bool activate = enable;
> +	u32 cs_num = 0;
> +	int idx;
>
>  	/*
> -	 * Avoid calling into the driver (or doing delays) if the chip select
> -	 * isn't actually changing from the last time this was called.
> +	 * In parallel mode all the chip selects are asserted/de-asserted
> +	 * at once
>  	 */
> -	if (!force && ((enable && spi->controller->last_cs == spi_get_chipselect(spi, 0)) ||
> -		       (!enable && spi->controller->last_cs != spi_get_chipselect(spi, 0))) &&
> -	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
> -		return;
> -
> -	trace_spi_set_cs(spi, activate);
> +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) == SPI_PARALLEL_CS_MASK) {

This check only works if you support a maximum of 2 CS in parallel. If
you support up to, say, 4 then a chip which sets only CS 0 and 2 would
not fall under this check.

I think your code in general should treat SPI_CS_CNT_MAX as an arbitrary
value and should be able to handle changing it to any reasonable value.

> +		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
> +
> +		if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
> +			spi_delay_exec(&spi->cs_hold, NULL);
> +
> +		if (spi->mode & SPI_CS_HIGH)
> +			enable = !enable;
> +
> +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1)) {
> +			if (!(spi->mode & SPI_NO_CS)) {
> +				/*
> +				 * Historically ACPI has no means of the GPIO polarity and
> +				 * thus the SPISerialBus() resource defines it on the per-chip
> +				 * basis. In order to avoid a chain of negations, the GPIO
> +				 * polarity is considered being Active High. Even for the cases
> +				 * when _DSD() is involved (in the updated versions of ACPI)
> +				 * the GPIO CS polarity must be defined Active High to avoid
> +				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
> +				 * into account.
> +				 */
> +				if (has_acpi_companion(&spi->dev)) {
> +					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> +									 !enable);
> +				} else {
> +					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +						/* Polarity handled by GPIO library */
> +						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> +									 activate);
> +				}
> +			}
> +			/* Some SPI masters need both GPIO CS & slave_select */
> +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> +			    spi->controller->set_cs)
> +				spi->controller->set_cs(spi, !enable);
> +		} else if (spi->controller->set_cs) {
> +			spi->controller->set_cs(spi, !enable);
> +		}
>
> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
> -	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
> +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1) ||
> +		    !spi->controller->set_cs_timing) {
> +			if (activate)
> +				spi_delay_exec(&spi->cs_setup, NULL);
> +			else
> +				spi_delay_exec(&spi->cs_inactive, NULL);
> +		}
> +	} else {
>
> -	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
> -		spi_delay_exec(&spi->cs_hold, NULL);
> +		if (spi->cs_index_mask)
> +			cs_num = ffs(spi->cs_index_mask) - 1;
>
> -	if (spi->mode & SPI_CS_HIGH)
> -		enable = !enable;
> +		/*
> +		 * Avoid calling into the driver (or doing delays) if the chip select
> +		 * isn't actually changing from the last time this was called.
> +		 */
> +		if (!force && ((enable && spi->controller->last_cs ==
> +				spi_get_chipselect(spi, cs_num)) ||
> +				(!enable && spi->controller->last_cs !=
> +				 spi_get_chipselect(spi, cs_num))) &&
> +		    (spi->controller->last_cs_mode_high ==
> +		     (spi->mode & SPI_CS_HIGH)))
> +			return;
> +
> +		trace_spi_set_cs(spi, activate);
> +
> +		spi->controller->last_cs = enable ? spi_get_chipselect(spi, cs_num) : -1;
> +		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
> +
> +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller->set_cs_timing) && !activate)
> +			spi_delay_exec(&spi->cs_hold, NULL);
> +
> +		if (spi->mode & SPI_CS_HIGH)
> +			enable = !enable;
> +
> +		if (spi_get_csgpiod(spi, cs_num)) {
> +			if (!(spi->mode & SPI_NO_CS)) {
> +				/*
> +				 * Historically ACPI has no means of the GPIO polarity and
> +				 * thus the SPISerialBus() resource defines it on the per-chip
> +				 * basis. In order to avoid a chain of negations, the GPIO
> +				 * polarity is considered being Active High. Even for the cases
> +				 * when _DSD() is involved (in the updated versions of ACPI)
> +				 * the GPIO CS polarity must be defined Active High to avoid
> +				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
> +				 * into account.
> +				 */
> +				if (has_acpi_companion(&spi->dev))
> +					gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> +								 !enable);
> +				else
> +					/* Polarity handled by GPIO library */
> +					gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> +								 activate);
> +			}
> +			/* Some SPI masters need both GPIO CS & slave_select */
> +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> +			    spi->controller->set_cs)
> +				spi->controller->set_cs(spi, !enable);
> +		} else if (spi->controller->set_cs) {
> +			spi->controller->set_cs(spi, !enable);
> +		}
>
> -	if (spi_get_csgpiod(spi, 0)) {
> -		if (!(spi->mode & SPI_NO_CS)) {
> -			/*
> -			 * Historically ACPI has no means of the GPIO polarity and
> -			 * thus the SPISerialBus() resource defines it on the per-chip
> -			 * basis. In order to avoid a chain of negations, the GPIO
> -			 * polarity is considered being Active High. Even for the cases
> -			 * when _DSD() is involved (in the updated versions of ACPI)
> -			 * the GPIO CS polarity must be defined Active High to avoid
> -			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
> -			 * into account.
> -			 */
> -			if (has_acpi_companion(&spi->dev))
> -				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
> +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller->set_cs_timing) {
> +			if (activate)
> +				spi_delay_exec(&spi->cs_setup, NULL);
>  			else
> -				/* Polarity handled by GPIO library */
> -				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
> +				spi_delay_exec(&spi->cs_inactive, NULL);
>  		}
> -		/* Some SPI masters need both GPIO CS & slave_select */
> -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> -		    spi->controller->set_cs)
> -			spi->controller->set_cs(spi, !enable);
> -	} else if (spi->controller->set_cs) {
> -		spi->controller->set_cs(spi, !enable);
> -	}
> -
> -	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
> -		if (activate)
> -			spi_delay_exec(&spi->cs_setup, NULL);
> -		else
> -			spi_delay_exec(&spi->cs_inactive, NULL);

I did not read this blob of code in detail yet. A couple of general
comments though. You seem to be special-casing the multi-CS path. I do
not think that is a good idea in general. Can you refactor it in such a
way that the same bit of code handles an arbitrary number of chip
selects being asserted at the same time?

>  	}
>  }
>
> @@ -2246,8 +2332,8 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
>  static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  			   struct device_node *nc)
>  {
> -	u32 value;
> -	int rc;
> +	u32 value, cs[SPI_CS_CNT_MAX] = {0};
> +	int rc, idx;
>
>  	/* Mode (clock phase/polarity/etc.) */
>  	if (of_property_read_bool(nc, "spi-cpha"))
> @@ -2320,13 +2406,21 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  	}
>
>  	/* Device address */
> -	rc = of_property_read_u32(nc, "reg", &value);
> -	if (rc) {
> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
> +						 SPI_CS_CNT_MAX);
> +	if (rc < 0 || rc > ctlr->num_chipselect) {
>  		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
>  			nc, rc);

This error message is not very helpful for the rc > ctlr->num_chipselect
case. I think you should make them separate checks and error messages.

>  		return rc;
> +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&

Nitpick: Why make it an else-if chain? Independent if statements would
be better since these are not directly related.

> +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> +		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
> +		return -EINVAL;
>  	}

You should also make sure that no cs[idx] is greater than
ctlr->num_chipselect. Perhaps also check for multple cs[idx] pointing to the
same physical CS? It might be better to check that in spi_add_device()
though. Not sure...

> -	spi_set_chipselect(spi, 0, value);
> +	for (idx = 0; idx < rc; idx++)
> +		spi_set_chipselect(spi, idx, cs[idx]);
> +	/* By default set the spi->cs_index_mask as 1 */

Nitpick: We can infer this fact quite easily by reading the code. The
comment should instead explain _why_ it is doing so.

> +	spi->cs_index_mask = 0x01;
>
>  	/* Device speed */
>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> @@ -3905,7 +3999,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
>  	 * cs_change is set for each transfer.
>  	 */
>  	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
> -					  spi_get_csgpiod(spi, 0))) {
> +					  spi_get_csgpiod(spi, 0) ||
> +					  spi_get_csgpiod(spi, 1))) {

Again, you hard-code this to only ever supporting 2 CS in parallel.
Please make it generic.

>  		size_t maxsize;
>  		int ret;
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cfe42f8cd7a4..d0f9a9a8b6d8 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -19,6 +19,11 @@
>  #include <linux/acpi.h>
>  #include <linux/u64_stats_sync.h>
>
> +/* Max no. of CS supported per spi device */
> +#define SPI_CS_CNT_MAX 2

This is fine, but...

> +
> +/* chip select mask */
> +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))

... as I mentioned above, the way you write this patch you makes it
difficult to change the limit in the future. Please refactor it so that
if you just change SPI_CS_CNT_MAX to any arbitrary value, the core is
able to handle it.

I also think calling it "parallel" can be a bit confusing. Perhaps use
"Multi CS" everywhere?

>  struct dma_chan;
>  struct software_node;
>  struct ptp_system_timestamp;
> @@ -166,6 +171,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>   *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
>   *	two delays will be added up.
>   * @pcpu_statistics: statistics for the spi_device
> + * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
>   *
>   * A @spi_device is used to interchange data between an SPI slave
>   * (usually a discrete chip) and CPU memory.
> @@ -181,7 +187,7 @@ struct spi_device {
>  	struct spi_controller	*controller;
>  	struct spi_controller	*master;	/* Compatibility layer */
>  	u32			max_speed_hz;
> -	u8			chip_select;
> +	u8			chip_select[SPI_CS_CNT_MAX];

Should also update documentation for chip_select.

>  	u8			bits_per_word;
>  	bool			rt;
>  #define SPI_NO_TX		BIT(31)		/* No transmit wire */
> @@ -212,7 +218,7 @@ struct spi_device {
>  	void			*controller_data;
>  	char			modalias[SPI_NAME_SIZE];
>  	const char		*driver_override;
> -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
>  	struct spi_delay	word_delay; /* Inter-word delay */
>  	/* CS delays */
>  	struct spi_delay	cs_setup;
> @@ -222,6 +228,13 @@ struct spi_device {
>  	/* The statistics */
>  	struct spi_statistics __percpu	*pcpu_statistics;
>
> +	/* Bit mask of the chipselect(s) that the driver need to use from
> +	 * the chipselect array.When the controller is capable to handle
> +	 * multiple chip selects & memories are connected in parallel
> +	 * then more than one bit need to be set in cs_index_mask.
> +	 */
> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
> +
>  	/*
>  	 * likely need more hooks for more protocol options affecting how
>  	 * the controller talks to each chip, like:
> @@ -278,22 +291,22 @@ static inline void *spi_get_drvdata(const struct spi_device *spi)
>
>  static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
>  {
> -	return spi->chip_select;
> +	return spi->chip_select[idx];
>  }
>
>  static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8 chipselect)
>  {
> -	spi->chip_select = chipselect;
> +	spi->chip_select[idx] = chipselect;
>  }
>
>  static inline struct gpio_desc *spi_get_csgpiod(const struct spi_device *spi, u8 idx)
>  {
> -	return spi->cs_gpiod;
> +	return spi->cs_gpiod[idx];
>  }
>
>  static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_desc *csgpiod)
>  {
> -	spi->cs_gpiod = csgpiod;
> +	spi->cs_gpiod[idx] = csgpiod;
>  }
>
>  /**
> @@ -398,6 +411,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   * @bus_lock_spinlock: spinlock for SPI bus locking
>   * @bus_lock_mutex: mutex for exclusion of multiple callers
>   * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
> + * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
> + *	more than one chip select at once.
>   * @setup: updates the device mode and clocking records used by a
>   *	device's SPI controller; protocol code may call this.  This
>   *	must fail if an unrecognized or unsupported mode is requested.
> @@ -564,6 +579,11 @@ struct spi_controller {
>  #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
>
>  #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
> +	/*
> +	 * The spi-controller has multi chip select capability and can
> +	 * assert/de-assert more than one chip select at once.
> +	 */
> +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
>
>  	/* Flag indicating if the allocation of this struct is devres-managed */
>  	bool			devm_allocated;

I only took a high level overview of this patch and I think it needs
some reworking. I will take another look later when it gets in better
shape. I am especially worried about interactions with SPI MEM (not sure
if there need to be any, but still I should take a look) and ACPI
support. But I think you have your work cut out for you for the next
version :-)

I also want to look at the SPI NOR parts, let's see if I can find some
more time this week.

--
Regards,
Pratyush Yadav
