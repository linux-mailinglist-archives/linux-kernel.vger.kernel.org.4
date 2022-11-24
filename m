Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4398F637778
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKXLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKXLTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:19:32 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB07A10569;
        Thu, 24 Nov 2022 03:19:31 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id n21so3426448ejb.9;
        Thu, 24 Nov 2022 03:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2M1MbZIrpYHpLP2dD6R/gFu6dOExd21XFUG3ohljI0=;
        b=7zVsM6DVGHCowX6pBzJTPhG+i1AVlMDuSxOMBPTrosjmAFEIzmUzSWuACofcFzuIGX
         wpSHMQF2xnV3ZcrHTt1yECWKJ6Selv8qCHaiB3FfqJTpQOZSTwU+oJ4goO3OYgqw6EKX
         ZNZ79ZZGZ/EidlSUCOtz8wj6hA5eAHzdospmACd1m9/AVlfWI1oL82xZiMeiJ8Cq03Gb
         al/NomrJrHvtn3gjjcSz60IJMLGDYTlGz/kXhqZksKr79M47Q/pnbaF2h6vPcx1kQNX+
         1f/4eE+byVTR8HTeksNCRhP2EnS06xokcehmbJ4XG7MmUS1nRaTbkIwAEpRpnxBZEYEd
         mSHg==
X-Gm-Message-State: ANoB5pmiN/i9MFs6GAOb7zFqAutJhE8NkrrfMjN2MTthU1gY9WDS27+2
        g9d67ei+YYCaQKlSG02ypbuOnUD89g0=
X-Google-Smtp-Source: AA0mqf7NnC7pbq0ixP6QKvrRPGY/8WkUt9XToJObO63R3P5XfPht2koY4UPOx4VuF+vwZKISpR7AHQ==
X-Received: by 2002:a17:906:8e0a:b0:7b9:bef6:3eea with SMTP id rx10-20020a1709068e0a00b007b9bef63eeamr6416300ejc.487.1669288769944;
        Thu, 24 Nov 2022 03:19:29 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id l17-20020a056402125100b00463c367024bsm386940edw.63.2022.11.24.03.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:19:29 -0800 (PST)
Message-ID: <140187ba-7d2c-8b7b-e172-7350eed458be@kernel.org>
Date:   Thu, 24 Nov 2022 12:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221123-serial-clk-v2-0-9c03ce8940d8@chromium.org>
 <20221123-serial-clk-v2-2-9c03ce8940d8@chromium.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] earlycon: Let users set the clock frequency
In-Reply-To: <20221123-serial-clk-v2-2-9c03ce8940d8@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24. 11. 22, 11:02, Ricardo Ribalda wrote:
...
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -120,9 +120,15 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>   	}
>   
>   	if (options) {
> +		char *uartclk;
> +
>   		if (kstrtouint(options, 0, &device->baud) < 0)
>   			pr_warn("[%s] unsupported earlycon baud rate option\n",
>   				options);

IMO this won't work if there is a comma in options (i.e. your new 
clkrate param). kstrtouint will return -EINVAL in that case.

> +		uartclk = strchr(options, ',');
> +		if (uartclk && kstrtouint(uartclk, 0, &port->uartclk) < 0)

You are giving ",number" to kstrtouint, right? That won't work either ;).

regards,
-- 
js

