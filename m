Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F56138BF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJaOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJaOJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:09:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E3010B48
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:09:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 24625338B7;
        Mon, 31 Oct 2022 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667225356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOQBcJHrH5TTnJTZ9kKFPMfWJn6TwnLyDmMgvxVGxwg=;
        b=l8S0H1BijW3zAOwbmv8qVvGzFSrIDP5N8AnYoEG/v03mJPOfWsxl5hafA8kktX/59vjX7I
        LQzzcZLCJIljG1bsRAi27lH1BEFf6liJlyi6Ov69B4xUw7TCxeQIDd9B+lYCsnsC0gfA/r
        +ZeT6TQHbeV8R5RGPG05qkvduMsXtqU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DAC362C141;
        Mon, 31 Oct 2022 14:09:15 +0000 (UTC)
Date:   Mon, 31 Oct 2022 15:09:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 03/38] printk: Prepare for SRCU console list
 protection
Message-ID: <Y1/XCLSPBZtsTy0h@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-4-john.ogness@linutronix.de>
 <Y1JZqyIF5rf4sal2@alley>
 <87leow9m77.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leow9m77.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-31 14:12:36, John Ogness wrote:
> On 2022-10-21, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ -3179,6 +3214,17 @@ void register_console(struct console *newcon)
> >>  		newcon->flags &= ~CON_PRINTBUFFER;
> >>  	}
> >>  
> >> +	newcon->dropped = 0;
> >> +	if (newcon->flags & CON_PRINTBUFFER) {
> >> +		/* Get a consistent copy of @syslog_seq. */
> >> +		mutex_lock(&syslog_lock);
> >> +		newcon->seq = syslog_seq;
> >> +		mutex_unlock(&syslog_lock);
> >> +	} else {
> >> +		/* Begin with next message. */
> >> +		newcon->seq = prb_next_seq(prb);
> >
> > Hmm, prb_next_seq() is the next-to-be written message. It does not
> > guarantee that all the existing messages already reached the boot
> > console.
> >
> > Ideally, we should set it to con->seq from the related boot
> > consoles. But we do not know which one it is.
> 
> Yes. It is really sad that we do not know this. We need to fix this boot
> console handover at some point in the future.
> 
> > A good enough solution would be to set it to the minimal con->seq
> > of all registered boot consoles. They would most likely be on
> > the same sequence number. Anyway, con->seq has to be read under
> > console_lock() at least at this stage of the patchset.
> 
> Well, for v3 I would do the following:
> 
> - explicitly have boot consoles also behave like CON_PRINTBUFFER
> 
> - use the oldest boot+enabled message
> 
> The code would include the additional changes:
> 
> -	if (newcon->flags & CON_PRINTBUFFER) {
> +	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
>  		/* Get a consistent copy of @syslog_seq. */
>  		mutex_lock(&syslog_lock);
>  		newcon->seq = syslog_seq;
>  		mutex_unlock(&syslog_lock);
>  	} else {
> -		/* Begin with next message. */
> +		/* Begin with next message added to the ringbuffer. */
>  		newcon->seq = prb_next_seq(prb);
> +
> +		/*
> +		 * If an enabled boot console is not caught up, start with
> +		 * that message instead. That boot console will be
> +		 * unregistered shortly and may be the same device.
> +		 */
> +		for_each_console(con) {
> +			if ((con->flags & (CON_BOOT | CON_ENABLED)) == (CON_BOOT | CON_ENABLED) &&
> +			    con->seq < newcon->seq) {
> +				newcon->seq = con->seq;
> +			}
> +		}
>  	}

Makes sense. Just please do it in a separate patch. It might
potentially change the behavior. And the problem have been
there since the global "console_seq" was moved to struct console_seq.

> >> +		hlist_add_behind_rcu(&newcon->node, console_list.first);
> >>  	}
> >>  	console_unlock();
> >> +

All the other proposed changes look good.

Best Regards,
Petr
