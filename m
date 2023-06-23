Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68AE73BA16
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFWO0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWO0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:26:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B852107
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:26:46 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bff4f1e93caso604236276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687530406; x=1690122406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgboT9DB1el8gJJMu7+C2OURoRCCX7Ata/wxDdFKnN4=;
        b=w28n1amYeL0DJ/moDFxZsD4D4MuFuyVqFZaHKTF8qUkt40kVGuD5V4sAJ2PVpOnSOz
         SK/WciwJXYcst1+LisK2JMF51MeP36BkHHDTgXvSLB3HmtjJG8kxO0E3DjE6S6QIjDCz
         SGb7ABPzsxAL/BtnZ88pXun1sLYuk7P3RfzkyUJbLQp1wKdkoP0NTevfW81bN53fHz8E
         LtesYSQnJnMHNqCsKpuFbtU7cCv7X374R2fDgrQJp7R5wB5Rrk5qUdWgAEceHJIO15bB
         3V8hcaodENPcD+hySYGJXRhMpVRUuMvAGXxK95u/XwjZ6KXfIZoIiAzflvktmnDUXG6/
         hIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530406; x=1690122406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgboT9DB1el8gJJMu7+C2OURoRCCX7Ata/wxDdFKnN4=;
        b=iG4HcNW2rrXzzhM1lQEpgkd0oKRZNJYIlUWrIRfeCeXumje/UPKg1AKCraqEx6E1bt
         1mc7w4rVo3Tt/6ZXveEDidK7u7Bf/81Fexhz0RTif2qPVQng0HQtPwpj6DNGRCJpuvHg
         LHDP3hf30pWOhYqedy8mGY2NAo7e0Veo1AzavNiThmu2Q6x+jnHQsP8XBPfkaFTGYL1J
         O1Xq9FCXnztasewgUo5Fx7/CTvq5C+lX1Lpf0IqDJAgl5vMRixLx0NFfm4IT+EIDZY+4
         tkAybdB3jcDTITFg9vLMULfbVmy9bToMf5KaF8GeWj89A+esULz6i2r64fb1MQkF+AXD
         MW0Q==
X-Gm-Message-State: AC+VfDz/C3EvIrQMlOIoocbRVct/NXeSr60R9oQZyeM9XNvdPzG940iN
        48qDRiPrb3A3Il8wq0DgxrnC/OhF9aWpg6PGrKuSnQ==
X-Google-Smtp-Source: ACHHUZ6J8HzYKG87DLuuKBMXmZ9SfPCwcNmLq3/1E4kMwaCy5SDeCN050rapC3NLRcfgeOFsYfxeI5jqznlchHJJxyE=
X-Received: by 2002:a25:aab3:0:b0:bcb:523e:addf with SMTP id
 t48-20020a25aab3000000b00bcb523eaddfmr18499604ybi.65.1687530405703; Fri, 23
 Jun 2023 07:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com> <20230623141806.13388-6-quic_kbajaj@quicinc.com>
In-Reply-To: <20230623141806.13388-6-quic_kbajaj@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 23 Jun 2023 17:26:34 +0300
Message-ID: <CAA8EJpoZiXWDHGEgBF6KuKruQigqdy37pLH1Q_AnXsN6iRPhyA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 17:19, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add LLCC support for multi channel DDR configuration
> based on a feature register. Reading DDR channel
> confiuration uses nvmem framework, so select the
> dependency in Kconfig. Without this, there will be
> errors while building the driver with COMPILE_TEST only.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig     |  2 ++
>  drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..cc9ad41c63aa 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -64,6 +64,8 @@ config QCOM_LLCC
>         tristate "Qualcomm Technologies, Inc. LLCC driver"
>         depends on ARCH_QCOM || COMPILE_TEST
>         select REGMAP_MMIO
> +       select NVMEM

No need to select NVMEM. The used functions are stubbed if NVMEM is disabled

> +       select QCOM_SCM
>         help
>           Qualcomm Technologies, Inc. platform specific
>           Last Level Cache Controller(LLCC) driver for platforms such as,
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 6cf373da5df9..3c29612da1c5 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>         return ret;
>  }
>
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
> +{
> +       int ret;
> +
> +       ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
> +       if (ret == -ENOENT) {

|| ret == -EOPNOTSUPP ?

> +               *cfg_index = 0;
> +               return 0;
> +       }
> +
> +       return ret;
> +}
> +
>  static int qcom_llcc_remove(struct platform_device *pdev)
>  {
>         /* Set the global pointer to a error code to avoid referencing it */
> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         int ret, i;
>         struct platform_device *llcc_edac;
> -       const struct qcom_llcc_config *cfg;
> +       const struct qcom_llcc_config *cfg, *entry;
>         const struct llcc_slice_config *llcc_cfg;
>         u32 sz;
> +       u8 cfg_index;
>         u32 version;
>         struct regmap *regmap;
> +       u32 num_entries = 0;
>
>         drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>         if (!drv_data) {
> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>
>         drv_data->version = version;
>
> -       llcc_cfg = cfg[0]->sct_data;
> -       sz = cfg[0]->size;
> +       ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +       if (ret)
> +               goto err;
> +
> +       for (entry = cfg; entry->sct_data; entry++, num_entries++)
> +               ;

Please add num_cfgs to the configuration data instead.

> +       if (cfg_index >= num_entries || cfg_index < 0) {

cfg_index is unsigned, so it can not be less than 0.

> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       llcc_cfg = cfg[cfg_index].sct_data;
> +       sz = cfg[cfg_index].size;
>
>         for (i = 0; i < sz; i++)
>                 if (llcc_cfg[i].slice_id > drv_data->max_slices)
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
