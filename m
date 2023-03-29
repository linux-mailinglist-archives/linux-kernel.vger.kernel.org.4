Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444D6CD0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC2D5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjC2D5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:57:04 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CF3A8F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:56:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id cf7so17800836ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680062219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ao2+adQnR6/po/E00/h2Hap8rN3GiJWX7nV/sFbf/k=;
        b=g3HWh7TIfO1AsxRD5Lo1r1xRuSLxWc/2B9BbHSCe/vkMc2KWAMnOoSzMlkYUcG5Par
         TOldYTyCKgMiIA//gOVSW2FpeMgjNzlae8qxIgd51GKa035K4Fy7ZRNDyTiqGmvskrUV
         0eNm3E5alaTM7jVNkTKDnZtRyCRa91i/h5yPF51CIbX38iM0fBSpLoFwm0zGuiVZxfYt
         EL+eenE/EOJljjcmZaG1IUPy2cBQ2lEiVPhrEO9iq7xaH63aealcC+EHgUgjcTCUFoLJ
         PWDU2ZIEmc/Ir/hruOMUwp433yMpHx8a76uh5RgQlYE1lQRAuS1oqfXCFStt5fRrW8rG
         El/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680062219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ao2+adQnR6/po/E00/h2Hap8rN3GiJWX7nV/sFbf/k=;
        b=m0fMzkzwMnP5MNxWqKotU35lxYhCM8a0wIkHTEgyEm6aFRdlqNfg7w/Jlpu/vg7Qty
         kOVWtXZ0AM+ji1sigucbd21MFVQ85E1YmqQJlSDN6FeWXTErxabVMeFJUOwGnPUra/Am
         4ji5aMOh1pRA//0TpY4x9G+2J0kNUD8eDRUnbWlMGRoX3p7iPK5LiWl6G47FkSHRgBnR
         5cyO+gEGXcOp2EoRl/CYMfl906HKWkxhS3XrppM81+uh1d1TDky8eWKTGyh6vONFVVwc
         DSWCoFZFxp4ppT4nFR1Z1Xho6EaIAqtHE0ZQG15oTDh8eu496Z23cIjWoK8FGoKasjJc
         42+Q==
X-Gm-Message-State: AAQBX9cqvxBL+n5Sw+e78DD3ZjCcYJp2Vy6f578NucPHZ5I1uRMFiyrW
        olAH9HJ9kJoybudJsoMLkLNh63C4SYsnvzgul39JNg==
X-Google-Smtp-Source: AKy350Zhit2F5VO/z/xZyBcGuBBBbw4hkgqbhERv+PcdEqWJ934Geek4oudvFSIJ6WtOEEWLLxZ+w8I3cR8nmIQHArY=
X-Received: by 2002:a25:d7ce:0:b0:b7d:e643:d3c3 with SMTP id
 o197-20020a25d7ce000000b00b7de643d3c3mr2138538ybg.8.1680062218889; Tue, 28
 Mar 2023 20:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230327043405.881645-1-joychakr@google.com> <20230327043405.881645-3-joychakr@google.com>
 <20230328180338.bpxvjwx4tn4ter3f@mobilestation>
In-Reply-To: <20230328180338.bpxvjwx4tn4ter3f@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Wed, 29 Mar 2023 09:26:47 +0530
Message-ID: <CAOSNQF3r+6Oz=chnA94=4q7pugGFKm2W09ry+pS2F0oe1HZmcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] spi: dw: Add dma controller capability checks
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge(y),

On Tue, Mar 28, 2023 at 11:33=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Mon, Mar 27, 2023 at 04:34:05AM +0000, Joy Chakraborty wrote:
> > Check capabilities of DMA controller during init to make sure it is
> > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > and store addr_width capabilities to check per transfer to make sure th=
e
> > bits/word requirement can be met for that transfer.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  drivers/spi/spi-dw-dma.c | 54 ++++++++++++++++++++++++++++++++--------
> >  drivers/spi/spi-dw.h     |  1 +
> >  2 files changed, 44 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index b3a88bb75907..f47483ec369f 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -23,6 +23,8 @@
> >  #define DW_SPI_TX_BUSY               1
> >  #define DW_SPI_TX_BURST_LEVEL        16
> >
> > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> > +
> >  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
> >  {
> >       struct dw_dma_slave *s =3D param;
> > @@ -72,12 +74,15 @@ static void dw_spi_dma_maxburst_init(struct dw_spi =
*dws)
> >       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
> >  }
> >
> > -static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
> > +static int dw_spi_dma_caps_init(struct dw_spi *dws)
> >  {
>
> > +     int ret;
> >       struct dma_slave_caps tx =3D {0}, rx =3D {0};
>
> 1. Preserve the reverse xmas tree order please (driver local convention).
> 2. The zero-initialization can be dropped since the function will halt
> on further procedures if any of the dma_get_slave_caps() calls fail.
> Meanwhile if all of them are successfully executed the capability
> structures will be sanely initialized.
>

Sure, will update

> >
> > -     dma_get_slave_caps(dws->txchan, &tx);
> > -     dma_get_slave_caps(dws->rxchan, &rx);
>
> > +     ret =3D dma_get_slave_caps(dws->txchan, &tx);
>         if (ret)
>                 return ret;
> < newline
> > +     ret |=3D dma_get_slave_caps(dws->rxchan, &rx);
> > +     if (ret)
> > +             return ret;
>
> No OR-ing the errnos please. They aren't bitfields.

Sure, I will update this.
In this case do you think we need an error print here to differentiate
which slave caps failed ?

>
> >
> >       if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
> >               dws->dma_sg_burst =3D min(tx.max_sg_burst, rx.max_sg_burs=
t);
> > @@ -87,6 +92,18 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *=
dws)
> >               dws->dma_sg_burst =3D rx.max_sg_burst;
> >       else
> >               dws->dma_sg_burst =3D 0;
> > +
> > +     /*
> > +      * Assuming both channels belong to the same DMA controller hence=
 the
> > +      * address width capabilities most likely would be the same.
> > +      */
> > +     dws->dma_addr_widths =3D tx.dst_addr_widths & rx.src_addr_widths;
> > +
>
> > +     if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > +           rx.directions & BIT(DMA_DEV_TO_MEM)))
> > +             return -ENXIO;
>
> Please move this to be right after the capabilities are retrieved.
> There is no point in the SG-burst and addr-width data initializations
> if a DMA-controller isn't suitable for the Tx/Rx DMAs.

