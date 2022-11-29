Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E674163C475
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiK2P7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiK2P7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:59:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23E69DD3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B62617A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A9C4347C;
        Tue, 29 Nov 2022 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669737484;
        bh=zrEzumqsT84sAsMe/WdazNyakaN/EBtxrup9XhwiJ4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC6K4vRPijG2/QsB4kYC85xkx1mTzkG9RkL0BQLiuotFt2sKX0H4H5zXCVYLRUKbn
         uWQvugQj4i5qxzQ8hY3jdzBj690iJDLfZrS60qEbWPqWpaMdANDmcwv0uzM90Mezcz
         VunLEvGuVXvpEB1Ujxcz/dCY0nmmsI2eLYu39hruALAvZ2q48qAeOdp1ZQ/2jc6Fd2
         33shhUUSqaaagf2jJTqjTWQI2b8Kt2SXuvkz0cGJJNNWYpY7NkqH75SuBUp1oR/FZr
         t2+nXbe0jPRFqyHmURxBRbLhYHVx67zPgYdAbnxhXMnzBxszvp+yLsmVb9E5Ym0iez
         FPKVX6/4YknqA==
Date:   Tue, 29 Nov 2022 15:57:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        David Wang =?utf-8?B?546L5qCH?= <wangbiao3@xiaomi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Message-ID: <20221129155757.GC26561@willie-the-truck>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
 <20221129140759.GA26437@willie-the-truck>
 <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:32:49AM -0500, Waiman Long wrote:
> On 11/29/22 09:07, Will Deacon wrote:
> > On Mon, Nov 28, 2022 at 10:11:52AM -0500, Waiman Long wrote:
> > > On 11/28/22 07:00, Will Deacon wrote:
> > > > On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
> > > > > On 11/24/22 21:39, Waiman Long wrote:
> > > > > > In general, a non-null user_cpus_ptr will remain set until the task dies.
> > > > > > A possible exception to this is the fact that do_set_cpus_allowed()
> > > > > > will clear a non-null user_cpus_ptr. To allow this possible racing
> > > > > > condition, we need to check for NULL user_cpus_ptr under the pi_lock
> > > > > > before duping the user mask.
> > > > > > 
> > > > > > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> > > > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > > This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
> > > > > ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
> > > > > So it needs to be fixed in the stable release as well. Will resend the patch
> > > > > with an additional fixes tag and updated commit log.
> > > > Please can you elaborate on the use-after-free here? Looking at
> > > > 07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
> > > > has dropped to zero and I can't see how that can race with fork().
> > > > 
> > > > What am I missing?
> > > I missed that at first. The current task cloning process copies the content
> > > of the task structure over to the newly cloned/forked task. IOW, if
> > > user_cpus_ptr had been set up previously, it will be copied over to the
> > > cloned task. Now if user_cpus_ptr of the source task is cleared right after
> > > that and before dup_user_cpus_ptr() is called. The obsolete user_cpus_ptr
> > > value in the cloned task will remain and get used even if it has been freed.
> > > That is what I call as use-after-free and double-free.
> > If the parent task can be modified concurrently with dup_task_struct() then
> > surely we'd have bigger issues because that's not going to be atomic? At the
> > very least we'd have a data race, but it also feels like we could end up
> > with inconsistent task state in the child. In fact, couldn't the normal
> > 'cpus_mask' be corrupted by a concurrent set_cpus_allowed_common()?
> > 
> > Or am I still failing to understand the race?
> > 
> A major difference between cpus_mask and user_cpus_ptr is that for
> cpus_mask, the bitmap is embedded into task_struct whereas user_cpus_ptr is
> a pointer to an external bitmap. So there is no issue of use-after-free wrt
> cpus_mask. That is not the case where the memory of the user_cpus_ptr of the
> parent task is freed, but then a reference to that memory is still available
> in the child's task struct and may be used.

Sure, I'm not saying there's a UAF on cpus_mask, but I'm concerned that we
could corrupt the data and end up with an affinity mask that doesn't correspond
to anything meaningful. Do you agree that's possible?

> Note that the problematic concurrence is not between the copying of task
> struct and changing of the task struct. It is what will happen after the
> task struct copying has already been done with an extra reference present in
> the child's task struct.

Well, sort of, but the child only has the extra reference _because_ the parent
pointer was concurrently cleared to NULL, otherwise dup_user_cpus_ptr() would
have allocated a new copy and we'd be ok, no?

Overall, I'm just very wary that we seem to be saying that copy_process()
can run concurrently with changes to the parent. Maybe it's all been written
with that in mindi (including all the arch callbacks), but I'd be astonished
if this is the only problem in there.

Will
