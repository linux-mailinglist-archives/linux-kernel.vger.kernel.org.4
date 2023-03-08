Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AC6B0C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCHPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCHPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC899C01;
        Wed,  8 Mar 2023 07:04:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 430EDB81CC0;
        Wed,  8 Mar 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7696C433D2;
        Wed,  8 Mar 2023 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678287845;
        bh=2jKVyaEpzl5bzsbm3jbTPTL4bnwl+r5C6jslj1q+q3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj52tIyh1sCsIOMF4baTxUDQmYfk5ZlGv8OlTT47qCkew3m1fdHHFFPSxTImJYnBS
         Z7vEosYRQOu64dKIKaNOw2UrKSfvn78HjVEor/MYSd9xezrdejRzR0Aayk2/CsraJA
         Ov9ZEjhliB73hMvtA5YqnvTirxWJe47AJJPHM6fe6jV4XIMPTUFQd/qQ+pJ2v4cfNq
         W9PBxRrXWXjJd071UDWJAF3O5JdVI0UcqayPbnX/2xY52ayL7vO8rlRde8G4kYLxYK
         NFrjGaqNUqTzIPY8Z+gPyAgf5veZrffb2toDMEGKGs5PF8LQtZMmLlGAxAZGiIj4Jv
         usnrQDdLQU41w==
Date:   Wed, 8 Mar 2023 15:03:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <1f0c2592-4433-47cb-9b73-d345e157dbf2@sirena.org.uk>
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8YYtAqBs0rIPZTzi"
Content-Disposition: inline
In-Reply-To: <20230308025908.21491-3-zhuyinbo@loongson.cn>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8YYtAqBs0rIPZTzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2023 at 10:59:08AM +0800, Yinbo Zhu wrote:

> +config SPI_LOONGSON
> +	tristate "Loongson SPI Controller Support"
> +	depends on LOONGARCH && OF && PCI

I'm not seeing any build time dependencies here (possibly PCI?) so
please add an || COMPILE_TEST to improve build coverage.  It'd be better
to have separate modules for the platform and PCI functionality, that
way someone who has a system without PCI can still use the driver even
with PCI support disabled.

> +++ b/drivers/spi/spi-loongson.c
> @@ -0,0 +1,502 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Loongson SPI Support
> + *
> + * Copyright (C) 2023 Loongson Technology Corporation Limited

Please make the entire comment block a C++ one so things look more
intentional.

> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +				     struct spi_device *spi, struct spi_transfer *t)
> +{
> +	unsigned int hz;
> +	unsigned int div, div_tmp;
> +	unsigned int bit;
> +	unsigned char val;
> +	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> +
> +	hz  = t ? t->speed_hz : spi->max_speed_hz;

Please write normal conditional statements so that things are legible,
though in this case the core will ensure that there's a speed_hz in
every transfer so there's no need for any of the logic around ensuring
it's set.

> +static int loongson_spi_setup(struct spi_device *spi)
> +{
> +	struct loongson_spi *loongson_spi;
> +
> +	loongson_spi = spi_master_get_devdata(spi->master);
> +	if (spi->bits_per_word % 8)
> +		return -EINVAL;
> +
> +	if (spi->chip_select >= spi->master->num_chipselect)
> +		return -EINVAL;
> +
> +	loongson_spi_update_state(loongson_spi, spi, NULL);
> +	loongson_spi_set_cs(loongson_spi, spi, 1);

Note that setup() needs to be able to run for one device while there are
transfers for other devices on the same controller active.

> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
> +					u8 **rx_buf, unsigned int num)
> +{
> +	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
> +
> +	if (tx_buf && *tx_buf) {
> +		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
> +		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1)

> +			;

A timeout would be good on these spins in case the controller gets
stuck.  It'd also be polite to have a cpu_relax() somewhere either here
or in the caller given that it's busy waiting.

> +static void loongson_spi_work(struct work_struct *work)
> +{
> +	int param;
> +	struct spi_message *m;
> +	struct spi_device  *spi;
> +	struct spi_transfer *t = NULL;
> +	struct loongson_spi *loongson_spi = container_of(work, struct loongson_spi, work);
> +
> +	spin_lock(&loongson_spi->lock);
> +	param = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
> +	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, param&~1);
> +	while (!list_empty(&loongson_spi->msg_queue)) {
> +		m = container_of(loongson_spi->msg_queue.next, struct spi_message, queue);
> +

This all looks like it's open coding the core's message pump, only
without the heavy optimisation work that the core has and missing some
handling of cs_change and delays.  You should implement
spi_transfer_one() instead, this will save a lot of code and should be
more performant.

> +static int loongson_spi_transfer(struct spi_device *spi, struct spi_message *m)
> +{

In general you'd need an extremely strong reason to implement transfer()
in a new driver.

> +static int __maybe_unused loongson_spi_resume(struct device *dev)
> +{

> +static const struct dev_pm_ops loongson_spi_dev_pm_ops = {
> +	.suspend = loongson_spi_suspend,
> +	.resume = loongson_spi_resume,
> +};

The suspend/resume ops are assigned unconditionally.

> +subsys_initcall(loongson_spi_init);
> +module_exit(loongson_spi_exit);

Why not just a regular module initcall like most SPI drivers?

--8YYtAqBs0rIPZTzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIo94ACgkQJNaLcl1U
h9BkRgf/dHyMZTWRbxoaxLX8YGUhsH5fGZlT2fvwplpo0B35nQMit4iS5/kFkpNs
d1Yo9FLlcdu6Ojw6tXquR/RTYQ+D28k/XqZXrh8YvAuzSpDN09DkC9OPilFGDrWQ
AfmyB3+5HcaeTzy+zIDqYoGSV4DuZbMdexerHu6ItD+WJG7TSrixyUCcbI/vFgjn
tm40MIRBVQuGxpeMn17AQ5GqbgXF37lcS2t5yABeuAZj1Bfttv7+LVA5Fb1ki0PA
CY+WAtQ0zeD3rziU6dDFwAPAnps4zz4RUZMAhiXOmPcz+zByVqCRZ9LqZIEtdc6b
ZvvWPp4baPCxZ6IQRQwt9q0/gtQAaw==
=EKhR
-----END PGP SIGNATURE-----

--8YYtAqBs0rIPZTzi--
