Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2F4644313
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiLFMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiLFMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:23:38 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FD2613B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:23:33 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 125so13963895vsi.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS41pdVPPftlkxjfAeNNX5m/JobiqQJnQqPs/qKrQKU=;
        b=j70OfvcxJivYV3jV9dIlvoC9BNn2MYMRSVLucnWH895vZoCq980rebl6a9/UqWIBdM
         3P0EvrkWWODPFvC78By6kuYcw+EMeJnHxb1NP5nq1lXfbLX+8mE2VTXby5bCBclYSdHO
         iEBZSqPMhcinbId1+ejPOAfhXxXBBEPP4zhL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS41pdVPPftlkxjfAeNNX5m/JobiqQJnQqPs/qKrQKU=;
        b=tQzv0Gzd8hIw9apxvmXY+PPsWQSlykTUtquRE4+d8iqMrOb5Vb2V7lrBNTUvXnR8RC
         8gL/eHM7tuiSK3UkDDeOhV5kZAmIrnF81qf2jSQs1Sb8a1O0cVaJVEwyeknY2EyQ9BuX
         CFsqRKqx1nfjkpFrzA6eMSL5LphRZKvIaG7heegEqU63u1ANS/8/1cXGn5FhIYZsYEL5
         L/uezgFR9o23pWayHjyovM49KOrnmAq3YfmvASd7CxZUe098j2RuWndSKzftG5h1meFs
         JP7Dzs56zUZ94j9Z8RnIrPes/uXGm2+yI0+et7sC3fKOt9R7W9vAzpZzBg6taCqsVibE
         s+Lg==
X-Gm-Message-State: ANoB5pmh3IIl24lkx6t3cCD8Q4KCmvQMvGwqIlzouKSdLbv8wdrA11Ry
        tj3tLEpS6odc/7C6E5h6PNHWNErXTw0fEDgRZ3fzOg==
X-Google-Smtp-Source: AA0mqf5jTjF11GvxCW7tLTboZIRLdroQaxX3DPq9TVWWQgiUfLFKRlMYFfIyx2FQJo5yv2rOIFkfQv1vYohWq1/7PT8=
X-Received: by 2002:a05:6102:e0c:b0:3b0:6da7:39ba with SMTP id
 o12-20020a0561020e0c00b003b06da739bamr35260338vst.26.1670329412933; Tue, 06
 Dec 2022 04:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20221129074530.640251-1-wenst@chromium.org> <45143854.fMDQidcC6G@kista>
 <5d79ed06-15c0-3564-97b6-5fd4433acabf@xs4all.nl>
In-Reply-To: <5d79ed06-15c0-3564-97b6-5fd4433acabf@xs4all.nl>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 6 Dec 2022 20:23:21 +0800
Message-ID: <CAGXv+5GH==gm533P_sNiFTyaFwQXp-QLXRLWyABdsn+0p_83UQ@mail.gmail.com>
Subject: Re: [PATCH] media: cedrus: Convert to MPLANE uAPI
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 4:35 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrot=
e:
>
> On 05/12/2022 22:01, Jernej =C5=A0krabec wrote:
> > Hi Chen-Yu!
> >
> > Dne torek, 29. november 2022 ob 08:45:30 CET je Chen-Yu Tsai napisal(a)=
:
> >> The majority of the V4L2 stateless video decoder drivers use the MPLAN=
E
> >> interface.
> >>
> >> On the userspace side, Gstreamer supports non-MPLANE and MPLANE
> >> interfaces. Chromium only supports the MPLANE interface, and is not ye=
t
> >> usable with standard desktop Linux. FFmpeg support for either has not
> >> landed.
> >
> > I don't like fixing userspace issues in kernel, if kernel side works fi=
ne.
> > Implementing missing non-MPLANE support in Chromium will also allow it =
to work
> > with older kernels.
> >
> > Hans, what's linux-media politics about such changes?
>
> Not keen on this. Does the cedrus HW even have support for multiple plane=
s?
> I suspect not, in which case the driver shouldn't suggest that it can do =
that.
>
> Now, if the hardware *can* support this, then there is an argument to be =
made
> for the cedrus driver to move to the multiplanar API before moving it out
> of staging to allow such future enhancements.

AFAIK it can, but has some limitations on how far apart the buffers for
the separate planes can be. Nicolas mentioned that I could support the
multiplanar API, but only allow the contiguous single planar formats,
so NV12 instead of NV12M.

And I suspect that reference frames have to be contiguous as well.
So I guess the overall answer is that it can't. But the same goes for
Hantro or rkvdec, which both use the multiplanar API.

This conversion was done so that I could use Cedrus as a testbed for
developing new codec support, as I already own an H6 device. Added
bonus is trying to get V4L2 decoder support to work for desktop Linux,
without the libraries that ChromeOS ships.

> Note that you have to choose whether to support single or multiplanar, yo=
u
> can't support both at the same time.
>
> So the decision to move to multiplanar should be led by the HW capabiliti=
es.
>
> And Chromium really needs to support non-multiplanar formats as well. I'm
> really surprised to hear that it doesn't, to be honest.

Chromium does support non-multiplanar formats, such as NV12. In fact
this is the preferred format, unless it's on MediaTek, in which it
switches to MM21 as the capture format, and does untiling in software.
This support for formats is separate from using the multiplanar API.

Support for video decoders is mostly driven by ChromeOS. Currently all the
hardware ChromeOS supports, be it stateful or stateless, use the multiplana=
r
API, so there hasn't been a real need to support it yet.


Regards
ChenYu

> Regards,
>
>         Hans
>
> >
> > Best regards,
> > Jernej
> >
> >>
> >> A fallback route using libv4l is also available. The library translate=
s
> >> MPLANE interface ioctl calls to non-MPLANE ones, provided that the pix=
el
> >> format used is single plane.
> >>
> >> Convert the Cedrus driver to the MPLANE interface, while keeping the
> >> supported formats single plane. Besides backward compatibility through
> >> the plugin, the hardware requires that different planes not be located
> >> too far apart in memory. Keeping the single plane pixel format makes
> >> this easy to enforce.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >> ---
> >>
> >> This has been tested with Fluster. The score remained the same with or
> >> without the patch. This also helps with getting VP8 decoding working
> >> with Chromium's in-tree test program "video_decode_accelerator_tests",
> >> though Chromium requires other changes regarding buffer allocation and
> >> management.
> >
> >
>
