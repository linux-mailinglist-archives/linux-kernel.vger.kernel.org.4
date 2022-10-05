Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698EE5F5262
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJEKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJEKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:18:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBE21E39
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664965115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x41/5klT3HDcc3qHUO/xtt9h6BjGcktdGOkkPFwNbTk=;
        b=UVz7TmqB1Bqzm2FxAaRlCb1bmlBtJp8cw5bpAbW8ajNR82GNRS3pikJJy7Bl6pWea+6dEJ
        dX7xANfMGPsswXtl1uh+QIKz4G79d5YPPfFU3Ny1vXKrPH+TNuITDoP7Z7EMdRxqItaMhA
        UCsl6jzoIZpIrRq2ZfhTh6DJqRfH1CE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-gMw2LUM5O4mp4d7RvWBIaQ-1; Wed, 05 Oct 2022 06:18:34 -0400
X-MC-Unique: gMw2LUM5O4mp4d7RvWBIaQ-1
Received: by mail-ej1-f72.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso6195384ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 03:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x41/5klT3HDcc3qHUO/xtt9h6BjGcktdGOkkPFwNbTk=;
        b=Q7E7SAd426yXWG1/qLmuQI1DUXubQAMmfihJugK53hqDz8piSk283/rmkSFdOztoO/
         JQ06Nd6hXWLemjxwKzcrNKZu/cKKeCeGblIo0XuA605cmr5qnZN2ucezvWNBuqoRlSp/
         2ZppfnhpR/hKXpJf1OWy+rg1U1+mdW/BbaV2dGvV//I3Rgt2o8cmT5ZcNObevaG/448u
         yiNtLwfyhS57iGsFeLRJSAUAA3ciYRNnvmHybXxG6VkkFp88GXPapYGNFBbgjC+bTHVF
         pPUf9fgOBc5KjM2BOxxoKfq347hQh5P29ETgK3RbsruNJkDkrcr6rlFHf7FmY+U0xw06
         apGg==
X-Gm-Message-State: ACrzQf19uVQ5mtMdJdjoG419R8E4hxI7dH5zSsd8DoSQWIMYo82kErd5
        uId6CTB6Th1RNTVNllueRNm77A9B1c+CXMrNepGa63Bt1fX5aMUqYlrGdJSBQoyqajWBU2W2jzn
        bEjamE0NODuDywPnflJVNwv7a/amV+APaOW+QGq97
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id eq13-20020a056402298d00b004515fc5d423mr27385189edb.102.1664965112465;
        Wed, 05 Oct 2022 03:18:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Q2Be0EZiS40BB/UlOpYk38i36HWcBT5ILV8Eb8kxwz4LCRB5s881Uem4lPfFPpVuDFdhhDY3/u/OObRmsBhM=
X-Received: by 2002:a05:6402:298d:b0:451:5fc5:d423 with SMTP id
 eq13-20020a056402298d00b004515fc5d423mr27385181edb.102.1664965112292; Wed, 05
 Oct 2022 03:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811084749.83809-1-sgarzare@redhat.com>
In-Reply-To: <20220811084749.83809-1-sgarzare@redhat.com>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Wed, 5 Oct 2022 12:18:20 +0200
Message-ID: <CAGxU2F6hQLbi2inrA+Tjd9YrfRovppZR=sbDxDD42=94nYw4MA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix warning casts when building with C=2
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Use __virtio16_to_cpu() to read `max_virtqueue_pairs` field in
> virtio_net_config since its type is __virtio16.
>
> This silences the following warning when building with `make C=2`:
>
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast to restricted __le16
>     ../drivers/vdpa/vdpa.c:811:19: warning: cast from restricted __virtio16
>

I just noticed that we still have these warnings, maybe this patch has
fallen through the cracks, so I just ping kindly to include it in this
merge window :-)

Thanks,
Stefano

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index c06c02704461..2466d5087478 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -808,7 +808,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>         if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
>                 return 0;
>
> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> +       val_u16 = __virtio16_to_cpu(true, config->max_virtqueue_pairs);
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> --
> 2.37.1
>

