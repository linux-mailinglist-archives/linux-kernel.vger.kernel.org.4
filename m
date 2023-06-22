Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B308739FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFVLj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVLjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B81FC6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687433839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
        b=KdZ3vmElMF0HaY3HDgoP54qaWF6TkFdZ3I80m0SwoYejP4MUeBoDYGc+K7Hf8S6xou3wJd
        oRt7Y+vVRww+UT1zL6XL4kXxIm/ov6oYF6ey/whWVqQKu7EXCHy6vuVqJextVFYgNN5TRY
        Jpah9yQcjwKnwgW6HJ2LhH4jwFpDUeY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-gEs23B0GNUKBXlGXwVwP-g-1; Thu, 22 Jun 2023 07:37:17 -0400
X-MC-Unique: gEs23B0GNUKBXlGXwVwP-g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-98843cc8980so468833966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687433836; x=1690025836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7SKEzo0tiPtjA/r8jOe2vPyIc6DKSYtWpFv1BZVSgU=;
        b=UHklVPm8MmT0BgZap6qCpXly9xJuU1LqnYazdIEDVYsONbVVh/C0ylDP8O2dewR+wY
         KyFU3lc7ogwgJnEzJkgBci35Ohg/KnPn7no47T2h+oW5nbMNDGbxa1M8G3TwrQKLwLb7
         hlwTPE5KQ9jlwv51TuhBlolRj1SXf0SH7/lEl6E1p1wDcijF5sW+bu7KIqhIxhZbXLWs
         DUUmASb0r/YBYMmiSGsaggt3gVSSPtxCGhYvGVDlQgvOA1FsYVz5dJ07oFdyLadC/+n0
         8bcWkCzcW2Kq3PPwqm/9xK2UVtIfRLQbeh8ZemzNC07gJuR/G4vOA6V+Vh2krKEgI1xW
         VyoA==
X-Gm-Message-State: AC+VfDzCJuz4uhtO/iZwQRwV+gmbYJ+jlowRU8pqu7QhDzsYzHyAJLbB
        hiLe+cWwItuiQC02mKmUEDeAvIweTFBH83qUmT657WDGXQ4b9R0vaEp3zTBDoWHLwhnYECwklLf
        rYmvPFlT0WGKisamCQRj7V2Am
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id ji16-20020a170907981000b0096fbceadf87mr18311950ejc.42.1687433836423;
        Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+6ZFEmHAogYeFG0AWvOJXQRz4NqoLSKP89l/++Hp1rS3Ll408wTBVz5tejEgoel33u4yaOA==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id ji16-20020a170907981000b0096fbceadf87mr18311937ejc.42.1687433836129;
        Thu, 22 Jun 2023 04:37:16 -0700 (PDT)
Received: from redhat.com ([2.52.159.126])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906644b00b00988956f244csm4586680ejn.6.2023.06.22.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:37:15 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:37:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: filter VIRTIO_F_RING_PACKED feature
Message-ID: <20230622073625-mutt-send-email-mst@kernel.org>
References: <20230605110644.151211-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605110644.151211-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 01:06:44PM +0200, Stefano Garzarella wrote:
> vhost-vdpa IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE)
> don't support packed virtqueue well yet, so let's filter the
> VIRTIO_F_RING_PACKED feature for now in vhost_vdpa_get_features().
> 
> This way, even if the device supports it, we don't risk it being
> negotiated, then the VMM is unable to set the vring state properly.
> 
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

OK so for now I dropped this, we have a better fix upstream.

> ---
> 
> Notes:
>     This patch should be applied before the "[PATCH v2 0/3] vhost_vdpa:
>     better PACKED support" series [1] and backported in stable branches.
>     
>     We can revert it when we are sure that everything is working with
>     packed virtqueues.
>     
>     Thanks,
>     Stefano
>     
>     [1] https://lore.kernel.org/virtualization/20230424225031.18947-1-shannon.nelson@amd.com/
> 
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8c1aefc865f0..ac2152135b23 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -397,6 +397,12 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>  
>  	features = ops->get_device_features(vdpa);
>  
> +	/*
> +	 * IOCTLs (eg. VHOST_GET_VRING_BASE, VHOST_SET_VRING_BASE) don't support
> +	 * packed virtqueue well yet, so let's filter the feature for now.
> +	 */
> +	features &= ~BIT_ULL(VIRTIO_F_RING_PACKED);
> +
>  	if (copy_to_user(featurep, &features, sizeof(features)))
>  		return -EFAULT;
>  
> 
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> -- 
> 2.40.1

