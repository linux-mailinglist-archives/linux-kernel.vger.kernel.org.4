Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5076255C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiKKIyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiKKIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:54:19 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3B7742F5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:54:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id 13so11180995ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE18/cCuxFVZ0pa3JlpYCtd8rwhqfTG6tMqmRyx7iVM=;
        b=QZ6cEviu0bmXteRZ1EBvIxfQezqih5TF1m8hzZPRhP6kqOUntcRhfgLxP7dBKXJSMv
         t8btOgCwjhfE2P8LqgX5D9A8OXP0SpdLzun3CBgu8f3zorefRofUDZW+e+GdY93DyM2N
         FeOyM4XoKNgGoNkWri8/WFNQroD+PkU9nBM44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cE18/cCuxFVZ0pa3JlpYCtd8rwhqfTG6tMqmRyx7iVM=;
        b=ZNAhl4UC0AnAGhaEhHljVqb7OQB1B61sjvDpAZhpQDLaqAE+vhoZiU4UDbZVGHAtaZ
         wo86ZATa68MruOPcA1PgUQTjDDDUoNnLFkL+OM6grnWjeSUsLskyRZwMBxIjvs+BEdpj
         UnkAkioFO79y6R9vnLp2WDKUOosRs2T9yl6aibkqpR5+ZWCaU2CscssC3JrTYBnY0WE7
         oAlzWofWUALopl2LlAACF7OSd0D5nvJyKRcqf5Sco+f6cOsSDJy6vy6YLKdFL2ofaJYk
         h0Pu946gcCdvr16zX5PCGQfDt5y9SXTpzE5tKXL0Hz0rtZqzZ3O2/Czm5iqD3Hb0VhJB
         FHIw==
X-Gm-Message-State: ANoB5plBub28sU2RteUPi/5Aub5+qZjYSvmqdvk0tAIObzQ/YwphfQpA
        OC97nhJGBWySYf6xBvyKApfox8wbVA5rYxZ9
X-Google-Smtp-Source: AA0mqf5tmO1K654oZcVPzSDMn/jbAhfumTeNrR/NNt0XJe/YEmmKv8/+Cq35mqM8Fyc5fXrBAO5C3w==
X-Received: by 2002:a17:906:2e97:b0:7ad:79c0:547a with SMTP id o23-20020a1709062e9700b007ad79c0547amr1150149eji.41.1668156856050;
        Fri, 11 Nov 2022 00:54:16 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id qx17-20020a170906fcd100b0073d7ab84375sm655801ejb.92.2022.11.11.00.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:54:14 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id f27so11180192eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:54:13 -0800 (PST)
X-Received: by 2002:a17:906:4e48:b0:73d:dfb2:d188 with SMTP id
 g8-20020a1709064e4800b0073ddfb2d188mr1123926ejw.426.1668156853340; Fri, 11
 Nov 2022 00:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com> <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com> <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
 <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com> <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
 <Y24LBrkveiXlmCMy@pendragon.ideasonboard.com>
In-Reply-To: <Y24LBrkveiXlmCMy@pendragon.ideasonboard.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 11 Nov 2022 17:54:01 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DZG9QDp-+e8Xs7gKL=ZLkm3hA1-=eJZe8hjoB42xE5qw@mail.gmail.com>
Message-ID: <CAAFQd5DZG9QDp-+e8Xs7gKL=ZLkm3hA1-=eJZe8hjoB42xE5qw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, mchehab@kernel.org,
        hans.verkuil@cisco.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        Brian.Starkey@arm.com, kernel@collabora.com,
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

