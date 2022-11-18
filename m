Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08B62F271
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiKRKX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbiKRKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:23:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F3F027
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:23:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8349C1F890;
        Fri, 18 Nov 2022 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668767033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iV7qxgfXIas0r1bWwuhYw2vLMjDfUDRt2URAsaMlpU=;
        b=QqCSgMTSCXufvadkR2iVDiO5Vqja5qqcCGCAMboJGvDTDNnRTjON9zKeCkswtOYBWXxese
        9c5PQRWO2X6nAxOl3Opyj0VGI3kQwDXpgcwVH1wP+En31Ml6HI7aI4ZtVB/ag/B2FOPxSm
        XpyMKZyLVgqUGGTJSppaZj6OiXVr0E4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3AA9E2C141;
        Fri, 18 Nov 2022 10:23:53 +0000 (UTC)
Date:   Fri, 18 Nov 2022 11:23:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 06/40] printk: fix setting first seq for
 consoles
Message-ID: <Y3ddONIRAGp5dBGJ@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116162152.193147-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-16 17:27:18, John Ogness wrote:
> It used to be that all consoles were synchronized with respect to
> which message they were printing. After commit a699449bb13b ("printk:
> refactor and rework printing logic"), all consoles have their own
> @seq for tracking which message they are on. That commit also changed
> how the initial sequence number was chosen. Instead of choosing the
> next non-printed message, it chose the sequence number of the next
> message that will be added to the ringbuffer.
> 
> That change created a possibility that a non-boot console taking over
> for a boot console might skip messages if the boot console was behind
> and did not have a chance to catch up before being unregistered.
> 
> Since it is not known which boot console is the same device, flush
> all consoles and, if necessary, start with the message of the enabled
> boot console that is the furthest behind. If no boot consoles are
> enabled, begin with the next message that will be added to the
> ringbuffer.
> 
> Also, since boot consoles are meant to be used at boot time, handle
> them the same as CON_PRINTBUFFER to ensure that no initial messages
> are skipped.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

See one possible improvement below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3131,16 +3131,56 @@ static void try_enable_default_console(struct console *newcon)
>  	       (con->flags & CON_BOOT) ? "boot" : "",	\
>  	       con->name, con->index, ##__VA_ARGS__)
>  
> -static void console_init_seq(struct console *newcon)
> +static void console_init_seq(struct console *newcon, bool bootcon_registered)
>  {
> -	if (newcon->flags & CON_PRINTBUFFER) {
> +	struct console *con;
> +	bool handover;
> +
> +	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
>  		/* Get a consistent copy of @syslog_seq. */
>  		mutex_lock(&syslog_lock);
>  		newcon->seq = syslog_seq;
>  		mutex_unlock(&syslog_lock);
>  	} else {
> -		/* Begin with next message. */
> +		/* Begin with next message added to ringbuffer. */
>  		newcon->seq = prb_next_seq(prb);
> +
> +		/*
> +		 * If any enabled boot consoles are due to be unregistered
> +		 * shortly, some may not be caught up and may be the same
> +		 * device as @newcon. Since it is not known which boot console
> +		 * is the same device, flush all consoles and, if necessary,
> +		 * start with the message of the enabled boot console that is
> +		 * the furthest behind.
> +		 */
> +		if (bootcon_registered && !keep_bootcon) {
> +			/*
> +			 * Flush all consoles and set the console to start at
> +			 * the next unprinted sequence number.
> +			 */
> +			if (!console_flush_all(true, &newcon->seq, &handover)) {
> +				/*
> +				 * Flushing failed. Just choose the lowest
> +				 * sequence of the enabled boot consoles.
> +				 */
> +
> +				/*
> +				 * If there was a handover, this context no
> +				 * longer holds the console_lock.
> +				 */
> +				if (handover)
> +					console_lock();

Another improvement might be to disable handover in this case.
It would be safe because we are in a sleepable context.
It would increase the chance that console_fluhs_all() succeeded.

On the other hand, it might cause that this caller gets stuck
here because of flood of messages printed by another caller.

We could do this later when there are problems with this approach.
The problem with the handover has been there even before.

I do not want to delay this patchset by discussion this non-critical
problem to the death ;-)

Best Regards,
Petr
