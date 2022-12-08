Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A626466BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLHCGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLHCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22BD11A1A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670465142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jCBIQoMJEe+lif1CmpRIbDtF+s/K6nqadebdurMGVrQ=;
        b=BgVXP2lEpoXJIulk7s8TikjgFDIgGMGccU/1uym6x53SI9HM4LBW4NBRDeqlMw0kxzr/2C
        WwdpwLAsZu2xhWFisGtCfe1Ai558XF9G50j9Wfx/1505C2sUt9dtRRZxddI/7DHTYfFpsM
        ZS3vPnRmsxAFEDbjQ1eUtWN1pYslHdw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-sizExJ4ZM-eN9NhV51hbNw-1; Wed, 07 Dec 2022 21:05:41 -0500
X-MC-Unique: sizExJ4ZM-eN9NhV51hbNw-1
Received: by mail-ua1-f70.google.com with SMTP id b19-20020ab01413000000b00418fea11cc9so25122uae.18
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 18:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCBIQoMJEe+lif1CmpRIbDtF+s/K6nqadebdurMGVrQ=;
        b=T9Vf2VkFpjlLWgIRpNaRdU1qx8R+U1L2G/jsGbftJUxOF/dxa58WqxqFvGnmbQ+IP0
         VSPUF87pp8Cqh6MsRPVpSDxiJ6DqjH6oyuqYRNh5zPi5JkcYp/owNiEZYupIDn4Usu9s
         lQMHHSDUyUdYwVVbgIvxOJYl3hvumzYZpq1pzpfV4wJY2iNtZt3qM4smfQroiBfB2WIY
         38jsgsfmJF9YR5Tt19YSVNjOdPNfCICSO/RJECm/lEuEbaynkpKZzXvtpE7JcBIBPKd6
         Ki9cbfcQF7mLZDLbOPtEx2hsfU0deCUJUNarpUkLWjWHlPDsY0hOIToM1+McqAHvNOvw
         p4wA==
X-Gm-Message-State: ANoB5pluLYvo1fzm1IUm2UjvtpvKpOSKfZN1Rv2bDk11Kxb74tqNdVnx
        /L0IqrRM+L8HsGnynUd7BhaQMPpOjleHjX7HG4c+ekdDaCgVlhdEkI4dwtFi0N8XujfyOKvMwAp
        51J3kMHpoa1BlsdI0kEKrpqyOtCHXUV4+mKDxHab5
X-Received: by 2002:a05:6102:117c:b0:3b1:47f1:526b with SMTP id k28-20020a056102117c00b003b147f1526bmr8583246vsg.77.1670465140941;
        Wed, 07 Dec 2022 18:05:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5vdMPqdn2y9KkeD3NF600AElgGYToMJkSztxgj5yXRGjSCro385vVarFYkuU54Kz18kZZiLIegURajjPdO04o=
X-Received: by 2002:a05:6102:117c:b0:3b1:47f1:526b with SMTP id
 k28-20020a056102117c00b003b147f1526bmr8583236vsg.77.1670465140673; Wed, 07
 Dec 2022 18:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20221207120813.2837529-1-sunnanyong@huawei.com>
In-Reply-To: <20221207120813.2837529-1-sunnanyong@huawei.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Thu, 8 Dec 2022 10:05:03 +0800
Message-ID: <CACLfguXTQuYjt_ftPS=P-CUoMkiiE9K7=oXhQ4Up8p3g-OwXgw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     mst@redhat.com, jasowang@redhat.com, gautam.dawar@xilinx.com,
        elic@nvidia.com, sgarzare@redhat.com, wangrong68@huawei.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        wangkefeng.wang@huawei.com
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

On Wed, 7 Dec 2022 at 19:23, Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> From: Rong Wang <wangrong68@huawei.com>
>
> In vp_vdpa_remove(), the code kfree(&vp_vdpa_mgtdev->mgtdev.id_table) uses
> a reference of pointer as the argument of kfree, which is the wrong pointer
> and then may hit crash like this:
>
> Unable to handle kernel paging request at virtual address 00ffff003363e30c
> Internal error: Oops: 96000004 [#1] SMP
> Call trace:
>  rb_next+0x20/0x5c
>  ext4_readdir+0x494/0x5c4 [ext4]
>  iterate_dir+0x168/0x1b4
>  __se_sys_getdents64+0x68/0x170
>  __arm64_sys_getdents64+0x24/0x30
>  el0_svc_common.constprop.0+0x7c/0x1bc
>  do_el0_svc+0x2c/0x94
>  el0_svc+0x20/0x30
>  el0_sync_handler+0xb0/0xb4
>  el0_sync+0x160/0x180
> Code: 54000220 f9400441 b4000161 aa0103e0 (f9400821)
> SMP: stopping secondary CPUs
> Starting crashdump kernel...
>
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Signed-off-by: Rong Wang <wangrong68@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index d448db0c4de3..8fe267ca3e76 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -647,7 +647,7 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
>         mdev = vp_vdpa_mgtdev->mdev;
>         vp_modern_remove(mdev);
>         vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> -       kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
> +       kfree(vp_vdpa_mgtdev->mgtdev.id_table);
>         kfree(mdev);
>         kfree(vp_vdpa_mgtdev);
>  }
> --
> 2.25.1
>
Reviewed-by: Cindy Lu <lulu@redhat.com>

