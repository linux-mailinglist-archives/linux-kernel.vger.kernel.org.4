Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA76BBBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjCOSGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCOSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:06:50 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4840A5D451
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:06:48 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54195ef155aso204925617b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678903607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEN+4igpQnsaZDWFE65KuKe5vYz6+U5Kq6oQlxkGgp4=;
        b=fT/0rkq91CZJKKkYi1eYGD0jl6CfHlvLWz+hbKRlg4EjJn1y0xjZUIINhgF/e9HWuB
         3QstKXsB6XxbFYPpDRPUV7TCv4ydC62EQLm7PqRVTAjpkkelqLVZDWNc2LdQsRMa2qKx
         KJKR4MvXg8l692WnMFP/zJrLzs5yRUJoKIO4je/G7zzn5q4owHC7mc/IDZZd5Jer0Rsc
         cBCj09BpvJQrO5jbNRmo8g5j5TY5PfabOVKQemktuzVjWP5B6Kv4gPbYgm6bh99Am0Gn
         c1fJsaH5rkAKmHckDWuN/UXznNcdSBChdlrqX4OTZHcMblxm7Sd/+Vi5HChmd776OQpg
         6EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEN+4igpQnsaZDWFE65KuKe5vYz6+U5Kq6oQlxkGgp4=;
        b=gSXnUOPkGIbxaftn3dZ/LbVZO1b9+JO3p9yXby5lRKdsHr0N84+SaUvq01ngnsJm1e
         9AdPoEddnsasSCiAlAvQny++7IKJF2+gKugSWedWLJB2BybVw45zm+ny7fWCrI8uC+x8
         mf02aStlLx+wfGXjyfRwHoIACVpnvK8LHGw/wYlGE8AJCHny+wSL+0Kiadj8g//S5DDL
         TySh90bFlp3IivvViJdjiMZ3g+0JT09L57yaRgA8TWgMeN/fxFSNtGlTuCJsVTlIbB+l
         puUr8Ytl/Qns73f03PCdd/lsgMtu7IRaZLbhsQAGOcx7XTlSJch/WnxhY7xuOY42ZCk+
         5oGA==
X-Gm-Message-State: AO0yUKXWIIbvX7vxG8VdXKkrrzEsqb5NqbTRG/QIyKr/S4muxtZSjyLw
        ofvktrqoOnrhfuVmN26zUUhFPwJ16tmwEdCHaow4OQ==
X-Google-Smtp-Source: AK7set/tGno4/NUFj4FeC/s/GZj7L8oEWZAxPlKwtJt+H+A7Ebdk41cyh63hbkvM2AxaMcKQ0IYhxJJEopYuV5Wmh/M=
X-Received: by 2002:a81:d302:0:b0:541:359c:103a with SMTP id
 y2-20020a81d302000000b00541359c103amr481255ywi.8.1678903607298; Wed, 15 Mar
 2023 11:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230310153151.293608-1-zenghuchen@google.com> <20230311022334.he6ev6tswfc2xcwo@mobilestation>
In-Reply-To: <20230311022334.he6ev6tswfc2xcwo@mobilestation>
From:   Jack Chen <zenghuchen@google.com>
Date:   Wed, 15 Mar 2023 14:06:36 -0400
Message-ID: <CALvyBcWewTs5pRwXktKcAuCOogXgQ8jkiwp5ToG7T+Dr2qaJjA@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: remove delay between write and read
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

> On Fri, Mar 10, 2023 at 10:31:51AM -0500, Jack Chen wrote:
> > Delay between write and read in polling mode is not necessary in dw spi
> > driver. It was added assuming that dw spi controller need the delay to
> > send data from tx fifo to spi devices. But it is not needed because
> > following reasons:
> > 1) dw spi datasheet claims transfer begins when first data word is
> >    present in the transmit FIFO and a slave is enabled. So at least we
> >    do not need the full fifo-size-transfer time delay.
> > 2) in practice, due to spi devices implementation, spi full-duplex
> >    (write and read real data) is always split into two transfers.

> In practice the delay is specifically added to minimize the dummy
> loops in the poll-based transfer. It's calculated based on the number
> of bytes pushed to the Tx FIFO and the SPI-bus clock rate (that's why
> the spi_transfer.effective_speed_hz field is initialized in the
> driver). So after all of them are transferred we get to start reading
> data from the Rx FIFO. Until then the kernel thread is supposed to
> sleep giving up the CPU for another tasks.

Thanks so much for your feedback. I understand the purpose of the specifica=
lly
calculated delay now. However, whether freeing cpu to other threads actuall=
y
depends on the size of delay. If the delay is smaller than 10 us, normally =
it
will cause busy-looping in cpu instead of freeing it.
And the delay does not work in all cases. For example:
if I am running the spi at 20M with a fifo size to be 8, and transfering a =
huge
chunk of data (4096 bytes) in one transfer, based on the delay calculation,=
 it
