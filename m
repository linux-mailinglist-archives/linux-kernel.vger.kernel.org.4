Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA774B1D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGGNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGGNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E01997
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28A9F61900
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C70C433C7;
        Fri,  7 Jul 2023 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688736935;
        bh=AiwiaqPWNJg66MgwIKyXQ8fE/65d0K0gg2hNk5w5wqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyXFf+PE/rucztgzpu/zExeeC2aZE3ALGtXInnMO0tNE6/hdexIFK1qYVXIZBRh1L
         DDMH9eoHniDqj3MK8CYFnGeYO0IWgS8a6zOniFgIF/C3B2mAhC+jgBqDu5lMinPgX5
         fUMVMxSzCoLmWoYgf6+nqFeTjqhhbUh10+sRLu41r1ZA4tpvt5LlZe33jtut+G20yc
         0uYHHcIBhhct0i7IPuGrk+/9XWBimMv0SD7v+xppT9Jx2WcK9BHTnrYUOou2NPZPEn
         UGfaxSd1vDCOJBRtNq3vwzkuWvoAbO/cvO91/7GfXDg2dnNIfNTz80RTZQMNgT53wg
         HbZvMZkCzDtUQ==
Date:   Fri, 7 Jul 2023 14:35:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
Message-ID: <f1041542-bd97-41d9-96b9-c6e5fef6b096@sirena.org.uk>
References: <20230705125723.40464-1-srinivas.kandagatla@linaro.org>
 <ZKfAUOOcGoBanHHu@hovoldconsulting.com>
 <efaf5960-bcc5-6d52-5552-e1505a13b635@linaro.org>
 <87y1jrkgdx.wl-tiwai@suse.de>
 <3450ef1e-cb20-4242-b482-41d3d34c4564@sirena.org.uk>
 <87wmzbkfw7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A3iaA4igre8crzyb"
Content-Disposition: inline
In-Reply-To: <87wmzbkfw7.wl-tiwai@suse.de>
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


--A3iaA4igre8crzyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2023 at 03:30:48PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > It's moderately common - typically in these cases the control is
> > described in the datasheet as an attenuation control rather than a gain,
> > and this usually corresponds to the physical implementation being only
> > able to make signals smaller relative to the reference.

> Yeah, I see the use case.  The problem is, however, that we're using
> the very same dB info for both gain and attenuation.  That means,
> application has no idea how to interpret those dB values -- to be
> added or to be subtracted.

> We should have defined a new TLV type for attenuation to
> differentiate, and define the TLV macro to give proper min/max.

The ASoC generic control stuff supports inverting the value prior to
presentation to userspace so it's masked there (instead of writing the
number userspace sees to the register we subtract the number from the
maximum value and write that to the register), pulling that up further
to the ALSA core might be nice I guess?

--A3iaA4igre8crzyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSoFKEACgkQJNaLcl1U
h9AqmQf/RFCU/P2SXEOUZ99uvePYWAioCNljKTipNMeGeHO1+6cJUPQyofxXd6Uy
GU5xG8S8GB3vvu5Rlf6w9rl1U1xNXpiZYK85G/hCtSZICIrxHc/HP2dr/gDwMCak
0Zbzx7fTNQGsgRjh0srTgdkgjOMnWBh/0I1w4/y68uW9yp/2AgMVKkvDrPz70kBo
QIfKmRYQNbPZ10S44lGd3hZlX7FiKa/DBaT+5++4eJiIvfV21K2jPrbwCkHtd3+W
i533qM9Zf58HxDQ9OyeQTCmOkdNlDoa6onrrG9SOkUkybLvqsEZoCwvj7aW/1BhM
Py+TdP3wvkyTjtJ0fH4jk603W/T5gQ==
=wwQk
-----END PGP SIGNATURE-----

--A3iaA4igre8crzyb--
