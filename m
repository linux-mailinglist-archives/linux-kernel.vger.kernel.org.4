Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33021651FBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLTLcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiLTLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9819299
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671535920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7a+5y93f4CEM76hoZILajwanmAtm9yvjPLzZAIqF7iI=;
        b=Afa6aH9wq359acAj7TBklxSdIl2YH430rgt4RMh98kikR0Ew3gnf/QUSpxgd1KmvOE6bD0
        KfsXqRMWGjNgi9apgjnW8vK7ltGkwmHLocSR7Ptu5CjykQ23r4SmhU9VRGPvPKFHSKhUEE
        dD71/+iQ8jw4dG4rbgWkc9B95CPpV1U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-jBden8a5PiGmIHRCRLic2w-1; Tue, 20 Dec 2022 06:31:58 -0500
X-MC-Unique: jBden8a5PiGmIHRCRLic2w-1
Received: by mail-qv1-f69.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so7054928qvb.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a+5y93f4CEM76hoZILajwanmAtm9yvjPLzZAIqF7iI=;
        b=I4yqhUemtignaVyvb/i8lmK02Tjs+cOb4Umx6Nxewp6NR/QwX1QQCealDzCmLLEsl+
         hBnUsb/uyXkJlpYqC8uoAwa6Z2x6KWWdtQRlgs85gIt8xGtLR8iyx+lvqRp3V5KGlHl7
         oRcmpQOlEjvEi7+XEye+DMNY/8SnZPIlO0DZWopwGzxd277mQiV4gLQ9+hBNwbjUA3Q4
         ITVBj9L8F6EXYuhYqTLEaRcqs8RnpWGieQQIK52a20Khgo30GmPVYGReog1tGxzJ829d
         cjD1sadBw8MYumKbtQTfEe42WaeYHRAt4Wf955qZUeQLA6fe9Qp/OUiBKkl+ZxHaSZ3p
         LmGg==
X-Gm-Message-State: ANoB5pnf1rKh+PXi5KWltE5EOEa3oo17+0TGqSpSb+c3hvAlIW/kkFz0
        Pf2Fd6XIfM2Dk0ejpJ6DIJ0AjsiZh77+QfCH3kjp1YF9pEYpenqasB8vPql3F5MsKEEuZ1+WLaL
        VgAAkphnhsUUg1K0iM35tY7ZB
X-Received: by 2002:ac8:424e:0:b0:3a8:5d1:aabc with SMTP id r14-20020ac8424e000000b003a805d1aabcmr59492062qtm.15.1671535918375;
        Tue, 20 Dec 2022 03:31:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4a4jDyD3P5OwsykxW14REihYDnY2vGZWD9Tg3lxnTugFQl9sEJVa6wbIZy/GZFfmMP4VKikQ==
X-Received: by 2002:ac8:424e:0:b0:3a8:5d1:aabc with SMTP id r14-20020ac8424e000000b003a805d1aabcmr59492035qtm.15.1671535918082;
        Tue, 20 Dec 2022 03:31:58 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id y23-20020ac87097000000b003a50b9f099esm7358183qto.12.2022.12.20.03.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:31:57 -0800 (PST)
Date:   Tue, 20 Dec 2022 06:31:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH v3] virtio: fix virtio_config_ops kerneldocs
Message-ID: <20221220063049-mutt-send-email-mst@kernel.org>
References: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:29:43PM +0100, Ricardo Cañuelo wrote:
> Fixes two warning messages when building htmldocs:
> 
>     warning: duplicate section name 'Note'
>     warning: expecting prototype for virtio_config_ops().
>              Prototype was for vq_callback_t() instead
> 
> Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.auug.org.au/
> Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com> 

I merged v2 already - squashed it in so Fixes isn't necessary.
I dropped Link: as well, probably going overboard for a fixup.

> ---
> Changes in v3:
>   - Added a Fixes tag referencing the commit that revealed the warning
>     messages (suggested by Bagas Sanjaya and Michael S. Tsirkin)
> 
> Changes in v2:
>   - Reword the "Note" comment in the kerneldoc so that it doesn't look
>     like a kerneldoc "Note" section (suggested by AngeloGioacchino Del
>     Regno)
>   - Link, Reported-by and Reviewed-by tags added (suggested by Bagas
>     Sanjaya)
> 
>  include/linux/virtio_config.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4b517649cfe8..2b3438de2c4d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -16,8 +16,10 @@ struct virtio_shm_region {
>  	u64 len;
>  };
>  
> +typedef void vq_callback_t(struct virtqueue *);
> +
>  /**
> - * virtio_config_ops - operations for configuring a virtio device
> + * struct virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
>   *       getting/setting a value as a simple read/write! Generally speaking,
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
> @@ -69,7 +71,8 @@ struct virtio_shm_region {
>   *	vdev: the virtio_device
>   *	This sends the driver feature bits to the device: it can change
>   *	the dev->feature bits if it wants.
> - * Note: despite the name this can be called any number of times.
> + *	Note that despite the name this	can be called any number of
> + *	times.
>   *	Returns 0 on success or error status
>   * @bus_name: return the bus name associated with the device (optional)
>   *	vdev: the virtio_device
> @@ -91,7 +94,6 @@ struct virtio_shm_region {
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
>   *	set.
>   */
> -typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);
> -- 
> 2.25.1

