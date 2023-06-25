Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E073CED3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFYHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFYHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE24BF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687676979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbYPIjkR3XyYE7RueUh8/3QvrSdR3D1Go2rsedUr3Z4=;
        b=UWvrf0yXKSbWq+CydkcTEH1C+PyN5GIir5hj+XowQCKBb5rDLI4OyI190jIdmj5WPoS9Sc
        jdSCe+FZ7nj/mZptFgF9+mIR8ehwwGg9Pk5KMHHumOQfmxQfxxy25I2GJYb4m5pNJm69or
        C/fbcvGrsJu1L+6yH3eoFVNgUcDaESQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-TEu16A6mNLetLYGi4eLJAg-1; Sun, 25 Jun 2023 03:09:38 -0400
X-MC-Unique: TEu16A6mNLetLYGi4eLJAg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edc5526c5fso1705873e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 00:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687676976; x=1690268976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbYPIjkR3XyYE7RueUh8/3QvrSdR3D1Go2rsedUr3Z4=;
        b=k7AM1987sVAcy96h4EE5rqMolFYglp3uMrsYTSa2RZ0O41bPnKpl976SNiD8Y2ZZ1e
         hEzkTPUVoqOlbMMKi1I0SCLbvVbEC2Hy1OOv9aSomaaXOJ9CJGzFZD/SMmUaCkOlJ9wg
         uInbheW2gjnY9qlgOpcFIziP/b55NgGYV3QEMEL53Pm7E7JPIxM0fYHc1yDsG9AwkBNO
         j+CFm72i4EvgrQKwbE+wHmGOAuFCmmSYBi2L4lm0Df0tg0f2rSwCzHny0lb1x44hfH6o
         /shmJ7KGT9o/UMklZbltvF/QcA1ehVnOdUiCE0x4QfLSmSsqAh2ft+jj/xe9kZGmTTUB
         tm2Q==
X-Gm-Message-State: AC+VfDxSbyIuqxlLk4HzjIjwTIAhgOWEIF0peRxtoveCEiGRoPC2n90E
        VEY9/PJ9zXljMnvmEFDHkhDUXFu2oJmKz+Lj7Qe7skNEI3mCXY93fsO5Ecc0o24pW+GVvEDup2S
        fk7FkzpeoMke9YnzABJTA1Td7qHZW7ApH6xbumIe5
X-Received: by 2002:a19:8c14:0:b0:4f8:7333:d1fd with SMTP id o20-20020a198c14000000b004f87333d1fdmr11221947lfd.34.1687676976584;
        Sun, 25 Jun 2023 00:09:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4iCpsy8J97MsvZhIh4Vr0xVedBNb3evsSFHyVeolxdYqrf2lfu5rzZT1HgQUgv/7X0z5JP9Aoj9/QtPPgYvzM=
X-Received: by 2002:a19:8c14:0:b0:4f8:7333:d1fd with SMTP id
 o20-20020a198c14000000b004f87333d1fdmr11221945lfd.34.1687676976263; Sun, 25
 Jun 2023 00:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622204851.318125-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230622204851.318125-1-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 25 Jun 2023 15:09:25 +0800
Message-ID: <CACGkMEuEHroKkBa4ccRKAyPR6E1-5AtjjABXicAOuyJtkYO6sw@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: fix NULL pointer dereference
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, gregkh@linuxfoundation.org,
        sheng.zhao@bytedance.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 4:49=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> vduse_vdpa_set_vq_affinity callback can be called
> with NULL value as cpu_mask when deleting the vduse
> device.
>
> This patch resets virtqueue's IRQ affinity mask value
> to set all CPUs instead of dereferencing NULL cpu_mask.
>
> [ 4760.952149] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [ 4760.959110] #PF: supervisor read access in kernel mode
> [ 4760.964247] #PF: error_code(0x0000) - not-present page
> [ 4760.969385] PGD 0 P4D 0
> [ 4760.971927] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 4760.976112] CPU: 13 PID: 2346 Comm: vdpa Not tainted 6.4.0-rc6+ #4
> [ 4760.982291] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 2.8.1=
 06/26/2020
