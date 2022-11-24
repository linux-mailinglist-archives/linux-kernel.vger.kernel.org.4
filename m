Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C06375E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKXKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKXKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:06:17 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12531B9F9;
        Thu, 24 Nov 2022 02:06:16 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D5B641C09DB; Thu, 24 Nov 2022 11:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1669284374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=capoMoyAoTRj+QhymNjy9DjDy54aOgbbJqtTNS98/nQ=;
        b=apDGjOxrfVjgw3aF/04OkmIsnhtrCyjo6MrJ4rcit4SWicJfR1qXNVdIuE6asqhticv22R
        M+VmZTXsmk7cSwRVDVSlbmb2xXp1Td3LXsEkJpqnka+yXADMcqikuw2OuYNZNWBDy/WNeW
        VVjbKXbc45uomNEG2UQd2yoHFVcLJxw=
Date:   Thu, 24 Nov 2022 11:06:14 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Eric Blake <eblake@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: nbd: please don't spawn 16 threads when nbd is not even in use
Message-ID: <Y39CFnRwNGBGIsCH@duo.ucw.cz>
References: <Y3y4+QqOlF00X9ET@duo.ucw.cz>
 <20221123200845.cuct5euvikqksojm@redhat.com>
 <Y36YHNVmbozzSdxH@duo.ucw.cz>
 <ccee0ff5-309c-b430-09c7-8d2081c9981d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HZjYMFTE2RCR7pyM"
Content-Disposition: inline
In-Reply-To: <ccee0ff5-309c-b430-09c7-8d2081c9981d@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HZjYMFTE2RCR7pyM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-11-24 09:17:51, Yu Kuai wrote:
> Hi,
>=20
> =E5=9C=A8 2022/11/24 6:01, Pavel Machek =E5=86=99=E9=81=93:
> > Hi!
> >=20
> > > > I see this... and it looks like there are 16 workqueues before nbd =
is
> > > > even used. Surely there are better ways to do that?
> > >=20
> > > Yes, it would be nice to create a pool of workers that only spawns up
> > > threads when actual parallel requests are made.  Are you willing to
> > > help write the patch?
> >=20
> > I was thinking more "only spawn a workqueue when nbd is opened" or so.
> >=20
> > I have 16 of them, and I'm not using nbd. Workqueue per open device is
> > okay, current situation... not so much.
>=20
> You can take a look at this commit:
>=20
> e2daec488c57 ("nbd: Fix hungtask when nbd_config_put")
>=20
> Allocation of recv_workq is moved from start device to alloc device to
> fix hungtask. You might need to be careful if you want to move this.

Can we get that reverted?

That is rather obscure bug (how many GFP_KERNEL failures do you
normally see?) and it costs, dunno, 100KB? of unswappable memory.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HZjYMFTE2RCR7pyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY39CFgAKCRAw5/Bqldv6
8vWYAJ9yQ6drFnNpEutVeHvEesUcP4FckgCgvgMVBq1JANQNm02eRF+IlRzW0uc=
=IyCl
-----END PGP SIGNATURE-----

--HZjYMFTE2RCR7pyM--
