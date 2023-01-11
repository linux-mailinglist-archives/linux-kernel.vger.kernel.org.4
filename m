Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF2665403
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAKFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjAKFxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:53:42 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F7A1BC;
        Tue, 10 Jan 2023 21:53:36 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so13557589wms.0;
        Tue, 10 Jan 2023 21:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFEcAp58L6/Lgz+twHfiRQkPVjyan/i1u3ORD6cFNFI=;
        b=KeZowzqQ9MspAdIJzDlAMNZMC6iod3fcHDzB2oGMsZbZ6D+znLnWt/w/ynWG5fdCDo
         bELmunWvazlZ1b57OXPqP7TI3cn8WPTXFDsyqqxlaElUXSxav7dCNx+pVADxS0582Obb
         3uHrpzUTpsNLdOZYYacDoQWR700M/gpEgtAbUxJex5IVmZKEWHgRqFBXzKL9wrzOmTLt
         sSL1zDcVvUc02gKQ/oHVvZvU9bcMalWHWVuveyC5G2Fsx8MBiLcpf+f1xK2QxNIzhQkR
         ER/0If6Xq6VqlxTbEdZ2dC6rbfWbwIWFhDJusgxdxKtQKca6D2aQSkWzCDG012jQB10E
         slTw==
X-Gm-Message-State: AFqh2ko8IwH80FmSIT7p2HC9E2Pce48riYYQU6KSu6SgzKg0ZWGj/qPE
        gk90bUo9QjSPMYAgjkCruO4=
X-Google-Smtp-Source: AMrXdXvrZE3tVJsikm25JOmVQtF8OzCR58hY5jxObYKZSL9DUDk/2N2c4Ldzo4F4+cEgUa9gGqsbSQ==
X-Received: by 2002:a7b:cd11:0:b0:3d9:e9ad:d9bf with SMTP id f17-20020a7bcd11000000b003d9e9add9bfmr9546875wmj.6.1673416414956;
        Tue, 10 Jan 2023 21:53:34 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c228200b003d9e00dfccfsm14455359wmf.8.2023.01.10.21.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 21:53:34 -0800 (PST)
Message-ID: <8d3470db-b0c9-017a-fac3-c23239da3413@kernel.org>
Date:   Wed, 11 Jan 2023 06:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 05/13] serial: Convert uart_{,port_}startup() init_hw
 param to bool
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
 <20230110120226.14972-6-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230110120226.14972-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 01. 23, 13:02, Ilpo Järvinen wrote:
> Convert init_hw parameter in uart_startup() and uart_port_startup() to
> bool as code treats them like bool.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/serial_core.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c881fefa3d97..f7074ac02801 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -182,7 +182,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>    * will be serialised by the per-port mutex.
>    */
>   static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> -		int init_hw)
> +			     bool init_hw)
>   {
>   	struct uart_port *uport = uart_port_check(state);
>   	unsigned long flags;
> @@ -254,7 +254,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>   }
>   
>   static int uart_startup(struct tty_struct *tty, struct uart_state *state,
> -		int init_hw)
> +			bool init_hw)
>   {
>   	struct tty_port *port = &state->port;
>   	int retval;
> @@ -997,7 +997,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>   			uart_change_speed(tty, state, NULL);
>   		}
>   	} else {
> -		retval = uart_startup(tty, state, 1);
> +		retval = uart_startup(tty, state, true);
>   		if (retval == 0)
>   			tty_port_set_initialized(port, true);
>   		if (retval > 0)
> @@ -1165,7 +1165,7 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
>   		 */
>   		uport->ops->config_port(uport, flags);
>   
> -		ret = uart_startup(tty, state, 1);
> +		ret = uart_startup(tty, state, true);
>   		if (ret == 0)
>   			tty_port_set_initialized(port, true);
>   		if (ret > 0)
> @@ -1943,7 +1943,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
>   	/*
>   	 * Start up the serial port.
>   	 */
> -	ret = uart_startup(tty, state, 0);
> +	ret = uart_startup(tty, state, false);
>   	if (ret > 0)
>   		tty_port_set_active(port, true);
>   

-- 
js
suse labs

