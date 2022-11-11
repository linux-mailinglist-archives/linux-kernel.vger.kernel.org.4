Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2C6255C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiKKIws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiKKIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:52:46 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0759742F0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:52:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so11098557ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiydaOC6bZdEhN21ButnrxAj6J1ajurIBtcHIo96ANM=;
        b=YHNHpU1wIJqSt66QMvC3Asd7Fs969LcqCVwePpBpjH04J9sOnjXFHPpf/4RQnS47T/
         p5RDljeRRzCqBmWPeHTLPG8b5mD5onnw+S7RaP00KRRiNQEP/VNGiPiwpPLRaHixDVoP
         PsZ99HjPW48NHgp0EN9B45Gw5NaA8wlqv9GR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiydaOC6bZdEhN21ButnrxAj6J1ajurIBtcHIo96ANM=;
        b=VMYG9sk56s/BRzAVXtmtCv8yHJBP38E7aodrp3bow7eYZOF3bX+MUD9clz4gS+QJ7c
         Os/j/peXU5IeHkC1BqAbzHNY8oM1AvWc5uslDDV0eIzVZ/ykP4aOWe30e83p9Mycg6P4
         ki6P12vlRGM4MAcY29iPhOyV5p21ib3dzRjoxM6Q7ldU9jgOMKhk8hcKlBzaI1qUSaPv
         IZwExndqMLvT8G3cem9ZQHZNVaiLxc7LVjQKmAber/3XGF61QVVimtHpKrqBITWHAOcW
         catKT965l17jCEHKguGDro2Kkg+LUQ5hx0jYjs2Tzk7qj2blX38992tjb20GjLU5fgKC
         P+OA==
X-Gm-Message-State: ANoB5pmv8qwbV+VwFMhVGF9cr4unLiMlHdjehC85JgUBkIJt8uDjh+Xs
        KIb2tzPh4/tAk18kXayo+AK4cKFdBU5c9vjn
X-Google-Smtp-Source: AA0mqf5lXZ470SLsf8c+/HGhz3v61MFhz3gcRjuSq4EFtVM7t4CVpbm97t2F8sD8rPmP5vLZPjUYiw==
X-Received: by 2002:a17:906:f886:b0:7ae:180f:e6e with SMTP id lg6-20020a170906f88600b007ae180f0e6emr1038215ejb.498.1668156763081;
        Fri, 11 Nov 2022 00:52:43 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b007aec44edcfcsm451271ejb.75.2022.11.11.00.52.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:52:41 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id kt23so11098282ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:52:40 -0800 (PST)
X-Received: by 2002:a17:906:9f04:b0:7ae:ed2:5367 with SMTP id
 fy4-20020a1709069f0400b007ae0ed25367mr1085959ejc.521.1668156759971; Fri, 11
 Nov 2022 00:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com> <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com> <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
 <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com> <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
 <91a96b4a-a91e-aae6-733f-c307ca6840f0@synaptics.com>
In-Reply-To: <91a96b4a-a91e-aae6-733f-c307ca6840f0@synaptics.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 11 Nov 2022 17:52:28 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
Message-ID: <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 3:31 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>
>
>
> On 11/11/22 13:48, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >
> >
> > On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li <Randy.Li@synaptics.com> w=
rote:
> >>
> >>
> >>
> >> On 11/11/22 01:06, Nicolas Dufresne wrote:
> >>> CAUTION: Email originated externally, do not click links or open atta=
chments unless you recognize the sender and know the content is safe.
> >>>
> >>>
> >>> Le samedi 05 novembre 2022 =C3=A0 23:19 +0800, Hsia-Jun Li a =C3=A9cr=
it :
> >>>>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
> >>>>>> VIDIOC_ENUM_FMT
> >>>>>> would just report NV12M.
> >>>>>
> >>>>> If NV12 and NV12M are equivalent in Ext API, I don't see why we wou=
ld
> >>>>> report both (unless I'm missing something, which is probably the ca=
se).
> >>>>>
> >>>>> The idea was to deprecate the M-variants one day.
> >>>> I was thinking the way in DRM API is better, always assuming it woul=
d
> >>>> always in a multiple planes. The only problem is we don't have a way=
 to
