Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CD62F94A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbiKRPaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiKRPaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:30:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F1D2A0;
        Fri, 18 Nov 2022 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668785406; x=1700321406;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JzOGwCVCRMAleGj8kwHWb9shL3ET4TYIk8KCROq8iBE=;
  b=V514Rju3XOlptZpQjkpI0hahIwa9vZHbMSUftacQUK5IMfpzlpy0A/rD
   /to9Qow9000WLwOzWcs+8oET1Q7tEmgGrTL4q+cDGCRAxzSetLlCHvobE
   aslNOH+llNrvcpHQILcrnnCIVN2N6pZTKJCo3igxXegQRQF/plGj0Z+Yz
   UP4CUdrWLQZ7TfIMlTwx2uIGiP82Vkd4FuL2wFVyOlMMsgcfWmWOFdfd9
   8JH6v83VnwvFij3Gw1gecgSvSlWAd3hF8Ndh+jxTLinBWY6d2fKd8eXB5
   55xgkiITVhGtDea3ucW9DUipVgnejlbc7pEUaofmsYM8ldcB0kxeBpgwL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293547078"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="293547078"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:30:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618041865"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="618041865"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:30:01 -0800
Date:   Fri, 18 Nov 2022 17:30:00 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 08/15] tty: serial: qcom-geni-serial: split out the FIFO
 tx code
In-Reply-To: <20221118122539.384993-9-brgl@bgdev.pl>
Message-ID: <3bc36af8-3cd4-b4b0-af30-2c5f309dc519@linux.intel.com>
References: <20221118122539.384993-1-brgl@bgdev.pl> <20221118122539.384993-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> qcom_geni_serial_handle_tx() is pretty big, let's move the code that
> handles the actual writing of data to a separate function which makes
> sense in preparation for introducing a dma variant of handle_tx().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 60 +++++++++++++++------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 39041538e5d2..4b155ca0ac74 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -701,19 +701,48 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>  	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
>  
> +static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
> +					    unsigned int chunk)
> +{

Some of the comments I have for this function you might want to implement 
in a different patch than this simple move to own function.

> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	size_t remaining = chunk;
> +	int i, tail = xmit->tail;

Why there's remaining and i variables, both seem to provide a chunk sized 
limit? Couldn't one be dropped?

You could drop local tail handling, it doesn't seem to add much value.

> +	for (i = 0; i < chunk; ) {
> +		unsigned int tx_bytes;
> +		u8 buf[sizeof(u32)];
> +		int c;
> +
> +		memset(buf, 0, sizeof(buf));
> +		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);

It's a bit confusing to mix sizeof(u32) and BYTES_PER_FIFO_WORD for the 
same purpose, no?

> +		for (c = 0; c < tx_bytes ; c++) {
> +			buf[c] = xmit->buf[tail++];
> +			tail &= UART_XMIT_SIZE - 1;

If you drop the local tail, this becomes:

			buf[c] = xmit->buf[xmit->tail];
			uart_xmit_advance(uport, 1);

> +		}
> +
> +		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
> +
> +		i += tx_bytes;
> +		uport->icount.tx += tx_bytes;

With uart_xmit_advance, this is to be dropped.

> +		remaining -= tx_bytes;
> +		port->tx_remaining -= tx_bytes;
> +	}
> +
> +	return tail;
> +}
> +
>  static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  		bool active)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	struct circ_buf *xmit = &uport->state->xmit;
>  	size_t avail;
> -	size_t remaining;
>  	size_t pending;
> -	int i;
>  	u32 status;
>  	u32 irq_en;
>  	unsigned int chunk;
> -	int tail;
>  
>  	status = readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>  
> @@ -732,7 +761,6 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  	avail = port->tx_fifo_depth - (status & TX_FIFO_WC);
>  	avail *= BYTES_PER_FIFO_WORD;
>  
> -	tail = xmit->tail;
>  	chunk = min(avail, pending);
>  	if (!chunk)
>  		goto out_write_wakeup;
> @@ -747,29 +775,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  					uport->membase + SE_GENI_M_IRQ_EN);
>  	}
>  
> -	remaining = chunk;
> -	for (i = 0; i < chunk; ) {
> -		unsigned int tx_bytes;
> -		u8 buf[sizeof(u32)];
> -		int c;
> -
> -		memset(buf, 0, sizeof(buf));
> -		tx_bytes = min_t(size_t, remaining, BYTES_PER_FIFO_WORD);
> -
> -		for (c = 0; c < tx_bytes ; c++) {
> -			buf[c] = xmit->buf[tail++];
> -			tail &= UART_XMIT_SIZE - 1;
> -		}
> -
> -		iowrite32_rep(uport->membase + SE_GENI_TX_FIFOn, buf, 1);
> -
> -		i += tx_bytes;
> -		uport->icount.tx += tx_bytes;
> -		remaining -= tx_bytes;
> -		port->tx_remaining -= tx_bytes;
> -	}
> -
> -	xmit->tail = tail;
> +	xmit->tail = qcom_geni_serial_send_chunk_fifo(uport, chunk);

Why you want to assign to xmit->tail here?

>  
>  	/*
>  	 * The tx fifo watermark is level triggered and latched. Though we had
> 

-- 
 i.

