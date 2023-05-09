Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F796FBF81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjEIGqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjEIGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C349F19B1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 611E462A94
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C032C433EF;
        Tue,  9 May 2023 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683614792;
        bh=wLct1GIrBzmusyn7tpdRRrCtoSUnA5Mtanl3erWwjsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYGiL1hJTtkcNwiDVZihNcZxnZqffPgwVH4PXfAptpqKfALqiwqpjJd2HmZc3qA4w
         uOXIsmGdZCb/t30uRDlYRI5Ne1A6EzLwJsK5gUKaZSbWx+0KyQMDaENrugjjpLR4yz
         QFUZBJcAlRsiYWrGhcIKy67HxPqfyICxTEo5qwALXsWrsDDexcNk3m6jNyBTEnuG5m
         3IT92DXLBK4XxeIthvnKc3PMXhBzFQWVpxvociUUTGmxsKkloXoWeOFZYs1xH3TC0r
         X+pxnquOwpxU1rOQ38Cy9OquLiZzFyCI1SdiKwb+fyH/oDCPWJJ4FHag6WiC/H6v1T
         Khnpr8TxcP4Lg==
Date:   Tue, 9 May 2023 15:46:28 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC:codecs: lpass: Fix for KASAN use_after_free out of
 bounds
Message-ID: <ZFnsRJXEbajKxj3h@finisterre.sirena.org.uk>
References: <20230509061321.10218-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="POkgUCpmy5u6zSNw"
Content-Disposition: inline
In-Reply-To: <20230509061321.10218-1-quic_visr@quicinc.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--POkgUCpmy5u6zSNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 11:43:21AM +0530, Ravulapati Vishnu Vardhan Rao wrote:

>  	val = ucontrol->value.enumerated.item[0];
> +	if (val < 0 && val > 15) {
> +		dev_err(component->dev, "Wrong value for DMIC configuration");
> +		return -EINVAL;
> +	}

This allows userspace to spam the system logs, no error should be
printed for something like this which can be trivially triggered from
userspace.

--POkgUCpmy5u6zSNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRZ7EQACgkQJNaLcl1U
h9DGcwf/cfo6G4f8hDzAGovnhM81PX6MSVusLCjspfaSjJvji4mpziG1QYfILtfZ
vX6/VfNu7+S1899tLmMyvV3nvbho8qQ6NbuV1JXtpgcRtZn4sr8BDkS1oECDGXUc
Ene58kkNvOOMHjwHR4Mm4MQJ/TY2mdoxBxesgj2qs6b8xvjbAVE+7In6FqzA8BuX
mOuKyde/h/Hitgld6a45RHIlP/sOatN/+e5Zmu3xuDFS6YAqgS2vOtP4Y5gm5SGN
ayZ+JNjsgQ7kYXEq6xB0fqSGhq6Cvja73Pq9FfNX2EqIATM/MIXBo6vTx5TAVHBb
t5cW6F8Wo+zoKe1BGoVt0h6d54mWOQ==
=ktQ6
-----END PGP SIGNATURE-----

--POkgUCpmy5u6zSNw--
