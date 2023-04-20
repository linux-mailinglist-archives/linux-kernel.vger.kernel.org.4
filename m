Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4757A6E9A84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjDTRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjDTRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:20:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12F4ECE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:19:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id j15so2670874ybl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682011156; x=1684603156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9sg0JiAMa7Mt8FAozcEUBataC+98aRjbjSpG582JJA=;
        b=QwBzvlS+ts8aSAl5eOdXFyG3uspGiqhOWmcI4L5lwLJQ2mSug8ESbLZCPnFM6UrE+0
         /sshig82zkuXPYFvS5bRjs7eYBKmev5x9sq5r8YoiS++fT00KNoLG1K8aWvOY99CMblZ
         VmhV6srZ1NXstjZF/B6cYLi2mjyxDm5c/NAes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011156; x=1684603156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9sg0JiAMa7Mt8FAozcEUBataC+98aRjbjSpG582JJA=;
        b=cVcvpmeXy3zm4pVEF1RrZgs4TV4DV9BV9tWs8bhZojZoHz16Nxp7y8AA42LMmKRyYi
         2s49RHZoB4r/Fsur8TI/DKaRHOARL2Lr6A1d6gkoX0sg6nZO1AfYuP6c4rMafqHdJ1BB
         tGZMlcT0O4BGK0by7mSn1FRmU1aJorSSxAmN7nOHvSOY+ZER8NgjIJ+Xr56GZeXpzVar
         EEtz+UQrwQ1MiJ7bMg+PU2AVgLHU1AYVxX4AN29qW+WEIpsIsxDPF7lSPmnOSoZ6MkGD
         i0h2rguMn7aRHgx6gE0uPe4FekOn6AhIhG2H9aOijCijoUZVGmCIi3g43rnld8dhF53x
         lSXQ==
X-Gm-Message-State: AAQBX9dG3yKder9uOQXFkEguiuBmg+1PZYPNXbX4OE6mOctx2lTHka+Z
        CmOvXUc0ZO/Fygb/NOZ3wfKyJUG/SgYSFnNhZrk=
X-Google-Smtp-Source: AKy350YUFlueklsN7iqyJBHcaoyCPHHeOQ1GLYY9X0dZwqdoiYW8yAZxr/dgMyqBFNc+2oOr0zEFxg==
X-Received: by 2002:a25:e710:0:b0:b96:29d0:dc3c with SMTP id e16-20020a25e710000000b00b9629d0dc3cmr2127733ybh.25.1682011156072;
        Thu, 20 Apr 2023 10:19:16 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id j6-20020a5b0686000000b00b8f3b826e58sm412126ybq.19.2023.04.20.10.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:19:14 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id u13so2738948ybu.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:19:14 -0700 (PDT)
X-Received: by 2002:a25:d797:0:b0:b8f:557f:f8f1 with SMTP id
 o145-20020a25d797000000b00b8f557ff8f1mr1132306ybg.0.1682011153798; Thu, 20
 Apr 2023 10:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <1681996394-13099-1-git-send-email-quic_vnivarth@quicinc.com> <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681996394-13099-6-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Apr 2023 10:19:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com>
Message-ID: <CAD=FV=VU9Zdk2wz=90cjmuBWxaVz9w+UxzrTtW_ny-jrwVLV3w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-qcom-qspi: Add DMA mode support
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        mka@chromium.org, swboyd@chromium.org, quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 20, 2023 at 6:13=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -137,11 +155,29 @@ enum qspi_clocks {
>         QSPI_NUM_CLKS
>  };
>
> +enum qspi_xfer_mode {
> +       QSPI_FIFO,
> +       QSPI_DMA
> +};
> +
> +/*
> + * Number of entries in sgt returned from spi framework that-
> + * will be supported. Can be modified as required.
> + * In practice, given max_dma_len is 64KB, the number of
> + * entries is not expected to exceed 1.
> + */
> +#define QSPI_MAX_SG 5

I actually wonder if this would be more nicely done just using a
linked list, which naturally mirrors how SGs work anyway. You'd add
"struct list_head" to the end of "struct qspi_cmd_desc" and just store
a pointer to the head in "struct qcom_qspi".

For freeing, you can always get back the "virtual" address because
it's just the address of each node. You can always get back the
physical address because it's stored in "data_address".


