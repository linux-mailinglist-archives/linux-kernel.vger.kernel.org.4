Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D94A70E5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbjEWTlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjEWTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68711A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A8D635F9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D8EC433EF;
        Tue, 23 May 2023 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870894;
        bh=0k+c3qp+hT/FnTIabF/tvyr485sFCPqurohdQ1Wmvg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTWYaq3hcBNFbJEBhhlcfrhVNacPYmQemdO5J2oJyFCamj+S9mFXmcLKNMQ4veADS
         Xh6Az6Ex1dQfeonR2xlXbtxBqnY4UUBlK62T+6JLln+YzuvwbJ8ujowyug7b0L7DsO
         we9q1cH+VMYZ8W/9YqcnAFGGvAuZ6XGgoFHdXtut2xEAvmu++lAWxDsm9JzgPawolK
         garDBhdL3brQxCRzbMj1yxZkmF67RAm4zH7VwqOZ0JE1L40AA8/HY2uTQyEFghVYVJ
         JiMKre9XPM0ByACQ16d0CZIGB3YmSR8Rto9bCXhp2as6lpyK4BcDKFAqlrmQDWl5ad
         /ejcOqyGF4aVQ==
Date:   Tue, 23 May 2023 20:41:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5682: Use a maple tree based register cache
Message-ID: <92ec3b6d-999e-4b35-8bce-b0213824eb63@sirena.org.uk>
References: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
 <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkDjINFkwfZZX0BZ"
Content-Disposition: inline
In-Reply-To: <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
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


--FkDjINFkwfZZX0BZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 02:24:53PM -0500, Pierre-Louis Bossart wrote:

> I don't see any other changes to this codec driver and the first problem
> detected seemed to happen when we did an upstream merge last week.
> Unfortunately the last merge was on April 24 (sof-dev-rebase-20230424)
> which is just the day before this commit was added...

Try this:

=46rom 5953e9de359674ff2d95fe4c241bc7880d6d0d82 Mon Sep 17 00:00:00 2001
=46rom: Mark Brown <broonie@kernel.org>
Date: Tue, 23 May 2023 20:40:22 +0100
Subject: [PATCH] regmap: maple: Drop the RCU read lock while syncing regist=
ers

Unfortunately the maple tree requires us to explicitly lock it so we need
to take the RCU read lock while iterating. When syncing this means that we
end up trying to write out register values while holding the RCU read lock
which triggers lockdep issues since that is an atomic context but most
buses can't be used in atomic context. Pause the iteration and drop the
lock for each register we check to avoid this.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/reg=
cache-maple.c
index 2d2d5d7ee447..14f6f49af097 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -203,15 +203,18 @@ static int regcache_maple_sync(struct regmap *map, un=
signed int min,
=20
 	mas_for_each(&mas, entry, max) {
 		for (r =3D max(mas.index, lmin); r <=3D min(mas.last, lmax); r++) {
+			mas_pause(&mas);
+			rcu_read_unlock();
 			ret =3D regcache_sync_val(map, r, entry[r - mas.index]);
 			if (ret !=3D 0)
 				goto out;
+			rcu_read_lock();
 		}
 	}
=20
-out:
 	rcu_read_unlock();
=20
+out:
 	map->cache_bypass =3D false;
=20
 	return ret;
--=20
2.30.2


--FkDjINFkwfZZX0BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRtFugACgkQJNaLcl1U
h9CWcgf9EaTd3BkCsWHJcyaj9CFfx161IAItun5Zers1a7vr2zo5DqQS8H9F2ROL
oGxOS9shq4q7MFCP0HDlLnI3UI+IkTUZruC777xkOc2mlbsWYGsXIPiaGuCuuUvH
2iZi9Fl+LPNVCQKMp7aqzSa7atoR34PVvFESsUALPjW9Rqd/y9O5E5XkCf/Nls5Q
zTfQ+QaTXuBjYgqEEpp6PEY6jug5OJmkjJ+qLBZ2qVgkeDFIyjti0kh/+68sAPwh
gTHldc2idDqnNAiAqznJ5djh7gMXdolT1RBM+YG1DK6nKrgIB1gpIiy70e0WWcFD
QXU1H6k0ROA8RdfaJqOxLYyiR++joQ==
=zZvr
-----END PGP SIGNATURE-----

--FkDjINFkwfZZX0BZ--
