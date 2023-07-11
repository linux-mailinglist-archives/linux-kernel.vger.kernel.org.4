Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648CE74E2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGKAuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjGKAuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68231BE;
        Mon, 10 Jul 2023 17:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5539661143;
        Tue, 11 Jul 2023 00:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22480C433C8;
        Tue, 11 Jul 2023 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689036611;
        bh=mZmsLSP5c8pSPcG/BlSgKxjmgEV+HlIp/6GqTKi3MCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBAlG74wtNwEaFpLHKoRzRSo5JRzTj2CCx44ZJ2KVJZSUMtRYwTuD+7vw2XAo8T/I
         WBzkon6LhTYKpSe+WkZmRqxKyNWuO3ZsVbUklHYyoLhsAMn6tf/ZiW+/5OUJehsiov
         HZHtrJfNCv9T8sObIkqcgGoROf/psXiQ5+kIRMDYfncyKYrqKRea+EeG60T/nRcoMG
         N+v2cXtQN8g+Vw7X+TCu183oy225Bmhy3B70nCEZZzEcTLekRoUpxYvZU7jnWzh8uY
         ON0rMlEZ1NObU3vpSvBxVHILIrxnqUsFJ73nXSCPc5+RT/angr39G1FTgEHqTjpU9D
         8TpqzegIyimxw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 03:50:05 +0300
Message-Id: <CTYXI8TL7C36.2SCWH82FAZWBO@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>,
        "kernel test robot" <yujie.liu@intel.com>
Subject: Re: [PATCH 3] tpm,tpm_tis: Disable interrupts after 1000 unhandled
 IRQs
X-Mailer: aerc 0.14.0
References: <20230619092219.2600-1-LinoSanfilippo@gmx.de>
In-Reply-To: <20230619092219.2600-1-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, you should do next time:

git format-patch -v4 to get "[PATCH v4]", which defacto way to mark up
patch set versions.

On Mon Jun 19, 2023 at 12:22 PM EEST, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> After activation of interrupts for TPM TIS drivers 0-day reports an
> interrupt storm on an Inspur NF5180M6 server.
>
> Fix this by detecting the storm and falling back to polling:
> Count the number of unhandled interrupts within a 10 ms time interval. In
> case that more than 1000 were unhandled deactivate interrupts entirely,
> deregister the handler and use polling instead.
>
> Also print a note to point to the tpm_tis_dmi_table.
>
> Since the interrupt deregistration function devm_free_irq() waits for all
> interrupt handlers to finish, only trigger a worker in the interrupt
> handler and do the unregistration in the worker to avoid a deadlock.
>
> Note: the storm detection logic equals the implementation in
> note_interrupt() which uses timestamps and counters stored in struct
> irq_desc. Since this structure is private to the generic interrupt core
> the TPM TIS core uses its own timestamps and counters. Furthermore the TP=
M
> interrupt handler always returns IRQ_HANDLED to prevent the generic
> interrupt core from processing the interrupt storm.
>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@in=
tel.com/
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 117 ++++++++++++++++++++++++++++----
>  drivers/char/tpm/tpm_tis_core.h |   4 ++
>  2 files changed, 106 insertions(+), 15 deletions(-)
>
> Changes to v2:
> - use define for max number of unhandles irqs(requested by Jarko)
> - rename intmask to int_mask (requested by Jarko)
> - rephrased short summary (requested by Jarko)
> - rename disable_interrupts to tpm_tis_disable_interrupts (requested by J=
arko)
> - print info message concerning adding an entry to tpm_tis_dmi_table
>   (suggested by Jerry)
> - amended commit message
> - handle failure of locality request by returning IRQ_NONE
> - dont take and release locality in __tpm_tis_disable_interrupts but in i=
ts
> caller
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 558144fa707a..d42537b985c5 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -24,9 +24,12 @@
>  #include <linux/wait.h>
>  #include <linux/acpi.h>
>  #include <linux/freezer.h>
> +#include <linux/dmi.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
> =20
> +#define TPM_TIS_MAX_UNHANDLED_IRQS	1000
> +
>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
> =20
>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> @@ -468,25 +471,29 @@ static int tpm_tis_send_data(struct tpm_chip *chip,=
 const u8 *buf, size_t len)
>  	return rc;
>  }
> =20
> -static void disable_interrupts(struct tpm_chip *chip)
> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	u32 int_mask =3D 0;
> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &int_mask);
> +	int_mask &=3D ~TPM_GLOBAL_INT_ENABLE;
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), int_mask);
> +
> +	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> +}
> +
> +static void tpm_tis_disable_interrupts(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> -	u32 intmask;
> -	int rc;
> =20
>  	if (priv->irq =3D=3D 0)
>  		return;
> =20
> -	rc =3D tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		intmask =3D 0;
> -
> -	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> -	rc =3D tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	__tpm_tis_disable_interrupts(chip);
> =20
>  	devm_free_irq(chip->dev.parent, priv->irq, chip);
>  	priv->irq =3D 0;
> -	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>  }

These look pretty good.

