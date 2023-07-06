Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0677495CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjGFGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjGFGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:40:10 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E319BD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:40:08 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so498367276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688625608; x=1691217608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFuZqCYd8mXPFwdbDCt+oUvIlNY8jrnxtlOUpCZbLis=;
        b=jpGr1CU6H7mQ60HH9/2BKuR7fddutdJCelTfZ4hE1iUAoAUne5+EpKwA32TJJZ7AUk
         +dVpIcojy5nMnPiuf/0N/MSQmDdtLLzjOwsPc3JXFrL2tXwf6ioehYEmP59y3nHxCIeh
         toFrOHZFCqiTSuGyjhr+x1Yv1OX2Fy9agiZbzBWR92N83x8sXxPw1SupWW6M1h/I4Chx
         1xJIWHyb+ZQbqWrBEGYckgoqX/3AlLHr6QUL/dHoZdlBBioXGV0efZLq+S2rvypwRnZR
         wpeOwRKTBhIvQQNkqrka0YpYIb6OLGmiCVsPxN42OcI82vQPYY47sGK5xR78NU+VOiP3
         nxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625608; x=1691217608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFuZqCYd8mXPFwdbDCt+oUvIlNY8jrnxtlOUpCZbLis=;
        b=BknQcBsqDEZVw6ZoVcDGKlA8kg8h+btxoDPmNs9iBwuC+81bUL1afo6Rq/Ljxqo9CU
         6vI5YQieoAYHX83qrMf1fH4XAU//8xDmYnbyrFOMsBQPsDxVU/tfsBjpy1rujUosrLKM
         Hftj0OLErngMKXZEaSkbMJn5F3lnHEHuX2ROahFtBf7UH7q40K7AT9+MzpXTvIrxXthg
         T8EBLOO+J6OVH2Q7REDg3s3Q5/fNg2+k8SlAkeBnYPl72wqW1zVjTnwC/e6PrErj7Uj9
         hvxLcqJKhf2dk65HroealC90Xo+YQ6ab3Gl8ZFDMYQIdvHKZpcMjMWaKbY4eyT+9tOpN
         hR3w==
X-Gm-Message-State: ABy/qLYQTUSlm7cQBM3FtvMIN9+gsYF4vk+GA/V5vTs0nytivBQX/qwt
        cM8XJWh5nwPcLcM+XEyT2NK0SzqguEzav3ESR4MoRw==
X-Google-Smtp-Source: APBJJlG7gdBtggFwSWHfxz/MwrCmoDARoTv3JJX1toI8d1Hwd/IwdBN+maLNT9LOwXA+BbkGADSmO4LWAAcK+DC7+hk=
X-Received: by 2002:a25:c588:0:b0:c5d:a805:eebd with SMTP id
 v130-20020a25c588000000b00c5da805eebdmr3097419ybe.7.1688625607747; Wed, 05
 Jul 2023 23:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230706051024.15422-1-quic_ptalari@quicinc.com> <20230706051024.15422-3-quic_ptalari@quicinc.com>
In-Reply-To: <20230706051024.15422-3-quic_ptalari@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 6 Jul 2023 09:39:56 +0300
Message-ID: <CAA8EJprU3FhEWodw2rfFiYkw3rg_WaxqZOOQOt=mcp3xfsoJUw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] spi: spi-geni-qcom: Add SPI Device mode support
 for GENI based QuPv3
