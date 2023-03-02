Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDDA6A884B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCBSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCBSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:08:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A24035A8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:08:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D837E6157C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 18:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F4C433EF;
        Thu,  2 Mar 2023 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677780526;
        bh=jzmw41TzLfX6n+F+JhK7GaN6lIZTZscm57eSTd8Ngdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3/hJdTgWu+pto4jfAakeMHgqcKZc8RbTCB1DNaqG2vznK98jPI2Zs/htudYmuAWC
         9oGlaMStrbDTEhTSuzsJHOmMNujFe+2JJNYoJ6oUDmvZWDXErORHCMOMG2m2HOqknZ
         iCSbG3NuG4RFPpvlswvqgt11sAiZauUl2ETjEO1y7SzQQ7sHgho264OYsEAWZbQMG2
         omfr2/Aqd5iGTKar+RVv8ZUrB9mW+daSQQWHQQgEv0W1UfGcs8DcWpBlfLwqRpuMWU
         ur5760JqkIRRlcKvbTJy7DoPrSTPJMZwcgcSt5dLPp/NbCd1tlt9mXxIsClrusC6NP
         Xxvp2wfjANi2w==
Date:   Thu, 2 Mar 2023 18:08:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: cs34l45: Hibernation support
Message-ID: <1f9fd2b8-f5d5-4a9c-8c52-63386c85101d@sirena.org.uk>
References: <20230302171154.2342527-1-vkarpovi@opensource.cirrus.com>
 <20230302171154.2342527-5-vkarpovi@opensource.cirrus.com>
 <8aef2c0c-9bd0-4c3a-86e1-7732ddedabfd@sirena.org.uk>
 <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bw+2Y+cFSWr2P+MI"
Content-Disposition: inline
In-Reply-To: <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
X-Cookie: Who messed with my anti-paranoia shot?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bw+2Y+cFSWr2P+MI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2023 at 11:59:05AM -0600, Vlad Karpovich wrote:
> The CS35L45 features a low-power Hibernation State. In this state, all
> register contents are lost, but the contents of
> RAM are retained. In the Hibernation State, only always-on digital functions
> to support wake-up are enabled.
> Entry to this state is achieved via the register interface (either by an
> external driver using the control port, or the
> programmable DSP). Exit from this state is triggered by activity on device
> GPIO pins, intended SPI transaction, or I2C
> transaction with intended slave address

OK, so it's essentially just a faster mechanism for bringing the device
out of runtime suspend?  I would suggest doing something in the code to
clarify that this is not the same thing as system level hibernation,
having references to hibernate in the driver is likely to lead to
confusion down the line.  I'd also include a bit more description in the
commit message too.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--bw+2Y+cFSWr2P+MI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQA5igACgkQJNaLcl1U
h9CtRwf9HCboECzM6pBl/mxSQdEdk/SfhRbi2BG8Pzo3RmLDjqY9oD09N3EE2cTQ
1hYHnGPuACevtpguasyZIz6zVFQfdtSAYUjq3Bqnk9s2heiWkAX5x3G//NejFK25
8Wr0OVtm+B7BTZChSfV/+CGEYjTseTCKJ4fr40Gme/9KwDvbW2y0qsgfTZaAVhLV
7gOkhGYLceDXJym0Ub01fDrl5l7m+MJ7QnieRE5HGFjdgxFO+rYT4aOspQyxpXW4
XYVSPgcKke7DPFHaFaRT+9dukghgdpb1Icm0lMY3lITwMsd0A+OrarWCIDdbAHWu
uiSa1M4e4xxybXdDeNqHvmczuwRLdA==
=04h1
-----END PGP SIGNATURE-----

--bw+2Y+cFSWr2P+MI--
