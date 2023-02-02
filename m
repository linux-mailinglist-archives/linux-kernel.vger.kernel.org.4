Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643DE688560
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjBBRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjBBRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDC6B362
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675359000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNaVe47uc7Q0fXzG8SuhGtyD3Y8OoxsATTFxBzgPmNM=;
        b=EvUFGcDM9VPMNV/4j8mgFQ6xNLRCJLb7G4hXsBeB9oXhhkhM6GX7R7nrx9cVSaoQgoC6Dy
        MDDfQX4cN0cL+5r+ueFS29OYyjdRN6NaC6YjfzkQnx7/b/LlqHf6P5ncUMTCsTNs/FMXwG
        d7cfxpKE+psSxCWy7MwJ/u7lKkErwwY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-tA-1cEKGP1C64byYqWp6Zg-1; Thu, 02 Feb 2023 12:29:59 -0500
X-MC-Unique: tA-1cEKGP1C64byYqWp6Zg-1
Received: by mail-ed1-f71.google.com with SMTP id o21-20020aa7dd55000000b004a245f58006so1923874edw.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNaVe47uc7Q0fXzG8SuhGtyD3Y8OoxsATTFxBzgPmNM=;
        b=wyW5oanLTHvFjKJaMSDNG6dcyt4whjTFPuTBql7h9qjVYbcqD5qolgC5+Ezrqk6VIl
         9BN9WSRq6e+FLi8bWScJTsE3n8HvQC/TWWTkFJ59g176j5D95+APirZGNz7Uzibn9khO
         8SnkBWECrk2D5E6p9AQ7zsLiGK8ZQ9OIBBQGZFw4j+FnMDV2SOnlajqw8ZNCq3QXQ4JI
         PYnBbOrS4ZtPNqCs2KZSvdFQezS4SnmTXt56ymjMtjG9KukNbZF35MRuAXwy50YyYX87
         +hUHJKKxONMz7hnXKHpKZaBduXAUeOeXM4Pxs4XzdNI7HkUxQr8r3zyPmUiJFBeZu1zt
         iN4g==
X-Gm-Message-State: AO0yUKUpZOoZXFVLIabJ29AG+PqVeIzg74//dXH+qtgd1CVAOXS6QzsJ
        4eWceyhXZiBtbxC2vsAC647yc+x6zrDUkiBXlvmdk8brFWwStu1K4XXXmdLpdE8uAWcYF9TIXUL
        gsDKAhhXUE5nPPi04m1YaQAbE
X-Received: by 2002:a17:907:6d15:b0:885:fcbd:40d3 with SMTP id sa21-20020a1709076d1500b00885fcbd40d3mr9622063ejc.8.1675358998409;
        Thu, 02 Feb 2023 09:29:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9yIZcEAYWK0GKq9rUYiFeEPeWHuu/njEMLeGRI1WCVonMJlxY1eZTX3Mwnwugq0+WHvT35eA==
X-Received: by 2002:a17:907:6d15:b0:885:fcbd:40d3 with SMTP id sa21-20020a1709076d1500b00885fcbd40d3mr9622045ejc.8.1675358998189;
        Thu, 02 Feb 2023 09:29:58 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906534900b0088478517830sm70616ejo.83.2023.02.02.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:29:57 -0800 (PST)
Date:   Thu, 2 Feb 2023 12:29:54 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] virtio: VIRTIO_DEVICE_F_MASK for all per-device
 features
Message-ID: <20230202122851-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-5-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675207345-22328-5-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:22:22PM -0800, Si-Wei Liu wrote:
> Introduce VIRTIO_DEVICE_F_MASK bitmask used for identification
> of per-device features. Feature bits VIRTIO_TRANSPORT_F_START
> through VIRTIO_TRANSPORT_F_END are reserved for transport
> features hence are not counted as per-device features against
> the 64bit feature space.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  include/uapi/linux/virtio_config.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Pls don't add this in uapi, people tend to depend on this and then
things fail when we extend virtio. For example this won't work with >64
feature bits.

> 
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 3c05162..3bdc7ed 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -54,6 +54,14 @@
>  #define VIRTIO_TRANSPORT_F_START	28
>  #define VIRTIO_TRANSPORT_F_END		41
>  
> +/*
> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> + * all 64bit features
> + */
> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
> +			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
> +
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
>   * suppressed them? */
> -- 
> 1.8.3.1

