Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C96A8210
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCBMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCBMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30341B7A;
        Thu,  2 Mar 2023 04:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79761615A4;
        Thu,  2 Mar 2023 12:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38027C433D2;
        Thu,  2 Mar 2023 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677759624;
        bh=UkLrRZGFWz4j9QDCZEWFzdN5QysERiBI8gpLVzs0Ss8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc+2QXJZDZRysL8lvu7f7BBWGcMnP656F43eWCBBO6elfthqASaUNwc8v0VOImKy/
         njDycTe4B8sWChXD2RV62gSsRmf2IXDanTXbNF8NU7W4Wdq+1peRTUvrAyGorQXsBJ
         GnuSyD0azT3DH65uaO2zWZM8v0uFdNxvsMdZ/JiOyi9jUQQVS9q/2NhTPmCx19dpIy
         yWunxw9UuUMhics9ohLCBvKmDiH0bKBh6SI/+wUuayFXwxTD9Z9C1guTl6bsDuYDat
         J0Y4U69qR1lhbkq474DsoGGasaSPrWg54Dul3Wt+RWUQq1czUW3TA9hwA06kK5bShG
         JY6fj0Oxuj/Dw==
Date:   Thu, 2 Mar 2023 12:20:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     richard.leitner@linux.dev
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
Message-ID: <b0a5c0c2-dfbd-460a-af0d-c9d498607d72@sirena.org.uk>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
 <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vZhJFgRVoDnGJw+Q"
Content-Disposition: inline
In-Reply-To: <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
X-Cookie: Who messed with my anti-paranoia shot?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vZhJFgRVoDnGJw+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2023 at 12:55:03PM +0100, richard.leitner@linux.dev wrote:

> +	max9867->mclk = devm_clk_get(&i2c->dev, "mclk");
> +	if (IS_ERR(max9867->mclk))
> +		return PTR_ERR(max9867->mclk);
> +	ret = clk_prepare_enable(max9867->mclk);
> +	if (ret < 0)
> +		dev_err(&i2c->dev, "Failed to enable MCLK: %d\n", ret);
> +

Nothing ever disables the clock - we need a disable in the remove path
at least.

--vZhJFgRVoDnGJw+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQAlIEACgkQJNaLcl1U
h9CpjQf8DCWgZStUPCJltIYPDoRugIPverAChi1iNMKLKqO9Rwi3VF2ulGPf9639
hTE+u7lHCXrsfWLn0BpvQk+RZ4aJTnbTbj9ndDlnSPWStGpcl6pIK4i5S3R7RvYJ
KesklhoL1nRCoBlYpwEdpnfRz6TL0NMo3bsqxHZqhGAxNcXuT/8ylPr3dPWYSljP
FiqTg6fqtBAuXES4A9OxtllOrcYMc5VbvEdNtIOyfVs3gNzJaMiiVX2LUG1t4bS3
6QXssdNh5JQHzZwkwKHE2gKiTHR3i3nK4RNBD9WB//DVCDaPuzPLASiyNz5m72T4
zDHfnV2WYtGr2tKlR82hF3AV8C1vfg==
=YJvp
-----END PGP SIGNATURE-----

--vZhJFgRVoDnGJw+Q--
