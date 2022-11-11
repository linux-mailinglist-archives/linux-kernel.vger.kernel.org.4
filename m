Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F70625334
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKKFtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKKFtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:49:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42C6F348
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:49:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f5so10327762ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTaYB/LpPyXqzqoBt6V96BonKGbJkZZ+Zedm35NemXc=;
        b=WAmP2pWQ6ci1hGe9HDUWopEi0zCh+qeL6mxlfdejbgWRMllDvAydyu0x1SAaspfFg1
         TtpW0NcRWkzh2vYm3BRdnPdHaUVnGO2tWj5G3aNT+0QZyLLkKqcU6/pV1BOzlEkBlBEC
         GvGNRESJCfMzlJNxF1A6vvLL4u5j/QDQOnjVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTaYB/LpPyXqzqoBt6V96BonKGbJkZZ+Zedm35NemXc=;
        b=S3wu6a+tnKPLuDKTFbwIDS9l4g3p64ADfwmEZ6+LSNpKArwsuyO0aT7OlU9QhVGFh2
         dAtqxWzdguLfYgwZAvLRuwzJ+awN589LVKYB//UnQS9SLFvhFQj7060cDm6yj5Aw95go
         FGraVXTftLsQBJAUQQrpQxkfmhHFFD/3XE2QuTngLeafURuYiWCmgtVnbhphs5sBpA6k
         z39lqGUk8MYUwHZZKALS+QpX7hNu8Kew3Jo96HQJbgXayPvBzssh7Jcl12FNdLSCoJAy
         8Wai/uHamBkaUqERMaCfg92z8cIZbAp6IFz3ISrkRU3J4n1seElF5+Yeenx2xaHAK32T
         2Hjg==
X-Gm-Message-State: ANoB5pnr5zlHjMLOcMQlmm8SE6c2TLnjkFtXc/SkyK/79c18va6IePQu
        Khpgq6oLu0zd5m464pXYxjknIKCHD0TEE3jS
X-Google-Smtp-Source: AA0mqf6PA0vC2Ze9Ol5vWcBrfkX48ILIPUttkxcRCBWGXOWaIYc1OzFHAB6SA0ebHpZk+uGXHn1hxA==
X-Received: by 2002:a17:907:7889:b0:78e:11ea:8528 with SMTP id ku9-20020a170907788900b0078e11ea8528mr696909ejc.190.1668145742237;
        Thu, 10 Nov 2022 21:49:02 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0077b523d309asm478867ejc.185.2022.11.10.21.49.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 21:49:01 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id q9so10465193ejd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:49:00 -0800 (PST)
X-Received: by 2002:a17:906:9f04:b0:7ae:ed2:5367 with SMTP id
 fy4-20020a1709069f0400b007ae0ed25367mr651463ejc.521.1668145740410; Thu, 10
 Nov 2022 21:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com> <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com> <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca> <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
In-Reply-To: <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 11 Nov 2022 14:48:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
Message-ID: <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>, mchehab@kernel.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@iki.fi, boris.brezillon@collabora.com,
        hiroh@chromium.org, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
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

On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote=
:
>
>
>
> On 11/11/22 01:06, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > Le samedi 05 novembre 2022 =C3=A0 23:19 +0800, Hsia-Jun Li a =C3=A9crit=
 :
> >>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
> >>>> VIDIOC_ENUM_FMT
> >>>> would just report NV12M.
> >>>
> >>> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
> >>> report both (unless I'm missing something, which is probably the case=
).
> >>>
> >>> The idea was to deprecate the M-variants one day.
> >> I was thinking the way in DRM API is better, always assuming it would
> >> always in a multiple planes. The only problem is we don't have a way t=
o
> >> let the allocator that allocate contiguous memory for planes when we
> >> need to do that.
> >
> > Its not too late to allow this to be negotiated, but I would move this =
out of
> > the pixel format definition to stop the explosion of duplicate pixel fo=
rmats,
> > which is a nightmare to deal with.
> I wonder whether we need to keep the pixel formats in videodev2.h
> anymore. If we would like to use the modifiers from drm_fourcc.h, why
> don't we use their pixel formats, they should be the same values of
> non-M variant pixel formats of v4l2.
>
> Let videodev2.h only maintain the those codecs or motion based
> compressed (pixel) formats.
>
> If I simplify the discussion, we want to
> > negotiate contiguity with the driver. The new FMT structure should have=
 a
> > CONTIGUOUS flag. So if userpace sets:
> >
> >    S_FMT(NV12, CONTIGUOUS)
> I wonder whether we would allow some planes being contiguous while some
> would not. For example, the graphics planes could be in a contiguous
> memory address while its compression metadata are not.
> Although that is not the case of our platform. I believe it sounds like
> reasonable case for improving the performance, two meta planes could
> resident in a different memory bank.

I feel like this would be only useful in the MMAP mode. Looking at how
the other UAPIs are evolving, things are going towards
userspace-managed allocations, using, for example, DMA-buf heaps. I
think we should follow the trend and keep the MMAP mode just at the
same level of functionality as is today and focus on improvements and
new functionality for the DMABUF mode.

>
> That lead to another question which I forgot whether I mention it before.
>
> There are four modifiers in DRM while we would only one in these patches.
>  From the EGL
> https://registry.khronos.org/EGL/extensions/EXT/EGL_EXT_image_dma_buf_imp=
ort_modifiers.txt
>
> The modifier for echo plane could be different. I wish it would be
> better to create a framebuffer being aware of which planes are graphics
> or metadata.

What's an echo plane?

That said, it indeed looks like we may want to be consistent with DRM
here and allow per-plane modifiers.

>
> I wonder whether it would be better that convincing the DRM maintainer
> adding a non vendor flag for contiguous memory allocation here(DRM
> itself don't need it).
> While whether the memory could be contiguous for these vendor pixel
> formats, it is complex vendor defined.

Memory allocation doesn't sound to me like it is related to formats or
modifiers in any way. I agree with Nicolas that if we want to allow
the userspace to specify if the memory should be contiguous or not,
that should be a separate flag and actually I'd probably see it in
REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.

>
> >
> > The driver can accepts, and return the unmodified structure, or may dro=
p the
> > CONTIGUOUS flag, which would mean its not supported. Could be the other=
 way
> > around too. As for allocation, if you have CONTIGUOUS flag set, userspa=
ce does
> > not have to export or map memory for each planes, as they are the same.=
 We
> > simply need to define the offset as relative to their allocation, which=
 I think
> > is the most sensible thing.
> >
> > Nicolas
> >
>
> --
> Hsia-Jun(Randy) Li
