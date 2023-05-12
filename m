Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193187005EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbjELKrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjELKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6A2106CC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683888383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsynTsGLRgJAZ6e7bZw1PiKpH4cHRIRVuXuTNd7pC7k=;
        b=VQq5BpKR7Ott7A2O9TAG9dng/zgm2j7i4fufPu8Qio8Aje4owEVjDglfBBZRJE75diyp7m
        m2eiWKWLYIJoCNuxQ8A7+ImsKTG6eyDoYvZgwgF7NOnVkjB4U/U203eSy4J7f1sQfGQQRS
        8USrTZURFyQ5BMgsCL43MDrnWpN6scs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-aNMW8uUAMcGO7oRGI2ErKQ-1; Fri, 12 May 2023 06:46:22 -0400
X-MC-Unique: aNMW8uUAMcGO7oRGI2ErKQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42b226871so18287905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888380; x=1686480380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsynTsGLRgJAZ6e7bZw1PiKpH4cHRIRVuXuTNd7pC7k=;
        b=VYPQFpr3i3MTOkUKr7NGJUWhdbUmlv2RwTwAqjozboPjEA7+6pt09A3a6cnd/eJ8RX
         kCHXDKmIGHS+0OWs6GlKcLhTXVJiN94FAnsaKBAqGzm6rHKUDLretgnLSpg/eb1gEyNn
         M9spJORLjJQEXcvthzAB6FBWFJbu4JXh7vqpijtIq0m1FhZjJTdTQcOd8sKtsgVSd2Pl
         FkwG5rOEE2dwmheXqGCHy8E7e+eaYPfFMZUJcWxAe+YKtCo5/888oQABSljr4Z0Bqddc
         4kRPsw5/c3q566SgoHOF91P1XkSuaiesw5ADmQ3T74WMKbHV/+UV3WVfmV8htO9c/y9X
         Gz9w==
X-Gm-Message-State: AC+VfDwnUcbHrgsjbuuUSQAP37UF5l4JADLt3NIU737U8UdhXUYJSZ4w
        FOdfJwRqSAxgqMJh4p81NVTBv6df7/XhXslwipYxppHjux4UQSvY9EgTwjYUKxqFh9hU5WwQJuW
        HPQ3EWbCtg08OezMI8rHyF/iESi51XgQR
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id t15-20020a7bc3cf000000b003f421cfb4a4mr12582359wmj.20.1683888379874;
        Fri, 12 May 2023 03:46:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z6Ib8rSNqJ+CLm2dO/jAwN3bvoLO1/oqTwhLzEwwiaM5GHCPGyUCsD/wCyb3sftKNlVIg2g==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:21cf:b4a4 with SMTP id t15-20020a7bc3cf000000b003f421cfb4a4mr12582331wmj.20.1683888379180;
        Fri, 12 May 2023 03:46:19 -0700 (PDT)
Received: from redhat.com ([31.187.78.61])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bcd1a000000b003f423f5b659sm15608064wmj.10.2023.05.12.03.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:46:18 -0700 (PDT)
Date:   Fri, 12 May 2023 06:46:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230512064305-mutt-send-email-mst@kernel.org>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512094618.433707-2-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
> There is already a virtqueue abstract structure in virtio subsystem
> (see struct virtqueue in include/linux/virtio.h), however the vring
> based virtqueue is used only in the past years, the virtqueue related
> methods mix much with vring(just look like the codes, virtqueue_xxx
> functions are implemented in virtio_ring.c).
> 
> Abstract virtqueue related methods(see struct virtqueue_ops), and
> separate virtqueue_xxx symbols from vring. This allows a non-vring
> based transport in the future. With this change, the following symbols
> are exported from virtio.ko instead of virtio_ring.ko:
>   virtqueue_add_sgs
>   virtqueue_add_outbuf
>   virtqueue_add_inbuf
>   virtqueue_add_inbuf_ctx
>   virtqueue_kick_prepare
>   virtqueue_notify
>   virtqueue_kick
>   virtqueue_enable_cb_prepare
>   virtqueue_enable_cb
>   virtqueue_enable_cb_delayed
>   virtqueue_disable_cb
>   virtqueue_poll
>   virtqueue_get_buf_ctx
>   virtqueue_get_buf
>   virtqueue_detach_unused_buf
>   virtqueue_get_vring_size
>   virtqueue_resize
>   virtqueue_is_broken
>   virtio_break_device
>   __virtio_unbreak_device
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_ring.c | 282 +++++----------------------
>  include/linux/virtio.h       |  29 +++
>  3 files changed, 443 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 3893dc29eb26..8d8715a10f26 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
>  EXPORT_SYMBOL_GPL(virtio_device_restore);
>  #endif
>  
> +/**
> + * virtqueue_add_sgs - expose buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sgs: array of terminated scatterlists.
> + * @out_sgs: the number of scatterlists readable by other side
> + * @in_sgs: the number of scatterlists which are writable (after readable ones)
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
> +		      unsigned int out_sgs, unsigned int in_sgs,
> +		      void *data, gfp_t gfp)
> +{
> +	unsigned int i, total_sg = 0;
> +
> +	/* Count them first. */
> +	for (i = 0; i < out_sgs + in_sgs; i++) {
> +		struct scatterlist *sg;
> +
> +		for (sg = sgs[i]; sg; sg = sg_next(sg))
> +			total_sg++;
> +	}
> +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
> +				data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);


