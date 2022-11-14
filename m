Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526CE628B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiKNVSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiKNVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F732664
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668460612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGtwzGs5+vKjZsZZeDpnHu2imq3A7FwvovVBxOyg6ug=;
        b=XJLPexre0QLjVkXnUKt8pZwj7zAzknQ3ny82r5/258RefKCV8I0vguu2egft+hv/YYFSeL
        BD3QgBPWvfHH0OnxQsmQfhBv/Rltf+NpJVLwn3MI7LrnRsbJQZvCt0Wiz7Ys8W8KsphfTj
        ERC9eG+KJHguf0pFDYClaxO3hOx/aaY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-uwjg9z8RPOOUloZYnF2Qjg-1; Mon, 14 Nov 2022 16:16:50 -0500
X-MC-Unique: uwjg9z8RPOOUloZYnF2Qjg-1
Received: by mail-wm1-f69.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so7291387wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGtwzGs5+vKjZsZZeDpnHu2imq3A7FwvovVBxOyg6ug=;
        b=SAXl+HCOCSpS1v7Yv5NuUlEHH4Jz74WsV4udhgzres7nJOde+wTYA249f5KVQDodXY
         kJEwOtYPzgrX6VtgyN5WzsWIbwLIqcGejZ4uYmRvm3VYEeUS207FDbUv9GdyeN++EB2r
         sk1Dl/MEsOJcSZlQ7UKkHElWnlkWffBwGb7SCXpqEcyeHEhEgpmpUWnuTwoXsO5khCSB
         uSE/YGLhHg8tlxy0sLZuskr2+AvDcoIDZfaB2Iw3LxGA7u+lCxpuKLLB72qx9qGoZIOJ
         S/Z65jXWuyrYD0pWU/LFl3wHO60GJfu5uptmOUzpu+M8FfCua9r6xn1PajpI60Af9hfe
         aTjA==
X-Gm-Message-State: ANoB5pmnJl4Y72dual5lrq5jBh0PI3kXWyOPb3C1iSTpF1IaCydAT9le
        ZI3wR2EQzgwAhEfO1MwCvVuO+nMnH+vyGKcRXj4/t2D39jwCuhx4653U1RV853+nbY8a684r1+n
        M7XUg1GdOvO8wKnQfZjrrXbM=
X-Received: by 2002:adf:f882:0:b0:236:8dd7:1919 with SMTP id u2-20020adff882000000b002368dd71919mr8333979wrp.242.1668460608714;
        Mon, 14 Nov 2022 13:16:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4g8xYEX2mCujXPvEtL6fos+VBp5ojZ9OHH6fn2CbdiYywpt2bmlIuAt40LVRxsa6UQhIn/GA==
X-Received: by 2002:adf:f882:0:b0:236:8dd7:1919 with SMTP id u2-20020adff882000000b002368dd71919mr8333975wrp.242.1668460608495;
        Mon, 14 Nov 2022 13:16:48 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15-20020adff24f000000b002345cb2723esm10465292wrp.17.2022.11.14.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:16:48 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:16:47 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v4 13/39] kdb: use srcu console list iterator
Message-ID: <20221114211647.bml74abrsatcnmda@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:35 +0106, John Ogness wrote:
> Guarantee safe iteration of the console list by using SRCU.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/debug/kdb/kdb_io.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 67d3c48a1522..5c7e9ba7cd6b 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  {
>  	struct console *c;
>  	const char *cp;
> +	int cookie;
>  	int len;
>  
>  	if (msg_len == 0)
> @@ -558,8 +559,20 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		cp++;
>  	}
>  
> -	for_each_console(c) {
> -		if (!(c->flags & CON_ENABLED))
> +	/*
> +	 * The console_srcu_read_lock() only provides safe console list
> +	 * traversal. The use of the ->write() callback relies on all other
> +	 * CPUs being stopped at the moment and console drivers being able to
> +	 * handle reentrance when @oops_in_progress is set.
> +	 *
> +	 * There is no guarantee that every console driver can handle
> +	 * reentrance in this way; the developer deploying the debugger
> +	 * is responsible for ensuring that the console drivers they
> +	 * have selected handle reentrance appropriately.
> +	 */
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(c) {
> +		if (!(console_srcu_read_flags(c) & CON_ENABLED))
>  			continue;
>  		if (c == dbg_io_ops->cons)
>  			continue;
> @@ -577,6 +590,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		--oops_in_progress;
>  		touch_nmi_watchdog();
>  	}
> +	console_srcu_read_unlock(cookie);
>  }
>  
>  int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> -- 
> 2.30.2
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

