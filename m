Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E23640550
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiLBKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiLBKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:53:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3DA659B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:53:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6FAB721C71;
        Fri,  2 Dec 2022 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669978388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvtLdw2rQ63hFPsH0Lm9wcccLl3JyUi3qHmTZCwTMKc=;
        b=VIZ7A8QY/+I/YIypxzZJFB5JXuZHxwf4D1HqeUVKHqVnYx2IlDqGn9xAkI5fdI8pYro0mb
        pnTSR1IanOjhMBwk8CxmCOcVcxTuTTduxm+zEKplC+6xV0n9yixHur9gLVme8Ym0unkEqk
        S545pbOkJUI8mXEP3+ysA+ZqziCPBBY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 778842C141;
        Fri,  2 Dec 2022 10:53:07 +0000 (UTC)
Date:   Fri, 2 Dec 2022 11:53:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qiang1.zhang@intel.com, sfr@canb.auug.org.au
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
Message-ID: <Y4nZEj06qCMElKCG@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
 <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
 <87lenqq012.fsf@jogness.linutronix.de>
 <20221201215650.GK4001@paulmck-ThinkPad-P17-Gen-1>
 <87edtipycj.fsf@jogness.linutronix.de>
 <20221202002152.GM4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202002152.GM4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-01 16:21:52, Paul E. McKenney wrote:
> On Thu, Dec 01, 2022 at 11:18:44PM +0106, John Ogness wrote:
> > On 2022-12-01, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > I therefore need to pull this into the pile for the upcoming merge
> > > window:
> > >
> > > dbc6ca150842 ("srcu: Make Tiny synchronize_srcu() check for readers")
> > >
> > > And kudos to Zqiang for a proactive fix!  ;-)
> > 
> > Yes! Great job!
> > 
> > > I will add your (John's) Tested-by, but please let me know if this is
> > > inappropriate.
> > 
> > Sure.
> > 
> > Tested-by: John Ogness <john.ogness@linutronix.de>
> 
> Applied, thank you!
> 
> The new -rcu branch is srcunmisafe.2022.12.01a.
> 
> Adding Stephen Rothwell on CC because Mr. Murphy says that this change
> will once again mess up -next.  Apologies in advance!!!

I have rebased printk/linux.git, branch rework/console-list-lock on
top of srcunmisafe.2022.12.01a, commit 51f5f78a4f804aeb73cf ("srcu:
Make Tiny synchronize_srcu() check for readers").

I hope that it will be OK.

Thanks a lot for nailing this down. It looked like a mystery to me.

Best Regards,
Petr
