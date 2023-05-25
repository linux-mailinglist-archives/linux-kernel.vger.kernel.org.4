Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE61711132
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjEYQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEYQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B1189;
        Thu, 25 May 2023 09:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D0C2646B9;
        Thu, 25 May 2023 16:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7945FC433EF;
        Thu, 25 May 2023 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685032971;
        bh=uGxy6H+pCSJEnDYbsR3lG5H09d4tgBzCRQCa4JaGbNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5rt4jNbzIUC+MpkCgJj04EW1vICNd21Qr9kCYTpo6AgzCOgXLRh/+vZTjAQQmWBa
         vA1JV2KMtzaEiDPlpJsX4ayE6AGW7WX/9+CB2ghTklXvKukFgURfFsnBf7CyeWvthI
         RSgIls18JG5yZ+fQzm6DaJPMDwde7FWetxkALORYXBq2tAUSkxkwIGvZdF6lAHXXhr
         V0dA7m9cyXDf7pMDoVxqjlR0ojqAP9bDCMwsGGu9tEzMiAM9GjDGSpz/tIJ5xPoaev
         JpPF+d4iF8ArKoNHPaiSQIeAJLQcksZRp2xGsqcICVSMTn5tWkJCOdbDES3LAqacH2
         bEwzh/JIuA1oA==
Received: by mercury (Postfix, from userid 1000)
        id B91CC1060A3F; Thu, 25 May 2023 18:42:48 +0200 (CEST)
Date:   Thu, 25 May 2023 18:42:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [BUG 6.4-rc3] BUG: kernel NULL pointer dereference in
 __dev_fwnode
Message-ID: <20230525164248.wsmyzsv5iwwswntz@mercury.elektranox.org>
References: <20230524131200.0f6fb318@rorschach.local.home>
 <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lcf2jwn42whcpcd3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNagW7exChQ4YuiRpCDN=kxmUdY5u7ebFux1jgEoL2tg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lcf2jwn42whcpcd3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 11:28:41AM -0700, Linus Torvalds wrote:
> On Wed, May 24, 2023 at 10:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > I started adding fixes to my urgent branch rebased on top of v6.4-rc3
> > and ran my tests. Unfortunately they crashed on unrelated code.
> >
> > Here's the dump:
> >
> >  BUG: kernel NULL pointer dereference, address: 00000000000003e8
> >  RIP: 0010:__dev_fwnode+0x9/0x2a
> >  Code: ff 85 c0 78 16 48 8b 3c 24 89 c6 59 e9 e0 f7 ff ff b8 ea ff ff f=
f c3 cc cc cc cc 5a c3 cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 <48> 8b 87 e8=
 03 00 00 48
> >  83 c0 18 c3 cc cc cc cc 48
>=20
> That disassembles to
>=20
>     endbr64
>     nopl   0x0(%rax,%rax,1)
>     mov    0x3e8(%rdi),%rax
>     add    $0x18,%rax
>     ret
>=20
> which looks like it must be the
>=20
>     return dev->fwnode;
>=20
> with a NULL 'dev'. Which makes sense for __dev_fwnode with CONFIG_OF
> not enabled.
>=20
> Except I have no idea what that odd 'add $0x18" is all about. Strange.
>=20
> Anyway, the caller seems to be this code in power_supply_get_battery_info=
():
>=20
>         if (psy->of_node) {
>             .. presumably not this ..
>         } else {
>                 err =3D fwnode_property_get_reference_args(
>                                         dev_fwnode(psy->dev.parent),
>                                         "monitored-battery", NULL, 0, 0, =
&args);
>                 ...
>=20
> so I suspect we have psy->dev.parent being NULL.
>=20
> >  I ran a bisect and it found it to be this commit:
> >
> > 27a2195efa8d2 ("power: supply: core: auto-exposure of simple-battery da=
ta")
> >
> > I checked out that commit and tested it, and it crashed. I then
> > reverted that commit, and the crash goes away.
>=20
> At a guess, it's
>=20
>  (a) the new code to expose battery info at registration time:
>=20
> +       /*
> +        * Expose constant battery info, if it is available. While there =
are
> +        * some chargers accessing constant battery data, we only want to
> +        * expose battery data to userspace for battery devices.
> +        */
> +       if (desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
> +               rc =3D power_supply_get_battery_info(psy, &psy->battery_i=
nfo);
> +               if (rc && rc !=3D -ENODEV && rc !=3D -ENOENT)
> +                       goto check_supplies_failed;
> +       }
>=20
> interacting with
>=20
>  (b) the test_power_init() that does that
>=20
>                 test_power_supplies[i] =3D power_supply_register(NULL,
>                                                 &test_power_desc[i],
>                                                 &test_power_configs[i]);
>=20
> which passes in NULL for the "parent" pointer.
>=20
> So it looks like a dodgy test that was a bit lazy. But maybe a NULL
> parent is supposed to work.
>=20
>                 Linus

I have a fix for that in my fixes branch, that I planned to send
this week:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfixes&id=3D44c524b642996148a8e94f1a1b8751076edcf577

-- Sebastian

--lcf2jwn42whcpcd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRvj/QACgkQ2O7X88g7
+pr9EQ/+IMhxE5+7cMcUAd4+ZqR9S8AVtNsgJufS4VAoVynHP9SkMljW21oG0Oji
TQUUFmEICPb6+hh2XQeEmMBMSOjKVCiMss42I4pi16viuwZC/34EYrH8z6K1Rn+y
PctcLbX0DOljBhSS1YUg3aGE512/ILjOllGC6M/SaFEa1Qqpza3fUA4DN0rNklvw
Eh+2PDqVl0ds6o+ZUhWNaUX7w+Ku59hZAc48YWf/Z6HNVxnNb1dP7ERzEoLXz4xR
K0aIx/fSlWvXFtGo1k/2xzLcuDG5qHnRA3A61Rk7xsZp+hqhgZ2OHvlw8n/NhPbW
9tTphmI3Gj2Ag91KbxR7sEfrBOfzQz3yiH/jdKQsa4TB0YmArMYRXSRLmoI91+X+
O9n6BXp9PgFn1YHt6jw8W21pFs/N4AbIiDj1fIu0pGU0dpypT1V0IwzY8c7lNv6h
ZRxHDMkcG9QKYIXA33NFItWh6fMKB9Pl+6w7TEyZ/kCgcSmYu3c6jd8wJnnfyozw
n2x7GsbXH9WJZk2d28QYdDFtb9pCFP/B5rSReo0C+oLaQK51uUOAMLYcjz+NWzu4
dlvFTpd0zAka5NPrr66ew4nXimOpbBwLXvo1GX+5F6oWQt9hWZFzO2eIlJe23vwC
xDdF2efSKEqnE8SysJ99LlKsAXuZNbjMNM2EBB3GimawakNU+jA=
=EAcj
-----END PGP SIGNATURE-----

--lcf2jwn42whcpcd3--
