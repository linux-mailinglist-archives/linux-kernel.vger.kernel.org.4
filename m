Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F76FE21B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjEJQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88C72B7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683734667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20W4Czom/LJp0YWSRRHuIr7SauQc+F/OF764Zl7g/+k=;
        b=WuK9j0NJ9u8lMxbU+opeyElpodMUFH1PBg5+xBmh4BxGqdz6SEs0ffzzYTwyU4JVE1FJE5
        9xSXDtALFfhRjItCVTaa78V3+s/mv8y+SRO0QJGDUl3QWE/OxkrnVeF1mxRH6QxGcndlYd
        k48p93B/19sR+LV36fV860miujmI5MY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-N6qOdVcCMOmnykCZLdjs3Q-1; Wed, 10 May 2023 12:04:26 -0400
X-MC-Unique: N6qOdVcCMOmnykCZLdjs3Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f348182ffcso46661455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734665; x=1686326665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20W4Czom/LJp0YWSRRHuIr7SauQc+F/OF764Zl7g/+k=;
        b=a4fE4TsE3kEpJTMZmYBEFhYPz5QUnJng6NMp/RzHWXprxxO4xDNrTkiPdhCBDTjjlU
         MjrweVJngO/Fr71IjN31WDJnWwq6O1YXWwrSCVp9xvdCHM+NYrdHKvHmnpxykxGqRC68
         n/dJbysmaDVhRYMPOtQzC2jOg+KZCIWro7cedygRQTXHKNgyHDhphzEOHf1MaWBcehhA
         trF4Iud1uIRnaThrTbdpaCE5qW9ZRx/PSRg/rzEuFeNou9qwW5JD7FMvSfNstDA2OzFU
         RTawD3xVHppSimK9O7XrMfW+BRdT6zaSTUNQ6EYZx0T4r7bURDlloWXduHLn6uVIV2Df
         YK8Q==
X-Gm-Message-State: AC+VfDzAugm3E71mSLUKgs2Gvt4qt8jZ9L5wcvZ9Q7hvvRtvpCGlWVK0
        fylUZC8GZ2L95Xh4cs8sZJ1nX1lZtABisqbYcNXbBXJetptajpM9nDJaF7f+CglVjv4ObSWTsDu
        P33OydnrePg1/vmAyZo4pDK6r
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr7838666wmq.19.1683734665553;
        Wed, 10 May 2023 09:04:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4B9LaeUTLsozM8szgufxr/B/Bt2vHbFZ0LpsmFrPFfyNdAV/BNdYrFPVeeFecPUepl4T7lUw==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr7838651wmq.19.1683734665269;
        Wed, 10 May 2023 09:04:25 -0700 (PDT)
Received: from redhat.com ([2.52.1.223])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f17122587bsm23382638wml.36.2023.05.10.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:04:24 -0700 (PDT)
Date:   Wed, 10 May 2023 12:04:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <20230510120332-mutt-send-email-mst@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> Add missing documentation for the vqs_list_lock field of struct virtio_device,
> and the validate field of struct virtio_driver.
> 
> ./scripts/kernel-doc says:
> 
>  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
>  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
>  2 warnings as Errors
> 
> No functional changes intended.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..0b2b82ee3220 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
>   * @config_enabled: configuration change reporting enabled
>   * @config_change_pending: configuration change reported while disabled
>   * @config_lock: protects configuration change reporting
> + * @vqs_list_lock: protects @vqs.
>   * @dev: underlying device.
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
> @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @validate: the function to call to vaidate features at probe time.

typo

and this is called before probe actually not at probe time

>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.

