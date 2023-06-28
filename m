Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1D741C11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjF1W56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjF1W5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:57:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C965E2972;
        Wed, 28 Jun 2023 15:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B31D61486;
        Wed, 28 Jun 2023 22:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C44C433D9;
        Wed, 28 Jun 2023 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687993055;
        bh=XSxNf5d4s/AaOcCnirW0Jl1hvso/mY++X2drHrXVbCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WYXmL+vPDanp9rWWgOqVG3J6qu+xxaFQTxmeVW2LJ3sI5bQVIUqIi2JN0ogyHNEc5
         cfbkDgSkk4fcLxroMjmvyXRI91pEf4dU/CH/XVRDqLmrBfDaXZQtG7Ev9/2qqN/7X0
         9RFVzkko3oQW0cXCts9ht/E7rRKtimpDtRVb3JWQ4nqY3yCEBQPW6dAbq7nWCRa1Mo
         Jtvx6oBg6S+mtkhb6tl/ZSxpwPlcwLTdTkqUx51BsUgTn4oWCG+Hpvh0/uXSYnlN/I
         R2CRgqqoVeotq2LZqXCF98OvrkklLVay0vwVs4Uf2LDSE3eNAA3Dm7dzYV8UqaX0Y4
         GZharQNDLg8JQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso949011fa.0;
        Wed, 28 Jun 2023 15:57:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDxT6fTiH8Q6Vb40zjLKq61mw7tlbhvO7nT6qG7K1OHLQDUAcZId
        sfh87tgRbIE3vSm6uccXDknha2SnWETuyU8cig==
X-Google-Smtp-Source: ACHHUZ4J98dfCHqOutQPFPcPHFwg8wcRtXlshbyiPOJK90fuQQ5MEJui8/nFepQ3uoj3Iks6YjlbDG9ljkXq33sPRYk=
X-Received: by 2002:a2e:7e0f:0:b0:2b5:9d2a:ab51 with SMTP id
 z15-20020a2e7e0f000000b002b59d2aab51mr9130668ljc.5.1687993053604; Wed, 28 Jun
 2023 15:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-11-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-11-git-send-email-quic_mojha@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Jun 2023 16:57:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+O70mnreuS1m54RKM+uZu_z1L87RT8sKBYEw5uvowGJg@mail.gmail.com>
Message-ID: <CAL_Jsq+O70mnreuS1m54RKM+uZu_z1L87RT8sKBYEw5uvowGJg@mail.gmail.com>
Subject: Re: [PATCH v4 10/21] soc: qcom: Add qcom's pstore minidump driver support
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:37=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> This driver was inspired from the fact pstore ram region should be
> fixed and boot firmware need to have awarness about this region,
> so that it will be persistent across boot. But, there are many
> QCOM SoC which does not support warm boot from hardware but they
> have minidump support from the software, and for them, there is
> no need of this pstore ram region to be fixed, but at the same
> time have interest in the pstore frontends data. So, this driver
> get the dynamic reserved region from the ram and register the
> ramoops platform device.
>
>  +---------+     +---------+   +--------+     +---------+
>  | console |     | pmsg    |   | ftrace |     | dmesg   |
>  +---------+     +---------+   +--------+     +---------+
>        |             |             |              |
>        |             |             |              |
>        +------------------------------------------+
>                           |
>                          \ /
>                   +----------------+
>             (1)   |pstore frontends|
>                   +----------------+
>                           |
>                          \ /
>                  +------------------- +
>             (2)  | pstore backend(ram)|
>                  +--------------------+
>                           |
>                          \ /
>                  +--------------------+
>             (3)  |qcom_pstore_minidump|
>                  +--------------------+
>                           |
>                          \ /
>                    +---------------+
>             (4)    | qcom_minidump |
>                    +---------------+
>
> This driver will route all the pstore front data to the stored
> in qcom pstore reserved region and the reason of showing an
> arrow from (3) to (4) as qcom_pstore_minidump driver will register
> all the available frontends region with qcom minidump driver
> in upcoming patch.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig                | 12 +++++
>  drivers/soc/qcom/Makefile               |  1 +
>  drivers/soc/qcom/qcom_pstore_minidump.c | 85 +++++++++++++++++++++++++++=
++++++

drivers/soc/ is the dumping ground for things with no other place. As
this is a pstore driver, it belongs with pstore.

