Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F0643D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiLFGuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLFGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B6DF00A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670309383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QRyJRGQed93e2oV6hVf2UMdunRy1tEcmm8rpx7XzZU=;
        b=h/FLbc2poouiooOg8AXxuEKhnPuXgShDKH6+lbNdZ3gTddiLXtpQAKISlrarEHwCxrnHuy
        h/YIy41FDSEIXYBOoBqi29548Jfbuc3rdtw5mXH+IZ/wiJAL4iP6tCg8qwJJxlVeHaXxCh
        23wF6lq6DYgkAPoLqY/gJGw1ulmYtBs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-IwnoR8msPvCqKe9JehyCFg-1; Tue, 06 Dec 2022 01:49:42 -0500
X-MC-Unique: IwnoR8msPvCqKe9JehyCFg-1
Received: by mail-oo1-f69.google.com with SMTP id x6-20020a4a2a46000000b0049ca27b1507so5270767oox.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QRyJRGQed93e2oV6hVf2UMdunRy1tEcmm8rpx7XzZU=;
        b=S5m+5/5oRWUzPgq8cmRiLjKuSJPWkyanBkxzfvRI/Lz7klT7wpgZgbVfjoS8bcKxCI
         m0r6s+H8ubQeenNPE36ExbO4ZXVZYJ1mgLTLljagpQPQUoFSQYGdqE7sCpjVcrVColP3
         XKExyVfZNz5PiMVGr1lGX5u7EQUEpmK1/rG/W2YyyFOLTn4YRVQxFuiNO1xqDny64fpz
         LurmlkvEP/63p8IPH9OTDfpfsf7tBfhzd2VuWRnC6FxT7zYOgVIpbtLSwQEcP9z6IE37
         sDY0UtyGB5QSSrShg81MHy8ICSdZiy5A83sN9dBtty7DGyDM+2Shc8BfWiFe1Z0LAn7B
         QKMw==
X-Gm-Message-State: ANoB5plMhO+tpdLU4yEtpePjBfUxNdA+5Qgh3GglxHGNRYEkDsviF5MR
        14mpnVdvW+ajRqRZe+HEXleDGzx4giPET85q4rqgeQ9T2E+OPOR5+nFL5mZYeJhg/MXGR/qnHB3
        v4djVt3aJEu+B3y5GuS1EHsD4SeXgivPNKT4xcons
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id a18-20020aca1a12000000b0035c303dfe37mr4109218oia.35.1670309381039;
        Mon, 05 Dec 2022 22:49:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7urHFr1rQgu43Jv9t4mhvIUwJQg2Mtgyn1pJiXbECS3dwGfV2OghH/gQ+LHnS49/OMVb20eZKwEEwoRHHncto=
X-Received: by 2002:aca:1a12:0:b0:35c:303d:fe37 with SMTP id
 a18-20020aca1a12000000b0035c303dfe37mr4109200oia.35.1670309380861; Mon, 05
 Dec 2022 22:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20221206021321.2400-1-longpeng2@huawei.com>
In-Reply-To: <20221206021321.2400-1-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 14:49:29 +0800
Message-ID: <CACGkMEtRw6Zk7BMNJOUPNsWquGof9vLiHRX8FovzpnE48unhXw@mail.gmail.com>
Subject: Re: [PATCH v2] vp_vdpa: harden the logic of set status
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        eperezma@redhat.com, cohuck@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
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

On Tue, Dec 6, 2022 at 10:13 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>    trigger a warning in that case.
>
> 2. The driver MUST wait for a read of device_status to return 0 before
>    reinitializing the device. But we also don't want to keep us in an
>    infinite loop forever, so wait for 5s if we try to reset the device.
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v1->v2:
>   - use WARN_ON instead of BUG_ON. [Stefano]
>   - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>   - use usleep_range instead of msleep (checkpatch). [Longpeng]
>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 13701c2a1963..a2d3b13ac646 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -214,6 +214,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>         u8 s = vp_vdpa_get_status(vdpa);
>
> +       /* We should never be setting status to 0. */
> +       WARN_ON(status == 0);
> +
>         if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>             !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>                 vp_vdpa_request_irq(vp_vdpa);
> @@ -222,14 +225,33 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         vp_modern_set_status(mdev, status);
>  }
>
> +#define VP_VDPA_RESET_TMOUT_MS 5000 /* 5s */
> +
>  static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>         struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>         u8 s = vp_vdpa_get_status(vdpa);
> +       unsigned long timeout;
>
>         vp_modern_set_status(mdev, 0);
>
> +       /*
> +        * As the virtio v1.1 spec (4.1.4.3.2) says: After writing 0 to
> +        * device_status, the driver MUST wait for a read of device_status
> +        * to return 0 before reinitializing the device.
> +        * To avoid keep us here forever, we only wait for 5 seconds.

s/keep/keeping/

> +        */
> +       timeout = jiffies + msecs_to_jiffies(VP_VDPA_RESET_TMOUT_MS);
> +       while (vp_modern_get_status(mdev)) {
> +               usleep_range(1000, 1500);
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(&mdev->pci_dev->dev,
> +                               "vp_vdpa: fail to reset device\n");
> +                       return -ETIMEDOUT;
> +               }

Any chance to use readx_poll_timeout() here?

Thanks

> +       }
> +
>         if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>                 vp_vdpa_free_irq(vp_vdpa);
>
> --
> 2.23.0
>

