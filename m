Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D980774F7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjGKSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGKSSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:18:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8A10F2;
        Tue, 11 Jul 2023 11:18:49 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E7BE46606F97;
        Tue, 11 Jul 2023 19:18:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689099528;
        bh=vh26j2x6rx+Z4Bys+671Juu7i5chZL2bp/7g8am8MYk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k7gObnPzFq5Rva3cI6n5eem9ysJD1tPfR3jax2EvnIGaGt36rd/jSLgGVxol/hVlg
         9+z9gAIaoXSNm8RhaRmyz9pZuApbR2yCcSaJm4rMsjSs2FoOeljMqBpl+TkIzBusYg
         HUV57PJ0mTNPSEOolDhhSEzIjvNYtlk3w0KGaRwkZ/c1Yj7hIKl8q6DOAYIAyx1JI+
         PP4QBKWYKIWC3lV1/7+ofCszcTSlQhwG5IfaKjED90LvrTzfea26FIlmpyDqR1irY5
         FHDgqI4vYSgiEHzHAIf6ZGM/YO+kI/H71R/J/FQfOc+W/xunJseMH9fQSLPFyWcx7p
         myTFlGvO9HWiA==
Message-ID: <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 11 Jul 2023 14:18:38 -0400
In-Reply-To: <ZK2NiQd1KnraAr20@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 juillet 2023 =C3=A0 19:12 +0200, Paul Kocialkowski a =C3=A9crit=
=C2=A0:
> Hi everyone!
>=20
> After various discussions following Andrzej's talk at EOSS, feedback from=
 the
> Media Summit (which I could not attend unfortunately) and various direct
> discussions, I have compiled some thoughts and ideas about stateless enco=
ders
> support with various proposals. This is the result of a few years of inte=
rest
> in the topic, after working on a PoC for the Hantro H1 using the hantro d=
river,
> which turned out to have numerous design issues.
>=20
> I am now working on a H.264 encoder driver for Allwinner platforms (curre=
ntly
> focusing on the V3/V3s), which already provides some usable bitstream and=
 will
> be published soon.
>=20
> This is a very long email where I've tried to split things into distinct =
topics
> and explain a few concepts to make sure everyone is on the same page.
>=20
> # Bitstream Headers
>=20
> Stateless encoders typically do not generate all the bitstream headers an=
d
> sometimes no header at all (e.g. Allwinner encoder does not even produce =
slice
> headers). There's often some hardware block that makes bit-level writing =
to the
> destination buffer easier (deals with alignment, etc).
>=20
> The values of the bitstream headers must be in line with how the compress=
ed
> data bitstream is generated and generally follow the codec specification.
> Some encoders might allow configuring all the fields found in the headers=
,
> others may only allow configuring a few or have specific constraints rega=
rding
> which values are allowed.
>=20
> As a result, we cannot expect that any given encoder is able to produce f=
rames
> for any set of headers. Reporting related constraints and limitations (be=
yond
> profile/level) seems quite difficult and error-prone.
>=20
> So it seems that keeping header generation in-kernel only (close to where=
 the
> hardware is actually configured) is the safest approach.

This seems to match with what happened with the Hantro VP8 proof of concept=
. The
encoder does not produce the frame header, but also, it produces 2 encoded
buffers which cannot be made contiguous at the hardware level. This notion =
of
plane in coded data wasn't something that blended well with the rest of the=
 API
and we didn't want to copy in the kernel while the userspace would also be
forced to copy to align the headers. Our conclusion was that it was best to
generate the headers and copy both segment before delivering to userspace. =
I
suspect this type of situation will be quite common.

>=20
> # Codec Features
>=20
> Codecs have many variable features that can be enabled or not and specifi=
c
> configuration fields that can take various values. There is usually some
> top-level indication of profile/level that restricts what can be used.
>=20
> This is a very similar situation to stateful encoding, where codec-specif=
ic
> controls are used to report and set profile/level and configure these asp=
ects.
> A particularly nice thing about it is that we can reuse these existing co=
ntrols
> and add new ones in the future for features that are not yet covered.
>=20
> This approach feels more flexible than designing new structures with a se=
lected
> set of parameters (that could match the existing controls) for each codec=
.

Though, reading more into this emails, we still have a fair amount of contr=
ols
to design and add, probably some compound controls too ?

