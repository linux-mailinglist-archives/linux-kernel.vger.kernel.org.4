Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F7C5F479B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJDQbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJDQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:30:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A24C5E570
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:30:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B83113E;
        Tue,  4 Oct 2022 09:30:49 -0700 (PDT)
Received: from wubuntu (unknown [10.57.33.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6571B3F792;
        Tue,  4 Oct 2022 09:30:41 -0700 (PDT)
Date:   Tue, 4 Oct 2022 17:30:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Sum of weights idea for CFS PI
Message-ID: <20221004163039.vv3byszpg5dqjhy5@wubuntu>
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu>
 <00140e95-0fe2-1ce4-1433-a3211f9da20c@joelfernandes.org>
 <20221003161404.kdow5uyj7kvbqyxs@wubuntu>
 <160a2ded-b8e0-acf0-a8b6-df1b0f2c0fa8@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160a2ded-b8e0-acf0-a8b6-df1b0f2c0fa8@joelfernandes.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 12:27, Joel Fernandes wrote:
> There's a lot to unwind so I will reply in pieces after spending some time
> thinking about it, but just for this part:
> 
> On 10/3/2022 12:14 PM, Qais Yousef wrote:
> >> In this case, there is no lock involved yet you have a dependency. But I don't
> >> mean to sound depressing, and just because there are cases like this does not
> >> mean we should not solve the lock-based ones. When I looked at Android, I saw
> >> that it uses futex directly from Android Runtime code instead of using pthread.
> >> So perhaps this can be trivially converted to FUTEX_LOCK_PI and then what we do
> >> in the kernel will JustWork(Tm) ?
> > I guess it will depend on individual libc implementation, but I thought all of
> > them use FUTEX under the hood for pthreads mutexes.
> > 
> > Maybe we can add a bootparam to force all futexes to be FUTEX_LOCK_PI?
> > 
> 
> In the case of FUTEX_LOCK_PI, you have to store the TID of the 'lock owner' in
> the futex word to signify that lock is held.

Right. So userspace has to opt-in.

> That wont work for the case above, Producer/Consumer signalling each other on a
> bounded-buffer, right? That's not locking even though it is acquiring and
> release of a limited resource.

Yes but as I tried to point out I don't think proxy-execution handles this case
where you don't hold a lock explicitly. But I could be wrong. IIUC Sebastian's
understanding is similar to mine. Only 'locks' (FUTEX_LOCK_PI which ends up
using rt-mutex) do PI inheritance.

So this signaling scenario is a new class of problems that wasn't handled
before; to my understanding.


Thanks

--
Qais Yousef
