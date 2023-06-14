Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2E70EC36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjEXD6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjEXD6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACCE8;
        Tue, 23 May 2023 20:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556B363878;
        Wed, 24 May 2023 03:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EBEC433D2;
        Wed, 24 May 2023 03:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684900693;
        bh=QIqZqDSSUbUXEg/VTaopvpEy+ejkPQJcvAVPm8NcZfE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fHMJY2fcuDQyicinykzylPKbIwT6a90yO01LAzZAxk0ifReus9KgVvk/CvxcYAD0T
         iM0myCHKk2vyIg1tBGrA+c0THKuJVpe46WXVK72m589l46LywRiq11eXpT4kz9DczB
         tuWxPCP9LKdVd1t5A+m400AJcYAMM6C8P/Y7nDZSgE1H2Q6L+HdYQY5yoX80tl54E6
         Gy3gU+bS6Gg++UfSy5JXRzT2AWDAEwa5+I2e+od0fx6UujXec263ABIfieD8Wy3f1D
         l1bdOFZzFhAlLReuwkiHLlgR/0FVuoirEr5Lz20enEettrMb3cM2T5Afs9YkQxGT8W
         gDCsXarfFLsRw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 06:58:08 +0300
Message-Id: <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
In-Reply-To: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, some minor glitches.

On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> interrupts instead of polling on all capable TPMs. Unfortunately, on some
> products the interrupt line is either never asserted or never deasserted.

Use Reported-by and Closes tag and remove this paragraph.

In Closes link instead from lore the email where the bug was reported.

> The former causes interrupt timeouts and is detected by
> tpm_tis_core_init(). The latter results in interrupt storms.

Please describe instead the system where the bug was realized. Don't
worry about speculative descriptions. We only deal with ones actually
realized.

> Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
> L490 and Inspur NF5180M6:
>
> https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@r=
edhat.com/
> https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a=
78af5a6.camel@kernel.org/

Please remove all of this, as the fixes have been handled. Let's keep
the commit message focused.

> The current approach to avoid those storms is to disable interrupts by
> adding a DMI quirk for the concerned device.
>
> However this is a maintenance burden in the long run, so use a generic
> approach:
>
> Detect an interrupt storm by counting the number of unhandled interrupts
> within a 10 ms time interval. In case that more than 1000 were unhandled
> deactivate interrupts, deregister the handler and fall back to polling.
>
> This equals the implementation that handles interrupt storms in
> note_interrupt() by means of timestamps and counters in struct irq_desc.
> However the function to access this structure is private so the logic has
> to be reimplemented in the TPM TIS core.

I only now found out that this is based on kernel/irq/spurious.c code
partly. Why this was unmentioned?

That would make this already more legitimate because it is based
on field tested metrics.

Then we only have to discuss about counter.

> routine trigger a worker thread that executes the unregistration.
>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 71 +++++++++++++++++++++++++++++++--
>  drivers/char/tpm/tpm_tis_core.h |  6 +++
>  2 files changed, 74 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 558144fa707a..458ebf8c2f16 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -752,6 +752,55 @@ static bool tpm_tis_req_canceled(struct tpm_chip *ch=
ip, u8 status)
>  	return status =3D=3D TPM_STS_COMMAND_READY;
>  }
> =20
> +static void tpm_tis_handle_irq_storm(struct tpm_chip *chip)
> +{
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> +	int intmask =3D 0;
> +
> +	dev_err(&chip->dev, HW_ERR
> +		"TPM interrupt storm detected, polling instead\n");

Degrading this to warn is fine because it is legit behaviour in a
sense.

> +
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +
> +	intmask &=3D ~TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_request_locality(chip, 0);
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	tpm_tis_relinquish_locality(chip, 0);
> +
> +	chip->flags &=3D ~TPM_CHIP_FLAG_IRQ;
> +
> +	/*
> +	 * We must not call devm_free_irq() from within the interrupt handler,

Never use "we" form. Always use either:

1. Imperative
2. Passive

I.e. to address this, you would write instead "devm_free_irq() must not
be called within the interrupt handler because ...".

> +	 * since this function waits for running interrupt handlers to finish
> +	 * and thus it would deadlock. Instead trigger a worker that does the
> +	 * unregistration.
> +	 */
> +	schedule_work(&priv->free_irq_work);
> +}
> +
> +static void tpm_tis_process_unhandled_interrupt(struct tpm_chip *chip)
> +{
> +	const unsigned int MAX_UNHANDLED_IRQS =3D 1000;
> +	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);

Reverse order and add empty line.

> +	/*
> +	 * The worker to free the TPM interrupt (free_irq_work) may already
> +	 * be scheduled, so make sure it is not scheduled again.
> +	 */
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> +		return;
> +
> +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
> +		priv->unhandled_irqs =3D 1;
> +	else
> +		priv->unhandled_irqs++;
> +
> +	priv->last_unhandled_irq =3D jiffies;
> +
> +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> +		tpm_tis_handle_irq_storm(chip);

Why wouldn't we switch to polling mode even when there is a single
unhandled IRQ?=20

> +}
> +
>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  {
>  	struct tpm_chip *chip =3D dev_id;
> @@ -761,10 +810,10 @@ static irqreturn_t tis_int_handler(int dummy, void =
*dev_id)
> =20
>  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt)=
;
>  	if (rc < 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	if (interrupt =3D=3D 0)
> -		return IRQ_NONE;
> +		goto unhandled;
> =20
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
> @@ -780,10 +829,14 @@ static irqreturn_t tis_int_handler(int dummy, void =
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
> +	tpm_tis_process_unhandled_interrupt(chip);
> +	return IRQ_HANDLED;
>  }
> =20
>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
> @@ -804,6 +857,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *c=
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
> @@ -816,6 +878,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *=
chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
> =20
> +	INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
> =20
>  	rc =3D devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>  				       tis_int_handler, IRQF_ONESHOT | flags,
> @@ -918,6 +981,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>  		interrupt =3D 0;
> =20
>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
> +	flush_work(&priv->free_irq_work);
> =20
>  	tpm_tis_clkrun_enable(chip, false);
> =20
> @@ -1021,6 +1085,7 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
>  	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	priv->chip =3D chip;
>  	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops =3D phy_ops;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index e978f457fd4d..6fc86baa4398 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -91,12 +91,18 @@ enum tpm_tis_flags {
>  };
> =20
>  struct tpm_tis_data {
> +	struct tpm_chip *chip;
>  	u16 manufacturer_id;
>  	struct mutex locality_count_mutex;
>  	unsigned int locality_count;
>  	int locality;
> +	/* Interrupts */
>  	int irq;
> +	struct work_struct free_irq_work;
> +	unsigned long last_unhandled_irq;
> +	unsigned int unhandled_irqs;
>  	unsigned int int_mask;
> +
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
>
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> --=20
> 2.40.1

BR, Jarkko
