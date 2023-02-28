Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D546A5F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjB1T24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB1T2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC72812F11;
        Tue, 28 Feb 2023 11:28:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 724B2B80E9E;
        Tue, 28 Feb 2023 19:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C21C433EF;
        Tue, 28 Feb 2023 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677612531;
        bh=kMA69NrL+76sUcWf1jULnTfFwY0MrYdOtzZl8EFoHfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0DAa2oba1EsKPi6cKSaGu872lQ4eDzeXihS0RbPtBerY4qUPyFTAROJYIF0tIm5y
         /eC1fsgqkQ26JBXUZdq6WmrYBDDAY4ugjxsQjmt3aFOKLaK0U70gQqblP+UpumkNlG
         hQhx0S3MPBmAz4HSOwA7dXg3DasmWVaK2I//9gRtEO5D9Ib/Q8pAjWwVzkpJR7HjRl
         Xk7f7h2jljtHcEpRBmelVKS+F+8HQcQeb0TftvPRSbtpmwuwaSNz+nGq0aL6+Ls9sO
         Y2nXLrIh44HGWdG6Gxw+gBzpfdc99kqTykeXctyjq1jiZ48Hs7E/UbCf4OfCJvuYcL
         KNAvR23ZHxLnQ==
Date:   Tue, 28 Feb 2023 19:28:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, quarium@gmail.com, jhentges@accesio.com,
        jay.dolan@accesio.com
Subject: Re: [PATCH 0/3] Migrate PCIe-IDIO-24 GPIO driver to the regmap API
Message-ID: <Y/5V7a4M+LhZQhsM@sirena.org.uk>
References: <cover.1677547393.git.william.gray@linaro.org>
 <Y/5RfjJCDdrZbHgJ@sirena.org.uk>
 <Y/1ksJHUENCwg/jy@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z224iF5tpl7ptq6H"
Content-Disposition: inline
In-Reply-To: <Y/1ksJHUENCwg/jy@fedora>
X-Cookie: For external use only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z224iF5tpl7ptq6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2023 at 09:19:28PM -0500, William Breathitt Gray wrote:
> On Tue, Feb 28, 2023 at 07:09:50PM +0000, Mark Brown wrote:

> > The values from the config buffer are supposed to be written out in
> > regmap_irq_sync_unlock() - why is something custom needed here?

> The PCIe-IDIO-24 "COS Enable" serves a dual purpose of interrupt
> enabling/disabling as well as configuring the interrupt types. Since
> this register is used for masking, config buffer would clobber the
> register if we use it in this particular case. Instead, we ignore the
> config buffer and configure the type directly for the device (handling
> the case where interrupts are masked and shouldn't be enabled).

Could you be more concrete about what's going on here please?  In what
way does this "COS Enable" serve these dual functions and why do they
clobber each other?

--z224iF5tpl7ptq6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP+Ve0ACgkQJNaLcl1U
h9CocQf/bQq7YkoCwVIr7g2hJACwZ7oQxNVAHU6c7kFyeA3MlDS4vD7efAFUOv45
ePto+mmKs6aRGW/B/0xKgXRHleY8BIm84vu/jgsB2L/6bOelnSLslWRek6ZGqQHa
PBqp3RWg9y1YP46C1AErJ6m/pYPbGhlBSMifDrKj01iiZ1G4vHXeutqDNFrCPIm5
8nxqLhJjAshZJGM1pjfkf53uoyRzG+PgU2hmUkURw5gqWCBTK679+LXOdHLUZDHM
gNcav/QvisiwS8JXDAhdQOwbTb/86Z6OrCcPbM2d+LKy65f51MWC7FIrdfHNH/7s
aMVEOwoiaJ2Bpf0HXu+gxTpKtZFfyQ==
=81Tq
-----END PGP SIGNATURE-----

--z224iF5tpl7ptq6H--
