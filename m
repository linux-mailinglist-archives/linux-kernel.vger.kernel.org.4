Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27266EE079
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjDYKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjDYKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:38:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66092D52
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:38:30 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rG3ypeIHUNW2mrG3ypVMX1; Tue, 25 Apr 2023 12:38:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682419107;
        bh=bkk4QMvO+SU95aOVCgFeXzN50c8wR2cps94Hazrj99M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=azJNp5Wh2l54tl+VJUaEY34NL7noPHC6JNnHnvMSTjuYsan1uiAD+M757wxK5Zqyc
         xH0hpIjJLvkd4R4AR97xl4DcjymHieX6wxYC6QanXg8me7DKOYUohPQ27huO26+6Z7
         s7fVwelRDd2nsn8jnyDbUArYeTqGmbSJByknzKneWmS4wfNczl82upknJgH61C4dSL
         fyrsdIK5y9A12QuIJWwxYFno/13LG3VqAFVqtBVKZDWVs+n0yIY9SMvjIny6w8+w6Q
         nkTRUd0tpQR29m9oqQWAMpMmvzUqkaqjUvMVevO9hf4xBl2yXzVbxNlYpY1v9EpUO9
         oOUYn/utIqZ9Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 12:38:27 +0200
X-ME-IP: 86.243.2.178
Message-ID: <46933536-2999-c3b0-f3d3-60e8830f50a6@wanadoo.fr>
Date:   Tue, 25 Apr 2023 12:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 10/11] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: fr
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tmaimon77@gmail.com, catalin.marinas@arm.com, will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230425102418.185783-1-ychuang570808@gmail.com>
 <20230425102418.185783-11-ychuang570808@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230425102418.185783-11-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/04/2023 à 12:24, Jacky Huang a écrit :
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> This adds UART and console driver for Nuvoton ma35d1 Soc.
> It supports full-duplex communication, FIFO control, and
> hardware flow control.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>   drivers/tty/serial/Kconfig         |  18 +
>   drivers/tty/serial/Makefile        |   1 +
>   drivers/tty/serial/ma35d1_serial.c | 781 +++++++++++++++++++++++++++++
>   3 files changed, 800 insertions(+)
>   create mode 100644 drivers/tty/serial/ma35d1_serial.c
> 

[...]

> +static int ma35d1serial_probe(struct platform_device *pdev)
> +{
> +	struct resource *res_mem;
> +	struct uart_ma35d1_port *up;
> +	int ret = 0;
> +	struct clk *clk;
> +	int err;
> +
> +	if (pdev->dev.of_node) {
> +		ret = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	up = &ma35d1serial_ports[ret];
> +	up->port.line = ret;
> +	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res_mem)
> +		return -ENODEV;
> +
> +	up->port.iobase = res_mem->start;
> +	up->port.membase = devm_ioremap(&pdev->dev, up->port.iobase, UART_REG_SIZE);
> +	up->port.ops = &ma35d1serial_ops;
> +
> +	spin_lock_init(&up->port.lock);
> +
> +	clk = of_clk_get(pdev->dev.of_node, 0);

Does this...

> +	if (IS_ERR(clk)) {
> +		err = PTR_ERR(clk);
> +		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> +		return -ENOENT;
> +	}
> +
> +	err = clk_prepare_enable(clk);

... and this be undone in the remove function?

CJ

> +	if (err)
> +		return -ENOENT;
> +
> +	if (up->port.line != 0)
> +		up->port.uartclk = clk_get_rate(clk);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;
> +	up->port.irq = ret;
> +	up->port.dev = &pdev->dev;
> +	up->port.flags = UPF_BOOT_AUTOCONF;
> +
> +	platform_set_drvdata(pdev, up);
> +
> +	return uart_add_one_port(&ma35d1serial_reg, &up->port);
> +}

[...]

