Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E97717976
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjEaIDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjEaIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:03:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103B113;
        Wed, 31 May 2023 01:03:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205251136.34.openmobile.ne.jp [126.205.251.136])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D65BC7FC;
        Wed, 31 May 2023 10:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685520191;
        bh=wt0uiRzdch80CnCJ9txOoIRjRmXX6qZoPWCiyabu1Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mn1x0f1s/9rwZsiTDMjdaKF/ODQaR4TeIB2OzM9B/hKAXy4HY4Cf10xROgcoWmJCF
         3chtShGizyZ5Qh5bMXXa59Zo5C4yhOljSKBkIEWANe/vviW4BWGDL5RIiU8PBMXmGy
         a8pmkIVdRWePdvRt/3ueJ0RvZX48GbIRz/nbN3EE=
Date:   Wed, 31 May 2023 11:03:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Message-ID: <20230531080331.GB6496@pendragon.ideasonboard.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
 <6c4658fd-3a64-b3f8-67cd-17ed2d7d3567@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c4658fd-3a64-b3f8-67cd-17ed2d7d3567@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 08:36:59AM +0200, Hans Verkuil wrote:
> On 21/03/2023 11:28, Benjamin Gaignard wrote:
> > Add module parameter "max_vb_buffer_per_queue" to be able to limit
> > the number of vb2 buffers store in queue.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >  drivers/media/common/videobuf2/videobuf2-core.c | 15 +++------------
> >  include/media/videobuf2-core.h                  | 11 +++++++++--
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index ae9d72f4d181..f4da917ccf3f 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -34,6 +34,8 @@
> >  static int debug;
> >  module_param(debug, int, 0644);
> >  
> > +module_param(max_vb_buffer_per_queue, ulong, 0644);
> 
> There is no MODULE_PARM_DESC here? Please add. I see it is not there for
> the debug param either, it should be added for that as well.

Would this be the right time to consider resource accounting in V4L2 for
buffers ? Having a module parameter doesn't sound very useful, an
application could easily allocate more buffers by using buffer orphaning
(allocating buffers, exporting them as dmabuf objects, and freeing them,
which leaves the memory allocated). Repeating allocation cycles up to
max_vb_buffer_per_queue will allow allocating an unbounded number of
buffers, using all the available system memory. I'd rather not add a
module argument that only gives the impression of some kind of safety
without actually providing any value.

> > +
> >  #define dprintk(q, level, fmt, arg...)					\
> >  	do {								\
> >  		if (debug >= level)					\
> > @@ -412,10 +414,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> >  	struct vb2_buffer *vb;
> >  	int ret;
> >  
> > -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> > -	num_buffers = min_t(unsigned int, num_buffers,
> > -			    VB2_MAX_FRAME - q->num_buffers);
> > -
> >  	for (buffer = 0; buffer < num_buffers; ++buffer) {
> >  		/* Allocate vb2 buffer structures */
> >  		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
> > @@ -801,9 +799,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> >  	/*
> >  	 * Make sure the requested values and current defaults are sane.
> >  	 */
> > -	WARN_ON(q->min_buffers_needed > VB2_MAX_FRAME);
> >  	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
> > -	num_buffers = min_t(unsigned int, num_buffers, VB2_MAX_FRAME);
> >  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
> >  	/*
> >  	 * Set this now to ensure that drivers see the correct q->memory value
> > @@ -919,11 +915,6 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
> >  	bool no_previous_buffers = !q->num_buffers;
> >  	int ret;
> >  
> > -	if (q->num_buffers == VB2_MAX_FRAME) {
> > -		dprintk(q, 1, "maximum number of buffers already allocated\n");
> > -		return -ENOBUFS;
> > -	}
> > -
> >  	if (no_previous_buffers) {
> >  		if (q->waiting_in_dqbuf && *count) {
> >  			dprintk(q, 1, "another dup()ped fd is waiting for a buffer\n");
> > @@ -948,7 +939,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
> >  			return -EINVAL;
> >  	}
> >  
> > -	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> > +	num_buffers = *count;
> >  
> >  	if (requested_planes && requested_sizes) {
> >  		num_planes = requested_planes;
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > index 397dbf6e61e1..b8b34a993e04 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -12,6 +12,7 @@
> >  #ifndef _MEDIA_VIDEOBUF2_CORE_H
> >  #define _MEDIA_VIDEOBUF2_CORE_H
> >  
> > +#include <linux/minmax.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/mutex.h>
> >  #include <linux/poll.h>
> > @@ -48,6 +49,8 @@ struct vb2_fileio_data;
> >  struct vb2_threadio_data;
> >  struct vb2_buffer;
> >  
> > +static size_t max_vb_buffer_per_queue = 1024;
> > +
> >  /**
> >   * struct vb2_mem_ops - memory handling/memory allocator operations.
> >   * @alloc:	allocate video memory and, optionally, allocator private data,
> > @@ -1268,12 +1271,16 @@ static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *
> >  
> >  	if (vb->index >= q->max_num_bufs) {
> >  		struct vb2_buffer **tmp;
> > +		int cnt = min(max_vb_buffer_per_queue, q->max_num_bufs * 2);
> > +
> > +		if (cnt >= q->max_num_bufs)
> > +			goto realloc_failed;
> >  
> > -		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
> > +		tmp = krealloc_array(q->bufs, cnt, sizeof(*q->bufs), GFP_KERNEL);
> >  		if (!tmp)
> >  			goto realloc_failed;
> >  
> > -		q->max_num_bufs *= 2;
> > +		q->max_num_bufs = cnt;
> >  		q->bufs = tmp;
> >  	}
> >  

-- 
Regards,

Laurent Pinchart
