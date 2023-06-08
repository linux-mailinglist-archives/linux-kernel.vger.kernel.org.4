Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B409728B98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbjFHXK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjFHXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:10:56 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9E30C8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:10:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bb2ffa1e235so1159086276.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686265854; x=1688857854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SN0ge3MI/0IeqRc4N5LmJFP892MgbxzN2dbFaINJp+g=;
        b=KCZTqmKJ+VJzOc9KKA8TdTIL+V67qW3YIPBb333hwaSl95weyBcaEOrdzBdrF3kxOt
         03oci5v6cJVwIL3Av8EXMgkBonynnmFa7JnghjySfHmsuBn+o77q1MzXbQj/7DcqGAft
         jJZ3qN+oW/akenO9XzoDbSgI/tgDK6d+uSCZvJVjYJKH5p5BMB4T+wvzmExywYspNrfy
         tyMsammujvyeJ7hjQC3ZrKTepcFjtsW6EW6rJ/22wpDCuc44eHe0gAjKxGLMlayqCYaL
         7R+agmogDqFnFWd3ev/dwL/lSNQ763vJZjHwLPfsZ3wASnYpEDskWHzHeNLR4TMc1tmK
         9xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265854; x=1688857854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SN0ge3MI/0IeqRc4N5LmJFP892MgbxzN2dbFaINJp+g=;
        b=LjQdSPKgZ/1k4DD41qrHY2brXGEDGNsOW4jfEGzXg7uM8U/BiDoajcw+TRU/cSq3zF
         /Laocu+yS6Ms58nLT1XyxtVtbLGVol7DXqpbx9oLvVwkEXYDSQNIYXCK6zvEljTNuWTY
         pySHMVzN/WlfVGduz3Vd94JsBOMFogcXZTZvO3Lg0PJM1D4QKQlkh2/n+Y6t6Nj7N6Dw
         TBdgGq9IzJnjl6vw9o1yy3mcLkYdgow5YT+gie4FSvfnIh4GTIAcDjn1DILxPdnCVlRs
         4eIunRHNgzKgGXd0ZP8/AnSCjPXDOCBnxRlqakVxUD3CwsmLwzcIXpZ9OmKSJ0hbzPkK
         S/LA==
X-Gm-Message-State: AC+VfDx6rE6FmRRvrKQBMAgYKAhTN4a566cgA+x9su/tS3WRn5V2NRFI
        9mEokYulvSrloFIaGY2Pi4NrS+jUobgZYvmt8GkL0w==
X-Google-Smtp-Source: ACHHUZ4E9RVn5dOQXszUyb0/CmvdkGdz1gQ5GkEnozd1DWeFgjXKVXrU07bXYk/k93aNeBLxNomjZnRyF31Pn36Vknk=
X-Received: by 2002:a0d:d84b:0:b0:569:e868:fd7f with SMTP id
 a72-20020a0dd84b000000b00569e868fd7fmr1147264ywe.7.1686265853979; Thu, 08 Jun
 2023 16:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230606113249.28057-1-wenbin.mei@mediatek.com> <20230606113249.28057-2-wenbin.mei@mediatek.com>
In-Reply-To: <20230606113249.28057-2-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 01:10:18 +0200
Message-ID: <CAPDyKFoR+0xtmjESCfk5-aUYhsjcc6ATevRoRpw+atCjmz5yrQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] mmc: mtk-sd: reduce CIT for better performance
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 at 13:32, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> CQHCI_SSC1 indicates to CQE the polling period to use when using periodic
> SEND_QUEUE_STATUS(CMD13) polling.
> Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
> frequency to get the actual time.
> The default value 0x1000 that corresponds to 150us for MediaTek SoCs, let's
> decrease it to 0x40 that corresponds to 2.35us, which can improve the
> performance of some eMMC devices.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> the previous patche link:
> v4: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605121442.23622-1-wenbin.mei@mediatek.com/
> v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605060107.22044-1-wenbin.mei@mediatek.com/
> v2: https://patchwork.kernel.org/project/linux-mediatek/patch/20230510015851.11830-1-wenbin.mei@mediatek.com/
> v1: https://patchwork.kernel.org/project/linux-mediatek/patch/20230419063048.10516-1-wenbin.mei@mediatek.com/
> ---
>  drivers/mmc/host/cqhci.h  |  2 ++
>  drivers/mmc/host/mtk-sd.c | 47 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..e35c655edefc 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -23,6 +23,8 @@
>  /* capabilities */
>  #define CQHCI_CAP                      0x04
>  #define CQHCI_CAP_CS                   0x10000000 /* Crypto Support */
> +#define CQHCI_CAP_ITCFMUL              GENMASK(15, 12)
> +#define CQHCI_ITCFMUL(x)               FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
>
>  /* configuration */
>  #define CQHCI_CFG                      0x08
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8ce864169986..b582f19f82f2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -473,6 +473,7 @@ struct msdc_host {
>         struct msdc_tune_para def_tune_para; /* default tune setting */
>         struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
>         struct cqhci_host *cq_host;
> +       u32 cq_ssc1_time;
>  };
>
>  static const struct mtk_mmc_compatible mt2701_compat = {
> @@ -2450,9 +2451,50 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>         }
>  }
>
> +static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
> +{
> +       struct mmc_host *mmc = mmc_from_priv(host);
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       u8 itcfmul;
> +       unsigned long hclk_freq;
> +       u64 value;
> +
> +       /*
> +        * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
> +        * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
> +        * Send Status Command Idle Timer (CIT) value.
> +        */
> +       hclk_freq = clk_get_rate(host->h_clk);
> +       itcfmul = CQHCI_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
> +       switch (itcfmul) {
> +       case 0x0:
> +               do_div(hclk_freq, 1000);
> +               break;
> +       case 0x1:
> +               do_div(hclk_freq, 100);
> +               break;
> +       case 0x2:
> +               do_div(hclk_freq, 10);
> +               break;
> +       case 0x3:
> +               break;
> +       case 0x4:
> +               hclk_freq = hclk_freq * 10;
> +               break;
> +       default:
> +               host->cq_ssc1_time = 0x40;
> +               return;
> +       }
> +
> +       value = hclk_freq * timer_ns;
> +       do_div(value, 1000000000);
> +       host->cq_ssc1_time = value;
> +}
> +
>  static void msdc_cqe_enable(struct mmc_host *mmc)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +       struct cqhci_host *cq_host = mmc->cqe_private;
>
>         /* enable cmdq irq */
>         writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> @@ -2462,6 +2504,9 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>         msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>         /* default read data timeout 1s */
>         msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +       /* Set the send status command idle timer */
> +       cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
>  }
>
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> @@ -2803,6 +2848,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 /* cqhci 16bit length */
>                 /* 0 size, means 65536 so we don't have to -1 here */
>                 mmc->max_seg_size = 64 * 1024;
> +               /* Reduce CIT to 0x40 that corresponds to 2.35us */
> +               msdc_cqe_cit_cal(host, 2350);
>         }
>
>         ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> --
> 2.25.1
>
