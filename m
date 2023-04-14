Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC316E2C62
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDNWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjDNWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:12:26 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7131BE6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:12:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id dw2so28955707qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681510335; x=1684102335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cvi2dU+iitiLIxLUaeBBm5twrfEdbhX+NPaWLDCNHs=;
        b=iozAVm8E9OwWWUpS7pal0wBlnUbzmnRXSscADPh6nfp0uKtgK71AXPv5xOeJFimbf0
         F7lwLn5EavSAz3ohpnt2lwe19ruUW8P5zVPaTklXMWpo65iIKY0TqnvTkLHPfFTRL1NK
         5AZ38ay9DoMawtHv6Bt+NEI74XQmV9vMipPmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681510335; x=1684102335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Cvi2dU+iitiLIxLUaeBBm5twrfEdbhX+NPaWLDCNHs=;
        b=SYFqIO/V/sKDefPuu0JNQ+5cOKSQbLMJXV9VWVI1eRGvqTOTVofJ00bp+zne/Hdu2D
         m+8nwmQMfe8jkVAoOrmQ4WZtCCDzbwXKqFgiurclyEgenQPBLkAnwng2wMZkHJjPl35H
         oA8ad92azE5qeQG7KlUC4eKEuR3wmmSNtwcNsivgLjMcJOc0+ynu+fnVSJAPO9GAFqWC
         Ip7MAGnfbsl5Aj5rgIEjvTvl1FXD3MQREp5OSaLRuQ3TojJb/wCbW/UWB+zbwEWdFOJP
         0WwFEJqFa9kvRgvRDVtUaudI9QZJYInTtnlWxS0C2u1zX+f61XCIMPX5tYTmajwzWfYK
         2JXg==
X-Gm-Message-State: AAQBX9c77ebX00ShgabA6gCzppZQ54UzyktmrJfQ8Ok4PPA+psW6hgv/
        1jYELu/RaWk83+dCjZqEPvS92gQ7v0/eIT5tHAM=
X-Google-Smtp-Source: AKy350YgRan1xEOyyCK34eCUl2Wo3UNenDjALYg3zOT96DnEKRK+zgct+j6/YiIGC5Jqo8LJGzGGMw==
X-Received: by 2002:a05:6214:1d26:b0:5e0:63ec:5d77 with SMTP id f6-20020a0562141d2600b005e063ec5d77mr6046171qvd.35.1681510334774;
        Fri, 14 Apr 2023 15:12:14 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id ne3-20020a056214424300b005e8f61012e9sm1388082qvb.26.2023.04.14.15.12.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 15:12:14 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id m21so9930729qtg.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:12:14 -0700 (PDT)
X-Received: by 2002:a25:d10e:0:b0:b8f:3881:1638 with SMTP id
 i14-20020a25d10e000000b00b8f38811638mr3954970ybg.7.1681509970219; Fri, 14 Apr
 2023 15:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com> <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1681481153-24036-4-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Apr 2023 15:05:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
Message-ID: <CAD=FV=VKY-0vX271G+EQQ5kC3gTqpPPyTGE0xHWPBncVUhZufQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: spi-qcom-qspi: Add DMA mode support
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 14, 2023 at 7:06=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> @@ -14,7 +16,6 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>
> -

Drop unrelated whitespace change.


> @@ -108,6 +110,10 @@
>  #define RD_FIFO_RESET          0x0030
>  #define RESET_FIFO             BIT(0)
>
> +#define NEXT_DMA_DESC_ADDR             0x0040
> +#define CURRENT_DMA_DESC_ADDR  0x0044
> +#define CURRENT_MEM_ADDR               0x0048

Looking at the above with a correctly configured editor (tab size=3D8)
the numbers don't line up. The first and 3rd have one too many tabs.


> @@ -120,6 +126,27 @@ enum qspi_dir {
>         QSPI_WRITE,
>  };
>
> +struct qspi_cmd_desc {
> +       u32 data_address;
> +       u32 next_descriptor;
> +       u32 direction:1;
> +       u32 multi_io_mode:3;
> +       u32 reserved1:4;
> +       u32 fragment:1;
> +       u32 reserved2:7;
> +       u32 length:16;
> +       /*
> +        * This marks end of HW cmd descriptor
> +        * Fields down below are for SW usage to
> +        * copy data from DMA buffer to rx buffer
> +        */
> +       u8 *bounce_src;
> +       u8 *bounce_dst;
> +       u32 bounce_length;
> +};
> +
> +#define QSPI_MAX_NUM_DESC 5

