Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C05F60D024
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiJYPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiJYPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:17:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0B169CC9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:17:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4FF862204D;
        Tue, 25 Oct 2022 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666711076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLtp+iolTKizih/b1Y5CQ6KJh7DgQFwagZeeeQ6XZZY=;
        b=qhDgUHJmhV8BNffLLPA1/OkpBO72sgX9izJi0BgSGxbQ3yMrltszAWELcIgUSamNluvlG5
        Bpn7w4dtJKjWFZwNRc1X7Eldebotw2v4NWBZ2lzE91qyZfQJ9np/BLBjmEPaCp9mNFZF8F
        sqodf47/cJWN/EpO4NwMsaNhvZZjKyw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2352C2C141;
        Tue, 25 Oct 2022 15:17:56 +0000 (UTC)
Date:   Tue, 25 Oct 2022 17:17:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 27/38] printk: console_flush_all: use srcu
 console list iterator
Message-ID: <Y1f+Izra36qQ4ae6@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-28-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-28-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:49, John Ogness wrote:
> Guarantee safe iteration of the console list by using SRCU.
> 
> Note that in the case of a handover, the SRCU read lock is also
> released. This is documented in the function description and as
> comments in the code. It is a bit tricky, but this preserves the
> lockdep lock ordering for the context handing over the
> console_lock:
> 
>   console_lock()
>   | mutex_acquire(&console_lock_dep_map)       <-- console lock
>   |
>   console_unlock()
>   | console_flush_all()
>   | | srcu_read_lock(&console_srcu)            <-- srcu lock
>   | | console_emit_next_record()
>   | | | console_lock_spinning_disable_and_check()
>   | | | | srcu_read_unlock(&console_srcu)      <-- srcu unlock
>   | | | | mutex_release(&console_lock_dep_map) <-- console unlock

I believe that we could avoid this complexity, see below.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7ff2fc75fc3b..c4d5d58b5977 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2808,7 +2815,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  	do {
>  		any_progress = false;
>  
> -		for_each_console(con) {
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(con) {
>  			bool progress;
>  
>  			if (!console_is_usable(con))
> @@ -2819,12 +2827,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  				/* Extended consoles do not print "dropped messages". */
>  				progress = console_emit_next_record(con, &text[0],
>  								    &ext_text[0], NULL,
> -								    handover);
> +								    handover, cookie);
>  			} else {
>  				progress = console_emit_next_record(con, &text[0],
>  								    NULL, &dropped_text[0],
> -								    handover);
> +								    handover, cookie);
>  			}
> +
> +			/*
> +			 * If a handover has occurred, the SRCU read lock
> +			 * is already released.
> +			 */
>  			if (*handover)
>  				return false;

Please, release the SRCU read lock here:

			if (*handover) {
				console_srcu_read_unlock(cookie);
				return false;
			}

The lock should be released in the same function where it was taken.
It does not require passing the cookie and looks more straightforward.

We actually do the same when abandon_console_lock_in_panic()
returns true. We could share the code:

handover_abandon:
	console_srcu_read_unlock(cookie);
	return false;


Or do I miss anything, please?

> @@ -2838,14 +2851,19 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  
>  			/* Allow panic_cpu to take over the consoles safely. */
>  			if (abandon_console_lock_in_panic())
> -				return false;
> +				goto abandon;
>  
>  			if (do_cond_resched)
>  				cond_resched();
>  		}
> +		console_srcu_read_unlock(cookie);
>  	} while (any_progress);
>  
>  	return any_usable;
> +
> +abandon:
> +	console_srcu_read_unlock(cookie);
> +	return false;
>  }

Best Regards,
Petr
