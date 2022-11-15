Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD167629DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiKOPeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiKOPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:34:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E0DFEF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:34:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B918833688;
        Tue, 15 Nov 2022 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668526450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fx1pabvdNXR/4MZEXdvaDvbLnLLLuOpiVQF5f9g0kBo=;
        b=PRNvaJAr2b0ao2L6bSSuW4Eg76ey9yIIDFlheQf0a9IdwAjz/NHdGLvWOyV0TnRBtm8ASz
        hUKcCG9qws8J2HJpGP0lY+Jsn8Xq8pByubsJXX+HvcUupIkR+I+huCwHl8KFvfT4faSJ1w
        gdOJ0YqwXl2/NEzOgP0bhBCjG6teMO4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8CE642C142;
        Tue, 15 Nov 2022 15:34:10 +0000 (UTC)
Date:   Tue, 15 Nov 2022 16:34:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: replay log: Re: [PATCH printk v4 38/39] printk: relieve console_lock
 of list synchronization duties
Message-ID: <Y3Oxck0/LAHFLYip@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-39-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:35:31, John Ogness wrote:
> The console_list_lock provides synchronization for console list and
> console->flags updates. All call sites that were using the console_lock
> for this synchronization have either switched to use the
> console_list_lock or the SRCU list iterator.
> 
> Remove console_lock usage for console list updates and console->flags
> updates.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
>  		 * boot console that is the furthest behind.
>  		 */
>  		if (bootcon_registered && !keep_bootcon) {
> +			/*
> +			 * Hold the console_lock to guarantee safe access to
> +			 * console->seq.
> +			 */
> +			console_lock();
>  			for_each_console(con) {
>  				if ((con->flags & CON_BOOT) &&
>  				    (con->flags & CON_ENABLED) &&
> @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
>  					newcon->seq = con->seq;
>  				}
>  			}
> +			console_unlock();

Thinking more about it. This console_unlock() will actually cause
flushing the boot consoles. A solution would be to call
console_flush_all() here.

And we could/should solve this in a separate patch. This code was not locked
before. It is a corner case. It could be solved later.

>  		}
>  	}
>  

Best Regards,
Petr
