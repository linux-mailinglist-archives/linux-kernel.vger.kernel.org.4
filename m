Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FD60E43F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiJZPLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiJZPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:11:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BA127BCB;
        Wed, 26 Oct 2022 08:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B869B82256;
        Wed, 26 Oct 2022 15:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C25C433C1;
        Wed, 26 Oct 2022 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666797108;
        bh=4Z5zLso9XNCBCHEEuJMM/rcAgVuqzF4fw0BCdufFO5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbUqWf/UNHlwTkNxQkTZ1K6W0GJk+JvCByByAYT51qdtLQpqEpX602AOL0P95C/sD
         CY73cmiO8ktDHurGqpaMAY5PlkDfrAfpHNGU5INpNLac6CNVx10EBPknWx0UYEMKhw
         uTuz+pKi+5Pkj3xjY4oIl/+Yrfy7yZchBQmf12bB4vvhC6AEgEprC/MI7ZUuTrNPpv
         25KGRiiF/D0PVka6WdMYU/fU1vdOwqwLLY3fsvUnMwSRnJa9MhIdlEYn3FO3EoNQX2
         3RpPu6fTs/ziU8Tz4+xVLlkQxF7eBviR8ZilkIUhv3F5R+SdneQMGdULvZc3gn0k5i
         zWRfnsWMWBuFA==
Date:   Wed, 26 Oct 2022 16:11:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
Message-ID: <Y1lOLgLNDgsmvfe5@sirena.org.uk>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <Y1Z74/vKHbnaCLrX@sirena.org.uk>
 <XaoRSEMyUlabAR8wEJITmm2lGCjwfPZg@localhost>
 <Y1fCfej+/WH8TI39@sirena.org.uk>
 <FgO8Xz5MtaEBdBidpT8So4X5posjL95Y@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="STgcsZayb3dhE5DX"
Content-Disposition: inline
In-Reply-To: <FgO8Xz5MtaEBdBidpT8So4X5posjL95Y@localhost>
X-Cookie: Prunes give you a run for your money.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--STgcsZayb3dhE5DX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 03:42:31PM +0100, Aidan MacDonald wrote:
> Mark Brown <broonie@kernel.org> writes:

> > There is a strong case for saying that all the clocking in CODECs might
> > fit into the clock API, especially given the whole DT thing.

> The ASoC APIs don't speak "struct clk", which seems (to me) like a
> prerequisite before we can think about doing anything with clocks.

Right, they probably should.

> Even if ASoC began to use the clock API for codec clocking, it's not
> clear how you maintain backward compatibility with the existing
> simple-card bindings. You'd have to go over all DAIs and mimic the
> effects of "snd_soc_dai_set_sysclk(dai, 0, freq, dir)" because there
> could be a device tree relying on it somewhere.

Of course, you'd need to define bindings for devices with multiple
clocks such that things continue to work out compatibly.

> So... given you're already stuck maintaining .set_sysclk() behavior
> forever, is there much harm in exposing the sysclock ID to the DT?

Yes, it's ABI and the more baked in this stuff gets the more issues we
have when trying to integrate with the wider clock tree in the system -
for example when devices are able to output their system clock to be
used as a master clock for a device which can use the clock API as an
input.  It's fine in kernel but we should be trying to keep it out of
ABI.

--STgcsZayb3dhE5DX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZTi0ACgkQJNaLcl1U
h9D/qgf/YOsJbQ4nQ75FNpRwHXAqvJR2rYBAW8fcMr3YrbLRTFOb03bpLFqa26nB
tfJdkMrYr61OwPJY57vjlxoEJjSgdMHNuk7wB/Jo+n1PoPiHTg2SiLVbbG/pOqfw
iENggEi02xvC4zGMmdEqzewObfbACRu0ZdIeKl4cXmFarL4/INkruO9WgABAFjtF
ER7DoDv7Klfk28I6fP49gzEGIV8Omn6qHViJkz4fcrPbGpQcJzJtLU45amKZi/Eu
NAy0T5bI48u/fcOZYup5lQYK/QyOb7XiI5CjLnd/MOjsBUjzUlukyeKnD/RLT6o2
Sd7w6TFggE4pjNnE6GfxQ15P+Iw1Rg==
=hC+q
-----END PGP SIGNATURE-----

--STgcsZayb3dhE5DX--
