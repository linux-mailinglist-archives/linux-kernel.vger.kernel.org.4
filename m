Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35242727D10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFHKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFHKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:42:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC21AB;
        Thu,  8 Jun 2023 03:42:25 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126033089000.35.openmobile.ne.jp [126.33.89.0])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18545480;
        Thu,  8 Jun 2023 12:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686220917;
        bh=HpyajXFq3Bn1xOynZKfJ657CvXa2Mt/KDZmQlXLGLBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4RD0gh/QbIyDCJw62QTaUdUTBgP5VKks+vXeLL9ThBAp+gdlvk3SqC0WnuLYuOFu
         kwDxjbDfNJhew0OqUoJ4/hWE5AdtvGP6tOc/K9oqjh0dFOn8FzbSh2pDm98NhXxZIJ
         wFjJd1htwDvwt8L0FKM8KSojiUSEugsNb6e0gVMk=
Date:   Thu, 8 Jun 2023 13:42:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Message-ID: <20230608104220.GP5058@pendragon.ideasonboard.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
 <6c4658fd-3a64-b3f8-67cd-17ed2d7d3567@xs4all.nl>
 <20230531080331.GB6496@pendragon.ideasonboard.com>
 <608ae7d6-3f3b-137d-08d2-d41a240be2c4@xs4all.nl>
 <20230531123945.GF27043@pendragon.ideasonboard.com>
 <CAAFQd5A6sz1BhEjiWyXH6B1TBTLt0ivAc6N0Vd73hebnpc7fKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5A6sz1BhEjiWyXH6B1TBTLt0ivAc6N0Vd73hebnpc7fKQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Thu, Jun 08, 2023 at 07:24:29PM +0900, Tomasz Figa wrote:
> On Wed, May 31, 2023 at 9:39 PM Laurent Pinchart wrote:
> > On Wed, May 31, 2023 at 10:30:36AM +0200, Hans Verkuil wrote:
> > > On 5/31/23 10:03, Laurent Pinchart wrote:
> > > > On Wed, May 31, 2023 at 08:36:59AM +0200, Hans Verkuil wrote:
> > > >> On 21/03/2023 11:28, Benjamin Gaignard wrote:
> > > >>> Add module parameter "max_vb_buffer_per_queue" to be able to limit
> > > >>> the number of vb2 buffers store in queue.
> > > >>>
> > > >>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > >>> ---
> > > >>>  drivers/media/common/videobuf2/videobuf2-core.c | 15 +++------------
> > > >>>  include/media/videobuf2-core.h                  | 11 +++++++++--
> > > >>>  2 files changed, 12 insertions(+), 14 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > > >>> index ae9d72f4d181..f4da917ccf3f 100644
> > > >>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > > >>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > > >>> @@ -34,6 +34,8 @@
> > > >>>  static int debug;
> > > >>>  module_param(debug, int, 0644);
> > > >>>
> > > >>> +module_param(max_vb_buffer_per_queue, ulong, 0644);
> > > >>
> > > >> There is no MODULE_PARM_DESC here? Please add. I see it is not there for
> > > >> the debug param either, it should be added for that as well.
> > > >
> > > > Would this be the right time to consider resource accounting in V4L2 for
> > > > buffers ? Having a module parameter doesn't sound very useful, an
> > > > application could easily allocate more buffers by using buffer orphaning
> > > > (allocating buffers, exporting them as dmabuf objects, and freeing them,
> > > > which leaves the memory allocated). Repeating allocation cycles up to
> > > > max_vb_buffer_per_queue will allow allocating an unbounded number of
> > > > buffers, using all the available system memory. I'd rather not add a
> > > > module argument that only gives the impression of some kind of safety
> > > > without actually providing any value.
> 
> Good point. It's even simpler, just keep opening new vim2m instances
> and requesting max buffers :).
> 
> > >
> > > Does dmabuf itself provide some accounting mechanism? Just wondering.
> > >
> > > More specific to V4L2: I'm not so sure about this module parameter either.
> > > It makes sense to have a check somewhere against ridiculous values (i.e.
> > > allocating MAXINT buffers), but that can be a define as well. But otherwise
> > > I am fine with allowing applications to allocate buffers until the memory
> > > is full.
> > >
> > > The question is really: what is this parameter supposed to do? The only
> > > thing it does is to sanitize unlikely inputs (e.g. allocating MAXINT buffers).
> > >
> > > I prefer that as a define, to be honest.
> > >
> > > I think it is perfectly fine for users to try to request more buffers than
> > > memory allows. It will just fail in that case, not a problem.
> > >
> > > And if an application is doing silly things like buffer orphaning, then so
> > > what? Is that any different than allocating memory and not freeing it?
> > > Eventually it will run out of memory and crash, which is normal.
> >
> > Linux provides APIs to account for and limit usage of resources,
> > including memory. A system administrator can prevent rogue processes
> > from starving system resources. The memory consumed by vb2 buffer isn't
> > taken into account, making V4L2 essentially unsafe for untrusted
> > processes.
> 
> I agree that proper accounting would be useful, although I wouldn't
> really make this patch series depend on it, since it's not introducing
> the loophole in the first place.

No disagreement here, my concern was about introducing a workaround for
the lack of proper memory accounting. I'd like to avoid the workaround,
but it doesn't mean memory accounting has to be implement now.

> We had some discussion about this in ChromeOS long ago and we thought
> it would be really useful for killing browser tabs with big videos,
> but otherwise using very little regular memory (e.g. via javascript).
> 
> One challenge with accounting V4L2 allocations is how to count shared
> DMA-bufs. If one process allocates a V4L2 buffer, exports it to
> DMA-buf and then sends it to another process that keeps it alive, but
> frees the V4L2 buffer (and even closes the DMA-buf fd), should that
> memory be still accounted to it even though it doesn't hold a
> reference to it anymore?

I've thought about that too. It's an annoying problem, it should
probably be discussed with memory management developers.

> > Now, to be fair, there are many reasons why allowing access to v4L2
> > devices to untrusted applications is a bad idea, and memory consumption
> > is likely not even the worst one. Still, is this something we want to
> > fix, or do we want to consider V4L2 to be priviledged API only ? Right
> > now we can't do so, but with many Linux systems moving towards pipewire,
> > we could possibly have a system daemon isolating untrusted applications
> > from the rest of the system. We may thus not need to fix this in the
> > V4L2 API.

-- 
Regards,

Laurent Pinchart
