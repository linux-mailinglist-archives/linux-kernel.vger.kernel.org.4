Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA16DDE38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDKOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDKOjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:39:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299AFE1;
        Tue, 11 Apr 2023 07:39:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z26so10596534lfj.11;
        Tue, 11 Apr 2023 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681223992; x=1683815992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yI1tRFxnR7CPa65y/9Js8EACycbLXmL0dO6WUaKFtRw=;
        b=X6wdpSx9c5fDjYH0ZQeHi9b+DkUIILF7A7hjO8QhO/nCtXN/+fnPMU4UVkefxMnwTd
         kg0CP+NhHvQSqrOiwS3E/zMlEw0PDcCnRWBiRuXNG2Uq23PtcBaf9FV9E9NItNgErlMB
         +t9XKaHQ/DWzHtw32bQZMcomw5vP7sAXCxx9gp9NNVW0WpCnUJHBKY3H2pnCM2Irc5K3
         nPNpZMnR+goWe2mdUfpNXNo3jaiHGbtANReFC0CsYeyvFUIsDqO/Bkog+SHSxB/iwWQ6
         8MnFGUNAFC1pq46S197t5oGD+659QUUmdU/fyeEpZcGJX0H92x71a4CatyeEV3H51J3d
         QQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223992; x=1683815992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI1tRFxnR7CPa65y/9Js8EACycbLXmL0dO6WUaKFtRw=;
        b=lF3dzJ7zwFPk4of/NGdHVz/jptLdc5e8dGh2lUDnLTp4n6WAD2/1/dfrI7HEprMqvl
         zmpMEfB26z6iAbzAWWZqjuFmTuvPJNvyEsEsaC/ZyZiC3Me+hOhP96yQnuKlKfos5rm4
         a+gGurXJc2jFkF0jhoZWdYQURFUrVw5wlkeTQn7D3rhtFzRbwl/xrSSKfHByLMVQ5Eid
         DzSzfkGrP2b8prqmtacyjtQgl5N5Z0WhH0A85vEy++9RDT3l3o+a8jgs6zVqTfFdsiKT
         StBLQPnUW9KjvPxNyThF+7a7aIZyHZCX/lKEeumla28EOUEjkR8sn+w/UtOtyV1/KhGL
         xfsQ==
X-Gm-Message-State: AAQBX9dLnGYYu58TGtgXRteJnJwT3Iy193m+swreSZSCTa/qiTvfmexR
        XALqkn8KMFs/joYHfi86XYI=
X-Google-Smtp-Source: AKy350Z8WSDx77TWEtccUxbDV7zq9WiVplfiOXF3iq6x8nNr7rCHsdo345/SzDnlEPU9F2uF19QTRg==
X-Received: by 2002:ac2:46d6:0:b0:4e9:ccff:daa6 with SMTP id p22-20020ac246d6000000b004e9ccffdaa6mr3374187lfo.30.1681223992310;
        Tue, 11 Apr 2023 07:39:52 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id 27-20020ac2483b000000b004db3890cb4bsm2599818lft.94.2023.04.11.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:39:51 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:39:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230411143950.ojx6omykx4vu4vja@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-2-joychakr@google.com>
 <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
 <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <CAOSNQF3MM6BLi=xs6VJFn9gWHU_00M--akcpsA=Jm=6U=3LZnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF3MM6BLi=xs6VJFn9gWHU_00M--akcpsA=Jm=6U=3LZnQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:00:23PM +0530, Joy Chakraborty wrote:
> Hello Andy,
> 
> On Tue, Apr 11, 2023 at 7:41 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko wrote:
> > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakraborty wrote:
> > >
> > > First of all the Subject is wrong. You are not touching DMA controller.
> > > Needs to be rephrased.
> 
> Sure, will rephrase this to "SPI DMA Driver" instead of controller.
> 
> > >
> > > > Add Support for AxSize = 4 bytes configuration from dw dma driver if
> > >
> > > SPI DMA driver
> > >
> > > (or something like this, note capital letters for acronyms).
> > >
> > > > n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > > >
> > > > Number of bytes written to fifo per write is depended on the bits/word
> > > > configuration being used which the DW core driver translates to n_bytes.
> > >
> > > ...
> > >
> > > >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> > > >  {
> > > > -   if (n_bytes == 1)
> > > > +   switch (n_bytes) {
> > > > +   case 1:
> > > >             return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > -   else if (n_bytes == 2)
> > > > +   case 2:
> > > >             return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > -
> > > > -   return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > >
> > > > +   case 3:
> > >
> > > I'm not sure about this.
> >
> > This actually makes sense seeing the function argument can have values
> > 1, 2, _3_ and 4:
> > dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> > transfer->bits_per_word = __F__(master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32));
> > ...
> > dw_spi_dma_convert_width(dws->n_bytes)
> >
> > The spi_transfer.bits_per_word field value depends on the
> > SPI peripheral device communication protocol requirements which may
> > imply the 3-bytes word xfers (even though it's indeed unluckily).
> >
> > This semantic will also match to what we currently have in the
> > IRQ-based SPI-transfer implementation (see dw_writer() and
> > dw_reader()).
> >
> > -Serge(y)
> >
> 
> Will keep this as is to be similar to dw_writer() / dw_reader() as
> explained by Serge(y).
> 
> > >
> > > > +   case 4:
> > > > +           return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > +   default:
> > > > +           return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > +   }
> > > >  }
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> 
> I shall create another patch series with the same.

Hold on for Andy to respond please.

-Serge(y)

> 
> Thanks
> Joy
