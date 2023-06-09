Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F2729827
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjFIL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFIL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:26:09 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533302D70
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:26:07 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565e8d575cbso15641177b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686309966; x=1688901966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZXll2p6QZbov35TIhSw5cTUwAtSmPgNFTPxS/Tfy1g=;
        b=ZOFLugWS4WDEBvyJpIL8RKZRU4WTqyWZWVLi6Bwhzw8GBxURqbAlQNTX8gzjUAT0ox
         /dpd8SFYA5MdsTdNZUapdAB3KHBNoQ56Xl8wqUKHmpl6iXBeAfCAiZq0JxT00xMTO0PY
         1l+28K3MSohUoWRpYTgQl/twHlyr7nrnlworbd98eniKBIQk1dinDmNuOhtLg9HOjq6m
         rPUbP3OUFOZ6YCx4mXbBDtziSXWQ5I2+mWePD4+9ZmWWVOdlJKSIadDeFHapK7J3huKv
         Hp2sUeRGvewP6S6KI74QGXjHtV6nL3V5MMxAbxPMFuZVip8zxsqFzklG4kkQDFKrD6fb
         Jg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309966; x=1688901966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZXll2p6QZbov35TIhSw5cTUwAtSmPgNFTPxS/Tfy1g=;
        b=TzWGTtR+FNKQ3HKZ+tA6p6+6zu6i4JhIHuQA+ddjYQlWXb++88tWupVjrIWhpsEt75
         qGIaYVPKUTzHfdWZOHbLtq/Rmx4L1fOhpmxAAK5K1N3wwOyR24iEDTg6CTJW5hRckmW/
         B9ziLz+OO2HLro+t0kDE+oQe8Xlucqr4uW8hrH+6zJ4r56Yo4a8eqyX/yYxhR+EGZ/cw
         KqJOO/3p/eFXQPq/xph2XWNxETV7NfXkbwEp6sOWm8nhxIVJY6eB4UWIH4O2kiYfews8
         ZFh/PKf9AYGC2fqwSNC9VnAHp3iRufJB3Wy43k5Yuvj10jLOeNXslylgqaVB78qzosyV
         bG3Q==
X-Gm-Message-State: AC+VfDxddUJmgkoYWnHjIIx917OIpRe7ju0zVWCRfdhWakFxakg20V2K
        Gcynym567a79yU/dFC1sW4o9xPkmxiPgU4J7TMv2ug==
X-Google-Smtp-Source: ACHHUZ7bp1ysdJMaMEi+eLtrGGAq1r8TEKctNxRIp5F2IxkCdI5JO2+zvf2/RVEDGhXRTX2bB0WMRC3r66YKEJzuyl8=
X-Received: by 2002:a81:52d7:0:b0:561:f6eb:d18a with SMTP id
 g206-20020a8152d7000000b00561f6ebd18amr1049606ywb.13.1686309966417; Fri, 09
 Jun 2023 04:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230609101355.5220-1-wenbin.mei@mediatek.com> <20230609101355.5220-2-wenbin.mei@mediatek.com>
In-Reply-To: <20230609101355.5220-2-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 13:25:30 +0200
Message-ID: <CAPDyKFrdLdQakpcMAp8ehZZu27xdPQL_cb12tOkjN0-vPT0F-A@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] mmc: mtk-sd: reduce CIT for better performance
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel test robot <lkp@intel.com>
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

On Fri, 9 Jun 2023 at 12:14, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
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
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

I have now replaced the v5 with v6, thanks! Applied for next.

Kind regards
Uffe


> ---
> the previous patche link:
> v5: https://patchwork.kernel.org/project/linux-mediatek/patch/20230606113249.28057-2-wenbin.mei@mediatek.com/
> v4: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605121442.23622-1-wenbin.mei@mediatek.com/
> v3: https://patchwork.kernel.org/project/linux-mediatek/patch/20230605060107.22044-1-wenbin.mei@mediatek.com/
> v2: https://patchwork.kernel.org/project/linux-mediatek/patch/20230510015851.11830-1-wenbin.mei@mediatek.com/
> v1: https://patchwork.kernel.org/project/linux-mediatek/patch/20230419063048.10516-1-wenbin.mei@mediatek.com/
> ---
>  drivers/mmc/host/cqhci.h  |  3 +++
>  drivers/mmc/host/mtk-sd.c | 46 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..1a12e40a02e6 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -5,6 +5,7 @@
>  #define LINUX_MMC_CQHCI_H
>
>  #include <linux/compiler.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/spinlock_types.h>
>  #include <linux/types.h>
> @@ -23,6 +24,8 @@
>  /* capabilities */
>  #define CQHCI_CAP                      0x04
>  #define CQHCI_CAP_CS                   0x10000000 /* Crypto Support */
> +#define CQHCI_CAP_ITCFMUL              GENMASK(15, 12)
> +#define CQHCI_ITCFMUL(x)               FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
>
>  /* configuration */
>  #define CQHCI_CFG                      0x08
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8ce864169986..99317fd9f084 100644
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
> @@ -2450,9 +2451,49 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>         }
>  }
>
> +static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
> +{
> +       struct mmc_host *mmc = mmc_from_priv(host);
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       u8 itcfmul;
> +       u64 hclk_freq, value;
> +
> +       /*
> +        * On MediaTek SoCs the MSDC controller's CQE uses msdc_hclk as ITCFVAL
> +        * so we multiply/divide the HCLK frequency by ITCFMUL to calculate the
> +        * Send Status Command Idle Timer (CIT) value.
> +        */
> +       hclk_freq = (u64)clk_get_rate(host->h_clk);
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
> @@ -2462,6 +2503,9 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>         msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>         /* default read data timeout 1s */
>         msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +       /* Set the send status command idle timer */
> +       cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
>  }
>
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> @@ -2803,6 +2847,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
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