> [ 4760.989769] RIP: 0010:memcpy_orig+0xc5/0x130
> [ 4760.994049] Code: 16 f8 4c 89 07 4c 89 4f 08 4c 89 54 17 f0 4c 89 5c 1=
7 f8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 fa 08 72 1b <=
4c> 8b 06 4c 8b 4c 16 f8 4c 89 07 4c 89 4c 17 f8 c3 cc cc cc cc 66
> [ 4761.012793] RSP: 0018:ffffb1d565abb830 EFLAGS: 00010246
> [ 4761.018020] RAX: ffff9f4bf6b27898 RBX: ffff9f4be23969c0 RCX: ffff9f4bc=
adf6400
> [ 4761.025152] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff9f4bf=
6b27898
> [ 4761.032286] RBP: 0000000000000000 R08: 0000000000000008 R09: 000000000=
0000000
> [ 4761.039416] R10: 0000000000000000 R11: 0000000000000600 R12: 000000000=
0000000
> [ 4761.046549] R13: 0000000000000000 R14: 0000000000000080 R15: ffffb1d56=
5abbb10
> [ 4761.053680] FS:  00007f64c2ec2740(0000) GS:ffff9f635f980000(0000) knlG=
S:0000000000000000
> [ 4761.061765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4761.067513] CR2: 0000000000000000 CR3: 0000001875270006 CR4: 000000000=
07706e0
> [ 4761.074645] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 4761.081775] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 4761.088909] PKRU: 55555554
> [ 4761.091620] Call Trace:
> [ 4761.094074]  <TASK>
> [ 4761.096180]  ? __die+0x1f/0x70
> [ 4761.099238]  ? page_fault_oops+0x171/0x4f0
> [ 4761.103340]  ? exc_page_fault+0x7b/0x180
> [ 4761.107265]  ? asm_exc_page_fault+0x22/0x30
> [ 4761.111460]  ? memcpy_orig+0xc5/0x130
> [ 4761.115126]  vduse_vdpa_set_vq_affinity+0x3e/0x50 [vduse]
> [ 4761.120533]  virtnet_clean_affinity.part.0+0x3d/0x90 [virtio_net]
> [ 4761.126635]  remove_vq_common+0x1a4/0x250 [virtio_net]
> [ 4761.131781]  virtnet_remove+0x5d/0x70 [virtio_net]
> [ 4761.136580]  virtio_dev_remove+0x3a/0x90
> [ 4761.140509]  device_release_driver_internal+0x19b/0x200
> [ 4761.145742]  bus_remove_device+0xc2/0x130
> [ 4761.149755]  device_del+0x158/0x3e0
> [ 4761.153245]  ? kernfs_find_ns+0x35/0xc0
> [ 4761.157086]  device_unregister+0x13/0x60
> [ 4761.161010]  unregister_virtio_device+0x11/0x20
> [ 4761.165543]  device_release_driver_internal+0x19b/0x200
> [ 4761.170770]  bus_remove_device+0xc2/0x130
> [ 4761.174782]  device_del+0x158/0x3e0
> [ 4761.178276]  ? __pfx_vdpa_name_match+0x10/0x10 [vdpa]
> [ 4761.183336]  device_unregister+0x13/0x60
> [ 4761.187260]  vdpa_nl_cmd_dev_del_set_doit+0x63/0xe0 [vdpa]
>
> Fixes: 28f6288eb63d ("vduse: Support set_vq_affinity callback")
> Cc: xieyongji@bytedance.com
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 5f5c21674fdc..0d84e6a9c3cc 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -726,7 +726,11 @@ static int vduse_vdpa_set_vq_affinity(struct vdpa_de=
vice *vdpa, u16 idx,
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>
> -       cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
> +       if (cpu_mask)
> +               cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
> +       else
> +               cpumask_setall(&dev->vqs[idx]->irq_affinity);
> +
>         return 0;
>  }
>
> --
> 2.41.0
>

