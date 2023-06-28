Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959B74164E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF1Q1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjF1Q10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:27:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04768268F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:27:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76547539775so470174185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1687969644; x=1690561644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3pEp4gR1EagFJJ0VQJvzcXKOpy0bwlfLoZKm6nYgbtU=;
        b=dLAT1hcfd0IQVA+8RNG9bGGVzawki9G6zN4TLnnB6tOfI6o4xQW9l1AAs72d7sNQNd
         mzbONnySMY2THL/0CpCr96Puft6Vdy5lm+l0FIbDenw2mHiwRaQzOWkd1InKQhp4gG1m
         wTzni6bZuucb1qP/dwhm56EyxuWWfgEglxjvInJEgzcLeoFLmipucJgWiQRn3AH1WT7N
         SHheBlPo4IhyffQDIt9rgF+06f2I2/ShRz14V8gY0lKRcU3MBrk5QG+L9iCQ7JbrsKpW
         GJg052byuT5KNlocLQPc4xv+1FCESrZVJWdQm0TFgFhrWLQQlopUtTAR4RfKPRGZLO1S
         5Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969644; x=1690561644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pEp4gR1EagFJJ0VQJvzcXKOpy0bwlfLoZKm6nYgbtU=;
        b=c4YtVw+9LBghpW0p+cFmf5jdzz3rJ5yKfXWpxab4tWPl9avXFZh4nrqpoobsbF2FoD
         zFp2+iw5ncnPvnzsu0/bYGxK/Z1J3rtQbE+fyFJnuX3Vm1DnryKp/uVHmTMuHrADF04Z
         Qq9xgDwzyU2hN5BkTDpN9vkz7Q1m8l7h+o514j7QFrP1IrySmBhex43NOasAI0iANAeq
         JvmjgXrBQrVseDx3sqh7GKiTbvqLTyISucYOpHJCbqqvE3KHulJehNzlqFBsq9L8X5dk
         Ob54Z16iK6QjW7c+AFLb7iAmRJBYHGBY9r9kKcpIOC/eFw7ep1BmcKlfCvIlN+67NLfl
         /uHA==
X-Gm-Message-State: AC+VfDyPr2Wu+qNGu5WeccYBMwHzHKrWz0BKI8k8ahv8OG09hQFcmt1Y
        yQAWVDdKnY5bxnlfN563OBEEzw==
X-Google-Smtp-Source: ACHHUZ4QJ2AelSefHWakS6doxVyxAdK4YMYSTI/TTNNPiJ/HeyfZQPqNCAAfEFrpe8j2TvgUKYm3vQ==
X-Received: by 2002:a05:620a:4114:b0:766:fd7c:f52e with SMTP id j20-20020a05620a411400b00766fd7cf52emr8623940qko.66.1687969644015;
        Wed, 28 Jun 2023 09:27:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:c623::7a9])
        by smtp.gmail.com with ESMTPSA id d11-20020a37c40b000000b007625382f4ccsm5197460qki.69.2023.06.28.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:27:23 -0700 (PDT)
Message-ID: <6674abe5681c0f4a4e4466e034393359346cfda7.camel@ndufresne.ca>
Subject: Re: [PATCH v7 1/9] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>, ayaka <ayaka@soulik.info>
Cc:     linux-media@vger.kernel.org, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        Helen Koike <helen.koike@collabora.com>
Date:   Wed, 28 Jun 2023 12:27:22 -0400
In-Reply-To: <1e3a583f-f9ef-d2d3-6571-ac3b79d800ce@synaptics.com>
References: <20230206043308.28365-1-ayaka@soulik.info>
         <20230206043308.28365-2-ayaka@soulik.info>
         <1e3a583f-f9ef-d2d3-6571-ac3b79d800ce@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please avoid HTML replies on the mailing list.

