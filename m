Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3746ED022
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjDXOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:16:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F77AB5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:16:28 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qwzPpkLGBbTpSqwzPpTfQr; Mon, 24 Apr 2023 16:16:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682345786;
        bh=0B4HsNB6x5ONknrYsL/C1v/q+uPV4H6LnAZ9l2J4F0E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FElLV2h+PGIvLa/VsW01tvBO2eOdLnIiCsKJYnzPNGJhmLC+w7kPd2rCFZ2HcDKnr
         QfQCBl/Y+uNUTLDaidnN+dDkqlqDuwM95O8QVYAJkp82bVB4fggPbjyVB5uS0qHw3k
         uP68wUTlTO9XeaAsOVZTxRFPmgPoxRQU+g/1/zVzDVzPIHaqTJ8qAZXYBW8zQuMgYP
         SJmambNGGov9oKxUpIaIarvv4ZD9DLi39VXFfFEUMzGGCe+EQVYtLotpk5vfhlszcK
         L6GoKYlvtcmFQrrYgLiTtmeeYi6HMjSyh6hqNKb/0Xi9Mv3beuv1ZjcluCd7cD72gL
         ZmVGTRdFidp6Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 16:16:26 +0200
X-ME-IP: 86.243.2.178
Message-ID: <5a6d9e93-0c3b-e1da-a577-6aca894356f8@wanadoo.fr>
Date:   Mon, 24 Apr 2023 16:16:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Content-Language: fr
To:     XuDong Liu <m202071377@hust.edu.cn>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424125100.4783-1-m202071377@hust.edu.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230424125100.4783-1-m202071377@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/04/2023 à 14:51, XuDong Liu a écrit :
> Smatch reports:
> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
> 
> In the function brcmuart_probe(), baud_mux_clk was not correctly released
> in subsequent error handling, which may cause memory leaks.
> 
> To fix this issue, an error handling branch, err_clk_put, is added to
> release the variable using clk_put(), and an err_disable branch is added
> to meet the requirement of balancing clk_disable and clk_enable calls.
> 
> Fixes: 15ac1122fd6d ("serial: 8250_bcm7271: Fix arbitration handling")
> Signed-off-by: XuDong Liu <m202071377@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is discovered by static analysis, and the patch is not tested
> yet.
> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index f801b1f5b46c..b1670558868b 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1023,7 +1023,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   		dev_dbg(dev, "BAUD MUX clock found\n");
>   		ret = clk_prepare_enable(baud_mux_clk);
>   		if (ret)
> -			goto release_dma;
> +			goto err_clk_put;
>   		priv->baud_mux_clk = baud_mux_clk;
>   		init_real_clk_rates(dev, priv);
>   		clk_rate = priv->default_mux_rate;
> @@ -1032,7 +1032,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	if (clk_rate == 0) {
>   		dev_err(dev, "clock-frequency or clk not defined\n");
>   		ret = -EINVAL;
> -		goto release_dma;
> +		goto err_clk_disable;
>   	}
>   
>   	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
> @@ -1119,6 +1119,10 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	serial8250_unregister_port(priv->line);
>   err:
>   	brcmuart_free_bufs(dev, priv);
> +err_clk_disable:
> +	clk_disable_unprepare(baud_mux_clk);
> +err_clk_put:
> +	clk_put(baud_mux_clk);
>   release_dma:
>   	if (priv->dma_enabled)
>   		brcmuart_arbitration(priv, 0);

Hi,

it is likely that it should also be added to the rmove function.

CJ
