Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCBA6469C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiLHHe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:34:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDB22E9F1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670484808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKpO4mivO2W1yNm3A0HXsqmTgKdI5x9eAmnflBCtN/Q=;
        b=ggvxuL+DktZeS9bI3V7aFDc9OuIIcY8FFGIG6JsaE4tGC7mjVRyU+YOHB9hHVBRk5DRsVm
        KZsM8yTp34x19hDTEV+D0Bxel+G/+rKKFM2t10yiwlyM8xtpYnU0yc5aRyzA6kopTxJtW4
        1wV28fbMQmJ0Uwd8hi+WgfXETnU7wRc=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-njK18LrGNCG-I1AX5FN_gQ-1; Thu, 08 Dec 2022 02:33:26 -0500
X-MC-Unique: njK18LrGNCG-I1AX5FN_gQ-1
Received: by mail-oo1-f72.google.com with SMTP id c8-20020a4a87c8000000b0049f149a83fdso169936ooi.19
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 23:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKpO4mivO2W1yNm3A0HXsqmTgKdI5x9eAmnflBCtN/Q=;
        b=xjiXtgzRto/mPBpiIairl1SXTVEuzxpo7ukUoTTfvOmaD1lr4tonFvFx0XoYDigbQM
         quOrj0MudnTS3+F+4x0xPg/S6T9k1+xS3rpoxprz7MjrW9xiKYLDLGJM6jnzSxz3nSn3
         NSr6qbOCxoM3Xfeq4mTBSNsd6BF5Esfi1Hjm/aGybyqtctM9pwbvPp4h5kwN4FmdLyhc
         ScsQmvHBjAGcmA2pvOprlJxUZBWNiUlst5+jOXBeMGx76gyk3f9F9yjaEgx+W5CTvoP5
         kX2Qa+717k0lOdoLI2hdoDRb0OvtY9b8uN93Z94Z4ziwE6o0LJt8oTx8PVv9mhjzeefm
         +Uig==
X-Gm-Message-State: ANoB5plBn6xsVxyDyarABv2M1OmL/LK0ABwcBljSO3FGtEhJgogDPG5B
        1eatsrAE8zr4jbc0drHylE+DutVs/aSymqUch4bn/kw+CwdR8YQrlw7ZX4DWHqiJguDRtd+gUwV
        zRr+Z1j80QE8DcCy5dNYHqWKUUj/bjfRWWE6L2E0k
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id 47-20020a9d0832000000b006705283dd3emr6224367oty.201.1670484804226;
        Wed, 07 Dec 2022 23:33:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Z/YaUgjQym50YJjJOHD3I4Z+BYdpVXLlv581GRTQvj0YH5cF06AcofePFl78CMoLz23eOJpLzJJuRD6RTv/0=
X-Received: by 2002:a9d:832:0:b0:670:5283:dd3e with SMTP id
 47-20020a9d0832000000b006705283dd3emr6224356oty.201.1670484804020; Wed, 07
 Dec 2022 23:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20221207120813.2837529-1-sunnanyong@huawei.com> <CACLfguXTQuYjt_ftPS=P-CUoMkiiE9K7=oXhQ4Up8p3g-OwXgw@mail.gmail.com>
In-Reply-To: <CACLfguXTQuYjt_ftPS=P-CUoMkiiE9K7=oXhQ4Up8p3g-OwXgw@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 8 Dec 2022 15:33:13 +0800
Message-ID: <CACGkMEtC5Ed+JKhuyRMuvW4eoHNidr3MFNjv2F3-R4R0brrnWA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/vp_vdpa: fix kfree a wrong pointer in vp_vdpa_remove
To:     Cindy Lu <lulu@redhat.com>
Cc:     Nanyong Sun <sunnanyong@huawei.com>, mst@redhat.com,
        gautam.dawar@xilinx.com, elic@nvidia.com, sgarzare@redhat.com,
        wangrong68@huawei.com, virtualization@lists.linux-foundation.org,
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

On Thu, Dec 8, 2022 at 10:05 AM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, 7 Dec 2022 at 19:23, Nanyong Sun <sunnanyong@huawei.com> wrote:
> >
> > From: Rong Wang <wangrong68@huawei.com>
> >
> > In vp_vdpa_remove(), the code kfree(&vp_vdpa_mgtdev->mgtdev.id_table) uses
> > a reference of pointer as the argument of kfree, which is the wrong pointer
> > and then may hit crash like this:
> >
> > Unable to handle kernel paging request at virtual address 00ffff003363e30c
> > Internal error: Oops: 96000004 [#1] SMP
> > Call trace:
> >  rb_next+0x20/0x5c
> >  ext4_readdir+0x494/0x5c4 [ext4]
> >  iterate_dir+0x168/0x1b4
> >  __se_sys_getdents64+0x68/0x170
> >  __arm64_sys_getdents64+0x24/0x30
> >  el0_svc_common.constprop.0+0x7c/0x1bc
> >  do_el0_svc+0x2c/0x94
> >  el0_svc+0x20/0x30
> >  el0_sync_handler+0xb0/0xb4
> >  el0_sync+0x160/0x180
> > Code: 54000220 f9400441 b4000161 aa0103e0 (f9400821)
> > SMP: stopping secondary CPUs
> > Starting crashdump kernel...
> >
> > Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> > Signed-off-by: Rong Wang <wangrong68@huawei.com>
> > Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index d448db0c4de3..8fe267ca3e76 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -647,7 +647,7 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
> >         mdev = vp_vdpa_mgtdev->mdev;
> >         vp_modern_remove(mdev);
> >         vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> > -       kfree(&vp_vdpa_mgtdev->mgtdev.id_table);
> > +       kfree(vp_vdpa_mgtdev->mgtdev.id_table);
> >         kfree(mdev);
> >         kfree(vp_vdpa_mgtdev);
> >  }
> > --
> > 2.25.1
> >
> Reviewed-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>

