Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9EA64E696
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiLPEDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLPEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9767FC7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671163371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bUg7DCrpGftfeECU7OexNPwbmvxXhls2VyJtY/quv18=;
        b=WJQDS0rJwV7FlNbKEZuoxpFaZ50wJH9LI2o5GM3npjjKmYlEYepC6JpOrnm+8YHL8NUR5y
        BgFX3XUu4Rc4MwPgXnkV82xGfj/i+y9d09BeCu2KhfWBgw64g71oX6v6CaETmvsjP+zrsB
        r87944Zsgm8Z5NVE/GOu1LAhf3uoRXM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-370-qPuyYvI2MWG4GJqqDFdYQA-1; Thu, 15 Dec 2022 23:02:50 -0500
X-MC-Unique: qPuyYvI2MWG4GJqqDFdYQA-1
Received: by mail-ot1-f71.google.com with SMTP id s22-20020a9d7596000000b0066eb4e77127so683837otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 20:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUg7DCrpGftfeECU7OexNPwbmvxXhls2VyJtY/quv18=;
        b=aGCrwi1qXYKEZK9WucGAYDNHIgh0cRecZRTT6XWWRGoYnkMKwHESRQjnlkzUHsys+T
         YAsxu9UkaAcfnr73KZ/O8CxBltnzP0sd+KuA7X5qgzvUgx9lMfrjQbvnmgkx3xYXQMkZ
         NkznYHr6qPyArtDHVb8JTyFaKobJRAkZJVjxvr3sKtosGKw5OQYZHhE3Ja3O8Ab9Wtai
         l57B64IylDpRhJauQ59Ed/69JTRFaGwQbpsMgjIKh4zWKg23iAorWzWqnQWvsjhz1fo9
         0UthcUkG2gBrv9RifgJajJ8qr0/O5CSoIR6nkK7NJgV5mNWKCbhNtQj0TuPzxISShIHZ
         Ii6A==
X-Gm-Message-State: ANoB5plKZX3a24+epBgcxvIJvEsCsDiRx1S0DRCJdAFn3aKJByNft+DX
        yMC8tBoiLggdHp/8i/mdvZful0LgcPuw6xMIbZwusmWa8o2WKI3lpZ57k+Btajie5Vu+0IDMEBL
        2ju3HLSZIpxfeK/rQCdfidIqQ856fUkC1R/YnBopC
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr321606oab.35.1671163369629;
        Thu, 15 Dec 2022 20:02:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ZbwN5SVcsG0tViudVD/KQAyGrKDv3T5sIawOHS5yWS6RLlOfxyro6WW/aLtbbno06tb2xhhPHHBslw0F0D2M=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321604oab.35.1671163369422; Thu, 15
 Dec 2022 20:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-6-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 12:02:38 +0800
Message-ID: <CACGkMEvkTJn7Hm5u=79nDNHQG_gakS3Cbvi=JpO38ndjHy_fog@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] vduse: Introduce bound workqueue for irq injection
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces a bound workqueue to support running
> irq callback in a specified cpu.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 37809bfcb7ef..d126f3e32a20 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -57,6 +57,7 @@ struct vduse_virtqueue {
>         struct vdpa_callback cb;
>         struct work_struct inject;
>         struct work_struct kick;
> +       int irq_effective_cpu;

I wonder why it's a cpu number instead of a cpumask. The latter seems
more flexible, e.g when using NUMA.

>  };
>
>  struct vduse_dev;
> @@ -128,6 +129,7 @@ static struct class *vduse_class;
>  static struct cdev vduse_ctrl_cdev;
>  static struct cdev vduse_cdev;
>  static struct workqueue_struct *vduse_irq_wq;
> +static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] = {
>         VIRTIO_ID_BLOCK,
> @@ -917,7 +919,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>  }
>
>  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> -                                   struct work_struct *irq_work)
> +                                   struct work_struct *irq_work,
> +                                   int irq_effective_cpu)
>  {
>         int ret = -EINVAL;
>
> @@ -926,7 +929,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>                 goto unlock;
>
>         ret = 0;
> -       queue_work(vduse_irq_wq, irq_work);
> +       if (irq_effective_cpu == -1)

Is it better to have a macro for this magic number?

Thanks

