Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC96E79D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjDSMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjDSMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA025E50;
        Wed, 19 Apr 2023 05:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 496EE63643;
        Wed, 19 Apr 2023 12:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAAEC433D2;
        Wed, 19 Apr 2023 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681907774;
        bh=zLBNrnGTS7PfXsbReuF8yNgt/hxvun5C/cZPrBU/CSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJQRX6bqVXlEh0BHEpwDcce45PLXeFw1aEKh6SbRv1HWjjPMJvn0Loxo0bEg9WvG1
         9Q/ucLIH+iAKcumTIy/dOF56okqDGd6c0Ex83XKG8ScsrxuzYMP6dTeMMEW3DaHT/P
         uVh7wfQHdHrLdUsHj6m728kRMkFmlH2WTv6q3xRhU9/V/sYpThvyQ2PAv5QJ9HcHjB
         xNp/8j5US+ehIlqeYZx7ilsbeieyScNJDN820HnixqzNkAZRGu0Wt47BW9CAqnh+Ei
         2iMVb9goliJ+2oNfU0T995yAUkCLGCajdjcDwrzhOJfHLS8r0Fre65vAVhlLf6YfH5
         P8yBDCCBe/oRA==
Date:   Wed, 19 Apr 2023 13:36:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v8 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <c24f8a28-23d4-46e3-8ff2-4b6f4e39b493@sirena.org.uk>
References: <20230419062202.28749-1-zhuyinbo@loongson.cn>
 <20230419062202.28749-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NVSAr3jEmrWbbgVZ"
Content-Disposition: inline
In-Reply-To: <20230419062202.28749-3-zhuyinbo@loongson.cn>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NVSAr3jEmrWbbgVZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2023 at 02:22:02PM +0800, Yinbo Zhu wrote:

> +       clk = devm_clk_get(dev, NULL);
> +       if (!IS_ERR(clk))
> +               spi->clk_rate = clk_get_rate(clk);

I notice we never actually enable this clock.  I guess it's some system
clock which is needed for basic system functionality which is always on
and we just need the rate but it looks a bit off.

> +static int __maybe_unused loongson_spi_suspend(struct device *dev)
> +{
> +	struct loongson_spi *loongson_spi;
> +	struct spi_master *master;
> +
> +	master = dev_get_drvdata(dev);
> +	loongson_spi = spi_master_get_devdata(master);
> +
> +	loongson_spi->spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
> +	loongson_spi->sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
> +	loongson_spi->spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
> +	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
> +	loongson_spi->sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
> +	loongson_spi->timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
> +
> +	spi_master_suspend(master);

This saves the register state before suspending at the SPI level but
that means that if there were any transfers in progress then the
register state might be changed by the active transfers after we've
saved the state, meaning we might restore a state for an active
transfer.  The spi_master_suspend() should go first, then save the
register state.  The resume is OK, it's just the suspend.

--NVSAr3jEmrWbbgVZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ/4DcACgkQJNaLcl1U
h9A0hQf7BHmvHA2QmbUR7lbb9AQGd+7eHamujsA+9a+BEsCykdhf6qhZpsPDPBHn
iSMfk+EvhYzgETram9i92BRsRk6246qOgrXI0okifQUzIr8SnKW+HGKPYfcu1tB9
0OoX41xcRkL4sxS/ScF35N2MzNw3i7Y7071JOjAvhoiLbYlTKYRpDPwmHPfrgbsl
CjVvtBNemnLTKKlrNy1VeejNey+HNo1ahRPRmz5kyNToZyPlIIxuabmqO1BDHOe4
NP9Ihdo01mzJkBnbufA/+d52OjiFOhNWjqVlZa9XXEv5D49K7Ua+eq/WS8NJk643
IhcP6AaWaI1gAlw0T1LDLkvwN1qbgQ==
=VLa1
-----END PGP SIGNATURE-----

--NVSAr3jEmrWbbgVZ--
