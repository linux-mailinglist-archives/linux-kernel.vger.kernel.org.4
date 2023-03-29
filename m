Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9836CD8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjC2Lru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2Lrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:47:49 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFD4690
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:47:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VewkDRj_1680090447;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VewkDRj_1680090447)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 19:47:28 +0800
Message-ID: <1680090301.6450636-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 19:45:01 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20230329102300.61000-1-huangjie.albert@bytedance.com>
In-Reply-To: <20230329102300.61000-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 18:23:00 +0800, Albert Huang <huangjie.albert@bytedance.com> wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
>
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
>
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
>
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.
>
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
>
> To fix:
> update VRING_AVAIL_F_NO_INTERRUPT or VRING_PACKED_EVENT_FLAG_DISABLE to vq
> when we call virtqueue_disable_cb even the event_triggered is set to true.
>
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
>
> v2->v3:
> -update the interrupt disable flag even with the event_triggered is set,
> -instead of checking whether event_triggered is set in
> -virtqueue_get_buf_ctx_{packed/split}, will cause the drivers  which have
> -not called virtqueue_{enable/disable}_cb to miss notifications.
>
> v3->v4:
> -remove change for
> -"if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)"
> -in virtqueue_disable_cb_packed
>
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")

Hi Michael,

I want to know what the purpose of this patch("virtio: fix up virtio_disable_cb")
is. I re-review this patch. I didn't understand what the purpose of this
patches. Does it reduce one write to vring_used_event(&vq->split.vring) ?

Thanks.


> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..ec7ab8e04846 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -931,6 +931,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		if (vq->event)
>  			/* TODO: this is a hack. Figure out a cleaner value to write. */
>  			vring_used_event(&vq->split.vring) = 0x0;
> @@ -1761,6 +1769,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>
>  	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> +
> +		/*
> +		 * If device triggered an event already it won't trigger one again:
> +		 * no need to disable.
> +		 */
> +		if (vq->event_triggered)
> +			return;
> +
>  		vq->packed.vring.driver->flags =
>  			cpu_to_le16(vq->packed.event_flags_shadow);
>  	}
> @@ -2462,12 +2478,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>
> -	/* If device triggered an event already it won't trigger one again:
> -	 * no need to disable.
> -	 */
> -	if (vq->event_triggered)
> -		return;
> -
>  	if (vq->packed_ring)
>  		virtqueue_disable_cb_packed(_vq);
>  	else
> --
> 2.20.1
>
