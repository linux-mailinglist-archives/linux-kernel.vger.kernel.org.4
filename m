Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA363F1BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiLANgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLANgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:36:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F415AB035
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875126200D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AB3C433C1;
        Thu,  1 Dec 2022 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669901768;
        bh=WLdPshfe4f2Z7hixLEnJ3dcblbOMYhUNLtouSGY+9vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipMPXXIoMddbZeYdf2D3TJawXB471s+wRLLLMVJrdHg/B7fSxpxHDxxG0hAJ6MENO
         8ieoFGyNNdwqkSHHf/5wA5P7VpdzE5ndjCuD1PqokY16Rkr/bc72hwn+tTtVjarycF
         pEgy943RwvkCYYhmv7t9Rz/K0ogZBtQSoEmGh8bt/1WqVOiafkKdSVEBbkCFcujb2i
         lOZLxktSr+kqN99+QZ3OzI7fZf34P08WvzT1Ulp7AjdSmljHDha5tGsvc3rOSldJCh
         f9nNhYZEg1pxwx8GeCMydjw42oEDQP1IyubicroLdVQ+TR/R75txHEG8E7mZqtqhna
         7UaBH7LCWJ8HQ==
Date:   Thu, 1 Dec 2022 13:36:02 +0000
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
Message-ID: <20221201133602.GB28489@willie-the-truck>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
 <20221129140759.GA26437@willie-the-truck>
 <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
 <20221129155757.GC26561@willie-the-truck>
 <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:03:35AM -0500, Waiman Long wrote:
> On 11/29/22 10:57, Will Deacon wrote:
> > On Tue, Nov 29, 2022 at 10:32:49AM -0500, Waiman Long wrote:
> > > On 11/29/22 09:07, Will Deacon wrote:
> > > > On Mon, Nov 28, 2022 at 10:11:52AM -0500, Waiman Long wrote:
> > > > > On 11/28/22 07:00, Will Deacon wrote:
> > > > > > On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
> > > > > > > On 11/24/22 21:39, Waiman Long wrote:
> > > > > > > > In general, a non-null user_cpus_ptr will remain set until the task dies.
> > > > > > > > A possible exception to this is the fact that do_set_cpus_allowed()
> > > > > > > > will clear a non-null user_cpus_ptr. To allow this possible racing
> > > > > > > > condition, we need to check for NULL user_cpus_ptr under the pi_lock
> > > > > > > > before duping the user mask.
> > > > > > > > 
> > > > > > > > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> > > > > > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > > > > This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
> > > > > > > ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
> > > > > > > So it needs to be fixed in the stable release as well. Will resend the patch
> > > > > > > with an additional fixes tag and updated commit log.
> > > > > > Please can you elaborate on the use-after-free here? Looking at
> > > > > > 07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
> > > > > > has dropped to zero and I can't see how that can race with fork().
> > > > > > 
> > > > > > What am I missing?
> > > > > I missed that at first. The current task cloning process copies the content
> > > > > of the task structure over to the newly cloned/forked task. IOW, if
> > > > > user_cpus_ptr had been set up previously, it will be copied over to the
> > > > > cloned task. Now if user_cpus_ptr of the source task is cleared right after
> > > > > that and before dup_user_cpus_ptr() is called. The obsolete user_cpus_ptr
> > > > > value in the cloned task will remain and get used even if it has been freed.
> > > > > That is what I call as use-after-free and double-free.
> > > > If the parent task can be modified concurrently with dup_task_struct() then
> > > > surely we'd have bigger issues because that's not going to be atomic? At the
> > > > very least we'd have a data race, but it also feels like we could end up
> > > > with inconsistent task state in the child. In fact, couldn't the normal
> > > > 'cpus_mask' be corrupted by a concurrent set_cpus_allowed_common()?
> > > > 
> > > > Or am I still failing to understand the race?
> > > > 
> > > A major difference between cpus_mask and user_cpus_ptr is that for
> > > cpus_mask, the bitmap is embedded into task_struct whereas user_cpus_ptr is
> > > a pointer to an external bitmap. So there is no issue of use-after-free wrt
> > > cpus_mask. That is not the case where the memory of the user_cpus_ptr of the
> > > parent task is freed, but then a reference to that memory is still available
> > > in the child's task struct and may be used.
> > Sure, I'm not saying there's a UAF on cpus_mask, but I'm concerned that we
> > could corrupt the data and end up with an affinity mask that doesn't correspond
> > to anything meaningful. Do you agree that's possible?
> That is certainly possible. So we have to be careful about it.

Hmm, but we're not being particularly careful, are we? I hacked memcpy()
to be byte-to-byte to make things a bit easier to reproduce, and sure enough
I can race a bog-standard sched_setaffinity() call w/ fork():

[ 1663.935258] BUG: KCSAN: data-race in arch_dup_task_struct+0x4c/0x224
[ 1663.936872]
[ 1663.937292] race at unknown origin, with read to 0xffff06a44b8880a9 of 1 bytes by task 351 on cpu 0:
[ 1663.938770]  arch_dup_task_struct+0x4c/0x224
[ 1663.939621]  dup_task_struct+0x68/0x2a8
[ 1663.940381]  copy_process+0x208/0x1404
[ 1663.941109]  kernel_clone+0xdc/0x2c8
[ 1663.941814]  __arm64_sys_clone+0x9c/0xd4
[ 1663.942909]  invoke_syscall+0x54/0x170
[ 1663.943816]  el0_svc_common+0x100/0x148
[ 1663.944607]  do_el0_svc+0x40/0x10c
[ 1663.945333]  el0_svc+0x2c/0x7c
[ 1663.946006]  el0t_64_sync_handler+0x84/0xf0
[ 1663.946804]  el0t_64_sync+0x18c/0x190

I then managed to get the child process to run with an affinity mask (i.e.
'task_struct::cpus_mask') of *zero*, which triggers the select_fallback_rq()
logic:

 | process 14622 (waiman) no longer affine to cpu0

So sure, it's not a UAF, but I still think it's an issue that should be
fixed.

Will
