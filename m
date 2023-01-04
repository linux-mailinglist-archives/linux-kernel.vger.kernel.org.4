Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF165CF8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjADJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjADJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:30:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00527D9B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:30:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so81064647ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CmEXY85Wfe5zRCPYTM22tY3+v8slzBjcPUwowPXH7Q=;
        b=YbFROjWcXuYpdMirg154U9mKDnTGYVd9fIuzWkgW4bVOFDMxgXQ0zHIUxFUcyrX2Zb
         30BKXYeNJWNG4wOeKq0Anr2+a692z3+W/K1xC7AsfzpEfRLviiG04KgVmDJDPc+BcP4J
         l6riXWXBS8z1jliXdzP22d7oVVY/qT16oX8N76iWJXMs0/SCWdVEZLamFmHli+QVQoOH
         JVfGKyQRbvs7ibMd/j1CiCoeleZJU1egZ+AD9owYwKmFbV77po19ss0O50OcqHSpFz3T
         44G3FcZ0Yp/++aj/aiYEdpko21rITUVVHczq1OHEFhSsXKv3FoZO+opchShyr6v/tWeG
         nTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CmEXY85Wfe5zRCPYTM22tY3+v8slzBjcPUwowPXH7Q=;
        b=BX9plNkxbN4tMUE1p2BpgJbcBW+shcjWUPNW1mgZFTYOGeqPyUB7GkKnTRAl+90slU
         jh70jtSR+MvaIFBxndKac4U2VYuIdwh+m3V5YDhzvWubOxdRjNsSejXZlbPxQcqiUjwr
         fhOIANJcCHbbcDsa2aMYbsZ81T5gHPhwNRPiluPkAMqIkYc5cWNZKniPMTfTda1Xk9Tm
         D9RF5N/Iyjsx/OjcKqnEcAzEQmc/tuzN4nXSv7Mf9BQC5KeS3p9cO6jAB8uB37HGPC96
         cQY6QaCC/RWvByEJ6yCwFtkbTEihRdcacaeqRfbPOMWeHUkZLYJZpRMvuZmbHc/n2QnL
         w2Tw==
X-Gm-Message-State: AFqh2kp4WNPRHJ5lH04XXFGVETfGjiSDFsY54XcNDTVXIShFTgr+zeIG
        Pp9TkFXeyoUwPyWydii2EEjfWM+lcvsivMlJA3zZ9w==
X-Google-Smtp-Source: AMrXdXs4jpYwJfABguan7RaoumMvEbg/uoMMMOFjsNNkGDgxEDFMlvnkPmf+x3Fxi8UykbA7W2HuYOVd7GPQt7af9fU=
X-Received: by 2002:a17:906:4ecb:b0:7bc:2ad:fae with SMTP id
 i11-20020a1709064ecb00b007bc02ad0faemr3244245ejv.724.1672824649391; Wed, 04
 Jan 2023 01:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20230103140521.187678-1-patrick.delaunay@foss.st.com> <20230103150515.v4.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
In-Reply-To: <20230103150515.v4.3.I59210046e368cfc22bd3cca2afe1653674f8ece8@changeid>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 4 Jan 2023 10:30:38 +0100
Message-ID: <CAN5uoS-dXLSs9DiJFBTAOJbPZPp4BUfxqZ7ND_irzBbUEwaUHg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] nvmem: stm32: detect bsec pta presence for STM32MP15x
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
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

Hi Patrick,

On Tue, 3 Jan 2023 at 15:08, Patrick Delaunay
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
> (no changes since v3)
>
> Changes in v3:
> - use of_find_compatible_node in optee_presence_check function
>   instead of of_find_node_by_path("/firmware/optee")
>
> Changes in v2:
> - Added patch in the serie for BSEC PTA support on STM32MP15x
>   with dynamic detection of OP-TEE presence and SMC support (legacy mode)
>
>  drivers/nvmem/stm32-romem.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 2edc61925e52..1b90c78301fa 100644
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
> @@ -195,10 +220,14 @@ static int stm32_romem_probe(struct platform_device *pdev)
>         } else {
>                 priv->cfg.size = cfg->size;
>                 priv->lower = cfg->lower;
> -               if (cfg->ta) {
> +               if (cfg->ta || optee_presence_check()) {
>                         rc = stm32_bsec_optee_ta_open(&priv->ctx);
>                         /* wait for OP-TEE client driver to be up and ready */
> -                       if (rc)
> +                       if (rc == -EPROBE_DEFER) {
> +                               /* BSEC PTA is required or SMC not ready */
> +                               if (cfg->ta || !stm32_bsec_smc_check())
> +                                       return -EPROBE_DEFER;
> +                       } else if (rc)

Could you fix the logic? The sequence here fails to fallback to BSEC
SMC service if optee does not embed BSEC PTA service and optee driver
is probed before stm32_romem.

Br,
etienne

>                                 return rc;
>                         rc = devm_add_action_or_reset(dev, stm32_bsec_optee_ta_close, priv->ctx);
>                         if (rc) {
> --
> 2.25.1
>
