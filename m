Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140465736A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiL1G7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiL1G7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64B8B9B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672210701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukjbzX1vWQFr/xva/9x/ei7X/FajccvHf2yreViP6fM=;
        b=TZyfv/J6O66v7aj8jWUoWftpXG/yV6sKoqpjXBuPmmXA2tSCMDMr/oBTxuKhauaY4hpo7l
        bjUO9//FUf65hCBK4TEODHuP5EeqzRonrKqg6FzSCCgN+AbNeasJr4SRaKd49bKb/8AbtI
        Q04gbxGPf1OVj11LzYP79n4BlfVZz6I=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-3Y8BAq3AOkO739cBQPOgQQ-1; Wed, 28 Dec 2022 01:58:17 -0500
X-MC-Unique: 3Y8BAq3AOkO739cBQPOgQQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1502de563fcso835007fac.15
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukjbzX1vWQFr/xva/9x/ei7X/FajccvHf2yreViP6fM=;
        b=NuRo9o8cWuPe/MQajfWGhf+zaYNi0gRs3LTnUUi4OcL+kSsWjuM1jyKwIrXdQJaM0q
         llChxdVURPllN0bV7pa1zUY/+sdRCdpipXZJsDt2zVWy6zMZGLA9Y72hj9rzYIebwR1F
         2c9UaHxbimj4cZ6vgYnB/BQ394zn+nh6B1upv3dIPvWapv6d1MBR2fNBeRBQgR8My1Vp
         +Hc/hUPbpjZojVIfr1vzwP4WVTlYgoXt4NbzNkUAyFoZ/1kfhHvMKstWOEpv+3+cveRS
         P1RiHSvs35oWBuCrGtpvMXTZmfISF8zmMJqNa5VTLT8UX3O092Ez9ZnHK6dzKrFhD0fX
         wqnw==
X-Gm-Message-State: AFqh2kp4bHu6LfEQvGNB9zSJunmFPZt/2dvWTADcOtGnZYvU7b9lwQEL
        zfcQup9hLDjbdghRT4B4K1DpstSYXz7prVU08RwqII9/YFNqys1EDwU2smFva0PyP1IH2y32w26
        K33MWrTAeviIq8EqWjkEMpS4QNSUJ3eoKkxS27Lj0
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id 17-20020aca1111000000b0035e7a427ab5mr1272502oir.280.1672210697026;
        Tue, 27 Dec 2022 22:58:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjRbcQngd3WQAoRBjABhHvQ5RUh+TMP7hoxIr4vy5ZF1s2o95GeaaGcuy+JWUIMNYFZckDvLXdwke+sLrojFc=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1272499oir.280.1672210696800; Tue, 27
 Dec 2022 22:58:16 -0800 (PST)
MIME-Version: 1.0
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
In-Reply-To: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Dec 2022 14:58:05 +0800
Message-ID: <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
To:     Tanmay Bhushan <007047221b@gmail.com>
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Dec 28, 2022 at 5:15 AM Tanmay Bhushan <007047221b@gmail.com> wrote:
>
> From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Tue, 27 Dec 2022 22:02:16 +0100
> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
>
> ifcvf_mgmt_dev leaks memory if it is not freed before
> returning. Call is made to correct return statement
> so memory does not leak. ifcvf_init_hw does not take
> care of this so it is needed to do it here.
>
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044c6442..44b29289aa19 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>         ret = ifcvf_init_hw(vf, pdev);
>         if (ret) {
>                 IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
> -               return ret;
> +               goto err;
>         }
>
>         for (i = 0; i < vf->nr_vring; i++)
> --
> 2.34.1
>
>

