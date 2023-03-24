Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260DA6C779C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCXGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCXGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF0193CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679638139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GaaEY4H15KWNoSziTd+hgiA9Y9SMayy770FfjBkX9Cg=;
        b=GacTdXk9itj0IpIZkouzeojn4EaCxUnkHpd7iS4mRBu6UdfW6wXcbTMGk9sAYUVZXfqgR9
        /rDK5gM8Sj+EhODrjdrJHhDHjGUmtkOYRESyrv5dkDgDBHVdhfZis08jWKMzl09krfHk3D
        hQWCalLkjtJFg8Ecz8zUs+AlAzNUQwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-WdvFtqcUPRWcW-Sakt1ktQ-1; Fri, 24 Mar 2023 02:08:57 -0400
X-MC-Unique: WdvFtqcUPRWcW-Sakt1ktQ-1
Received: by mail-wm1-f69.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so321107wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679638136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaaEY4H15KWNoSziTd+hgiA9Y9SMayy770FfjBkX9Cg=;
        b=qMsh02HtNzYrMKzAzrxoZMg21+MI7vxQkf0bLGI+/UZ9qP1iSuupj9Dk2LPszWqAgF
         3h5Ny6vG2MTjHocCtAmRaBf3KzhIMDhX2kUb9wZgj10UmweIVorU03kdMw6+jEaL4fBs
         BX9aGhabi14nU/oZH+4NOBwJvmK10bayQFn4rKVfL/cio/KDjhhwKG7+OFgzQLaW29Hv
         YzUpx8ReDDBNDMYRZqm6xk/bfTRLf4E5Rvi3ZRzJA4MNenLUU0khjyGLvBb6ieQSd2jQ
         +K/zdC9X/sYQLFECSUNdhvKR2FG9fysaa5r6hJkcUmHdqsvXcQE8u6+5TjCOKGw4Hd2K
         Sirw==
X-Gm-Message-State: AAQBX9c33tvqSnTJfJonPlB7fzIvLJafYKHS1fVamrgEyIkwhZvtmfe6
        oIAFqJI30ObGZPIbihcoLcgy4O9Ohhf6QjdI+76yGU4ZAMm9WV34YjuSfV7xJWC/XGCkB9oRAPr
        tQDtpRgxo1RjaZ5L9djOuTW+T
X-Received: by 2002:adf:f8d2:0:b0:2d7:452f:79ec with SMTP id f18-20020adff8d2000000b002d7452f79ecmr1004815wrq.7.1679638136124;
        Thu, 23 Mar 2023 23:08:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zte+yhwOuXp0n1DsXAlkdtZgqKOrWQD5KEI1UhnnB0Txz009uzHbrWUXvpfB2oH3nVFUeNQQ==
X-Received: by 2002:adf:f8d2:0:b0:2d7:452f:79ec with SMTP id f18-20020adff8d2000000b002d7452f79ecmr1004799wrq.7.1679638135745;
        Thu, 23 Mar 2023 23:08:55 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d48ce000000b002d45575643esm15608669wrs.43.2023.03.23.23.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:08:55 -0700 (PDT)
Date:   Fri, 24 Mar 2023 02:08:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
Message-ID: <20230324015954-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321085953.24949-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!
I picked it up.
I made small changes, please look at it in my branch,
both to see what I changed for your next submission,
and to test that it still addresses the problem for you.
Waiting for your confirmation to send upstream.
Thanks!


On Tue, Mar 21, 2023 at 04:59:53PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> 
> if we disable the napi_tx. when we triger a tx interrupt, the
> vq->event_triggered will be set to true. It will no longer be
> set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> or virtqueue_enable_cb_prepare
> 
> if we disable the napi_tx, It will only be called when the tx ring
> buffer is relatively small:
> virtio_net->start_xmit:
> 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> 		netif_stop_subqueue(dev, qnum);
> 		if (!use_napi &&
> 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> 			/* More just got used, free them then recheck. */
> 			free_old_xmit_skbs(sq, false);
> 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> 				netif_start_subqueue(dev, qnum);
> 				virtqueue_disable_cb(sq->vq);
> 			}
> 		}
> 	}
> Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> 
> if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> or vq->packed.vring.driver->off_wrap
> 
> Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 307e139cb11d..f486cccadbeb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> +			&& (vq->event_triggered == false))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> +			&& (vq->event_triggered == false))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
> -- 
> 2.31.1

