Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F461EC4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKGHm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiKGHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D273E74
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667806916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vzzqd2jio4AZxTd7QQW36f88T5gwDOYUqqpTsVWYFf0=;
        b=HrCDpjAM3uu5/eO9OUQprJffXz09I61gaLgg0Zr2XEuwE1j81iOczfioQmczfQYa1yok0h
        SHqooVqK57vEiuR84KzlLqLYMc5b61j2E4usMbZ/1kexvxQ0Geb3gUfscSWqk6EdDCCLfJ
        7qp8lEEyWBaL4e4H51xNBfvO1v+A1Ag=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-H_ZOWJICP8OO4Tb_4muaTw-1; Mon, 07 Nov 2022 02:41:54 -0500
X-MC-Unique: H_ZOWJICP8OO4Tb_4muaTw-1
Received: by mail-oo1-f71.google.com with SMTP id g28-20020a4a251c000000b0049c515643ecso2568732ooa.14
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vzzqd2jio4AZxTd7QQW36f88T5gwDOYUqqpTsVWYFf0=;
        b=RbgJ0mP+/ZxADvQkaKCziOqZZlCoLSUE+rI/g49byAbjOj3IzEW7F4vfSRiIW/08XX
         FkuQX4Goym8yVYUoMSFdyk/kcmcmkSyxpwmi+3ygmndjpXsKsAk7NbA//fkaFiGCeNrL
         ECf1Jdn4eneJPTokRdWnscKphnPNCUwK6eBLtVUmryILH2bxGxF4d20GHSPHsed/coxN
         BO1wc4JhptqO98XZQ6fuuZpj37BettH7v4mVjq2dL8uVlceboXLp3BTDqx9UQkBAcAcg
         DfzShpaoE9ujyA6wA87iPly1U5rqsd6BX0qmW8xTgIuYIAfQ//za9WYv1NT85OYUnUun
         WiAQ==
X-Gm-Message-State: ACrzQf3IEmDJ0fbgvKWUEw8tAsAto886vwkVXBI5V1UIIV+QRF5N1gHA
        nT/z9NPhRn8Uy+jn/yllN5D2bAAwB/RIfenCnREoKxHhiwAbb4c/eo0iJGYtcfJJvdC1Za1T7Ra
        DGuzd9IIezQzQzhADjiXud9RJem8oDdfKiCZT+PeL
X-Received: by 2002:a05:6830:16c5:b0:66c:6a63:dd4c with SMTP id l5-20020a05683016c500b0066c6a63dd4cmr16042108otr.201.1667806914212;
        Sun, 06 Nov 2022 23:41:54 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7oOAV+uc9t7s8MBz7qTTD7zfFUiw34yn3qYUKtzP5s1gzgwMA5EfGWNJZz9lHNABJ/rakf5LO5N9ismitfWQ8=
X-Received: by 2002:a05:6830:16c5:b0:66c:6a63:dd4c with SMTP id
 l5-20020a05683016c500b0066c6a63dd4cmr16042098otr.201.1667806913996; Sun, 06
 Nov 2022 23:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20221104083423.2090463-1-ruanjinjie@huawei.com>
In-Reply-To: <20221104083423.2090463-1-ruanjinjie@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 7 Nov 2022 15:41:42 +0800
Message-ID: <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix possible memory leak in vdpasim_net_init()
 and vdpasim_blk_init()
To:     ruanjinjie <ruanjinjie@huawei.com>
Cc:     mst@redhat.com, sgarzare@redhat.com, eperezma@redhat.com,
        gautam.dawar@xilinx.com, elic@nvidia.com,
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

On Fri, Nov 4, 2022 at 4:41 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> If device_register() returns error in vdpasim_net_init() or
> vdpasim_blk_init(), name of kobject which is allocated in dev_set_name()
> called in device_add() is leaked.
>
> As comment of device_add() says, it should call put_device() to drop
> the reference count that was set in device_initialize() when it fails,
> so the name can be freed in kobject_cleanup().
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Should we have a fixes tag and cc stable?

Thanks

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index c6db1a1baf76..f745926237a8 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -427,8 +427,10 @@ static int __init vdpasim_blk_init(void)
>         int ret;
>
>         ret = device_register(&vdpasim_blk_mgmtdev);
> -       if (ret)
> +       if (ret) {
> +               put_device(&vdpasim_blk_mgmtdev);
>                 return ret;
> +       }
>
>         ret = vdpa_mgmtdev_register(&mgmt_dev);
>         if (ret)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c3cb225ea469..11f5a121df24 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -305,8 +305,10 @@ static int __init vdpasim_net_init(void)
>         int ret;
>
>         ret = device_register(&vdpasim_net_mgmtdev);
> -       if (ret)
> +       if (ret) {
> +               put_device(&vdpasim_net_mgmtdev);
>                 return ret;
> +       }
>
>         ret = vdpa_mgmtdev_register(&mgmt_dev);
>         if (ret)
> --
> 2.25.1
>

