Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA4170E38F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjEWR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjEWRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D0E78
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D726F62D7F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7717C433D2;
        Tue, 23 May 2023 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862722;
        bh=hZem+bw/YpKsx96rrifNWNXdixYFstBba2CYEgc/T6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWQsINp88A7hoy48glJuXnfc3JCjt3kDEhepUVQ9SEyjhPvs1YBvdL0uc95t6UvrF
         tzv9SKhj8PKfs+SuaIsa+BwtolCHTKGN29n7rWBsVGs+R0clBApQ7fQOUPUTzyiBjN
         jPtMlfNp22SRQx+dFgISC34Ooe/5HcRzSmLwq3HOyNiV7RcOORbWT8HselDTw3wVBV
         FRIc9jWalv6c3qJtdsko9iz85YyL9ndqYxD8BnBgoNSphvjg/s8qVumU95MyKdR0Je
         1u5mmlmlT+l7SIU9ouh4PFUcKoVHMLLcorvnD19j6DwKlLXcSHBBeIqohKDZqFW73b
         XdkiqLtzZtl4w==
Date:   Tue, 23 May 2023 18:25:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Message-ID: <f9484905-fc8d-450a-bc52-00ba99db0d1f@sirena.org.uk>
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
 <dd2d2484-13f9-4fa6-85d2-5a540f137b3a@sirena.org.uk>
 <1f34ca48-75cc-d824-2230-7375146ad970@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oa+ySSvabEXrwp8E"
Content-Disposition: inline
In-Reply-To: <1f34ca48-75cc-d824-2230-7375146ad970@linaro.org>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oa+ySSvabEXrwp8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 06:13:25PM +0100, Srinivas Kandagatla wrote:
> On 23/05/2023 17:58, Mark Brown wrote:
> > On Tue, May 23, 2023 at 04:47:47PM +0100, Srinivas Kandagatla wrote:

> > > +	/* Only bulk writes are supported not multi-register writes */
> > > +	if (config->can_multi_write)
> > > +		return -ENOTSUPP;

> > This doesn't seem like the right fix - I'd expect us to simply choose
> > not to use multiple writes, with an additional flag/check for bus
> > support.

> Is there a way to check if bus support multi-register writes?

> All I can see from the code is that regmap can_multi_write is set based on
> regmap_config from device and write callback from bus.

No, that'd be the additional flag/check bit - see also my question about
if this is something the hardware actually has or not on the CODEC patch.

--oa+ySSvabEXrwp8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs9vwACgkQJNaLcl1U
h9C9qQf/auuUdT7K6tq7nbLMF/9lM7W/KynIXf3fmUgnWGNiCTCQ/zZTZwMuY5Ec
24PUvz8TnI/gwcFmKwzgOxvD51YTXGTcUHxB1bVv2Ol4nYh4kcULH4iTRlum71qC
D6zDXorhSconpwGee90Dlcq5Y7hX9O2bVLvyJLByfBXhsm2xR0/tt9leRuIWKIJu
PoKJtBBTUTtFUCeOLq2Uy8M9lrY5iDKVIpzJxhvf9DIeWukao/tBQSPgCbnd88sE
w/DJJ5YxrC+qBox+QgNZtbHFbxtm3RMxZJZpiraG4ti/4MxhbvuQJYzvJcGG+XkM
FRILCfhwat7ClnuVQMReWeIq7y8CYA==
=DdSa
-----END PGP SIGNATURE-----

--oa+ySSvabEXrwp8E--
