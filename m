Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34585ED045
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiI0W3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiI0W32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286D21E769B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664317766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRQQc7BKWa8LDrkT5Hw2G0pLPlGFJTPkEo3Kh+HZDeo=;
        b=QnQuxbs6R96M1es+14JnofqjeQvUI6D+Jhrh3552EnTPYxVuBdlndBmOMUXuORrSkrv0ww
        P+cp+jK8oYKnMkZoS2YEife/aD3DI6/3U5jHV6R1+AQcIeHSDxymKOYelTHfV/AsJYl+8/
        QlEbCDxrurlktWUYlXKWrDw8z9uWfmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147--dPBNX-_PnGJoF16c2N_MQ-1; Tue, 27 Sep 2022 18:29:25 -0400
X-MC-Unique: -dPBNX-_PnGJoF16c2N_MQ-1
Received: by mail-wm1-f72.google.com with SMTP id r7-20020a1c4407000000b003b3309435a9so44234wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DRQQc7BKWa8LDrkT5Hw2G0pLPlGFJTPkEo3Kh+HZDeo=;
        b=Lx+rGA/dOIOHdGvHDaHRYrkb9It1fsDaWFYXibTl5l3xgutfU0YcRAm50g2U4BAWiY
         QL7joklPsOWEXktQBd6mO2iA1vKlJwWn4lG0CeLaoS+Rs9ytK2WipT0+8VQ2fzyjtkt0
         40huDAZ5qnSUzQTh+G6ckbxWx0hBWsfAgi0I5+8OqxTWERWF0nlMNumpgq0VBlvu6dQN
         BS1YYa4/eMKDJ4B+Im+bv70+5gLJMIDgQy+aJlK5hjd0X0AftIUu7HTYyyxLCaTblSUU
         wsr/AUekFLjZnhDCtHFTKDMpSdTeFVZoTwmUcO8PCq5VzXQgw7TanGhhTQJFLN92jOwo
         V6Lw==
X-Gm-Message-State: ACrzQf1kVwEYP68ueMyxizw0GgWo1CbAIE2beXJ7RcXmbB/wkHc4j493
        +gRmd5Urj+a22GIAOuBXGAaYm3WNW/8n3fbpj6Wey4UwVvV58garTFXgSBA4jbI8gPlWaP0JwTo
        is+a88CyV9rRH36TA1ZDDohys
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id m28-20020a05600c3b1c00b003b4fef36a62mr4427492wms.129.1664317762512;
        Tue, 27 Sep 2022 15:29:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6i/qTzNbRH5TrNdBRgSX0rc5y6zxldDHjyPAwP5H5gXq9WE2MFlW3Al5YW7ASlerOifzbrkg==
X-Received: by 2002:a05:600c:3b1c:b0:3b4:fef3:6a62 with SMTP id m28-20020a05600c3b1c00b003b4fef36a62mr4427485wms.129.1664317762333;
        Tue, 27 Sep 2022 15:29:22 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id bx31-20020a5d5b1f000000b0022a2bacabbasm2837817wrb.31.2022.09.27.15.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:29:21 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:29:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: Drop unnecessary initialization of
 detach_buf_packed
Message-ID: <20220927182855-mutt-send-email-mst@kernel.org>
References: <20220926102946.3097-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926102946.3097-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 06:29:46AM -0400, Deming Wang wrote:
> The variable is initialized but it is only used after its assignment.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>

The thing to do here is to move the first assigment to the
initialization.

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..abac0a3de440 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1544,7 +1544,7 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  static void detach_buf_packed(struct vring_virtqueue *vq,
>  			      unsigned int id, void **ctx)
>  {
> -	struct vring_desc_state_packed *state = NULL;
> +	struct vring_desc_state_packed *state;
>  	struct vring_packed_desc *desc;
>  	unsigned int i, curr;
>  
> -- 
> 2.27.0