On second thought I see that dma_get_slave_caps already checks if
direction exists in dmaengine.c:
...
int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
...
    if (!device->directions)
        return -ENXIO;
...
But it does not check the capability w.r.t the type of channel i.e.
tx/rx , so we can keep this check as well.
Either Way, in case we keep it I shall move this as you suggested.

>
> -Serge(y)
>
> > +
> > +     return 0;
> >  }
> >
> >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws=
)
> > @@ -95,6 +112,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, =
struct dw_spi *dws)
> >       struct dw_dma_slave dma_rx =3D { .src_id =3D 0 }, *rx =3D &dma_rx=
;
> >       struct pci_dev *dma_dev;
> >       dma_cap_mask_t mask;
> > +     int ret =3D -EBUSY;
> >
> >       /*
> >        * Get pci device for DMA controller, currently it could only
> > @@ -124,20 +142,24 @@ static int dw_spi_dma_init_mfld(struct device *de=
v, struct dw_spi *dws)
> >
> >       init_completion(&dws->dma_completion);
> >
> > -     dw_spi_dma_maxburst_init(dws);
> > +     ret =3D dw_spi_dma_caps_init(dws);
> > +     if (ret)
> > +             goto free_txchan;
> >
> > -     dw_spi_dma_sg_burst_init(dws);
> > +     dw_spi_dma_maxburst_init(dws);
> >
> >       pci_dev_put(dma_dev);
> >
> >       return 0;
> > -
> > +free_txchan:
> > +     dma_release_channel(dws->txchan);
> > +     dws->txchan =3D NULL;
> >  free_rxchan:
> >       dma_release_channel(dws->rxchan);
> >       dws->rxchan =3D NULL;
> >  err_exit:
> >       pci_dev_put(dma_dev);
> > -     return -EBUSY;
> > +     return ret;
> >  }
> >
> >  static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *=
dws)
> > @@ -163,12 +185,16 @@ static int dw_spi_dma_init_generic(struct device =
*dev, struct dw_spi *dws)
> >
> >       init_completion(&dws->dma_completion);
> >
> > -     dw_spi_dma_maxburst_init(dws);
> > +     ret =3D dw_spi_dma_caps_init(dws);
> > +     if (ret)
> > +             goto free_txchan;
> >
> > -     dw_spi_dma_sg_burst_init(dws);
> > +     dw_spi_dma_maxburst_init(dws);
> >
> >       return 0;
> > -
> > +free_txchan:
> > +     dma_release_channel(dws->txchan);
> > +     dws->txchan =3D NULL;
> >  free_rxchan:
> >       dma_release_channel(dws->rxchan);
> >       dws->rxchan =3D NULL;
> > @@ -202,8 +228,14 @@ static bool dw_spi_can_dma(struct spi_controller *=
master,
> >                          struct spi_device *spi, struct spi_transfer *x=
fer)
> >  {
> >       struct dw_spi *dws =3D spi_controller_get_devdata(master);
> > +     enum dma_slave_buswidth dma_bus_width;
> > +
> > +     if (xfer->len <=3D dws->fifo_len)
> > +             return false;
> > +
> > +     dma_bus_width =3D dw_spi_dma_convert_width(dws->n_bytes);
> >
> > -     return xfer->len > dws->fifo_len;
> > +     return dws->dma_addr_widths & BIT(dma_bus_width);
> >  }
> >
> >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index 9e8eb2b52d5c..3962e6dcf880 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -190,6 +190,7 @@ struct dw_spi {
> >       struct dma_chan         *rxchan;
> >       u32                     rxburst;
> >       u32                     dma_sg_burst;
> > +     u32                     dma_addr_widths;
> >       unsigned long           dma_chan_busy;
> >       dma_addr_t              dma_addr; /* phy address of the Data regi=
ster */
> >       const struct dw_spi_dma_ops *dma_ops;
> > --
> > 2.40.0.348.gf938b09366-goog
> >

Thanks
Joy
