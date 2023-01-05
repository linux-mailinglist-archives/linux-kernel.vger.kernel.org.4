Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F398565E563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjAEGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAEGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:03:54 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416352742;
        Wed,  4 Jan 2023 22:03:52 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id d17so15381196wrs.2;
        Wed, 04 Jan 2023 22:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oln2BJESJaZLxq2MMN6NNjRsJ78g1e+v/BPrX1x+dU=;
        b=KC1kLFGoc18mze6Ko0etblRt2SX0DMN7COeUZAwJO+EI1YGp08nP7xVCDsi8Km0VzW
         ScRVwiE/C5I9VXO46U8nUT43+XpRLmrLlGTci6U25cj92yytqa4Gi5KNjCQICNZug0hq
         z2e7UJ0qP0IzCVBwCQ8ODeptWFM63uYQSzYpo5DoDMC6GQXxmp5XLl4SupnYmC0/n1Wr
         bGZKENyr1aVUQ5zlePP61yxG1rMDzzy0cBDlE2zDeccnJeOOCLny3GSF7IS9M6tGSgcg
         KfFc3HnWS1Jy3pwspxOwJWyTuFgsHS4yriafnDyaEuJ4krFbdgGReOuo59Bo57YbGFgv
         TCGw==
X-Gm-Message-State: AFqh2kpfC8PycDsZ3FU6cLxIxmeLoIWwTu4pVcxzC8/27fyQ4DXWkNXO
        5XkdkLUXbF7GrIUx+BzObeU=
X-Google-Smtp-Source: AMrXdXv7j14veUyAM1SxsNiL9ukc34Byah+VghqCMT2gsFqcAo91ZbfvaFMk3Vn0lFGJ8I1Gf2nIwg==
X-Received: by 2002:a05:6000:24a:b0:26c:bc17:f3ba with SMTP id m10-20020a056000024a00b0026cbc17f3bamr32717880wrz.61.1672898630969;
        Wed, 04 Jan 2023 22:03:50 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm43197911wrg.72.2023.01.04.22.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 22:03:50 -0800 (PST)
Message-ID: <ba486888-1c79-6b62-0f2e-7f2ca60e4d41@kernel.org>
Date:   Thu, 5 Jan 2023 07:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 03/10] tty: Cleanup tty_port_set_active() bool parameter
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-4-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230104151531.73994-4-ilpo.jarvinen@linux.intel.com>
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
>   drivers/tty/amiserial.c          |  2 +-
>   drivers/tty/serial/serial_core.c |  4 ++--
>   drivers/tty/synclink_gt.c        |  6 +++---
>   drivers/tty/tty_port.c           | 10 +++++-----
>   4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index f8cdce1626cb..460d33a1e70b 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -1329,7 +1329,7 @@ static void rs_hangup(struct tty_struct *tty)
>   	rs_flush_buffer(tty);
>   	shutdown(tty, info);
>   	info->tport.count = 0;
> -	tty_port_set_active(&info->tport, 0);
> +	tty_port_set_active(&info->tport, false);
>   	info->tport.tty = NULL;
>   	wake_up_interruptible(&info->tport.open_wait);
>   }
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f9564b1e3dfb..c881fefa3d97 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1827,7 +1827,7 @@ static void uart_hangup(struct tty_struct *tty)
>   		spin_lock_irqsave(&port->lock, flags);
>   		port->count = 0;
>   		spin_unlock_irqrestore(&port->lock, flags);
> -		tty_port_set_active(port, 0);
> +		tty_port_set_active(port, false);
>   		tty_port_tty_set(port, NULL);
>   		if (uport && !uart_console(uport))
>   			uart_change_pm(state, UART_PM_STATE_OFF);
> @@ -1945,7 +1945,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
>   	 */
>   	ret = uart_startup(tty, state, 0);
>   	if (ret > 0)
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   
>   	return ret;
>   }
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 2b96bf0ecafb..81c94906f06e 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -694,7 +694,7 @@ static void hangup(struct tty_struct *tty)
>   	info->port.count = 0;
>   	info->port.tty = NULL;
>   	spin_unlock_irqrestore(&info->port.lock, flags);
> -	tty_port_set_active(&info->port, 0);
> +	tty_port_set_active(&info->port, false);
>   	mutex_unlock(&info->port.mutex);
>   
>   	wake_up_interruptible(&info->port.open_wait);
> @@ -3169,7 +3169,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
>   
>   	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
>   		/* nonblock mode is set or port is not enabled */
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   		return 0;
>   	}
>   
> @@ -3226,7 +3226,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
>   	port->blocked_open--;
>   
>   	if (!retval)
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   
>   	DBGINFO(("%s block_til_ready ready, rc=%d\n", tty->driver->name, retval));
>   	return retval;
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 0c00d5bd6c88..469de3c010b8 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -403,7 +403,7 @@ void tty_port_hangup(struct tty_port *port)
>   		set_bit(TTY_IO_ERROR, &tty->flags);
>   	port->tty = NULL;
>   	spin_unlock_irqrestore(&port->lock, flags);
> -	tty_port_set_active(port, 0);
> +	tty_port_set_active(port, false);
>   	tty_port_shutdown(port, tty);
>   	tty_kref_put(tty);
>   	wake_up_interruptible(&port->open_wait);
> @@ -518,14 +518,14 @@ int tty_port_block_til_ready(struct tty_port *port,
>   	 * the port has just hung up or is in another error state.
>   	 */
>   	if (tty_io_error(tty)) {
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   		return 0;
>   	}
>   	if (filp == NULL || (filp->f_flags & O_NONBLOCK)) {
>   		/* Indicate we are open */
>   		if (C_BAUD(tty))
>   			tty_port_raise_dtr_rts(port);
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   		return 0;
>   	}
>   
> @@ -588,7 +588,7 @@ int tty_port_block_til_ready(struct tty_port *port,
>   	port->blocked_open--;
>   	spin_unlock_irqrestore(&port->lock, flags);
>   	if (retval == 0)
> -		tty_port_set_active(port, 1);
> +		tty_port_set_active(port, true);
>   	return retval;
>   }
>   EXPORT_SYMBOL(tty_port_block_til_ready);
> @@ -695,7 +695,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
>   		wake_up_interruptible(&port->open_wait);
>   	}
>   	spin_unlock_irqrestore(&port->lock, flags);
> -	tty_port_set_active(port, 0);
> +	tty_port_set_active(port, false);
>   }
>   EXPORT_SYMBOL(tty_port_close_end);
>   

-- 
js
suse labs

