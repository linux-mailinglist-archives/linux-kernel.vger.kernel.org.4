Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2862A165
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKOSgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKOSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:36:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FACD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:36:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 682371F892;
        Tue, 15 Nov 2022 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668537367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XQ2sJiljidryJdoIX8oswLfwoui4/Bu1nty4gymX/8=;
        b=A54A9+xGYc9OqUV7vdGFpmQszxhIQ5tBZfxPrAFLJU/6sqMDjpsKmb+sp6gK26PhlhWZth
        UbxIY2+tdWrG/rsLHT/Y7o6M851tdNGpwDMmIxgypa1r4rlq3JQUz/RtM91OF2UGFcAahn
        2ZkWsS755qohpy6R1hYsq9qxhKp0U8I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 497222C149;
        Tue, 15 Nov 2022 18:36:07 +0000 (UTC)
Date:   Tue, 15 Nov 2022 19:36:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
Message-ID: <Y3PcFvz1BXrDcyPm@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley>
 <Y3PBNJRvE6tU8ct+@alley>
 <87r0y4m955.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0y4m955.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-15 18:21:34, John Ogness wrote:
> On 2022-11-15, Petr Mladek <pmladek@suse.com> wrote:
> >>> --- a/kernel/printk/printk.c
> >>> +++ b/kernel/printk/printk.c
> >>> @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
> >>>  		 * boot console that is the furthest behind.
> >>>  		 */
> >>>  		if (bootcon_registered && !keep_bootcon) {
> >>> +			/*
> >>> +			 * Hold the console_lock to guarantee safe access to
> >>> +			 * console->seq.
> >>> +			 */
> >>> +			console_lock();
> >>>  			for_each_console(con) {
> >>>  				if ((con->flags & CON_BOOT) &&
> >>>  				    (con->flags & CON_ENABLED) &&
> >>> @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
> >>>  					newcon->seq = con->seq;
> >>>  				}
> >>>  			}
> >>> +			console_unlock();
> >
> > So, without the above two hunks:
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Note that we actually need those hunks to guarantee a consistent @seq
> value. The console_lock is the only synchronization mechanism available
> to read console->seq.

Yes, we need a solution. But it does not need to be in this patch.

This patch removes console_lock() on some locations. But this
particular code was called without console_lock() even before
this patch.

Note that the regression was added in the 3rd patch that moved
this code outside console_lock().

Maybe, the easiest solution would be to do in the 3rd patch [*]:

	} else {
		/* Begin with next message. */
		newcon->seq = prb_next_seq(prb);
		/*
		 * Try hard to show the pending messages on boot consoles.
		 * so that the new console does not start too late.
		 */
		pr_flush();
	}

It should behave as good and as bad as the original code.

[*] Or move the code and add this change before the 3rd patch
    to keep this questionable solution separated and avoid
    the regression.

Best Regards,
Petr
