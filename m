Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA7716B43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjE3Rio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjE3Rin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:38:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A058B2;
        Tue, 30 May 2023 10:38:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205198071.34.openmobile.ne.jp [126.205.198.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68C084A9;
        Tue, 30 May 2023 19:38:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685468298;
        bh=aWLEljEa4WBDYidz22ghKKHo6cHXsO43Tw4K7iTQ6hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9jtKbXxW+cOBY9Kwb7daVQCzjgcT8IDF5LCmE02LSMSZZUczzxgkrSGmpwD5dy/G
         F6hWETU4pZUvl59kgiOTruU0PEAQ8FIklRLCBbZZJbgguK41qQjPP8CIBz5vNOoTsf
         Mkr9l0lcyGWCxG1bDXKaTRCby3NYIPW5RHpsz44o=
Date:   Tue, 30 May 2023 20:38:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        m.szyprowski@samsung.com, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, eagle.zhou@nxp.com, bin.liu@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, daniel.almeida@collabora.com,
        hverkuil-cisco@xs4all.nl, jernel@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/8] media: videobuf2: Add a module param to limit vb2
 queue buffer storage
Message-ID: <20230530173839.GH22516@pendragon.ideasonboard.com>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-4-benjamin.gaignard@collabora.com>
 <20230519101916.dt25jofubidrasd2@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519101916.dt25jofubidrasd2@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:19:16AM +0000, Tomasz Figa wrote:
> On Tue, Mar 21, 2023 at 11:28:50AM +0100, Benjamin Gaignard wrote:
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
> 
> We should keep the validation here, just using the new module parameter
> instead of VB2_MAX_FRAME. Otherwise we let the userspace pass
> UINT_MAX to REQBUFS and have the array below exhaust the system memory.
> 
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
> 
> Similar concern here.
> 
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
> 
> Ditto.
> 
> >  	if (no_previous_buffers) {
> >  		if (q->waiting_in_dqbuf && *count) {
> >  			dprintk(q, 1, "another dup()ped fd is waiting for a buffer\n");
> > @@ -948,7 +939,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
> >  			return -EINVAL;
> >  	}
> >  
> > -	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);
> > +	num_buffers = *count;
> 
> Ditto.
> 
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
> 
> Should cnt also be size_t to match max_vb_buffer_per_queue?
> This could also overflow given q->max_num_bufs big enough, so maybe it
> would just be better to rewrite to?
> 
> size_t cnt = (q->max_num_bufs > max_vb_buffer_per_queue / 2) ?
> 		max_vb_buffer_per_queue : q->max_num_bufs * 2;
> 
> Or we could just switch to XArray and it would solve this for us. :)

I like using existing libraries instead of reinventing the wheel :-)

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
