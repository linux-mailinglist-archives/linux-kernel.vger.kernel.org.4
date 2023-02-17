Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB769A7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBQJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBQJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:17:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F05E59C;
        Fri, 17 Feb 2023 01:17:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C05B615B5;
        Fri, 17 Feb 2023 09:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F29C433EF;
        Fri, 17 Feb 2023 09:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676625464;
        bh=bZNPZdaHcY8OMbBMrEDaxJlVQ7RjxEFNxQHJdZsl+hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3Pfe9QJjnlbDDhlwctILyxo30xaao8fpR1rb4paFCv+BXaogyLBMUhox5a+/FZoe
         y4OEqq7Oz69+qBvXTZf4d5kaZEDfa0faLbZTKL2XI7yh4pPvYiQdOqh0sB/5pwVkdB
         RNVfGqNe7rePBzqeCaKHszZjIttUp1uYsWwR6s1Q=
Date:   Fri, 17 Feb 2023 10:17:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        l.sanfilippo@kunbus.com, andy.shevchenko@gmail.com,
        peter_hong@fintek.com.tw, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH] serial: 8250_fintek: Add using BIOS IRQ default setting
Message-ID: <Y+9GNsYQz3Z6KioX@kroah.com>
References: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217084953.2580-1-hpeter+linux_kernel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 04:49:53PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> In 8250_fintek.c probe_setup_port(), we'll detect the IRQ trigger mode by
> irq_get_irq_data() and pass it to fintek_8250_set_irq_mode(). If detected
> Edge mode, we'll set the UART with Edge/High mode, otherwise Level/Low.
> 
> But in some motherboard, The APIC maybe setting to Level/High. In this case
> the driver will setting wrong configuration into UART. So we add a option
> to kernel parameter to control the driver as following:
> 
> 	fintek_uart_irq_mode_override= [SERIAL]
> 		{default, bios}
> 		If the parameter is "default", the driver will using
> 		former IRQ override methed(By IRQ trigger type).
> 		otherwise, we'll don't change the UART IRQ setting.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_fintek.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
> index dba5950b8d0e..c5fea0a7c79b 100644
> --- a/drivers/tty/serial/8250/8250_fintek.c
> +++ b/drivers/tty/serial/8250/8250_fintek.c
> @@ -92,6 +92,9 @@
>  #define F81866_UART_CLK_18_432MHZ BIT(0)
>  #define F81866_UART_CLK_24MHZ BIT(1)
> 
> +#define FINTEK_IRQ_MODE_BY_DETECT	0
> +#define FINTEK_IRQ_MODE_BY_BIOS		1
> +
>  struct fintek_8250 {
>  	u16 pid;
>  	u16 base_port;
> @@ -99,6 +102,24 @@ struct fintek_8250 {
>  	u8 key;
>  };
> 
> +static int not_override_irq_mode = FINTEK_IRQ_MODE_BY_DETECT;
> +
> +static int __init parse_uart_irq_mode_override(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (strcmp(arg, "bios") == 0)
> +		not_override_irq_mode = FINTEK_IRQ_MODE_BY_BIOS;
> +	else if (strcmp(arg, "default") == 0)
> +		not_override_irq_mode = FINTEK_IRQ_MODE_BY_DETECT;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("fintek_uart_irq_mode_override", parse_uart_irq_mode_override);

Sorry, but no, this will not work with multiple devices.  Please fix the
bios to handle this all properly, do not require users to manually fix
up problems for you (i.e. fix it once, not in thousands of individual
systems.)

> +
>  static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
>  {
>  	outb(reg, pdata->base_port + ADDR_PORT);
> @@ -248,6 +269,12 @@ static int fintek_8250_rs485_config(struct uart_port *port,
> 
>  static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
>  {
> +	if (not_override_irq_mode == FINTEK_IRQ_MODE_BY_BIOS) {
> +		pr_info("Fintek UART(%04x) irq mode is using BIOS default",
> +				pdata->pid);

Note, this is a driver, always use dev_*() calls, never pr_*() calls.

thanks,

greg k-h
