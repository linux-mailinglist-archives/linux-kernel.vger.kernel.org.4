Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986465E567
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjAEGF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjAEGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:05:24 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D551331;
        Wed,  4 Jan 2023 22:05:20 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id m7so685366wrn.10;
        Wed, 04 Jan 2023 22:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO5ojAVw2HzC/9/8FWaFlQsaTbaoRAzFd6eVu5Ya8sg=;
        b=xT0S+TXIAolw+fn+jpv7MSZHPgycXfG37x4Kk3gA6wOCwkifwO0VyKpJR1kAEdStRZ
         gh+BcjJ9PMntYohLTR5S8nazJ+LkKV2I8moF/xQoSzTNEEgmIkAN1rX1W/+u1g8O7afm
         /bFt/H0EH1t3Ouo67LlpnPhtAw//yzQ+CnAYn6/IA1jl/Pd30N0jhu9V3ca27xslIkds
         prwOFS+vY7AT8z/me+OtCSf5l2i9U4pHoFO0auPYu12X4xud1sUkHW7s/cwN6UjCYnqT
         k+aMh3Y85lM/pIU7luS4hXY8ptwRm0YZO3BJgnvsxWAXYG9sb/5+P0MWpa/WLsyG6DHW
         Dm8w==
X-Gm-Message-State: AFqh2kq3mMgAm+xCfBhCsCcdnfwbYjSoJDpzGXTvi+tty4zVqn7yS6rT
        BIgSwT53x73zMxE3HjOhxsjQf2RzxUA=
X-Google-Smtp-Source: AMrXdXvXAtdCeTDTgH0Z9ePECCe8B57JnLQDN+8+esQvCgQ6qV7qH/gayoezLvdxbEqeivo5KCN4QQ==
X-Received: by 2002:a5d:63cb:0:b0:293:b54e:4f09 with SMTP id c11-20020a5d63cb000000b00293b54e4f09mr10256586wrw.4.1672898719183;
        Wed, 04 Jan 2023 22:05:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241fde8fe04sm35949467wri.7.2023.01.04.22.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:05:18 -0800 (PST)
Message-ID: <7ecfd7bc-8148-cadc-a58a-a2813b1862ac@kernel.org>
Date:   Thu, 5 Jan 2023 07:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 05/10] serial: Convert uart_{,port_}startup() init_hw
 param to bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-6-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 01. 23, 16:15, Ilpo Järvinen wrote:
> Convert init_hw parameter in uart_startup() and uart_port_startup() to
> bool as code treats them like bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/serial_core.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c881fefa3d97..a0260a40bdb9 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -181,8 +181,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>    * Startup the port.  This will be called once per open.  All calls
>    * will be serialised by the per-port mutex.
>    */
> -static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> -		int init_hw)
> +static int uart_port_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)
>   {
>   	struct uart_port *uport = uart_port_check(state);
>   	unsigned long flags;
> @@ -253,8 +252,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>   	return retval;
>   }
>   
> -static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> -		int init_hw)
> +static int uart_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)

You made both of them over 80 characters/line. Why?

thanks,
-- 
js
suse labs