would add a 3200 ns delay between each sub-transfer, which is transformed t=
o
4us delay and in most cases on most platforms, udelay is not precise enough=
 and
I measured >=3D 5 us delay in most cases on my platform. So at least 1.8 us=
 extra
delay is added. Considering the time to fill tx_fifo, let's round it to 2us=
.
The actual time needed to transfer 8 bytes at 20M speed is just 3.2 us but =
we
added an extra delay of 2 us on average. When we consider the whole chunk o=
f
data (4096 bytes) in the whole transfer, we added more than 1 ms delay. Thi=
s
extra delay is long enough to fail a big chunk of data transfer application=
s (
e.g. image, audio.).

To overcome the extra delay, maybe we can consider the following two
proposals:
1) add a node in dts and allow users to enable the delay in polling mode.
2) Let's compare the needed delay time (bytes to transfer in tx fifo) to 10=
 us,
        and only call spi_delay_exec when the delay is bigger than 10 us. S=
ince
        When the delay is smaller than 10 us, short delay calls
(ndelay/udelay)
        are just busy-loops, even calling delay won't freeing cpu to
other tasks.
What is your opinion?
Thanks
Jack Chen

On Fri, Mar 10, 2023 at 9:23=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Jack
>
> On Fri, Mar 10, 2023 at 10:31:51AM -0500, Jack Chen wrote:
> > Delay between write and read in polling mode is not necessary in dw spi
> > driver. It was added assuming that dw spi controller need the delay to
> > send data from tx fifo to spi devices. But it is not needed because
> > following reasons:
> > 1) dw spi datasheet claims transfer begins when first data word is
> >    present in the transmit FIFO and a slave is enabled. So at least we
> >    do not need the full fifo-size-transfer time delay.
> > 2) in practice, due to spi devices implementation, spi full-duplex
> >    (write and read real data) is always split into two transfers.
>
> In practice the delay is specifically added to minimize the dummy
> loops in the poll-based transfer. It's calculated based on the number
> of bytes pushed to the Tx FIFO and the SPI-bus clock rate (that's why
> the spi_transfer.effective_speed_hz field is initialized in the
> driver). So after all of them are transferred we get to start reading
> data from the Rx FIFO. Until then the kernel thread is supposed to
> sleep giving up the CPU for another tasks.
>
> > Delay between spi transfers may be needed. But this can be introduced b=
y
> > using a more formal helper function "spi_transfer_delay_exec", in which
> > the delay time is passed by users through spi_ioc_transfer.
>
> This is wrong. spi_transfer.delay is supposed to be executed after the
> whole transfer is completed. You suggest to to do that in between some
> random data chunks pushed and pulled from the controller FIFO.
> Moreover that delay is already performed by the SPI-core:
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L1570
>
> -Serge(y)
>
> >
> > Signed-off-by: Jack Chen <zenghuchen@google.com>
> > ---
> >  drivers/spi/spi-dw-core.c | 20 +++++++-------------
> >  1 file changed, 7 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index c3bfb6c84cab..7c10fb353567 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -379,9 +379,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
> >
> >  /*
> >   * The iterative procedure of the poll-based transfer is simple: write=
 as much
> > - * as possible to the Tx FIFO, wait until the pending to receive data =
is ready
> > - * to be read, read it from the Rx FIFO and check whether the performe=
d
> > - * procedure has been successful.
> > + * as possible to the Tx FIFO, then read from the Rx FIFO and check wh=
ether the
> > + * performed procedure has been successful.
> > + *
> > + * Delay is introduced in the end of each transfer before (optionally)=
 changing
> > + * the chipselect status, then starting the next transfer or completin=
g the
> > + * list of @spi_message.
> >   *
> >   * Note this method the same way as the IRQ-based transfer won't work =
well for
> >   * the SPI devices connected to the controller with native CS due to t=
he
> > @@ -390,21 +393,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
> >  static int dw_spi_poll_transfer(struct dw_spi *dws,
> >                               struct spi_transfer *transfer)
> >  {
> > -     struct spi_delay delay;
> > -     u16 nbits;
> >       int ret;
> >
> > -     delay.unit =3D SPI_DELAY_UNIT_SCK;
> > -     nbits =3D dws->n_bytes * BITS_PER_BYTE;
> > -
> >       do {
> >               dw_writer(dws);
> > -
> > -             delay.value =3D nbits * (dws->rx_len - dws->tx_len);
> > -             spi_delay_exec(&delay, transfer);
> > -
> >               dw_reader(dws);
> > -
> > +             spi_transfer_delay_exec(transfer);
> >               ret =3D dw_spi_check_status(dws, true);
> >               if (ret)
> >                       return ret;
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
