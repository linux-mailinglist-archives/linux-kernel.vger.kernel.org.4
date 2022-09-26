Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557CB5E9DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiIZJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiIZJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F326C2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664184820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9yo7nQ7X6csLZdzPbIjxBnehSyTfz7orjW0yNtRxTE=;
        b=bKhWn1gWvhj7Bh7ttKpKwKlqOFN66DmQSbPvWvu0bsF545aV78flz5bDrHJDoi4BXwo8uP
        ec27cMPuwWRK22Kdt+zjkofKZCGrPNVaDRdx7Akwcf9R/Gj2G3OaAME7WbZxbf8dCQRhOE
        92QbhWn/feB3srhZJwuLNkKdaH3cnTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-s3APgJMlNz24koPu5jpTqw-1; Mon, 26 Sep 2022 05:33:39 -0400
X-MC-Unique: s3APgJMlNz24koPu5jpTqw-1
Received: by mail-wr1-f71.google.com with SMTP id i27-20020adfaadb000000b0022a48b6436dso975300wrc.23
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H9yo7nQ7X6csLZdzPbIjxBnehSyTfz7orjW0yNtRxTE=;
        b=kmnA7KLVEk55HLuUoRe3b3ErSZUgZ57k72rV7dFg3GZDgDbUuYFDg23B6+kApqGOmT
         IVsbrcnaHoL186F5P+CW7NLvA7EHJ69kDvpnQQAlKnpt3NxVWsF+/VjDopODD7hFFV9r
         vLHtzEMQcby2EiZtivy2Q5adV2QDnxJ0rLg/+9GHX+y+BOoqgz7/8Gly4LDwSNpYT+p9
         5B5tstvXRfRNT1U7Yk+SVly5omhGTOaHFAT8i+MSDb1JLEe4jay7hzILIh0iOkE28eso
         DdwkD0j5T6WaXO2qpOe8+es4czvftClo7St+H2OUCsqTSF4bCmL+WuX/o5Tn3CE8AuJi
         Tz2w==
X-Gm-Message-State: ACrzQf1SNXId/fdypwwosJVu5YIuBjR3b30bqHhmJyC9OFgD9gNXXeEa
        clMyvSfkC04Y4985tbwVCRC+1rxLHGF9Xxi8MB5BnuVIWr4Gc/BzCWecOHPyHdRQWGMhixJam4B
        vdpsxMHyk5hzh+gDJrZXQmAo=
X-Received: by 2002:a05:600c:114f:b0:3b4:9a0a:6204 with SMTP id z15-20020a05600c114f00b003b49a0a6204mr14264178wmz.132.1664184818143;
        Mon, 26 Sep 2022 02:33:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4pQqUHviODc3cofcz3alTrEOSQs7Ng28XfxFeTiv0/6sR/oQsIefxECuC6NG0anOiJGp5dpQ==
X-Received: by 2002:a05:600c:114f:b0:3b4:9a0a:6204 with SMTP id z15-20020a05600c114f00b003b49a0a6204mr14264155wmz.132.1664184817894;
        Mon, 26 Sep 2022 02:33:37 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c502000b003a531c7aa66sm10720950wmr.1.2022.09.26.02.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:33:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:33:35 +0100
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk 10/18] kgbd: Pretend that console list walk is safe
Message-ID: <20220926093335.exvrpwp5khlwqxhp@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10 +0206, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide a special list iterator macro for KGDB to allow unprotected list
> walks and add a few comments to explain the hope based approach.
> 
> Preperatory change for changing the console list to hlist and adding
> lockdep asserts to regular list walks.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/tty/serial/kgdboc.c |  5 ++++-
>  include/linux/console.h     | 10 ++++++++++
>  kernel/debug/kdb/kdb_io.c   |  7 ++++++-
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index af2aa76bae15..57a5fd27dffe 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -462,10 +462,13 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>  	 * we have no other choice so we keep using it.  Since not all
>  	 * serial drivers might be OK with this, print a warning once per
>  	 * boot if we detect this case.
> +	 *
> +	 * Pretend that walking the console list is safe...
>  	 */
> -	for_each_console(con)
> +	for_each_console_kgdb(con) {
>  		if (con == kgdboc_earlycon_io_ops.cons)
>  			return;
> +	}
>  
>  	already_warned = true;
>  	pr_warn("kgdboc_earlycon is still using bootconsole\n");
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 24344f9b0bc1..86a6125512b9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -187,6 +187,16 @@ extern void console_list_unlock(void) __releases(console_mutex);
>  #define for_each_console(con)						\
>  	for (con = console_drivers; con != NULL; con = con->next)
>  
> +/**
> + * for_each_console_kgdb() - Iterator over registered consoles for KGDB
> + * @con:	struct console pointer used as loop cursor
> + *
> + * Has no serialization requirements and KGDB pretends that this is safe.
> + * Don't use outside of the KGDB fairy tale land!
> + */
> +#define for_each_console_kgdb(con)					\
> +	for (con = console_drivers; con != NULL; con = con->next)
> +
>  extern int console_set_on_cmdline;
>  extern struct console *early_console;
>  
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 67d3c48a1522..fb3775e61a3b 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -558,7 +558,12 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		cp++;
>  	}
>  
> -	for_each_console(c) {
> +	/*
> +	 * This is a completely unprotected list walk designed by the
> +	 * wishful thinking department. See the oops_in_progress comment
> +	 * below - especially the encourage section...
> +	 */
> +	for_each_console_kgdb(c) {
>  		if (!(c->flags & CON_ENABLED))
>  			continue;
>  		if (c == dbg_io_ops->cons)
> -- 
> 2.30.2
> 

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

