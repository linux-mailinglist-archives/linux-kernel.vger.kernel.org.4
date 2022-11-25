Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3E0638ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKYRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKYRHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:07:21 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2E47306
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:07:20 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p18so3015176qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97kBq1lHFGTQU+jw0/b/R8A8S8A1UfU8aPvHkRRFZT4=;
        b=20KP1RhXPKqqM2jWK5xsvK/NjCT6INujtBc6GaRsjf4fMRpNCxBMaCGt/1zoioiro+
         Qjgxu2+QSi6zaOGIa5lKH6/wvdtKSXSpmVtTxFkKqTbVGNiZfprfSwGfVAqZXbY3fTtV
         gcZktnSKO7PkuJ5dUsnTXJ0HgSdYfGbli61uB3hnnF62JBLpRB2QOMP7UAM/f6kKSp7L
         3kRf9KIoIjMH6Fm8/0ieNzBiqxqb+oEtilxQSE1M5I7pjT5J3+d0YGmSFr+ohGYuB7Cs
         g0gcoMNUFQj6RwxESEtsjVfrf+b7Gy257GahKgFhtnKaM4IFJy9S72r9tl81jBuVRtNJ
         dX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97kBq1lHFGTQU+jw0/b/R8A8S8A1UfU8aPvHkRRFZT4=;
        b=WcjVKr1u0vt806srGs8iXmOezaLp7MQ+CTNknXlMs9S3DW0nVhs3CDfCoBIP4tMhFn
         0OKzX4Xa7QrF45zZScEKpwMZ2/58+LAV8o5/JDJsQV9efIOJ2vlSqC2IWS5QVlNia1Af
         sAoUP1rOEXqKM5ZCIdyMxJgHNSHoKee0rOz791BhLSkXhx4jlS4OEJJw4qw7LWEZtqYf
         NsGDI+ZXrICiKvHKWyLfldImt533iJyloOdwqQus/bpF5D5u60sMAivfZiZFa4G/bk32
         naKdfBtfP+C9RYmVKHwQlj9635XSG1ImR/xLxeaT8Xm1vvqvTZvy6x6tFQvaaNl+w9OH
         pngw==
X-Gm-Message-State: ANoB5pm3KoImYd3OwVAQoJ9LBCNkkgqpGkQ/i+nj3pSyyBrYNt1WTtHw
        FJ+F0ALrIqh1ZOr9W/vCVjWBtA==
X-Google-Smtp-Source: AA0mqf73BwAzRPM9OhZfqMvWynMdb0MPgrv9Ij3EKAfQMLZasIQDPXgVwAUXC0S60Weaq3zaXcXzHw==
X-Received: by 2002:a05:620a:2b8b:b0:6fb:28a:4a57 with SMTP id dz11-20020a05620a2b8b00b006fb028a4a57mr35004047qkb.239.1669396039467;
        Fri, 25 Nov 2022 09:07:19 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bv14-20020a05622a0a0e00b0039c37a7914csm2502106qtb.23.2022.11.25.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 09:07:19 -0800 (PST)
Message-ID: <35256805b1ce0b2b7533f53f658c799a37255469.camel@ndufresne.ca>
Subject: Re: [PATCH] media: videobuf2: add V4L2_BUF_FLAG_HEADERS_ONLY flag
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 25 Nov 2022 12:07:17 -0500
In-Reply-To: <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
References: <20220712093754.23370-1-ming.qian@nxp.com>
         <15ba9b9e-f3f6-7f30-c200-d7c9593a4735@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying on top, a bit unusual, but I think it makes sense ....

Le jeudi 24 novembre 2022 =C3=A0 11:42 +0100, Hans Verkuil a =C3=A9crit=C2=
=A0:
> +CC Nicolas and Tomasz.
>=20
> I would like some feedback for this patch.
>=20
> On 12/07/2022 11:37, Ming Qian wrote:
> > By setting the V4L2_BUF_FLAG_HEADERS_ONLY flag,
> > hint the vb2 only contains stream header,
> > but does not contain any frame data.
> >=20
> > This flag needs to be used when header mode is set to
> > V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE.
> >=20
> > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > ---
> >  Documentation/userspace-api/media/v4l/buffer.rst      | 11 +++++++++++
> >  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 10 +++++++---
> >  include/uapi/linux/videodev2.h                        |  2 ++
> >  3 files changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documen=
tation/userspace-api/media/v4l/buffer.rst
> > index 4638ec64db00..18a6f5fcc822 100644
> > --- a/Documentation/userspace-api/media/v4l/buffer.rst
> > +++ b/Documentation/userspace-api/media/v4l/buffer.rst
> > @@ -607,6 +607,17 @@ Buffer Flags
> >  	the format. Any subsequent call to the
> >  	:ref:`VIDIOC_DQBUF <VIDIOC_QBUF>` ioctl will not block anymore,
> >  	but return an ``EPIPE`` error code.
> > +    * .. _`V4L2-BUF-FLAG-HEADERS-ONLY`:
> > +
> > +      - ``V4L2_BUF_FLAG_HEADERS_ONLY``
> > +      - 0x00200000
> > +      - This flag may be set when the buffer only contains codec
>=20
> Set by the driver or userspace? Or either, depending on whether it is
> an encoder or decoder?

