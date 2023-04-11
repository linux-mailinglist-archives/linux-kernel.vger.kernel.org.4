Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5B6DE625
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKVG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjDKVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821194482;
        Tue, 11 Apr 2023 14:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13FBC625C3;
        Tue, 11 Apr 2023 21:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3585AC433D2;
        Tue, 11 Apr 2023 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681247215;
        bh=P5kk+3HVor0otYo94Y9G9N4eNK+mWyQxWEUIOko/rMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbIKZGOCX/7fiRt1GpDSR+rtak3ggv7H77B2RxD/Hc77w1JmFPLR1dnH1REUEzfSQ
         DN0CCuxfM4QR88K9qVp3NoXzkSupq9iGFP3Fu6K3DNBxGB9ACEN4n6orD+FJ26IuEG
         oi2rdpOCAVYKY0n7TT4Yq9lTLW4F9anemxOGpe4/2cKSJXNV5gMPUs96t2v3y7Ebnb
         V/64xUxcPEfnuwKOZMo0ntcSqZlQAJWcLXAdHRE7TYxqNZ48q0f1j95flV/dmAE0B0
         0HuDa55MzfNfqHNSM9NCfu5ml/xYvLPFi1S3thPEfiy5O2VdqkLL5evp3Ma1938+S6
         9i+u/0/r8KceQ==
Date:   Tue, 11 Apr 2023 22:06:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 5/7] soc: starfive: Use call back to parse device tree
 resources
Message-ID: <20230411-stimuli-reapprove-4659d50e5d2e@spud>
References: <20230411064743.273388-1-changhuang.liang@starfivetech.com>
 <20230411064743.273388-6-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bDUiOgF7hkvaIlrf"
Content-Disposition: inline
In-Reply-To: <20230411064743.273388-6-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bDUiOgF7hkvaIlrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 11:47:41PM -0700, Changhuang Liang wrote:
> Different compatible parse device tree resources work in different ways.

Right now there is only one compatible, so this commit message needs to
be expanded on to provide more information on your motivation.

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

>  static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
>  {
>  	struct jh71xx_pmu_dev *pmd;
> @@ -296,23 +325,20 @@ static int jh71xx_pmu_probe(struct platform_device =
*pdev)
>  	if (!pmu)
>  		return -ENOMEM;
> =20
> -	pmu->base =3D device_node_to_regmap(np);
> -	if (IS_ERR(pmu->base))
> -		return PTR_ERR(pmu->base);
> -
> -	pmu->irq =3D platform_get_irq(pdev, 0);
> -	if (pmu->irq < 0)
> -		return pmu->irq;
> -
> -	ret =3D devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
> -			       0, pdev->name, pmu);
> -	if (ret)
> -		dev_err(dev, "failed to request irq\n");
> +	spin_lock_init(&pmu->lock);
> =20
>  	match_data =3D of_device_get_match_data(dev);
>  	if (!match_data)
>  		return -EINVAL;
> =20
> +	if (match_data->pmu_parse_dt) {

How can this be false?

Cheers,
Conor.

--bDUiOgF7hkvaIlrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDXL6gAKCRB4tDGHoIJi
0hKsAQDfXKLTbzKOVFnOKyo4Q8rhO79dEC4uKOIjSEkTkNr0sAEAmTPcrqwT9S1J
id3pUSxlo+QqgTZJtIAEFaPBifiRGg8=
=MAxW
-----END PGP SIGNATURE-----

--bDUiOgF7hkvaIlrf--
