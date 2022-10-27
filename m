Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E960F79A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiJ0Mkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiJ0Mkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:40:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3082CDDF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:40:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E93C3219C2;
        Thu, 27 Oct 2022 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666874422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jjpn1XrYqf2pbnqgcNjThISKkBvrRgT51YkcuopGVUI=;
        b=oKoBmZ9lk2FI1PTJFbTz8dCsythL5UmKyoza7po0ugiEVdUT1k+NeOoHWJr8nZmHeH22+h
        xIh+6EPxs0vuXY46BwuY2Ji86iHRXRDKzJ0HEwOtsQGc36zFYm9RQc2//aW60CiN41/o5N
        y1AXELIs4gnQdKY0F1j9D+23JawaK70=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A087C2C141;
        Thu, 27 Oct 2022 12:40:22 +0000 (UTC)
Date:   Thu, 27 Oct 2022 14:40:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 37/38] printk: relieve console_lock of list
 synchronization duties
Message-ID: <Y1p8NrxqaGP+iGQU@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-38-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-38-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:59, John Ogness wrote:
> The console_list_lock provides synchronization for console list and
> console->flags updates. All call sites that were using the console_lock
> for this synchronization have either switched to use the
> console_list_lock or the SRCU list iterator.
> 
> Remove console_lock usage for console list updates and console->flags
> updates.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 3615ee6d68fd..840d581c4b23 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3370,8 +3363,6 @@ static int unregister_console_locked(struct console *console)
>  	if (res > 0)
>  		return 0;
>  
> -	console_lock();
> -
>  	/* Disable it unconditionally */
>  	console->flags &= ~CON_ENABLED;
>  
> @@ -3394,8 +3385,6 @@ static int unregister_console_locked(struct console *console)
>  	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
>  		console_first()->flags |= CON_CONSDEV;
>  
> -	console_unlock();
> -
>  	/* Ensure that all SRCU list walks have completed */
>  	synchronize_srcu(&console_srcu);

In addition, in unregister_console_locked(), we need to remove goto out_unlock:

	if (hlist_unhashed(&console->node)) {
		res = -ENODEV;
		goto out_unlock;
	}

out_unlock:
	console_unlock();
	return res;


I did my best to check all users that either iterate over the list
and/or access console->flags. And I did not find any real problems.

With the removal of the above mentioned out_unlock:

Reviewed-by: Petr Mladek <pmladek@suse.com>


Best Regards,
Petr

PS: Two ideas for possible future improvement:

  1. It might make sense to synchronize also @console_cmdline using
     the console_list_lock. It is modified only in
     __add_preferred_console() and read only from register_console().

     It would remove another possible race. Well, it is probably hard
     to hit, especially when new entries are always added at the end.


  2. It might make sense to create an API to modify and check
     console->flags. It might print a warning when the flags
     are accessed without console_list_lock or console_srcu.

     These days, it is pretty hard to catch all users.