I think it should be set by the driver when encoding, and set by user space=
 when
decoding. And of course, should be documented as previous review underline.

>=20
> codec -> the codec
>=20
> > +	header, but does not contain any frame data. Usually the codec
> > +	header is merged to the next idr frame, with the flag
>=20
> to -> with
> idr -> IDR
>=20
> > +	``V4L2_BUF_FLAG_KEYFRAME``, but there is still some scenes that will
>=20
> is -> are
>=20
> scenes: do you mean 'scenarios'?
>=20
> > +	split the header and queue it separately. This flag can set only when
>=20
> "split the header and queue it separately" -> queue the header in a separ=
ate buffer
>=20
> can -> can be
>=20
> > +	codec support V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
>=20
> codec -> the codec
> support -> supports
>=20
> > +	and the header mode is set to V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE
> >      * .. _`V4L2-BUF-FLAG-REQUEST-FD`:
> > =20
> >        - ``V4L2_BUF_FLAG_REQUEST_FD``
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > index 6183f43f4d73..478b6af4205d 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > @@ -1386,8 +1386,12 @@ enum v4l2_mpeg_video_intra_refresh_period_type -
> >      (enum)
> > =20
> >  enum v4l2_mpeg_video_header_mode -
> > -    Determines whether the header is returned as the first buffer or i=
s
> > -    it returned together with the first frame. Applicable to encoders.
> > +    Determines whether the header is returned as the first buffer
> > +    with flag V4L2_BUF_FLAG_HEADERS_ONLY or is
>=20
> or is it -> or if it is
>=20
> > +    it returned together with the first frame.
> > +    Applicable to encoders and decoders.
> > +    If it's not implemented in a driver,
> > +    V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME is to be assumed=
,
> >      Possible values are:
> > =20
> >  .. raw:: latex
> > @@ -1401,7 +1405,7 @@ enum v4l2_mpeg_video_header_mode -
> >      :stub-columns: 0
> > =20
> >      * - ``V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE``
> > -      - The stream header is returned separately in the first buffer.
> > +      - The stream header is returned separately in the first buffer w=
ith the flag V4L2_BUF_FLAG_HEADERS_ONLY.
> >      * - ``V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME``
> >        - The stream header is returned together with the first encoded
> >  	frame.
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 5311ac4fde35..6fd96acd6080 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -1131,6 +1131,8 @@ static inline __u64 v4l2_timeval_to_ns(const stru=
ct timeval *tv)
> >  #define V4L2_BUF_FLAG_TSTAMP_SRC_SOE		0x00010000
> >  /* mem2mem encoder/decoder */
> >  #define V4L2_BUF_FLAG_LAST			0x00100000
> > +/* Buffer only contains codec header */
>=20
> codec -> the codec
>=20
> > +#define V4L2_BUF_FLAG_HEADERS_ONLY		0x00200000
> >  /* request_fd is valid */
> >  #define V4L2_BUF_FLAG_REQUEST_FD		0x00800000
> > =20
>=20
> Of course, there needs to be a driver that uses this as well. And drivers=
 that support
> V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE would need to add support for this f=
lag as well,
> I guess.
>=20
> And what I haven't seen here is *why* you need this flag. There are alrea=
dy drivers that
> support V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE, and they managed fine witho=
ut it.

I think this can make sense, I'm not user of this, since this is OMX/Androi=
d
specific behaviour, but I think I can make sense of it.

For encoders, in WebRTC (any RTP, or streaming protocol with keyframe reque=
st),
we often ask the encoder to produce a new keyframe. We don't reset the enco=
der
this point. Some encoder may resend the headers, as the encoder is in "sepe=
rate
mode" it should send it separately. Userland can then handle resending the =
last
seem header if it wasn't there. It also help locating when the request was
actually honoured (I'm guessing there is already a keyframe flag of some so=
rt).
So to me this enhancement is valid, it makes everything nicer. I agree it n=
eeds
a solid adoption, so any driver supporting this should be ported (could be =
blind
ported and tested by their maintainers).

For decoders, if a a decoder is in "separate mode", it seems that sending
headers must happen this way. If this uses a separate path internally, the
kernel needs also to be aware which buffers are what (and we don't parse in=
 the
kernel). In very basic case, the driver assume that the first buffer after
streamon is a header, but that prevents resolution changes without a
drain+flush, which android and chromeos folks seems to use. (I always drain=
 and
flush for what I'm doing).

Nicolas

>=20
> Regards,
>=20
> 	Hans