>=20
> # Reference and Reconstruction Management
>=20
> With stateless encoding, we need to tell the hardware which frames need t=
o be
> used as references for encoding the current frame and make sure we have t=
he
> these references available as decoded frames in memory.
>=20
> Regardless of references, stateless encoders typically need some memory s=
pace to
> write the decoded (known as reconstructed) frame while it's being encoded=
.
>=20
> One question here is how many slots for decoded pictures should be alloca=
ted
> by the driver when starting to stream. There is usually a maximum number =
of
> reference frames that can be used at a time, although perhaps there is a =
use
> case to keeping more around and alternative between them for future refer=
ences.
>=20
> Another question is how the driver should keep track of which frame will =
be used
> as a reference in the future and which one can be evicted from the pool o=
f
> decoded pictures if it's not going to be used anymore.
>=20
> A restrictive approach would be to let the driver alone manage that, simi=
larly
> to how stateful encoders behave. However it might provide extra flexibili=
ty
> (and memory gain) to allow userspace to configure the maximum number of p=
ossible
> reference frames. In that case it becomes necessary to indicate if a give=
n
> frame will be used as a reference in the future (maybe using a buffer fla=
g)
> and to indicate which previous reference frames (probably to be identifie=
d with
> the matching output buffer's timestamp) should be used for the current en=
code.
> This could be done with a new dedicated control (as a variable-sized arra=
y of
> timestamps). Note that userspace would have to update it for every frame =
or the
> reference frames will remain the same for future encodes.
>=20
> The driver will then make sure to keep the reconstructed buffer around, i=
n one
> of the slots. When there's no slot left, the driver will drop the oldest
> reference it has (maybe with a bounce buffer to still allow it to be used=
 as a
> reference for the current encode).
>=20
> With this behavior defined in the uAPI spec, userspace will also be able =
to
> keep track of which previous frame is no longer allowed as a reference.

If we want, we could mirror the stateless decoders here. During the decodin=
g, we
pass a "dpb" or a reference list, which represent all the active references=
.
These do not have to be used by the current frame, but the driver is allowe=
d to
use this list to cleanup and free unused memory (or reuse in case it has a =
fixed
slot model, like mtk vcodec).

On top of this, we add a list of references to be used for producing the cu=
rrent
frame. Usually, the picture references are indices into the dpb/reference l=
ist
of timestamp. This makes validation easier.  We'll have to define how many
reference can be used I think since unlike decoders, encoders don't have to
fully implement levels and profiles.

>=20
> # Frame Types
>=20
> Stateless encoder drivers will typically instruct the hardware to encode =
either
> an intra-coded or an inter-coded frame. While a stream composed only of a=
 single
> intra-coded frame followed by only inter-coded frames is possible, it's
> generally not desirable as it is not very robust against data loss and ma=
kes
> seeking difficult.

Let's avoid this generalization in our document and design. In RTP streamin=
g,
like WebRTP or SIP, it is desirable to use open GOP (with nothing else then=
 P
frames all the time, except the very first one). The FORCE_KEY_FRAME is mea=
nt to
allow handling RTP PLI (and other similar feedback). Its quite rare an
application would mix close GOP and FORCE_KEY_FRAME, but its allowed though=
.
What I've seen the most, is the FORCE_KEY_FRAME would just start a new GOP,
following size and period from this new point.

>=20
> As a result, the frame type is usually decided based on a given GOP size
> (the frequency at which a new intra-coded frame is produced) while intra-=
coded
> frames can be explicitly requested upon request. Stateful encoders implem=
ent
> these through dedicated controls:
> - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
>=20
> It seems that reusing them would be possible, which would let the driver =
decide
> of the particular frame type.
>=20
> However it makes the reference frame management a bit trickier since refe=
rence
> frames might be requested from userspace for a frame that ends up being
> intra-coded. We can either allow this and silently ignore the info or exp=
ect
> that userspace keeps track of the GOP index and not send references on th=
e first
> frame.
>=20
> In some codecs, there's also a notion of barrier key-frames (IDR frames i=
n
> H.264) that strictly forbid using any past reference beyond the frame.
> There seems to be an assumption that the GOP start uses this kind of fram=
e
> (and not any intra-coded frame), while the force key frame control does n=
ot
> particularly specify it.
>=20
> In that case we should flush the list of references and userspace should =
no
> longer provide references to them for future frames. This puts a requirem=
ent on
> userspace to keep track of GOP start in order to know when to flush its
> reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, but=
 this
> could also indicate a general intra-coded frame that is not a barrier.
>=20
> So another possibility would be for userspace to explicitly indicate whic=
h
> frame type to use (in a codec-specific way) and act accordingly, leaving =
any
> notion of GOP up to userspace. I feel like this might be the easiest appr=
oach
> while giving an extra degree of control to userspace.

I also lean toward this approach ...

>=20
> # Rate Control
>=20
> Another important feature of encoders is the ability to control the amoun=
t of
> data produced following different rate control strategies. Stateful encod=
ers
> typically do this in-firmware and expose controls for selecting the strat=
egy
> and associated targets.
>=20
> It seems desirable to support both automatic and manual rate-control to
> userspace.
>=20
> Automatic control would be implemented kernel-side (with algos possibly s=
hared
> across drivers) and reuse existing stateful controls. The advantage is
> simplicity (userspace does not need to carry its own rate-control
> implementation) and to ensure that there is a built-in mechanism for comm=
on
> strategies available for every driver (no mandatory dependency on a propr=
ietary
> userspace stack). There may also be extra statistics or controls availabl=
e to
> the driver that allow finer-grain control.

Though not controlling the GOP (or no gop) might require a bit more work on
driver side. Today, we do have queues of request, queues of buffer etc. But=
 it
is still quite difficult to do lookahead these queues. That is only useful =
if
rate control algorithm can use future frame type (like keyframe) to make
decisions. That could be me pushing to far here though.

>=20
> Manual control allows userspace to get creative and requires the ability =
to set
> the quantization parameter (QP) directly for each frame (controls are alr=
eady
> as many stateful encoders also support it).
>=20
> # Regions of Interest
>=20
> Regions of interest (ROIs) allow specifying sub-regions of the frame that=
 should
> be prioritized for quality. Stateless encoders typically support a limite=
d
> number and allow setting specific QP values for these regions.
>=20
> While the QP value should be used directly in manual rate-control, we pro=
bably
> want to have some "level of importance" setting for kernel-side rate-cont=
rol,
> along with the dimensions/position of each ROI. This could be expressed w=
ith
> a new structure containing all these elements and presented as a variable=
-sized
> array control with as many elements as the hardware can support.

Do you see any difference in ROI for stateful and stateless ? This looks li=
ke a
feature we could combined. Also, ROI exist for cameras too, I'd probably tr=
y and
keep them separate though.

This is a very good overview of the hard work ahead of us. Looking forward =
on
this journey and your Allwinner driver.

regards,
Nicolas
