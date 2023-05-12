Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E170066B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbjELLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbjELLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:12:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80312E9B
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:11:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64384274895so7015893b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683889903; x=1686481903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWUF/DYv1jnKJ8vR8wMgZeyL5oNGsu4WTVEsbiWB8Vk=;
        b=CNl8PQ30zIzL7/2Xhv3Lhc+bcTLn/+StpE629utKmAs1ElN8IfQCAsQWS6zHMDPTxB
         MMDfRtHcogil9uC6uUBk0YKrKoZlFU1G7+jtpOE93GuKUKSZMw/qwRoIdArbdlyOp+bF
         lHZH56+E68OQY/ZUbXowLrSfHKjijbdnlHvQEHiv3BYf4JGzGRgIq+PEd4a68fr90ZIe
         VJSxoFq2Gf5fJawUG/eC+LP93CRswz/qYbc0mPrX1Wg9NIEmYZbJ5lf+y9Gwd92TjH5P
         a8+yHNJoIhEQtXrLPkg+qXwX9xUNH2sYSaaeB/fxPpS6BV9tOOmN13m22g2FklHhcBlj
         PYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683889903; x=1686481903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWUF/DYv1jnKJ8vR8wMgZeyL5oNGsu4WTVEsbiWB8Vk=;
        b=CUQboQUWrTO1QXND4X93J58qY8QrXueUMPnL0aTknmc6VSbr/IM/KoHJa1GkgtxK+p
         FBlalAEXg9MgkXoJwCYzPW8TRj6LbkNQ5PKeMbOJ5zKeH+yOAMfEwXVjbQ8UaYdGI6ML
         7GCY316Z5uJMO2QDFm5qUDkPgUVeZsMjXz/j87vFkFre3LifQUKsB7PMmIN8EIDOWJBI
         YREd3rmBI2w/MksV1WAjCJb6CxfF28SX+DCaI6VHaoZxkQdI7s/7pjNjg+NwVb8UI2OI
         ak3OJBeRG3X61nLcHmAioLUwissSCel+we16iZt1sPiWc2T7FZhTTyUBGAPsXzISDY+D
         jVKQ==
X-Gm-Message-State: AC+VfDxZoN7icyLa128+AEjaEm8pgnXzVl4JgC5nePbhIkpbkM4+mezQ
        eRjUbNshzcv4v458tfxBkVl/2iK+jYtFzpXGCz8=
X-Google-Smtp-Source: ACHHUZ45AjU5yfvO35JkNOdP5Bjt7NUpHmOHLQPaeZJJhytnrB0dPjdZw4VhoG9IRKZI9x0gHCVUkw==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id v4-20020a056a20918400b00100d4eeba80mr10019096pzd.27.1683889903283;
        Fri, 12 May 2023 04:11:43 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id g15-20020a63f40f000000b0053031f7a367sm6559889pgi.85.2023.05.12.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:11:42 -0700 (PDT)
Message-ID: <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
Date:   Fri, 12 May 2023 19:09:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
 <20230512064305-mutt-send-email-mst@kernel.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20230512064305-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 18:46, Michael S. Tsirkin wrote:
> On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
>> There is already a virtqueue abstract structure in virtio subsystem
>> (see struct virtqueue in include/linux/virtio.h), however the vring
>> based virtqueue is used only in the past years, the virtqueue related
>> methods mix much with vring(just look like the codes, virtqueue_xxx
>> functions are implemented in virtio_ring.c).
>>
>> Abstract virtqueue related methods(see struct virtqueue_ops), and
>> separate virtqueue_xxx symbols from vring. This allows a non-vring
>> based transport in the future. With this change, the following symbols
>> are exported from virtio.ko instead of virtio_ring.ko:
>>    virtqueue_add_sgs
>>    virtqueue_add_outbuf
>>    virtqueue_add_inbuf
>>    virtqueue_add_inbuf_ctx
>>    virtqueue_kick_prepare
>>    virtqueue_notify
>>    virtqueue_kick
>>    virtqueue_enable_cb_prepare
>>    virtqueue_enable_cb
>>    virtqueue_enable_cb_delayed
>>    virtqueue_disable_cb
>>    virtqueue_poll
>>    virtqueue_get_buf_ctx
>>    virtqueue_get_buf
>>    virtqueue_detach_unused_buf
>>    virtqueue_get_vring_size
>>    virtqueue_resize
>>    virtqueue_is_broken
>>    virtio_break_device
>>    __virtio_unbreak_device
>>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
>>   drivers/virtio/virtio_ring.c | 282 +++++----------------------
>>   include/linux/virtio.h       |  29 +++
>>   3 files changed, 443 insertions(+), 230 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 3893dc29eb26..8d8715a10f26 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
>>   EXPORT_SYMBOL_GPL(virtio_device_restore);
>>   #endif
>>   
>> +/**
>> + * virtqueue_add_sgs - expose buffers to other end
>> + * @vq: the struct virtqueue we're talking about.
>> + * @sgs: array of terminated scatterlists.
>> + * @out_sgs: the number of scatterlists readable by other side
>> + * @in_sgs: the number of scatterlists which are writable (after readable ones)
>> + * @data: the token identifying the buffer.
>> + * @gfp: how to do memory allocations (if necessary).
>> + *
>> + * Caller must ensure we don't call this with other virtqueue operations
>> + * at the same time (except where noted).
>> + *
>> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
>> + */
>> +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
>> +		      unsigned int out_sgs, unsigned int in_sgs,
>> +		      void *data, gfp_t gfp)
>> +{
>> +	unsigned int i, total_sg = 0;
>> +
>> +	/* Count them first. */
>> +	for (i = 0; i < out_sgs + in_sgs; i++) {
>> +		struct scatterlist *sg;
>> +
>> +		for (sg = sgs[i]; sg; sg = sg_next(sg))
>> +			total_sg++;
>> +	}
>> +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>> +				data, NULL, gfp);
>> +}
>> +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> 
> 
> Hmm this kind of indirection on data path is going to be costly
> performance-wise especially when retpolines are in place.
> 
> Any data on this?
> 

Hi,

1, What about moving these functions into virtio.h and declare them as 
static inline?
2, what about moving method fields into struct virtqueue?

Then we have struct like:
struct virtqueue {
	struct list_head list;
	...
	void *priv;

	/* virtqueue specific operations */
         int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
                        unsigned int total_sg,
                        unsigned int out_sgs, unsigned int in_sgs,
                        void *data, void *ctx, gfp_t gfp);
	...
}

and functions like:
static inline int virtqueue_add_sgs(...)
{
         unsigned int i, total_sg = 0;

         /* Count them first. */
         for (i = 0; i < out_sgs + in_sgs; i++) {
                 struct scatterlist *sg;

                 for (sg = sgs[i]; sg; sg = sg_next(sg))
                         total_sg++;
         }
         return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
                            data, NULL, gfp);
}

If [1] is acceptable, we can also reduce changes in patch 'tools/virtio: 
implement virtqueue in test'.

-- 
zhenwei pi
