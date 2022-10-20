Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5D60570D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJTF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJTF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:56:10 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A7A1870B9;
        Wed, 19 Oct 2022 22:56:07 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id w18so32563165wro.7;
        Wed, 19 Oct 2022 22:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4MvR28c36adEifSdnseDvQ9P1t97q1voP7IqxbBr6s=;
        b=1VaZfAWk1sE63+uKSuONlV1sYHzJeWAv48XNyVRi5Ej1iNeVqbR35axez1bBZ7ikom
         GD2Uf0J+MHgzJY0mnojMacVAckvreJDcIlJYWF1e/AelTQZouvnyfMJYNpk+elxhhN74
         Lxh9bpFHqdDfEU0Ejx74ExixywD4OK6qFIUEgbcq1mmTad4WMmFk81+wHd05JLWXbyWg
         5cQk3PvNbfcPwZs9EkkEjLq0CL9HiQ9Gk/9IjZILFVBNeH0I3syrYjMytCiPQhQPOTrd
         oFD8obr+ysFIRllkTO47WDXgCuHJ/wZPS4JwyKVKw7aD20DRUPIE5s4/C2TpFCll1KuK
         upgg==
X-Gm-Message-State: ACrzQf3jbuszPVpMfYIn/iOIrSaFDHJacQbq+hdut51cImiUbci0gMH/
        4B7rv818mUaRCqzHevn7iO/8Mga1/c/G6w==
X-Google-Smtp-Source: AMsMyM5NnAB7vSAo8Ki7rsAP0aYljmvUJnjkIxJ46FctxNJ/oSkGVbLbTesB0+mNrM8hXWIxbvT4jA==
X-Received: by 2002:adf:edd1:0:b0:22e:5257:a19e with SMTP id v17-20020adfedd1000000b0022e5257a19emr6942963wro.180.1666245366108;
        Wed, 19 Oct 2022 22:56:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003b47b913901sm4309263wmo.1.2022.10.19.22.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 22:56:05 -0700 (PDT)
Message-ID: <2040575a-2378-ef7a-8a23-b2458d3103f6@kernel.org>
Date:   Thu, 20 Oct 2022 07:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        lukas@wunner.de, ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20221019110720.31722-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
In-Reply-To: <20221019110720.31722-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 22, 13:07, Sherry Sun wrote:
> lpuart_global_reset() shouldn't break the on-going transmit engin, need

"engine"

> to recover the on-going data transfer after reset.
> 
> This can help earlycon here, since commit 60f361722ad2 ("serial:
> fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
> before uart_add_one_port(), earlycon is writing during global reset,
> as global reset will disable the TX and clear the baud rate register,
> which caused the earlycon cannot work any more after reset, needs to
> restore the baud rate and re-enable the transmitter to recover the
> earlycon write.
> 
> Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. The while loop may never exit as the stat and sfifo are not re-read inside
> the loop, fix that.
> ---
>   drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 67fa113f77d4..9a0781395b1f 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port *sport)
>   {
>   	struct uart_port *port = &sport->port;
>   	void __iomem *global_addr;
> +	unsigned long tx_enable, bd;
>   	int ret;
>   
> -	if (uart_console(port))
> -		return 0;
> -
>   	ret = clk_prepare_enable(sport->ipg_clk);
>   	if (ret) {
>   		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
> @@ -420,11 +418,29 @@ static int lpuart_global_reset(struct lpuart_port *sport)
>   	}
>   
>   	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
> +		/*
> +		 * If the transmitter is used by earlycon, wait transmit engin complete

"wait for transmit engine to complete"

> +		 * and then reset

"." (add a period)

> +		 */
> +		tx_enable = lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
> +		if (tx_enable) {
> +			bd = lpuart32_read(&sport->port, UARTBAUD);
> +			while (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_TC &&
> +				 lpuart32_read(port, UARTFIFO) & UARTFIFO_TXEMPT))
> +				cpu_relax();

If the HW is stuck, you make the kernel stuck too. What about 
read_poll_timeout_atomic(). Or at least a custom timeout.

> +		}
> +
>   		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
>   		writel(UART_GLOBAL_RST, global_addr);
>   		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
>   		writel(0, global_addr);
>   		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
> +
> +		/* Recover the transmitter for earlycon */
> +		if (tx_enable) {
> +			lpuart32_write(port, bd, UARTBAUD);
> +			lpuart32_write(port, UARTCTRL_TE, UARTCTRL);

I don't know the HW. Is it enough to write TE here? IOW shouldn't we 
preserve the whole register content from the above read here?

thanks,
-- 
js
suse labs

