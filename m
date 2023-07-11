Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1174F6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGKRMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:12:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44427F9;
        Tue, 11 Jul 2023 10:12:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A5B140003;
        Tue, 11 Jul 2023 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689095563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RAr2OWJj8jpQoBytEBqzyQoKRhzKGkXqx6/ZMK1HS0k=;
        b=HckTFNcHkqzpgFZDA9ef8m9G2KTnT4auHqxlE96yi487vHm+7lR74cOhx3vu2tcac33VEK
        e6wuCl8TifiLh9R9nMU4LRCaTsGrCkqw22LRi4b+EoIVuf9BkXW9MgQqyAQGv8V2WzfHsi
        ROHJsW+j+ogr6kEOorW8nlGWqOtF+OY2UpcunEnevJwXAcuow4+fuEr/jXjVFpl9o1ZtCC
        VsMHzW2VitwnCtkTtgw9jIbK+ueo/a9Ub5DfvPIQ2/7hp6nee/qqVRRQN3TWz0n13+8GDs
        ATSglIlcvf7lP4b9MZh4uhmsDrxJ6kNGbgF4NRXmGDPGkbfqChyWCru5n52UdQ==
Date:   Tue, 11 Jul 2023 19:12:41 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZK2NiQd1KnraAr20@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cHA3IpzXREBvds8Z"
Content-Disposition: inline
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cHA3IpzXREBvds8Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone!

After various discussions following Andrzej's talk at EOSS, feedback from t=
he
Media Summit (which I could not attend unfortunately) and various direct
discussions, I have compiled some thoughts and ideas about stateless encode=
rs
support with various proposals. This is the result of a few years of intere=
st
in the topic, after working on a PoC for the Hantro H1 using the hantro dri=
ver,
which turned out to have numerous design issues.

I am now working on a H.264 encoder driver for Allwinner platforms (current=
ly
focusing on the V3/V3s), which already provides some usable bitstream and w=
ill
be published soon.

This is a very long email where I've tried to split things into distinct to=
pics
and explain a few concepts to make sure everyone is on the same page.

# Bitstream Headers

Stateless encoders typically do not generate all the bitstream headers and
sometimes no header at all (e.g. Allwinner encoder does not even produce sl=
ice
headers). There's often some hardware block that makes bit-level writing to=
 the
destination buffer easier (deals with alignment, etc).

The values of the bitstream headers must be in line with how the compressed
data bitstream is generated and generally follow the codec specification.
Some encoders might allow configuring all the fields found in the headers,
others may only allow configuring a few or have specific constraints regard=
ing
which values are allowed.

As a result, we cannot expect that any given encoder is able to produce fra=
mes
for any set of headers. Reporting related constraints and limitations (beyo=
nd
profile/level) seems quite difficult and error-prone.

So it seems that keeping header generation in-kernel only (close to where t=
he
hardware is actually configured) is the safest approach.

# Codec Features

Codecs have many variable features that can be enabled or not and specific
configuration fields that can take various values. There is usually some
top-level indication of profile/level that restricts what can be used.

This is a very similar situation to stateful encoding, where codec-specific
controls are used to report and set profile/level and configure these aspec=
ts.
A particularly nice thing about it is that we can reuse these existing cont=
rols
and add new ones in the future for features that are not yet covered.

This approach feels more flexible than designing new structures with a sele=
cted
set of parameters (that could match the existing controls) for each codec.

# Reference and Reconstruction Management

With stateless encoding, we need to tell the hardware which frames need to =
be
used as references for encoding the current frame and make sure we have the
these references available as decoded frames in memory.

Regardless of references, stateless encoders typically need some memory spa=
ce to
write the decoded (known as reconstructed) frame while it's being encoded.

One question here is how many slots for decoded pictures should be allocated
by the driver when starting to stream. There is usually a maximum number of
reference frames that can be used at a time, although perhaps there is a use
case to keeping more around and alternative between them for future referen=
ces.

Another question is how the driver should keep track of which frame will be=
 used
as a reference in the future and which one can be evicted from the pool of
decoded pictures if it's not going to be used anymore.

