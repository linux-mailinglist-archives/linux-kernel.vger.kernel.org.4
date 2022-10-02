Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB55F22A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJBKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:37:29 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9A83BC52;
        Sun,  2 Oct 2022 03:37:29 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id a20so5018614qtw.10;
        Sun, 02 Oct 2022 03:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Vn8QgBQKdU3foTWT0lboWMjSxI0LuQABTI7xN/fvQJ0=;
        b=TqiGc6xZScuk/OOtuoC4b8ytKYZGECE1pBo9clYJjs8ShtJ4zQxxz+8O/8MTyolrOA
         PrqRO03ObGrUjA2gVlkw6GdGZGiUBhkl8c6P6mgQmUrApqmP9tVbpFa/pIK1fe8uTIyS
         P3gCfgU8fa/wMo0TGiUS+XACaz1MTYR3tJtqMAChW+KEFhpLZhdZnLHMT5jbiIKOWV+c
         KjXFslovT/auGOO1omMggRspIWrYU3rj/TbCOQnXFm6XlFcQCoVRiQBniO0OmzaKzD6o
         YcCkcQQXqYWyoful8q4jnxsWymU/YmSW3Wd9J3H41M+dXdTVmxGfGkuwOX1DZ9PFjXzs
         EoDA==
X-Gm-Message-State: ACrzQf20r4cicBHp7HDYQe3mZmmTUsrXMt6DeIaBo9wWXnSYvM8wqncL
        fhhSiDnOQpAAC3IZXcOV8GkSjCc/5R0/3w==
X-Google-Smtp-Source: AMsMyM6qgKZoENCBZs4SYYtuQXLpBv2+jAR8oU66XWERib4YYCWo/8533axKLQit65huCIcRg/vjOg==
X-Received: by 2002:ac8:7dc6:0:b0:35c:c9b1:9f98 with SMTP id c6-20020ac87dc6000000b0035cc9b19f98mr12943534qte.170.1664707047858;
        Sun, 02 Oct 2022 03:37:27 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87541000000b0035bb6c3811asm6617926qtr.53.2022.10.02.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 03:37:27 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-353fbfa727cso82810747b3.4;
        Sun, 02 Oct 2022 03:37:27 -0700 (PDT)
X-Received: by 2002:a0d:ea90:0:b0:358:b93:d039 with SMTP id
 t138-20020a0dea90000000b003580b93d039mr4473622ywe.47.1664707046943; Sun, 02
 Oct 2022 03:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221001122148.9158-1-kyarlagadda@nvidia.com> <20221001122148.9158-5-kyarlagadda@nvidia.com>
In-Reply-To: <20221001122148.9158-5-kyarlagadda@nvidia.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 12:37:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUoABDeLrdudfY09jGmCcnFpJmFGf0OieVBG6OuEpk7ZA@mail.gmail.com>
Message-ID: <CAMuHMdUoABDeLrdudfY09jGmCcnFpJmFGf0OieVBG6OuEpk7ZA@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: tegra210-quad: native dma support
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Sat, Oct 1, 2022 at 2:26 PM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:
> Enable Native DMA support for Tegra23 & Tegra24
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>

Thanks for your patch!

> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c

> @@ -163,7 +169,7 @@
>  #define DATA_TRANSFER                          3
>
>  struct tegra_qspi_soc_data {
> -       bool has_dma;
> +       int has_dma;

unsigned int

Please rename the variable to e.g. "dma_mode", as "has_<foo>" suggests
it is a boolean flag.

>         bool cmb_xfer_capable;
>         unsigned int cs_count;
>  };

> @@ -629,23 +640,35 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
>                 len = tqspi->curr_dma_words * 4;
>
>         /* set attention level based on length of transfer */
> -       val = 0;
> -       if (len & 0xf) {
> -               val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> -               dma_burst = 1;
> -       } else if (((len) >> 4) & 0x1) {
> -               val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> -               dma_burst = 4;
> -       } else {
> -               val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> -               dma_burst = 8;
> +       if (has_ext_dma) {
> +               val = 0;
> +               if (len & 0xf) {
> +                       val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> +                       dma_burst = 1;
> +               } else if (((len) >> 4) & 0x1) {
> +                       val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> +                       dma_burst = 4;
> +               } else {
> +                       val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> +                       dma_burst = 8;
> +               }
>         }
>
>         tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>         tqspi->dma_control_reg = val;
>
>         dma_sconfig.device_fc = true;
> -       if (tqspi->cur_direction & DATA_DIR_TX) {
> +       if ((tqspi->cur_direction & DATA_DIR_TX) && !has_ext_dma) {
> +               if (tqspi->is_packed)
> +                       tx_dma_phys = t->tx_dma;
> +               else
> +                       tx_dma_phys = tqspi->tx_dma_phys;
> +               tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +               tegra_qspi_writel(tqspi, (tx_dma_phys & 0xffffffff),

lower_32_bits(), for consistency with below.

> +                                 QSPI_DMA_MEM_ADDRESS_REG);
> +               tegra_qspi_writel(tqspi, ((tx_dma_phys >> 32) & 0xff),

upper_32_bits(), to fix the build failures reported by 0-day
("warning: shift count >= width of type").

> +                                 QSPI_DMA_HI_ADDRESS_REG);
> +       } else if ((tqspi->cur_direction & DATA_DIR_TX) && has_ext_dma) {
>                 dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
>                 dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 dma_sconfig.dst_maxburst = dma_burst;

> @@ -1045,6 +1085,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>                                         struct spi_message *msg)
>  {
>         bool is_first_msg = true;
> +       bool has_ext_dma = (tqspi->soc_data->has_dma &
> +                           QSPI_DMA_EXT) ? true : false;

No need for the "? true : false" (everywhere)

>         struct spi_transfer *xfer;
>         struct spi_device *spi = msg->spi;
>         u8 transfer_phase = 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
