Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A997622643
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKIJH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiKIJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:06:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001B2034B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:06:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id h133-20020a1c218b000000b003cf4d389c41so796008wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Pjmzpa2+Wkg5tUF7TzZe/ozyOO+Z8mEPUUrHJ0Z2v8=;
        b=O9hvm8JDUV9x2jKaGrEXqSJrzjVf63iU3NV3UY8vAwFC4YiP216OcnELhIuKmLq7wC
         awmdUhsQEPpaYXuOXLYXoaFBd7dOPZh1emxki5EOxdgw6wbxA2IRbDz2q0yTY/H/USu2
         xsr9obCAncgFnizU6BGbj8JMEqyHI4k51ZryNwsLYqAqj9aescXWrLYXlMiOfGJ323CB
         goAytNR+IpwmHc+oedvkrs/IQOx7l16vZ4RFE/bBwI8zOlIeNADNL7gf+sEf96Ouhueq
         dUW58nhyszvjqfdBHSKJs8D6lNyNWLjUTpkw1XC3mQ6BhRab7zIw+ZrPp0sl9+hRGj2R
         og9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Pjmzpa2+Wkg5tUF7TzZe/ozyOO+Z8mEPUUrHJ0Z2v8=;
        b=jeqRu5Jom8SAH6+JHXZFvHZs7RHtRvhjfSe90ahSEGq7m3jJ535/Bflu/xz4L5kEey
         Q1KWAmRuLn9Q5dztEildHnxsTqmXsGKLorVkEyPDfqbnrxsp5cPa1Q2G8M31ca4laQ22
         zx77Jc+4evep1DmBt2OIKiRDjL2sz8Wd71K9Tcy+RpbDw/2+M+LNJuQ4w4bla5le6LO2
         OmKFQBusD8EtmxKi+DPvD92/hxbiDEQWx/4jQAkM+G73MONtTBaa8A3hKKyJddo0QAWc
         Lw/AYOZXvRH8MKeEYk52baRJPpwyTlws9vxmvufsPMnbAQxfzeINWviqRkpMG8s6jS+8
         U0wg==
X-Gm-Message-State: ACrzQf2SLdNvzuMSokdv5TOZnow3uLHBl4pdjMwQOxMi8V140GUq5LJ5
        Tf2oR6Jfq++YaBg1BbSnikuLEw==
X-Google-Smtp-Source: AMsMyM49i60Ob39TBkwfhUEZqRP9HkqUXUcmGafKbG87L17B6OxTNZ5yXqhPDGLQA8aICC+gY8eeHQ==
X-Received: by 2002:a05:600c:54ca:b0:3cf:8e5d:7146 with SMTP id iw10-20020a05600c54ca00b003cf8e5d7146mr22196642wmb.191.1667984794183;
        Wed, 09 Nov 2022 01:06:34 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id bu12-20020a056000078c00b0023655e51c33sm13114552wrb.4.2022.11.09.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:06:33 -0800 (PST)
Date:   Wed, 9 Nov 2022 09:06:31 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 36/40] tty: serial: kgdboc: use
 console_list_lock for list traversal
Message-ID: <20221109090631.wbtar2ho45x5yanl@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-37-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-37-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:34PM +0106, John Ogness wrote:
> configure_kgdboc() uses the console_lock for console list iteration. Use
> the console_list_lock instead because list synchronization responsibility
> will be removed from the console_lock in a later change.
>
> The SRCU iterator could have been used here, but a later change will
> relocate the locking of the console_list_lock to also provide
> synchronization against register_console().
>
> Note, the console_lock is still needed to serialize the device()
> callback with other console operations.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/kgdboc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 5be381003e58..82b4b4d67823 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -451,6 +463,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  {
>  	struct console *con;
>  	static bool already_warned;
> +	int cookie;
>
>  	if (already_warned)
>  		return;
> @@ -463,9 +476,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  	 * serial drivers might be OK with this, print a warning once per
>  	 * boot if we detect this case.
>  	 */
> -	for_each_console(con)
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
>  		if (con == kgdboc_earlycon_io_ops.cons)
> -			return;
> +			break;
> +	}
> +	console_srcu_read_unlock(cookie);
> +	if (con)
> +		return;

This change isn't mentioned in the patch description.


Daniel.