To:     Praveen Talari <quic_ptalari@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_vnivarth@quicinc.com, quic_arandive@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2023 at 08:12, Praveen Talari <quic_ptalari@quicinc.com> wrote:
>
> Currently spi geni driver supports only master mode operation.
>
> Add spi device mode support to GENI based QuPv3.
>
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> ---
> v3 -> v4:
> - Used existing property spi-slave.
>
> v2 -> v3:
> - modified commit message to use device mode instead of slave mode
>
> v1 -> v2
> - modified the commit message
> - added the code changes for code comments
> ---
>  drivers/spi/spi-geni-qcom.c | 57 +++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 206cc04bb1ed..4ec4fdee06b5 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/soc/qcom/geni-se.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
> @@ -52,6 +53,9 @@
>  #define SPI_CS_CLK_DELAY_MSK           GENMASK(19, 10)
>  #define SPI_CS_CLK_DELAY_SHFT          10
>
> +#define SE_SPI_SLAVE_EN                                (0x2BC)
> +#define SPI_SLAVE_EN                           BIT(0)
> +
>  /* M_CMD OP codes for SPI */
>  #define SPI_TX_ONLY            1
>  #define SPI_RX_ONLY            2
> @@ -99,6 +103,24 @@ struct spi_geni_master {
>         int cur_xfer_mode;
>  };
>
> +static struct spi_master *get_spi_master(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct spi_master *spi = platform_get_drvdata(pdev);

You can use dev_get_drvdata() directly, without going through platform_device.

> +
> +       return spi;
> +}
> +
> +static void spi_slv_setup(struct spi_geni_master *mas)
> +{
> +       struct geni_se *se = &mas->se;
> +
> +       writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
> +       writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
> +       writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
> +       dev_dbg(mas->dev, "spi slave setup done\n");
> +}
> +
>  static int get_spi_clk_cfg(unsigned int speed_hz,
>                         struct spi_geni_master *mas,
>                         unsigned int *clk_idx,
> @@ -140,12 +162,18 @@ static void handle_se_timeout(struct spi_master *spi,
>         const struct spi_transfer *xfer;
>
>         spin_lock_irq(&mas->lock);
> -       reinit_completion(&mas->cancel_done);
>         if (mas->cur_xfer_mode == GENI_SE_FIFO)
>                 writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>
>         xfer = mas->cur_xfer;
>         mas->cur_xfer = NULL;
> +
> +       if (spi->slave) {

A comment here would be nice.

> +               spin_unlock_irq(&mas->lock);
> +               goto unmap_if_dma;
> +       }
> +
> +       reinit_completion(&mas->cancel_done);
>         geni_se_cancel_m_cmd(se);
>         spin_unlock_irq(&mas->lock);
>
> @@ -542,6 +570,10 @@ static bool geni_can_dma(struct spi_controller *ctlr,
>         if (mas->cur_xfer_mode == GENI_GPI_DMA)
>                 return true;
>
> +       /* Set DMA mode for SPI slave. */

SE DMA mode

> +       if (ctlr->slave)
> +               return true;
> +
>         len = get_xfer_len_in_words(xfer, mas);
>         fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
>
> @@ -619,6 +651,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>
>  static int spi_geni_init(struct spi_geni_master *mas)
>  {
> +       struct spi_master *spi = get_spi_master(mas->dev);
>         struct geni_se *se = &mas->se;
>         unsigned int proto, major, minor, ver;
>         u32 spi_tx_cfg, fifo_disable;
> @@ -627,7 +660,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
>         pm_runtime_get_sync(mas->dev);
>
>         proto = geni_se_read_proto(se);
> -       if (proto != GENI_SE_SPI) {
> +
> +       if (spi->slave) {
> +               if (proto != GENI_SE_SPI_SLAVE) {
> +                       dev_err(mas->dev, "Invalid proto %d\n", proto);
> +                       goto out_pm;
> +               }
> +               spi_slv_setup(mas);
> +       } else if (proto != GENI_SE_SPI) {
>                 dev_err(mas->dev, "Invalid proto %d\n", proto);
>                 goto out_pm;
>         }
> @@ -677,9 +717,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
>         }
>
>         /* We always control CS manually */
> -       spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> -       spi_tx_cfg &= ~CS_TOGGLE;
> -       writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +       if (!spi->slave) {
> +               spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
> +               spi_tx_cfg &= ~CS_TOGGLE;
> +               writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +       }
>
>  out_pm:
>         pm_runtime_put(mas->dev);
> @@ -1072,6 +1114,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>         pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
>         pm_runtime_enable(dev);
>
> +       if (device_property_read_bool(&pdev->dev, "spi-slave"))
> +               spi->slave = true;
> +
>         ret = geni_icc_get(&mas->se, NULL);
>         if (ret)
>                 goto spi_geni_probe_runtime_disable;
> @@ -1092,7 +1137,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>          * for dma (gsi) mode, the gsi will set cs based on params passed in
>          * TRE
>          */
> -       if (mas->cur_xfer_mode == GENI_SE_FIFO)
> +       if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
>                 spi->set_cs = spi_geni_set_cs;
>
>         ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
