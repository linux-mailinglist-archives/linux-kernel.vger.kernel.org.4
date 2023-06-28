Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A59740AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjF1IJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232099AbjF1IEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofwo3P8uKOaWvV1X+hYEb8hA8CV2BceFbJ10PxbVumI=;
        b=BqbSGWJ2/dzYgqH4VP6s6XMdkU50BeknZqtRq1QJ9Wo4LdVTeCeCk4NbQYyxvkA0P5qEfx
        OiRb92394B0xvzwPkvyNJEKUHrQ3KVeix41A/ChD73phgWsnNCVx2JAA6FSNJEU8BQ5lDR
        nAnkKFCshoPAfjJtxjk3NLvRTYJb9/I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-osblvqpVM7GySJVFMm6kUA-1; Wed, 28 Jun 2023 04:03:53 -0400
X-MC-Unique: osblvqpVM7GySJVFMm6kUA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f9569b09a3so459992e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939432; x=1690531432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofwo3P8uKOaWvV1X+hYEb8hA8CV2BceFbJ10PxbVumI=;
        b=e0OvVjndkYVPGqGeDgDa+hNnmeVBqPQ7GfBsu0eqi2/qIcO78BWnbn0a+W6+ZvoFHZ
         1D3S8buFK70CLeXrAtia8JNt2H9dHCx8D3qUCgfiaaxGpad2X5zm8VByh3d1sl3V2cZt
         iJ9wJEsuuJd7EY7/tv/RYsa0SfqQ+u4fGs8vpEpJKTdyELwrs6gKx5kvQbyV/9HVk+r6
         tdq5k6wp1lUPUyXY1p+Mp1sGkRvLlKmeBYm2yt+nQ64BUKtSPY6xvO2C51imLoS/Xv6N
         nXO0M8oiU0QPM9XrrWZN8cAB25pfudrDWjJxajSptTjm3vymthw0MK5RPrWt9mEwtCOR
         Hr3g==
X-Gm-Message-State: AC+VfDw35YkDPsybpOToo/WJttF08qTK1DChmTN18QOFvJ2HxhAVsfS3
        uZ5mW8l/sk93NVTjnOPrjCAPF2fu7+ExHz+gN/oX78jOMPrIbm6eWBaRkC2KLsbSu8Z+hLLCWe9
        wKuojtVhNcnpY+NyujGAunEzyOvV2T2QJL0w3e9kS
X-Received: by 2002:a05:6512:2828:b0:4f8:75d5:e14f with SMTP id cf40-20020a056512282800b004f875d5e14fmr206447lfb.28.1687939432273;
        Wed, 28 Jun 2023 01:03:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+VHNhq6OsMLyItLK9e1q5NqGMrmykMJR0HIs4eAUBTfGZ9IUjxcd7L2s5r2cSDn4Ra3WnvvHrOmw346uihVA=
X-Received: by 2002:a05:6512:2828:b0:4f8:75d5:e14f with SMTP id
 cf40-20020a056512282800b004f875d5e14fmr206443lfb.28.1687939431925; Wed, 28
 Jun 2023 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230628065919.54042-1-lulu@redhat.com> <20230628065919.54042-2-lulu@redhat.com>
In-Reply-To: <20230628065919.54042-2-lulu@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 28 Jun 2023 16:03:40 +0800
Message-ID: <CACGkMEvTyxvEkdMbYqZG3T4ZGm2G36hYqPidbTNzLB=bUgSr0A@mail.gmail.com>
Subject: Re: [RFC 1/4] vduse: Add the struct to save the vq reconnect info
To:     Cindy Lu <lulu@redhat.com>
Cc:     mst@redhat.com, maxime.coquelin@redhat.com,
        xieyongji@bytedance.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 2:59=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> From: Your Name <you@example.com>

It looks to me your git is not properly configured.

>
> this struct is to save the reconnect info struct, in this
> struct saved the page info that alloc to save the
> reconnect info
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 26b7e29cb900..f845dc46b1db 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -72,6 +72,12 @@ struct vduse_umem {
>         struct page **pages;
>         struct mm_struct *mm;
>  };
> +struct vdpa_reconnect_info {
> +       u32 index;
> +       phys_addr_t addr;
> +       unsigned long vaddr;
> +       phys_addr_t size;
> +};

Please add comments to explain each field. And I think this should be
a part of uAPI?

Thanks

>
>  struct vduse_dev {
>         struct vduse_vdpa *vdev;
> @@ -106,6 +112,7 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       struct vdpa_reconnect_info reconnect_info[64];
>  };
>
>  struct vduse_dev_msg {
> --
> 2.34.3
>