>  3 files changed, 98 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 1834213fd652..fbf08e30feda 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -306,4 +306,16 @@ config QCOM_MINIDUMP_SMEM
>
>           This config should be enabled if the low level minidump is impl=
emented
>           as part of SMEM.
> +
> +config QCOM_PSTORE_MINIDUMP
> +       tristate "Pstore support for QCOM Minidump"
> +       depends on ARCH_QCOM
> +       depends on PSTORE_RAM
> +       depends on QCOM_MINIDUMP
> +       help
> +         Enablement of this driver ensures that ramoops region can be an=
ywhere
> +         reserved in ram instead of being fixed address which needs boot=
 firmware
> +         awareness. So, this driver creates plaform device and registers=
 available
> +         frontend region with the Qualcomm's minidump driver.
> +
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 737d868757ac..1ab59c1b364d 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -36,3 +36,4 @@ qcom_ice-objs                 +=3D ice.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)        +=3D qcom_ice.o
>  obj-$(CONFIG_QCOM_MINIDUMP) +=3D qcom_minidump.o
>  obj-$(CONFIG_QCOM_MINIDUMP_SMEM) +=3D qcom_minidump_smem.o
> +obj-$(CONFIG_QCOM_PSTORE_MINIDUMP) +=3D qcom_pstore_minidump.o
> diff --git a/drivers/soc/qcom/qcom_pstore_minidump.c b/drivers/soc/qcom/q=
com_pstore_minidump.c
> new file mode 100644
> index 000000000000..b07cd10340df
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_pstore_minidump.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserv=
ed.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>

You probably don't need this include. Use the actual includes you need
and don't rely on implicit includes (because I'm trying to remove
those).

> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/pstore_ram.h>
> +
> +struct qcom_ramoops_dd {
> +       struct ramoops_platform_data qcom_ramoops_pdata;
> +       struct platform_device *ramoops_pdev;
> +};
> +
> +static int qcom_ramoops_probe(struct platform_device *pdev)
> +{
> +       struct device_node *of_node =3D pdev->dev.of_node;
> +       struct qcom_ramoops_dd *qcom_rdd;
> +       struct ramoops_platform_data *pdata;
> +       struct reserved_mem *rmem;
> +       struct device_node *node;
> +       long ret;
> +
> +       node =3D of_parse_phandle(of_node, "memory-region", 0);
> +       if (!node)
> +               return -ENODEV;
> +
> +       rmem =3D of_reserved_mem_lookup(node);
> +       of_node_put(node);
> +       if (!rmem) {
> +               dev_err(&pdev->dev, "failed to locate DT /reserved-memory=
 resource\n");
> +               return -EINVAL;
> +       }
> +
> +       qcom_rdd =3D devm_kzalloc(&pdev->dev, sizeof(*qcom_rdd), GFP_KERN=
EL);
> +       if (!qcom_rdd)
> +               return -ENOMEM;
> +
> +       pdata =3D &qcom_rdd->qcom_ramoops_pdata;
> +       pdata->mem_size =3D rmem->size;
> +       pdata->mem_address =3D rmem->base;
> +       ramoops_parse_dt(pdev, pdata);
> +
> +       qcom_rdd->ramoops_pdev =3D platform_device_register_data(NULL, "r=
amoops", -1,
> +                                                              pdata, siz=
eof(*pdata));
> +       if (IS_ERR(qcom_rdd->ramoops_pdev)) {
> +               ret =3D PTR_ERR(qcom_rdd->ramoops_pdev);
> +               dev_err(&pdev->dev, "could not create platform device: %l=
d\n", ret);
> +               qcom_rdd->ramoops_pdev =3D NULL;
> +       }
> +       platform_set_drvdata(pdev, qcom_rdd);
> +
> +       return ret;
> +}
> +
> +static void qcom_ramoops_remove(struct platform_device *pdev)
> +{
> +       struct qcom_ramoops_dd *qcom_rdd =3D platform_get_drvdata(pdev);
> +
> +       platform_device_unregister(qcom_rdd->ramoops_pdev);
> +       qcom_rdd->ramoops_pdev =3D NULL;
> +}
> +
> +static const struct of_device_id qcom_ramoops_of_match[] =3D {
> +       { .compatible =3D "qcom,ramoops"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_ramoops_of_match);
> +
> +static struct platform_driver qcom_ramoops_drv =3D {
> +       .driver         =3D {
> +               .name   =3D "qcom,ramoops",
> +               .of_match_table =3D qcom_ramoops_of_match,
> +       },
> +       .probe =3D qcom_ramoops_probe,
> +       .remove_new =3D qcom_ramoops_remove,
> +};
> +
> +module_platform_driver(qcom_ramoops_drv);
> +
> +MODULE_DESCRIPTION("Qualcomm ramoops minidump driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
