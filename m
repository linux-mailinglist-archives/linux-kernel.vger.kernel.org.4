Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7463E6C780D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCXGh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCXGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7576144BC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679639833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTHEkG0veS3WOnmD1zcIed5zrYB8TJOmsb7HBmnzkgQ=;
        b=QAIVFX+zSTqhCOV3EMEb9LLacgtxRLWpoDp7vZZwUzetrv7ac8j4HJR10DshLuZ0msMlIZ
        4RJBxUvk9nj9TXUsUaXRLdvC/H9kLRTBTdbZj+0FV36QyFJKhrFMqIrFJowGRgtVNjbMsL
        2n6QgMw0qCJU3UScZtfJYPO/Erct+o4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332--oZTl3H0OKqSp3BFBrVrcw-1; Fri, 24 Mar 2023 02:37:11 -0400
X-MC-Unique: -oZTl3H0OKqSp3BFBrVrcw-1
Received: by mail-wm1-f72.google.com with SMTP id bh19-20020a05600c3d1300b003ee93fac4a9so1759117wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTHEkG0veS3WOnmD1zcIed5zrYB8TJOmsb7HBmnzkgQ=;
        b=D+oCTPeciAolAfOVwayi4ixxQWWs1a0y9DuFSSaisfpPiqNBcuLehZVNPaUrhc82VQ
         Vn615JVqCaCKI/GeAhikcbd2ceSTJZTTzQ9IMZktYGuLfGTsEVZummiU7JgZ2trmnBvp
         5VuOOVOsH0TxMoEek8MbtB6ef7hCBkYDgRU59n6Mn+gBqPViiD/sAV19MWzGKATf/J68
         CkerC8HbsvCLi1ux1ZN3p866JYjweMNf/WViZSmuimkzB3wsnzP/2HPHs0KIf4CLhjc9
         1LuifBHr5UGHIo8QABAi1R9UcraM/iiTTQ9G0hwVOtk3EBB7TxCIlQNh/dyR3vwB66fM
         cSHw==
X-Gm-Message-State: AO0yUKVEMWwEv+gLhZXvexJ9n9mDnvptm2QASvk2EmitYZvJiRONnl9i
        PZKB6UEUL+/IhZPpoApyUmlbm+Kt/RvshnnJhqKDE7rYMsNtm/iS8nMOgUn8vAWVN8c2TH1j5YY
        yod3KewnKpZBz6lEaCq2kmag0+MOKWdBr
X-Received: by 2002:a05:600c:285:b0:3ee:e978:51d8 with SMTP id 5-20020a05600c028500b003eee97851d8mr1309966wmk.16.1679639830159;
        Thu, 23 Mar 2023 23:37:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set9jCSGKCzz7i9696EMOlfmBSZxXJ+g69JqLl6rKpJZbW2idUaifH/ggXl2FMWciUlQ+Ph+YNA==
X-Received: by 2002:a05:600c:285:b0:3ee:e978:51d8 with SMTP id 5-20020a05600c028500b003eee97851d8mr1309954wmk.16.1679639829854;
        Thu, 23 Mar 2023 23:37:09 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id o15-20020a1c750f000000b003ee1acdb036sm3954941wmc.17.2023.03.23.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:37:09 -0700 (PDT)
Date:   Fri, 24 Mar 2023 02:37:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_ring: Suppress tx interrupt when napi_tx disable
Message-ID: <20230324023552-mutt-send-email-mst@kernel.org>
References: <20230321085953.24949-1-huangjie.albert@bytedance.com>
 <20230324015954-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324015954-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm I sent a bit too fast, and my testing rig is down now.
So please do send a new version, I sent comments on what to fix
in this one.

On Fri, Mar 24, 2023 at 02:08:55AM -0400, Michael S. Tsirkin wrote:
> Thanks for the patch!
> I picked it up.
> I made small changes, please look at it in my branch,
> both to see what I changed for your next submission,
> and to test that it still addresses the problem for you.
> Waiting for your confirmation to send upstream.
> Thanks!
> 
> 
> On Tue, Mar 21, 2023 at 04:59:53PM +0800, Albert Huang wrote:
> > From: "huangjie.albert" <huangjie.albert@bytedance.com>
> > 
> > fix commit 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> > 
> > if we disable the napi_tx. when we triger a tx interrupt, the
> > vq->event_triggered will be set to true. It will no longer be
> > set to false. Unless we explicitly call virtqueue_enable_cb_delayed
> > or virtqueue_enable_cb_prepare
> > 
> > if we disable the napi_tx, It will only be called when the tx ring
> > buffer is relatively small:
> > virtio_net->start_xmit:
> > 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > 		netif_stop_subqueue(dev, qnum);
> > 		if (!use_napi &&
> > 		    unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> > 			/* More just got used, free them then recheck. */
> > 			free_old_xmit_skbs(sq, false);
> > 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > 				netif_start_subqueue(dev, qnum);
> > 				virtqueue_disable_cb(sq->vq);
> > 			}
> > 		}
> > 	}
> > Because event_triggered is true.Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> > VRING_PACKED_EVENT_FLAG_DISABLE will not be set.So we update
> > vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> > every time we call virtqueue_get_buf_ctx.This will bring more interruptions.
> > 
> > if event_triggered is set to true, do not update vring_used_event(&vq->split.vring)
> > or vq->packed.vring.driver->off_wrap
> > 
> > Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 307e139cb11d..f486cccadbeb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -795,7 +795,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >  	/* If we expect an interrupt for the next entry, tell host
> >  	 * by writing event index and flush out the write before
> >  	 * the read in the next get_buf call. */
> > -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> > +	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)
> > +			&& (vq->event_triggered == false))
> >  		virtio_store_mb(vq->weak_barriers,
> >  				&vring_used_event(&vq->split.vring),
> >  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> > @@ -1529,7 +1530,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	 * by writing event index and flush out the write before
> >  	 * the read in the next get_buf call.
> >  	 */
> > -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> > +	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC
> > +			&& (vq->event_triggered == false))
> >  		virtio_store_mb(vq->weak_barriers,
> >  				&vq->packed.vring.driver->off_wrap,
> >  				cpu_to_le16(vq->last_used_idx));
> > -- 
> > 2.31.1

