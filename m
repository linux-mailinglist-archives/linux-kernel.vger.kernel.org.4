Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7FD6DAC5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbjDGLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjDGLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:50:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB968A5B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF1FA64AC5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F5C4339E;
        Fri,  7 Apr 2023 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680868215;
        bh=6c+ynh6b37yxe9+tR3T6QeLAsO8mDEt45gcqv+TcKSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8aMElzEulA1OTeVcGex2WL7XckwJgrNO1swUbRXMWjmSUi507n8WiMob0knMOWG7
         kQX0w8kWi3BC+fZxLWt6GQKULTIcAEhX2hfVy9kV6L3jp3paZthLBdMJ9mzGqppVOB
         qj+Jhjd9D9CdlsSGxeRmnhla22l+Y+LzlxKERfYxkS5ihZ/N4VF7SqX3tKDSn/ZmIF
         GYgHukx9sv61eANc+Y3gLubqRPWqLEoSjHXNKagJezRq60xrGsUOOrfOoKkIDJXbmR
         aHKA2hslqM4VyE5dEf1vG+jqRFipWIvcutK1CvycBYmX5UFl1H127250jMUFVwI+FD
         tIYFPaejrn6xQ==
Date:   Fri, 7 Apr 2023 13:50:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
Message-ID: <ZDADdMnY0oW2k5BV@lothringen>
References: <87h6tsred7.ffs@tglx>
 <874jpsqdy1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jpsqdy1.ffs@tglx>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 10:44:22AM +0200, Thomas Gleixner wrote:
> On Thu, Apr 06 2023 at 21:37, Thomas Gleixner wrote:
> > On Thu, Apr 06 2023 at 00:19, Frederic Weisbecker wrote:
> >> We could arrange for doing the same thing as hrtimer_cancel_wait_running()
> >> but for posix cpu timers, with taking a similar lock within
> >> handle_posix_cpu_timers() that timer_wait_running() could sleep on and
> >> inject its PI into.
> >
> > I have a faint memory that we discussed something like that, but there
> > was an issue which completely escaped my memory.
> 
> Now memory came back. The problem with posix CPU timers is that it is
> not really known to the other side which task is actually doing the
> expiry. For process wide timers this could be any task in the process.
> 
> For hrtimers this works because the expiring context is known.

So if posix_cpu_timer_del() were to clear ctmr->pid to NULL and then
delay put_pid() with RCU, we could retrieve that information without
holding the timer lock (with appropriate RCU accesses all around).

> 
> > Though we should quickly shut this warning up for the !RT case by
> > providing an callback which does
> >
> >   WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT);
> >
> > and let the RT folks deal with it.
> 
> OTOH, this is not only a RT issue.
> 
> On preemptible kernels the task which collected the expired timers onto
> a local list and set the firing bit, can be preempted after dropping
> sighand lock. So the other side still can busy wait for quite a while.
> Same is obviously true for guests independent of preemption when the
> vCPU gets scheduled out.

Ok, fortunately task work is a sleepable context so using a mutex would
work for everyone, at the cost of a new mutex in task_struct though.
Lemme try something.

> 
> Thanks,
> 
>         tglx
> 
