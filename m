Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B43862558B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiKKInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:43:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB1742FC;
        Fri, 11 Nov 2022 00:43:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49F32283;
        Fri, 11 Nov 2022 09:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668156185;
        bh=fn4ioUaBzLJcV7m3KMl94OYt9U6PKXTcA3EHnoLwpR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPPV/TjiF+bwV3C90x3AWMaZx1MEE0ntEDQSf/M7zUyx9jKYCsMypPJG8aguAsyBz
         5YZFJjWLFU6EYt8yHgaxKEzVmmX7Ys1kfKR8fu4Ll/zUIXLLuad6Mek6V9KixL8U5M
         ztutX1zjLpQSnGfhRnhmuQ1joGFWzUwlEVBNHKTY=
Date:   Fri, 11 Nov 2022 10:42:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, mchehab@kernel.org,
        hans.verkuil@cisco.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Message-ID: <Y24LBrkveiXlmCMy@pendragon.ideasonboard.com>
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
 <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
 <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Fri, Nov 11, 2022 at 02:48:48PM +0900, Tomasz Figa wrote:
> On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li wrote:
> > On 11/11/22 01:06, Nicolas Dufresne wrote:
> > > Le samedi 05 novembre 2022 à 23:19 +0800, Hsia-Jun Li a écrit :
> > >>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
> > >>>> VIDIOC_ENUM_FMT
> > >>>> would just report NV12M.
> > >>>
> > >>> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
> > >>> report both (unless I'm missing something, which is probably the case).
> > >>>
> > >>> The idea was to deprecate the M-variants one day.
> > >> I was thinking the way in DRM API is better, always assuming it would
> > >> always in a multiple planes. The only problem is we don't have a way to
> > >> let the allocator that allocate contiguous memory for planes when we
> > >> need to do that.
> > >
> > > Its not too late to allow this to be negotiated, but I would move this out of
> > > the pixel format definition to stop the explosion of duplicate pixel formats,
> > > which is a nightmare to deal with.
> > 
> > I wonder whether we need to keep the pixel formats in videodev2.h
> > anymore. If we would like to use the modifiers from drm_fourcc.h, why
> > don't we use their pixel formats, they should be the same values of
> > non-M variant pixel formats of v4l2.
> >
> > Let videodev2.h only maintain the those codecs or motion based
> > compressed (pixel) formats.
> >
> > If I simplify the discussion, we want to
> > 
> > > negotiate contiguity with the driver. The new FMT structure should have a
> > > CONTIGUOUS flag. So if userpace sets:
> > >
> > >    S_FMT(NV12, CONTIGUOUS)
> > 
> > I wonder whether we would allow some planes being contiguous while some
> > would not. For example, the graphics planes could be in a contiguous
> > memory address while its compression metadata are not.
> > Although that is not the case of our platform. I believe it sounds like
> > reasonable case for improving the performance, two meta planes could
> > resident in a different memory bank.
> 
> I feel like this would be only useful in the MMAP mode. Looking at how
> the other UAPIs are evolving, things are going towards
> userspace-managed allocations, using, for example, DMA-buf heaps. I
> think we should follow the trend and keep the MMAP mode just at the
> same level of functionality as is today and focus on improvements and
> new functionality for the DMABUF mode.

I agree, but we will need an API to expose the memory constraints of the
device, or userspace won't be able to allocate memory compatible with
the hardware or driver requirements.

> > That lead to another question which I forgot whether I mention it before.
> >
> > There are four modifiers in DRM while we would only one in these patches.
> >  From the EGL
> > https://registry.khronos.org/EGL/extensions/EXT/EGL_EXT_image_dma_buf_import_modifiers.txt
> >
> > The modifier for echo plane could be different. I wish it would be
> > better to create a framebuffer being aware of which planes are graphics
> > or metadata.
> 
> What's an echo plane?
> 
> That said, it indeed looks like we may want to be consistent with DRM
> here and allow per-plane modifiers.
> 
> > I wonder whether it would be better that convincing the DRM maintainer
> > adding a non vendor flag for contiguous memory allocation here(DRM
> > itself don't need it).
> > While whether the memory could be contiguous for these vendor pixel
> > formats, it is complex vendor defined.
> 
> Memory allocation doesn't sound to me like it is related to formats or
> modifiers in any way. I agree with Nicolas that if we want to allow
> the userspace to specify if the memory should be contiguous or not,
> that should be a separate flag and actually I'd probably see it in
> REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.

I like how DRM decouples allocation of buffer objects and creation of
frame buffers.

> > > The driver can accepts, and return the unmodified structure, or may drop the
> > > CONTIGUOUS flag, which would mean its not supported. Could be the other way
> > > around too. As for allocation, if you have CONTIGUOUS flag set, userspace does
> > > not have to export or map memory for each planes, as they are the same. We
> > > simply need to define the offset as relative to their allocation, which I think
> > > is the most sensible thing.

-- 
Regards,

Laurent Pinchart