> >>>> let the allocator that allocate contiguous memory for planes when we
> >>>> need to do that.
> >>>
> >>> Its not too late to allow this to be negotiated, but I would move thi=
s out of
> >>> the pixel format definition to stop the explosion of duplicate pixel =
formats,
> >>> which is a nightmare to deal with.
> >> I wonder whether we need to keep the pixel formats in videodev2.h
> >> anymore. If we would like to use the modifiers from drm_fourcc.h, why
> >> don't we use their pixel formats, they should be the same values of
> >> non-M variant pixel formats of v4l2.
> >>
> >> Let videodev2.h only maintain the those codecs or motion based
> >> compressed (pixel) formats.
> >>
> >> If I simplify the discussion, we want to
> >>> negotiate contiguity with the driver. The new FMT structure should ha=
ve a
> >>> CONTIGUOUS flag. So if userpace sets:
> >>>
> >>>     S_FMT(NV12, CONTIGUOUS)
> >> I wonder whether we would allow some planes being contiguous while som=
e
> >> would not. For example, the graphics planes could be in a contiguous
> >> memory address while its compression metadata are not.
> >> Although that is not the case of our platform. I believe it sounds lik=
e
> >> reasonable case for improving the performance, two meta planes could
> >> resident in a different memory bank.
> >
> > I feel like this would be only useful in the MMAP mode. Looking at how
> > the other UAPIs are evolving, things are going towards
> > userspace-managed allocations, using, for example, DMA-buf heaps. I
> > think we should follow the trend and keep the MMAP mode just at the
> > same level of functionality as is today and focus on improvements and
> > new functionality for the DMABUF mode.
> >
> I know there are still some devices(encoder) which only have one
> register for storing the address of a graphics buffer.

For those, the legacy MMAP mode (with existing functionality) can be
successfully used, we wouldn't be removing it any time soon. Just
don't want to design new functionality specifically for the legacy
mode.

> >>
> >> That lead to another question which I forgot whether I mention it befo=
re.
> >>
> >> There are four modifiers in DRM while we would only one in these patch=
es.
> >>   From the EGL
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__registry.khrono=
s.org_EGL_extensions_EXT_EGL-5FEXT-5Fimage-5Fdma-5Fbuf-5Fimport-5Fmodifiers=
.txt&d=3DDwIFaQ&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7=
biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=3DmCebYOAiZK6pbpH1MrZGq-ZkDW-OqORCSw=
sCEX9ScgdXk_yfWZFJPC5aC93CUg5F&s=3DrtmW_t2LYoJ6g3Y5wgyICmABu-2Npw3JCOlvUVIY=
H2o&e=3D
> >>
> >> The modifier for echo plane could be different. I wish it would be
> >> better to create a framebuffer being aware of which planes are graphic=
s
> >> or metadata.
> >
> > What's an echo plane?
> >
> They could be
> DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
> DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
> DRM_FORMAT_MOD_SYNA_MTR
> DRM_FORMAT_MOD_SYNA_MTR
> Or
> DRM_FORMAT_MOD_SYNA_V4H3P8_64L4
> DRM_FORMAT_MOD_SYNA_V4H3P8_64L4
>
> in our platform. It could give a better idea on what is stored in a plane=
.

Yes, that's what I was thinking, but my question is more about what
those planes hold. Are you sure that they should be planes of the same
buffer rather than separate buffers?

> > That said, it indeed looks like we may want to be consistent with DRM
> > here and allow per-plane modifiers.
> >
> >>
> >> I wonder whether it would be better that convincing the DRM maintainer
> >> adding a non vendor flag for contiguous memory allocation here(DRM
> >> itself don't need it).
> >> While whether the memory could be contiguous for these vendor pixel
> >> formats, it is complex vendor defined.
> >
> > Memory allocation doesn't sound to me like it is related to formats or
> > modifiers in any way. I agree with Nicolas that if we want to allow
> > the userspace to specify if the memory should be contiguous or not,
> > that should be a separate flag and actually I'd probably see it in
> > REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
> >
> I agree with that. But here is a problem, if there was a display
> device(DRM) that only supports contiguous planes in a frame buffer.
> How do we be aware of that?

That's why I think the MMAP mode is not scalable and shouldn't be
expanded anymore. Both V4L2 and DRM devices should describe their
constraints to the userspace and then the userspace should allocate
accordingly from the right DMA-buf heap. (Or as Android and ChromeOS
do, just have a central allocator library that understands the
constraints, so there is no need to query the drivers.)

> >>
> >>>
> >>> The driver can accepts, and return the unmodified structure, or may d=
rop the
> >>> CONTIGUOUS flag, which would mean its not supported. Could be the oth=
er way
> >>> around too. As for allocation, if you have CONTIGUOUS flag set, users=
pace does
> >>> not have to export or map memory for each planes, as they are the sam=
e. We
> >>> simply need to define the offset as relative to their allocation, whi=
ch I think
> >>> is the most sensible thing.
> >>>
> >>> Nicolas
> >>>
> >>
> >> --
> >> Hsia-Jun(Randy) Li
>
> --
> Hsia-Jun(Randy) Li
