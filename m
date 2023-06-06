Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B705E72412B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjFFLk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjFFLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:40:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386510CE;
        Tue,  6 Jun 2023 04:39:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74C236606EB5;
        Tue,  6 Jun 2023 12:39:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686051591;
        bh=aTOiB1WUAchQeXSapkz3ePBm+TJmWUkMK13QQnVxEaU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mTj8Bvle/QR4IRP4nYvzPVOvgc3fpv94wAG5kR4dxKXc7sRqp+KORHfzDBy03mzAb
         sxXyR7txUP0XafUsaHmHVyOZJ0qw+xkVGp9gw5EOqXLYKV7nIJFAHn9bNVq4X1HDhA
         qoukPuPGRsOTfKWt+NnFa10yQQf5cSVqtSl+SZjkBLnt4NikD7Vgstm+QD7XULNrtI
         ZAVlxKMuMFckAcnDDqTbsVKPD/QPTZx+VW+AAVB2Ftv+A0Qyesf0hHWGx2egAJiwib
         Ab/qwAMQ0AjhP4KkhQFIg+MCCIIHJ7ezGJMCk3pcZGjnEjkmW1y1pfaHGe3jnz3y99
         lOEbjynplSBhQ==
Message-ID: <b8f43743-9c60-a138-0606-93873719da7c@collabora.com>
Date:   Tue, 6 Jun 2023 13:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] serial: 8250_mtk: Simplify clock sequencing and runtime
 PM
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
References: <20230606091747.2031168-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230606091747.2031168-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/06/23 11:17, Chen-Yu Tsai ha scritto:
> The 8250_mtk driver's runtime PM support has some issues:
> 
> - The bus clock is enabled (through runtime PM callback) later than a
>    register write
> - runtime PM resume callback directly called in probe, but no
>    pm_runtime_set_active() call is present
> - UART PM function calls the callbacks directly, _and_ calls runtime
>    PM API
> - runtime PM callbacks try to do reference counting, adding yet another
>    count between runtime PM and clocks
> 
> This fragile setup worked in a way, but broke recently with runtime PM
> support added to the serial core. The system would hang when the UART
> console was probed and brought up.
> 
> Tony provided some potential fixes [1][2], though they were still a bit
> complicated. The 8250_dw driver, which the 8250_mtk driver might have
> been based on, has a similar structure but simpler runtime PM usage.
> 
> Simplify clock sequencing and runtime PM support in the 8250_mtk driver.
> Specifically, the clock is acquired enabled and assumed to be active,
> unless toggled through runtime PM suspend/resume. Reference counting is
> removed and left to the runtime PM core. The serial pm function now
> only calls the runtime PM API.
> 
> [1] https://lore.kernel.org/linux-serial/20230602092701.GP14287@atomide.com/
> [2] https://lore.kernel.org/linux-serial/20230605061511.GW14287@atomide.com/
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/tty/serial/8250/8250_mtk.c | 50 ++++++------------------------
>   1 file changed, 10 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index aa8e98164d68..74da5676ce67 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -431,12 +431,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
>   	while
>   		(serial_in(up, MTK_UART_DEBUG0));
>   
> -	if (data->clk_count == 0U) {
> -		dev_dbg(dev, "%s clock count is 0\n", __func__);
> -	} else {
> -		clk_disable_unprepare(data->bus_clk);
> -		data->clk_count--;
> -	}
> +	clk_disable_unprepare(data->bus_clk);
>   
>   	return 0;
>   }
> @@ -444,19 +439,8 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
>   static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
>   {
>   	struct mtk8250_data *data = dev_get_drvdata(dev);
> -	int err;
>   
> -	if (data->clk_count > 0U) {
> -		dev_dbg(dev, "%s clock count is %d\n", __func__,
> -			data->clk_count);
> -	} else {
> -		err = clk_prepare_enable(data->bus_clk);
> -		if (err) {
> -			dev_warn(dev, "Can't enable bus clock\n");
> -			return err;
> -		}
> -		data->clk_count++;
> -	}
> +	clk_prepare_enable(data->bus_clk);
>   
>   	return 0;
>   }
> @@ -465,14 +449,12 @@ static void
>   mtk8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
>   {
>   	if (!state)
> -		if (!mtk8250_runtime_resume(port->dev))
> -			pm_runtime_get_sync(port->dev);
> +		pm_runtime_get_sync(port->dev);
>   
>   	serial8250_do_pm(port, state, old);
>   
>   	if (state)
> -		if (!pm_runtime_put_sync_suspend(port->dev))
> -			mtk8250_runtime_suspend(port->dev);
> +		pm_runtime_put_sync_suspend(port->dev);
>   }
>   
>   #ifdef CONFIG_SERIAL_8250_DMA
> @@ -504,7 +486,7 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
>   		return 0;
>   	}
>   
> -	data->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +	data->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
>   	if (IS_ERR(data->bus_clk))
>   		return PTR_ERR(data->bus_clk);
>   
> @@ -587,25 +569,16 @@ static int mtk8250_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, data);
>   
> -	pm_runtime_enable(&pdev->dev);
> -	err = mtk8250_runtime_resume(&pdev->dev);
> -	if (err)
> -		goto err_pm_disable;
> -
>   	data->line = serial8250_register_8250_port(&uart);
> -	if (data->line < 0) {
> -		err = data->line;
> -		goto err_pm_disable;
> -	}
> +	if (data->line < 0)
> +		return data->line;
>   
>   	data->rx_wakeup_irq = platform_get_irq_optional(pdev, 1);
>   
> -	return 0;
> -
> -err_pm_disable:
> -	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>   
> -	return err;
> +	return 0;
>   }
>   
>   static int mtk8250_remove(struct platform_device *pdev)
> @@ -619,9 +592,6 @@ static int mtk8250_remove(struct platform_device *pdev)
>   	pm_runtime_disable(&pdev->dev);
>   	pm_runtime_put_noidle(&pdev->dev);
>   
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> -		mtk8250_runtime_suspend(&pdev->dev);
> -
>   	return 0;
>   }
>   

