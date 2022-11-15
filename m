Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C86629652
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbiKOKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbiKOKuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:50:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C321E23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:50:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21BD81F8B5;
        Tue, 15 Nov 2022 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668509434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FTzh3IqYnsvgJzPb6LH/DCDSa8tDLbBI2Cl4le4c+k=;
        b=clQHvMuYUmo0CX84Qp1eGE9cTD09zVwxq2prklM6iZ2FuKryLC4kXT5f0w90oG64MeRI+F
        UB9sh+z2SnRCSwxkI74rIZ5IhTuUP5U+6SuSaX+0Pg6aUQnY+RsEs7HXniFUVW22u6MFU0
        QgmZMnc6/95IeIQlaUHA/yeX1+w9ISs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C19E82C142;
        Tue, 15 Nov 2022 10:50:33 +0000 (UTC)
Date:   Tue, 15 Nov 2022 11:50:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v4 03/39] printk: Prepare for SRCU console list
 protection
Message-ID: <Y3Nu+Bd/SWsYn8Sp@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:34:56, John Ogness wrote:
> Provide an NMI-safe SRCU protected variant to walk the console list.
> 
> Note that all console fields are now set before adding the console
> to the list to avoid the console becoming visible by SCRU readers
> before being fully initialized.
> 
> This is a preparatory change for a new console infrastructure which
> operates independent of the console BKL.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3254,7 +3303,7 @@ int unregister_console(struct console *console)
>  		return -ENODEV;
>  	}
>  
> -	hlist_del_init(&console->node);
> +	hlist_del_init_rcu(&console->node);

This should be hlist_del_rcu() here so that a list walker that it just
processing this console could see the rest of the list.

It seems that hlist_unhashed() checks only node.pprev pointer
so that we even do not need to initialize it.

We discussed this in v3 in the patch implementing
console_force_preferred_locked(), see
https://lore.kernel.org/r/Y20aBwNWT19YDeib@alley.
I forgot that unregister_console() might have the same problem.

Best Regards,
Petr

>  
>  	/*
>  	 * <HISTORICAL>
> @@ -3269,6 +3318,14 @@ int unregister_console(struct console *console)
>  		console_first()->flags |= CON_CONSDEV;
>  
>  	console_unlock();
> +
> +	/*
> +	 * Ensure that all SRCU list walks have completed. All contexts
> +	 * must not be able to see this console in the list so that any
> +	 * exit/cleanup routines can be performed safely.
> +	 */
> +	synchronize_srcu(&console_srcu);
> +
>  	console_sysfs_notify();
>  
>  	if (console->exit)
> -- 
> 2.30.2
