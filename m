Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0896F9E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjEHEEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEHEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2546A8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683518639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cjPs9stpL32DcqNj5bKjn9GpBpdTZMFDdDnlNEkwniM=;
        b=PQAbHiyZvGjJURQVJ2p12JQsBbYSJGxu5Jw/43HKRsjtvPhzNqbQSUHnDiGdTVqB4wEE2O
        tME8Cy95IiUcp+vMy9IucaTcxeygCWCUGAVs6Kdr9c83r4QE31hyz/yz4xWugNC7oDPtzb
        pWuuou0cKYqYFU9+9IdOPPI3CUBBfdo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-z2LdOB7aNce4fyLwHU4N6A-1; Mon, 08 May 2023 00:03:57 -0400
X-MC-Unique: z2LdOB7aNce4fyLwHU4N6A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f002e0e56cso2073390e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 21:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683518636; x=1686110636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjPs9stpL32DcqNj5bKjn9GpBpdTZMFDdDnlNEkwniM=;
        b=CIRY6YvllQKRikanIS4+eCr2NdWXibGt6SnOh2OgsSbNOt6Ir/KYvxnMxi8DqHKy6L
         77pTRGu/PL0ltlq6VgB58RX4CDLEw7entwjiumznG6YJ2OwR7izsk9639cd1JCiHHQrM
         /anXkDAHhFNpytkU607WP1AK4Czv07iVwhEFbA3XHruyJqPPgSIB3sH0S+o3Vywx/OzW
         637JhXppjo3fjYC82c6Pm+zkxpkCo91OfZ+zecYr4w4kPu1ym/L0H8H6fdwQlgWsFiYI
         AzXmVgXZyAtUP7OFUISMkDCm+nFy3gCOUcinjUL37Wv1yLNaXBMzkCZMfIiuKhNVupjC
         eFLA==
X-Gm-Message-State: AC+VfDxIKOMqSXUAy8jnQVbddYPoQObmRqNOOVrOyaLGNTn1DCiDcCA7
        5/iCvGoXxBcwXAexNl0O0GQuz2gZ44JiRNZOZbXOmetVXrNAvyLU3Z1NkCh22kQzeSSNe/nAXPy
        mobEDlkEsRHuqUuxoqiId8uradmvznbLAqr5ydwQ7
X-Received: by 2002:ac2:5d42:0:b0:4f0:1a32:d51f with SMTP id w2-20020ac25d42000000b004f01a32d51fmr2130080lfd.23.1683518636457;
        Sun, 07 May 2023 21:03:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qV2KFVI/GVAa9K7BHzf5fBIl+dJd4cI1tXXN94p9wvE+RjD75G6WDEDrhlh3J58C1wRSGJhuSPvsX2+k1sEs=
X-Received: by 2002:ac2:5d42:0:b0:4f0:1a32:d51f with SMTP id
 w2-20020ac25d42000000b004f01a32d51fmr2130074lfd.23.1683518636126; Sun, 07 May
 2023 21:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230427104428.862643-1-mie@igel.co.jp> <20230427104428.862643-4-mie@igel.co.jp>
In-Reply-To: <20230427104428.862643-4-mie@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 8 May 2023 12:03:44 +0800
Message-ID: <CACGkMEsjH8fA2r=0CacK8WK_sUTAcTK7SQ_VwkJpa1rSgDP0dg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] PCI: endpoint: Add EP function driver to
 provide virtio-console functionality
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 6:44=E2=80=AFPM Shunsuke Mie <mie@igel.co.jp> wrote=
:
>
> Add a new PCIe endpoint function driver that works as a pci virtio-consol=
e
> device. The console connect to endpoint side console. It enables to
> communicate PCIe host and endpoint.
>
> Architecture is following:
>
>  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90         =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
>  =E2=94=82virtioe     =E2=94=82         =E2=94=82                      =
=E2=94=82virtio      =E2=94=82
>  =E2=94=82console drv =E2=94=82         =E2=94=9C=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=82console drv =E2=
=94=82
>  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=82(vi=
rtio console=E2=94=82      =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
>  =E2=94=82 virtio bus =E2=94=82         =E2=94=82 device)       =E2=94=82=
=E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82 virtio bus =
=E2=94=82
>  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4         =E2=94=9C---=
------------=E2=94=A4      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
>  =E2=94=82            =E2=94=82         =E2=94=82 pci ep virtio =E2=94=82=
                   =E2=94=82
>  =E2=94=82  pci bus   =E2=94=82         =E2=94=82  console drv  =E2=94=82=
                   =E2=94=82
>  =E2=94=82            =E2=94=82  pcie   =E2=94=9C=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4                   =E2=94=82
>  =E2=94=82            =E2=94=82 =E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=BA =E2=94=82  pci ep Bus   =E2=94=82                 =
  =E2=94=82
