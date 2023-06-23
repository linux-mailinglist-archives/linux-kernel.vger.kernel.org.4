Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC17973B4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFWKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFWKPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE772949;
        Fri, 23 Jun 2023 03:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E9F61A05;
        Fri, 23 Jun 2023 10:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B31C433C0;
        Fri, 23 Jun 2023 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687515305;
        bh=/aSXCSqv/VKsWuNl5ddGk7ozs2KUpTx2lvAt2RmeF3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxkTY8Enhzt7H27iMQEXUf2PbJWEQa9lEfZ17TkIvKUN9+8mC5+mr9/dMY5EOktns
         Tfb9ZnNv22yKQxYJaWgiamaEs1vSkxDUl+6OvJLo/lrtl6ElygDBccyFm7ENPT8EGT
         FSa8cooDxj5QGu37PCaBw/gjYbp/buOMZ1r9hvXaMG7CQL84zO8amPpc6tGI7ZFGEw
         onNGQfXEZ5IoxPAOT3Kq3FrlFZaA6KGgqWtHxoqhkCYwfU8Hys/l7pPQcrYU+rVzIj
         2xec7N955iYgAeLM8plG5wNLEI9B0KBZapjgi1dpAbnbCXPhoFNFRoD+BG6hlVGFW7
         EKRG1WR2lHbIA==
Date:   Fri, 23 Jun 2023 11:15:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, mkumard@nvidia.com, sheetal@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/8] ASoC: tegra: Fix AMX byte map
Message-ID: <ZJVwpE5KeL8rgvB9@finisterre.sirena.org.uk>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
 <1687433656-7892-3-git-send-email-spujar@nvidia.com>
 <ad4b4dc9-7466-45a9-a008-c2301a7485dd@sirena.org.uk>
 <7893c366-e6aa-d606-c3d6-e85f73a345e0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnl+KoOKISxFJemC"
Content-Disposition: inline
In-Reply-To: <7893c366-e6aa-d606-c3d6-e85f73a345e0@nvidia.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vnl+KoOKISxFJemC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 23, 2023 at 11:09:32AM +0530, Sameer Pujar wrote:
> On 22-06-2023 17:37, Mark Brown wrote:
> > On Thu, Jun 22, 2023 at 05:04:10PM +0530, Sameer Pujar wrote:

> > > Byte mask for channel-1 of stream-1 is not getting enabled and this
> > > causes failures during AMX use cases. The enable bit is not set during
> > > put() callback of byte map mixer control.

> > > This happens because the byte map value 0 matches the initial state
> > > of byte map array and put() callback returns without doing anything.

> > > Fix the put() callback by actually looking at the byte mask array
> > > to identify if any change is needed and update the fields accordingly.

> > I'm not quite sure I follow the logic here - I'd have expected this to
> > mean that there's a bootstrapping issue and that we should be doing some
> > more initialisation during startup such that the existing code which
> > checks if there is a change will be doing the right thing?

> The issue can happen in subsequent cycles as well if once the user disables
> the byte map by putting 256. It happens because of following reason where
> 256 value is reset to 0 since the byte map array is tightly packed and it
> can't store 256 value.

...

> > > Also update get() callback to return 256 if the byte map is disabled.
> > This will be a user visible change.  It's not clear to me why it's
> > needed - it seems like it's a hack to push users to do an update in the
> > case where they want to use channel 1 stream 1?

> Though it looks like 256 value is forced, but actually the user sees
> whatever value is set before. The 256 value storage is linked to byte mask
> value.

> I must admit that this is not easily readable. If you suggest to simplify
> this, I can check if storage space increase for byte map value can make it
> more readable. Thanks for your feedback.

This could definitely use more clarification I think.  It's not obvious
that storing 256 won't actually hold (and that should trigger a
complaint from mixer-test if that's what happens).

--vnl+KoOKISxFJemC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVcKQACgkQJNaLcl1U
h9ChNAf8Dc9guHHicnKRVmRXvQ/BAUbK3nW/Sj1OA5p9qg7p+/GYuii6LDx6P9Ot
Is7FImWjHZSLY9pG2ym1CvV022stiZ54g4B/Wqmh7MTerAOrdu0RddPMo9zn/dP6
mTQLPLwYKcd/p+3DFvDQIjJPsik21pCP/p/6nwNIyJvabevapr9bPEpbU6e+4gYb
BE7RDSx/sen2JbDP9a5RjDt/SgGVinAaEUVtDxcOyPXYN0IZ1JawmJd7NG7mLJg7
yZauxzEyW0sEPPFcG0tjnLGcmOfQOhm28dsG0T+05fUBS+SPArut78CmDeyxXsHz
BV2BrsupkV3HVoa2IaGFb8jyms2lng==
=BPLR
-----END PGP SIGNATURE-----

--vnl+KoOKISxFJemC--
