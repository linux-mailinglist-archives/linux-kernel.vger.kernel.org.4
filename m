Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E58B644C54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLFTPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLFTPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:15:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867040920;
        Tue,  6 Dec 2022 11:15:32 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA1326602B2C;
        Tue,  6 Dec 2022 19:15:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670354130;
        bh=CbpetSjHvQviX156mgDvQrxS6ZNVFJ4ayCXN+Hd15qE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iDe6TZ4x00XduKQhsVWMhOUhifd4fAGQA9W2enB/w5rC3edcQ/UI+OZavlqkN5oVp
         F+lzQXnH3pwvD7jdJDEJblO+lcAe4GVxCmE2yrCGBZpxKCIOgjpPAawBjwZLfM9Uv0
         Lwt7F0G7xJ41Enn33lr7MsOvKPJBgDPEQ1rfzvK4+HzJqQkDo+76V1NAyp2FEWfg95
         AzxfbUBPShVt/5xm31KHmE1oH95UngzsQmuDXSSIM5INSl/BPdKHwlU2tkPE08W0AM
         J5/WbklRLVxYqwT3boakWqqAVs9tJP/+v0CqNUEKoC0szKgc9p3l2rmbmXKjYT44S1
         mmW7MXw4jfWHw==
Message-ID: <6c75bbbf497f9baa5d99f642bd466751e2b0d460.camel@collabora.com>
Subject: Re: [PATCH] media: cedrus: Convert to MPLANE uAPI
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Dec 2022 14:15:19 -0500
In-Reply-To: <CAGXv+5GH==gm533P_sNiFTyaFwQXp-QLXRLWyABdsn+0p_83UQ@mail.gmail.com>
References: <20221129074530.640251-1-wenst@chromium.org>
         <45143854.fMDQidcC6G@kista>
         <5d79ed06-15c0-3564-97b6-5fd4433acabf@xs4all.nl>
         <CAGXv+5GH==gm533P_sNiFTyaFwQXp-QLXRLWyABdsn+0p_83UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 06 d=C3=A9cembre 2022 =C3=A0 20:23 +0800, Chen-Yu Tsai a =C3=A9cri=
t=C2=A0:
> On Tue, Dec 6, 2022 at 4:35 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wr=
ote:
> >=20
> > On 05/12/2022 22:01, Jernej =C5=A0krabec wrote:
> > > Hi Chen-Yu!
> > >=20
> > > Dne torek, 29. november 2022 ob 08:45:30 CET je Chen-Yu Tsai napisal(=
a):
> > > > The majority of the V4L2 stateless video decoder drivers use the MP=
LANE
> > > > interface.
> > > >=20
> > > > On the userspace side, Gstreamer supports non-MPLANE and MPLANE
> > > > interfaces. Chromium only supports the MPLANE interface, and is not=
 yet
> > > > usable with standard desktop Linux. FFmpeg support for either has n=
ot
> > > > landed.
> > >=20
> > > I don't like fixing userspace issues in kernel, if kernel side works =
fine.
> > > Implementing missing non-MPLANE support in Chromium will also allow i=
t to work
> > > with older kernels.
> > >=20
> > > Hans, what's linux-media politics about such changes?
> >=20
> > Not keen on this. Does the cedrus HW even have support for multiple pla=
nes?
> > I suspect not, in which case the driver shouldn't suggest that it can d=
o that.

Hi Hans,

> >=20
> > Now, if the hardware *can* support this, then there is an argument to b=
e made
> > for the cedrus driver to move to the multiplanar API before moving it o=
ut
> > of staging to allow such future enhancements.
>=20
> AFAIK it can, but has some limitations on how far apart the buffers for
> the separate planes can be. Nicolas mentioned that I could support the
> multiplanar API, but only allow the contiguous single planar formats,
> so NV12 instead of NV12M.

indeed, MPLANE buffer API is not an advertisement for MPLANE support. The p=
ixel
formats exposed through ENUM_FMT are the only possible advertisement, and o=
nly
single allocation format (NV12) remains exposed.

Putting my userspace hat on, I see see an effort by the author of MPLANE AP=
I to
make it so it would completely replaced the older API. The effort have imho=
 very
bad consequences (duplication of pixel formats), but if we also don't enfor=
ce
porting existing drivers to the new API, we add yet another consequence, bu=
t
this time on userspace, which must handle both C structures to actually wor=
k
generically. I totally understand that from driver maintainer point of view=
,
this change have absolutely no value, but we force userspace complexity sim=
ply
because we leave it to driver author to pick older or newer (totally equiva=
lent)
APIs. To me, the problem is that V4L2 API maintainers didn't adopt the new =
API
despite merging it. The adoption should have deprecated usage of the old AP=
I, at
least in new drivers (since 2011). This should also have been an unstaging
requirement.

regards,
Nicolas

>=20
> And I suspect that reference frames have to be contiguous as well.
> So I guess the overall answer is that it can't. But the same goes for
> Hantro or rkvdec, which both use the multiplanar API.
>=20
> This conversion was done so that I could use Cedrus as a testbed for
> developing new codec support, as I already own an H6 device. Added
> bonus is trying to get V4L2 decoder support to work for desktop Linux,
> without the libraries that ChromeOS ships.
>=20
> > Note that you have to choose whether to support single or multiplanar, =
you
> > can't support both at the same time.
> >=20
> > So the decision to move to multiplanar should be led by the HW capabili=
ties.
> >=20
> > And Chromium really needs to support non-multiplanar formats as well. I=
'm
> > really surprised to hear that it doesn't, to be honest.
>=20
> Chromium does support non-multiplanar formats, such as NV12. In fact
> this is the preferred format, unless it's on MediaTek, in which it
> switches to MM21 as the capture format, and does untiling in software.
> This support for formats is separate from using the multiplanar API.
>=20
> Support for video decoders is mostly driven by ChromeOS. Currently all th=
e
> hardware ChromeOS supports, be it stateful or stateless, use the multipla=
nar
> API, so there hasn't been a real need to support it yet.
>=20
>=20
> Regards
> ChenYu
>=20
> > Regards,
> >=20
> >         Hans
> >=20
> > >=20
> > > Best regards,
> > > Jernej
> > >=20
> > > >=20
> > > > A fallback route using libv4l is also available. The library transl=
ates
> > > > MPLANE interface ioctl calls to non-MPLANE ones, provided that the =
pixel
> > > > format used is single plane.
> > > >=20
> > > > Convert the Cedrus driver to the MPLANE interface, while keeping th=
e
> > > > supported formats single plane. Besides backward compatibility thro=
ugh
> > > > the plugin, the hardware requires that different planes not be loca=
ted
> > > > too far apart in memory. Keeping the single plane pixel format make=
s
> > > > this easy to enforce.
> > > >=20
> > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > ---
> > > >=20
> > > > This has been tested with Fluster. The score remained the same with=
 or
> > > > without the patch. This also helps with getting VP8 decoding workin=
g
> > > > with Chromium's in-tree test program "video_decode_accelerator_test=
s",
> > > > though Chromium requires other changes regarding buffer allocation =
and
> > > > management.
> > >=20
> > >=20
> >=20

