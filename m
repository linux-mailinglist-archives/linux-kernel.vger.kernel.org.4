Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB765E584
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjAEGTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAEGTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:19:39 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6A63FE;
        Wed,  4 Jan 2023 22:19:38 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso554965wms.5;
        Wed, 04 Jan 2023 22:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMhTa8031xnJCr78Gg3MxS4F8Q+GpLcOHRVjapQT5tQ=;
        b=GDuEYTGHUvAkQfu4Jz/oKEda42zNak78B6+NTm8++HZxsmMuhNu85ffpfVaA10g33d
         sJUgY6mgPnV1BttjvetdlwN0TtBQWiCwkNVll0F5RXVNaGZXIowKauAkTppaeLwo49lb
         Klk04DAJbdWRLbvNyRyKVz6GM7lrdxYJ2WaY09cvG0wrxsUM//BTDOQGGoFvMPJIG4DG
         vQRaGgsURN5TmSkPWXf6NbowAoBrYyMbpVQFyCzuK9vGc5Thd0uCfgR4SmLFS1MAuq9j
         kKAG/XmgSVKlq7EKwsma/OEit5u2iiu3YGSuPtuGBLSbZ2BkdNQqTe7m1TjncFm3ygWN
         MpUw==
X-Gm-Message-State: AFqh2kooEK7DbD/PsHMb7Z7eTTtYVartsRCeAS7n41tmGisGH30Xbo6y
        5F1Zrt2Ixr6bsPHtoNZanVE=
X-Google-Smtp-Source: AMrXdXvnbuIqp+JAgFHrP0UKIr61/hDJcQemGGF6LX9p8WLjDYXsDs+9lWsr5CrFNlnRZz9V75Ka4w==
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr35818833wmb.0.1672899577065;
        Wed, 04 Jan 2023 22:19:37 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id q187-20020a1c43c4000000b003c6c182bef9sm1319688wma.36.2023.01.04.22.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:19:36 -0800 (PST)
Message-ID: <09043f30-c516-e173-3836-5e5dd5f5c472@kernel.org>
Date:   Thu, 5 Jan 2023 07:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-8-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 07/10] tty: Convert ->dtr_rts() to take bool argument
In-Reply-To: <20230104151531.73994-8-ilpo.jarvinen@linux.intel.com>
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
> Convert the raise/on parameter in ->dtr_rts() to bool through the
> callchain. The parameter is used like bool. In USB serial, there
> remains a few implicit bool -> larger type conversions because some
> devices use u8 in their control messages.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
...
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -378,7 +378,7 @@ static void async_mode(MGSLPC_INFO *info);
>   static void tx_timeout(struct timer_list *t);
>   
>   static bool carrier_raised(struct tty_port *port);
> -static void dtr_rts(struct tty_port *port, int onoff);
> +static void dtr_rts(struct tty_port *port, bool onoff);

Not anything for this patch, but having this dubbed "onoff" instead of 
"on" makes it really confusing.

> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -548,14 +548,14 @@ static bool uart_carrier_raised(struct tty_port *tport)
>    *	adjusted during an open, close and hangup.
>    */
>   
> -static void uart_dtr_rts(struct tty_port *tport, int onoff)
> +static void uart_dtr_rts(struct tty_port *tport, bool onoff)
>   {
>   	struct sdio_uart_port *port =
>   			container_of(tport, struct sdio_uart_port, port);
>   	int ret = sdio_uart_claim_func(port);
>   	if (ret)
>   		return;
> -	if (onoff == 0)
> +	if (!onoff)
>   		sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
>   	else
>   		sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);

Especially here. What does "!onoff" mean? If it were:

if (on)
   sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
else
   sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);

it would be a lot more clear.

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -1459,7 +1459,7 @@ static bool amiga_carrier_raised(struct tty_port *port)
>   	return !(ciab.pra & SER_DCD);
>   }
>   
> -static void amiga_dtr_rts(struct tty_port *port, int raise)
> +static void amiga_dtr_rts(struct tty_port *port, bool raise)

Or "raise". That makes sense too and we call it as such in 
tty_port_operations:

> --- a/include/linux/tty_port.h
> +++ b/include/linux/tty_port.h
...
> @@ -32,7 +32,7 @@ struct tty_struct;
>    */
>   struct tty_port_operations {
>   	bool (*carrier_raised)(struct tty_port *port);
> -	void (*dtr_rts)(struct tty_port *port, int raise);
> +	void (*dtr_rts)(struct tty_port *port, bool raise);
>   	void (*shutdown)(struct tty_port *port);
>   	int (*activate)(struct tty_port *port, struct tty_struct *tty);
>   	void (*destruct)(struct tty_port *port);

Care to fix that up too?

thanks,
-- 
js
suse labs

