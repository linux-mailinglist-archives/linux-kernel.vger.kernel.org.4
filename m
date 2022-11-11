Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2863A6253E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKKGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKKGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF16327E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668148480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1SBdufX+flggeoNplMAMsXncPCQnRWs3FUbWH+qL6Q=;
        b=cPqwZsfdi5Mv6EW95e9Ls3vNraVYUCoHofU5HLPNPo65brQ5Ic+3+1ZvCDcQxJVoJdDVjt
        AgXZxuTNiquokMC44K9XIUVpzW9J29+Cd00SfLgqingZtKGG1l4f9QidolvGn4StDllj5a
        lDztGxiprSj7FMMa2eCA4PM3g261N2s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-fLO9nC_iMSGk6uJnzQ_QNA-1; Fri, 11 Nov 2022 01:34:39 -0500
X-MC-Unique: fLO9nC_iMSGk6uJnzQ_QNA-1
Received: by mail-ed1-f69.google.com with SMTP id t4-20020a056402524400b004620845ba7bso2977540edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 22:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1SBdufX+flggeoNplMAMsXncPCQnRWs3FUbWH+qL6Q=;
        b=MZ56l8/fWl/wMUhnyOFQCczUO3ax8URuYqcHGym0w93zzMlYtZG/yaTM2ohLrlzb6T
         DVxgS20YXBaFTM0ReHjWH/uuhOmJB+RoHSthJHGCHe5W+MCkAYuPiCHasmhng80Ux+7L
         2xJxwDmgzp6zQ1u+RGbMA7AeHYw+cRGuhq8MvE9dGRSKRhstJV+tHTMzmZCbo0buLPXs
         vEVAwRBIqvEVfDZcLOnFWalY7U2EO8eMHExd6ji0EMFLb5jfkwJMPVYdybkV9iuGjM6I
         rzg4R1EEYjgEvuaAnY8zN+MFa+DAOj+/bERgXOZ1FFuoIn4z8L1pq6I10Ob/yxjP6wxX
         +dBg==
X-Gm-Message-State: ANoB5pl+5Pz2NY7iuZzUPwxriDvSQP4wxM65kMCzeVHyvESSe8SFUWBl
        x3KuvagAuWlTEGnjw9Tyj2c3fYRsMsdg2eF0knOhRa+xebRkaW2967UFDYOMUZqioHGHuY2L46c
        p9lroeJxl2csfbUPNxmY7duL3V0pWPa2uBLZFbmOK
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id q1-20020a170906144100b007adb97e283amr708013ejc.567.1668148475741;
        Thu, 10 Nov 2022 22:34:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7NURk90dJe46Y9VlLLQA0NXmHgm4YuMHmbjfycuMXqhT190gmtbUwNycASbJRMQpVacAQLU0NRwhmuJexXjhM=
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id
 q1-20020a170906144100b007adb97e283amr708001ejc.567.1668148475547; Thu, 10 Nov
 2022 22:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20221110141335.62171-1-sgarzare@redhat.com>
In-Reply-To: <20221110141335.62171-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Nov 2022 14:34:22 +0800
Message-ID: <CACGkMEvmumcokt4UpazGKWfOeLDrh+kaLEWywQtPF0dJfW-kUw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix vringh initialization in vdpasim_queue_ready()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Eugenio Perez Martin <eperezma@redhat.com>
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

On Thu, Nov 10, 2022 at 10:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> When we initialize vringh, we should pass the features and the
> number of elements in the virtqueue negotiated with the driver,
> otherwise operations with vringh may fail.
>
> This was discovered in a case where the driver sets a number of
> elements in the virtqueue different from the value returned by
> .get_vq_num_max().
>
> In vdpasim_vq_reset() is safe to initialize the vringh with
> default values, since the virtqueue will not be used until
> vdpasim_queue_ready() is called again.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..b20689f8fe89 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -67,8 +67,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>  {
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> -       vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> -                         VDPASIM_QUEUE_MAX, false,
> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, false,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> --
> 2.38.1
>