> @@ -223,6 +261,16 @@ static void qcom_qspi_handle_err(struct spi_master *=
master,
>         spin_lock_irqsave(&ctrl->lock, flags);
>         writel(0, ctrl->base + MSTR_INT_EN);

Can you also clear all interrupts here? That will make sure that if
the interrupt somehow fires after you run that it will detect that
there's nothing to do.


>         ctrl->xfer.rem_bytes =3D 0;
> +
> +       if (ctrl->xfer_mode =3D=3D QSPI_DMA) {
> +               int i;
> +
> +               /* free cmd descriptors */
> +               for (i =3D 0; i < ctrl->n_cmd_desc; i++)
> +                       dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_=
desc[i],
> +                                         ctrl->dma_cmd_desc[i]);
> +               ctrl->n_cmd_desc =3D 0;
> +       }

Instead of checking for ctrl->xfer_mode, why not just check for
ctrl->n_cmd_desc? Then you can get rid of "ctrl->xfer_mode".


> @@ -258,6 +306,120 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ct=
rl, unsigned long speed_hz)
>         return 0;
>  }
>
> +#define QSPI_ALIGN_REQ 32

nit: put this at the top of the file with other #defines.


> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, dma_addr_t dma_p=
tr,
> +                       uint32_t n_bytes)
> +{
> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
> +       dma_addr_t dma_cmd_desc;
> +
> +       /* allocate for dma cmd descriptor */
> +       virt_cmd_desc =3D (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dm=
a_cmd_pool,
> +               GFP_KERNEL, &dma_cmd_desc);

Remove unnecessary cast; "void *" assigns fine w/out a cast.

Add "| GFP_ZERO" and then get rid of the need to clear the "reserved"
and "next_descriptor" stuff below.


> +       if (!virt_cmd_desc) {
> +               dev_err(ctrl->dev,
> +                       "Could not allocate for cmd_desc\n");
> +               return -ENOMEM;
> +       }

You never need to add an extra message for allocation failures (they
already splat). Remove it.


> +       ctrl->virt_cmd_desc[ctrl->n_cmd_desc] =3D virt_cmd_desc;
> +       ctrl->dma_cmd_desc[ctrl->n_cmd_desc] =3D dma_cmd_desc;
> +       ctrl->n_cmd_desc++;
> +
> +       /* setup cmd descriptor */
> +       virt_cmd_desc->data_address =3D dma_ptr;
> +       virt_cmd_desc->next_descriptor =3D 0;
> +       virt_cmd_desc->direction =3D ctrl->xfer.dir;
> +       virt_cmd_desc->multi_io_mode =3D qspi_buswidth_to_iomode(ctrl, ct=
rl->xfer.buswidth);
> +       virt_cmd_desc->reserved1 =3D 0;
> +       virt_cmd_desc->fragment =3D ctrl->xfer.is_last ? 0 : 1;

virt_cmd_desc->fragment =3D !ctrl->xfer.is_last;


> +       virt_cmd_desc->reserved2 =3D 0;
> +       virt_cmd_desc->length =3D n_bytes;
> +
> +       /* update previous descriptor */
> +       if (ctrl->n_cmd_desc >=3D 2) {
> +               prev =3D (ctrl->virt_cmd_desc)[ctrl->n_cmd_desc - 2];
> +               prev->next_descriptor =3D dma_cmd_desc;
> +               prev->fragment =3D 1;
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
> +       unsigned int sg_total_len =3D 0;
> +       dma_addr_t dma_ptr_sg;
> +       unsigned int dma_len_sg;
> +       int i;
> +
> +       if (ctrl->n_cmd_desc) {
> +               dev_err(ctrl->dev, "Remnant dma buffers n_cmd_desc-%d\n",=
 ctrl->n_cmd_desc);
> +               return -EIO;
> +       }
> +
> +       sgt =3D (ctrl->xfer.dir =3D=3D QSPI_READ) ? &xfer->rx_sg : &xfer-=
>tx_sg;
> +       if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
> +               dev_err(ctrl->dev, "Cannot handle %d entries in scatter l=
ist\n", sgt->nents);
> +               return -EAGAIN;

If you're retrying, don't use "dev_err" but instead "dev_warn".
Similar in other places.


> +       }
> +
> +       for (i =3D 0; i < sgt->nents; i++) {
> +               dma_ptr_sg =3D sg_dma_address(sgt->sgl + i);
> +               if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
> +                       dev_err(ctrl->dev, "dma address-%pad not aligned =
to %d\n",
> +                               &dma_ptr_sg, QSPI_ALIGN_REQ);

In general it's not good practice to put pointer values into the error
log as it can be an attack vector. Probably the %p will be replaced
with something bogus anyway, but it'll look weird.


> +                       return -EAGAIN;
> +               }
> +               sg_total_len +=3D sg_dma_len(sgt->sgl + i);
> +       }
> +
> +       if (sg_total_len !=3D xfer->len) {
> +               dev_err(ctrl->dev, "Data lengths mismatch\n");
> +               return -EAGAIN;
> +       }

This feels like overly defensive programming. The SPI framework is
what's in charge of setting up the scatter gather lists and it can be
trusted to give you something where the total transfer length matches.
IMO, drop that validation. I'm OK w/ keeping the double-check of the
alignment since that's handled by the client drivers and they are less
trustworthy.


> +
> +       for (i =3D 0; i < sgt->nents; i++) {
> +               dma_ptr_sg =3D sg_dma_address(sgt->sgl + i);
> +               dma_len_sg =3D sg_dma_len(sgt->sgl + i);
> +
> +               ret =3D qcom_qspi_alloc_desc(ctrl, dma_ptr_sg, dma_len_sg=
);
> +               if (ret)
> +                       goto cleanup;
> +       }
> +       return 0;
> +
> +cleanup:
> +       dev_err(ctrl->dev, "ERROR cleanup in setup_dma_desc\n");

Drop above print--we should have already printed any relevant errors.


> @@ -290,8 +454,37 @@ static int qcom_qspi_transfer_one(struct spi_master =
*master,
>         ctrl->xfer.is_last =3D list_is_last(&xfer->transfer_list,
>                                           &master->cur_msg->transfers);
>         ctrl->xfer.rem_bytes =3D xfer->len;
> +
> +       if (xfer->rx_sg.nents || xfer->tx_sg.nents) {
> +               /* do DMA transfer */
> +               ctrl->xfer_mode =3D QSPI_DMA;
> +               if (!(mstr_cfg & DMA_ENABLE)) {
> +                       mstr_cfg |=3D DMA_ENABLE;
> +                       writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
> +               }
> +
> +               ret =3D qcom_qspi_setup_dma_desc(ctrl, xfer);
> +               if (ret) {
> +                       if (ret =3D=3D -EAGAIN) {
> +                               dev_err_once(ctrl->dev, "DMA failure, fal=
ling back to PIO");
> +                               goto do_pio;
> +                       }
> +                       spin_unlock_irqrestore(&ctrl->lock, flags);
> +                       return ret;
> +               }
> +               qcom_qspi_dma_xfer(ctrl);
> +               goto end;
> +       }
> +
> +do_pio:

A bit nitty, but the "do_pio" label feels like a slight stretch from
what I consider the acceptable uses of "goto". Maybe it's better to
avoid it? The "end" label is OK w/ me, though usually I see it called
"exit". AKA:

  ...
  ret =3D qcom_qspi_setup_dma_desc(ctrl, xfer);
  if (ret !=3D -EAGAIN) {
    if (!ret)
      qcom_qspi_dma_xfer(ctrl);
    goto exit;
  }
  dev_warn_once(...);
  ret =3D 0; /* We'll retry w/ PIO */
}

...
...

exit:
  spin_unlock_irqrestore(&ctrl->lock, flags);

  if (ret)
    return ret;

  /* We'll call spi_finalize_current_transfer() when done */
  return 1;


> @@ -328,6 +521,17 @@ static int qcom_qspi_prepare_message(struct spi_mast=
er *master,
>         return 0;
>  }
>
> +static int qcom_qspi_alloc_dma(struct qcom_qspi *ctrl)
> +{
> +       /* allocate for cmd descriptors pool */

The above comment doesn't add much. Drop?


> @@ -426,27 +630,48 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev=
_id)
>         int_status =3D readl(ctrl->base + MSTR_INT_STATUS);
>         writel(int_status, ctrl->base + MSTR_INT_STATUS);
>
> -       if (ctrl->xfer.dir =3D=3D QSPI_WRITE) {
> -               if (int_status & WR_FIFO_EMPTY)
> -                       ret =3D pio_write(ctrl);
> -       } else {
> -               if (int_status & RESP_FIFO_RDY)
> -                       ret =3D pio_read(ctrl);
> -       }
> -
> -       if (int_status & QSPI_ERR_IRQS) {
> -               if (int_status & RESP_FIFO_UNDERRUN)
> -                       dev_err(ctrl->dev, "IRQ error: FIFO underrun\n");
> -               if (int_status & WR_FIFO_OVERRUN)
> -                       dev_err(ctrl->dev, "IRQ error: FIFO overrun\n");
> -               if (int_status & HRESP_FROM_NOC_ERR)
> -                       dev_err(ctrl->dev, "IRQ error: NOC response error=
\n");
> -               ret =3D IRQ_HANDLED;
> -       }
> -
> -       if (!ctrl->xfer.rem_bytes) {
> -               writel(0, ctrl->base + MSTR_INT_EN);
> -               spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev))=
;
> +       switch (ctrl->xfer_mode) {
> +       case QSPI_FIFO:
> +               if (ctrl->xfer.dir =3D=3D QSPI_WRITE) {
> +                       if (int_status & WR_FIFO_EMPTY)
> +                               ret =3D pio_write(ctrl);
> +               } else {
> +                       if (int_status & RESP_FIFO_RDY)
> +                               ret =3D pio_read(ctrl);
> +               }
> +
> +               if (int_status & QSPI_ERR_IRQS) {
> +                       if (int_status & RESP_FIFO_UNDERRUN)
> +                               dev_err(ctrl->dev, "IRQ error: FIFO under=
run\n");
> +                       if (int_status & WR_FIFO_OVERRUN)
> +                               dev_err(ctrl->dev, "IRQ error: FIFO overr=
un\n");
> +                       if (int_status & HRESP_FROM_NOC_ERR)
> +                               dev_err(ctrl->dev, "IRQ error: NOC respon=
se error\n");
> +                       ret =3D IRQ_HANDLED;
> +               }
> +
> +               if (!ctrl->xfer.rem_bytes) {
> +                       writel(0, ctrl->base + MSTR_INT_EN);
> +                       spi_finalize_current_transfer(dev_get_drvdata(ctr=
l->dev));
> +               }
> +               break;
> +       case QSPI_DMA:
> +               if (int_status & DMA_CHAIN_DONE) {
> +                       int i;
> +
> +                       writel(0, ctrl->base + MSTR_INT_EN);
> +
> +                       for (i =3D 0; i < ctrl->n_cmd_desc; i++)
> +                               dma_pool_free(ctrl->dma_cmd_pool, ctrl->v=
irt_cmd_desc[i],
> +                                                 ctrl->dma_cmd_desc[i]);
> +                       ctrl->n_cmd_desc =3D 0;
> +
> +                       ret =3D IRQ_HANDLED;
> +                       spi_finalize_current_transfer(dev_get_drvdata(ctr=
l->dev));
> +               }
> +               break;
> +       default:
> +               dev_err(ctrl->dev, "Unknown xfer mode:%d", ctrl->xfer_mod=
e);

I'm still of the opinion that you should drop xfer_mode, which means
deleting it from above.


> @@ -517,7 +742,14 @@ static int qcom_qspi_probe(struct platform_device *p=
dev)
>                 return ret;
>         }
>
> +       ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +       if (ret)
> +               return dev_err_probe(dev, ret, "could not set DMA mask\n"=
);
> +
>         master->max_speed_hz =3D 300000000;
> +       master->max_dma_len =3D 65536; /* as per HPG */
> +       /* intimate protocal drivers about alignment requirement */

Comment above doesn't add much and is already in the comment in the
definition of the structure. Drop it.


> +       master->dma_alignment =3D QSPI_ALIGN_REQ;
>         master->num_chipselect =3D QSPI_NUM_CS;
>         master->bus_num =3D -1;
>         master->dev.of_node =3D pdev->dev.of_node;
> @@ -528,6 +760,7 @@ static int qcom_qspi_probe(struct platform_device *pd=
ev)
>         master->prepare_message =3D qcom_qspi_prepare_message;
>         master->transfer_one =3D qcom_qspi_transfer_one;
>         master->handle_err =3D qcom_qspi_handle_err;
> +       master->can_dma =3D qcom_qspi_can_dma;
>         master->auto_runtime_pm =3D true;
>
>         ret =3D devm_pm_opp_set_clkname(&pdev->dev, "core");
> @@ -540,6 +773,11 @@ static int qcom_qspi_probe(struct platform_device *p=
dev)
>                 return ret;
>         }
>
> +       /* allocate for DMA descriptor pools */

Above comment is obvious from the name of the function you're calling.
