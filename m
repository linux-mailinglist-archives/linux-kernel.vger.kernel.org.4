Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DC6C7462
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjCXAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F111171
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFA9B82200
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14184C433EF;
        Fri, 24 Mar 2023 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679616877;
        bh=5e5Tzve7Dd79xcTNdzm57g5wRClxIC6OdMpghScFxOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4K7k18r848BLqhpwlEA6Ld7DoDKRrdC6Hn1idP1bo6iEJc1HHk8Qb4EgaFF4lofC
         NlLv9qe+izxpoVd/t60Fbde51YIjrTxVn6aDerhFATmBp5whR4qs2Rv+y1muClq50J
         74g1WcjvBb5ppTTghoOnBBoybaZ1us8qoUpcN0mm1cEudenxgGOUIY5O8VdYDaxGuJ
         ZitVOwScaMxguqXQu03LtHqc4g+UTKso/BxJHZDI9EZvp9n4jcJiQgeHqrgrXsmn3e
         BaMFTZPljxSHkXbi2i1pl1cBAuWUjKn2F8QQRwACbHVa24ZrsyElOAh6jCXn7BgEde
         f9VOuEik86naw==
Date:   Fri, 24 Mar 2023 00:14:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, johan+linaro@kernel.org,
        steev@kali.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Message-ID: <101cfc2d-59d7-4f37-9dd1-e83d1b803bc5@sirena.org.uk>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <5dc11c47-bae6-2f4e-4ffd-58c4f462fd68@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qr22+g/wK5Y2DBT5"
Content-Disposition: inline
In-Reply-To: <5dc11c47-bae6-2f4e-4ffd-58c4f462fd68@linux.intel.com>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qr22+g/wK5Y2DBT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2023 at 01:11:11PM -0500, Pierre-Louis Bossart wrote:

> > The trigger is run in atomic context, can you really write safely to a
> > SoundWire device there?

> Mark, I've seen that comment from you several times, and I wonder if I
> am missing something: the triggers for SoundWire managers and dailinks
> are typically nonatomic - at least for the Cadence-based solution the
> trigger is based on a bank switch that may happen with a delay and with
> a wait_for_completion(). Sending a command over the SoundWire channel is
> also typically not atomic, there's usually a wait_for_completion() as well.

Ah, you're setting the nonatomic flag on your links to disable the
locking.  The default for trigger operations is to run them with local
interrupts disabled.  It looks like at least some of the Qualcomm stuff
does that too.

--Qr22+g/wK5Y2DBT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQc62cACgkQJNaLcl1U
h9DzHQf/TIS72n0OUMiQng7OQKu/e8P+3/vOqyZs7KgpO4ZAgAj3Fh2LNTDL/ozv
8WNTHCDmF/caNspF1f+3A+4iShLnqEfAjP338hgBKfMakh+2kLZjvquv8uau41xa
Ptq6Syp6qN0kRgdgVpidwj77UwHldZUf333vlsz9zh7cb7jgCmasy76TN1OZfgyP
2eY/Y2j6+BKcAfP1DOSmguTo1h8x/nU5uLddP1bSAdFyjaD3GFgJlPJfQBPjFvFu
fTMiMqpenPGAde/jzDPrKzYBBUeP+C3KAnQy7ivVRjRCx1vjGZ7HAj8WNT0flzHF
a+d504cA5fOV3hcEYjIDjHFd1yIaWg==
=Au5o
-----END PGP SIGNATURE-----

--Qr22+g/wK5Y2DBT5--
