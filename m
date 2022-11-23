Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC11A6364B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiKWPvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiKWPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:50:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834FC8B11A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669218571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KF/ov70bORdprLanpzIpmLSFeEwa9e3wCywBo/4P5WE=;
        b=amB4gwMR5notD8cQ+Oi7tHbDwYzeIz6mr2rSOqjZzjI/6xBS4RzyIgHeYmj842tOnPao69
        kApmVssGznQqwEG9ggAieC9U8lKb8V6uKa6HyrzgUkkCTCUHiDD9Xg0o+dTLk8ym4E0EeP
        ViTMZ/4z4ZrhLtvExWbgMeYuSU87X+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-kTDUYF1zPWms8PPC1SQs2g-1; Wed, 23 Nov 2022 10:49:30 -0500
X-MC-Unique: kTDUYF1zPWms8PPC1SQs2g-1
Received: by mail-wr1-f70.google.com with SMTP id u24-20020adfa198000000b00241da98e057so2670682wru.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF/ov70bORdprLanpzIpmLSFeEwa9e3wCywBo/4P5WE=;
        b=H0Wxj8Z5cexqqKflRlbLGsNMp1msmBBGTNpGdYNB5TY8+mna9uUg2w7vJ08N6rXU+J
         om0maKVB28zUoqomP7jgsUemGls/fAWDDFkfxLGSmcmOqAw+z+sh4bGKI7UxqXjBObtT
         tL1QIEJbK5D7E0wQe330WfkxhgEWSOIbEiUhU3d/dYKFLffctGn4R5HRDtBrJPvUHjBW
         I2jPUm/KXbPYPY9WcwAF5KqkM8I1ZvQMJt9ycGujkF3a1KpWm9JQ4T7jy8pqFLIJOZXG
         T/S7rbLJ0ldqeEg1ZGvQN3roaL7gFoZ+jLIFWsGZm7ENSCoWvF8sLk33A+Q92GwRD8Rf
         vM/A==
X-Gm-Message-State: ANoB5pmZu0ljG4HIuqOrXXlJ/J8nGb8lMmJ8pjcy0uwCF7aKLJJS7HKA
        YBNUqj1dSbEO+q+plRdgEtBd4sXFKgS28UIZ4q+ZfrPh6MJvLfixFHWr+EJjVmVyF8L6nBl5dtn
        M3e7pbHTe+IXpERLEKlhCBdqC
X-Received: by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id o6-20020a5d6706000000b00241cf90ab1emr8060362wru.685.1669218568965;
        Wed, 23 Nov 2022 07:49:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5MXC1Gnn3d7MuC2idiVTxfYIH+t32YkYXeo2vUYG8xk+Blpi+PNvoc7oab2ZPOg4ajRWOf5w==
X-Received: by 2002:a5d:6706:0:b0:241:cf90:ab1e with SMTP id o6-20020a5d6706000000b00241cf90ab1emr8060343wru.685.1669218568717;
        Wed, 23 Nov 2022 07:49:28 -0800 (PST)
Received: from redhat.com ([2.52.16.74])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b0023c8026841csm17024927wru.23.2022.11.23.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:49:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:49:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: sanity check on callback of virtio drivers
Message-ID: <20221123104757-mutt-send-email-mst@kernel.org>
References: <TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:32:27PM +0800, Dawei Li wrote:
> This commit includes changes below:
> 
> 1 Since register_virtio_driver doesn't force probe & remove
>   to be mandatory callback, so it's caller's job to make the
>   sanity check before invocation.

What's the point of these checks? I don't see how any driver
won't have these set. Why waste memory checking?

> 2 Replace sprintf with sysfs_emit or its variants for their
>   built-in PAGE_SIZE awareness.

this makes sense.

> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  drivers/virtio/virtio.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 828ced060742..e391a8dff333 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -15,7 +15,7 @@ static ssize_t device_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%04x\n", dev->id.device);
> +	return sysfs_emit(buf, "0x%04x\n", dev->id.device);
>  }
>  static DEVICE_ATTR_RO(device);
>  
> @@ -23,7 +23,7 @@ static ssize_t vendor_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%04x\n", dev->id.vendor);
> +	return sysfs_emit(buf, "0x%04x\n", dev->id.vendor);
>  }
>  static DEVICE_ATTR_RO(vendor);
>  
> @@ -31,7 +31,7 @@ static ssize_t status_show(struct device *_d,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
> +	return sysfs_emit(buf, "0x%08x\n", dev->config->get_status(dev));
>  }
>  static DEVICE_ATTR_RO(status);
>  
> @@ -39,7 +39,7 @@ static ssize_t modalias_show(struct device *_d,
>  			     struct device_attribute *attr, char *buf)
>  {
>  	struct virtio_device *dev = dev_to_virtio(_d);
> -	return sprintf(buf, "virtio:d%08Xv%08X\n",
> +	return sysfs_emit(buf, "virtio:d%08Xv%08X\n",
>  		       dev->id.device, dev->id.vendor);
>  }
>  static DEVICE_ATTR_RO(modalias);
> @@ -54,9 +54,9 @@ static ssize_t features_show(struct device *_d,
>  	/* We actually represent this as a bitstring, as it could be
>  	 * arbitrary length in future. */
>  	for (i = 0; i < sizeof(dev->features)*8; i++)
> -		len += sprintf(buf+len, "%c",
> +		len += sysfs_emit_at(buf, len, "%c",
>  			       __virtio_test_bit(dev, i) ? '1' : '0');
> -	len += sprintf(buf+len, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
>  	return len;
>  }
>  static DEVICE_ATTR_RO(features);
> @@ -302,9 +302,11 @@ static int virtio_dev_probe(struct device *_d)
>  	if (err)
>  		goto err;
>  
> -	err = drv->probe(dev);
> -	if (err)
> -		goto err;
> +	if (drv->probe) {
> +		err = drv->probe(dev);
> +		if (err)
> +			goto err;
> +	}
>  
>  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
>  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> @@ -329,7 +331,8 @@ static void virtio_dev_remove(struct device *_d)
>  
>  	virtio_config_disable(dev);
>  
> -	drv->remove(dev);
> +	if (drv->remove)
> +		drv->remove(dev);
>  
>  	/* Driver should have reset device. */
>  	WARN_ON_ONCE(dev->config->get_status(dev));
> -- 
> 2.25.1

