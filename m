Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536016D50D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjDCSkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCSkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB24BC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8852761FCA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC17C433D2;
        Mon,  3 Apr 2023 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680547228;
        bh=Srg17dNP3NaApim/6laEY2JCIVbwu+qkygiafOGB1go=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=rC2SXgARn1yOrQWNIHkV1C24XtLoxNk+yhhZJBphPjO1EJqtnv0iUhgaTGDowoTBM
         5yWTn+vZ4PRzB3CN3oAlSbj1Ov+WRgcWrnF4+ZbDf3U/2yfW/xbY9A15z6Grzxo0wl
         zuqL8S27swxCmhi6YHeSoad2+gtyDY1/G3wd/vZJc5UNcTPbP892in+kTvql3RztWK
         aAP94rLGWPuSU5v5Dm3MKs8z6xqrjrAXQv2Sj/YMVSHPkE925ZWBcS+BFaJMAMgjZY
         JEp4f1sg3g0wn8XjeHCPAIsDpNrcOj1/kRivj/hCjUU5YJLYZhnOMDwskOKRL/y+do
         iK6Hswfl+ZdJw==
Date:   Mon, 3 Apr 2023 19:40:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regmap: Add maple tree based register cache
Message-ID: <149d2462-a190-4480-a501-d645a84ec1bf@sirena.org.uk>
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
 <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
 <20230403154508.qia42tyasj4vhtm5@revolver>
 <6f49fdf0-c373-46f7-89bd-f30f0fb68c15@sirena.org.uk>
 <20230403182644.uylyonu6w6l63oze@revolver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCJRLG+x40+NiNKG"
Content-Disposition: inline
In-Reply-To: <20230403182644.uylyonu6w6l63oze@revolver>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uCJRLG+x40+NiNKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 02:26:44PM -0400, Liam R. Howlett wrote:

> What you have will work.  If you need more optimisations later, then we
> can have another look.

Yeah, what's there tests out OK.  In terms of optimisation the baseline
requirement is that we have to be able to pull values out faster than
we'd be able to read them from the device so until we're working with
MMIO devices (which people do use regmap with sometimes but aren't the
common case) we can typically burn a *lot* of CPU cycles and still be
doing just fine.  The hot spots are basic read/write of an existing
cached register, then sync and initial load in of cache defaults.

--uCJRLG+x40+NiNKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrHZYACgkQJNaLcl1U
h9AUrgf/UA/wWHJU2ED6xMclVK69qf4qrvaY+h8h8VonghCw2gV1pNxQ4rAqQ1GB
i93wOAlCJQNDsGKkFK/TlAYamC/VImoZOQdFv4TOj/BHZ8BkRfCXEekBaODALZxx
dOQEdC5rqmhUAjbuB2EZBsOEKTHNwjNkmnFXHcYifgbmQ3NcuKEcUxdWa2BNyLHq
MZ0KIKgBPKMbB5gQGiI3cfNQiNG2omySomm4ipU2J2uQbv4cUy0eR9HqlbiQFmrf
0Y/qVwJbkNsIWJ8jiPxeX6FAjEYNg3Ei3D20Bam7pbc+X39LpZH8XPQuGK4Khq3g
yRP1AcqWix27Fh7V4o1zKZibq66QhQ==
=C0mB
-----END PGP SIGNATURE-----

--uCJRLG+x40+NiNKG--