> =20
>  /*
> @@ -552,7 +559,7 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *bu=
f, size_t len)
>  	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>  		tpm_msleep(1);
>  	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
> -		disable_interrupts(chip);
> +		tpm_tis_disable_interrupts(chip);
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	return rc;
>  }
> @@ -752,6 +759,71 @@ static bool tpm_tis_req_canceled(struct tpm_chip *ch=
ip, u8 status)
>  	return status =3D=3D TPM_STS_COMMAND_READY;
>  }
> =20
> +static irqreturn_t tpm_tis_reenable_polling(struct tpm_chip *chip)


I'd rename this to tpm_tis_revert_interrupts(), as it reverts enabling
the interrupts. Polling was never enabled in a fully initialized driver
so the function name is implying something that never happened.

> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	const char *product;
> +	const char *vendor;
> +
> +	dev_warn(&chip->dev, FW_BUG
> +		 "TPM interrupt storm detected, polling instead\n");
> +
> +	vendor =3D dmi_get_system_info(DMI_SYS_VENDOR);
> +	product =3D dmi_get_system_info(DMI_PRODUCT_VERSION);
> +
> +	if (vendor && product) {
> +		dev_info(&chip->dev,
> +			"Consider adding the following entry to tpm_tis_dmi_table:\n");
> +		dev_info(&chip->dev, "\tDMI_SYS_VENDOR: %s\n", vendor);
> +		dev_info(&chip->dev, "\tDMI_PRODUCT_VERSION: %s\n", product);
> +	}
> +
> +	if (tpm_tis_request_locality(chip, 0) !=3D 0)
> +		return IRQ_NONE;
> +
> +	__tpm_tis_disable_interrupts(chip);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	/*
> +	 * devm_free_irq() must not be called from within the interrupt handler=
,
> +	 * since this function waits for running handlers to finish and thus it
> +	 * would deadlock. Instead trigger a worker that takes care of the
> +	 * unregistration.
> +	 */

Way too complex description. This should do:

	/* Defer devm_free_irq() outside the interrupt context: */

> +	schedule_work(&priv->free_irq_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t tpm_tis_check_for_interrupt_storm(struct tpm_chip *ch=
ip)

What does checking interrupt storm mean, anyway?

> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	irqreturn_t irqret =3D IRQ_HANDLED;
> +
> +	/*
> +	 * The worker to free the TPM interrupt (free_irq_work) may already
> +	 * be scheduled, so make sure it is not scheduled again.
> +	 */

I don't understand the text in the comment. It is not even a proper
sentence ("to work to free").

> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +		return IRQ_HANDLED;
> +
> +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
> +		priv->unhandled_irqs =3D 1;
> +	else
> +		priv->unhandled_irqs++;
> +
> +	priv->last_unhandled_irq =3D jiffies;
> +
> +	if (priv->unhandled_irqs > TPM_TIS_MAX_UNHANDLED_IRQS)
> +		irqret =3D tpm_tis_reenable_polling(chip);
> +
> +	/*
> +	 * Prevent the genirq code from starting its own interrupt storm
> +	 * handling by always reporting that the interrupt was handled.
> +	 */

Ditto, textual content is confusing.

You can either make them more informative, or add a short description
before the function.

> +	return irqret;
> +}
> +
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip =3D dev_id;
> @@ -761,10 +833,10 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
> =20
>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt)=
;
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;

s/unhandled/err/g

> =20
>  	if (interrupt =3D=3D 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
> @@ -780,10 +852,13 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
>  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt)=
;
>  	tpm_tis_relinquish_locality(chip, 0);
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	return IRQ_HANDLED;
> +
> +unhandled:
> +	return tpm_tis_check_for_interrupt_storm(chip);
>  }
> =20
>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
> @@ -804,6 +879,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *c=
hip)
>  		chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
>  }
> =20
> +static void tpm_tis_free_irq_func(struct work_struct *work)
> +{
> +	struct tpm_tis_data *priv =3D container_of(work, typeof(*priv), free_ir=
q_work);
> +	struct tpm_chip *chip =3D priv->chip;
> +
> +	devm_free_irq(chip->dev.parent, priv->irq, chip);
> +	priv->irq =3D 0;
> +}
> +
>  /* Register the IRQ and issue a command that will cause an interrupt. If=
 an
>   * irq is seen then leave the chip setup for IRQ operation, otherwise re=
verse
>   * everything and leave in polling mode. Returns 0 on success.
> @@ -816,6 +900,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *=
chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
> =20
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> =20
>  	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>  				       tis_int_handler, IRQF_ONESHOT | flags,
> @@ -918,6 +1003,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>  		interrupt =3D 0;
> =20
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> +	flush_work(&priv->free_irq_work);
> =20
>  	tpm_tis_clkrun_enable(chip, false);
> =20
> @@ -1021,6 +1107,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	priv->chip =3D chip;
>  	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops =3D phy_ops;
> @@ -1179,7 +1266,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  			rc =3D tpm_tis_request_locality(chip, 0);
>  			if (rc < 0)
>  				goto out_err;
> -			disable_interrupts(chip);
> +			tpm_tis_disable_interrupts(chip);
>  			tpm_tis_relinquish_locality(chip, 0);
>  		}
>  	}
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index 610bfadb6acf..b1a169d7d1ca 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -91,11 +91,15 @@ enum tpm_tis_flags {
>  };
> =20
>  struct tpm_tis_data {
> +	struct tpm_chip *chip;
>  	u16 manufacturer_id;
>  	struct mutex locality_count_mutex;
>  	unsigned int locality_count;
>  	int locality;
>  	int irq;
> +	struct work_struct free_irq_work;
> +	unsigned long last_unhandled_irq;
> +	unsigned int unhandled_irqs;
>  	unsigned int int_mask;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>
> base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
> --=20
> 2.40.1


BR, Jarkko
