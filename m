Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB736D6E40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjDDUpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDDUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:45:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761D44A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 13:45:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a44so16615606ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680641126;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8me2c8RpT+Py8cOFPX0SAcc5NRBfZ3o5bnDzUrcRKT4=;
        b=EDhxdLeWoIQbK0Wbx73MtpraHTB0UjxhG73gt2RsbOt3ve1kM8mQjkjfNUoBIohcr5
         9NUHTKNquhBkePsnybR3xuIJ9ze3SV0OYWrC6NWPjXQhDnHvZz8bjxyyPk+xXpT9XS3z
         5N1dxbZCaEmmHzy8Nw/2iKkSjGFVpmy9Jy5/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680641126;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8me2c8RpT+Py8cOFPX0SAcc5NRBfZ3o5bnDzUrcRKT4=;
        b=LbFjWmZHPZS9/9BCei7jgJnYjDplgpSlZHpH5zUmE3jgvDAaGd7bVkEEJ/WKsFBpK2
         kHK/RCAzl2A261UeeirygMhCwpGGYA9kJBt/WvbuGIdY9Q5HmQl5mZQqYehumXOJDIl9
         6eUM5/40cM79QBWzx+0kVvy/JFWJMFFRoOWa5L2MfRhuWOqwT13R+35Xa6EdaD7eaBXC
         lP7dJt5TOccIc5HQsAEgVBM6O36TOLBbILhDOEs7mx216VYXrUisSC2N6KivaeulVItB
         mzoDt6ZSNSLDCcEa3z3bEkyNLJ/694//YB7AqRfASgH7VtyO6SNVpvDzFFOpm1cSIKgW
         2/aw==
X-Gm-Message-State: AAQBX9cYVxOLp+aSxnjE7sNQYdU1GpgejXjwILjJTGzpCtyw98otqahc
        O5M/jJU+zE8MibYMPNbOC9JqTXUl59D2OyJDHEXcdQ==
X-Google-Smtp-Source: AKy350Ycq+5EIjsBx44MXA4L3Z8L5TrEdWnhRJSBAvaQcuPjbYy0/v/yuOgmRlTFRvbUpfqkOPFBMR9KTqC3nbb8oz0=
X-Received: by 2002:a2e:9e4f:0:b0:299:aa7a:94c8 with SMTP id
 g15-20020a2e9e4f000000b00299aa7a94c8mr1420786ljk.10.1680641126406; Tue, 04
 Apr 2023 13:45:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Apr 2023 13:45:25 -0700
MIME-Version: 1.0
In-Reply-To: <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
References: <1680631400-28865-1-git-send-email-quic_vnivarth@quicinc.com> <1680631400-28865-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 4 Apr 2023 13:45:25 -0700
Message-ID: <CAE-0n53zOKQ+MwNP9nkse2hO4xfxC6T8tRJ0h_vB3gMibC_=Ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-qcom-qspi: Add DMA mode support
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, vkoul@kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijaya Krishna Nivarthi (2023-04-04 11:03:20)
> For performance improvement in terms of number of interrupts.
> Code flow for DMA mode...
> Allocate for DMA pools in probe()
> For xfers with len > 64 bytes, return true from can_dma()
> Thus framework creates and maps an sg table for each xfer buffer.
> In transfer_one() enable DMA in MSTR_CONFIG.
> Split the dma buffer of each entry of sgt into a maximum of 3 parts...
> Unaligned head, aligned middle and tail.
> For each part create a dma_cmd_descriptor.
> For head and tail allocate dma_data_descriptors
>   For tx, copy the data into allocated data descriptors
>   For rx, remember the original buffers to copy from-
>   allocated descriptors after xfer is complete
> For middle part use the aligned dma buffer.
> Link each dma_cmd_descriptor to next.
> Thus create a chain of descriptors.
> Kick-off the xfer by copying 1st cmd descriptor to-
> NEXT_DMA_DESC_ADDR register.
> On receiving DMA_CHAIN_DONE interrupt, complete the xfer and-
> free descriptors.
> If timeout happens handle error by freeing descriptors.
> In remove() free DMA pools.
>

Write a real commit text, and not psuedo-code for the patch. It should
sell us on wanting to review the patch, and help us understand the
importance of the change. The "how" comes from reading the patch
and code itself.

> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 429 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 398 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index fab1553..64c3bec 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -13,7 +13,8 @@
>  #include <linux/pm_opp.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
> -
> +#include <linux/dmapool.h>
> +#include <linux/dma-mapping.h>

Sort this alphabetically like all the other headers here.

>
>  #define QSPI_NUM_CS            2
>  #define QSPI_BYTES_PER_WORD    4
> @@ -62,6 +63,7 @@
>  #define WR_FIFO_FULL           BIT(10)
>  #define WR_FIFO_OVERRUN                BIT(11)
>  #define TRANSACTION_DONE       BIT(16)
> +#define DMA_CHAIN_DONE         BIT(31)
>  #define QSPI_ERR_IRQS          (RESP_FIFO_UNDERRUN | HRESP_FROM_NOC_ERR | \
>                                  WR_FIFO_OVERRUN)
>  #define QSPI_ALL_IRQS          (QSPI_ERR_IRQS | RESP_FIFO_RDY | \
> @@ -108,6 +110,10 @@
>  #define RD_FIFO_RESET          0x0030
>  #define RESET_FIFO             BIT(0)
>
> +#define NEXT_DMA_DESC_ADDR             0x0040
> +#define CURRENT_DMA_DESC_ADDR  0x0044
> +#define CURRENT_MEM_ADDR               0x0048
> +
>  #define CUR_MEM_ADDR           0x0048
>  #define HW_VERSION             0x004c
>  #define RD_FIFO                        0x0050
> @@ -120,6 +126,22 @@ enum qspi_dir {
>         QSPI_WRITE,
>  };
>
> +struct qspi_cmd_desc {
> +       uint32_t data_address;

Use u32/u8 instead of uint32_t/uint8_t

> +       uint32_t next_descriptor;
> +       uint32_t direction:1;
> +       uint32_t multi_io_mode:3;
> +       uint32_t reserved1:4;
> +       uint32_t fragment:1;
> +       uint32_t reserved2:7;
> +       uint32_t length:16;
> +       //------------------------//
> +       uint8_t *bounce_src;
> +       uint8_t *bounce_dst;
> +       uint32_t bounce_length;
> +};
> +
> +#define QSPI_MAX_NUM_DESC 5
>  struct qspi_xfer {
>         union {
>                 const void *tx_buf;
> @@ -137,11 +159,30 @@ enum qspi_clocks {
>         QSPI_NUM_CLKS
>  };
>
> +enum qspi_xfer_mode {
> +       QSPI_INVALID,
> +       QSPI_FIFO,
> +       QSPI_DMA
> +};
> +
> +/* number of entries in sgt returned from spi framework that we can support */
> +#define QSPI_QCOM_MAX_SG 5
> +
>  struct qcom_qspi {
>         void __iomem *base;
>         struct device *dev;
>         struct clk_bulk_data *clks;
>         struct qspi_xfer xfer;
> +       struct dma_pool *dma_cmd_pool;
> +       struct dma_pool *dma_data_pool;
> +       dma_addr_t dma_cmd_desc[3*QSPI_QCOM_MAX_SG];

Make a define for 3 and 2 and then a define for each equation?

> +       dma_addr_t dma_data_desc[2*QSPI_QCOM_MAX_SG];
> +       void *virt_cmd_desc[3*QSPI_QCOM_MAX_SG];
> +       void *virt_data_desc[2*QSPI_QCOM_MAX_SG];
> +       unsigned int n_cmd_desc;
> +       unsigned int n_data_desc;
> +       int xfer_mode;
> +       u32 iomode;

Good use of u32

>         struct icc_path *icc_path_cpu_to_qspi;
>         unsigned long last_speed;
>         /* Lock to protect data accessed by IRQs */
> @@ -258,6 +326,186 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ctrl, unsigned long speed_hz)
>         return 0;
>  }
>
> +/* aligned to 32 bytes, not to cross 1KB boundary */
> +#define QSPI_ALIGN_REQ         32
> +#define QSPI_BOUNDARY_REQ      1024
> +
> +int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_ptr,
> +                       dma_addr_t dma_ptr, uint32_t n_bytes)
> +{
> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
> +       uint8_t *virt_data_desc;
> +       dma_addr_t dma_cmd_desc, dma_data_desc;
> +
> +       if (virt_ptr && n_bytes >= QSPI_ALIGN_REQ) {
> +               dev_err(ctrl->dev,
> +                       "Exiting to avert memory overwrite, n_bytes-%d\n", n_bytes);
> +               return -ENOMEM;
> +       }
> +
> +       /* allocate for dma cmd descriptor */
> +       virt_cmd_desc = (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dma_cmd_pool,
> +               GFP_KERNEL, &dma_cmd_desc);
> +       if (!virt_cmd_desc) {
> +               dev_err(ctrl->dev,
> +                       "Could not allocate for cmd_desc\n");
> +               return -ENOMEM;
> +       }
> +       ctrl->virt_cmd_desc[ctrl->n_cmd_desc] = virt_cmd_desc;
> +       ctrl->dma_cmd_desc[ctrl->n_cmd_desc] = dma_cmd_desc;
> +       ctrl->n_cmd_desc++;
> +
> +       /* allocate for dma data descriptor if unaligned else use pre-aligned */
> +       if (virt_ptr) {
> +               virt_data_desc = (uint8_t *)dma_pool_zalloc(ctrl->dma_data_pool,
> +                       GFP_KERNEL, &dma_data_desc);
> +               if (!virt_data_desc) {
> +                       dev_err(ctrl->dev,
> +                               "Could not allocate for data_desc\n");
> +                       return -ENOMEM;
> +               }
> +               ctrl->virt_data_desc[ctrl->n_data_desc] = virt_data_desc;
> +               ctrl->dma_data_desc[ctrl->n_data_desc] = dma_data_desc;
> +               ctrl->n_data_desc++;
> +
> +               /*
> +                * for tx copy xfer data into allocated buffer
> +                * for rx setup bounce info to copy after xfer
> +                */
> +               if (ctrl->xfer.dir == QSPI_WRITE) {
> +                       memcpy(virt_data_desc, virt_ptr, n_bytes);
> +               } else {
> +                       virt_cmd_desc->bounce_src = virt_data_desc;
> +                       virt_cmd_desc->bounce_dst = virt_ptr;
> +                       virt_cmd_desc->bounce_length = n_bytes;
> +               }
> +       } else {
> +               dma_data_desc = dma_ptr;
> +       }
> +
> +       /* setup cmd descriptor */
> +       virt_cmd_desc->data_address = (uint32_t)(uintptr_t)(dma_data_desc);

Why does this need to be casted?

> +       virt_cmd_desc->next_descriptor = 0;
> +       virt_cmd_desc->direction = ctrl->xfer.dir;
> +       virt_cmd_desc->multi_io_mode = ctrl->iomode;
> +       virt_cmd_desc->reserved1 = 0;
> +       virt_cmd_desc->fragment = 0;
> +       virt_cmd_desc->reserved2 = 0;
> +       virt_cmd_desc->length = n_bytes;
> +
> +       /* update previous descriptor */
> +       if (ctrl->n_cmd_desc >= 2) {
> +               prev = (ctrl->virt_cmd_desc)[ctrl->n_cmd_desc - 2];
> +               prev->next_descriptor = dma_cmd_desc;
> +               prev->fragment = 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
> +                               struct spi_transfer *xfer)
> +{
> +       int ret;
> +       struct sg_table *sgt;
> +       unsigned int sg_total_len = 0;
> +       dma_addr_t dma_ptr_sg;
> +       unsigned int dma_len_sg;
> +       uint32_t prolog_bytes, aligned_bytes, epilog_bytes;
> +       dma_addr_t aligned_ptr;

Don't put types in the variable name.

> +       int ii;

Why double i?

> +       uint8_t *byte_ptr;
> +
> +       if (ctrl->n_cmd_desc || ctrl->n_data_desc) {
> +               dev_err(ctrl->dev, "Remnant dma buffers cmd-%d, data-%d\n",
> +                       ctrl->n_cmd_desc, ctrl->n_data_desc);
> +               return -EIO;
> +       }
> +
> +       sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
> +       if (!sgt->nents || sgt->nents > QSPI_QCOM_MAX_SG) {
> +               dev_err(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
