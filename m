Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B24174B1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGNW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB90131
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24B2619A0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1990C433C7;
        Fri,  7 Jul 2023 13:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688736171;
        bh=NHCxkwb/m5V0S7DCsQ1y4xdBpD1W9GlLedhbup59uxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTi+H3WdfHPM9Byxcm2uOHye+pl0xSXW+NfUsQ2T1zjOFGAvJdUSuxZTA/NL7BxrV
         fmc5hIq2P1DY6FKKo4OLqdf7zMj0GhlBpQSe8CbmAgz6k7lQzWOIV0dvsg9gY4nj/b
         fe5qRdVwrg/cT18TVNUNYkRGo+aaQCRjq//shCKUoW7NlcBfa+VSO6mcsouBmp+r/Z
         xsZ5a6S2HYt6Ma3/6Brph4A4s8SR6dYCsVo4ALeyVsR9YvkCTcz/LBv0BScgRl6z8G
         GiL0BTmgsyY3V2VyaCZWzRhXNLwQXC5+tRftUA4asvU19qN3Fvm2VekpjfWSUZs6wf
         mS/YMTZmyuJHw==
Date:   Fri, 7 Jul 2023 14:22:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <3450ef1e-cb20-4242-b482-41d3d34c4564@sirena.org.uk>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
 <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
 <87y1jrkgdx.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wVyCaq/6JTHUGMD"
Content-Disposition: inline
In-Reply-To: <87y1jrkgdx.wl-tiwai@suse.de>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5wVyCaq/6JTHUGMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 03:20:10PM +0200, Takashi Iwai wrote:
> Srinivas Kandagatla wrote:

> > yes, the highest value corresponds to lowest dB which is why its inverted.

> Ouch, that's a bad design choice...

It's moderately common - typically in these cases the control is
described in the datasheet as an attenuation control rather than a gain,
and this usually corresponds to the physical implementation being only
able to make signals smaller relative to the reference.

--5wVyCaq/6JTHUGMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoEaUACgkQJNaLcl1U
h9CsMwf/SZvOJmKt2vqSP+P7xpCmdnZuh5IZm0EUCIEuuA293OaTfe1+amJOiCPB
/wIC4KaE4nYOKYq7VltaO9ytlJuUPbTgYSJDaLuA/N54rNmkhc5LPUfpb1U7vhUS
PtFvtPDhHdiEgSAUHMJ+hFg3+dacjO39J/5X/8mhVJQefrSK7wZRfuaiBbhgxIpU
AKRTLYxDE8wAQwoRmPqpfTOQaDZ3FJ88FeK0LBtVwCPc0jVEXzIE8zUanWxXeNZv
riUd4goWN9XLteCM9iFu2WlCrPVrTwJj0ICAGOJMxHM3SpACSu9GAn9JIy8aDaR3
LpUiI3ukZByAEAt6HOo/dh20Hl5aLA==
=BUAJ
-----END PGP SIGNATURE-----

--5wVyCaq/6JTHUGMD--
