Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B235F57C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJEPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:46:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B58878BE3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:46:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D066113E;
        Wed,  5 Oct 2022 08:46:58 -0700 (PDT)
Received: from wubuntu (unknown [10.57.32.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752CD3F67D;
        Wed,  5 Oct 2022 08:46:49 -0700 (PDT)
Date:   Wed, 5 Oct 2022 16:46:47 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'John Stultz' <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v3 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221005154647.vok6unu3vnzxp74d@wubuntu>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220921012550.3288570-3-jstultz@google.com>
 <20220928125517.ei64pxfucaem55cr@wubuntu>
 <CANDhNCpLp+St4U_fjs+W8HXT-2ff4gpkx0P6vDnrX0CcesiQfA@mail.gmail.com>
 <efbeb4b069384aa39a80d606d14ec833@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efbeb4b069384aa39a80d606d14ec833@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/22 09:50, David Laight wrote:

[...]

> > That's fair. Digging through the patch history in the Android trees,
> > the first pass was for all softirqs but then restricted to remove
> > known short-running ones.
> > From the bug history and what I can directly reproduce, the net and
> > block softirqs have definitely caused trouble, but I don't see a
> > specific example from TASKLET,  so I'm ok dropping that for now, and
> > should we get specific evidence we can argue for it in a future patch.
> > 
> > So I'll drop TASKLET from the list here. Thanks for the suggestion!
> 
> I've also seen the code that finally frees memory freed under rcu
> take a long time.
> That was a workload sending a lot of UDP/RTP from a raw socket using
> IP_HDRINC - each send allocated a structure (fib?) that was freed from
> the rcu (timer?) softint callback.

I'm assuming this is a network driver that using RCU callback to free some
memory?

> 
> But, actually, one of the biggest causes of RT wakeup latency
> was a normal thread looping without a cond_resched() call.
> In my case some graphics driver doing page flushes of the
> display memory.

Were these drivers that cause these problem in-tree or out-of-tree?


Thanks

--
Qais Yousef