A restrictive approach would be to let the driver alone manage that, simila=
rly
to how stateful encoders behave. However it might provide extra flexibility
(and memory gain) to allow userspace to configure the maximum number of pos=
sible
reference frames. In that case it becomes necessary to indicate if a given
frame will be used as a reference in the future (maybe using a buffer flag)
and to indicate which previous reference frames (probably to be identified =
with
the matching output buffer's timestamp) should be used for the current enco=
de.
This could be done with a new dedicated control (as a variable-sized array =
of
timestamps). Note that userspace would have to update it for every frame or=
 the
reference frames will remain the same for future encodes.

The driver will then make sure to keep the reconstructed buffer around, in =
one
of the slots. When there's no slot left, the driver will drop the oldest
reference it has (maybe with a bounce buffer to still allow it to be used a=
s a
reference for the current encode).

With this behavior defined in the uAPI spec, userspace will also be able to
keep track of which previous frame is no longer allowed as a reference.

# Frame Types

Stateless encoder drivers will typically instruct the hardware to encode ei=
ther
an intra-coded or an inter-coded frame. While a stream composed only of a s=
ingle
intra-coded frame followed by only inter-coded frames is possible, it's
generally not desirable as it is not very robust against data loss and makes
seeking difficult.

As a result, the frame type is usually decided based on a given GOP size
(the frequency at which a new intra-coded frame is produced) while intra-co=
ded
frames can be explicitly requested upon request. Stateful encoders implement
these through dedicated controls:
- V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
- V4L2_CID_MPEG_VIDEO_GOP_SIZE
- V4L2_CID_MPEG_VIDEO_H264_I_PERIOD

It seems that reusing them would be possible, which would let the driver de=
cide
of the particular frame type.

However it makes the reference frame management a bit trickier since refere=
nce
frames might be requested from userspace for a frame that ends up being
intra-coded. We can either allow this and silently ignore the info or expect
that userspace keeps track of the GOP index and not send references on the =
first
frame.

In some codecs, there's also a notion of barrier key-frames (IDR frames in
H.264) that strictly forbid using any past reference beyond the frame.
There seems to be an assumption that the GOP start uses this kind of frame
(and not any intra-coded frame), while the force key frame control does not
particularly specify it.

In that case we should flush the list of references and userspace should no
longer provide references to them for future frames. This puts a requiremen=
t on
userspace to keep track of GOP start in order to know when to flush its
reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, but t=
his
could also indicate a general intra-coded frame that is not a barrier.

So another possibility would be for userspace to explicitly indicate which
frame type to use (in a codec-specific way) and act accordingly, leaving any
notion of GOP up to userspace. I feel like this might be the easiest approa=
ch
while giving an extra degree of control to userspace.

# Rate Control

Another important feature of encoders is the ability to control the amount =
of
data produced following different rate control strategies. Stateful encoders
typically do this in-firmware and expose controls for selecting the strategy
and associated targets.

It seems desirable to support both automatic and manual rate-control to
userspace.

Automatic control would be implemented kernel-side (with algos possibly sha=
red
across drivers) and reuse existing stateful controls. The advantage is
simplicity (userspace does not need to carry its own rate-control
implementation) and to ensure that there is a built-in mechanism for common
strategies available for every driver (no mandatory dependency on a proprie=
tary
userspace stack). There may also be extra statistics or controls available =
to
the driver that allow finer-grain control.

Manual control allows userspace to get creative and requires the ability to=
 set
the quantization parameter (QP) directly for each frame (controls are alrea=
dy
as many stateful encoders also support it).

# Regions of Interest

Regions of interest (ROIs) allow specifying sub-regions of the frame that s=
hould
be prioritized for quality. Stateless encoders typically support a limited
number and allow setting specific QP values for these regions.

While the QP value should be used directly in manual rate-control, we proba=
bly
want to have some "level of importance" setting for kernel-side rate-contro=
l,
along with the dimensions/position of each ROI. This could be expressed with
a new structure containing all these elements and presented as a variable-s=
ized
array control with as many elements as the hardware can support.

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--cHA3IpzXREBvds8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmStjYkACgkQ3cLmz3+f
v9Fn0Qf+PTjAI9+hdMSo2NPRIjYvaAx/BFE9xM6iU1yEacB0J3BWycFUZYakwD7r
m3pD9NH7bePTCrQtz7FfHArHUw93SmeuiLlAduWQxs+6PRfDZuKmFINl7DXiNGmu
W1+zSmUNLgFpTGDiPx2TJWVHQprtOdWN45A7yFytbKQ8adm20lRPQ2hxiLB3ky0B
sZXdahPXJBGvFX4P9Nt6FlWtlvTPbEySw3eNtW0I/M/3tQuWoCzld8wzCrRYxcbi
jYR0CH3ihl6EkTsRW6N492sphGsMe3NP4qmUD8PZ0AarAjG62qp9vXPxjTXvEWCB
Kx9tTmyUZmYBZAT6M2uKcbhqvY4pNQ==
=ldoN
-----END PGP SIGNATURE-----

--cHA3IpzXREBvds8Z--
