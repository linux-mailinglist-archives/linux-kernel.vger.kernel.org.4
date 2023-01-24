Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0E67A5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjAXWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAXWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:39:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC693AA5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:39:14 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1pKRwQ-0000eR-1x; Tue, 24 Jan 2023 23:38:58 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1pKRwN-000359-UC; Tue, 24 Jan 2023 23:38:55 +0100
Date:   Tue, 24 Jan 2023 23:38:55 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Robert Mader <robert.mader@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hantro: Fix JPEG encoder ENUM_FRAMESIZE on RK3399
Message-ID: <20230124223855.GD7611@pengutronix.de>
References: <20221223141644.703088-1-nicolas.dufresne@collabora.com>
 <CAAEAJfATk+jOq3qt-m2CZEbCVumHHWDFfuEXKA7k0NZQXajCRg@mail.gmail.com>
 <6449640fcfbbfd4b72e619f03704b7e9031a8a17.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
In-Reply-To: <6449640fcfbbfd4b72e619f03704b7e9031a8a17.camel@collabora.com>
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


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2022 at 12:05:21PM -0500, Nicolas Dufresne wrote:
>Le vendredi 23 d=E9cembre 2022 =E0 13:28 -0300, Ezequiel Garcia a =E9crit=
=A0:
>> Hi everyone,
>>
>> On Fri, Dec 23, 2022 at 11:17 AM Nicolas Dufresne
>> <nicolas.dufresne@collabora.com> wrote:
>> >
>> > The frmsize structure was left initialize to 0, as side effect, the dr=
iver was
>> > reporting an invalid frmsize.
>> >
>> >   Size: Stepwise 0x0 - 0x0 with step 0/0
>> >
>> > Fix this by replicating the constraints in the raw formats too. This f=
ixes
>> > taking picture in Gnome Cheese Software, or any software using GSteamer
>> > encodebin feature.
>> >
>> > Fixes: 775fec69008d30 ("media: add Rockchip VPU JPEG encoder driver")
>>
>> The frmsize is only for bitstream formats (see comment in struct hantro_=
fmt).
>> If I can read code correctly, this was broken by this commit:
>>
>> commit 79c987de8b35421a2a975982929f150dd415f8f7
>> Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Date:   Mon Apr 4 18:06:40 2022 +0200
>>
>>     media: hantro: Use post processor scaling capacities
>>
>> Before that commit we used to return EINVAL for enum_framesizes
>> in RAW formats. I guess we missed that :-)
>
>I see, and gstreamer had a quirk for such a bogus response. Let me explain=
 why
>its bogus, for the general knowlege. A driver that supports ENUM_FRAMESIZE=
 but
>does not return any sizes, is in theory a driver that does not support any=
thing.
>Fortunaly, GStreamer considered not having a single framesize bogus, and w=
ould
>fallback to the old school try_fmt() dance to find the supported sizes.
>
>So yes, it used to work in gstreamer, and its indeed
>79c987de8b35421a2a975982929f150dd415f8f7 that broke it. I'll correct his i=
n V2.
>
>>
>> To be completely honest, I'm not sure if we used to support encodebin,
>> and I'm not too sure how to approach this issue, but I would really
>> love to start with something super simple like:
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 2c7a805289e7..0b28f86b7463 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -161,8 +161,11 @@ static int vidioc_enum_framesizes(struct file
>> *file, void *priv,
>>         }
>>
>>         /* For non-coded formats check if postprocessing scaling is poss=
ible */
>> -       if (fmt->codec_mode =3D=3D HANTRO_MODE_NONE &&
>> hantro_needs_postproc(ctx, fmt)) {
>> -               return hanto_postproc_enum_framesizes(ctx, fsize);
>> +       if (fmt->codec_mode =3D=3D HANTRO_MODE_NONE)
>> +        if (hantro_needs_postproc(ctx, fmt))
>> +            return hanto_postproc_enum_framesizes(ctx, fsize);
>> +        else
>> +            return -ENOTTY;
>>         } else if (fsize->index !=3D 0) {
>>                 vpu_debug(0, "invalid frame size index (expected 0, got =
%d)\n",
>>                           fsize->index);
>>
>> (ENOTTY was suggested by Nicolas on IRC)
>>
>> Nicolas also pointed out that our current handling of frmsize is not cor=
rect,
>> as we cannot express different constraints on combinations of RAW
>> and bitstream formats.
>>
>> This seems to call for a rework of enum_framesizes, so frmsize
>> is not static but somehow obtained per-codec.
>
>So I'll respin along these line to we more or less "revert back" to working
>state. Though having a framesize enumeration on encoder raw (OUTPUT queue)=
 is
>what makes most sense so that will have to be revisited with a corrected
>mechanism, as whenever we add VP8 and H.264 encoding, we'll need different=
 range
>per codec. I'll check in January with my colleague, we might do that insid=
e the
>VP8 encoder branch (that is nearly ready and will be sent after the holida=
ys),
>or could be an intermediate set.

I just came across this discussion and found my very similar and somehow
forgotten patch the other day.

https://lore.kernel.org/linux-media/66839e0c4b19eb4faba5fbed5cd0a4ec0c8415f=
8.camel@ndufresne.ca/

Should I just send a v2 with the ENOTTY for now?

Thanks,
Michael

>> > Reported-by: Robert Mader <robert.mader@collabora.com>
>> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>
>> And thanks a lot for the report and the patch!
>>
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmPQXf8ACgkQC+njFXoe
LGR0URAAnuIJ1dqGDMV7Do/ZHpZdF0V/7bcGJE4ur8iVcpa23lu6TpbboYTIT7Wu
YlKwhKkSwmKny7fQIujtHMQ34WQCJc+LET9sccMg23pr8ZFNoeSJOALfeWY2F039
mDTGT3RDz6T/vtb1jBkA+r/uABVZe9XwB//1INx5BYBVBCy8nJWLCzWIh858njLk
a5SEXcB89AKNASx2QXkV8GXvXwTwYzxh9myreJRo0Zsu5ZNZKmdP90ohWPAVRDGb
M7L4f54ZAYOdlOqHalqujcazbOq5jifjheD2dXVgGZX0viR1vY7msdtE33MOP2ma
VACntFZRkfQb9LwuxRE/TarOVecZqm44J93eU8LfS4azWjf/cVpe3PmniJ0B9Zkc
opIGR+h/kbig+VZpvix5Z683UqtdHg3MAtLSe1j2E7r1h3THE2Q/SJ+BR2BFLkE5
hRszxEbPMJSQY3BQtOWsG2QvxNrfq+29WyxSHzN+ZidHr3DO2Clcj08zDsmQ0H6R
h9+ohPy9DWgr887bolhR49dPzvuuPpiWBSdZDK6yJvBD6EjxpSMSsDtSp/7mBfvA
tSjxKfnI8EEUve9uhhI+iUkHsgl4kE9QLzozcVXkxOMlc3lQMEmNz/zAGq6ymK+D
KE9u9I3v59cIQk7jomSxcXJFqhHTWyn26SOLT6ugzve4fNIePgI=
=rLWU
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
