Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085F062F9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiKRPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242471AbiKRPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:50:40 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E88C79B;
        Fri, 18 Nov 2022 07:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668786635; x=1700322635;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R6PmwwntqAIN5rZjS2byFpDrbCzPZrB3saTnnVmYUVs=;
  b=dLlORxoCRmcFmun+AceLiLINHhpYnI+cwHuA5abFVGdVnumfRZO91nPy
   Iy1hcnQjPMLVCRvALdmw3P5i/5FIc/7xHd6PZDwyDG4bs+jBM1lFWsAMR
   tPoOlLzycmSSUmh4dcg//BOLyx1AO1qS6WEz/HZ8H45u2ECUXLR60StDW
   0s8i58vJFyuwamJs/u975ei9yO+LJ+FkFOPEEI80H/M1AVEpF2Ub19pXZ
   UQpxrq1TPwrN//0UxreYYjaiGxgUgRN0g3+iZGfQ845hes62Lp0mexNIM
   jAQ9FQ4ainBft6T11jbA6CYQHJNzLy+FkTYKpH6aDAvbwKwSBVIHdRH2t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="377429643"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="377429643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:50:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703780849"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703780849"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:50:30 -0800
Date:   Fri, 18 Nov 2022 17:50:29 +0200 (EET)
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
Subject: Re: [PATCH 15/15] tty: serial: qcom-geni-serial: add support for
 serial engine DMA
In-Reply-To: <20221118122539.384993-16-brgl@bgdev.pl>
Message-ID: <dc4857d-74b6-3d11-7b56-e05be63cdbf@linux.intel.com>
References: <20221118122539.384993-1-brgl@bgdev.pl> <20221118122539.384993-16-brgl@bgdev.pl>
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
> The qcom-geni-serial driver currently only works in SE FIFO mode. This
> limits the UART speed to around 180 kB/s. In order to achieve higher
> speeds we need to use SE DMA mode.
> 
> Keep the console port working in FIFO mode but extend the code to use DMA
> for the high-speed port.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 288 ++++++++++++++++++++++----
>  1 file changed, 246 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index cdd476d504da..700e20860af0 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -70,6 +70,8 @@
>  #define UART_START_TX			0x1
>  /* UART S_CMD OP codes */
>  #define UART_START_READ			0x1
> +#define UART_PARAM			0x1
> +#define UART_PARAM_RFR_OPEN		BIT(7)
>  
>  #define UART_OVERSAMPLING		32
>  #define STALE_TIMEOUT			16
> @@ -95,9 +97,11 @@
>  /* We always configure 4 bytes per FIFO word */
>  #define BYTES_PER_FIFO_WORD		4
>  
> +#define DMA_RX_BUF_SIZE		2048
> +
>  struct qcom_geni_device_data {
>  	bool console;
> -	void (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> +	enum geni_se_xfer_mode mode;
>  };
>  
>  struct qcom_geni_private_data {
> @@ -118,9 +122,11 @@ struct qcom_geni_serial_port {
>  	u32 tx_fifo_depth;
>  	u32 tx_fifo_width;
>  	u32 rx_fifo_depth;
> +	dma_addr_t tx_dma_addr;
> +	dma_addr_t rx_dma_addr;
>  	bool setup;
>  	unsigned int baud;
> -	void *rx_fifo;
> +	void *rx_buf;
>  	u32 loopback;
>  	bool brk;
>  
> @@ -549,18 +555,11 @@ static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>  
>  static void handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>  {
> -	struct tty_port *tport;
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
> -	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
> -	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
> +	struct tty_port *tport = &uport->state->port;
>  	int ret;
>  
> -	tport = &uport->state->port;
> -	ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo, words);
> -	if (drop)
> -		return;
> -
> -	ret = tty_insert_flip_string(tport, port->rx_fifo, bytes);
> +	ret = tty_insert_flip_string(tport, port->rx_buf, bytes);
>  	if (ret != bytes) {
>  		dev_err(uport->dev, "%s:Unable to push data ret %d_bytes %d\n",
>  				__func__, ret, bytes);
> @@ -575,7 +574,69 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *uport)
>  	return !readl(uport->membase + SE_GENI_TX_FIFO_STATUS);
>  }
>  
> -static void qcom_geni_serial_start_tx(struct uart_port *uport)
> +static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	bool done;
> +	u32 status;
> +	u32 m_irq_en;
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (!(status & M_GENI_CMD_ACTIVE))
> +		return;
> +
> +	if (port->rx_dma_addr) {
> +		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
> +				      port->tx_remaining);
> +		port->tx_dma_addr = (dma_addr_t)NULL;
> +		port->tx_remaining = 0;
> +	}
> +
> +	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
> +	writel(m_irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> +	geni_se_cancel_m_cmd(&port->se);
> +
> +	done = qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
> +					 S_CMD_CANCEL_EN, true);
> +	if (!done) {
> +		geni_se_abort_m_cmd(&port->se);
> +		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +					  M_CMD_ABORT_EN, true);
> +		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +	}
> +	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +}
> +
> +static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +	unsigned int xmit_size;
> +	int ret;
> +
> +	if (port->tx_dma_addr)
> +		return;
> +
> +	xmit_size = uart_circ_chars_pending(xmit);
> +	if (xmit_size < WAKEUP_CHARS)
> +		uart_write_wakeup(uport);
> +
> +	xmit_size = min_t(unsigned int, xmit_size, UART_XMIT_SIZE - xmit->tail);

