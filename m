Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85D727D31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjFHKuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjFHKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FEB269A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6078E611E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4F0C433D2;
        Thu,  8 Jun 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686221424;
        bh=d9rhyteykx390amid4fogZjlw+8v7h6yhbM1lcS1kOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzjukPe2bQ9bBS2ApgLOZLaWiDnw5W0/A/oofCoOIHTArx0SGvK8s5aUrWyKUyq4+
         kcEMV0HT9m1Jl9tVoamHF2vujgIybo8dmRqIWNWZ2B9HBu4dGSrP3CD7HO4CQjk3C5
         4fO95JjFdCkQH1x2kF9J16lblzD1Djo6FrgcGNs9GtghHv5fNoqsQ7NHeg9yONDbKf
         iTuaA0ybu8wJw43cmLrXxLdnPH7kCDeSAPyEqoqg9QIXEbg3fO0SrSTrAp0kXAncdN
         BbvtdDXz47RZLxkHyuyG6IfIKQAUHJaLracCNIHOZ9KvZAjXLwRd4kV/T1cjM76uJd
         +++4WRCgwXgsA==
Date:   Thu, 8 Jun 2023 11:50:19 +0100
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
Message-ID: <c974d0c7-b091-4d5c-b73c-1b6584eb823a@sirena.org.uk>
References: <20230607081439.1517-1-walker.chen@starfivetech.com>
 <3eb7ffc5-a16a-4ac2-93a0-260f7cb1f81c@sirena.org.uk>
 <d941ac20-e8b3-cb13-4258-3a9a86e978d3@starfivetech.com>
 <fbbc0963-fba5-4178-b886-fbb35c0c8df2@sirena.org.uk>
 <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2uNTG7wn7psmZdj"
Content-Disposition: inline
In-Reply-To: <7db1d08e-8310-8876-4ed8-36d6e53ab8bf@starfivetech.com>
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


--f2uNTG7wn7psmZdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 06:43:09PM +0800, Walker Chen wrote:
> On 2023/6/8 18:15, Mark Brown wrote:

> > I can't find the comments you're referring to in there.

> You should see the following comments in the link above:

> > +       #define CLKPOL_BIT              5
> > +       #define TRITXEN_BIT             4
> > +       #define ELM_BIT                 3
> > +       #define SYNCM_BIT               2
> > +       #define MS_BIT                  1

> Instead of these *_BIT defines as plain numbers you can defined them using
> BIT() macro and use macros in place instead of

The usual pattern is to have defines for both the shift and the mask,
not just one.

--f2uNTG7wn7psmZdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSBsmoACgkQJNaLcl1U
h9AaAgf/YFRMuzUXFmKWVFmW0C4MWUJR3lzyYhAx+RwVv/ootjDxlKsogcqv6mNq
8LjQpDuh+em/aq6ue26Faqn4yf8ZdyQN/kbRAAaufI8wvIoqY6ZJrkhY6J4rBt6C
BO43k/HSyKZEQpBC8KgOD68upzo5Q6k/HO2j6CtslH6E/E4xYmuWoeKeGfbeqIzj
1eyfuepNe/+l0U9YhLT63Cu/w4BhVrOvlfYVXsNP2OehKTCjjMcdRPRokv+nkx8Q
F+0YiQiSNP+kLw/B/H0tqVuPlxCaLqyiSsqFXlhf+KCkOLdSH0JTxEC/yV8dUaUp
pZYAn1LJKxiIEztZTta+TWpzvu6Cyw==
=V59r
-----END PGP SIGNATURE-----

--f2uNTG7wn7psmZdj--
