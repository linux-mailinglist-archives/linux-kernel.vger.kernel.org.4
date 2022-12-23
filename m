Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A17654F01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLWKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLWKMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E13F014
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671790300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsRBNe3WT8BRQoVRu10Z7bp050T1kGX33i/INXm09e0=;
        b=eyRd2eo2tcrFNWoQlrlqpBr78EDkFvz5VrirvmidllsoGf1+wQXji7AS/whReoz4tdnplE
        S0pfNCtc2XAYIGJILFUWW86DYPjgonTz8NFOP4Z+N3eWheNmqbi4pk6GPs5SV3iwu0rDBa
        KFaUMpOz2g8bXJAT0QVrZih0DnB2xG8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-id_sWNBuM1OfEAWGX3IsSw-1; Fri, 23 Dec 2022 05:11:38 -0500
X-MC-Unique: id_sWNBuM1OfEAWGX3IsSw-1
Received: by mail-ej1-f70.google.com with SMTP id oz11-20020a1709077d8b00b007c0dd8018b6so3171484ejc.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsRBNe3WT8BRQoVRu10Z7bp050T1kGX33i/INXm09e0=;
        b=tv/AkD3KE9ztMlF9IXRS/LFPPwDa/A84EJp12xEoYJnLNJotQESMnryTTgf0EiWykm
         LsE+LMG8419TcflgSLqXi95ulEKoJ0vKQV0FaiFxJzdoiW0oVsmAJL0zdQSQGlR46iP6
         q8RC5r1aXGNd2K8pT7HO57slT+EaC6tbB4iSOab+MlX71+z5bYz1LhdNE02Onn1FDveQ
         nnIfv9dLZsIFbscraLSCjYBqEiyXtIBxg96aV1u/j7BdDCAMnV26B9TNCq4xlMRxU+Q9
         kuKkTECOD3wc3qpYq/9EUhJtUT9Gj4/KEJBNQBX3LxNYb6cWHC37oZr/XBni5hTFgs5o
         61CQ==
X-Gm-Message-State: AFqh2ko1Nx3EPH7aUCT9SjsNNszGHGtu1XcrcRU0gp7U+TAwZvFmKvz2
        CsXXdC2iCrgpOwcEobRsE57VlqwL0zUaWEMzpDclitq8ig/ijpzwFSNnxRvWTjSMHJeHoBpIXOk
        mBDI3rdzSeguoi/YUra3oXILg3Q/1C1DTNdlTWAZD
X-Received: by 2002:a17:906:a391:b0:7b2:7c9a:1849 with SMTP id k17-20020a170906a39100b007b27c9a1849mr658255ejz.733.1671790297201;
        Fri, 23 Dec 2022 02:11:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs6Iua26tQDi1dvHBARcoUy4CVZWUKKnuoAHm57aOGEIb64b3504j53uCzzLQe9lijs3H9fhof0HN/HBjCrY7Y=
X-Received: by 2002:a17:906:a391:b0:7b2:7c9a:1849 with SMTP id
 k17-20020a170906a39100b007b27c9a1849mr658249ejz.733.1671790297000; Fri, 23
 Dec 2022 02:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221062146.15356-1-jasowang@redhat.com>
In-Reply-To: <20221221062146.15356-1-jasowang@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 23 Dec 2022 11:11:00 +0100
Message-ID: <CAJaqyWcb6WniP33fb7UOQvxPN=i4LmBN2Jkmky2aCDs4RS6arw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: use weak barriers
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 7:21 AM Jason Wang <jasowang@redhat.com> wrote:
>
> vDPA simulators are software emulated device, so let's switch to use
> weak barriers to avoid extra overhead in the driver.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index b071f0d842fb..eeaeaf43b476 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -68,7 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim=
, unsigned int idx)
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>
>         vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_feature=
s,
> -                         VDPASIM_QUEUE_MAX, false,
> +                         VDPASIM_QUEUE_MAX, true,
>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>                           (struct vring_avail *)
>                           (uintptr_t)vq->driver_addr,
> --
> 2.25.1
>

