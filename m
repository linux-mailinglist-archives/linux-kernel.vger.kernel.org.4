Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AFE6659D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjAKLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjAKLOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:14:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC6265A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:12:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so35947939ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JttOkOJMHLs5GvRO7ORXR2MC8X5jHZgJMAB6697r9oM=;
        b=XHdQCaKEQoXe4eL4a39+1JcPoPHTui3/h+QXetOdFnndBDJlD6sUr34L3Y4N/Gup8I
         05ORsbdRXXxmod5Kl/W/48Gksx3z+4P5229PISD8WWof+HxUYHAgEIui+URzld+8OJJJ
         5QpMqBtFTX7zkjIzHdqi/HyQIt+/ashzLctfxCxYZUVM9ou1gTxVpNIXeR047hGZldfq
         3DSkDDuutJAwOjFDzvTJUKjQk+9iCKuv2d5ptgLtA6tGycnc85eeU1UElQxWZALWx1+u
         ySEH9oIlGRTTBIfDheNgsuJUwN0OrNO6Mg+mdlovIihktNtI1DT2UX6d41KDE2/or+jo
         SARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JttOkOJMHLs5GvRO7ORXR2MC8X5jHZgJMAB6697r9oM=;
        b=rPlCApfV5eb7LURkAWukdGR87Z0gXgQpKhF2TeOnnJug95G9CVpYuxGWitTiKnSTE4
         zD8xh7Jdqp2uRwyaLRrvkPBVRXLoGihg1JrGGl1UgK11V6W/KOHWthBVGSvGqhVHBbBt
         I6Y9RPRPDAw+WGAXzKRhIeYTcRwKQhK8a/VPuQy2ogm9dont1nGST9uoKTD7a5W7PY5K
         5MB+LN50VEC2xoHVhIp/ZlUWbNvlzd6lbxWDwFbl+w8k2/8krJXsr5BOwwooktyCmzG6
         vKB7az+HPXq5UbeOwhT+4C79PqkfLKbprhS1WgfuMJQJPs+pSfinAPk7kvWdJBttaLbY
         0W9g==
X-Gm-Message-State: AFqh2koBbtxCylHtA5+9DqGrgud0tQohoJp81tXjpDcrdWqhOzw85HyR
        cpAmMvsRfOxWLbHLgADJcuaySG+PqfeEglvq0ilzkA==
X-Google-Smtp-Source: AMrXdXtoD/QhjaCvT4w3OyNRVCFgG++1yWmj9/YEfR2eaM9+I5FOTlFKyYJwlrJgCHuJbE1Cg5lgBGzecixLqcouYIo=
X-Received: by 2002:a17:906:2816:b0:7c0:a997:2298 with SMTP id
 r22-20020a170906281600b007c0a9972298mr5755197ejc.430.1673435576675; Wed, 11
 Jan 2023 03:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20230106170430.1214186-1-patrick.delaunay@foss.st.com> <20230106180414.v5.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
In-Reply-To: <20230106180414.v5.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 11 Jan 2023 12:12:45 +0100
Message-ID: <CAN5uoS8TN-1_Hndcpz7RZxsKSFffwc3KGAxGdEqPsZfKo-bC3A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] nvmem: stm32: detect bsec pta presence for STM32MP15x
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 at 18:04, Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> On STM32MP15x SoC, the SMC backend is optional when OP-TEE is used;
> the PTA BSEC should be used as it is done on STM32MP13x platform,
> but the BSEC SMC can be also used: it is a legacy mode in OP-TEE,
> not recommended but used in previous OP-TEE firmware.
>
> The presence of OP-TEE is dynamically detected in STM32MP15x device tree
> and the supported NVMEM backend is dynamically detected:
> - PTA with stm32_bsec_pta_find
> - SMC with stm32_bsec_check
>
> With OP-TEE but without PTA and SMC detection, the probe is deferred for
> STM32MP15x devices.
>
> On STM32MP13x platform, only the PTA is supported with cfg->ta = true
> and this detection is skipped.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
> Changes in v5:
> - update the BSEC SMC detection logic in stm32_romem_probe()
>   after Etienne Carierre review to support NVMEM probe after OP-TEE probe
>
> Changes in v3:
> - use of_find_compatible_node in optee_presence_check function
>   instead of of_find_node_by_path("/firmware/optee")
>
> Changes in v2:
> - Added patch in the serie for BSEC PTA support on STM32MP15x
>   with dynamic detection of OP-TEE presence and SMC support (legacy mode)
>
>  drivers/nvmem/stm32-romem.c | 38 +++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 978a63edf297..e0babc2cebd7 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -159,6 +159,31 @@ static int stm32_bsec_pta_write(void *context, unsigned int offset, void *buf,
>         return stm32_bsec_optee_ta_write(priv->ctx, priv->lower, offset, buf, bytes);
>  }
>
> +static bool stm32_bsec_smc_check(void)
> +{
> +       u32 val;
> +       int ret;
> +
> +       /* check that the OP-TEE support the BSEC SMC (legacy mode) */
> +       ret = stm32_bsec_smc(STM32_SMC_READ_SHADOW, 0, 0, &val);
> +
> +       return !ret;
> +}
> +
> +static bool optee_presence_check(void)
> +{
> +       struct device_node *np;
> +       bool tee_detected = false;
> +
> +       /* check that the OP-TEE node is present and available. */
> +       np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
> +       if (np && of_device_is_available(np))
> +               tee_detected = true;
> +       of_node_put(np);
> +
> +       return tee_detected;
> +}
> +
>  static int stm32_romem_probe(struct platform_device *pdev)
>  {
>         const struct stm32_romem_cfg *cfg;
> @@ -195,11 +220,16 @@ static int stm32_romem_probe(struct platform_device *pdev)
>         } else {
>                 priv->cfg.size = cfg->size;
>                 priv->lower = cfg->lower;
> -               if (cfg->ta) {
> +               if (cfg->ta || optee_presence_check()) {
>                         rc = stm32_bsec_optee_ta_open(&priv->ctx);
> -                       /* wait for OP-TEE client driver to be up and ready */
> -                       if (rc)
> -                               return rc;
> +                       if (rc) {
> +                               /* wait for OP-TEE client driver to be up and ready */
> +                               if (rc == -EPROBE_DEFER)
> +                                       return -EPROBE_DEFER;
> +                               /* BSEC PTA is required or SMC not ready */

Nitpicking: I would replace "SMC not ready" with "SMC not supported".
Aside that, Reviewed-by: Etienne Carriere <etienne.carriere@linaro.org>


> +                               if (cfg->ta || !stm32_bsec_smc_check())
> +                                       return rc;
> +                       }
>                 }
>                 if (priv->ctx) {
>                         rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
> --
> 2.25.1
>
