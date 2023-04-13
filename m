Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C86E0D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDMMKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDMMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:10:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E54EFD;
        Thu, 13 Apr 2023 05:10:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E697321870;
        Thu, 13 Apr 2023 12:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681387843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bVHo1AXvNk+0J2p7GN3q6H/IIXVoMsR7G7c5lAwQvBU=;
        b=HaJy1zlPz/tNt7qW8EQurlRkj6zMsHLxlojZiP//cBWXlSwvxA/9Yt9fVGAlgmgwdpyZlM
        f59uzjPxfPkSp45d7VkT76gPiKn6IuNhKxzknWGURkgawwA7BYZOB141pPpJ0SRI6we18N
        xM24LBgMca98+CFZA9PXAYQb0c2rYbE=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 508042C143;
        Thu, 13 Apr 2023 12:10:43 +0000 (UTC)
Date:   Thu, 13 Apr 2023 14:10:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v1 17/18] rcu: Add atomic write enforcement for
 rcu stalls
Message-ID: <ZDfxPwFE/Kg0p+uk@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-18-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-18-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:17, John Ogness wrote:
> Invoke the atomic write enforcement functions for rcu stalls to
> ensure that the information gets out to the consoles.

"ensure" is too strong. It is still just the best effort. It might
fail when the current console user does not pass the lock.

I would say that it will increase the chance to see the messages
on NOBKL consoles by printing the messages directly instead
of waiting for the printk thread.

> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of the
> atomic consoles. Optimally there should be no legacy consoles
> registered.

The above paragraph is a bit vague. It is not clear how exactly the
legacy consoles affect the reliability,

Does it mean that they might cause a deadlock because they are not
atomic? But there is nothing specific about rcu stalls and priority
of NOBKL consoles. This is a generic problem with legacy consoles.


> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -566,6 +568,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	prev_prio = cons_atomic_enter(CONS_PRIO_EMERGENCY);

Thinking loudly: This would set the EMERGENCY priority on this
CPU. But the following function:

  + rcu_dump_cpu_stacks()
    + dump_cpu_task()
      + trigger_single_cpu_backtrace()

might send IPI and the backtrace will be printed from another CPU.
As a result that backtraces won't be printed with EMERGENCY priority.

One solution would be to have also global EMERGENCY priority.

Another possibility would be to use EMERGENCY priority also
in nmi_cpu_backtrace() which is the callback called by the IPI.

I would probably go for the global flag. printk() called in EMERGENCY
priority has to flush also messages added by other CPUs. So that
messages added by other CPUs are printed "directly" anyway.

Also setting the EMERGENCY priority in  nmi_cpu_backtrace() is an
ad-hoc solution. The backtrace is usually called as part of another
global emergency report.

> +
>  	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug

Best Regards,
Petr
