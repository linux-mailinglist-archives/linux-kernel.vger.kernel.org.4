Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790F61337B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJaKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJaKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:20:29 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F4DF62
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m125so13129695ybb.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5Gh0MPIp9DhVYaGLkkI1Pm4w41CIF739b91UGaYNM0=;
        b=pOrA0Oy+cgIv/AS1+YP5PBy96QVgfr1Qwi4ZUr3npdyVMYQ9H+93dWLGRsF/Jcf8N9
         SsZAH/vCfkNg6bSRS1P3uHrcR9oWrLmg8lZqE2X12fkaBa1/UZ4vvwNxk9f6E4iU/4/V
         cP0n3DhDUy6VWjFURsblMdqemupVeEKO5WEnyoLm7gtIrbHBZ8f4XI5LkF5gZPpcPO/N
         3aNXOwhbwbHBJUAKmPXJNfffCgv9hRWeoItEu45SehMwpow1v3mwLuedht1V/BQMWXhl
         c1HsVNOMApBOUN1nJBz4heqm5Mudq6m+xAgM7TDD4HKBMarm/dwlZaRDEucn2UfbubpY
         xnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5Gh0MPIp9DhVYaGLkkI1Pm4w41CIF739b91UGaYNM0=;
        b=2olF1MI2qwEmpX1XK7v0VpmWsjr4NMsq8+/4pR9ttrRvAjtb+b+63UV9Auj/8KasuL
         +ekBbzSsM4/MHqcLACf6UVszccYFwu92RSHRXBcaBfWm3cpG8r2yEDztSxDlsaqa8qSv
         RqM0fCkpSZ2P3akcUXAv42LeA4pU9zJqregMLxdy5To1YBCJn/0oxiF9SzQUolUVGIvL
         wzczOlzj29cn/2Bz8e1L6Q+89EnJeEbScEUrUbjaqsD2Gjytxebh6kHsZv1MUQwX8Bx2
         x9xaXTOwlmdp7oy+7fyChsEws/KynogzCHCR93cW9suw2qfzT2mEfQmMbwOQbv36EZa6
         iPEQ==
X-Gm-Message-State: ACrzQf2sadvubvIfLFmUogdpDeQhSmmERfywJXB9VnyGb9YClxa+e8i6
        h+onwVtERtw7fXFPHkm0HngVWrccjhFD0d1Vzm8BRpn16nr7RQ==
X-Google-Smtp-Source: AMsMyM5q9cjKVWuU5SQgcD0HzhX3LppmTWY7BqNEkBqmkfbop4ax+sOcxWtThwr9qahwrpzd2RjMTooVzvqFOSSJa08=
X-Received: by 2002:a05:6902:1006:b0:6ca:ae8d:9a2d with SMTP id
 w6-20020a056902100600b006caae8d9a2dmr12507191ybt.35.1667211625405; Mon, 31
 Oct 2022 03:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221029075356.7296-1-peter.ujfalusi@gmail.com>
In-Reply-To: <20221029075356.7296-1-peter.ujfalusi@gmail.com>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Mon, 31 Oct 2022 11:20:14 +0100
Message-ID: <CANyCTtQxciMKs9eaPM29NqpNTVdrqSMO2s3kKex-pRG5g2OZ9g@mail.gmail.com>
Subject: Re: [PATCH v2] soc: ti: k3-ringacc: Allow the driver to be built as module
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 29 oct. 2022 =C3=A0 09:44, Peter Ujfalusi
<peter.ujfalusi@gmail.com> a =C3=A9crit :
>
> The ring accelerator driver can be built as module since all depending
> functions are exported.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
> Hi,
>
> Changes since v1:
> - Fix MODULE_LICENSE line to GPL
> - Use goto label in k3_ringacc_request_ring() for try_module_get error
> - keep suppress_bind_attrs =3D true
>
> Nicolas, I have not added your reviewed and tested by tag due to these ch=
anges.
> I would appreciate if you would spare some time to re-check the patch.
>

Hi Peter,

I've re-checked/re-tested the patch.

Reviewed-by: Nicolas Frayer <nfrayer@baylibre.com>
Tested-by: Nicolas Frayer <nfrayer@baylibre.com>

> Regards,
> Peter
>
>  drivers/soc/ti/Kconfig      |  2 +-
>  drivers/soc/ti/k3-ringacc.c | 28 ++++++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7e2fb1c16af1..e009d9589af4 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -63,7 +63,7 @@ config TI_SCI_PM_DOMAINS
>           rootfs may be available.
>
>  config TI_K3_RINGACC
> -       bool "K3 Ring accelerator Sub System"
> +       tristate "K3 Ring accelerator Sub System"
>         depends on ARCH_K3 || COMPILE_TEST
>         depends on TI_SCI_INTA_IRQCHIP
>         help
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index f7bf18b8229a..e01e4d815230 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -7,7 +7,7 @@
>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> @@ -336,6 +336,9 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_rin=
gacc *ringacc,
>
>         mutex_lock(&ringacc->req_lock);
>
> +       if (!try_module_get(ringacc->dev->driver->owner))
> +               goto err_module_get;
> +
>         if (id =3D=3D K3_RINGACC_RING_ID_ANY) {
>                 /* Request for any general purpose ring */
>                 struct ti_sci_resource_desc *gp_rings =3D
> @@ -380,6 +383,9 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_rin=
gacc *ringacc,
>         return &ringacc->rings[id];
>
>  error:
> +       module_put(ringacc->dev->driver->owner);
> +
> +err_module_get:
>         mutex_unlock(&ringacc->req_lock);
>         return NULL;
>  }
> @@ -616,6 +622,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
>  no_init:
>         clear_bit(ring->ring_id, ringacc->rings_inuse);
>
> +       module_put(ringacc->dev->driver->owner);
> +
>  out:
>         mutex_unlock(&ringacc->req_lock);
>         return 0;
> @@ -1450,6 +1458,7 @@ static const struct of_device_id k3_ringacc_of_matc=
h[] =3D {
>         { .compatible =3D "ti,am654-navss-ringacc", .data =3D &k3_ringacc=
_data, },
>         {},
>  };
> +MODULE_DEVICE_TABLE(of, k3_ringacc_of_match);
>
>  struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev=
,
>                                             struct k3_ringacc_init_data *=
data)
> @@ -1544,12 +1553,27 @@ static int k3_ringacc_probe(struct platform_devic=
e *pdev)
>         return 0;
>  }
>
> +static int k3_ringacc_remove(struct platform_device *pdev)
> +{
> +       struct k3_ringacc *ringacc =3D dev_get_drvdata(&pdev->dev);
> +
> +       mutex_lock(&k3_ringacc_list_lock);
> +       list_del(&ringacc->list);
> +       mutex_unlock(&k3_ringacc_list_lock);
> +       return 0;
> +}
> +
>  static struct platform_driver k3_ringacc_driver =3D {
>         .probe          =3D k3_ringacc_probe,
> +       .remove         =3D k3_ringacc_remove,
>         .driver         =3D {
>                 .name   =3D "k3-ringacc",
>                 .of_match_table =3D k3_ringacc_of_match,
>                 .suppress_bind_attrs =3D true,
>         },
>  };
> -builtin_platform_driver(k3_ringacc_driver);
> +module_platform_driver(k3_ringacc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TI Ringacc driver for K3 SOCs");
> +MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
> --
> 2.38.1
>
