Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447546FC895
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjEIOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjEIOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:12:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABE30E9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A329E62BF4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88254C433EF;
        Tue,  9 May 2023 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683641569;
        bh=Ia9qR/V+dgyiZQmU96o1UbuUGtZdvdOBtBPw3NwRYJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2bVYeNp5yBaBNpJrq/lMcqKeH4Eu5ZbakZcYCLu6XMVFkStwkNiHguLEiQlYp1M/
         NvG480htiNEKhlHXF/+PjVDkqQQEKvRDqaae9WCbeyT658wWE4l86gD3CwjuCcwAyh
         sGQpMge9V9FLFe035uipI2fh3+USJwv1I+kaVznbbMYjY9eGP+cFguDiDBjzVk1bdo
         39WZqJSn1pANwyXLM0N/m/sYi4dMV9a8TurXCX4eylD+bVovXGEfnXueVAAmYXF2bu
         FOd5e1I7g5L+cIJw0KQtPQLzLHd2xS9/OjHNRb2GOb0l4l6wSRnxINxP4V4RTdibr0
         tUKrCP3fe5dHg==
Date:   Tue, 9 May 2023 23:12:46 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of
 bounds
Message-ID: <ZFpU3iIhoWA4oIhf@finisterre.sirena.org.uk>
References: <20230509103232.20953-1-quic_visr@quicinc.com>
 <bb67f4b0-e96a-3718-f855-80e1d21e9d38@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7MjTQKZ/juz56Sws"
Content-Disposition: inline
In-Reply-To: <bb67f4b0-e96a-3718-f855-80e1d21e9d38@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7MjTQKZ/juz56Sws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 01:26:32PM +0100, Srinivas Kandagatla wrote:
> On 09/05/2023 11:32, Ravulapati Vishnu Vardhan Rao wrote:

> >   	val = ucontrol->value.enumerated.item[0];
> > +	if (val < 0 && val > 15)
> > +		return -EINVAL;

> how about

> if (val >= e->items)
> 	return -EINVAL;

The enum value is passed as an int so is signed unfortunately.

> We could get these checks if CONFIG_SND_CTL_INTPUT_VALIDATION  was enabled.

You can't rely on that being set.

--7MjTQKZ/juz56Sws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRaVNsACgkQJNaLcl1U
h9A0Uwf/UvIT8fZeRNOkWNIfq84pL8mhWAPjeWjO0KZMX5qY6ryVzPuDQY3cuv5S
cH0vyKy12IWKEFhMwN+kM1h70iiX+Ai7STIp+6tJWJnXTGlZmpi1qwGy9yDc2Zxz
30c8CyfvhFYm3y6cJGOq/D79DABrDT1xeG1HG4/CAhFagIQBruQ9/2gnHJIhfcfx
UVGfLUmU8srAmBE/o8DyrME67anVAn5jEttqIdetnCyISSF0Svu9xyx7pM9k0WQs
nOcCE+PfRL6owkajRu+pnBpimZXX4zXmUBwcQl+KDIxexpp2eAR35OgK9KXn0kE/
lRZcSZ1/feq8gjoO/Fh6AcJghyasxA==
=qvvD
-----END PGP SIGNATURE-----

--7MjTQKZ/juz56Sws--