CIRC_CNT_TO_END()

> +	qcom_geni_serial_setup_tx(uport, xmit_size);
> +
> +	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
> +				  xmit_size, &port->tx_dma_addr);
> +	if (ret) {
> +		dev_err(uport->dev, "unable to start TX SE DMA: %d\n", ret);
> +		qcom_geni_serial_stop_tx_dma(uport);
> +		return;
> +	}
> +
> +	port->tx_remaining = xmit_size;
> +}
> +
> +static void qcom_geni_serial_start_tx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> @@ -594,7 +655,7 @@ static void qcom_geni_serial_start_tx(struct uart_port *uport)
>  	writel(irq_en, uport->membase +	SE_GENI_M_IRQ_EN);
>  }
>  
> -static void qcom_geni_serial_stop_tx(struct uart_port *uport)
> +static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> @@ -620,14 +681,13 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>  	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  }
>  
> -static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
> +static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
>  {
>  	u32 status;
>  	u32 word_cnt;
>  	u32 last_word_byte_cnt;
>  	u32 last_word_partial;
>  	u32 total_bytes;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
>  	word_cnt = status & RX_FIFO_WC_MSK;
> @@ -642,10 +702,10 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
>  		total_bytes += last_word_byte_cnt;
>  	else
>  		total_bytes += BYTES_PER_FIFO_WORD;
> -	port->dev_data->handle_rx(uport, total_bytes, drop);
> +	handle_rx_console(uport, total_bytes, drop);
>  }
>  
> -static void qcom_geni_serial_stop_rx(struct uart_port *uport)
> +static void qcom_geni_serial_stop_rx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> @@ -675,7 +735,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
>  	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
>  	/* Flush the Rx buffer */
>  	if (s_irq_status & S_RX_FIFO_LAST_EN)
> -		qcom_geni_serial_handle_rx(uport, true);
> +		qcom_geni_serial_handle_rx_fifo(uport, true);
>  	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
>  
>  	status = readl(uport->membase + SE_GENI_STATUS);
> @@ -683,7 +743,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
>  		qcom_geni_serial_abort_rx(uport);
>  }
>  
> -static void qcom_geni_serial_start_rx(struct uart_port *uport)
> +static void qcom_geni_serial_start_rx_fifo(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> @@ -691,7 +751,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>  
>  	status = readl(uport->membase + SE_GENI_STATUS);
>  	if (status & S_GENI_CMD_ACTIVE)
> -		qcom_geni_serial_stop_rx(uport);
> +		qcom_geni_serial_stop_rx_fifo(uport);
>  
>  	geni_se_setup_s_cmd(&port->se, UART_START_READ, 0);
>  
> @@ -704,6 +764,101 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>  	writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
>  
> +static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	u32 status;
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (!(status & S_GENI_CMD_ACTIVE))
> +		return;
> +
> +	geni_se_cancel_s_cmd(&port->se);
> +	qcom_geni_serial_poll_bit(uport, SE_GENI_S_IRQ_STATUS,
> +				  S_CMD_CANCEL_EN, true);
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (status & S_GENI_CMD_ACTIVE)
> +		qcom_geni_serial_abort_rx(uport);
> +
> +	if (port->rx_dma_addr) {
> +		geni_se_rx_dma_unprep(&port->se, port->rx_dma_addr,
> +				      DMA_RX_BUF_SIZE);
> +		port->rx_dma_addr = (dma_addr_t)NULL;
> +	}
> +}
> +
> +static void qcom_geni_serial_start_rx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	u32 status;
> +	int ret;
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (status & S_GENI_CMD_ACTIVE)
> +		qcom_geni_serial_stop_rx_dma(uport);
> +
> +	geni_se_setup_s_cmd(&port->se, UART_START_READ, UART_PARAM_RFR_OPEN);
> +
> +	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
> +				  DMA_RX_BUF_SIZE,
> +				  &port->rx_dma_addr);
> +	if (ret) {
> +		dev_err(uport->dev, "unable to start RX SE DMA: %d\n", ret);
> +		qcom_geni_serial_stop_rx_dma(uport);
> +	}
> +}
> +
> +static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	u32 status;
> +	u32 rx_in;
> +	int ret;
> +
> +	status = readl(uport->membase + SE_GENI_STATUS);
> +	if (!(status & S_GENI_CMD_ACTIVE))
> +		return;
> +
> +	if (!port->rx_dma_addr)
> +		return;
> +
> +	geni_se_rx_dma_unprep(&port->se, port->rx_dma_addr, DMA_RX_BUF_SIZE);
> +	port->rx_dma_addr = (dma_addr_t)NULL;
> +
> +	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
> +	if (!rx_in) {
> +		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
> +		return;
> +	}
> +
> +	if (!drop)
> +		handle_rx_uart(uport, rx_in, drop);
> +
> +	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
> +				  DMA_RX_BUF_SIZE,
> +				  &port->rx_dma_addr);
> +	if (ret) {
> +		dev_err(uport->dev, "unable to start RX SE DMA: %d\n", ret);
> +		qcom_geni_serial_stop_rx_dma(uport);
> +	}
> +}
> +
> +static void qcom_geni_serial_start_rx(struct uart_port *uport)
> +{
> +	uport->ops->start_rx(uport);
> +}
> +
> +static void qcom_geni_serial_stop_rx(struct uart_port *uport)
> +{
> +	uport->ops->stop_rx(uport);
> +}
> +
> +static void qcom_geni_serial_stop_tx(struct uart_port *uport)
> +{
> +	uport->ops->stop_tx(uport);
> +}
>  static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
>  					    unsigned int chunk)
>  {
> @@ -736,8 +891,8 @@ static int qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
>  	return tail;
>  }
>  
> -static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
> -		bool active)
> +static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
> +					    bool done, bool active)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	struct circ_buf *xmit = &uport->state->xmit;
> @@ -757,7 +912,7 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  
>  	/* All data has been transmitted and acknowledged as received */
>  	if (!pending && !status && done) {
> -		qcom_geni_serial_stop_tx(uport);
> +		qcom_geni_serial_stop_tx_fifo(uport);
>  		goto out_write_wakeup;
>  	}
>  
> @@ -800,12 +955,32 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  		uart_write_wakeup(uport);
>  }
>  
> +static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
> +{
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
> +	struct circ_buf *xmit = &uport->state->xmit;
> +
> +	xmit->tail = (xmit->tail + port->tx_remaining) & (UART_XMIT_SIZE - 1);
> +	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
> +	uport->icount.tx += port->tx_remaining;

Use uart_xmit_advance(uport, port->tx_remaining); to handle tail and 
icount.tx manipulation.

After that I think you can probably drop xmit local var.

> +	port->tx_dma_addr = (dma_addr_t)NULL;
> +	port->tx_remaining = 0;
> +
> +	if (!uart_circ_empty(xmit))
> +		qcom_geni_serial_start_tx_dma(uport);
> +	else
> +		uart_write_wakeup(uport);

Usually the condition for wakeup is:

	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
		uart_write_wakeup(uport);

-- 
 i.

> +}
> +
>  static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  {
>  	u32 m_irq_en;
>  	u32 m_irq_status;
>  	u32 s_irq_status;
>  	u32 geni_status;
> +	u32 dma;
> +	u32 dma_tx_status;
> +	u32 dma_rx_status;
>  	struct uart_port *uport = dev;
>  	bool drop_rx = false;
>  	struct tty_port *tport = &uport->state->port;
> @@ -818,10 +993,15 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  
>  	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
>  	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> +	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
> +	dma_rx_status = readl(uport->membase + SE_DMA_RX_IRQ_STAT);
>  	geni_status = readl(uport->membase + SE_GENI_STATUS);
> +	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
>  	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>  	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
>  	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> +	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
> +	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
>  
>  	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
>  		goto out_unlock;
> @@ -831,10 +1011,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>  	}
>  
> -	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> -		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
> -					   geni_status & M_GENI_CMD_ACTIVE);
> -
>  	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
>  		if (s_irq_status & S_GP_IRQ_0_EN)
>  			uport->icount.parity++;
> @@ -844,8 +1020,35 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  		port->brk = true;
>  	}
>  
> -	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
> -		qcom_geni_serial_handle_rx(uport, drop_rx);
> +	if (dma) {
> +		if (dma_tx_status & TX_DMA_DONE)
> +			qcom_geni_serial_handle_tx_dma(uport);
> +
> +		if (dma_rx_status) {
> +			if (dma_rx_status & RX_RESET_DONE)
> +				goto out_unlock;
> +
> +			if (dma_rx_status & RX_DMA_PARITY_ERR) {
> +				uport->icount.parity++;
> +				drop_rx = true;
> +			}
> +
> +			if (dma_rx_status & RX_DMA_BREAK)
> +				uport->icount.brk++;
> +
> +			if (dma_rx_status & (RX_DMA_DONE | RX_EOT))
> +				qcom_geni_serial_handle_rx_dma(uport, drop_rx);
> +		}
> +	} else {
> +		if (m_irq_status & m_irq_en &
> +		    (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
> +			qcom_geni_serial_handle_tx_fifo(uport,
> +					m_irq_status & M_CMD_DONE_EN,
> +					geni_status & M_GENI_CMD_ACTIVE);
> +
> +		if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
> +			qcom_geni_serial_handle_rx_fifo(uport, drop_rx);
> +	}
>  
>  out_unlock:
>  	uart_unlock_and_check_sysrq(uport);
> @@ -915,7 +1118,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>  	geni_se_config_packing(&port->se, BITS_PER_BYTE, BYTES_PER_FIFO_WORD,
>  			       false, true, true);
>  	geni_se_init(&port->se, UART_RX_WM, port->rx_fifo_depth - 2);
> -	geni_se_select_mode(&port->se, GENI_SE_FIFO);
> +	geni_se_select_mode(&port->se, port->dev_data->mode);
>  	port->setup = true;
>  
>  	return 0;
> @@ -1313,10 +1516,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  
>  static const struct uart_ops qcom_geni_console_pops = {
>  	.tx_empty = qcom_geni_serial_tx_empty,
> -	.stop_tx = qcom_geni_serial_stop_tx,
> -	.start_tx = qcom_geni_serial_start_tx,
> -	.stop_rx = qcom_geni_serial_stop_rx,
> -	.start_rx = qcom_geni_serial_start_rx,
> +	.stop_tx = qcom_geni_serial_stop_tx_fifo,
> +	.start_tx = qcom_geni_serial_start_tx_fifo,
> +	.stop_rx = qcom_geni_serial_stop_rx_fifo,
> +	.start_rx = qcom_geni_serial_start_rx_fifo,
>  	.set_termios = qcom_geni_serial_set_termios,
>  	.startup = qcom_geni_serial_startup,
>  	.request_port = qcom_geni_serial_request_port,
> @@ -1334,9 +1537,10 @@ static const struct uart_ops qcom_geni_console_pops = {
>  
>  static const struct uart_ops qcom_geni_uart_pops = {
>  	.tx_empty = qcom_geni_serial_tx_empty,
> -	.stop_tx = qcom_geni_serial_stop_tx,
> -	.start_tx = qcom_geni_serial_start_tx,
> -	.stop_rx = qcom_geni_serial_stop_rx,
> +	.stop_tx = qcom_geni_serial_stop_tx_dma,
> +	.start_tx = qcom_geni_serial_start_tx_dma,
> +	.start_rx = qcom_geni_serial_start_rx_dma,
> +	.stop_rx = qcom_geni_serial_stop_rx_dma,
>  	.set_termios = qcom_geni_serial_set_termios,
>  	.startup = qcom_geni_serial_startup,
>  	.request_port = qcom_geni_serial_request_port,
> @@ -1405,9 +1609,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
>  
>  	if (!data->console) {
> -		port->rx_fifo = devm_kcalloc(uport->dev,
> -			port->rx_fifo_depth, sizeof(u32), GFP_KERNEL);
> -		if (!port->rx_fifo)
> +		port->rx_buf = devm_kzalloc(uport->dev,
> +					    DMA_RX_BUF_SIZE, GFP_KERNEL);
> +		if (!port->rx_buf)
>  			return -ENOMEM;
>  	}
>  
> @@ -1531,12 +1735,12 @@ static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
>  
>  static const struct qcom_geni_device_data qcom_geni_console_data = {
>  	.console = true,
> -	.handle_rx = handle_rx_console,
> +	.mode = GENI_SE_FIFO,
>  };
>  
>  static const struct qcom_geni_device_data qcom_geni_uart_data = {
>  	.console = false,
> -	.handle_rx = handle_rx_uart,
> +	.mode = GENI_SE_DMA,
>  };
>  
>  static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
> 

