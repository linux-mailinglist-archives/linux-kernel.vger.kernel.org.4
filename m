Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5986CD1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjC2Fht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjC2Fhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599BDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680068221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hla3Qnsgd5UPmON5n9RR870xL1b8aSKIkUrN0GzbMGw=;
        b=FBRY2eQZl1cbB9zmNhJoEZpGHC4x9SGxUuZlvhzp2eSAwtdYicU1dZQZ5nCmA6nmNcxl+v
        49+KG5a5D7rsxBopk9TJ15BB3CSZEGkwBsPN5H6tah4RTFN6ia+vS80Zu7IECBo/9wUMZz
        L7++lFVnlp2v51Lt5EqSu8V1ETLNbq4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-QZ9ZqbAGNCyFFHfIOPFqVQ-1; Wed, 29 Mar 2023 01:37:00 -0400
X-MC-Unique: QZ9ZqbAGNCyFFHfIOPFqVQ-1
Received: by mail-wm1-f71.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so7287099wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680068219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hla3Qnsgd5UPmON5n9RR870xL1b8aSKIkUrN0GzbMGw=;
        b=3YpLvAqDGSANKK/dfKwGDxJOzEysKwW8wZvcwfyktcdlHbQEr4KG9TF93j3L3OUY54
         sQtqhAFPgihnXgOgcUB64JDjR6baaAYexuhrkKVh5zMjBufl7+Ae2eJ+3RufLoSGnGrv
         zXrxRd2SwDGPNU44YKMJjFRi1smWFO9M/hqY2iq1Xo3fxrC76pGv/hPPavrCbMFAy16q
         1OtuzLeafWepV1P/XEvqVBZjd/+6vQNtioJVFNBeCiJP4UQAz6jTlE//VhsUeiCl2eHE
         TL/mkBzst7ILjlBKQm3sNgIow1rZfgFOodlfxE3j6vrXNrP0Au+BDKymdbOH1Imw0HSm
         WMOw==
X-Gm-Message-State: AAQBX9ekvkPXeqwIEhXDXnnWGi8R8AB5sxz7IJupNjfwyoxQRBpg9OSW
        d4uXp5TqWPHkkHupSREsxMKgfG9bRzLfjSsHlJH6C3Ob0KsKITEYRU5Se0wsGgjj1Q3/CLYKBxN
        vYQYMI3s/JdB/QCJ10WgQFHTN
X-Received: by 2002:adf:ee0c:0:b0:2d8:908c:8fa0 with SMTP id y12-20020adfee0c000000b002d8908c8fa0mr15090848wrn.9.1680068218834;
        Tue, 28 Mar 2023 22:36:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y06HXL9L5OeExITLNa0kaQS5mr7hukl/oOQCa72DJkzos37Pccw/+PbWD3EAjVhwrN5OJ3XQ==
X-Received: by 2002:adf:ee0c:0:b0:2d8:908c:8fa0 with SMTP id y12-20020adfee0c000000b002d8908c8fa0mr15090838wrn.9.1680068218505;
        Tue, 28 Mar 2023 22:36:58 -0700 (PDT)
Received: from redhat.com ([2.52.18.165])
        by smtp.gmail.com with ESMTPSA id b9-20020adfde09000000b002daeb108304sm16094294wrm.33.2023.03.28.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:36:57 -0700 (PDT)
Date:   Wed, 29 Mar 2023 01:36:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Albert Huang <huangjie.albert@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_ring: don't update event idx on get_buf
Message-ID: <20230329013434-mutt-send-email-mst@kernel.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 06:56:33PM +0800, Albert Huang wrote:
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

dropped for now due to breakage of 9p.
Pls post v3 with the fix you suggested (moving the check
of vq->event_triggered).

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
> -- 
> 2.37.0 (Apple Git-136)

