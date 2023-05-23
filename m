Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8770E037
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjEWPR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjEWPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C41A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEADA62958
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B97C433D2;
        Tue, 23 May 2023 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684854976;
        bh=riyQcmwRS50LvfDOvBnaSn1Pdsx6qcjiuaUwj4oD9K8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3ienv9QYvR22eXv7mQP4lqOeMTSsWjgQ/0LPFw3YUCN0aoUBUANjfT43qNLZf2c/
         L2eCBHlF+3l7EDTaFk6r29N8hxn6wLQ7yR5WNvNl/R1jj6jMsNbL8AC1UnwazaWjA0
         wXvCeTR5wWi3v8rIZJkhRDz3V9PEkUzSqH+s2Eo71u7TKNzwSMJ1bNwVcHFHOxyJ3n
         U6OaD9DORpKh+yJJGGlUberzFUi0FYFqkocTtqExroS/LWmG3ndvD/pHxcXdkTZvuU
         3Wl+3TR4sZ4A/TDxMUT6PV3VMwjMAp7/XaVBdo9P8Cp7kFaVmD/kU+1Bsdh7nsO3A3
         56PU2QqTaMprw==
Date:   Tue, 23 May 2023 16:16:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Osama Muhammad <osmtendev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Streamline debugfs operations
Message-ID: <2c26f143-47ae-4c2f-bd55-2e3b7a6300f0@sirena.org.uk>
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oesjpCYrzZPeXfzW"
Content-Disposition: inline
In-Reply-To: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oesjpCYrzZPeXfzW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:

> -	if (!regulator->debugfs) {
> +	if (IS_ERR(regulator->debugfs))
>  		rdev_dbg(rdev, "Failed to create debugfs directory\n");
> -	} else {
> -		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
> -				   &regulator->uA_load);
> -	}
> +
> +	debugfs_create_u32("uA_load", 0444, regulator->debugfs,
> +			   &regulator->uA_load);

No, it's actually useful to not just dump these files in the root
directory if we fail to create the per regulator directory.

--oesjpCYrzZPeXfzW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs2LoACgkQJNaLcl1U
h9CMzAf7B1M/cVgldQf+MV8yOCmHAz0pR7PVoZ4CkYyqq8BfE4QH1jT4Vn3hxoS4
y5spa1SALFIrMxhJ9bzncMgjtzjmWOdySywKZ6/szCtHlqm5n2GqlkqYfDAGGkZS
BbWdv9OhnQfNkmIrtN3/qxV//yt/h+0+3ATJxJ2NnvpAdc2FxTK+MpDYYR0JuJHF
Wjf9vpLRWW14FdboWXFzIxf9CpY+Tdw1iPBSz9BISDNjmVsWJ0tA02PXyir/1aAb
GkO29pZaNLkavhoxaHkI4sQGUk0MaeW1JmOlbWlXmJtAWmXHDHyfZCneqN2RPo1R
dvUpobtbZZvUighl/T1ruJcbgLMMQQ==
=Encs
-----END PGP SIGNATURE-----

--oesjpCYrzZPeXfzW--
