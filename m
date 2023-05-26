Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB237129B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbjEZPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjEZPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5307EE52;
        Fri, 26 May 2023 08:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5F7565110;
        Fri, 26 May 2023 15:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD58C433D2;
        Fri, 26 May 2023 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685115381;
        bh=yCh5HTW3ayVDzDP143w8WhELufxoUmboVgdJFyi38+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LctbgrVuyr/tGYdjAO/j1n6Rmm8FQ6y3WZoV41ku617Sb1FK8sndw5juCEjJSmFJS
         5DzmMMHZxTQI351xhtcYaQ2/Ce6yrfnqNgKRZiogEv+gNSz2smjlC7r70HUO9dK0vO
         u5O0/rKvn3aXeMSofTyYBASG5FkMAc5w3QPy/+txUr9hIrGWtgn7QdIDcH8My2sdBq
         UNesdKhRXMzS1+Culp1lDWtYECugXcZ7EByl/N2IlMygPf7mc9MvCBGPmVece3rbUk
         52xyqbqKcijq7L1HOUs4ULS/1N2RZD+IgY1h69EhyW/I9XFAgeVYzL+xHSdf6v3kfv
         QscS8pwZYXG4A==
Date:   Fri, 26 May 2023 16:36:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <fecc9d6a-022e-49d9-a452-8a63c409ebf3@sirena.org.uk>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v+3QrjJW0SnLoR7W"
Content-Disposition: inline
In-Reply-To: <20230526062529.46747-3-william.qiu@starfivetech.com>
X-Cookie: A Smith & Wesson beats four aces.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v+3QrjJW0SnLoR7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2023 at 02:25:28PM +0800, William Qiu wrote:

>  	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
> +		qspi_ahb = devm_clk_get(dev, "qspi-ahb");
> +		if (IS_ERR(qspi_ahb)) {
> +			dev_err(dev, "Cannot claim QSPI_AHB clock.\n");
> +			ret = PTR_ERR(qspi_ahb);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(qspi_ahb);
> +		if (ret) {
> +			dev_err(dev, "Cannot enable QSPI AHB clock.\n");
> +			goto probe_clk_failed;
> +		}

Nothing ever disables or unprepares this clock as far as I can tell?
Perhaps also consider using the clk_bulk_ APIs.

--v+3QrjJW0SnLoR7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRw0e4ACgkQJNaLcl1U
h9DDjAf/R/4LWKt8MIxLgActzDmknNj+os5gInUv/NtPY46t1E8c3jR/Eg97Gwi5
OlkkK9IGHeqfKcfWzj2JTZP+474sqV5Jss5qmQuBHcG+O8Vl63kxhlgDJi/v88Rs
CkyE+kbTbQgjNXVoq5XmHRRJfj5ncsv74NqrldUZEsfogSW6xuidDwgbp9lHOM21
5qZ2jLYI/JMLyu0hXO5HKofG8QcizYDmBsRrHBu/Im9RLesezvQDHpAaO2E0nl2q
MLLFaPijxFFGpl4sivm4QBJOO66TXc/Lh8JDk+qJd9EnElYMMw9YC/qxR+8syUp/
8kxK93togpBNaxDL4x5zo8EiNX0nBQ==
=c3SD
-----END PGP SIGNATURE-----

--v+3QrjJW0SnLoR7W--
