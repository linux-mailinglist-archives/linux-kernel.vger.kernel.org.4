Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246256CEF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC2Q1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjC2Q1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17D126
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680107179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QMeWDDRRF1UyQKkjOF9xaUDyLXaqabC3JIGztQRh24=;
        b=eZmFldVZjNBHspxufZ4lcKmU6sCBMnsUYZq30tUuJMREq2BXGdffH45qmpqIcWnrIujtpb
        5esyZ94leEriFr3pztXtquOTyDMyHQiaB6/cPde5XBx4JU8RH5hb/Fj3+qpes9iJuLkBzt
        uzw3zzkc+qw2pGABGFCFEtpq3skdncc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-GU7mQI2PP62mNzm5DCw4sg-1; Wed, 29 Mar 2023 12:26:15 -0400
X-MC-Unique: GU7mQI2PP62mNzm5DCw4sg-1
Received: by mail-wm1-f72.google.com with SMTP id bd16-20020a05600c1f1000b003ee895f6201so9005786wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680107174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QMeWDDRRF1UyQKkjOF9xaUDyLXaqabC3JIGztQRh24=;
        b=T2iGqzU9TU/AjaqrFtWn6UPXWl5iA4QwsJhBvzWikuBqdM+DxNWWO3J5DEFXy/wNDQ
         /1wKpBowhtUPLW45OSh6Ni9FKX7UW8DvBCbfXn3Ox4V3OJ3t2B7ZSlnQUhrwC26kAT2U
         OyKd5J1tFqrBWAaDmMLVqqVs6kJeszf2ePaLle4QSJ0clPHAdOyF8PTpr8uk/FG2zZWq
         CGJtt5PFf+APeVmaQtf0Q0ldPq/y7gY33UcryHuwLH3v3abecyrWOFtf9DmXUJMafvV2
         Wna+H885GmiFVWV8WtRtfvDRPFDSfHrLvMEGXLZD5AR+QLtyfgnSalKyV8f6hzCEC4E+
         h5mg==
X-Gm-Message-State: AAQBX9ctSGFtw6TW6Kdsv/jSCX3DC1Sr97mYXASz2WXMRdNoSgcjTPit
        rcsHQAobut59ePnIbr4DKRigHKqXoWvCCDacozRBjZV/XPtWG+a7JOomopBfA32WkEFkJxdMvfl
        ceGBNtgxmHOHNvjcyzfiN48Ep
X-Received: by 2002:a7b:c006:0:b0:3ea:fc95:7bf with SMTP id c6-20020a7bc006000000b003eafc9507bfmr10207778wmb.30.1680107174531;
        Wed, 29 Mar 2023 09:26:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZrR1tSknZVZ/c/aJTzooFZR2BKVt06DJ9es+d4wlckyD1UzYVce7RYEdvWTe1HUMX9eAtn8g==
X-Received: by 2002:a7b:c006:0:b0:3ea:fc95:7bf with SMTP id c6-20020a7bc006000000b003eafc9507bfmr10207761wmb.30.1680107174161;
        Wed, 29 Mar 2023 09:26:14 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm2886365wmo.26.2023.03.29.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 09:26:13 -0700 (PDT)
Date:   Wed, 29 Mar 2023 12:26:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio_ring: interrupt disable flag updated to vq
 even with event_triggered is set
Message-ID: <20230329121354-mutt-send-email-mst@kernel.org>
References: <20230329012908-mutt-send-email-mst@kernel.org>
 <20230329072135.44757-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329072135.44757-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ican't parse the subject at all. I think the subject from v2
was fine - we are skipping event index updates on get buf.
Or maybe go higher level and describe the effect of the patch:

virtio_ring: reduce interrupt rate with event idx enabled


On Wed, Mar 29, 2023 at 03:21:35PM +0800, Albert Huang wrote:
> From: "huangjie.albert" <huangjie.albert@bytedance.com>
> 
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false.

this last sentence is redundant

> Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.
> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx.This bring more interruptions.

This will bring more interrupts. And pls add space after ".".

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

bad grammar here and way too much detail.  better:

	make disable_cb set VRING_AVAIL_F_NO_INTERRUPT or
	VRING_PACKED_EVENT_FLAG_DISABLE in flags shadow to make get_buf
	correctly detect that callbacks are disabled.

> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
>

put changelog after --- please.
 
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


Why are you making this change? It's not great because it
only works because VRING_PACKED_EVENT_FLAG_DISABLE happens
to equal 0x1. does not the patch work with the original
if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE)
?

Besides, if you are making unrelated changes commit log should
describe them.

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

