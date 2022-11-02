Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35CF615BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBFf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKBFf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F861163
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667367277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1I2T+2/Dxfm9YlZ7q9jKIOhGfg+UzZ9X3JKRBk8sZw=;
        b=ClSQZcDFILjUVFRPaoy6FnPnYL7xl1mEIxzuwbCHKfJaO2hYUxJF7GlJdATsFrwv/48IQ4
        vmqB1Tmyfi0cr/DEf+rs022aN7fFx2ZpMD4eZ6uJPXDmKlifA7QNf37bT4+wMyOqL/KPkj
        ODwjkNGmAK+dA3pn+YAlvvjqKP7HTfQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-tlshegsHNCajveAn8RXT_Q-1; Wed, 02 Nov 2022 01:34:36 -0400
X-MC-Unique: tlshegsHNCajveAn8RXT_Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13ba8947e4cso8363675fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 22:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1I2T+2/Dxfm9YlZ7q9jKIOhGfg+UzZ9X3JKRBk8sZw=;
        b=A/1/0nWM8VizPwYFehGl1UHlUNzq/Kn1c0gGMAhNeSj90D+auq9KcYBOWuk6K7ekhH
         1IQpuvN2AyP0XUF+ae+RX3ns0i9Vt5CFcKK/GcYNB9SwhrwsMg9n3n4GudTi8eAjfL/L
         Kd39Fpm9ASFrO8FJd8NxrciGsUCE33p0NGYJGFuZuFa3V9U8kwa9tTYrWKiWEYPyh+GB
         ouo8bJZOdUHly4zalN6U0KmKRgwAboJC1M+fm+szN8V91txTphCbYwzGIWwEqTTJqYyO
         +Pj9dATQxCNDGlLOR219ZJZiT7dhkkLFFRowHsf7305FE/YdOZHW8uncp/KrOBoVEbsH
         2Vbw==
X-Gm-Message-State: ACrzQf2XplFhw19xHGgWEr8M7hLW73bmKTd++aZqCLwZkZ4R4ZP6l6UQ
        87Dgf5hHzGKVNl9XfjIc6R66qNXvbj8XjuUIDDJflhoFGOH+SFlE+nd7PN5IOC1dYqDYKAoPPhh
        K8y40fnYJWAydn5jyKNGujj0cCan8r+gNcP4tFt3+
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id t14-20020a056871054e00b0013b29b7e2e8mr22473283oal.35.1667367275364;
        Tue, 01 Nov 2022 22:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lMHmKVqFfYJ+4BBy6X8pl2zo+yvdvZ342P4QBfqvmiuEti4C3GFtm9zo5CotzTsTk01EWfGY+2IBJSDrtmFw=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr22473271oal.35.1667367275173; Tue, 01
 Nov 2022 22:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 2 Nov 2022 13:34:23 +0800
Message-ID: <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lingshan.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> Virtio_crypto use max_data_queues+1 to setup vqs,
> we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> if common->num_queues is not set well,and it return -ENOENT.
> It is better to use -EINVAL instead.

I'm not sure I get this. It would be better to describe:

1) what kind of issues can we see if we return -ENOENT
2) why -EINVAL can help in this case

Thanks

>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index c3b9f2761849..edf2e18014cd 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         int err;
>
>         if (index >= vp_modern_get_num_queues(mdev))
> -               return ERR_PTR(-ENOENT);
> +               return ERR_PTR(-EINVAL);
>
>         /* Check if queue is either not available or already active. */
>         num = vp_modern_get_queue_size(mdev, index);
> --
> 2.25.1
>

