Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ECD5F0B80
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiI3MQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiI3MQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E917B52E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7114062316
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FD5C433D6;
        Fri, 30 Sep 2022 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664540197;
        bh=h+KMnKvy2rH8iR2ELT9m5DYIjnlRASkttN82L1ercCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+AWobz7JZkClM3mLMtKSs4fmjbCsoM6tKTnAT4RxTESpG59P2r6lVyAXeAHyBMuw
         6T9eb1moSl819JgNRxlGmpIvGjh6UIFUYv9vc6DLWPf3IwnmwQngB9Nc5KiWRTFwbQ
         BJBKq6jJsOu1hsuy4Qw0MxSga4/mTmOKmP7vN+qaQqDhPZ+SXj2i0G4gepJRntNRTk
         WHumIX5YOfteNPxz0v+yt7/IKbtRSKVul8Z6xGafeB+hf/Z/5RTkrEA6LjYwcqQogY
         qYUafqt9oPeO+0FsDQ4CeG06n4MANtqoLq/6bQ7oXdRieB1o3NNVsf00PYlxz22Glv
         EM3ywO4OvXPqA==
Date:   Fri, 30 Sep 2022 14:16:34 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     zhengzucheng <zhengzucheng@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        hucool.lihua@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/cputime: Fix the time backward issue about
 /proc/stat
Message-ID: <20220930121634.GA266766@lothringen>
References: <20220928033402.181530-1-zhengzucheng@huawei.com>
 <YzQB8afi2rCPvuC1@hirez.programming.kicks-ass.net>
 <20220928121134.GA233658@lothringen>
 <5126b2dc-8624-babc-2e1e-58ac27927c31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5126b2dc-8624-babc-2e1e-58ac27927c31@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:43:58AM +0800, zhengzucheng wrote:
> 
> 在 2022/9/28 20:11, Frederic Weisbecker 写道:
> > @@ -1024,20 +1045,20 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
> >   		 * add pending nohz time to the right place.
> >   		 */
> >   		if (state == VTIME_SYS) {
> > -			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
> > +			cpustat[CPUTIME_SYSTEM] += delta;
> >   		} else if (state == VTIME_USER) {
> >   			if (task_nice(tsk) > 0)
> > -				cpustat[CPUTIME_NICE] += vtime->utime + delta;
> > +				cpustat[CPUTIME_NICE] += delta;
> >   			else
> > -				cpustat[CPUTIME_USER] += vtime->utime + delta;
> > +				cpustat[CPUTIME_USER] += delta;
> “delta” has the same problem as vtime->utime, which varies with different
> tasks. switching between different tasks may cause time statistics to be
> reversed.

I'm a bit confused, can you provide an example?

Thanks.

> >   		} else {
> >   			WARN_ON_ONCE(state != VTIME_GUEST);
> >   			if (task_nice(tsk) > 0) {
> > -				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
> > -				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
> > +				cpustat[CPUTIME_GUEST_NICE] += delta;
> > +				cpustat[CPUTIME_NICE] += delta;
> >   			} else {
> > -				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
> > -				cpustat[CPUTIME_USER] += vtime->gtime + delta;
> > +				cpustat[CPUTIME_GUEST] += delta;
> > +				cpustat[CPUTIME_USER] += delta;
> >   			}
> >   		}
> >   	} while (read_seqcount_retry(&vtime->seqcount, seq));
> > .
