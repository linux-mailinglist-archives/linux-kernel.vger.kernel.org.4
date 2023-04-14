Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65B6E2A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjDNScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDNSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3286A2;
        Fri, 14 Apr 2023 11:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8033E649C2;
        Fri, 14 Apr 2023 18:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E2CC433EF;
        Fri, 14 Apr 2023 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681497153;
        bh=vKUitZRz+obzaz3lR/ADlqWYQaTRObBYOfyX3so27Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgMiVd29EUGpZ0DIrQG8hCUG6oRbUwMXG3RATbdWmuTePaJKjipP0URpQpFKfUIK6
         Ibtsn7dD8gDx8lnOprtLzd0QMEvkUGudgpuXfwsHTi/NGDrvmby3RvLJpLJbQxT/TQ
         Y11T7gwPxWUGGeqrpwvczEWVGKS2VGNXuCrrpnGG9sV2zlekd2Afu4xILoFeSIFlRd
         0Ldm2nG9Ut8l//ahhzO22les8tmNKW6oRTRBRoj3psef920gK6OaVdZcSjClvk1qxt
         JmFFHAkhIOryH3pvLdjo4YDKNF+ojqZEyo6UAlEZuXxjwEcchWVr7+xhQ43Yz8VeX7
         Q128fCVFPjayA==
Date:   Fri, 14 Apr 2023 19:32:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v7 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <f0989d13-4520-461f-8715-3595e11f988e@sirena.org.uk>
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
 <20230412045152.4694-3-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="29/KVkP8J7BvNLls"
Content-Disposition: inline
In-Reply-To: <20230412045152.4694-3-zhuyinbo@loongson.cn>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--29/KVkP8J7BvNLls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 12:51:52PM +0800, Yinbo Zhu wrote:

> +static int __maybe_unused loongson_spi_suspend(struct device *dev)
> +{
> +	struct loongson_spi *loongson_spi;
> +	struct spi_master *master;
> +
> +	master = dev_get_drvdata(dev);
> +	loongson_spi = spi_master_get_devdata(master);
> +
> +	loongson_spi->spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);

This is missing a call to spi_controller_suspend(), and similarly resume
is missing a call to spi_controller_resume().  Otherwise this looks
good.

--29/KVkP8J7BvNLls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5nDsACgkQJNaLcl1U
h9CAhwf/U5UIA8nm2mT4KVXaTYaJXvCv34GkE7RaSHf8It33c3T+SzafytzTzRHk
4q8WWlxOQZu5tu+0aO3gaBj56nQeZjKNF4ZlL2xaoZqCH9KEgmaOfgo6PLNKO9o/
bNa3M7s1p+FfNWmAdlBroU5mQdBFmZdFV0QvE/Ys/JeF3tHQSRYWm248IZezQTc4
+8YKNJxyZZGXD9LG65ArFFHvaCGzYu6c236XAPXEh9zhFENmeEXITVdsn4no6jgq
c7lb7gp9y9urAdft/vo+/Xmyltfx+5lDCz22gFdO6zWY9lWjDmvqACOfYExsX6SV
1IyF3T3c6GnpADr3xzM5RPE/iU2rjg==
=eM2N
-----END PGP SIGNATURE-----

--29/KVkP8J7BvNLls--
