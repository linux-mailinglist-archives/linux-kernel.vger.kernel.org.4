Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD298629F34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiKOQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiKOQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:41:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67027CF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:41:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5775A1F8D7;
        Tue, 15 Nov 2022 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668530485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ycQZRRFQgvxG2WyGorZjXvE5UVgAmsA0aTYa2Dgr/LA=;
        b=Q4mK6OMClM2mZzhg4zTIG2AL3CTn/3rk8P6t5G261zwnEV6rNUWllkI5isUQXvE4E/TcFe
        e2BTKMESgcO0my2K6ZkV0FLK1+S2O5IfDx0zvbGS2SEJGyfu1gJ8gtZGxcPNVfcHl0q6QA
        oM+vS7hb0TROmIORzW9MtKIefbF/q18=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 104242C142;
        Tue, 15 Nov 2022 16:41:24 +0000 (UTC)
Date:   Tue, 15 Nov 2022 17:41:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
Message-ID: <Y3PBNJRvE6tU8ct+@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Oxck0/LAHFLYip@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-15 16:34:10, Petr Mladek wrote:
> On Mon 2022-11-14 17:35:31, John Ogness wrote:
> > The console_list_lock provides synchronization for console list and
> > console->flags updates. All call sites that were using the console_lock
> > for this synchronization have either switched to use the
> > console_list_lock or the SRCU list iterator.
> > 
> > Remove console_lock usage for console list updates and console->flags
> > updates.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
> >  		 * boot console that is the furthest behind.
> >  		 */
> >  		if (bootcon_registered && !keep_bootcon) {
> > +			/*
> > +			 * Hold the console_lock to guarantee safe access to
> > +			 * console->seq.
> > +			 */
> > +			console_lock();
> >  			for_each_console(con) {
> >  				if ((con->flags & CON_BOOT) &&
> >  				    (con->flags & CON_ENABLED) &&
> > @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
> >  					newcon->seq = con->seq;
> >  				}
> >  			}
> > +			console_unlock();
> 
> Thinking more about it. This console_unlock() will actually cause
> flushing the boot consoles. A solution would be to call
> console_flush_all() here.
> 
> And we could/should solve this in a separate patch. This code was not locked
> before. It is a corner case. It could be solved later.
> 
> >  		}
> >  	}
> >  

The rest of the patch looks fine. I checked hopefully console_list walks
and console flags manipulations and everything looks good.

So, without the above two hunks:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
