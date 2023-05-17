Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7B705F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEQFY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEQFYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D613C25
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684301045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2TQmhlyr4qpfepuY+DlN4KamSzGRCNW1CGNN09KiW0=;
        b=esCEDrkv6XDvIWCerh+ijARKvqfGWdYfLpnH0WaU6gGbzZpwyEO7FZb9ATj7JdObYGxqsX
        Bi8DVsbM6Fy9BdaTcfIlXbUXxvnqHpgXVxc7u5r0AY31t/SGz6Wb2i0SifTlBPbyWiXnIL
        KJNQD9JIZBpZruy2G4DtvmeH0ZCRCK0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-388kzGULMry5tqUuDu0H7w-1; Wed, 17 May 2023 01:24:03 -0400
X-MC-Unique: 388kzGULMry5tqUuDu0H7w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f3907d04dcso252479e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 22:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301042; x=1686893042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2TQmhlyr4qpfepuY+DlN4KamSzGRCNW1CGNN09KiW0=;
        b=eD6lqLy4TKjgOSbC5uQJK9q0PFYL6OBSc4wUHvuPN7f2nTHYSMFzH2kpq9+OIC6W8v
         ZJXe/F7yj+SsHu+wL1uZx/kvnIem7kyNN+QT0bJmkbTclmhDGOTbJZeidQoKCzylI+WC
         6HzceVzEUgVvziIXbQt4sO5BA3S8+aqzbmE3RrqCe88TR/PSw8J0/HkONw5vEfBrvL3j
         qIZpi7fbWd8SN5s8XqPboFgmJD3ESvZia24cCLZSbQT83Cf5skwD2TAvNdhzTR3rGrhv
         M+VBz7+95Ux6niDKQezMI8PcPIDfYnvCtrfgxi4YjkWoUxH3DjPQ2O0msB5UyswAs+lg
         2Z6w==
X-Gm-Message-State: AC+VfDyORM65nFUd6qbi1an/hmqijWOLGK4SelCpCGlis1AQazikp3YM
        rhxE+wlcz8LVwoT2h1luD+BuXe2il1EGl6eeqc0u7Lj3mj5skIAMrTaXUmaVhEtcP6BFbCu+FWB
        uasA2N2IXj0x7CQXAW0yQUVuctAzNcLKy/iO/LYN/
X-Received: by 2002:ac2:598c:0:b0:4f3:83d6:f22c with SMTP id w12-20020ac2598c000000b004f383d6f22cmr2314502lfn.66.1684301042055;
        Tue, 16 May 2023 22:24:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cbD5EclJjMC9h5Bmo7GCWi9NvKPqma8Oxjx6jDgJ08ur23xMjHhPMa62dMTnl0xvbjx0fqKiMEfZSJJ6fsHM=
X-Received: by 2002:ac2:598c:0:b0:4f3:83d6:f22c with SMTP id
 w12-20020ac2598c000000b004f383d6f22cmr2314490lfn.66.1684301041754; Tue, 16
 May 2023 22:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516135446.16266-1-feliu@nvidia.com>
In-Reply-To: <20230516135446.16266-1-feliu@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 17 May 2023 13:23:50 +0800
Message-ID: <CACGkMEtitFX1v=fFYohLNz=xo3S7CM3Cdt09=C6xXz8kb1a4Cg@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pci: Optimize virtio_pci_device structure size
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 9:55=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
> Improve the size of the virtio_pci_device structure, which is commonly
> used to represent a virtio PCI device. A given virtio PCI device can
> either of legacy type or modern type, with the
> struct virtio_pci_legacy_device occupying 32 bytes and the
> struct virtio_pci_modern_device occupying 88 bytes. Make them a union,
> thereby save 32 bytes of memory as shown by the pahole tool. This
> improvement is particularly beneficial when dealing with numerous
> devices, as it helps conserve memory resources.
>
> Before the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         struct virtio_pci_legacy_device ldev;            /*   824    32 *=
/
>         /* --- cacheline 13 boundary (832 bytes) was 24 bytes ago --- */
>         struct virtio_pci_modern_device mdev;            /*   856    88 *=
/
>
>         /* XXX last struct has 4 bytes of padding */
> [...]
>         /* size: 1056, cachelines: 17, members: 19 */
> [...]
> };
>
> After the modification, pahole tool reported the following:
> struct virtio_pci_device {
> [...]
>         union {
>                 struct virtio_pci_legacy_device ldev;    /*   824    32 *=
/
>                 struct virtio_pci_modern_device mdev;    /*   824    88 *=
/
>         };                                               /*   824    88 *=
/
> [...]
>         /* size: 1024, cachelines: 16, members: 18 */
> [...]
> };
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_pci_common.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_p=
ci_common.h
> index 23112d84218f..4b773bd7c58c 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -45,9 +45,10 @@ struct virtio_pci_vq_info {
>  struct virtio_pci_device {
>         struct virtio_device vdev;
>         struct pci_dev *pci_dev;
> -       struct virtio_pci_legacy_device ldev;
> -       struct virtio_pci_modern_device mdev;
> -
> +       union {
> +               struct virtio_pci_legacy_device ldev;
> +               struct virtio_pci_modern_device mdev;
> +       };
>         bool is_legacy;
>
>         /* Where to read and clear interrupt */
> --
> 2.37.1 (Apple Git-137.1)
>