Le mardi 27 juin 2023 =C3=A0 14:42 +0800, Hsia-Jun Li a =C3=A9crit=C2=A0:
> > +/**
> > + * struct v4l2_ext_pix_format - extended multiplanar format definition
> > + * @type:		enum v4l2_buf_type; type of the data stream
> > + * @width:		image width in pixels
> > + * @height:		image height in pixels
> > + * @pixelformat:	little endian four character code (fourcc)
> > + * @modifier:		modifier applied to the format (used for tiled formats
> > + *			and other kind of HW-specific formats, like compressed
> > + *			formats) as defined in drm_fourcc.h
> > + * @field:		enum v4l2_field; field order (for interlaced video)
> > + * @colorspace:		enum v4l2_colorspace; supplemental to pixelformat
> > + * @plane_fmt:		per-plane information
> > + * @flags:		format flags (V4L2_PIX_FMT_FLAG_*)
> > + * @ycbcr_enc:		enum v4l2_ycbcr_encoding, Y'CbCr encoding
> > + * @hsv_enc:		enum v4l2_hsv_encoding, HSV encoding
> > + * @quantization:	enum v4l2_quantization, colorspace quantization
> > + * @xfer_func:		enum v4l2_xfer_func, colorspace transfer function
> > + * @reserved:		drivers and applications must zero this array
> > + */
> > +struct v4l2_ext_pix_format {
> > +	__u32				type;
> > +	__u32				width;
> > +	__u32				height;
> > +	__u32				pixelformat;
> > +	__u64				modifier;
> > +	__u32				field;
> > +	__u32				colorspace;
> > +
> > +	struct v4l2_plane_pix_format	plane_fmt[VIDEO_MAX_PLANES];
> > +	__u8				flags;
> > +	 union {
> > +		__u8				ycbcr_enc;
> > +		__u8				hsv_enc;
> > +	};
> > +	__u8				quantization;
> > +	__u8				xfer_func;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0
> >=20
> >=20
> >=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0I heard that a suggestion that we could remove co=
lorimetry fields
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0here.
> =C2=A0=C2=A0=C2=A0=C2=A0Although those are useless for codec M2M drivers =
if no pixel
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0formats translation invoked.
> =C2=A0=C2=A0=C2=A0=C2=A0Even HDMI(DRM) cares about colorspace.
> =C2=A0=C2=A0=C2=A0=C2=A0For example if a downsink(TV) shows RGB formats,=
=C2=A0 with an YUV
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0input frame buffer, colorimetry would=
 be important or the wrong
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0EOTF would be used. If YUV is MPEG ra=
nge(linear EOTF) while a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0non-linear EOFT (full range) is used,=
 you would found the black is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0not black enough while the white look=
s a gray. Also color bias
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0would happen.
> =C2=A0=C2=A0=C2=A0=C2=A0This problem may not happen to a ultra high resol=
ution TV while
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0only YUV type color formats are suppo=
rted due to HDMI bandwidth
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0limitation.
> =C2=A0=C2=A0=C2=A0=C2=A0The problem I want to raise is the time cost for =
enumeration.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Each pixel format with a colorimetry =
setting would invoke a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ioctl(). For the application likes Gs=
treamer would enum all the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0possible colorimetries.
> =C2=A0=C2=A0=C2=A0=C2=A0It would be better we could have something like D=
RM blob id that
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0application could copy the data from =
a non-DMA buffer from the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kernel.

This is a good topic. Colorimetry could indeed be moved away from the forma=
t,
considering they cannot be enumerated. It remains that this information nee=
ds to
be passed around, and the format of a blob in media space is not has restri=
cted
as with display HW. I think keeping an "exploded version" of the colorimetr=
y
remains needed.

Remember though that for stateful decoder, were the information could be st=
ored
in the bitstream, the decoder is responsible for returning that information=
.
Currently its passed through the G_FMT call, it would need to be replaced w=
ith a
control, similar to the HDR10 static metadata. If the colorimetry is no lon=
ger
static in the future, and may change while streaming, one option would be R=
O
request. This was foreseen for HDR10+ and Dolby Vision metadata notably, th=
ough
other options exists.

There exist known decoders that can do YUV to RGB conversion using an inlin=
e
post procesor (VC8000D and newer is an example), and for these to return co=
rrect
colors, the colorimetry information needs to be passed. So its not strictly
useless.

In short, if we drop colorimetry from format, we also need to go ahead and
design a replacement for it, that allow for the application to detect chang=
es.

regards,
Nicolas

