Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432C6FF0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjEKLsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 07:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbjEKLsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 07:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CDE2D77
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 04:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF13E64BF3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE80C433EF;
        Thu, 11 May 2023 11:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683805680;
        bh=ywt+0Zr1X76Z2OEmm1AvLswJH2dZ2KmiLgCy1lCgePo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIXskn8/TVzBMWdCoSD64b53K22Md5kU5vHlzOtuVUv+HKZy70Qxlpd2DtwUe4qC9
         7wmIgDnFLBwI+veBCJMD1jL3HFoe5fUbhewr+sRzfG+kOZpunn2/0R7Fwb16tPbtE+
         CUG5b83w6S4ZJmAMgeTg4+Zo8fgmq0i0m3NTmUwoqQ1euv9/yhB0emk7kZw4GSpvlR
         q0xXocrDTjP3989z9Lzdnq7HGxKeglApM+CVbYjZA43hgSNa+0DS0lAood/dDSX4AH
         hFxRyWX1/SwX/K96+Vw58nmC1ruqAFVcYD8X1hHUSfBcF2E2oI3UrFvKmIuFGWNlzr
         +OHeNmxiOjvTw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1px4mX-0001KH-Dv; Thu, 11 May 2023 13:48:25 +0200
Date:   Thu, 11 May 2023 13:48:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <ZFzWCey825wSlr2v@hovoldconsulting.com>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YjvbUq+RuprNibir"
Content-Disposition: inline
In-Reply-To: <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YjvbUq+RuprNibir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 12:39:23PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, May 11, 2023 at 12:18:09PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 11, 2023 at 9:34=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Many drivers that use runtime PM call pm_runtime_get_sync() or one of
> > > its variants in their remove callback. So calling pm_runtime_put_sync=
()
> > > directly before calling the remove callback results (under some
> > > conditions) in the driver's suspend routine being called just to resu=
me
> > > it again afterwards.
> > >
> > > So delay the pm_runtime_put_sync() call until after device_remove().
> > >
> > > Confirmed on a stm32mp157a that doing
> > >
> > >         echo 4400e000.can > /sys/bus/platform/drivers/m_can_platform/=
unbind
> > >
> > > (starting with a runtime-pm suspended 4400e000.can) results in one ca=
ll
> > > less of m_can_runtime_resume() and m_can_runtime_suspend() each after
> > > this change was applied.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I'm not against this change, although I kind of expect it to trigger
> > some fallout that will need to be addressed.  So caveat emtor.
> >=20
> > Anyway
> >=20
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>=20
> Thanks for your review tag. I wondered if there will be some fallout,
> and don't know what to expect yet. Sounds like getting it into next soon
> is a good idea?!

No, this seems like very bad idea and even violates the documentation
which clearly states that the usage counter is balanced before calling
remove() so that drivers can use pm_runtime_suspend() to put devices
into suspended state.

There's is really no good reason to even try to change as this is in no
way a fast path.

NAK.

Johan

--YjvbUq+RuprNibir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZFzWBQAKCRALxc3C7H1l
CEmdAP48YvGUiT2voAzj2gqP4ohmaHTEH7q7zfd6Qe6cRNqedQD8DCJURAE0CXXO
Z/Kg3dnErUpngBFKmBFtaZScllflIwM=
=+8jj
-----END PGP SIGNATURE-----

--YjvbUq+RuprNibir--
