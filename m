Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338FB63C1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiK2OId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiK2OIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA828E22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:08:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 226BCB81690
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF53C433C1;
        Tue, 29 Nov 2022 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669730886;
        bh=z9u6Fb+dpcCcMgPZ81cZKnM/cbNzGTF1MoHKmB0Xadk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwsFhvPglpb5GYltEJmdRyeg+uViWT73gTnA1ZFgwYJPP4rMvBYecLSVsuTTrYEK5
         Cnl07RStFH0tTxBxQCWKNxoGaXHmcBrI5inB2J7F9YZM0Zu1oX3ZCbftoXtmuZs5KI
         wNuuIsIyB+KXJl+n6Q/DfCc3E7XjogTXq1qjIEwoC87dX7jPn2fvbOgs11wvS3vKkp
         aK6K/VMAwoDaqJAGktHaNRMV6qqPa0jxclApTd1zWvMgHf8iWt6wZ/nyIefXk+KFcM
         JgtSUqJHSFPj1Goi7ClsE8+5umMliCLOfU9ZWxk2tsqykxvOcDJlGuJBdLctWel6wK
         eIFWkG5P1JV8A==
Date:   Tue, 29 Nov 2022 14:07:59 +0000
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
Message-ID: <20221129140759.GA26437@willie-the-truck>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:11:52AM -0500, Waiman Long wrote:
> On 11/28/22 07:00, Will Deacon wrote:
> > On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
> > > On 11/24/22 21:39, Waiman Long wrote:
> > > > In general, a non-null user_cpus_ptr will remain set until the task dies.
> > > > A possible exception to this is the fact that do_set_cpus_allowed()
> > > > will clear a non-null user_cpus_ptr. To allow this possible racing
> > > > condition, we need to check for NULL user_cpus_ptr under the pi_lock
> > > > before duping the user mask.
> > > > 
> > > > Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
> > > ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
> > > So it needs to be fixed in the stable release as well. Will resend the patch
> > > with an additional fixes tag and updated commit log.
> > Please can you elaborate on the use-after-free here? Looking at
> > 07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
> > has dropped to zero and I can't see how that can race with fork().
> > 
> > What am I missing?
> 
> I missed that at first. The current task cloning process copies the content
> of the task structure over to the newly cloned/forked task. IOW, if
> user_cpus_ptr had been set up previously, it will be copied over to the
> cloned task. Now if user_cpus_ptr of the source task is cleared right after
> that and before dup_user_cpus_ptr() is called. The obsolete user_cpus_ptr
> value in the cloned task will remain and get used even if it has been freed.
> That is what I call as use-after-free and double-free.

If the parent task can be modified concurrently with dup_task_struct() then
surely we'd have bigger issues because that's not going to be atomic? At the
very least we'd have a data race, but it also feels like we could end up
with inconsistent task state in the child. In fact, couldn't the normal
'cpus_mask' be corrupted by a concurrent set_cpus_allowed_common()?

Or am I still failing to understand the race?

Will
