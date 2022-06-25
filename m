Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3245E609256
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJWK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 06:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 06:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B635A8DB;
        Sun, 23 Oct 2022 03:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A888B60B61;
        Sun, 23 Oct 2022 10:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14D3C433C1;
        Sun, 23 Oct 2022 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666522596;
        bh=lyTdIKeZjwi6PoGVvjTDLmW7YJbAZtMOfj7JmOF6Gmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NYPN8VkGrvo19tKNOorOnl8MKQZvblC5h8iXLPadyri41aTPyDui7E+JY5laKk+DL
         HLXoCzTDhLStJFiOsTWS7Ncr1r0Q1BZF8UMrxr8FSNQw10fyEnSJvTK9KVZipqgMvu
         Pm06NM/KwM3bDnwN6EgJ5sg+pW6tCqZcRnCOZ3HBg5qOnzkoejcMbW072nABaLReYu
         mx60T4xZD0Lx1O0iMQEHmgnQ0Pbc4lwiMYYdl2OZ0wlBlNfEKSUk3/FlhgO4qHfiUT
         gdTCJn9FaCuXP6NgrgH/Q35es00kmSD38ewz/SOd9ZOWo/MCEdOnPw5IlbI+dJeBFy
         MqZCizIzCf3Tg==
Date:   Sat, 25 Jun 2022 14:32:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220625143253.0c022fcd@jic23-huawei>
In-Reply-To: <CAHp75VeRgnCLP0YqiOe8OkW3hQ178ia+Y3PjFtCMW4Sh7JfCZQ@mail.gmail.com>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
        <20220620162059.1097264-3-cosmin.tanislav@analog.com>
        <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
        <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com>
        <CAHp75Vc_fcAP6gGwMkYZUoMM6jKeUoQr8J+zYCUz8inSHnTF_w@mail.gmail.com>
        <54bfff70-938f-16e1-198d-47ed9ba95db4@gmail.com>
        <CAHp75VeRgnCLP0YqiOe8OkW3hQ178ia+Y3PjFtCMW4Sh7JfCZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 19:33:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jun 23, 2022 at 6:14 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> > On 6/23/22 18:39, Andy Shevchenko wrote:  
> > > On Thu, Jun 23, 2022 at 5:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:  
> > >> On 6/20/22 21:29, Andy Shevchenko wrote:  
> > >>> On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:  
> 
> ...
> 
> > >>>> +       /*
> > >>>> +        * DMA (thus cache coherency maintenance) requires the
> > >>>> +        * transfer buffers to live in their own cache lines.
> > >>>> +        */  
> > >>>
> > >>> This is a good comment, but what fields does it apply to?  
> > >>
> > >> Whatever is below it, grouped together. This is not hard to
> > >> understand.  
> > >
> > > It's hard to understand what exactly is DMA-aware here. I see only one
> > > buffer that is aligned properly for DMA, the rest are not, except the
> > > case if all of them are going in one DMA transaction. Is this the case
> > > here?
> > >  
> > >>>> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);  
> > >
> > > This is aligned.
> > >  
> > >>>> +       u8                      reg_write_tx_buf[4];  
> > >
> > > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0).
> > >  
> > >>>> +       u8                      reg_read_tx_buf[1];  
> > >
> > > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4).
> > >  
> > >>>> +       u8                      reg_read_rx_buf[3];  
> > >
> > > This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4 + 1).
> > > And this is Rx.
> > >  
> > >>>> +       u8                      fifo_tx_buf[2];  
> > >
> > > Here is Tx again which is most likely is not aligned...
> > >  
> > >>>> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
> > >>>> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
> > >>>> +};  
> > >  
> >
> > This has been mentioned before by Jonathan as a reply to V6 of my
> > AD74413R driver.
> >  
> >  > I'm surprised I didn't mention this before but you only need to  
> > ensure  > that any memory used for DMA is not in a cacheline with memory
> > used  
> >  > for other things that might change concurrently.  
> >
> > To my understanding, as long as the DMA buffers will all be accessed by
> > the same DMA-compatible SPI controller, you only need to align them so
> > they're not in the same cacheline with memory that will not be accessed
> > by the SPI controller.  
> 
> SPI is synchronous by nature, what will happen if the Tx and Rx
> buffers are sharing the same cache line? Anybody to shed a light here?
> 
> (I.o.w. I'm not sure that we don't need to split the Rx and Tx buffers
> of the same transfer.)

My understanding is that any device that stamps on itself is considered broken
and needs to do it's own bounce buffering.  We just need to ensure no
CPU writes hit stuff in the same cacheline whilst DMA is in progress.

A clarification to the comment to say that it covers all the buffers at the
end of the structure would be a good addition.

Jonathan

