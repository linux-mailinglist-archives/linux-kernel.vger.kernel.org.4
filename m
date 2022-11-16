Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D162B6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiKPJs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiKPJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:48:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85B5F86
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:48:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38811336E7;
        Wed, 16 Nov 2022 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668592135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwhjYbNBUd3PtUYV/XWub7bHHJtVJkMKjMJnNEBApUI=;
        b=ezOrrIsACMJF3SEsu4t+uXp7G1RqSyq2yGm6afMXQCUfqtFimEI7nqhXkI2xe3TgjmOKon
        QcQVaCAMN9P21/gntGR6j++HRI/YCCtIdD18K0t0VQJrMxUfQbwPvEGCeHJu2UUug80vsE
        BJ6Ab/HTgbt7hx7wrateAGJ68zY2e8c=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E87432C14F;
        Wed, 16 Nov 2022 09:48:54 +0000 (UTC)
Date:   Wed, 16 Nov 2022 10:48:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
Message-ID: <Y3SyBk1VPVVT3h0J@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley>
 <87tu30maqf.fsf@jogness.linutronix.de>
 <Y3PZEbx+40ZyN/79@alley>
 <87y1sbjn77.fsf@jogness.linutronix.de>
 <87v8nfjn0d.fsf@jogness.linutronix.de>
 <87sfijjmgc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfijjmgc.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-16 10:14:35, John Ogness wrote:
> Hi Petr,
> 
> Sorry, console_flush_all() only loses the console_lock if there was a
> handover. Here is a new complete suggestion from me.
> 
> 	if (newcon->flags & (CON_PRINTBUFFER | CON_BOOT)) {
> 		/* Get a consistent copy of @syslog_seq. */
> 		mutex_lock(&syslog_lock);
> 		newcon->seq = syslog_seq;
> 		mutex_unlock(&syslog_lock);
> 	} else {
> 		/* Begin with next message added to ringbuffer. */
> 		newcon->seq = prb_next_seq(prb);
> 
> 		/*
> 		 * If any enabled boot consoles are due to be unregistered
> 		 * shortly, some may not be caught up and may be the same
> 		 * device as @newcon. Since it is not known which boot console
> 		 * is the same device, flush all consoles and, if necessary,
> 		 * start with the message of the enabled boot console that is
> 		 * the furthest behind.
> 		 */
> 		if (bootcon_registered && !keep_bootcon) {
> 			bool handover;
> 
> 			/*
> 			 * Hold the console_lock to guarantee safe access to
> 			 * console->seq.
> 			 */
> 			console_lock();
> 
> 			/*
> 			 * Flush all consoles and set the console to start at
> 			 * the next unprinted sequence number.
> 			 */
> 			if (!console_flush_all(true, &newcon->seq, &handover)) {
> 				/*
> 				 * Flushing failed. Just choose the lowest
> 				 * sequence of the enabled boot consoles.
> 				 */
> 
> 				/*
> 				 * If there was a handover, this context no
> 				 * longer holds the console_lock.
> 				 */
> 				if (handover)
> 					console_lock();
> 
> 				newcon->seq = prb_next_seq(prb);
> 				for_each_console(con) {
> 					if ((con->flags & CON_BOOT) &&
> 					    (con->flags & CON_ENABLED) &&
> 					    con->seq < newcon->seq) {
> 						newcon->seq = con->seq;
> 					}
> 				}
> 			}
> 
> 			console_unlock();
> 		}

It looks good to me.

Now, we just need to agree how to add this into the patchset.
My proposal is to:

1. patch: hide the original code into a function, .e.g. console_init_seq()
2. patch: move console_init_seq() and add the above trickery

Do both before the 3rd patch in this patchset. It moved the code
outside console_lock() guarded section.

Best Regards,
Petr
