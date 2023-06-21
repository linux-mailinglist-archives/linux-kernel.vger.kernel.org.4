Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF09D73808F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFUK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjFUK23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:28:29 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2F10D5;
        Wed, 21 Jun 2023 03:28:21 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-47186c609ddso1385092e0c.2;
        Wed, 21 Jun 2023 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343300; x=1689935300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abONhdXq2jNE7G62WBMGplwmL4EI1Nfvc3N698K+m40=;
        b=deOAJE4FiGOM04XZxt2hhcZTWNEGjHt2XvCbaKRL/ni0WQ0BHgxHTvI/6Or6ZARTEh
         fQYVKUBebokN5Oe9ahO7bjzmJFZbABl0g6ccX06NoWEfNxX+Yl8koKd35c/chhSykI//
         NcqjNwrwP2HrUu84xnH9rJ3kl8OCxuvcvXc1v2c66HDMiFh0KGWBp8OouCdW2BIzVbWx
         xoyqDlEiEipLVaBk2I8ppvS67JMyXPAQ1M0YabbqD6a6S8Nxk88Rp78lk7FSjV5mt63S
         b0J30MXUgJ2QZVPc8l87ZCgl2ACHJe8718s2VOdCzPIlz8OklstP8QCcJceeQhH4TgWo
         4gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343300; x=1689935300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abONhdXq2jNE7G62WBMGplwmL4EI1Nfvc3N698K+m40=;
        b=afHp2Iq46PXLEmVSU7zUYrpME/CqXoCibSmv4RAB0quRhk53vd5+rGUHarY6iFXhB/
         fhgOloqASx55Oxen2wbWHGhJ1e2ew4dH+Yo3yNPYY4j8fdGtmKusyyGTl6pCsWCpZ6AM
         RlwilySkeO7aOk6RnK01dD83R2ReY17z5DgBvLcwb85BkOoWEncQgB5oJ21fjjISM5Iv
         yw+ZQ+Y5tn0iOuCQOaW8USYFcTZMOJlP4grDEs85nXTVWLSpvxHmmc1CfFe6G/Zg1dBh
         gqCjMUTd0BKykXDXcNhngb1JzQsLVYOSoW6UgRTmYEKiIYKhwCwHrjycG9grZL1/aJWH
         pR1g==
X-Gm-Message-State: AC+VfDzecD/bga6G8xRND3vNx7KdsbA+DTEUR+A3qbA3iFithnIdH0wX
        MTCcdT2rXLL8bIZ188AeeIzrQ9gqkWHGC8Vq4Ws=
X-Google-Smtp-Source: ACHHUZ4VxduJfBicnNqe90BwdXnRttHeiNoGdPTayPjfE/+imiGxm62fS7+YRyFgy8RCNK7KPsV7ggh8lyHI0mTtJrw=
X-Received: by 2002:a1f:cd46:0:b0:471:b557:12a with SMTP id
 d67-20020a1fcd46000000b00471b557012amr3898807vkg.11.1687343300268; Wed, 21
 Jun 2023 03:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-9-victor.shih@genesyslogic.com.tw> <1730bd81-c101-c426-bffb-900b5bbe2d78@intel.com>
In-Reply-To: <1730bd81-c101-c426-bffb-900b5bbe2d78@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:28:08 +0800
Message-ID: <CAK00qKD5A12JxRj7OvKN=0O8r=YjMGi4g6E-a24DScmBzGmc2g@mail.gmail.com>
Subject: Re: [PATCH V7 08/23] mmc: sdhci: add UHS-II module and add a kernel configuration
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Apr 12, 2023 at 9:10=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This patch adds sdhci-uhs2.c as a module for UHS-II support.
> > This is a skelton for further development in this patch series.
> >
> > This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> > in the following commits to indicate UHS-II specific code in sdhci
> > controllers.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/Kconfig      |  9 +++++++
> >  drivers/mmc/host/Makefile     |  1 +
> >  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 56 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 4745fe217ade..06ab111eba3b 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
> >
> >         This is the case for the Nintendo Wii SDHCI.
> >
> > +config MMC_SDHCI_UHS2
> > +     tristate "UHS2 support on SDHCI controller"
> > +     depends on MMC_SDHCI
> > +     help
> > +       This option is selected by SDHCI controller drivers that want t=
o
> > +       support UHS2-capable devices.
> > +
> > +       If you have a controller with this feature, say Y or M here.
> > +
> >  config MMC_SDHCI_PCI
> >       tristate "SDHCI support on PCI bus"
> >       depends on MMC_SDHCI && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index a693fa3d3f1c..799f21d1f81f 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)               +=3D pxamci.o
> >  obj-$(CONFIG_MMC_MXC)                +=3D mxcmmc.o
> >  obj-$(CONFIG_MMC_MXS)                +=3D mxs-mmc.o
> >  obj-$(CONFIG_MMC_SDHCI)              +=3D sdhci.o
> > +obj-$(CONFIG_MMC_SDHCI_UHS2) +=3D sdhci-uhs2.o
> >  obj-$(CONFIG_MMC_SDHCI_PCI)  +=3D sdhci-pci.o
> >  sdhci-pci-y                  +=3D sdhci-pci-core.o sdhci-pci-o2micro.o=
 sdhci-pci-arasan.o \
> >                                  sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > new file mode 100644
> > index 000000000000..8e15bd0dadee
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controll=
er
> > + *  Interface driver
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + *  Copyright (C) 2020 Genesys Logic, Inc.
> > + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > + *  Copyright (C) 2020 Linaro Limited
> > + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-uhs2.h"
> > +
> > +#define DRIVER_NAME "sdhci_uhs2"
> > +#define DBG(f, x...) \
> > +     pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Driver init/exit                                                   =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int __init sdhci_uhs2_mod_init(void)
> > +{
> > +     return 0;
> > +}
> > +module_init(sdhci_uhs2_mod_init);
> > +
> > +static void __exit sdhci_uhs2_mod_exit(void)
> > +{
> > +}
> > +module_exit(sdhci_uhs2_mod_exit);
> > +
> > +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> > +MODULE_DESCRIPTION("MMC UHS-II Support");
> > +MODULE_LICENSE("GPL v2");
>
> Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cure the M=
ODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
>
>

I will update it to the V8 version.

Thanks, Victor Shih
