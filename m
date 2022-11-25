Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE29638891
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKYLUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiKYLTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:50 -0500
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3479F27B0C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:19:48 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id yWk8ogLXMFUJ3yWk9o95Fd; Fri, 25 Nov 2022 12:19:43 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Nov 2022 12:19:43 +0100
X-ME-IP: 86.243.100.34
Message-ID: <43480917-dbe8-2b0c-3806-00f142d417d4@wanadoo.fr>
Date:   Fri, 25 Nov 2022 12:19:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] serial: tegra: Add missing clk_disable_unprepare() in
 tegra_uart_hw_init()
To:     yiyang13@huawei.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com
References: <20221125101109.175394-1-yiyang13@huawei.com>
Content-Language: fr, en-CA
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221125101109.175394-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/11/2022 à 11:11, Yi Yang a écrit :
> Add the missing clk_disable_unprepare() before return from
> tegra_uart_hw_init() in the error handling path.
> 
> Fixes: cc9ca4d95846 ("serial: tegra: Only print FIFO error message when an error occurs")
> Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
> Signed-off-by: Yi Yang <yiyang13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/tty/serial/serial-tegra.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Hi,

I think that it is also missing in tegra_uart_startup() if an error 
occurs after a successful tegra_uart_hw_init() call.

Or maybe (based on function mane) tegra_uart_hw_deinit() should called 
there.

Just my 2c.

CJ


> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index e5b9773db5e3..abc5039eb273 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -1046,6 +1046,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>   	if (tup->cdata->fifo_mode_enable_status) {
>   		ret = tegra_uart_wait_fifo_mode_enabled(tup);
>   		if (ret < 0) {
> +			clk_disable_unprepare(tup->uart_clk);
>   			dev_err(tup->uport.dev,
>   				"Failed to enable FIFO mode: %d\n", ret);
>   			return ret;
> @@ -1067,6 +1068,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
>   	 */
>   	ret = tegra_set_baudrate(tup, TEGRA_UART_DEFAULT_BAUD);
>   	if (ret < 0) {
> +		clk_disable_unprepare(tup->uart_clk);
>   		dev_err(tup->uport.dev, "Failed to set baud rate\n");
>   		return ret;
>   	}

