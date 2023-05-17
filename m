Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B620A7062D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjEQI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEQI2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEE73A9F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D46E64398
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE8C433EF;
        Wed, 17 May 2023 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312081;
        bh=gprm+aRgbmnVXxLPxkjfr9QXVB3kzbD/cWblpsfNuOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGwtSh9dv5lpSCcLDbb24d69IguiAYuQwrR9xDieFkJ2Y0lFsjQVUwViFiqWpNCcR
         OeKgZv/aZXXgJQxMOpNIl8SRaY1dpeE5Eg4ADl16t0HXK7TjnZMbHWAzh1B9iE8TbQ
         5OkVojyS76Z1WydRhKRBdBswVFb8NFyUhjeHFeU51+fjAy7uHopF5c1ztkbzD+YU+f
         drzWnlrLsEi14ZMnhze0Udo0Xi3NOrXAZmq0sUI8g0lSdu5kZAM/y/la/Q1fv3oQOb
         yWWk1jDWIWEhVo9a9Id+EtshUSqBt759f2ZtiCEGh1PvCkxnEu0Tk+zR1ZLFkLCTE6
         6E/Tw/A1udGPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzCVt-0002qK-H3; Wed, 17 May 2023 10:28:01 +0200
Date:   Wed, 17 May 2023 10:28:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after
 device_remove()
Message-ID: <ZGSQEapCl5HfQpY8@hovoldconsulting.com>
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de>
 <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
 <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
 <20230512184925.d7w3j4r7oajtpsxi@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3d0lRLJWdny4Pqi"
Content-Disposition: inline
In-Reply-To: <20230512184925.d7w3j4r7oajtpsxi@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3d0lRLJWdny4Pqi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 08:49:25PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, May 12, 2023 at 09:40:01AM +0200, Johan Hovold wrote:
> > On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 11, 2023 at 1:48=E2=80=AFPM Johan Hovold <johan@kernel.or=
g> wrote:
> >=20
> > > > No, this seems like very bad idea and even violates the documentati=
on
> > > > which clearly states that the usage counter is balanced before call=
ing
> > > > remove() so that drivers can use pm_runtime_suspend() to put devices
> > > > into suspended state.
> > >=20
> > > I missed that, sorry.
> > >=20
> > > > There's is really no good reason to even try to change as this is i=
n no
> > > > way a fast path.
> > >=20
> > > Still, I think that while the "put" part needs to be done before
> > > device_remove(), the actual state change can be carried out later.
> > >=20
> > > So something like
> > >=20
> > >     pm_runtime_put_noidle(dev);
> > >=20
> > >     device_remove(dev);
> > >=20
> > >     pm_runtime_suspend(dev);
> > >=20
> > > would generally work, wouldn't it?
> >=20
> > No, as drivers typically disable runtime pm in their remove callbacks,
> > that pm_runtime_suspend() would amount to a no-op (and calling the
> > driver pm ops post unbind and the driver having freed its data would
> > not work either).
>=20
> However if a driver author also cares for the CONFIG_PM=3Dn case, calling
> pm_runtime_suspend() doesn't have the intended effect and so it's
> unfortunately complicated to rely on runtime-pm to power down your
> device and you have to do it by hand anyhow (unless you let your driver
> depend on CONFIG_PM). So I'm not convinced that "A driver can call
> pm_runtime_suspend() to power down" is a useful thing to have.

Right, but we do have drivers that have CONFIG_PM as an explicit
dependency.

> In the end something like 72362dcdf654 ("can: mcp251xfd:
> mcp251xfd_unregister(): simplify runtime PM handling") might be an
> approach. But IMHO it's more complicated than it should be and honestly
> I'm not sure if it's safe and correct this way.

Yeah, unfortunately runtime PM is fairly underspecified so we end up
with this multitude of implementations, many of which are broken in
various ways. A smaller API with documented best-practices may have
helped, but that's not where we are right now.

Looks like 72362dcdf654 ("can: mcp251xfd: mcp251xfd_unregister():
simplify runtime PM handling") introduces yet another way to do things,
and which will break if anyone enables (or tries to use this pattern in
another driver with) autosuspend...

Johan

--u3d0lRLJWdny4Pqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZGSQDQAKCRALxc3C7H1l
CCUxAQCBMVdykLUbY8F9CWXd5BBDXfshKIcDX1jXyL2+ftKfpAD/RWsfIRH06GYz
7PlUJ/q2Y7mzBVV4JEzZlWr8lX7/+g8=
=o2gs
-----END PGP SIGNATURE-----

--u3d0lRLJWdny4Pqi--