On Fri, Nov 11, 2022 at 5:43 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Tomasz,
>
> On Fri, Nov 11, 2022 at 02:48:48PM +0900, Tomasz Figa wrote:
> > On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li wrote:
> > > On 11/11/22 01:06, Nicolas Dufresne wrote:
> > > > Le samedi 05 novembre 2022 =C3=A0 23:19 +0800, Hsia-Jun Li a =C3=A9=
crit :
> > > >>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
> > > >>>> VIDIOC_ENUM_FMT
> > > >>>> would just report NV12M.
> > > >>>
> > > >>> If NV12 and NV12M are equivalent in Ext API, I don't see why we w=
ould
> > > >>> report both (unless I'm missing something, which is probably the =
case).
> > > >>>
> > > >>> The idea was to deprecate the M-variants one day.
> > > >> I was thinking the way in DRM API is better, always assuming it wo=
uld
> > > >> always in a multiple planes. The only problem is we don't have a w=
ay to
> > > >> let the allocator that allocate contiguous memory for planes when =
we
> > > >> need to do that.
> > > >
> > > > Its not too late to allow this to be negotiated, but I would move t=
his out of
> > > > the pixel format definition to stop the explosion of duplicate pixe=
l formats,
> > > > which is a nightmare to deal with.
> > >
> > > I wonder whether we need to keep the pixel formats in videodev2.h
> > > anymore. If we would like to use the modifiers from drm_fourcc.h, why
> > > don't we use their pixel formats, they should be the same values of
> > > non-M variant pixel formats of v4l2.
> > >
> > > Let videodev2.h only maintain the those codecs or motion based
> > > compressed (pixel) formats.
> > >
> > > If I simplify the discussion, we want to
> > >
> > > > negotiate contiguity with the driver. The new FMT structure should =
have a
> > > > CONTIGUOUS flag. So if userpace sets:
> > > >
> > > >    S_FMT(NV12, CONTIGUOUS)
> > >
> > > I wonder whether we would allow some planes being contiguous while so=
me
> > > would not. For example, the graphics planes could be in a contiguous
> > > memory address while its compression metadata are not.
> > > Although that is not the case of our platform. I believe it sounds li=
ke
> > > reasonable case for improving the performance, two meta planes could
> > > resident in a different memory bank.
> >
> > I feel like this would be only useful in the MMAP mode. Looking at how
> > the other UAPIs are evolving, things are going towards
> > userspace-managed allocations, using, for example, DMA-buf heaps. I
> > think we should follow the trend and keep the MMAP mode just at the
> > same level of functionality as is today and focus on improvements and
> > new functionality for the DMABUF mode.
>
> I agree, but we will need an API to expose the memory constraints of the
> device, or userspace won't be able to allocate memory compatible with
> the hardware or driver requirements.

Yes, I fully agree and that's why I think we should rather focus our
efforts in that direction rather than expanding the existing MMAP
capabilities.

>
> > > That lead to another question which I forgot whether I mention it bef=
ore.
> > >
> > > There are four modifiers in DRM while we would only one in these patc=
hes.
> > >  From the EGL
> > > https://registry.khronos.org/EGL/extensions/EXT/EGL_EXT_image_dma_buf=
_import_modifiers.txt
> > >
> > > The modifier for echo plane could be different. I wish it would be
> > > better to create a framebuffer being aware of which planes are graphi=
cs
> > > or metadata.
> >
> > What's an echo plane?
> >
> > That said, it indeed looks like we may want to be consistent with DRM
> > here and allow per-plane modifiers.
> >
> > > I wonder whether it would be better that convincing the DRM maintaine=
r
> > > adding a non vendor flag for contiguous memory allocation here(DRM
> > > itself don't need it).
> > > While whether the memory could be contiguous for these vendor pixel
> > > formats, it is complex vendor defined.
> >
> > Memory allocation doesn't sound to me like it is related to formats or
> > modifiers in any way. I agree with Nicolas that if we want to allow
> > the userspace to specify if the memory should be contiguous or not,
> > that should be a separate flag and actually I'd probably see it in
> > REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
>
> I like how DRM decouples allocation of buffer objects and creation of
> frame buffers.

Exactly why I proposed so rather than coupling it with S_FMT. (But
then it's moot if we decide to focus on DMABUF mode.)

>
> > > > The driver can accepts, and return the unmodified structure, or may=
 drop the
> > > > CONTIGUOUS flag, which would mean its not supported. Could be the o=
ther way
> > > > around too. As for allocation, if you have CONTIGUOUS flag set, use=
rspace does
> > > > not have to export or map memory for each planes, as they are the s=
ame. We
> > > > simply need to define the offset as relative to their allocation, w=
hich I think
> > > > is the most sensible thing.
>
> --
> Regards,
>
> Laurent Pinchart
