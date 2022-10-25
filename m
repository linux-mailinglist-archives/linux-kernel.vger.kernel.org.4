Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAE60D230
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiJYRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJYRBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDDD118764
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FAB461A36
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8019BC433D6;
        Tue, 25 Oct 2022 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666717299;
        bh=ZuJKcAQMkujH9+0prLxGhTP9jvrCsGmBnKWefprVjGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpA0LzHrgSz02sllow3ZDsWOk+g4yHqg+faYVEftNuUDM9MtAy8fPx9azP4XDlovm
         Rxx2fsTW9RUnmnrglNfbaAcpIeSEmeWX67yDyo5Mx7Wc8UtOQAiMzS79d7KEHN9QF6
         y3HkELMs2eZ5LaSNP/FR+1mp+ye5+EdXQ7zZjr96cVFIMQwd/xZnLWOIETUeHojeCy
         iyzOk+iv6xPCgPqITLTmLRd4bO4kHJ6hrMDy3aBP/HQdVLOFC2Vpzz69pqEZyW+n7P
         mc97cZ9+5/pR3WMEupCZfxgE5uqgCfoe7i4O24SvmSQLHrgsSSL4eC1XOvxC4NOwH+
         UwUnUBOhhJkRA==
Date:   Tue, 25 Oct 2022 18:01:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangkailong@jari.cn
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        motolav@gmail.com, cezary.rojewski@intel.com, mkumard@nvidia.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA/ASoC: replace ternary operator with min()
Message-ID: <Y1gWbN2/Tbf1jeL6@sirena.org.uk>
References: <3d74bcaf.5.1840fa4d439.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52xkT7tmDJB4XLjc"
Content-Disposition: inline
In-Reply-To: <3d74bcaf.5.1840fa4d439.Coremail.wangkailong@jari.cn>
X-Cookie: Your step will soil many countries.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52xkT7tmDJB4XLjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 10:56:11PM +0800, wangkailong@jari.cn wrote:
> Fix the following coccicheck warning:
>=20
> sound/soc/soc-ops.c:817: WARNING opportunity for min()

>  	kfree(uctl);
> -	return err < 0 ? err : 0;
> +	return min(err, 0);

I don't think this is a good warning, while I'm no big fan of the
ternery operator the new code is less clear about the intent than the
old code.

--52xkT7tmDJB4XLjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNYFmwACgkQJNaLcl1U
h9DnnQf46hTo5WrWkISGqW6jNIBXt5mGN0OPMV3MELnvzFgLtMs0v3kRYtPCzt8A
i2D6cV6vpswxDsakPONljDX8tHDl2BnjIU5iAlC0y6SKvkNKYTFY11+YwlmIpXzZ
G+rZO89kV4Lp2Kg9otPu7GIx0YRL5JwpatiDsObBoqUoBobAzrqnltXKAnZtYjaK
/GqYM4rOZzQaMMxVOT560lpvEBlu2H39qlYkCbt9jyobJamikptAC2i2QzncZP+0
go01VG5NcPB+1WrijzNxsNolfX0qy00KjpOsSnkbGX/AghEzwls9YGyZt5YcMmX6
b/8y5yIPxykoK3jnZ0L7/x8cY56X
=nvwK
-----END PGP SIGNATURE-----

--52xkT7tmDJB4XLjc--
