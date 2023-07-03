Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D55745A0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGCKT5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 06:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGCKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:19:42 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA7D2;
        Mon,  3 Jul 2023 03:19:39 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-56fff21c2ebso50362497b3.3;
        Mon, 03 Jul 2023 03:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688379578; x=1690971578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otTmQa23ksdmtXKU5Wvw4W3m/LeTHlMGWSV7Ivn/a54=;
        b=Gfbled8ZhBknK2NwkOKdhLNFWSYDyhaRzrQMV2vFTvFNFjnuOn6//11FbZlXMhEPaH
         kTswYCsQtFjMt1xcDw1gRy8w8MewzpZgXFsm6t6DKcyn3YalpB4YKd97ILwotAch659F
         e7jSBUDosWr1FiiJLsqvnw3nkyHwQuBxWCeUBgl5hDe3f9zSkBmgxmgatrnWR5JSJOOU
         VvjkhUPS619SWeWAGduxVZgJNwZWqQH7dX5mgJb6GbffwFO3sjaZZ6euHpkzcucPJAQw
         QVhVakGvwenDNaw7fUcbJ5k7GCacl2zSOom94+kNKY1+EBMS0v+DRYyopsUao1xElsrt
         omNg==
X-Gm-Message-State: ABy/qLYc7k8hmOR/0/E9OsfAS8P54lqhR7SalQ/Gkl3jy0Cg2sAAce13
        9Y5Bqco0EuydiiQj1TFvy2xgxrzdkbOpOw==
X-Google-Smtp-Source: APBJJlG2fCbFeD8/jEjYvn3pn7Ir+vTfEUTZv5f/ob5ouENJVP969GY0It3BBdqRcdkzD8e7h7Jm1A==
X-Received: by 2002:a0d:d6c2:0:b0:577:16f7:91d9 with SMTP id y185-20020a0dd6c2000000b0057716f791d9mr8831516ywd.12.1688379578445;
        Mon, 03 Jul 2023 03:19:38 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id v19-20020a814813000000b0054fba955474sm5016041ywa.17.2023.07.03.03.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:19:38 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so2021461276.3;
        Mon, 03 Jul 2023 03:19:37 -0700 (PDT)
X-Received: by 2002:a25:9d0f:0:b0:c1c:df23:44ec with SMTP id
 i15-20020a259d0f000000b00c1cdf2344ecmr9214702ybp.0.1688379577443; Mon, 03 Jul
 2023 03:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230622113341.657842-1-fabrizio.castro.jz@renesas.com> <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230622113341.657842-4-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 12:19:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
Message-ID: <CAMuHMdVsYohH5FVv6r4ha0AaHRoHjNF1ErjW1FNF7ZAQR9ntxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spi: Add support for Renesas CSI
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Thu, Jun 22, 2023 at 1:34 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M SoC comes with the Clocked Serial Interface (CSI)
> IP, which is a master/slave SPI controller.
>
> This commit adds a driver to support CSI master mode.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v2: edited includes in drivers/spi/spi-rzv2m-csi.c

Thanks for your patch!

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -825,6 +825,12 @@ config SPI_RSPI
>         help
>           SPI driver for Renesas RSPI and QSPI blocks.
>
> +config SPI_RZV2M_CSI
> +       tristate "Renesas RZV2M CSI controller"

RZ/V2M (patch sent)

> +       depends on ARCH_RENESAS || COMPILE_TEST
> +       help
> +         SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
> +
>  config SPI_QCOM_QSPI
>         tristate "QTI QSPI controller"
>         depends on ARCH_QCOM || COMPILE_TEST

