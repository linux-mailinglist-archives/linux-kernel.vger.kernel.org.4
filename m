Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6635373A088
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFVMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjFVMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0311728;
        Thu, 22 Jun 2023 05:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1451617FB;
        Thu, 22 Jun 2023 12:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01029C433C0;
        Thu, 22 Jun 2023 12:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687435683;
        bh=AhyNDGJmhhola/QmWkU/88kjnQn/z/ZY1Yo42GWMUA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beCwEaRwAnDmL4ncqLaEpgpdOtYbsqDnFdQIbh+XurazBXC0dhink0Ef9CAZjeaP6
         Jx/WQogSNCVQsQxvqyPRilrxafXr7enJ8qFJVTjmdCl6FEhkOXATocRC9Z6/g+15gA
         /CW1e3ai7tiuOwzl4dyBXKGNtQYQ+VKdG1eA9em7Q80WTH1yVZeCI2suGay03XAQag
         PKznyOzwvaRUbr4gWQRi4dixavuMJ9/DnE1rIeU8y5mssFxjRRnYLu1C0jmXKP7IE8
         wqYXzEJIIf5hyqh0biVRq36JEBX+i30tltZMiuMKnU9wyqGslwJAYkcnCrtDgwwNm8
         crsoeNfRxKShA==
Date:   Thu, 22 Jun 2023 13:07:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/8] ASoC: tegra: Fix AMX byte map
Message-ID: <ad4b4dc9-7466-45a9-a008-c2301a7485dd@sirena.org.uk>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hvr/i48Dzsk3Qmc8"
Content-Disposition: inline
In-Reply-To: <1687433656-7892-3-git-send-email-spujar@nvidia.com>
X-Cookie: Please ignore previous fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hvr/i48Dzsk3Qmc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 05:04:10PM +0530, Sameer Pujar wrote:
> From: Sheetal <sheetal@nvidia.com>
>=20
> Byte mask for channel-1 of stream-1 is not getting enabled and this
> causes failures during AMX use cases. The enable bit is not set during
> put() callback of byte map mixer control.
>=20
> This happens because the byte map value 0 matches the initial state
> of byte map array and put() callback returns without doing anything.
>=20
> Fix the put() callback by actually looking at the byte mask array
> to identify if any change is needed and update the fields accordingly.

I'm not quite sure I follow the logic here - I'd have expected this to
mean that there's a bootstrapping issue and that we should be doing some
more initialisation during startup such that the existing code which
checks if there is a change will be doing the right thing?

> Also update get() callback to return 256 if the byte map is disabled.

This will be a user visible change.  It's not clear to me why it's
needed - it seems like it's a hack to push users to do an update in the
case where they want to use channel 1 stream 1?

--Hvr/i48Dzsk3Qmc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUOZsACgkQJNaLcl1U
h9DHhAf/WefGD9yvCmEhMJLKKlodJrVPiVYeL9PQs1d2i8BgdWrneVmZJdrx1hkW
4ZWCYKwK3UcuNjes6c/oKuhJswe8nHUgdyH21fnoagm/pC0Ofb9x1spklUvUkhlD
sVD1UjM7EyKX+io2TI0GcK+Gq6PF1kdejPTG0G8rDRz0xVWcQmt/ik6v7oRPCHsI
HVXMIiPYGeP3EGAps4oyD+jUeSIyc/3+7yOZdxE7sHs6+iNY6wmDKgwdQ9XrexcW
2hrfIcStW1dIcMSTqxR33p6BF51q9ao0CuAMWIKc5cPB+5+CK7fuQNz9A9iaNxUR
JjcnjMponglfk0gg0VuJ0rVMwAnYYQ==
=/vui
-----END PGP SIGNATURE-----

--Hvr/i48Dzsk3Qmc8--
