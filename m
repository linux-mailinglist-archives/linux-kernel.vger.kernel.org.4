Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64F62F8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241983AbiKRPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbiKRPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:11:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0326AC3;
        Fri, 18 Nov 2022 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668784301; x=1700320301;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BTgT1SBKtQfEh6v013vVX4uFjQtyVZZjVeVCqJpSIzU=;
  b=hEJ7rNcItU3xiBb1iW7RgxUpNCkCP5kaAtYRsZloLnMxIrvheyMRuY/b
   4r0gQDZZBmFbfCFk2gIwmQ3kxOzkt5gZY5760Vv0wYIC0YxOFu64WfpRc
   AHJiDn4VQ6ms4RJ6+VFlpnpBjj1OoLRFXkHv8/6oieCPaJ16k7yIM3uCX
   wsGZTtadqqUuPf/kFNS8qA741ThzyfYub91UlQtifm7+OHXfh7Tla6bt8
   kkWshtpr82s8onHJcwVSjzniwH96K2+qOpRt3oJ5r24pyLdMQIYZ6pFT/
   M0vSLrt9PnUGd63P4cd+R3Ov4JHBRuMEngf3qDZcjlyhULoV/kal5AJD5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="377420904"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="377420904"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:11:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="969302509"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="969302509"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 07:11:36 -0800
Date:   Fri, 18 Nov 2022 17:11:35 +0200 (EET)
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
Subject: Re: [PATCH 04/15] tty: serial: qcom-geni-serial: simplify the
 to_dev_port() macro
In-Reply-To: <20221118122539.384993-5-brgl@bgdev.pl>
Message-ID: <a67ec01d-e3ed-3cd2-a880-31c0485d5198@linux.intel.com>
References: <20221118122539.384993-1-brgl@bgdev.pl> <20221118122539.384993-5-brgl@bgdev.pl>
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
> The member we want to resolve in struct qcom_geni_serial_port is called
> uport so we don't need an additional redundant parameter in this macro.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 33 +++++++++++++--------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 97ee7c074b79..1db2795804e9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -133,8 +133,7 @@ static const struct uart_ops qcom_geni_uart_pops;
>  static struct uart_driver qcom_geni_console_driver;
>  static struct uart_driver qcom_geni_uart_driver;
>  
> -#define to_dev_port(ptr, member) \
> -		container_of(ptr, struct qcom_geni_serial_port, member)
> +#define to_dev_port(ptr) container_of(ptr, struct qcom_geni_serial_port, uport)

Make this a static inline now that you're touching it.

-- 
 i.


>  static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
>  	[0] = {
> @@ -175,7 +174,7 @@ static struct qcom_geni_serial_port qcom_geni_console_port = {
>  static int qcom_geni_serial_request_port(struct uart_port *uport)
>  {
>  	struct platform_device *pdev = to_platform_device(uport->dev);
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	uport->membase = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(uport->membase))
> @@ -212,7 +211,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>  							unsigned int mctrl)
>  {
>  	u32 uart_manual_rfr = 0;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	if (uart_console(uport))
>  		return;
> @@ -253,7 +252,7 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
>  	struct qcom_geni_private_data *private_data = uport->private_data;
>  
>  	if (private_data->drv) {
> -		port = to_dev_port(uport, uport);
> +		port = to_dev_port(uport);
>  		baud = port->baud;
>  		if (!baud)
>  			baud = 115200;
> @@ -506,7 +505,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>  	u32 i;
>  	unsigned char buf[sizeof(u32)];
>  	struct tty_port *tport;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	tport = &uport->state->port;
>  	for (i = 0; i < bytes; ) {
> @@ -549,7 +548,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
>  static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
>  {
>  	struct tty_port *tport;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	u32 num_bytes_pw = port->tx_fifo_width / BITS_PER_BYTE;
>  	u32 words = ALIGN(bytes, num_bytes_pw) / num_bytes_pw;
>  	int ret;
> @@ -598,7 +597,7 @@ static void qcom_geni_serial_stop_tx(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
>  	irq_en &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
> @@ -627,7 +626,7 @@ static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop)
>  	u32 last_word_byte_cnt;
>  	u32 last_word_partial;
>  	u32 total_bytes;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	status = readl(uport->membase +	SE_GENI_RX_FIFO_STATUS);
>  	word_cnt = status & RX_FIFO_WC_MSK;
> @@ -649,7 +648,7 @@ static void qcom_geni_serial_stop_rx(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	u32 s_irq_status;
>  
>  	irq_en = readl(uport->membase + SE_GENI_S_IRQ_EN);
> @@ -687,7 +686,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>  {
>  	u32 irq_en;
>  	u32 status;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	status = readl(uport->membase + SE_GENI_STATUS);
>  	if (status & S_GENI_CMD_ACTIVE)
> @@ -707,7 +706,7 @@ static void qcom_geni_serial_start_rx(struct uart_port *uport)
>  static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
>  		bool active)
>  {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	struct circ_buf *xmit = &uport->state->xmit;
>  	size_t avail;
>  	size_t remaining;
> @@ -803,7 +802,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>  	struct uart_port *uport = dev;
>  	bool drop_rx = false;
>  	struct tty_port *tport = &uport->state->port;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	if (uport->suspended)
>  		return IRQ_NONE;
> @@ -869,7 +868,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
>  
>  static int qcom_geni_serial_port_setup(struct uart_port *uport)
>  {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
>  	u32 proto;
>  	u32 pin_swap;
> @@ -917,7 +916,7 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>  static int qcom_geni_serial_startup(struct uart_port *uport)
>  {
>  	int ret;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	if (!port->setup) {
>  		ret = qcom_geni_serial_port_setup(uport);
> @@ -1003,7 +1002,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>  	u32 stop_bit_len;
>  	unsigned int clk_div;
>  	u32 ser_clk_cfg;
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  	unsigned long clk_rate;
>  	u32 ver, sampling_rate;
>  	unsigned int avg_bw_core;
> @@ -1288,7 +1287,7 @@ static struct uart_driver qcom_geni_uart_driver = {
>  static void qcom_geni_serial_pm(struct uart_port *uport,
>  		unsigned int new_state, unsigned int old_state)
>  {
> -	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
> +	struct qcom_geni_serial_port *port = to_dev_port(uport);
>  
>  	/* If we've never been called, treat it as off */
>  	if (old_state == UART_PM_STATE_UNDEFINED)
> 