> --- /dev/null
> +++ b/drivers/spi/spi-rzv2m-csi.c
> @@ -0,0 +1,667 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Renesas RZ/V2M Clocked Serial Interface (CSI) driver
> + *
> + * Copyright (C) 2023 Renesas Electronics Corporation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/count_zeros.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +
> +/* Registers */
> +#define CSI_MODE               0x00    /* CSI mode control */
> +#define CSI_CLKSEL             0x04    /* CSI clock select */
> +#define CSI_CNT                        0x08    /* CSI control */
> +#define CSI_INT                        0x0C    /* CSI interrupt status */
> +#define CSI_IFIFOL             0x10    /* CSI receive FIFO level display */
> +#define CSI_OFIFOL             0x14    /* CSI transmit FIFO level display */
> +#define CSI_IFIFO              0x18    /* CSI receive window */
> +#define CSI_OFIFO              0x1C    /* CSI transmit window */
> +#define CSI_FIFOTRG            0x20    /* CSI FIFO trigger level */
> +
> +/* CSI_MODE */
> +#define CSI_MODE_CSIE          BIT(7)
> +#define CSI_MODE_TRMD          BIT(6)
> +#define CSI_MODE_CCL           BIT(5)
> +#define CSI_MODE_DIR           BIT(4)
> +#define CSI_MODE_CSOT          BIT(0)
> +
> +#define CSI_MODE_SETUP         0x00000040
> +
> +/* CSI_CLKSEL */
> +#define CSI_CLKSEL_CKP         BIT(17)
> +#define CSI_CLKSEL_DAP         BIT(16)
> +#define CSI_CLKSEL_SLAVE       BIT(15)
> +#define CSI_CLKSEL_CKS         GENMASK(14, 1)
> +
> +/* CSI_CNT */
> +#define CSI_CNT_CSIRST         BIT(28)
> +#define CSI_CNT_R_TRGEN                BIT(19)
> +#define CSI_CNT_UNDER_E                BIT(13)
> +#define CSI_CNT_OVERF_E                BIT(12)
> +#define CSI_CNT_TREND_E                BIT(9)
> +#define CSI_CNT_CSIEND_E       BIT(8)
> +#define CSI_CNT_T_TRGR_E       BIT(4)
> +#define CSI_CNT_R_TRGR_E       BIT(0)
> +
> +/* CSI_INT */
> +#define CSI_INT_UNDER          BIT(13)
> +#define CSI_INT_OVERF          BIT(12)
> +#define CSI_INT_TREND          BIT(9)
> +#define CSI_INT_CSIEND         BIT(8)
> +#define CSI_INT_T_TRGR         BIT(4)
> +#define CSI_INT_R_TRGR         BIT(0)
> +
> +/* CSI_FIFOTRG */
> +#define CSI_FIFOTRG_R_TRG       GENMASK(2, 0)
> +
> +#define CSI_FIFO_SIZE_BYTES    32
> +#define CSI_FIFO_HALF_SIZE     16
> +#define CSI_EN_DIS_TIMEOUT_US  100
> +#define CSI_CKS_MAX            0x3FFF
> +
> +#define UNDERRUN_ERROR         BIT(0)
> +#define OVERFLOW_ERROR         BIT(1)
> +#define TX_TIMEOUT_ERROR       BIT(2)
> +#define RX_TIMEOUT_ERROR       BIT(3)
> +
> +#define CSI_MAX_SPI_SCKO       8000000
> +
> +struct rzv2m_csi_priv {
> +       void __iomem *base;
> +       struct clk *csiclk;
> +       struct clk *pclk;
> +       struct device *dev;
> +       struct spi_controller *controller;
> +       const u8 *txbuf;
> +       u8 *rxbuf;
> +       int buffer_len;
> +       int bytes_sent;
> +       int bytes_received;
> +       int bytes_to_transfer;
> +       int words_to_transfer;

All these ints should be unsigned.

> +       unsigned char bytes_per_word;

3-byte gap

> +       wait_queue_head_t wait;
> +       u8 errors;

3 byte gap

> +       u32 status;
> +};

> +
> +static int rzv2m_csi_fill_txfifo(struct rzv2m_csi_priv *csi)
> +{
> +       int i;

unsigned int

> +
> +       if (readl(csi->base + CSI_OFIFOL))
> +               return -EIO;
> +
> +       if (csi->bytes_per_word == 2) {
> +               u16 *buf = (u16 *)csi->txbuf;

I think you can get rid of the casts by making rxbuf a const void *.

> +
> +               for (i = 0; i < csi->words_to_transfer; i++)
> +                       writel(buf[i], csi->base + CSI_OFIFO);
> +       } else {
> +               u8 *buf = (u8 *)csi->txbuf;
> +
> +               for (i = 0; i < csi->words_to_transfer; i++)
> +                       writel(buf[i], csi->base + CSI_OFIFO);
> +       }
> +
> +       csi->txbuf += csi->bytes_to_transfer;
> +       csi->bytes_sent += csi->bytes_to_transfer;
> +
> +       return 0;
> +}
> +
> +static int rzv2m_csi_read_rxfifo(struct rzv2m_csi_priv *csi)
> +{
> +       int i;
> +
> +       if (readl(csi->base + CSI_IFIFOL) != csi->bytes_to_transfer)
> +               return -EIO;
> +
> +       if (csi->bytes_per_word == 2) {
> +               u16 *buf = (u16 *)csi->rxbuf;

Similar for rxbuf.

> +
> +               for (i = 0; i < csi->words_to_transfer; i++)
> +                       buf[i] = (u16)readl(csi->base + CSI_IFIFO);
> +       } else {
> +               u8 *buf = (u8 *)csi->rxbuf;
> +
> +               for (i = 0; i < csi->words_to_transfer; i++)
> +                       buf[i] = (u8)readl(csi->base + CSI_IFIFO);
> +       }
> +
> +       csi->rxbuf += csi->bytes_to_transfer;
> +       csi->bytes_received += csi->bytes_to_transfer;
> +
> +       return 0;
> +}
> +
> +static inline void rzv2m_csi_calc_current_transfer(struct rzv2m_csi_priv *csi)
> +{
> +       int bytes_transferred = max_t(int, csi->bytes_received, csi->bytes_sent);
> +       int bytes_remaining = csi->buffer_len - bytes_transferred;
> +       int to_transfer;

unsigned...

> +
> +       if (csi->txbuf)
> +               /*
> +                * Leaving a little bit of headroom in the FIFOs makes it very
> +                * hard to raise an overflow error (which is only possible
> +                * when IP transmits and receives at the same time).
> +                */
> +               to_transfer = min_t(int, CSI_FIFO_HALF_SIZE, bytes_remaining);
> +       else
> +               to_transfer = min_t(int, CSI_FIFO_SIZE_BYTES, bytes_remaining);

Why min_t(int, ...)? Both values are int.

It would be better to make both unsigned, though.

> +
> +       if (csi->bytes_per_word == 2)
> +               to_transfer >>= 1;
> +
> +       /*
> +        * We can only choose a trigger level from a predefined set of values.
> +        * This will pick a value that is the greatest possible integer that's
> +        * less than or equal to the number of bytes we need to transfer.
> +        * This may result in multiple smaller transfers.
> +        */
> +       csi->words_to_transfer = x_trg_words[to_transfer - 1];
> +
> +       if (csi->bytes_per_word == 2)
> +               csi->bytes_to_transfer = csi->words_to_transfer << 1;
> +       else
> +               csi->bytes_to_transfer = csi->words_to_transfer;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
