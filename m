Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52248624574
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiKJPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKJPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:18:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3F317EE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:18:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r14so3558815edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnbvJ2aNd/N4qPmGQHgGv1wyv/KitPYgnCYQxHNl5yc=;
        b=STUtE1y18DQBqcdpzuDwOSXPZ13/gNh8YkjwWCd0EFji3vWoV/Q+siSjXq5bjNysOx
         4cH5Vj08sKiHa1oI3ngPSGWGkVHv4tZvyT2HHNxyvcwyj42mHxHoVf91t0h8ltJngJnQ
         X6pmsLISMzLboUUe+d6BnTe8xP0CxeH666LWdMTWW5fEtSfLzZ85Y26ngYBd7isEVvI9
         ZXd0yXZYIpSUrv3FTKYfuXvQ/eiB6mNRg/q2w5tkVvPZilPVIKX9qT7QLimsXe2Fy1mv
         5ET5ZbciqYjlEZ7powNKjcY/I17J2fqkefvtJ6Np7IcJ3AuVBzCr2AXLs1XYT1KsUyUy
         hfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnbvJ2aNd/N4qPmGQHgGv1wyv/KitPYgnCYQxHNl5yc=;
        b=xygdNmYBfysyEYq2wpmYEx7TRHSkDbwihWKzo/4swpFjKgSa1zDuypkQId1SdJHXXm
         WFHZsSdRnxXBvt4GCDSiFG+d+yzlLGiv46I/boPvtlTJGJWxctgDPt5Z54n+/9VhLFCU
         fZLkqoH0EKqco60iFz7+C9ZKjZ2lcLxQJP+IkEkp4toVYVXGJEHlsE3pQP2Pu18hdLGB
         vJWSp64ZfUxvYhhrh5CR3iDThA0BKfauTAITM96KbU+xrFemwuDWtYiZ04ZfNi6XBir1
         EcTm9VfVO/SRjjmPAhJsa5ZK0PqGpLWLdbfqCLQUPFQ2W/kZHQ5QZZpIfeb4e4xcaDfR
         eW6Q==
X-Gm-Message-State: ACrzQf13WSBxAMNOwmWvmmkWHIdH9oxDnoha2HU/SDngYU6Lv7+j0QB3
        m7u7t3RSdyuh69gm0IqrktQ1lQ==
X-Google-Smtp-Source: AMsMyM7A2A2Tt1JxgZ82rllwHec1SazSu8WJQM2KYh7x6hVkjuwcr8WdaWIGdmbf3PCd/TlGC6P+UA==
X-Received: by 2002:a50:ef17:0:b0:45b:4a4b:478c with SMTP id m23-20020a50ef17000000b0045b4a4b478cmr2414848eds.317.1668093491324;
        Thu, 10 Nov 2022 07:18:11 -0800 (PST)
Received: from frostfish ([82.132.184.39])
        by smtp.gmail.com with ESMTPSA id l22-20020aa7cad6000000b0045b4b67156fsm8561373edt.45.2022.11.10.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:18:10 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:18:07 +0000
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
Subject: Re: [PATCH printk v3 38/40] tty: serial: kgdboc: use
 console_list_lock to trap exit
Message-ID: <Y20WLyrLgu8q4kyB@frostfish>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-39-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-39-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:36PM +0106, John Ogness wrote:
> kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
> are unregistered until the kgdboc_earlycon is setup. The console_list_lock
> should be used instead because list synchronization responsibility will
> be removed from the console_lock in a later change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I've not looked at the other patches in the series to understand the
future tense here (e.g. why we need intermediate patches like this one).

However I've no objections to the change so:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/tty/serial/kgdboc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 8c2b7ccdfebf..a3ed9b34e2ab 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -558,13 +558,13 @@ static int __init kgdboc_earlycon_init(char *opt)
>  	 */
>  
>  	/*
> -	 * Hold the console_lock to guarantee that no consoles are
> +	 * Hold the console_list_lock to guarantee that no consoles are
>  	 * unregistered until the kgdboc_earlycon setup is complete.
>  	 * Trapping the exit() callback relies on exit() not being
>  	 * called until the trap is setup. This also allows safe
>  	 * traversal of the console list and race-free reading of @flags.
>  	 */
> -	console_lock();
> +	console_list_lock();
>  	for_each_console(con) {
>  		if (con->write && con->read &&
>  		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
> @@ -606,7 +606,7 @@ static int __init kgdboc_earlycon_init(char *opt)
>  	}
>  
>  unlock:
> -	console_unlock();
> +	console_list_unlock();
>  
>  	/* Non-zero means malformed option so we always return zero */
>  	return 0;
> -- 
> 2.30.2
> 
