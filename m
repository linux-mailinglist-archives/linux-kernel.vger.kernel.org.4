Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0A6611AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjAGUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjAGUtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:49:43 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5303E847;
        Sat,  7 Jan 2023 12:49:42 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id t7so3469463qvv.3;
        Sat, 07 Jan 2023 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWbA44Bf2vZY0/3H5jD+i5cHh/WsBY5ereQ2rQNmxw0=;
        b=JiZ/HqQVdc9k1RkpydVSZfSB9yHBE8kUolaxxhi/FGwqpiSXdWyoaKzh9QV/8jzIav
         nAsRCcB2kkejXGWFmb6+03kf6tdfCMCp46/mOyAteWfRZxz/GB23bZTi3b9ckOh1Vug/
         7mSYjOUWM2B9VN1F2V2n1Lu3Qmp5SRL4tDh9TJgxKeuWIJYk9OC4QdhAZmC21NRGPVgg
         0smqUsx1sfm/8TQ06rwqpNeeV6W+lUrVSntkWg5OehKMPxEjoA48nNct47iFT3WKnPVK
         bG0yKIQ1kODGCa+lmnI6catgw7zcsfCZxIh2CbHrfBAt12Te7lvLzCZrRoqNC0mHYnfb
         dOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWbA44Bf2vZY0/3H5jD+i5cHh/WsBY5ereQ2rQNmxw0=;
        b=5SY/eef3p5K0JIzrtgdDUSLp+UJaMITi43SL7tSkZZ5rpUYF83yKBxx/kNA+nA55ct
         wnJwKi1Qj3Zn9OalOB8B4MvbnBAYFcBZYI2PxxkOaTjaDJxDNEtAS9mvyq09Xz2nOUw0
         PfTdOyN3lB1tXIKKtRwWJpHMJDsLA+WxthpcDF9UUpGdtmMTurVcF2LIeThYb4TLDdW0
         TFI9Ze39FE0CWbcI8zgdEWystT77OW6G7zYdmfQOQsdA9MqUvx8tEIukiKP5MUiWFrXw
         qRPDnHE368ZnKFaNE/WDzPWf8wPyXkC/VnSe8BJAgXD+IDLPTP4I58/k9og45kq6ePKy
         xPew==
X-Gm-Message-State: AFqh2kol5QJZ82ascXmB94ZigbTqh74fHPVYNmDkXzF0HI1p6NvRuJzb
        Vbxy97SfX//UL/Vymb3laGxqhiTBPq3sR4E9phk=
X-Google-Smtp-Source: AMrXdXvHyNaPaM+nF0FYtAmWCAbCqii4k/sDGzoSEXwrk1BHJSXFkfacEglgcuzFXrpsznMkPO3oG/AwPE03qfOn8TU=
X-Received: by 2002:a05:6214:2e17:b0:4b1:a359:c204 with SMTP id
 mx23-20020a0562142e1700b004b1a359c204mr3821567qvb.64.1673124581234; Sat, 07
 Jan 2023 12:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y7i4Q3CAbiCzvGS/@spud>
In-Reply-To: <Y7i4Q3CAbiCzvGS/@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 7 Jan 2023 20:49:14 +0000
Message-ID: <CA+V-a8uEEDuN56roLKLiD-ryOH9khz1a5Wh=W+6WAsAYQVKNUw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Conor Dooley <conor@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jason M Bills <jason.m.bills@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the review.

On Sat, Jan 7, 2023 at 12:09 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 06:55:25PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > external non-caching masters, such as DMA controllers. The accesses
> > from IOCP are coherent with D-Caches and L2 Cache.
> >
> > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > SoC due to this reason IP blocks using DMA will fail.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtime.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >
> > More info about PMA (section 10.3):
> > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >
> > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > software. Firstly OpenSBI configures the memory region as
> > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > allocations happen from this region and synchronization callbacks are
> > implemented to synchronize when doing DMA transactions.
> >
> > Example PMA region passes as a DT node from OpenSBI:
> >     reserved-memory {
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> >         ranges;
> >
> >         pma_resv0@58000000 {
> >             compatible = "shared-dma-pool";
> >             reg = <0x0 0x58000000 0x0 0x08000000>;
> >             no-map;
> >             linux,dma-default;
> >         };
> >     };
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
> > new file mode 100644
> > index 000000000000..556e6875627c
> > --- /dev/null
> > +++ b/drivers/cache/ax45mp_cache.c
> > @@ -0,0 +1,279 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * non-coherent cache functions for Andes AX45MP
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corp.
> > + */
> > +
> > +#include <asm/dma-noncoherent.h>
> > +#include <linux/cacheflush.h>
> > +#include <linux/cacheinfo.h>
> > +#include <linux/dma-direction.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/sbi.h>
>
> You don't actually need this anymore, do you?
>
Agreed these can be dropped now.

> > +static int ax45mp_l2c_probe(struct platform_device *pdev)
> > +{
> > +     struct riscv_cache_ops ax45mp_cmo_ops;
> > +
> > +     /*
> > +      * riscv_cbom_block_size is set very much earlier so we can
> > +      * definitely rely on it and only if its being set we continue
> > +      * further in the probe path.
> > +      */
> > +     if (!riscv_cbom_block_size)
> > +             return 0;
>
> Return 0? That's because we may actually have the IOCP & do not want to
> install ops, right?
> If so, please add that to the comment.
>
OK, I will add that.

> > +
> > +     ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
> > +     if (!ax45mp_priv)
> > +             return -ENOMEM;
> > +
> > +     ax45mp_priv->l2c_base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(ax45mp_priv->l2c_base))
> > +             return PTR_ERR(ax45mp_priv->l2c_base);
> > +
> > +     ax45mp_get_l2_line_size(pdev);
> > +
> > +     memset(&ax45mp_cmo_ops, 0x0, sizeof(ax45mp_cmo_ops));
> > +     ax45mp_cmo_ops.riscv_dma_noncoherent_cmo_ops = &ax45mp_no_iocp_cmo;
>
> Yah, drop this dance and use a static struct foo_ops construct please.
>
Will do.

> With those two, I'm happy with this I guess..
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> > +     riscv_noncoherent_register_cache_ops(&ax45mp_cmo_ops);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id ax45mp_cache_ids[] = {
> > +     { .compatible = "andestech,ax45mp-cache" },
> > +     { /* sentinel */ }
> > +};
> > +
> > +static struct platform_driver ax45mp_l2c_driver = {
> > +     .driver = {
> > +             .name = "ax45mp-l2c",
> > +             .of_match_table = ax45mp_cache_ids,
> > +     },
> > +     .probe = ax45mp_l2c_probe,
> > +};
> > +
> > +static int __init ax45mp_cache_init(void)
> > +{
> > +     return platform_driver_register(&ax45mp_l2c_driver);
> > +}
> > +arch_initcall(ax45mp_cache_init);
> > +
> > +MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Andes AX45MP L2 cache driver");
> > +MODULE_LICENSE("GPL");
>
> BTW, I think these are surplus-to-requirements since this is never going
> to be built as a module.
>
Agreed, I will drop it.

> If you resurrect the directory level maintainers entry from my v5.1, you
> can also add:
Sure I'll add it in the next version..

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
... and also include your ACK.

Cheers,
Prabhakar