Nothing uses QSPI_MAX_NUM_DESC. Drop it.


> @@ -137,11 +164,36 @@ enum qspi_clocks {
>         QSPI_NUM_CLKS
>  };
>
> +enum qspi_xfer_mode {
> +       QSPI_INVALID,
> +       QSPI_FIFO,
> +       QSPI_DMA
> +};

Why bother with INVALID? It's either FIFO or DMA, right?


> +/* number of entries in sgt returned from spi framework that we can supp=
ort */
> +#define QSPI_MAX_SG 5

Is the above a hardware limitation, or just because you are statically
allocating arrays? Please clarify in the comment. Would it make sense
to just dynamically allocate the arrays and remove the need for this
limitation?


> +/* 3 descriptors for head, aligned part and tail */
> +#define QSPI_NUM_CMD_DESC 3
> +
> +/* 2 descriptors for head, tail */
> +#define QSPI_NUM_DAT_DESC 2
> +
>  struct qcom_qspi {
>         void __iomem *base;
>         struct device *dev;
>         struct clk_bulk_data *clks;
>         struct qspi_xfer xfer;
> +       struct dma_pool *dma_cmd_pool;
> +       struct dma_pool *dma_data_pool;
> +       dma_addr_t dma_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
> +       dma_addr_t dma_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
> +       void *virt_cmd_desc[QSPI_NUM_CMD_DESC*QSPI_MAX_SG];
> +       void *virt_data_desc[QSPI_NUM_DAT_DESC*QSPI_MAX_SG];
> +       unsigned int n_cmd_desc;
> +       unsigned int n_data_desc;
> +       int xfer_mode;

Instead of "int", shouldn't xfer_mode be "enum qspi_xfer_mode"?
Although below I'm proposing that xfer_mode can just be completely
dropped from this structure.


> @@ -151,18 +203,25 @@ struct qcom_qspi {
>  static u32 qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
>                                    unsigned int buswidth)
>  {
> +       u32 ret;
> +
> +       /* for DMA we don't write to PIO_XFER_CFG register, so don't shif=
t */
>         switch (buswidth) {
>         case 1:
> -               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +               ret =3D (ctrl->xfer_mode =3D=3D QSPI_DMA ? SDR_1BIT : SDR=
_1BIT << MULTI_IO_MODE_SHFT);
> +               break;
>         case 2:
> -               return SDR_2BIT << MULTI_IO_MODE_SHFT;
> +               ret =3D (ctrl->xfer_mode =3D=3D QSPI_DMA ? SDR_2BIT : SDR=
_2BIT << MULTI_IO_MODE_SHFT);
> +               break;
>         case 4:
> -               return SDR_4BIT << MULTI_IO_MODE_SHFT;
> +               ret =3D (ctrl->xfer_mode =3D=3D QSPI_DMA ? SDR_4BIT : SDR=
_4BIT << MULTI_IO_MODE_SHFT);
> +               break;
>         default:
>                 dev_warn_once(ctrl->dev,
>                                 "Unexpected bus width: %u\n", buswidth);
> -               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +               ret =3D (ctrl->xfer_mode =3D=3D QSPI_DMA ? SDR_1BIT : SDR=
_1BIT << MULTI_IO_MODE_SHFT);
>         }
> +       return ret;

Wouldn't it be easier to do the test once at the end? In other words,
in the switch statement "ret" never contains the shift and then at the
end:

if (ctrl->xfer_mode !=3D QSPI_DMA)
  ret <<=3D MULTI_IO_MODE_SHFT;
return ret;

...or, even better, just always return the unshifted mode and do the
shifting unconditionally in qcom_qspi_pio_xfer_cfg(). Then you never
need to look at xfer_mode to decide.


> @@ -241,12 +316,16 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ct=
rl, unsigned long speed_hz)
>                 return ret;
>         }
>
> +       avg_bw_cpu =3D Bps_to_icc(speed_hz);
>         /*
> -        * Set BW quota for CPU as driver supports FIFO mode only.
> -        * We don't have explicit peak requirement so keep it equal to av=
g_bw.
> +        * Set BW quota for CPU for FIFO to avg_bw
> +        * as we don't have explicit peak requirement.
> +        * TBD TBD TBD - change this as required for DMA.
> +        * As of now same peak requirement seems to be working.
>          */
> -       avg_bw_cpu =3D Bps_to_icc(speed_hz);
> -       ret =3D icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, avg_bw=
_cpu);
> +       peak_bw_cpu =3D ctrl->xfer_mode =3D=3D QSPI_FIFO ? avg_bw_cpu : a=
vg_bw_cpu;
> +
> +       ret =3D icc_set_bw(ctrl->icc_path_cpu_to_qspi, avg_bw_cpu, peak_b=
w_cpu);

