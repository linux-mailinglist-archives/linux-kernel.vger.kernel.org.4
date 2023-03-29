Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C006CD33E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjC2HbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjC2Haq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:30:46 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB3E448B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:28:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VevwF9d_1680074851;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VevwF9d_1680074851)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 15:27:32 +0800
Message-ID: <1680074823.805977-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq even with event_triggered is set
Date:   Wed, 29 Mar 2023 15:27:03 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
 <ZCJNTBQLZeyLBKKB@codewreck.org>
 <CACGkMEt29t9CK2Muiuyb1s6p2AzgcMiD_z0NVFn1d+KEqBydug@mail.gmail.com>
 <CABKxMyPwuRb6p-oHxcQDhRtJv04=NDWvosNAp=epgvdrfCeveg@mail.gmail.com>
 <CACGkMEuukvjXBTDX2K9YLYmpHsqK96AiMK39gbm3+f_+kUydMQ@mail.gmail.com>
 <CABKxMyN0598wA6wHv5GkZC14znwp=OPo7u71_BizJfR+gUx4_w@mail.gmail.com>
 <20230329012908-mutt-send-email-mst@kernel.org>
 <20230329072135.44757-1-huangjie.albert@bytedance.com>
In-Reply-To: <20230329072135.44757-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe one new thread is better.

Thanks.

On Wed, 29 Mar 2023 15:21:35 +0800, Albert Huang <huangjie.albert@bytedance.com> wrote:
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
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..ad74463a48ee 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -812,6 +812,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
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
> @@ -1544,8 +1552,16 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>
> -	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
> +	if (!(vq->packed.event_flags_shadow & VRING_PACKED_EVENT_FLAG_DISABLE)) {
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
> @@ -2063,12 +2079,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
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
> 2.31.1
>
