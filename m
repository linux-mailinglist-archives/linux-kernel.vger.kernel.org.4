Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB462BEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiKPNDj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Nov 2022 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKPND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:03:26 -0500
X-Greylist: delayed 897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 05:03:22 PST
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066E40455;
        Wed, 16 Nov 2022 05:03:22 -0800 (PST)
Received: from [192.168.10.76] (unknown [140.207.23.225])
        by kozue.soulik.info (Postfix) with ESMTPSA id 943FF1007FF;
        Wed, 16 Nov 2022 21:38:27 +0900 (JST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify single/multi-planar handling (and more)
From:   ayaka <ayaka@soulik.info>
In-Reply-To: <df2a19b7fd0238808f00973b2cb5f4f478c38ef9.camel@ndufresne.ca>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <randy.li@synaptics.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@iki.fi, boris.brezillon@collabora.com,
        hiroh@chromium.org, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Date:   Wed, 16 Nov 2022 20:38:25 +0800
Message-Id: <4F8FA564-9F66-4A12-8025-0B8D975A29E2@soulik.info>
References: <df2a19b7fd0238808f00973b2cb5f4f478c38ef9.camel@ndufresne.ca>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
X-Mailer: iPad Mail (18D61)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 16, 2022, at 12:03 AM, Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> ﻿CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le vendredi 11 novembre 2022 à 17:52 +0900, Tomasz Figa a écrit :
>>>> Memory allocation doesn't sound to me like it is related to formats or
>>>> modifiers in any way. I agree with Nicolas that if we want to allow
>>>> the userspace to specify if the memory should be contiguous or not,
>>>> that should be a separate flag and actually I'd probably see it in
>>>> REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
>>> I agree with that. But here is a problem, if there was a display
>>> device(DRM) that only supports contiguous planes in a frame buffer.
>>> How do we be aware of that?
>> 
>> That's why I think the MMAP mode is not scalable and shouldn't be
>> expanded anymore. Both V4L2 and DRM devices should describe their
>> constraints to the userspace and then the userspace should allocate
>> accordingly from the right DMA-buf heap. (Or as Android and ChromeOS
>> do, just have a central allocator library that understands the
>> constraints, so there is no need to query the drivers.)
> 
> Just pointing out, they "hardcode" the constraints, they don't truly understand
> them. Also, the Android/ChromeOS implementation is not a great playground, as it
> completely ignores the constrait already exposed by V4L2 API (the sizeimage and
> bytesperline found in the FMT structure). You would not have to implement Hantro
> and Rockchip motion vector size calculation there if you'd simply use the
> sizeimage.
> 
About the allocation, I have my own plan here. Beyond the draft of DMAHeap allocator I threw last time.
I would like to modify the v4l2_queue API:
1. allowing different allocators for each memory plane(that matches the demand of synaptics video smart platform, which graphic planes support IOMMU while the compression metadata planes don’t).
2. New API that let driver allocate all memory planes for a buffer in a call

And DMAHeap V4l2 allocator would become a template or currying.

> Nicolas

