Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA85623E67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKJJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKJJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36C682AE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668071670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xcao/PqbCDd3mW4vvxXtcV3kVRYEc6SH+zTFTbxv0YQ=;
        b=Zi1EYc3/GAIALG6zuBSCTkpq0rPJBARTWUCoxibiVTwJIE93jEe8NdjsdO3UCeNPQocWyf
        jOFDYlox3IUjJBDkvpZmYnpLk3XON7+iq0PPfoESiwpMm6KNPUasuG9yJfJ6GOy/G6El7P
        H8fCkNSazXItZdMK9T0L8i3JiEVjpD4=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-209-GpG3E-IqOAmRLLiZJa6XEw-1; Thu, 10 Nov 2022 04:14:26 -0500
X-MC-Unique: GpG3E-IqOAmRLLiZJa6XEw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-13b88262940so756678fac.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xcao/PqbCDd3mW4vvxXtcV3kVRYEc6SH+zTFTbxv0YQ=;
        b=V2iRGL+E0VvQ4Y8LGWRf/4b9xgg3t/qa8JHWbcFNTsnlB9D6nyMJ7iuOnbyDwKkquc
         Jz03uwdaXKd9zIr6IsyaVepJgv6TWXTfxXAaY1CJJthIyYlDH3zjK/o0mgYegOg++KYk
         vt/5nSc/7vED5ZN37jLgrCWlk1w6Zvc9keAf5rex+6iRZmIRrclpmrjnjHuLr70LBZjJ
         7ym/jGtc7reVuPA01rHm6Hmr9FYyeXL6CdeThvyBzu8Ucynybdtce1o5TGm1YGJFYkbv
         kXa+KO+3s/VP2+TbWOIADRuCFr/R+w2Q3xQGdxyqCm1QdwKrCyWwuPsmjD8GK/ki1lVL
         NuzA==
X-Gm-Message-State: ACrzQf1uPkGsA3/wql3RVuUbX+aYKVP1mP7TAYs2WCgb9sEOvfuCQXSe
        XyUkDkJucJlkkRBkoYm5320lgi65Szo2ImvJ4TfB+Op1vMyes0QmVSenuiaxQS0qa1JM1CP/LWI
        9Z0QHSCaBJ/LuQ2CN+KwbMwvapjs3+Ujgd6WHu6uT
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id k21-20020a056870959500b0013207b329acmr1260434oao.35.1668071664157;
        Thu, 10 Nov 2022 01:14:24 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7yhstRl6FSx3BzstYBqH9xt9jlKlqXg+p6H0IkT5AEZO+FdX25kmAF9Vd/tew9SdATkdsvQ79C+yUJ/ecZFhU=
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr1260423oao.35.1668071663899; Thu, 10
 Nov 2022 01:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20221110082348.4105476-1-ruanjinjie@huawei.com>
In-Reply-To: <20221110082348.4105476-1-ruanjinjie@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 10 Nov 2022 17:14:12 +0800
Message-ID: <CACGkMEvMuBge8LnQbdQHS86RVx8CkwSyMjR4md7Qs0uranTPuA@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa_sim: fix possible memory leak in
 vdpasim_net_init() and vdpasim_blk_init()
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

On Thu, Nov 10, 2022 at 4:27 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> Inject fault while probing module, if device_register() fails in
> vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
> not decreased to 0, the name allocated in dev_set_name() is leaked.
> Fix this by calling put_device(), so that name can be freed in
> callback function kobject_cleanup().
>
> (vdpa_sim_net)
> unreferenced object 0xffff88807eebc370 (size 16):
>   comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
>   hex dump (first 16 bytes):
>     76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>     [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>     [<ffffffffa0270013>] 0xffffffffa0270013
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> (vdpa_sim_blk)
> unreferenced object 0xffff8881070c1250 (size 16):
>   comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
>   hex dump (first 16 bytes):
>     76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>     [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>     [<ffffffffa0220013>] 0xffffffffa0220013
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v3:
> - add fix tag
> v2:
> - add fault inject message
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

