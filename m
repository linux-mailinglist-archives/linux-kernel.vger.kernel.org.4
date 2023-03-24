Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0746C86B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCXUVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:21:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91E1A94D;
        Fri, 24 Mar 2023 13:21:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B21B2A58;
        Fri, 24 Mar 2023 21:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679689295;
        bh=k082uSrt6jNQq0wYKw9dlktMyGfVT1a6X+VmeRopIhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjQE14OQG/1rdUOuBbJvohFSBegnyZS9jPYY5Lhj5m5xjVQ1OJPx/QPJJxHmEGiXk
         oxQ6r8iqbugo67bppEFw0YuiMMMT9fwCwGbS8mMgppoOdT1QGXkMOAVYQ8ww48etkK
         37OWSXgkj0n17Xxk29IxOG2ZMCYZdkbUbUbV7Czo=
Date:   Fri, 24 Mar 2023 22:21:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        David Laight <David.Laight@ACULAB.COM>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Message-ID: <20230324202142.GB23868@pendragon.ideasonboard.com>
References: <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
 <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
 <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
 <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
 <20230319233358.GD20234@pendragon.ideasonboard.com>
 <f085aa9225c573df906bdc7ff032a8fd591b18b3.camel@ndufresne.ca>
 <20230322150153.GO20234@pendragon.ideasonboard.com>
 <2d6480e36ce061a63440d1e11d52b02e57ba746d.camel@ndufresne.ca>
 <68ba7b3f-57f5-3969-5036-2c8d08273548@xs4all.nl>
 <6f2979d33526e5ccdc32cf096415d8309fc91d3d.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f2979d33526e5ccdc32cf096415d8309fc91d3d.camel@ndufresne.ca>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:34:48AM -0400, Nicolas Dufresne wrote:
> Le vendredi 24 mars 2023 à 16:18 +0100, Hans Verkuil a écrit :
> > On 24/03/2023 16:14, Nicolas Dufresne wrote:
> > > Le mercredi 22 mars 2023 à 17:01 +0200, Laurent Pinchart a écrit :
> > > > On Wed, Mar 22, 2023 at 10:50:52AM -0400, Nicolas Dufresne wrote:
> > > > > Le lundi 20 mars 2023 à 01:33 +0200, Laurent Pinchart a écrit :
> > > > > > > The typical usage is that applications allocate N buffers with the
> > > > > > > VIDIOC_REQBUFS ioctl, and in most cases that's all they use.
> > > > > > 
> > > > > > Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd like to
> > > > > > encourage applications to use the new API, and deprecate REQBUFS
> > > > > > (dropping it isn't on my radar, as it would take forever before no
> > > > > > userspace uses it anymore).
> > > > > 
> > > > > I was wondering if you can extend on this. I'm worried the count semantic might
> > > > > prevent emulating it over create_bufs() ops, but if that works, did you meant to
> > > > > emulate it so driver no longer have to implement reqbufs() if they have
> > > > > create_bufs() ?
> > > > 
> > > > For drivers it should be fairly simply, as the reqbufs and create_bufs
> > > > ioctl handlers should just point to the corresponding videobuf2 helpers.
> > > > 
> > > > What I meant is that I'd like to encourage userspace to use the
> > > > VIDIOC_CREATE_BUFS ioctl instead of VIDIOC_REQBUFS.
> > > > 
> > > 
> > > I'm not sure what rationale I can give implementer to "encourage" them to use a
> > > more complex API that needs to copy over the FMT (which has just been set),
> > > specially in the initial pre-allocation case. For most, CREATE_BUFS after SMT
> > > will look like a very redundant and counter intuitive thing. Maybe you have a
> > > more optimistic view on the matter ? Or you have a better idea how we could give
> > > a meaning to having a fmt there on the initial case where the allocation matches
> > > the queue FMT ?
> > 
> > I wouldn't mind if we can make a much nicer CREATE_BUFS variant with just the
> > size instead of a format. That was in hindsight a really bad idea, terrible
> > over-engineering.
> 
> Note that all DRM allocators also includes width/height and some format related
> info (or the full info). This is because the driver deals with the alignment
> requirements. In some use cases (I have inter frame dynamic control in mind
> here) the fmt could be a mean to feedback the alignment (like bytesperline) back
> to the application where the stream is no longer homogeneous on the FMT.
> 
> That being said, If we move toward a size base allocator API, we could also just
> point back to an existing HEAP (or export an new heap if none are valid). And
> define the sizeimage(s) is now that information you need from the FMT to
> allocate anything + which heap needs to be used for the current setup.

If we could move away from allocating buffers within V4L2 to only
importing buffers allocated through the DMA heaps API, I'd be very
happy. That won't be simple though. Maybe a good candidate for
discussions during the media summit in Prague this year ?

-- 
Regards,

Laurent Pinchart
