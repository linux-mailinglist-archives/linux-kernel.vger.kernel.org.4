Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F796D0988
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjC3P2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjC3P1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:27:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92778C679;
        Thu, 30 Mar 2023 08:27:25 -0700 (PDT)
Received: from mercury (dyndsl-091-248-191-116.ewe-ip-backbone.de [91.248.191.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B398866030CD;
        Thu, 30 Mar 2023 16:26:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680189980;
        bh=b8BFbDxlmYytLZ0QnDA04VtQavFxFlJBUUjl2Zq+y4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgcabsnyEs+YRnB9DrSuVJG76rhjme+YMIeghLJUXySMkMRbTlkRaU88/Y1tAJsZv
         hsIPDR/ddOO3WdZzFLpppQWN0xVyp1gwn3k5EEp7m7FAHMEsLEGOoOWMlqK1WBSJ5p
         t+lbvrwqstI7vMt4eZss8GEr06/Vt4KVf7CRwcCtetFoztOsjW/1nF/4Av9qsu7SCS
         m4nB6SXSnaSpEgBclRmHBWu/CLNjHQvGkKh3I877viqoLNjgqRsat2++KP7QKb0PPe
         bU0TbO/ej0xYD713PXy2mOJEADsSCNAZfilphQ5LtS7J8p+jidgJo1Ov4pU6VTJnGn
         fq6UU7kG8/ewA==
Received: by mercury (Postfix, from userid 1000)
        id AC0301062717; Thu, 30 Mar 2023 17:26:17 +0200 (CEST)
Date:   Thu, 30 Mar 2023 17:26:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20230330152617.6zj5llx5pf6mlv2t@mercury.elektranox.org>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
 <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
 <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
 <2f4967f2a079e23b2b8a6013012c66e0.sboyd@kernel.org>
 <20230330060601.6mo7b4ecd2sk5mdr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4t4y27tmdb2m2ofs"
Content-Disposition: inline
In-Reply-To: <20230330060601.6mo7b4ecd2sk5mdr@pengutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4t4y27tmdb2m2ofs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 30, 2023 at 08:06:01AM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Mar 29, 2023 at 02:27:08PM -0700, Stephen Boyd wrote:
> > Quoting Uwe Kleine-K=F6nig (2023-03-29 13:46:32)
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index c3c3f8c07258..356119a7e5fe 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > [...]
> > > > > @@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_sub=
tree(struct clk_core *core)
> > > > >          * back to .disable
> > > > >          */
> > > > >         if (clk_core_is_enabled(core)) {
> > > > > -               trace_clk_disable(core);
> > > > > -               if (core->ops->disable_unused)
> > > > > -                       core->ops->disable_unused(core->hw);
> > > > > -               else if (core->ops->disable)
> > > > > -                       core->ops->disable(core->hw);
> > > > > -               trace_clk_disable_complete(core);
> > > > > +               if (clk_unused_keep_on) {
> > > > > +                       pr_warn("Keep unused clk \"%s\" on\n", co=
re->name);
> > > > > +                       clk_unused_keep_on -=3D 1;
> > > > > +               } else {
> > > > > +                       trace_clk_disable(core);
> > > >=20
> > > > We have trace_clk_disable() here. Can you have this tracepoint prin=
t to
> > > > the kernel log and watch over serial console? That would be faster =
than
> > > > bisecting.
> > >=20
> > > Well no, that doesn't work for all the problems where
> > > clk_ignore_unused=3D7 could be useful. Consider that e.g. you know th=
at
> > > eth0 is broken, but with clk_ignore_unused is works. So one of the (s=
ay)
> > > 25 nominally unused clks are required for eth0. But it's not possible=
 to
> > > test the network after each of the 25 clk_disable()s. Unless I'm miss=
ing
> > > something and you can hook a userspace action on a trace line?!
> >=20
> > In that case it sounds like you want to compile the kernel with the
> > support for enabling clks from debugfs. Can you use that?
>=20
> In some of the cases that might work. Unless for example the problem
> makes the kernel fail to boot or the device is broken when the clk was
> disabled and reenable doesn't help?!

I recently debugged a similar issue like this:

1. build kernel with CLOCK_ALLOW_WRITE_DEBUGFS
2. boot with clk_ignore_unused, so clocks stay enabled
3. disable clocks via sysfs:
   echo 1 > /sys/kernel/debug/clk/${CLK}/clk_prepare_enable
   echo 0 > /sys/kernel/debug/clk/${CLK}/clk_prepare_enable
4. check if peripheral is still ok
5. repeat step 3 with the next 'interesting' clock

-- Sebastian

--4t4y27tmdb2m2ofs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQlqhIACgkQ2O7X88g7
+ppqHw/+OdRrES3M3CO43e8OqvDC9wqhevdLaEYJEqY7/vbrb4Vq3h8Wbb4DWfJj
iWLNR3TUsWIGQ95b6SGTJCQarLBgRIeEln+YN5nyRc7bYfrjLboNfCxo4dHhjbgl
u2ZYY7kYdT9oyXvBx5WushvIUxRe687yxfQqHUMoBi0MjDD/+WjBZDQ0q1w5ZQWb
ySpmlbMGa8md9HmxIQmUSGD1t5B7y8KCYHQPYO/YJoosTe6jrRksdP56JRVwj2Gj
zr5jJ2rPLI/Xk2604rK/GQPKUebFHPcrYzotNjNyOuwEVRtA3qGOKiI/IJFkozpE
oG05WALoD42Zt9NapQOeysMJQErAbIpZEYsF8+/sj7SzJfRCALEcvYPYCbwubf6W
/ZSkxZFZyz4cyY6vvHTZ1xZfQdrBDmHgYnf8l4Iu2zT7dWJB2ZSUoHMwZVqBeGze
MG0cHB1yApfedJrP29UMnaFTG2GeBDW3lgYTkYdODn+jCoRyneCceodx1LBpEA2z
sLMr8M/yf60ZB6+RPrqP0jQAFlD/dj+VVwaqIIAomQJSCLd5yKm6faVlOOagMwhI
OaCdg1JMa2wwetu7zyfgATNSC9Bmub7d9swYwdNN6GSIZvvttM2IFG2Fv5mapP4+
qpO6Jtm6duP6uDbf91V79JVvML6HMEeo6m7WdtkF1gpcdZguEX4=
=888j
-----END PGP SIGNATURE-----

--4t4y27tmdb2m2ofs--
