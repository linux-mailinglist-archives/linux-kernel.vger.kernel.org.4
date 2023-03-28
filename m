Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4816CB39B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC1CN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1CN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:13:56 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50B170B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:13:55 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 40641C009; Tue, 28 Mar 2023 04:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679969634; bh=wqMNk37v7ep6rr1jhz7sYBORs1dIt3NXHYcIbaQ7jIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaJ9nxJiUyIPy8ueCwiEx/oeUQU9Le68MAl7WiYoUySqzr/SBKQ9DFwCvyQ0cK4wJ
         vm/Q/DJhKOMMTElGC6JWubgHWfHf4NqIolq6uhzwmxd6lz9J6R4HABcEY9msuO4Uim
         pAkTecob9/2RSDwpOzp+LfNvzQO4eJsSC2QXVR6VfxgjoOl0+tJTwueKCDCHbX2d7Z
         WCEkGgdx8g9olpLET/6ZMPqvqwKYA++G0dHeVn3CI95QUFx/WV23tAlS3baZFOavp0
         YDUib7Y2blGbb6rWhbebdS6l97tr6xeY+qX/YoRziQYqeRGIZTc2e91XLu7B6dP5V6
         DKFWSJgIruyxg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7569FC009;
        Tue, 28 Mar 2023 04:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679969633; bh=wqMNk37v7ep6rr1jhz7sYBORs1dIt3NXHYcIbaQ7jIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xPW62TJvFSHPl3Gv9JQ8HAfCEesqn8fdPlrV/CljUx8VPMf1mGBfubqVsMbbBLDP1
         k/nyIvbgcrXG1s6YDRs3CA0dcn2CAUE1rBN2WGUpmWHfJ2yUYVKV3K7GDV0camJXxY
         uJTGxrpr4i6TbwJtSv/zBV8oLhJWFv9ShJwHjSKFOHAe376n/xtBtayDrsxdKYOgv1
         RDxRmc5C8zR2V6Fj69hCPWk1hi+UFbd/7EzKdE923DKvf5XqwU0J5t40q/ie2PQR+x
         GbwSmpsScKd8D44OkV+Vo3YLetFhBfoxgMG197N335V0aiPlAWRN8JCmlS8YG97Q/d
         GvX97CEcOLOog==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id c6bb0979;
        Tue, 28 Mar 2023 02:13:48 +0000 (UTC)
Date:   Tue, 28 Mar 2023 11:13:32 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Albert Huang <huangjie.albert@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: 9p regression (Was: [PATCH v2] virtio_ring: don't update event idx
 on get_buf)
Message-ID: <ZCJNTBQLZeyLBKKB@codewreck.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Albert,

Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.

This patch (commited as 35395770f803 ("virtio_ring: don't update event
idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org

I've just hit had a look at recent patches[1] and reverted this to test
and I can mount again, so I'm pretty sure this is the culprit, but I
didn't look at the content at all yet so cannot advise further.
It might very well be that we need some extra handling for 9p
specifically that can be added separately if required.

[1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio/


This can be reproduced with a simple mount, run qemu with some -virtfs
argument and `mount -t 9p -o debug=65535 tag mountpoint` will hang after
these messages:
9pnet: -- p9_virtio_request (83): 9p debug: virtio request
9pnet: -- p9_virtio_request (83): virtio request kicked

So I suspect we're just not getting a callback.


I'll have a closer look after work, but any advice meanwhile will be
appreciated!
(I'm sure Luis would also like a temporary drop from -next until
this is figured out, but I'll leave this up to you)


> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix, if event_triggered is set to true, do not update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..1c36fa477966 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
