Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4B65E560
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAEGDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjAEGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:03:36 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C95274A;
        Wed,  4 Jan 2023 22:03:32 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id ja17so27255356wmb.3;
        Wed, 04 Jan 2023 22:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19Y2P7V2t+2ZRZgLAXjvRDt8CKL07d40Bou6MZtBRRs=;
        b=disW6rJed8YzOsZg7uj2rRxre83r3ul6ygZcxplwGg8ymF+TL4PovGSWDve09XBYOJ
         ZbcBLh/f8zhuONNiXhiRkICWAiRpN3PF8uZ+KE3efZDbcVbAFj7Uj0SV3fLqbm1x7wA3
         fxGGpxMrNaoldYFnIpMUAp/Si0czEableoXsCtDlorqD8iUBwVopWdhr1HfOcu0iN3Ny
         bMKTnlhbfPJ41gKBj9x/JEbjvlUmrWXB0XTDXPfhNbTd8MQATIZbsz1lxcER5kSqFE8b
         JlFgiIU18TwPeBJah2jHypz5LK/flrtlNPoW0WbClJBWegyIj3zFcbAWmDr4hvHphZI+
         YIiw==
X-Gm-Message-State: AFqh2kocMzoesldMD1VzPsqFbiQTcz+H9wi7Fv6jpBzcm0HEQSf1u99v
        pmDR3B/YeLYSSOlJN5s3kWQ=
X-Google-Smtp-Source: AMrXdXtptJIldygHlFFq52y6vkRGVwDOSUl6Y4qiWtDQ1Wnb7zULyjBNSuaLIDh3ZmaLy91r31qrNg==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr36234320wma.4.1672898610601;
        Wed, 04 Jan 2023 22:03:30 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6510000000b002755e301eeasm33552370wru.100.2023.01.04.22.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:03:30 -0800 (PST)
Message-ID: <86a7635e-f25c-03d1-744c-2046640aea60@kernel.org>
Date:   Thu, 5 Jan 2023 07:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/10] tty: Cleamup tty_port_set_suspended() bool
 parameter
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-3-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-3-ilpo.jarvinen@linux.intel.com>
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
> Make callers pass true/false consistently for bool val.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> ---
>   drivers/tty/serial/serial_core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index e049c760b738..f9564b1e3dfb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -312,7 +312,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>   	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
>   	 * we don't try to resume a port that has been shutdown.
>   	 */
> -	tty_port_set_suspended(port, 0);
> +	tty_port_set_suspended(port, false);
>   
>   	/*
>   	 * Do not free() the transmit buffer page under the port lock since
> @@ -1725,7 +1725,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
>   	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
>   	 * we don't try to resume a port that has been shutdown.
>   	 */
> -	tty_port_set_suspended(port, 0);
> +	tty_port_set_suspended(port, false);
>   
>   	/*
>   	 * Free the transmit buffer.
> @@ -2346,7 +2346,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>   		int tries;
>   		unsigned int mctrl;
>   
> -		tty_port_set_suspended(port, 1);
> +		tty_port_set_suspended(port, true);
>   		tty_port_set_initialized(port, false);
>   
>   		spin_lock_irq(&uport->lock);
> @@ -2469,7 +2469,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>   			}
>   		}
>   
> -		tty_port_set_suspended(port, 0);
> +		tty_port_set_suspended(port, false);
>   	}
>   
>   	mutex_unlock(&port->mutex);

-- 
js
suse labs