The change to this function is completely a no-op, right? You check
the mode against QSPI_FIFO but you set the "peak_bw_cpu" to the same
thing in both modes. ...and the thing you set it to is exactly the
same as the function set it to before your patch.

...so drop all the changes you made to this function.


> @@ -258,6 +337,190 @@ static int qcom_qspi_set_speed(struct qcom_qspi *ct=
rl, unsigned long speed_hz)
>         return 0;
>  }
>
> +/* aligned to 32 bytes, not to cross 1KB boundary */
> +#define QSPI_ALIGN_REQ         32
> +#define QSPI_BOUNDARY_REQ      1024
> +
> +static int qcom_qspi_alloc_desc(struct qcom_qspi *ctrl, uint8_t *virt_pt=
r,
> +                       dma_addr_t dma_ptr, uint32_t n_bytes)

Why is "n_bytes" "uint32_t" instead of just "u32"? Please just use
"u32" consistently in this file.


> +{
> +       struct qspi_cmd_desc *virt_cmd_desc, *prev;
> +       uint8_t *virt_data_desc;
> +       dma_addr_t dma_cmd_desc, dma_data_desc;
> +
> +       if (virt_ptr && n_bytes >=3D QSPI_ALIGN_REQ) {
> +               dev_err(ctrl->dev,
> +                       "Exiting to avert memory overwrite, n_bytes-%d\n"=
, n_bytes);
> +               return -ENOMEM;
> +       }
> +
> +       /* allocate for dma cmd descriptor */
> +       virt_cmd_desc =3D (struct qspi_cmd_desc *)dma_pool_alloc(ctrl->dm=
a_cmd_pool,
> +               GFP_KERNEL, &dma_cmd_desc);
> +       if (!virt_cmd_desc) {
> +               dev_err(ctrl->dev,
> +                       "Could not allocate for cmd_desc\n");
> +               return -ENOMEM;
> +       }
> +       ctrl->virt_cmd_desc[ctrl->n_cmd_desc] =3D virt_cmd_desc;
> +       ctrl->dma_cmd_desc[ctrl->n_cmd_desc] =3D dma_cmd_desc;
> +       ctrl->n_cmd_desc++;
> +
> +       /* allocate for dma data descriptor if unaligned else use pre-ali=
gned */
> +       if (virt_ptr) {
> +               virt_data_desc =3D (uint8_t *)dma_pool_zalloc(ctrl->dma_d=
ata_pool,
> +                       GFP_KERNEL, &dma_data_desc);
> +               if (!virt_data_desc) {
> +                       dev_err(ctrl->dev,
> +                               "Could not allocate for data_desc\n");
> +                       return -ENOMEM;
> +               }
> +               ctrl->virt_data_desc[ctrl->n_data_desc] =3D virt_data_des=
c;
> +               ctrl->dma_data_desc[ctrl->n_data_desc] =3D dma_data_desc;
> +               ctrl->n_data_desc++;
> +
> +               /*
> +                * for tx copy xfer data into allocated buffer
> +                * for rx setup bounce info to copy after xfer
> +                */
> +               if (ctrl->xfer.dir =3D=3D QSPI_WRITE) {
> +                       memcpy(virt_data_desc, virt_ptr, n_bytes);
> +               } else {
> +                       virt_cmd_desc->bounce_src =3D virt_data_desc;
> +                       virt_cmd_desc->bounce_dst =3D virt_ptr;
> +                       virt_cmd_desc->bounce_length =3D n_bytes;
> +               }
> +       } else {
> +               dma_data_desc =3D dma_ptr;
> +       }
> +
> +       /* setup cmd descriptor */
> +       virt_cmd_desc->data_address =3D dma_data_desc;
> +       virt_cmd_desc->next_descriptor =3D 0;
> +       virt_cmd_desc->direction =3D ctrl->xfer.dir;
> +       virt_cmd_desc->multi_io_mode =3D ctrl->iomode;
> +       virt_cmd_desc->reserved1 =3D 0;
> +       virt_cmd_desc->fragment =3D ctrl->xfer.is_last ? 0 : 1;
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
> +       uint32_t prolog_bytes, aligned_bytes, epilog_bytes;
> +       dma_addr_t aligned_addr;
> +       int i;
> +       uint8_t *byte_ptr;
> +
> +       if (ctrl->n_cmd_desc || ctrl->n_data_desc) {
> +               dev_err(ctrl->dev, "Remnant dma buffers cmd-%d, data-%d\n=
",
> +                       ctrl->n_cmd_desc, ctrl->n_data_desc);
> +               return -EIO;
> +       }
> +
> +       sgt =3D (ctrl->xfer.dir =3D=3D QSPI_READ) ? &xfer->rx_sg : &xfer-=
>tx_sg;
> +       if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
> +               dev_err(ctrl->dev, "Cannot handle %d entries in scatter l=
ist\n", sgt->nents);
> +               return -EINVAL;
> +       }
> +
> +       for (i =3D 0; i < sgt->nents; i++)
> +               sg_total_len +=3D sg_dma_len(sgt->sgl + i);
> +       if (sg_total_len !=3D xfer->len) {
> +               dev_err(ctrl->dev, "Data lengths mismatch\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ctrl->xfer.dir =3D=3D QSPI_READ)
> +               byte_ptr =3D xfer->rx_buf;
> +       else
> +               byte_ptr =3D (uint8_t *)xfer->tx_buf;
> +
> +       for (i =3D 0; i < sgt->nents; i++) {
> +               dma_ptr_sg =3D sg_dma_address(sgt->sgl + i);
> +               dma_len_sg =3D sg_dma_len(sgt->sgl + i);
> +
> +               aligned_addr =3D PTR_ALIGN(dma_ptr_sg, QSPI_ALIGN_REQ);
> +
> +               prolog_bytes =3D min(dma_len_sg, (unsigned int)(aligned_a=
ddr - dma_ptr_sg));
> +               if (prolog_bytes) {
> +                       ret =3D qcom_qspi_alloc_desc(ctrl, byte_ptr, 0, p=
rolog_bytes);
> +                       if (ret)
> +                               goto cleanup;
> +                       byte_ptr +=3D prolog_bytes;
> +               }
> +
> +               aligned_bytes =3D PTR_ALIGN_DOWN(dma_len_sg - prolog_byte=
s, QSPI_ALIGN_REQ);
> +               if (aligned_bytes) {
> +                       ret =3D qcom_qspi_alloc_desc(ctrl, 0, aligned_add=
r, aligned_bytes);
> +                       if (ret)
> +                               goto cleanup;
> +                       byte_ptr +=3D aligned_bytes;
> +               }
> +
> +               epilog_bytes =3D dma_len_sg - prolog_bytes - aligned_byte=
s;
> +               if (epilog_bytes) {
> +                       ret =3D qcom_qspi_alloc_desc(ctrl, byte_ptr, 0, e=
pilog_bytes);
> +                       if (ret)
> +                               goto cleanup;
> +                       byte_ptr +=3D epilog_bytes;

While I won't claim to be an expert on DMA, the above smells wrong to
me. It looks as if you're doing a whole lot of work here that doesn't
really belong in your driver but should be in the SPI core. If I
understand correctly, the issue is that this SPI controller needs DMA
buffers to start aligned on a 32-byte boundary. To handle that, you're
doing a whole lot of manual work to copy/bounce the bits that aren't
aligned.

Having alignment requirements like this doesn't seem like it should be
that unusual, though, and that's why it feels like the logic belongs
in the SPI core. In fact, it seems like this is _supposed_ to be
handled in the SPI core, but it isn't? In "spi.h" I see
"dma_alignment" that claims to be exactly what you need. As far as I
can tell, though, the core doesn't use this? ...so I'm kinda confused.
As far as I can tell this doesn't do anything and thus anyone setting
it today is broken?

Mark can tell me if I'm giving bad advice here, but IMO you should:

1. Set your controller's "dma_alignment" property to 32.

2. Add support to the core (in spi_map_buf() and spi_unmap_buf(), I
think) to handle the bouncing.


Other notes around this:

* In your code, I see "QSPI_BOUNDARY_REQ as 1K" which confuses me. As
far as I can tell you can do DMA that crosses 1K boundaries since (I
think) "aligned_bytes" above can be up to 64K, right?

* I haven't yet figured out why exactly you need the "epilog". Are you
sure you really do, or could this be combined with the "aligned"
chunk? I think the only requirement is that the start of the transfer
is aligned, right?

* If this is done in the core in spi_map_buf(), I think you only need
a single bounce buffer that is "dma_alignment" bytes big that you can
allocate once and store with the controller, right?


> +               }
> +       }
> +       return 0;
> +
> +cleanup:
> +       dev_err(ctrl->dev, "ERROR cleanup in setup_dma_desc\n");
> +       for (i =3D 0; i < ctrl->n_data_desc; i++)
> +               dma_pool_free(ctrl->dma_data_pool, ctrl->virt_data_desc[i=
],
> +                                 ctrl->dma_data_desc[i]);
> +       ctrl->n_data_desc =3D 0;
> +
> +       for (i =3D 0; i < ctrl->n_cmd_desc; i++)
> +               dma_pool_free(ctrl->dma_cmd_pool, ctrl->virt_cmd_desc[i],
> +                                 ctrl->dma_cmd_desc[i]);
> +       ctrl->n_cmd_desc =3D 0;
> +       return ret;
> +}
> +
> +static void qcom_qspi_dma_xfer(struct qcom_qspi *ctrl)
> +{
> +       /* Ack any previous interrupts that might be hanging around */
> +       writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_STATUS);

Do we really need the above? Maybe we can drop it and (in a separate
patch) drop the similar statement in qcom_qspi_pio_xfer()?

If this is truly needed for some reason, then it seems like in both
cases you should ack _all_ interrupts (the FIFO plus the DMA ones)
since we might be switching back and forth between the two modes and
thus any old interrupts that are "hanging around" could be from
either. ...but I think you can just drop it. If there are really any
interrupts "hanging around" we're in pretty bad shape.


> +       /* Setup new interrupts */
> +       writel(DMA_CHAIN_DONE, ctrl->base + MSTR_INT_EN);
> +
> +       /* flush all writes */
> +       wmb();

Why do you need this explicit wmb()? I'm fairly sure that this is
handled automatically by the fact that you're using writel() and not
writel_relaxed(). writel() documents that it is "ordered relative to
any prior Normal memory access" and certainly it's ordered relative to
IO writes to the same device.


> +
> +       /* kick off transfer */
> +       writel((uint32_t)(uintptr_t)(ctrl->dma_cmd_desc)[0], ctrl->base +=
 NEXT_DMA_DESC_ADDR);

It feels like there's one too many casts here. Shouldn't this just be
"(u32)(ctrl->dma_cmd_desc[0])"?


> +}
> +
> +/* Switch to DMA if transfer length exceeds this */
> +#define QSPI_MAX_BYTES_FIFO 64
> +
> +static bool qcom_qspi_can_dma(struct spi_controller *ctlr,
> +                        struct spi_device *slv, struct spi_transfer *xfe=
r)
> +{
> +       return xfer->len > QSPI_MAX_BYTES_FIFO ? true : false;

No need for the "? true : false". Just:

return xfer->len > QSPI_MAX_BYTES_FIFO;


> @@ -290,7 +555,25 @@ static int qcom_qspi_transfer_one(struct spi_master =
*master,
>         ctrl->xfer.is_last =3D list_is_last(&xfer->transfer_list,
>                                           &master->cur_msg->transfers);
>         ctrl->xfer.rem_bytes =3D xfer->len;
> -       qcom_qspi_pio_xfer(ctrl);
> +
> +       if (qcom_qspi_can_dma(master, slv, xfer)) {

Maybe it would be better to check if either "xfer->rx_sg.nents" or
"xfer->tx_sg.nents" is non-zero. That indicates that the SPI framework
is expecting you to do DMA.


> +               ctrl->xfer_mode =3D QSPI_DMA;
> +               ctrl->iomode =3D qspi_buswidth_to_iomode(ctrl, ctrl->xfer=
.buswidth);

Don't store iomode in the "ctrl" structure (remove it from that
struct). Just make it a local variable in qcom_qspi_setup_dma_desc()
and then pass it in to the one place that needs it:
qcom_qspi_alloc_desc()


> +               mstr_cfg |=3D DMA_ENABLE;
> +               writel(mstr_cfg, ctrl->base + MSTR_CONFIG);

nit: I seem to remember IO writes to the controller taking a
non-trivial amount of time. Maybe worth it to do?

if (!(mstr_cfg & DMA_ENABLE)) {
  mstr_cfg |=3D DMA_ENABLE;
  writel(mstr_cfg, ctrl->base + MSTR_CONFIG);
}

...similar for the "else" case below.


> @@ -328,6 +611,40 @@ static int qcom_qspi_prepare_message(struct spi_mast=
er *master,
>         return 0;
>  }
>
> +static int qcom_qspi_alloc_dma(struct qcom_qspi *ctrl)
> +{
> +       /* allocate for cmd descriptors pool */
> +       ctrl->dma_cmd_pool =3D dma_pool_create("qspi cmd desc pool",
> +               ctrl->dev, sizeof(struct qspi_cmd_desc), 0, 0);

Instead of dma_pool_create(), use dmam_pool_create(). That looks to be
the (oddly named) devm version of the function. Then you can fully get
rid of qcom_qspi_free_dma() and also the dma_pool_destroy() in your
error handling below.

It also seems really weird that the "data" pool has such strict
alignment requirements and you do a whole ton of work to meet those
requirements, but the "cmd" pool has no alignment requirements at all.
Is this really correct?


> +       if (!ctrl->dma_cmd_pool) {
> +               dev_err(ctrl->dev, "Could not create dma pool for cmd_des=
c\n");

nit: no need for an error message here. You can assume that allocation
failures will already print a warning splat and you don't need another
one for this incredibly unlikely event.


> @@ -426,27 +743,63 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev=
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

I don't think you really need to check xfer_mode here, do you? If
xfer_mode is FIFO then only the FIFO-related interrupts are enabled.
If xfer_mode is DMA then only the DMA-related interrupts are enabled.

In fact, I think you can fully get rid of the "xfer_mode" structure
member completely. It's completely redundant.


> @@ -487,6 +840,9 @@ static int qcom_qspi_probe(struct platform_device *pd=
ev)
>         if (ret)
>                 return ret;
>
> +       /* set default mode to FIFO */
> +       ctrl->xfer_mode =3D QSPI_FIFO;

Get rid of this initialization. Above I'm suggesting getting rid of
"xfter" mode altogether, but in any case, we should be setting this
before each transfer so the initialization doesn't do anything useful.


> @@ -556,10 +923,15 @@ static int qcom_qspi_probe(struct platform_device *=
pdev)
>  static void qcom_qspi_remove(struct platform_device *pdev)
>  {
>         struct spi_master *master =3D platform_get_drvdata(pdev);
> +       struct qcom_qspi *ctrl;
> +
> +       ctrl =3D spi_master_get_devdata(master);
>
>         /* Unregister _before_ disabling pm_runtime() so we stop transfer=
s */
>         spi_unregister_master(master);
>
> +       qcom_qspi_free_dma(ctrl);
> +
>         pm_runtime_disable(&pdev->dev);

To make this the reverse order of probe the qcom_qspi_free_dma() call
should be _after_ the pm_runtime_disable(), although above I'm
suggesting fully getting rid of qcom_qspi_free_dma() so maybe the
point is moot.
