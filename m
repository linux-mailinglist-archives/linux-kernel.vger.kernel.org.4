Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71526D5318
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjDCVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjDCVI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6B44B7;
        Mon,  3 Apr 2023 14:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E0A62B58;
        Mon,  3 Apr 2023 21:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B567C433EF;
        Mon,  3 Apr 2023 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556084;
        bh=PVBPRpr58MiOy6wGa6wE7NRJu02Si3vHn7TkitFaKmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAOAo9qXJ3pkmaaM0Y+ukqG15b716d9Lh7iEAUbxl6ajlESrxH+lHJ8EgUk85lhOo
         osGNYa4toQlDOYpP1C1ULlAHvKEgrtCOFETFyBSGszHqshLk7lP2wjWM6QHleNy7fW
         wCrihhl6FudfKk3jYJlSG8orIVIT1QdmWQBwdeSoCizDZhBqIrSwwABXr9e4IhWcTJ
         Pm4EXWgFqZLnW0DEhxPJsywhDtFa371tJNeLXgGKL+5GKRaZ4eOX69g+HUXiEMdh2S
         /Ff7JmKgkZDoHzfuPvT0T7YO/G4lZBP59rrhI8/jjI4Rp0Xepg3VFOjLBceGFXTq2q
         +isiBVm0KBjwQ==
Date:   Mon, 3 Apr 2023 22:07:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        techsupport@winsystems.com, pdemetrotion@winsystems.com,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH v5 1/3] regmap: Pass irq_drv_data as a parameter for
 set_type_config()
Message-ID: <e6445419-b932-49f7-a401-b11155ad5bb9@sirena.org.uk>
References: <cover.1679845842.git.william.gray@linaro.org>
 <5ba9d4c58a4cef138201334ea48e8bc8297a9a1c.1679845842.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LgISFP/7WOX9dQTd"
Content-Disposition: inline
In-Reply-To: <5ba9d4c58a4cef138201334ea48e8bc8297a9a1c.1679845842.git.william.gray@linaro.org>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LgISFP/7WOX9dQTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 26, 2023 at 12:25:57PM -0400, William Breathitt Gray wrote:

> Changes in v5:
>  - Wrap lines to 100 characters rather than 80

It's good to keep things under 80 where we can.

>  	int (*set_type_config)(unsigned int **buf, unsigned int type,
> -			       const struct regmap_irq *irq_data, int idx);
> +			       const struct regmap_irq *irq_data, int idx, void *irq_drv_data);
>  	unsigned int (*get_irq_reg)(struct regmap_irq_chip_data *data,
>  				    unsigned int base, int index);
>  	void *irq_drv_data;

There's no benefit from overflowing here and...

> @@ -1660,7 +1660,8 @@ struct regmap_irq_chip {
>  unsigned int regmap_irq_get_irq_reg_linear(struct regmap_irq_chip_data *data,
>  					   unsigned int base, int index);
>  int regmap_irq_set_type_config_simple(unsigned int **buf, unsigned int type,
> -				      const struct regmap_irq *irq_data, int idx);
> +				      const struct regmap_irq *irq_data, int idx,
> +				      void *irq_drv_data);

...it's not even consistent.

--LgISFP/7WOX9dQTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrQC4ACgkQJNaLcl1U
h9DV/Qf+PRCsw/4s4r8lTZpU3nIiqV1fietBklJFobjST5n8EYp9hxeTLmF/r4x1
ZbZvAzsJYQu8LuChYTC2lel4jhFFhvlmOcDZcQryNrjvG9y8GKtbaSwWQgo906Px
GpzazDmchrlrtIfCKgnt3jdcaHkcD3LlxFRAIKXA/XloHjMySTl59F1Zi2ABTGzK
i+eI0XLLyshbrcYD85c+FhBAq1nj0W1O28TA7z7aVvxQL+Z//Vf4Xk4Oe9jkVVGY
jHyv5vQ7RhH/IIcu9BBMlmOHHFGFT6serZnJ8bgvnpCesEI4zYHIo+Y5n8OMmfzv
zJ+X1mDLdB9JulOuDdh4OxEnWy14MA==
=dRZY
-----END PGP SIGNATURE-----

--LgISFP/7WOX9dQTd--
