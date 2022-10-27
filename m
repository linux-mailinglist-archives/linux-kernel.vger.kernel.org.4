Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2591E6100A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiJ0Sus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbiJ0SuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:50:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E634737
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7A15B8275D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907BAC433D6;
        Thu, 27 Oct 2022 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666896607;
        bh=wc9aMgF+ITiRWJz3AgiRZDnpx5N96c+47dmxorXHqjA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qVe7TAhR2qzFSKcXK9yD5GUHJa2uUZSpYHwuc4TR+h7QuMxV4MSNt7I2HlzU2m5HI
         E05wj/RFH7XDf6YU0y8o/03ZGW1YDGFZe9DmdDwvel4BN9HyCbvSxe9dmP8Ns+cBAC
         LJvM0fJINyxo5y9nhXQSF0bQMUyCotgM40CqbHu6rQMgbmBSbrqrqqOa0jmQA65qzN
         JO9VMniEx18KTDT2u5+/JXO91FOYJ3BJtg1wt61VKQC26ok995ETp2cmyRJ1NhJhGb
         uH8Q/gDF6lbKglZszxuL/JKMEb4SF8VrIhKjEDETeAWoUFDcHfkwgDrNc4aVoy02Kk
         ga43cHHlklaMA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 311F05C0A59; Thu, 27 Oct 2022 11:50:07 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:50:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        boqun.feng@gmail.com
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
Message-ID: <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
 <Y1pY3I1ufABvroYj@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1pY3I1ufABvroYj@alley>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 12:09:32PM +0200, Petr Mladek wrote:
> Adding Paul into Cc so that he is aware of using a custom SRCU lockdep
> check in console_list_lock().

[ . . . ]

> > +/**
> > + * console_list_lock - Lock the console list
> > + *
> > + * For console list or console->flags updates
> > + */
> > +void console_list_lock(void)
> > +{
> > +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> > +	/*
> > +	 * In unregister_console(), synchronize_srcu() is called with the
> > +	 * console_list_lock held. Therefore it is not allowed that the
> > +	 * console_list_lock is taken with the srcu_lock held.
> > +	 *
> > +	 * Whether or not this context is in the read-side critical section
> > +	 * can only be detected if the appropriate debug options are enabled.
> > +	 */
> > +	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
> > +		     srcu_read_lock_held(&console_srcu));

Yes, this is an interesting case.

The problem that John is facing is that srcu_read_lock_held() believes
that it is safer to err on the side of there being an SRCU reader.
This is because the standard use is to complain if there is -not-
an SRCU reader.  So as soon as there is a lockdep issue anywhere,
srcu_read_lock_held() switches to unconditionally returning true.

Which is exactly what John does not want in this case.

So he excludes the CONFIG_DEBUG_LOCK_ALLOC=n case and the
!debug_lockdep_rcu_enabled() case, both of which cause
srcu_read_lock_held() to unconditionally return true.

This can result in false-positive splats if some other CPU issues a
lockdep warning after debug_lockdep_rcu_enabled() is invoked but before
srcu_read_lock_held() is invoked.  But similar vulnerabilities are
present in RCU_LOCKDEP_WARN(), so unless and until there is a problem,
this code should suffice.

One way to save a line is as follows:

	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
		     debug_lockdep_rcu_enabled() &&
		     srcu_read_lock_held(&console_srcu));

Longer term, it might be possible to teach lockdep about this sort of
SRCU deadlock.  This is not an issue for vanilla RCU because the RCU
reader context prohibits such deadlocks.  This isn't exactly the same
as reader-writer locking because this is perfectly OK with SRCU:

	CPU 0:
		spin_lock(&mylock);
		idx = srcu_read_lock(&mysrcu);
		do_something();
		srcu_read_unlock(&mysrcu, idx);
		spin_unlock(&mylock);

	CPU 1:
		idx = srcu_read_lock(&mysrcu);
		spin_lock(&mylock);
		do_something();
		spin_unlock(&mylock);
		srcu_read_unlock(&mysrcu, idx);

Adding Boqun on CC in case it is easier than I think.  ;-)

							Thanx, Paul
