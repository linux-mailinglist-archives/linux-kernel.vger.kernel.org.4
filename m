Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83E76F0D22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjD0U3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjD0U3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:29:39 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885644236
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:29:38 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id s8FCpJCcq9Qtjs8FCpvUK5; Thu, 27 Apr 2023 22:29:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682627376;
        bh=1rsbZtenHmrnqF4Ffk+H2ILDLPPocKXAqSr9a8KsmVQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YfPbKyrO2pe5kB/c6GCh9r1DveBEBvc6MPrDkGfciG/EuieQ+ED+Kzem0wR5xNxFJ
         4APp/yRWPBksSycpJWsgCUcMaM372gtwgbWI67LkOrZcqmfprB47wPczQ8e6WkkWSX
         yZJ70o6I/+MSgSA3pAL9PW7tuVnd3b6/Cs4tyNzkVnVteP5e5ZjmN4P3U7S7cGoWG5
         pGB4RXCg1u/fmkoaVCfpGM2BDT+A+y1MIyM3W28ehz/bunV2F5/I6/xRmj+wR04aPb
         PKM6iaYzXPCXBRuUG7aXj88OwZmzeuk4KFckHLyi3UwQ706+0WreLNEHihFPm8h8cp
         sZXwq7gvpZskQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 27 Apr 2023 22:29:36 +0200
X-ME-IP: 86.243.2.178
Message-ID: <37c23054-1590-b33d-9299-7d5d6198f8f0@wanadoo.fr>
Date:   Thu, 27 Apr 2023 22:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
To:     Doug Berger <opendmb@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230427181916.2983697-1-opendmb@gmail.com>
 <20230427181916.2983697-3-opendmb@gmail.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230427181916.2983697-3-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/04/2023 à 20:19, Doug Berger a écrit :
> Smatch reports:
> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
> 
> The issue is fixed by using a managed clock.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Reported-by: XuDong Liu <m202071377@hust.edu.cn>
> Link: https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>   drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index 90ee7bc12f77..af0e1c070187 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1012,7 +1012,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>   	of_property_read_u32(np, "clock-frequency", &clk_rate);
>   
>   	/* See if a Baud clock has been specified */
> -	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
> +	baud_mux_clk = devm_clk_get(dev, "sw_baud");

If switching to devm_clk_get(), maybe devm_clk_get_enabled() could also 
be an option to fix both issues and avoid adding some LoC.

The order of operation in the remove function would then be different. I 
don't know if it can be an issue.

Just my 2c.

CJ

>   	if (IS_ERR(baud_mux_clk)) {
>   		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
>   			ret = -EPROBE_DEFER;

