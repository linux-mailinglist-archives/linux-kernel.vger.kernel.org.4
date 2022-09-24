Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A95E8B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiIXKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIXKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:54:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ABCDDDA5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:54:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so8145587pjk.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2T/nAXofM+cBGCCzdK/WhAhFJ6YKGhgXDN2daZJ21cQ=;
        b=RrYv3vma8l+uA3BgIPpdjCQlzwFxeVsVyO30kx+88rAIAa7gpFLg4iObx7k3VcN/IC
         4qNSedKcnXVWzGuLPpldSaHpXaIZo60/f+f/+F9dY3BXCmXoq7QTzFuQdSp0OqDFgvU6
         0/6oRZNMcaC6u0wEny+s+Sf6jsJR2wfkwfeVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2T/nAXofM+cBGCCzdK/WhAhFJ6YKGhgXDN2daZJ21cQ=;
        b=u+FccsF+1Z7Sx8iPugCfP3xin6tHeypgdCWxsRFKOpkwcVZvhcNW37TNs3yecMxim0
         OR0fa3u/jJmhwAq6Vqn67Fd6udT7sj66ChAWkSjnxu8MdZBmb06stT4DhSzDNsFxfgoz
         op6iESJpEaBbzNpWYsbZZEnzX77Gz1jtnoGyp0rQ2GtpaKQG2EeCy2ShOchzy2dzaBFd
         QnPB87/BRavq7SNbfeOF+JdHVIMbvR4uWbERyqW4f7E5tZKiwtZOzsxVe8svZe4yS8O5
         5I3UbWWy5mLApzPux7CBijW0YXPQE9ODlCwkfjj1BnkG88EvW5rl6uBOiec/ahskiCW/
         chtg==
X-Gm-Message-State: ACrzQf26FKb9vSfc2ih2sDD7Os2BL2oWjlkxzkshrnWSiY8PIoHuBnvw
        iWl1rUtQZOeKvDkPTogU8GXn3w==
X-Google-Smtp-Source: AMsMyM71AQgkf5TJ0FexsQnrVew9TRRjvxzcx0KaOzhnhIf9ge1do5GUeDCFKOKWjtZ7mpRdlQOLyA==
X-Received: by 2002:a17:90b:4b49:b0:202:e09c:6662 with SMTP id mi9-20020a17090b4b4900b00202e09c6662mr14180414pjb.138.1664016845708;
        Sat, 24 Sep 2022 03:54:05 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f4de:2419:efa3:8fed])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b00177e5d83d3dsm7575087pla.170.2022.09.24.03.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 03:54:04 -0700 (PDT)
Date:   Sat, 24 Sep 2022 19:53:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Message-ID: <Yy7hxxJVzY6GYHkG@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 02:10), John Ogness wrote:
[..]
>  static int console_unregister_locked(struct console *console)
>  {
> -	struct console *con;
>  	int res;
>  
>  	con_printk(KERN_INFO, console, "disabled\n");
> @@ -3274,32 +3287,28 @@ static int console_unregister_locked(struct console *console)
>  	if (res > 0)
>  		return 0;
>  
> -	res = -ENODEV;
>  	console_lock();
> -	if (console_drivers == console) {
> -		console_drivers=console->next;
> -		res = 0;
> -	} else {
> -		for_each_console(con) {
> -			if (con->next == console) {
> -				con->next = console->next;
> -				res = 0;
> -				break;
> -			}
> -		}
> -	}
>  
> -	if (res)
> -		goto out_disable_unlock;
> +	/* Disable it unconditionally */
> +	console->flags &= ~CON_ENABLED;
> +
> +	if (hlist_unhashed(&console->node))
> +		goto out_unlock;

Shouldn't this set `ret` to -ENODEV before goto? Otherwise it will always
return 0 (which is set by _braille_unregister_console()).

> +
> +	hlist_del_init(&console->node);
>  
>  	/*
> +	 * <HISTORICAL>
>  	 * If this isn't the last console and it has CON_CONSDEV set, we
>  	 * need to set it on the next preferred console.
> +	 * </HISTORICAL>
> +	 *
> +	 * The above makes no sense as there is no guarantee that the next
> +	 * console has any device attached. Oh well....
>  	 */

It's complicated...
