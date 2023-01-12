Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBD666E84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjALJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbjALJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:42:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6A13F12;
        Thu, 12 Jan 2023 01:41:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 260FD61F8B;
        Thu, 12 Jan 2023 09:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0531C433D2;
        Thu, 12 Jan 2023 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673516477;
        bh=L71EaY3pd8rJtO7sKEFCg+WmL03bHx3xmOlFP6Poe6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtVLb7r6SqZF+oaTWa66jwP3eLGA9LyDRlvAu0WYLQ4YIccMkE3VA0g6rPfoz3SqK
         0t+wFlklDjIklFX74lCJBCrFVO3tBdw04cNNwqlcsWsDJJ7rtcUlgizIyXolxfyflq
         oglHqbV8l1wOhXxF4HVzFjtoCWLNfJg8/qyCbbqY=
Date:   Thu, 12 Jan 2023 10:41:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 00/14] serial: qcom-geni-serial: implement support for
 SE DMA
Message-ID: <Y7/VtWp9AQ+8uNcM@kroah.com>
References: <20221229155030.418800-1-brgl@bgdev.pl>
 <CAMRc=McPdvZFJ4DhgAQ9rPOD3Xi89nrA3ZrgZtA33PjptQuPxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McPdvZFJ4DhgAQ9rPOD3Xi89nrA3ZrgZtA33PjptQuPxA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:59:51AM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 29, 2022 at 4:50 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The goal of this series is to update the qcom-geni-serial driver to use
> > the DMA mode of the QUPv3 serial engine. This is accomplished by the last
> > patch in the series. The previous ones contain either various tweaks,
> > reworks and refactoring or prepare the driver for adding DMA support.
> >
> > More work will follow on the serial engine in order to reduce code
> > redundancy among its users and add support for SE DMA to the qcom GENI
> > SPI driver.
> >
> > v5 -> v6:
> > - move patch 12/14 to the front of the series and mark it as a fix
> > - rebase on top of v6.2-rc1 (there were some updates to the driver)
> >
> > v4 -> v5:
> > - split patch 8/13 into two: one for splitting out the chunk sending code
> >   and one for refactoring it (for easier review)
> > - when stopping uart: disable the irq first before stopping transfers in
> >   progress, otherwise we rist rescheduling additional transfers after
> >   interrupt
> > - make types even nore consistent in qcom_geni_serial_send_chunk_fifo()
> >
> > v3 -> v4:
> > - don't assign NULL (even cast) to variables of type dma_addr_t
> > - refactor checking the SE_GENI_STATUS into two inline functions
> > - drop min_t() in favor of regular min() after adding some consistency to types
> > - check if the abort command was successful and emit a message if not when
> >   stopping TX in DMA mode
> >
> > v2 -> v3:
> > - drop devres patches from the series
> >
> > v1 -> v2:
> > - turn to_dev_uport() macro into a static inline function
> > - use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
> >   handle xmit->tail directly
> > - drop sizeof() where BYTES_PER_FIFO_WORD can be used
> > - further refactor qcom_geni_serial_handle_tx_fifo()
> > - collect review tags
> >
> > Bartosz Golaszewski (14):
> >   tty: serial: qcom-geni-serial: stop operations in progress at shutdown
> >   tty: serial: qcom-geni-serial: drop unneeded forward definitions
> >   tty: serial: qcom-geni-serial: remove unused symbols
> >   tty: serial: qcom-geni-serial: align #define values
> >   tty: serial: qcom-geni-serial: improve the to_dev_port() macro
> >   tty: serial: qcom-geni-serial: remove stray newlines
> >   tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
> >   tty: serial: qcom-geni-serial: remove unneeded tabs
> >   tty: serial: qcom-geni-serial: split out the FIFO tx code
> >   tty: serial: qcom-geni-serial: refactor
> >     qcom_geni_serial_send_chunk_fifo()
> >   tty: serial: qcom-geni-serial: drop the return value from handle_rx
> >   tty: serial: qcom-geni-serial: use of_device_id data
> >   soc: qcom-geni-se: add more symbol definitions
> >   tty: serial: qcom-geni-serial: add support for serial engine DMA
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 626 +++++++++++++++++---------
> >  include/linux/qcom-geni-se.h          |   3 +
> >  2 files changed, 413 insertions(+), 216 deletions(-)
> >
> > --
> > 2.37.2
> >
> 
> It's been two weeks without any further comments, can this be picked
> up now into the serial tree?

When I dig out of the huge hole that is my todo queue, yes:
	$ mdfrm -c ~/mail/todo/
	2560 messages in /home/gregkh/mail/todo/

You are in good company...

