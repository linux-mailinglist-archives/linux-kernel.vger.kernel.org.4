Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EF962228A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKIDZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKIDZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A9192AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667964277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1qirjMG3kZUXL8rp78PkVsEriIi9ata3YC3IMmDFgo=;
        b=Rigx1i/2Ku9x3DLO5JOv66QoRAjFAwSu3neFsFQP7BdHMOqVhaPvr6OhOmOTdFtYqXCjG8
        Vsx7rRBBKheMAVSShyfO8qKpYM+iMbfvvDYGK5gdiS2bkkwCIIkqQAVVBv3FFIia1vSjV7
        xhwEL7dH2PAnBcJMIYO1JbuKUThpkLw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-509-EzwSKIIgP8q3xfnrizIPvg-1; Tue, 08 Nov 2022 22:24:36 -0500
X-MC-Unique: EzwSKIIgP8q3xfnrizIPvg-1
Received: by mail-oo1-f70.google.com with SMTP id n27-20020a4a611b000000b0048067b2a6f7so4427263ooc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 19:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1qirjMG3kZUXL8rp78PkVsEriIi9ata3YC3IMmDFgo=;
        b=lswiX7pFsb5zvjX86LZhnGo2gpSrHx40wprEs0ehc/jF32DhKARunFUCzjZRrl2pAc
         tFf+GyhRb2yJGT5EO32aq9cLkWXvosDC+60nM+xU5weQiPaB3ofiC2tsXcHPTKFwTvta
         7VJSwI96skIDA1UPlkIZQZW/4k/INlRT8IFxkup2DjAmofeULQ4Qyg411EJzOccs118q
         Gmz4d+IY0WGRRCL2M+RObTvyAVyBHACvp4y+B9YHnhn6NfZD1kJo7nSkw4nxmVoAtcys
         9s+EI/P+k3v1e0CCo0s4TDii6J0QSqDpe577T1pIFMPK0UEM21EbN+CwUT1wva4uMpZX
         YLcw==
X-Gm-Message-State: ACrzQf3qdbL2ikMfJWwMzi7IZiz84j0kNqaaIp59EJ7rJXXHXpt18grJ
        WItKOHYDEJfEd5Rjavraw06hTGevdMmInfu5ZuCXi+67WSmgFcDi5AyJlDWYHOGVwByvGUlrQxL
        sjGlzQM6ZKC1Sz8qkDM2AdBK+bVwBDsKm1SpoLG8a
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id o198-20020a4a2ccf000000b0049eb5023a2bmr9788969ooo.57.1667964275439;
        Tue, 08 Nov 2022 19:24:35 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4TS8SZHDk+F11XcIXyOjWg7x3CStUwgN7DXqTHrvfbCTUgELD600O6A1TkWZj32gJcP6VoqsHMRgJlXrNy6A0=
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9788965ooo.57.1667964275202; Tue, 08
 Nov 2022 19:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20221108103437.105327-1-sgarzare@redhat.com> <20221108103437.105327-2-sgarzare@redhat.com>
In-Reply-To: <20221108103437.105327-2-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 9 Nov 2022 11:24:23 +0800
Message-ID: <CACGkMEu+T1zX0XQbe2NR24MBC1LfV6ECv6vOm7ofrvqCJZ4avA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vringh: fix range used in iotlb_translate()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org
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

On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_iotlb_itree_first() requires `start` and `last` parameters
> to search for a mapping that overlaps the range.
>
> In iotlb_translate() we cyclically call vhost_iotlb_itree_first(),
> incrementing `addr` by the amount already translated, so rightly
> we move the `start` parameter passed to vhost_iotlb_itree_first(),
> but we should hold the `last` parameter constant.
>
> Let's fix it by saving the `last` parameter value before incrementing
> `addr` in the loop.
>
> Fixes: 9ad9c49cfe97 ("vringh: IOTLB support")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vringh.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 11f59dd06a74..828c29306565 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1102,7 +1102,7 @@ static int iotlb_translate(const struct vringh *vrh,
>         struct vhost_iotlb_map *map;
>         struct vhost_iotlb *iotlb = vrh->iotlb;
>         int ret = 0;
> -       u64 s = 0;
> +       u64 s = 0, last = addr + len - 1;
>
>         spin_lock(vrh->iotlb_lock);
>
> @@ -1114,8 +1114,7 @@ static int iotlb_translate(const struct vringh *vrh,
>                         break;
>                 }
>
> -               map = vhost_iotlb_itree_first(iotlb, addr,
> -                                             addr + len - 1);
> +               map = vhost_iotlb_itree_first(iotlb, addr, last);
>                 if (!map || map->start > addr) {
>                         ret = -EINVAL;
>                         break;
> --
> 2.38.1
>

