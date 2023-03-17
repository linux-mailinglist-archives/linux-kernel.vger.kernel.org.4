Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D76BEE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCQQ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCQQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A04DCF75;
        Fri, 17 Mar 2023 09:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A57460C4F;
        Fri, 17 Mar 2023 16:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E84C433EF;
        Fri, 17 Mar 2023 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679070410;
        bh=CwEEAx/G5OhiLd/eGbnRZjcYdZNmqggCPk6B/V0rcDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klg2rxiLCzc3qstlsTguGQNYPWf0tgSuYPq4RGOI2/wbwMn6smqAMuCsaKg/jB8cJ
         uDb5jlhlGivt6vz4/IDuL7phiMarYs1gW1b4P41lEwDCyDLmC3VCLuJqKRlsVL9UdP
         QFIXR/2DSL8VICE8lQLcrHnqIhIOCMiKYeDbTFMEtHnyheOfkw8QGNdMTWI/+gYBGZ
         0MLm9LZc01MvGRBxzSccP36734lX03bqZqmN4ELJmdk3ZLTbCCVvb+FXjuq/dt9p50
         XLpbnUSO9o2g9Us8A5eTKjgaguPmKDF/kyMshKu3qbYx2iXJ4ZkWedX90CpY+K8Av4
         4CfAYSeePbAJA==
Date:   Fri, 17 Mar 2023 16:26:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zrMJl7KvHhcf2o8H"
Content-Disposition: inline
In-Reply-To: <20230317082950.12738-3-zhuyinbo@loongson.cn>
X-Cookie: Life is like an analogy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zrMJl7KvHhcf2o8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 17, 2023 at 04:29:50PM +0800, Yinbo Zhu wrote:

> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +				     struct spi_device *spi, struct spi_transfer *t)
> +{

...

> +		loongson_spi->hz = hz;
> +		loongson_spi->spcr = div_tmp & 3;
> +		loongson_spi->sper = (div_tmp >> 2) & 3;
> +		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);

This is writing to general chip registers, apparently not per chip
select ones.

> +static int loongson_spi_setup(struct spi_device *spi)
> +{
> +	struct loongson_spi *loongson_spi;

> +	spin_lock(&loongson_spi->lock);
> +	loongson_spi_update_state(loongson_spi, spi, NULL);

As IIRC I mentioned last time setup() might be called while other
transfers are happening and therefore shouldn't affect parallel
operations on other devices.

> +static const struct of_device_id loongson_spi_id_table[] = {
> +	{ .compatible = "loongson,ls2k-spi", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
> +
> +static struct platform_driver loongson_spi_driver = {
> +	.probe = loongson_spi_platform_probe,
> +	.driver	= {
> +		.name	= "loongson-spi",
> +		.owner	= THIS_MODULE,
> +		.bus = &platform_bus_type,
> +		.pm = &loongson_spi_dev_pm_ops,
> +		.of_match_table = loongson_spi_id_table,
> +	},
> +};
> +
> +#ifdef CONFIG_PCI
> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +			const struct pci_device_id *ent)

Again as I said last time the two buses should probably be separate
modules.

Otherwise this looks fine.

--zrMJl7KvHhcf2o8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQUlMQACgkQJNaLcl1U
h9DOXAf/VDU6yjRFyVKb5HgozUkSGmHX6XY1E0Ewx7g2+gB3FvCpIieLcR2Jaf1t
cEfkvFNQcL3QMnpFOlhFm0AqU41bHOYATqmI9d8InkuLHlLCo0cnD0xlaWZR520J
FyYRjIsTc9K78zBQ6gEApxdpLNl+SJMBm+idowd3IIr2mr64g3P5h7tTXQ12NCjD
7y6hfQ0EKbwW2TXO5Vfho3o8N38fQjbRH8fPrLQyktkhXW9YdKd9uGBo0cYlyv/I
Dm52x0Bkdg7XIp7RNsAVW0NPBGq+p9pjvBccNXNCpwOASf+tVm70t8eoQw5RfJwA
prWG7YI8y2+mQ1msWDmT3N84BLTqkg==
=SVU/
-----END PGP SIGNATURE-----

--zrMJl7KvHhcf2o8H--