>  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98
>    PCIe Root              PCIe Endpoint
>

I think it might only works for peer devices like:

net, console or vsock.

So there're many choices here, I'd like to know what's the reason for
you to implement a mediation.

An alternative is to implement a dedicated net, console and vsock
driver for vringh (CAIF somehow works like this). This would have
better performance.



> This driver has two roles. The first is as a PCIe endpoint virtio console
> function, which is implemented using the PCIe endpoint framework and PCIe
> EP virtio helpers. The second is as a virtual virtio console device
> connected to the virtio bus on PCIe endpoint Linux.
>
> Communication between the two is achieved by copying the virtqueue data
> between PCIe root and endpoint, respectively.
>
> This is a simple implementation and does not include features of
> virtio-console such as MULTIPORT, EMERG_WRITE, etc. As a result, each
> virtio console driver only displays /dev/hvc0.
>
> As an example of usage, by setting getty to /dev/hvc0, it is possible to
> login to another host.
>
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
> Changes from v2:
> - Change to use copy functions between kiovs of pci-epf-virtio.
>
>  drivers/pci/endpoint/functions/Kconfig        |  12 +
>  drivers/pci/endpoint/functions/Makefile       |   1 +
>  drivers/pci/endpoint/functions/pci-epf-vcon.c | 596 ++++++++++++++++++
>  3 files changed, 609 insertions(+)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-vcon.c
>
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoin=
t/functions/Kconfig
> index fa1a6a569a8f..9ce2698b67e1 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -44,3 +44,15 @@ config PCI_EPF_VIRTIO
>         select VHOST_RING_IOMEM
>         help
>           Helpers to implement PCI virtio Endpoint function
> +
> +config PCI_EPF_VCON
> +       tristate "PCI Endpoint virito-console driver"
> +       depends on PCI_ENDPOINT
> +       select VHOST_RING
> +       select PCI_EPF_VIRTIO
> +       help
> +         PCIe Endpoint virtio-console function implementatino. This modu=
le
> +         enables to show the virtio-console as pci device to PCIe host s=
ide, and
> +         another virtual virtio-console device registers to endpoint sys=
tem.
> +         Those devices are connected virtually and can communicate each =
other.
> +
> diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoi=
nt/functions/Makefile
> index a96f127ce900..b4056689ce33 100644
> --- a/drivers/pci/endpoint/functions/Makefile
> +++ b/drivers/pci/endpoint/functions/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_PCI_EPF_TEST)              +=3D pci-epf-test=
.o
>  obj-$(CONFIG_PCI_EPF_NTB)              +=3D pci-epf-ntb.o
>  obj-$(CONFIG_PCI_EPF_VNTB)             +=3D pci-epf-vntb.o
>  obj-$(CONFIG_PCI_EPF_VIRTIO)           +=3D pci-epf-virtio.o
> +obj-$(CONFIG_PCI_EPF_VCON)             +=3D pci-epf-vcon.o
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vcon.c b/drivers/pci/=
endpoint/functions/pci-epf-vcon.c
> new file mode 100644
> index 000000000000..31f4247cd10f
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-vcon.c
> @@ -0,0 +1,596 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Endpoint function driver to impliment virtio-console device
> + * functionality.
> + */
> +#include <linux/pci-epf.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_console.h>
> +#include <linux/virtio_ring.h>
> +
> +#include "pci-epf-virtio.h"
> +
> +static int virtio_queue_size =3D 0x100;
> +module_param(virtio_queue_size, int, 0444);
> +MODULE_PARM_DESC(virtio_queue_size, "A length of virtqueue");
> +
> +struct epf_vcon {
> +       /* To access virtqueues on remote host */
> +       struct epf_virtio evio;
> +       struct vringh_kiov *rdev_iovs;
> +
> +       /* To register a local virtio bus */
> +       struct virtio_device vdev;
> +
> +       /* To access virtqueus of local host driver */
> +       struct vringh *vdev_vrhs;
> +       struct vringh_kiov *vdev_iovs;
> +       struct virtqueue **vdev_vqs;
> +
> +       /* For transportation and notification */
> +       struct workqueue_struct *task_wq;
> +       struct work_struct raise_irq_work, rx_work, tx_work;
> +
> +       /* To retain virtio features. It is commonly used local and remot=
e. */
> +       u64 features;
> +
> +       /* To show a status whether this driver is ready and the remote i=
s connected */
> +       bool connected;
> +};
> +
> +enum {
> +       VCON_VIRTQUEUE_RX,
> +       VCON_VIRTQUEUE_TX,
> +       // Should be end of enum
> +       VCON_VIRTQUEUE_NUM
> +};

It would be better if we can split the console specific thing out,
then it allows us to do ethernet and vsock in the future.

Thanks