Hmm this kind of indirection on data path is going to be costly
performance-wise especially when retpolines are in place.

Any data on this?

> +
> +/**
> + * virtqueue_add_outbuf - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_outbuf(struct virtqueue *vq, struct scatterlist *sg,
> +			 unsigned int num, void *data, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> +
> +/**
> + * virtqueue_add_inbuf - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf(struct virtqueue *vq, struct scatterlist *sg,
> +			unsigned int num, void *data, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
> +
> +/**
> + * virtqueue_add_inbuf_ctx - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @ctx: extra context for the token
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf_ctx(struct virtqueue *vq, struct scatterlist *sg,
> +			    unsigned int num, void *data, void *ctx, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
> +
> +/**
> + * virtqueue_kick_prepare - first half of split virtqueue_kick call.
> + * @vq: the struct virtqueue
> + *
> + * Instead of virtqueue_kick(), you can do:
> + *	if (virtqueue_kick_prepare(vq))
> + *		virtqueue_notify(vq);
> + *
> + * This is sometimes useful because the virtqueue_kick_prepare() needs
> + * to be serialized, but the actual virtqueue_notify() call does not.
> + */
> +bool virtqueue_kick_prepare(struct virtqueue *vq)
> +{
> +	return vq->ops->kick_prepare(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> +
> +/**
> + * virtqueue_notify - second half of split virtqueue_kick call.
> + * @vq: the struct virtqueue
> + *
> + * This does not need to be serialized.
> + *
> + * Returns false if host notify failed or queue is broken, otherwise true.
> + */
> +bool virtqueue_notify(struct virtqueue *vq)
> +{
> +	return vq->ops->notify(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_notify);
> +
> +/**
> + * virtqueue_kick - update after add_buf
> + * @vq: the struct virtqueue
> + *
> + * After one or more virtqueue_add_* calls, invoke this to kick
> + * the other side.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns false if kick failed, otherwise true.
> + */
> +bool virtqueue_kick(struct virtqueue *vq)
> +{
> +	if (virtqueue_kick_prepare(vq))
> +		return virtqueue_notify(vq);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick);
> +
> +/**
> + * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns current queue state
> + * in an opaque unsigned value. This value should be later tested by
> + * virtqueue_poll, to detect a possible race between the driver checking for
> + * more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +unsigned int virtqueue_enable_cb_prepare(struct virtqueue *vq)
> +{
> +	return vq->ops->enable_cb_prepare(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> +
> +/**
> + * virtqueue_enable_cb - restart callbacks after disable_cb.
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns "false" if there are pending
> + * buffers in the queue, to detect a possible race between the driver
> + * checking for more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +bool virtqueue_enable_cb(struct virtqueue *vq)
> +{
> +	unsigned int val = vq->ops->enable_cb_prepare(vq);
> +
> +	return !vq->ops->poll(vq, val);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
> +
> +/**
> + * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks but hints to the other side to delay
> + * interrupts until most of the available buffers have been processed;
> + * it returns "false" if there are many pending buffers in the queue,
> + * to detect a possible race between the driver checking for more work,
> + * and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +bool virtqueue_enable_cb_delayed(struct virtqueue *vq)
> +{
> +	return vq->ops->enable_cb_delayed(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> +
> +/**
> + * virtqueue_disable_cb - disable callbacks
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * Note that this is not necessarily synchronous, hence unreliable and only
> + * useful as an optimization.
> + *
> + * Unlike other operations, this need not be serialized.
> + */
> +void virtqueue_disable_cb(struct virtqueue *vq)
> +{
> +	vq->ops->disable_cb(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> +
> +/**
> + * virtqueue_poll - query pending used buffers
> + * @vq: the struct virtqueue we're talking about.
> + * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> + *
> + * Returns "true" if there are pending used buffers in the queue.
> + *
> + * This does not need to be serialized.
> + */
> +bool virtqueue_poll(struct virtqueue *vq, unsigned int idx)
> +{
> +	return vq->ops->poll(vq, idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_poll);
> +
> +/**
> + * virtqueue_get_buf_ctx - get the next used buffer
> + * @vq: the struct virtqueue we're talking about.
> + * @len: the length written into the buffer
> + * @ctx: extra context for the token
> + *
> + * If the device wrote data into the buffer, @len will be set to the
> + * amount written.  This means you don't need to clear the buffer
> + * beforehand to ensure there's no data leakage in the case of short
> + * writes.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> +			    void **ctx)
> +{
> +	return vq->ops->get_buf_ctx(vq, len, ctx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> +
> +void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
> +{
> +	return vq->ops->get_buf_ctx(vq, len, NULL);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf);
> +
> +/**
> + * virtqueue_detach_unused_buf - detach first unused buffer
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * Returns NULL or the "data" token handed to virtqueue_add_*().
> + * This is not valid on an active queue; it is useful for device
> + * shutdown or the reset queue.
> + */
> +void *virtqueue_detach_unused_buf(struct virtqueue *vq)
> +{
> +	return vq->ops->detach_unused_buf(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> +
> +/**
> + * virtqueue_get_vring_size - return the size of the virtqueue's vring
> + * @vq: the struct virtqueue containing the vring of interest.
> + *
> + * Returns the size of the vring.  This is mainly used for boasting to
> + * userspace.  Unlike other operations, this need not be serialized.
> + */
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq)
> +{
> +	return vq->ops->get_vring_size(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
> +
> +/**
> + * virtqueue_resize - resize the vring of vq
> + * @vq: the struct virtqueue we're talking about.
> + * @num: new ring num
> + * @recycle: callback for recycle the useless buffer
> + *
> + * When it is really necessary to create a new vring, it will set the current vq
> + * into the reset state. Then call the passed callback to recycle the buffer
> + * that is no longer used. Only after the new vring is successfully created, the
> + * old vring will be released.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
> + *  vq can still work normally
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -E2BIG/-EINVAL: num error
> + * -EPERM: Operation not permitted
> + *
> + */
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	if (vq->ops->resize)
> +		return vq->ops->resize(vq, num, recycle);
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_resize);
> +
> +bool virtqueue_is_broken(const struct virtqueue *vq)
> +{
> +	return vq->ops->is_broken(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> +
> +/*
> + * This should prevent the device from being used, allowing drivers to
> + * recover.  You may need to grab appropriate locks to flush.
> + */
> +void virtio_break_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(vq, &dev->vqs, list) {
> +		vq->ops->__break(vq);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(virtio_break_device);
> +
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush the write to
> + * vq->broken. This should only be used in some specific case e.g
> + * (probing and restoring). This function should only be called by the
> + * core, not directly by the driver.
> + */
> +void __virtio_unbreak_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(vq, &dev->vqs, list) {
> +		vq->ops->__unbreak(vq);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +
>  static int virtio_init(void)
>  {
>  	if (bus_register(&virtio_bus) != 0)
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..7b86417255db 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -227,6 +227,8 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>  
> +static struct virtqueue_ops vring_ops;
> +
>  /*
>   * Helpers.
>   */
> @@ -2041,6 +2043,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	vq->vq.name = name;
>  	vq->vq.index = index;
>  	vq->vq.reset = false;
> +	vq->vq.ops = &vring_ops;
>  	vq->we_own_ring = true;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> @@ -2114,17 +2117,17 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>  
>  
>  /*
> - * Generic functions and exported symbols.
> + * Vring specific operation functions
>   */
>  
> -static inline int virtqueue_add(struct virtqueue *_vq,
> -				struct scatterlist *sgs[],
> -				unsigned int total_sg,
> -				unsigned int out_sgs,
> -				unsigned int in_sgs,
> -				void *data,
> -				void *ctx,
> -				gfp_t gfp)
> +static inline int vring_virtqueue_add_sgs(struct virtqueue *_vq,
> +					  struct scatterlist *sgs[],
> +					  unsigned int total_sg,
> +					  unsigned int out_sgs,
> +					  unsigned int in_sgs,
> +					  void *data,
> +					  void *ctx,
> +					  gfp_t gfp)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2135,110 +2138,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  }
>  
>  /**
> - * virtqueue_add_sgs - expose buffers to other end
> - * @_vq: the struct virtqueue we're talking about.
> - * @sgs: array of terminated scatterlists.
> - * @out_sgs: the number of scatterlists readable by other side
> - * @in_sgs: the number of scatterlists which are writable (after readable ones)
> - * @data: the token identifying the buffer.
> - * @gfp: how to do memory allocations (if necessary).
> - *
> - * Caller must ensure we don't call this with other virtqueue operations
> - * at the same time (except where noted).
> - *
> - * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> - */
> -int virtqueue_add_sgs(struct virtqueue *_vq,
> -		      struct scatterlist *sgs[],
> -		      unsigned int out_sgs,
> -		      unsigned int in_sgs,
> -		      void *data,
> -		      gfp_t gfp)
> -{
> -	unsigned int i, total_sg = 0;
> -
> -	/* Count them first. */
> -	for (i = 0; i < out_sgs + in_sgs; i++) {
> -		struct scatterlist *sg;
> -
> -		for (sg = sgs[i]; sg; sg = sg_next(sg))
> -			total_sg++;
> -	}
> -	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
> -			     data, NULL, gfp);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> -
> -/**
> - * virtqueue_add_outbuf - expose output buffers to other end
> - * @vq: the struct virtqueue we're talking about.
> - * @sg: scatterlist (must be well-formed and terminated!)
> - * @num: the number of entries in @sg readable by other side
> - * @data: the token identifying the buffer.
> - * @gfp: how to do memory allocations (if necessary).
> - *
> - * Caller must ensure we don't call this with other virtqueue operations
> - * at the same time (except where noted).
> - *
> - * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> - */
> -int virtqueue_add_outbuf(struct virtqueue *vq,
> -			 struct scatterlist *sg, unsigned int num,
> -			 void *data,
> -			 gfp_t gfp)
> -{
> -	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> -
> -/**
> - * virtqueue_add_inbuf - expose input buffers to other end
> - * @vq: the struct virtqueue we're talking about.
> - * @sg: scatterlist (must be well-formed and terminated!)
> - * @num: the number of entries in @sg writable by other side
> - * @data: the token identifying the buffer.
> - * @gfp: how to do memory allocations (if necessary).
> - *
> - * Caller must ensure we don't call this with other virtqueue operations
> - * at the same time (except where noted).
> - *
> - * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> - */
> -int virtqueue_add_inbuf(struct virtqueue *vq,
> -			struct scatterlist *sg, unsigned int num,
> -			void *data,
> -			gfp_t gfp)
> -{
> -	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
> -
> -/**
> - * virtqueue_add_inbuf_ctx - expose input buffers to other end
> - * @vq: the struct virtqueue we're talking about.
> - * @sg: scatterlist (must be well-formed and terminated!)
> - * @num: the number of entries in @sg writable by other side
> - * @data: the token identifying the buffer.
> - * @ctx: extra context for the token
> - * @gfp: how to do memory allocations (if necessary).
> - *
> - * Caller must ensure we don't call this with other virtqueue operations
> - * at the same time (except where noted).
> - *
> - * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> - */
> -int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
> -			struct scatterlist *sg, unsigned int num,
> -			void *data,
> -			void *ctx,
> -			gfp_t gfp)
> -{
> -	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
> -
> -/**
> - * virtqueue_kick_prepare - first half of split virtqueue_kick call.
> + * vring_virtqueue_kick_prepare - first half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
>   *
>   * Instead of virtqueue_kick(), you can do:
> @@ -2248,24 +2148,23 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>   * This is sometimes useful because the virtqueue_kick_prepare() needs
>   * to be serialized, but the actual virtqueue_notify() call does not.
>   */
> -bool virtqueue_kick_prepare(struct virtqueue *_vq)
> +static bool vring_virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
>  				 virtqueue_kick_prepare_split(_vq);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
>  /**
> - * virtqueue_notify - second half of split virtqueue_kick call.
> + * vring_virtqueue_notify - second half of split virtqueue_kick call.
>   * @_vq: the struct virtqueue
>   *
>   * This does not need to be serialized.
>   *
>   * Returns false if host notify failed or queue is broken, otherwise true.
>   */
> -bool virtqueue_notify(struct virtqueue *_vq)
> +static bool vring_virtqueue_notify(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2279,30 +2178,9 @@ bool virtqueue_notify(struct virtqueue *_vq)
>  	}
>  	return true;
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_notify);
>  
>  /**
> - * virtqueue_kick - update after add_buf
> - * @vq: the struct virtqueue
> - *
> - * After one or more virtqueue_add_* calls, invoke this to kick
> - * the other side.
> - *
> - * Caller must ensure we don't call this with other virtqueue
> - * operations at the same time (except where noted).
> - *
> - * Returns false if kick failed, otherwise true.
> - */
> -bool virtqueue_kick(struct virtqueue *vq)
> -{
> -	if (virtqueue_kick_prepare(vq))
> -		return virtqueue_notify(vq);
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_kick);
> -
> -/**
> - * virtqueue_get_buf_ctx - get the next used buffer
> + * vring_virtqueue_get_buf_ctx - get the next used buffer
>   * @_vq: the struct virtqueue we're talking about.
>   * @len: the length written into the buffer
>   * @ctx: extra context for the token
> @@ -2318,7 +2196,7 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
>   * Returns NULL if there are no used buffers, or the "data" token
>   * handed to virtqueue_add_*().
>   */
> -void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
> +static void *vring_virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  			    void **ctx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> @@ -2326,15 +2204,9 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
>  				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> -void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
> -{
> -	return virtqueue_get_buf_ctx(_vq, len, NULL);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_get_buf);
>  /**
> - * virtqueue_disable_cb - disable callbacks
> + * vring_virtqueue_disable_cb - disable callbacks
>   * @_vq: the struct virtqueue we're talking about.
>   *
>   * Note that this is not necessarily synchronous, hence unreliable and only
> @@ -2342,7 +2214,7 @@ EXPORT_SYMBOL_GPL(virtqueue_get_buf);
>   *
>   * Unlike other operations, this need not be serialized.
>   */
> -void virtqueue_disable_cb(struct virtqueue *_vq)
> +static void vring_virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2351,10 +2223,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  	else
>  		virtqueue_disable_cb_split(_vq);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
>  /**
> - * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
> + * vring_virtqueue_enable_cb_prepare - restart callbacks after disable_cb
>   * @_vq: the struct virtqueue we're talking about.
>   *
>   * This re-enables callbacks; it returns current queue state
> @@ -2365,7 +2236,7 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>   * Caller must ensure we don't call this with other virtqueue
>   * operations at the same time (except where noted).
>   */
> -unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> +static unsigned int vring_virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2375,10 +2246,9 @@ unsigned int virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
>  				 virtqueue_enable_cb_prepare_split(_vq);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
>  /**
> - * virtqueue_poll - query pending used buffers
> + * vring_virtqueue_poll - query pending used buffers
>   * @_vq: the struct virtqueue we're talking about.
>   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
>   *
> @@ -2386,7 +2256,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>   *
>   * This does not need to be serialized.
>   */
> -bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
> +static bool vring_virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2397,29 +2267,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  	return vq->packed_ring ? virtqueue_poll_packed(_vq, last_used_idx) :
>  				 virtqueue_poll_split(_vq, last_used_idx);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
>  /**
> - * virtqueue_enable_cb - restart callbacks after disable_cb.
> - * @_vq: the struct virtqueue we're talking about.
> - *
> - * This re-enables callbacks; it returns "false" if there are pending
> - * buffers in the queue, to detect a possible race between the driver
> - * checking for more work, and enabling callbacks.
> - *
> - * Caller must ensure we don't call this with other virtqueue
> - * operations at the same time (except where noted).
> - */
> -bool virtqueue_enable_cb(struct virtqueue *_vq)
> -{
> -	unsigned int last_used_idx = virtqueue_enable_cb_prepare(_vq);
> -
> -	return !virtqueue_poll(_vq, last_used_idx);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
> -
> -/**
> - * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
> + * vring_virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
>   * @_vq: the struct virtqueue we're talking about.
>   *
>   * This re-enables callbacks but hints to the other side to delay
> @@ -2431,7 +2281,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
>   * Caller must ensure we don't call this with other virtqueue
>   * operations at the same time (except where noted).
>   */
> -bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> +static bool vring_virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> @@ -2441,24 +2291,22 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
>  				 virtqueue_enable_cb_delayed_split(_vq);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
>  /**
> - * virtqueue_detach_unused_buf - detach first unused buffer
> + * vring_virtqueue_detach_unused_buf - detach first unused buffer
>   * @_vq: the struct virtqueue we're talking about.
>   *
>   * Returns NULL or the "data" token handed to virtqueue_add_*().
>   * This is not valid on an active queue; it is useful for device
>   * shutdown or the reset queue.
>   */
> -void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> +static void *vring_virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
>  				 virtqueue_detach_unused_buf_split(_vq);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> @@ -2531,6 +2379,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->vq.name = name;
>  	vq->vq.index = index;
>  	vq->vq.reset = false;
> +	vq->vq.ops = &vring_ops;
>  	vq->we_own_ring = false;
>  	vq->notify = notify;
>  	vq->weak_barriers = weak_barriers;
> @@ -2616,7 +2465,7 @@ struct virtqueue *vring_create_virtqueue_dma(
>  EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
>  
>  /**
> - * virtqueue_resize - resize the vring of vq
> + * vring_virtqueue_resize - resize the vring of vq
>   * @_vq: the struct virtqueue we're talking about.
>   * @num: new ring num
>   * @recycle: callback for recycle the useless buffer
> @@ -2639,8 +2488,8 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
>   * -EPERM: Operation not permitted
>   *
>   */
> -int virtqueue_resize(struct virtqueue *_vq, u32 num,
> -		     void (*recycle)(struct virtqueue *vq, void *buf))
> +static int vring_virtqueue_resize(struct virtqueue *_vq, u32 num,
> +				  void (*recycle)(struct virtqueue *vq, void *buf))
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct virtio_device *vdev = vq->vq.vdev;
> @@ -2669,7 +2518,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (err)
>  		return err;
>  
> -	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> +	while ((buf = vring_virtqueue_detach_unused_buf(_vq)) != NULL)
>  		recycle(_vq, buf);
>  
>  	if (vq->packed_ring)
> @@ -2682,7 +2531,6 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_resize);
>  
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
> @@ -2809,20 +2657,19 @@ void vring_transport_features(struct virtio_device *vdev)
>  EXPORT_SYMBOL_GPL(vring_transport_features);
>  
>  /**
> - * virtqueue_get_vring_size - return the size of the virtqueue's vring
> + * vring_virtqueue_get_vring_size - return the size of the virtqueue's vring
>   * @_vq: the struct virtqueue containing the vring of interest.
>   *
>   * Returns the size of the vring.  This is mainly used for boasting to
>   * userspace.  Unlike other operations, this need not be serialized.
>   */
> -unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
> +static unsigned int vring_virtqueue_get_vring_size(const struct virtqueue *_vq)
>  {
>  
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
>  /*
>   * This function should only be called by the core, not directly by the driver.
> @@ -2848,54 +2695,29 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>  
> -bool virtqueue_is_broken(const struct virtqueue *_vq)
> +static bool vring_virtqueue_is_broken(const struct virtqueue *_vq)
>  {
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return READ_ONCE(vq->broken);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> -
> -/*
> - * This should prevent the device from being used, allowing drivers to
> - * recover.  You may need to grab appropriate locks to flush.
> - */
> -void virtio_break_device(struct virtio_device *dev)
> -{
> -	struct virtqueue *_vq;
> -
> -	spin_lock(&dev->vqs_list_lock);
> -	list_for_each_entry(_vq, &dev->vqs, list) {
> -		struct vring_virtqueue *vq = to_vvq(_vq);
> -
> -		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> -		WRITE_ONCE(vq->broken, true);
> -	}
> -	spin_unlock(&dev->vqs_list_lock);
> -}
> -EXPORT_SYMBOL_GPL(virtio_break_device);
> -
> -/*
> - * This should allow the device to be used by the driver. You may
> - * need to grab appropriate locks to flush the write to
> - * vq->broken. This should only be used in some specific case e.g
> - * (probing and restoring). This function should only be called by the
> - * core, not directly by the driver.
> - */
> -void __virtio_unbreak_device(struct virtio_device *dev)
> -{
> -	struct virtqueue *_vq;
> -
> -	spin_lock(&dev->vqs_list_lock);
> -	list_for_each_entry(_vq, &dev->vqs, list) {
> -		struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> -		WRITE_ONCE(vq->broken, false);
> -	}
> -	spin_unlock(&dev->vqs_list_lock);
> -}
> -EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +static struct virtqueue_ops vring_ops = {
> +	.add_sgs = vring_virtqueue_add_sgs,
> +	.kick_prepare = vring_virtqueue_kick_prepare,
> +	.notify = vring_virtqueue_notify,
> +	.enable_cb_prepare = vring_virtqueue_enable_cb_prepare,
> +	.enable_cb_delayed = vring_virtqueue_enable_cb_delayed,
> +	.disable_cb = vring_virtqueue_disable_cb,
> +	.poll = vring_virtqueue_poll,
> +	.get_buf_ctx = vring_virtqueue_get_buf_ctx,
> +	.detach_unused_buf = vring_virtqueue_detach_unused_buf,
> +	.get_vring_size = vring_virtqueue_get_vring_size,
> +	.resize = vring_virtqueue_resize,
> +	.__break = __virtqueue_break,
> +	.__unbreak = __virtqueue_unbreak,
> +	.is_broken = vring_virtqueue_is_broken,
> +};
>  
>  dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..845858b8761e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -10,6 +10,34 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
>  
> +struct virtqueue;
> +
> +/**
> + * struct virtqueue_ops - abstract operations for a virtqueue.
> + *
> + * Descriptions of each field see the comments in virtio.c
> + */
> +struct virtqueue_ops {
> +	int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
> +		       unsigned int total_sg,
> +		       unsigned int out_sgs, unsigned int in_sgs,
> +		       void *data, void *ctx, gfp_t gfp);
> +	bool (*kick_prepare)(struct virtqueue *vq);
> +	bool (*notify)(struct virtqueue *vq);
> +	unsigned int (*enable_cb_prepare)(struct virtqueue *vq);
> +	bool (*enable_cb_delayed)(struct virtqueue *vq);
> +	void (*disable_cb)(struct virtqueue *vq);
> +	bool (*poll)(struct virtqueue *vq, unsigned int idx);
> +	void *(*get_buf_ctx)(struct virtqueue *vq, unsigned int *len, void **ctx);
> +	void *(*detach_unused_buf)(struct virtqueue *vq);
> +	unsigned int (*get_vring_size)(const struct virtqueue *vq);
> +	int (*resize)(struct virtqueue *vq, u32 num,
> +		      void (*recycle)(struct virtqueue *vq, void *buf));
> +	void (*__break)(struct virtqueue *vq);
> +	void (*__unbreak)(struct virtqueue *vq);
> +	bool (*is_broken)(const struct virtqueue *vq);
> +};
> +
>  /**
>   * struct virtqueue - a queue to register buffers for sending or receiving.
>   * @list: the chain of virtqueues for this device
> @@ -36,6 +64,7 @@ struct virtqueue {
>  	unsigned int num_max;
>  	bool reset;
>  	void *priv;
> +	struct virtqueue_ops *ops;
>  };
>  
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> -- 
> 2.20.1

