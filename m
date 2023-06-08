Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17777727C85
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjFHKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjFHKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9471E1FEC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A9B64AFE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2553C433EF;
        Thu,  8 Jun 2023 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686219345;
        bh=Quyj3jLiFjeJyIx2n6eJqoeLweuibXEoGzDmM2bwqQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqtBZiNYFkI2OsGbD89+croM5qG9ymnlvHVtkIt7eXNnzGPous6D9+O/VT3MlSEPk
         X36PmqvNjvJ+mNR07A5IWqHPY9ZnZqqNkRJuh3jJSPqihywYxYzeQItHKvHKK6x3K+
         rlz+6jVh4k1wn3Hx43d5LtRGie9FFGL9RZ5S6iKgNE2S46GV1V6QjWEKjlXWlEomWQ
         UGPNFeb/6aNcs/rgp/clhLjh2ZKTwjDIaIp69s8Vu1rFgzjp8PPpLAkNKbGvzL1/sm
         +fM8Gca1792neWsx+Tbbk4dDp0sJWfONv6y59mjET9g08hsU5dzLF6o1vRIpLIblp5
         pNXaqh/H7H8ig==
Date:   Thu, 8 Jun 2023 11:15:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: starfive: Cleanup and fix error check for
 JH7110 TDM
Message-ID: <fbbc0963-fba5-4178-b886-fbb35c0c8df2@sirena.org.uk>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
 <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
 <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PKcaVHh5qOw7fnfv"
Content-Disposition: inline
In-Reply-To: <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
X-Cookie: Disk crisis, please clean up!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PKcaVHh5qOw7fnfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 10:15:03AM +0800, Walker Chen wrote:
> On 2023/6/7 19:44, Mark Brown wrote:

> >> -		  (tdm->rx.wl << WL_BIT) |
> >> -		  (tdm->rx.sscale << SSCALE_BIT) |
> >> -		  (tdm->rx.sl << SL_BIT) |
> >> -		  (tdm->rx.lrj << LRJ_BIT);
> >> +	datarx =3D (tdm->rxwl << 8) |
> >> +		  (tdm->rxsscale << 4) |
> >> +		  (tdm->rxsl << 2) |
> >> +		  TDM_PCMRXCR_LEFT_J;

> > I'm not sure this change to use numbers here is a win - the _BIT
> > definitions look fine (I might've called them _SHIFT but whatever).

> This is Claudiu's advice. Using the macro BIT() to replace these definiti=
on of *_BIT,=20
> it will result in big changes in the code.

I'm questioning doing a change at all.

> Please refer to previous comments:
>  https://lore.kernel.org/all/143e2fa2-e85d-8036-4f74-ca250c026c1b@microch=
ip.com/

I can't find the comments you're referring to in there.

--PKcaVHh5qOw7fnfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSBqkkACgkQJNaLcl1U
h9CWywf/Z1xfv//r9y6BIdrx+QwhKwPVc+ncix5QdBhiVs6lXk4evYULyaOiLLi1
uajsPVJ7VZgYRbUJpZRbb0QUqXpFiYv7IgCczTeZifvZryIcjopEm3eEaAXMErLI
r5y7LVayIa95enLcjWgyoISRLB9/1kXuBmKqo6JA7xakIyMwG5gioVte7W2B1vpu
AJ3BLVh2zZsIm03d3FagA5omPMLAKEEP6eHbZr9rYkn7oiPutgm6TN4up5h1XWrD
Ua12qPKgU5TnU9bUD4ymUojA2kz4LD69Fy4UgFLyjJ7NF9VrzwHK+iqjgxqrFLOR
WBxCnZbXj6Z+TexDiFUZAgcd2OqhtA==
=i16b
-----END PGP SIGNATURE-----

--PKcaVHh5qOw7fnfv--
