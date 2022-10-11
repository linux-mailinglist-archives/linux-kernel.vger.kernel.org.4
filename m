Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F515FBB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJKTs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJKTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:48:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E09882865
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:48:25 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oiLEY-0005oM-LO; Tue, 11 Oct 2022 21:48:10 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oiLEW-0002YF-O8; Tue, 11 Oct 2022 21:48:08 +0200
Date:   Tue, 11 Oct 2022 21:48:08 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/3] uvc gadget performance issues
Message-ID: <20221011194808.GH27626@pengutronix.de>
References: <20221011183437.298437-1-w36195@motorola.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <20221011183437.298437-1-w36195@motorola.com>
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


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan!

Thanks for the patches.

On Tue, Oct 11, 2022 at 01:34:32PM -0500, Dan Vacura wrote:
>Hello uvc gadget developers,
>
>Please find my V2 series with added patches to disable these performance
>features at the userspace level for devices that don't work well with
>the UDC hw, i.e. dwc3 in this case. Also included are updates to
>comments for the v1 patch.
>
>Original note:
>
>I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
>controller and I'm encountering two problems related to the recent perform=
ance
>improvement changes:
>
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

This actually smells very much like an race between hardware and
software, that is probably working on the same memory. I would guess
that the hardware in the non interrupt case is currently processing
queued memory, while at the same time the software stack will update
that same memory with new data.

In my opinion this should be fixed, rather then making the interrupt
load optional. Also we could discuss if an option to adjust the load
adds some extra value, but out of this issue scope you describe here.

Also, is this issue also being more likely to happen when streaming YUYV?

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

I did not stream with YUYV for some time. I will do that and try to
reproduce the issues you describe.

I also have an patch in the queue that will limit the sg support for
devices with speed > HIGH_SPEED. Because of the overhead of the limited
transfer payload of 1024*3 Bytes, it is possible that a simple memcpy
will actually be fast enough. But for that patch I still have to make
proper measurements. Btw. which USB speed are you transferring with?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmNFyHYACgkQC+njFXoe
LGQKWBAAvw/j89tD3kjwqyxfWnaTZeBB+9XOhwQ8PNHbGYKS1zuq+cWNe2uUENtT
oRmEhJn8RtKWUWGkpIJ2e7vAgpvQNvYD99vTPjLQBd3kbIOLa37ap2DyCWbaAuwC
HtcWRMq3Amp/WxcQMtvdSnYmLpAWHk31oL/bOtAXHs4P6UiU2BeWzRu747/TprIB
GBgU6Ha+yr4bJRMDS6uvcJ7UwnqF2rOSwk8bz2V8MLyXQ5cHYrgQonlvlXHUubWX
dtflCXzKvF30cG0ZRxIVuBnLhPWJKvUClRQBhwclRaktew1hGxzdTnC5uImovkDr
UOydAAHf+tE+nNF4+DJeTqNNMrXOdL2Fe8JGLPL8Yuduzw1JQlqcWuyHQXhIKfOH
87AOOzj8TVzKt/QMiTPAqUpckez7Q4KUCLLpZqQvR1fFnMLi2ITLwyK606a7MFS2
4fz2CP4H8FfroBbKTENOjBYxJ+tCxf/nev8lW+4IfCtCrrZIKuXyanZT8qn84+Ja
55jpB6Mc60ztdPbn9ddiA6gvQYKazjnyyaWimVWkHKhIPNr570xXB5lfBY7i/rRi
2Os6Hw9vq2yxWizn0proK0KTW+EOJPHpifECmoYqrYrtz+vkYq2a+TkHj+9h8LRt
F/WBxxy1RQW3MkLmKZV2okqIQK89YI83eA1r3nIN5M3/JPsTskk=
=CJe0
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
