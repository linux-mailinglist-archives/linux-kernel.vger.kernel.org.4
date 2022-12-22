Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FD2654142
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiLVMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiLVMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:46:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E01C09
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KuqnMcJO0dp697So4H0mIqLFmpVOveIphlqnuNm0Dg=; b=pBU1yqQtEZ1yfPtFv9e0Mx4SNa
        QVoyaWJpS491vWaHZTEONAIr5OEFbOvnCD3AITpQuWCJ7zdignFsJkpLblX5MKrux9zFk+TAg55lo
        hKmeU2+InYcSiTwFzJTvJD/D+CrBwxG8hwddW/iH24UuVtmTRYeDODDqXUkSrl9EutpAguq/uLHkV
        lK+Ev7S9hBCeFGmj7ncL13JtcspXcC0VFxf1Wk2ylfaFuNA8ANIOmlIAPztnO+TDy2h0xh7iAWmeF
        nYawSpAngm4uAKsswq13FxlJVjPK4OJBRsLxybqQiSbcxBdFLjhkWQh2S7I7qhTZLna7Fzakii+pW
        p7YBVwIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8KxU-003f2f-9d; Thu, 22 Dec 2022 12:46:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FE8A3001E5;
        Thu, 22 Dec 2022 13:45:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19ED52CEADD46; Thu, 22 Dec 2022 13:45:48 +0100 (CET)
Date:   Thu, 22 Dec 2022 13:45:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 11:19:31PM +0800, Zhang Qiao wrote:
> hi folks,
> 
>     I found problem about s64 overflow in max_vruntime().
> 
>     I create a task group GROUPA (path: /system.slice/xxx/yyy/CGROUPA) and run a task in this
> group on each cpu, these tasks is while loop and 100% cpu usage.
> 
>     When unregister net devices, will queue a kwork on system_highpri_wq at flush_all_backlogs()
> and wake up a high-priority kworker thread on each cpu. However, the kworker thread has been
> waiting on the queue and has not been scheduled.
> 
>     After parsing the vmcore, the vruntime of the kworker is 0x918fdb05287da7c3 and the
> cfs_rq->min_vruntime is 0x124b17fd59db8d02.
> 
>     why the difference between the cfs_rq->min_vruntime and kworker's vruntime is so large?
>     1) the kworker of the system_highpri_wq sleep for long long time(about 300 days).
>     2) cfs_rq->curr is the ancestor of the GROUPA, cfs->curr->load.weight is 2494, so when
> the task belonging to the GROUPA run for a long time, its vruntime will increase by 420
> times, cfs_rq->min_vruntime will also grow rapidly.
>     3) when wakeup kworker thread, kworker will be set the maximum value between kworker's
> vruntime and cfs_rq->min_vruntime. But at max_vruntime(), there will be a s64 overflow issue,
> as follow:
> 
> ---------
> 
> static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
> {
> 	/*
> 	 * vruntime=0x124b17fd59db8d02
> 	 * min_vruntime=0x918fdb05287da7c3
> 	 * vruntime - min_vruntime = 9276074894177461567 > s64_max, will s64 overflow
> 	 */
> 	s64 delta = (s64)(vruntime - min_vruntime);
> 	if (delta < 0)
> 		min_vruntime = vruntime;
> 
> 	return min_vruntime;
> }
> 
> ----------
> 
> max_vruntime() will return the kworker's old vruntime, it is incorrect and the correct result
> shoud be cfs_rq->minvruntime. This incorrect result is greater than cfs_rq->min_vruntime and
> will cause kworker thread starved.
> 
>     Does anyone have a good suggestion for slove this problem? or bugfix patch.

I don't understand what you tihnk the problem is. Signed overflow is
perfectly fine and works as designed here.
