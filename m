Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7685709468
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjESKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjESKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:05:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4612B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:04:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d11974b45so1379833b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684490699; x=1687082699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xTS/+ikRkp6T2vKwWJPFVIVMKM4hxn92K6n0PRCytk=;
        b=kknctPkpZrVOtKToPJl+ulrI88aXtNavFYH10YxLF2I4G2cDXB2nOfkmYVnypLwYOr
         97CSCYF/uB4e6h6q791T5909bZmXXMvpBslfC1NgSzpFMpUcERN+W6b7wZnnsDCim1LE
         CU2uKf5iyeHjv4M2QrZ1p3QERw1tEVISL+9CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490699; x=1687082699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xTS/+ikRkp6T2vKwWJPFVIVMKM4hxn92K6n0PRCytk=;
        b=GUCd7ZOvZEhXc0/mfk0429x3tNwNkrsKWStUUIbeTSAEJSmBgk0a4Ra2jlAIk/x882
         j9kmovdH0phBdDq7UIvP5UzpYXTpNsi4dDeKJh5I/V2q0qu/yqMJy8s1Db8/cw52yALq
         6QMSqv+6QMS67EaUYxfmOrM2H+xR+adqC7eH5G+cnmhlp+71eUVYvZid3tYKTPNz5jrp
         MdgcZjk20Qhs3HB6fJVOphTsM94kuEZ4+lcrgv35Krxio8miJx/hHEVdnbNOZmd4e3En
         Vi1LZ+f7oHGJo4dDF3quTf/eJAcJ4ZvE38aLF/Qmdw0e0v8/7l7a7ysTfLXRI5nUss0o
         s7cQ==
X-Gm-Message-State: AC+VfDzU2A1wrslXfaSMgoPF/mbqzXOAHRQJqWOKB4eJPUueyeWcTSeD
        qQm0VnlMABfA4meCG7ellGRqng==
X-Google-Smtp-Source: ACHHUZ5tvd92H6EeKlIkOXPkMDBslOJK20p/RKYh/cqtFgsiyWV7f/sG/EKWlt6mVLUiEs9OHaRAHg==
X-Received: by 2002:a05:6a21:9706:b0:104:387a:bbaf with SMTP id ub6-20020a056a21970600b00104387abbafmr1046602pzb.53.1684490699233;
        Fri, 19 May 2023 03:04:59 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 11-20020aa7910b000000b006372791d708sm2678533pfh.104.2023.05.19.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:04:58 -0700 (PDT)
Date:   Fri, 19 May 2023 10:04:53 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Subject: Re: [PATCH v2 2/8] media: videobuf2: Make bufs array dynamic
 allocated
Message-ID: <20230519100453.6o4eriisloiji32g@chromium.org>
References: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
 <20230321102855.346732-3-benjamin.gaignard@collabora.com>
 <20230321181610.GE20234@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321181610.GE20234@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:16:10PM +0200, Laurent Pinchart wrote:
> Hi Benjamin,
> 
> Thank you for the patch.
> 
> On Tue, Mar 21, 2023 at 11:28:49AM +0100, Benjamin Gaignard wrote:
> > Instead of a static array change bufs to a dynamically allocated array.
> > This will allow to store more video buffer if needed.
> > Protect the array with a spinlock.
> 
> I think I asked in the review of v1 why we couldn't use the kernel
> IDA/IDR APIs to allocate buffer IDs and register buffers, but I don't
> think I've received a reply. Wouldn't it be better than rolling out our
> own mechanism ?
> 

+1, with a note that [1] suggests that IDR is deprecated and XArray[2]
should be used instead.

[1] https://docs.kernel.org/core-api/idr.html
[2] https://docs.kernel.org/core-api/xarray.html

Also from my quick look, XArray may be solving the locking concerns for us
automatically.

Best regards,
Tomasz

> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-core.c   |  8 +++
> >  include/media/videobuf2-core.h                | 49 ++++++++++++++++---
> >  2 files changed, 49 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index 79e90e338846..ae9d72f4d181 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -2452,6 +2452,13 @@ int vb2_core_queue_init(struct vb2_queue *q)
> >  	mutex_init(&q->mmap_lock);
> >  	init_waitqueue_head(&q->done_wq);
> >  
> > +	q->max_num_bufs = 32;
> > +	q->bufs = kmalloc_array(q->max_num_bufs, sizeof(*q->bufs), GFP_KERNEL | __GFP_ZERO);
> > +	if (!q->bufs)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&q->bufs_lock);
> > +
> >  	q->memory = VB2_MEMORY_UNKNOWN;
> >  
> >  	if (q->buf_struct_size == 0)
> > @@ -2479,6 +2486,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
> >  	mutex_lock(&q->mmap_lock);
> >  	__vb2_queue_free(q, q->num_buffers);
> >  	mutex_unlock(&q->mmap_lock);
> > +	kfree(q->bufs);
> >  }
> >  EXPORT_SYMBOL_GPL(vb2_core_queue_release);
> >  
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > index 5b1e3d801546..397dbf6e61e1 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -558,6 +558,8 @@ struct vb2_buf_ops {
> >   * @dma_dir:	DMA mapping direction.
> >   * @bufs:	videobuf2 buffer structures
> >   * @num_buffers: number of allocated/used buffers
> > + * @bufs_lock: lock to protect bufs access
> > + * @max_num_bufs: max number of buffers storable in bufs
> >   * @queued_list: list of buffers currently queued from userspace
> >   * @queued_count: number of buffers queued and ready for streaming.
> >   * @owned_by_drv_count: number of buffers owned by the driver
> > @@ -619,8 +621,10 @@ struct vb2_queue {
> >  	struct mutex			mmap_lock;
> >  	unsigned int			memory;
> >  	enum dma_data_direction		dma_dir;
> > -	struct vb2_buffer		*bufs[VB2_MAX_FRAME];
> > +	struct vb2_buffer		**bufs;
> >  	unsigned int			num_buffers;
> > +	spinlock_t			bufs_lock;
> > +	size_t				max_num_bufs;
> >  
> >  	struct list_head		queued_list;
> >  	unsigned int			queued_count;
> > @@ -1239,9 +1243,16 @@ static inline void vb2_clear_last_buffer_dequeued(struct vb2_queue *q)
> >  static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> >  						unsigned int index)
> >  {
> > -	if (index < q->num_buffers)
> > -		return q->bufs[index];
> > -	return NULL;
> > +	struct vb2_buffer *vb = NULL;
> > +
> > +	spin_lock(&q->bufs_lock);
> > +
> > +	if (index < q->max_num_bufs)
> > +		vb = q->bufs[index];
> > +
> > +	spin_unlock(&q->bufs_lock);
> > +
> > +	return vb;
> >  }
> >  
> >  /**
> > @@ -1251,12 +1262,30 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> >   */
> >  static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> >  {
> > -	if (vb->index < VB2_MAX_FRAME) {
> > +	bool ret = false;
> > +
> > +	spin_lock(&q->bufs_lock);
> > +
> > +	if (vb->index >= q->max_num_bufs) {
> > +		struct vb2_buffer **tmp;
> > +
> > +		tmp = krealloc_array(q->bufs, q->max_num_bufs * 2, sizeof(*q->bufs), GFP_KERNEL);
> > +		if (!tmp)
> > +			goto realloc_failed;
> > +
> > +		q->max_num_bufs *= 2;
> > +		q->bufs = tmp;
> > +	}
> > +
> > +	if (vb->index < q->max_num_bufs) {
> >  		q->bufs[vb->index] = vb;
> > -		return true;
> > +		ret = true;
> >  	}
> >  
> > -	return false;
> > +realloc_failed:
> > +	spin_unlock(&q->bufs_lock);
> > +
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -1266,8 +1295,12 @@ static inline bool vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *
> >   */
> >  static inline void vb2_queue_remove_buffer(struct vb2_queue *q, struct vb2_buffer *vb)
> >  {
> > -	if (vb->index < VB2_MAX_FRAME)
> > +	spin_lock(&q->bufs_lock);
> > +
> > +	if (vb->index < q->max_num_bufs)
> >  		q->bufs[vb->index] = NULL;
> > +
> > +	spin_unlock(&q->bufs_lock);
> >  }
> >  
> >  /*
> 
> -- 
> Regards,
> 
> Laurent Pinchart
