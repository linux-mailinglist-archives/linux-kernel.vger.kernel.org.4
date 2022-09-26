Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32585EB1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIZUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIZUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:15:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2619E6A9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:15:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1ocuW0-0002DA-Uu; Mon, 26 Sep 2022 22:15:44 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1ocuVx-0002lJ-W9; Mon, 26 Sep 2022 22:15:41 +0200
Date:   Mon, 26 Sep 2022 22:15:41 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] uvc gadget sg performance issues
Message-ID: <20220926201541.GH20022@pengutronix.de>
References: <20220926195307.110121-1-w36195@motorola.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <20220926195307.110121-1-w36195@motorola.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan!

On Mon, Sep 26, 2022 at 02:53:06PM -0500, Dan Vacura wrote:
>
>Hello uvc gadget developers,
>
>I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
>controller and I'm encountering two problems related to the recent perform=
ance
>improvement changes:

What's about that odd kernel number. UVC is under heavy development, if
you plan to work with this code, you should probably test top of tree.

>https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-=
5-m.grzeschik@pengutronix.de/  and
>https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16762-=
6-m.grzeschik@pengutronix.de/
>
>If I revert these two changes, then I have much improved stability and a
>transmission problem I'm seeing is gone. Has there been any success from
>others on 5.15 with this uvc improvement and any recommendations for my
>current problems?  Those being:
>
>1) a smmu panic, snippet here:=A0
>
>    <3>[ =A0718.314900][ =A0T803] arm-smmu 15000000.apps-smmu: Unhandled a=
rm-smmu context fault from a600000.dwc3!
>    <3>[ =A0718.314994][ =A0T803] arm-smmu 15000000.apps-smmu: FAR =A0 =A0=
=3D 0x00000000efe60800
>    <3>[ =A0718.315023][ =A0T803] arm-smmu 15000000.apps-smmu: PAR =A0 =A0=
=3D 0x0000000000000000
>    <3>[ =A0718.315048][ =A0T803] arm-smmu 15000000.apps-smmu: FSR =A0 =A0=
=3D 0x40000402 [TF R SS ]
>    <3>[ =A0718.315074][ =A0T803] arm-smmu 15000000.apps-smmu: FSYNR0 =A0 =
=A0=3D 0x5f0003
>    <3>[ =A0718.315096][ =A0T803] arm-smmu 15000000.apps-smmu: FSYNR1 =A0 =
=A0=3D 0xaa02
>    <3>[ =A0718.315117][ =A0T803] arm-smmu 15000000.apps-smmu: context ban=
k# =A0 =A0=3D 0x1b
>    <3>[ =A0718.315141][ =A0T803] arm-smmu 15000000.apps-smmu: TTBR0 =A0=
=3D 0x001b0000c2a92000
>    <3>[ =A0718.315165][ =A0T803] arm-smmu 15000000.apps-smmu: TTBR1 =A0=
=3D 0x001b000000000000
>    <3>[ =A0718.315192][ =A0T803] arm-smmu 15000000.apps-smmu: SCTLR =A0=
=3D 0x0a5f00e7 ACTLR =A0=3D 0x00000003
>    <3>[ =A0718.315245][ =A0T803] arm-smmu 15000000.apps-smmu: CBAR =A0=3D=
 0x0001f300
>    <3>[ =A0718.315274][ =A0T803] arm-smmu 15000000.apps-smmu: MAIR0 =A0 =
=3D 0xf404ff44 MAIR1 =A0 =3D 0x0000efe4
>    <3>[ =A0718.315297][ =A0T803] arm-smmu 15000000.apps-smmu: SID =3D 0x40
>    <3>[ =A0718.315318][ =A0T803] arm-smmu 15000000.apps-smmu: Client info=
: BID=3D0x5, PID=3D0xa, MID=3D0x2
>    <3>[ =A0718.315377][ =A0T803] arm-smmu 15000000.apps-smmu: soft iova-t=
o-phys=3D0x0000000000000000
>
>    I can reduce this panic with the proposed patch, but it still happens =
until I
>    disable the "req->no_interrupt =3D 1" logic.
>
>2) The frame is not fully transmitted in dwc3 with sg support enabled.
>
>    There seems to be a mapping limit I'm seeing where only the roughly fi=
rst
>    70% of the total frame is sent. Interestingly, if I allocate a larger
>    size for the buffer upfront, in uvc_queue_setup(), like sizes[0] =3D
>    video->imagesize * 3. Then the issue rarely happens. For example, when=
 I
>    do YUYV I see green, uninitialized data, at the bottom part of the
>    frame. If I do MJPG with smaller filled sizes, the transmission is fin=
e.
>
>    +-------------------------+
>    |                         |
>    |                         |
>    |                         |
>    |      Good data          |
>    |                         |
>    |                         |
>    |                         |
>    +-------------------------+
>    |xxxxxxxxxxxxxxxxxxxxxxxxx|
>    |xxxx  Bad data  xxxxxxxxx|
>    |xxxxxxxxxxxxxxxxxxxxxxxxx|
>    +-------------------------+
>
>
>Appreciate any thoughts or feedback related to these issues.

Anyway, this is probably due to the frames being given back to early to
the frameproducer. We have the following patches mainline now to fix this i=
ssue:

aef11279888c00e1841a3533a35d279285af3a51 usb: gadget: uvc: improve sg exit =
condition
9b969f93bcef9b3d9e92f1810e22bbd6c344a0e5 usb: gadget: uvc: giveback vb2 buf=
fer on req complete

You might need some patches beforehand to get them applied on your
stack.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmMyCGoACgkQC+njFXoe
LGRTOxAAqBLJmzmap4ZqZBd/5aEiOH053uIyxCqo6KaugcuhKc2834bUh2Ic2lPc
y970WiEhleorwjHgb9qKEc2hHpvz9jlnA1AxG2gL2hM4QH56oQMZy/zFuVNtd877
FS796+HDhoGDjmZwXLfV3Jiid6C51R8G5KOyyWBDXlBLvz7TMX5OQv63SyJJuHHf
PPUoBkJ3fqhWVU7wMF2KN3wkygkxpI/4Awlsq1W2dX80ot+EnkD+lUceDRiQCxbt
BbIV0yKPmnow2PbwY/ToigeJ75ZB+yoW1FT+S871eYSTivwcf0FrRidMBCjt2emT
v5NyRVXW4l2huo/BokMI7e9B/ALfk7ZLUqSOQ+eNmDbsKTNVE6VdfRS2Ea1xfFQV
NuuupimylG1gliXxXiAnr8JlA9RJvj2yj1FmIoclgDE/Brc553Prx0B4krqVW4lX
ZJZw4RWhqEbOYkdLeHqj/r7dbjJUIQ40FSsKWI9rqX+zrNlIc4wdCH5D/UAzChVU
9NmAYb6hJ6LEu7Mlpa/EfdtALikTAp0TrPQvF/aGUfqAWrdTjgwsNOMTtWGnNjcV
oO4gtWI1HG6FmPXxg1f4JSycfSL45v7dErnWSc70w18J7D8CS8CC7IZhwBFlEN55
V/IXwLPY9QjLDqRvJevIkWIcDLuO56n2sBvn0cdbVzS0Ab8R3Po=
=bcQ0
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
