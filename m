Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9F67E603
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjA0NDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjA0NDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:03:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D90457FE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:03:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5775161B8E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BBC433EF;
        Fri, 27 Jan 2023 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674824592;
        bh=3q9WdGMixFx1ZmvLwgUEx1kq+2d51k4z5LpTi+bEFsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g14P7+Bca9TKg+94E1NOtW+mwubpw3YSNYtmOjjFnQSnqBkDIlex5DW0zX0ovYr32
         jJRoeC5yCGu/LN2wJkfpUSVsAAQXSOj7NB2i4fiaawzyEfYdNzyqiWSvP0mCqxJ3np
         YOj9Q24n0z+WvGHgtf31Z7FEY5/wkN1yfMYUT7y5xVJo6vZ8GIfdK5ItcGvDaB7H7W
         6vd6pbe/D8ICMrLwnwwFB+1VlzEDwSBXLG3W7q9FQfybUkTAh4yaA2J9IiyT2C7Wwr
         1vaw3FqTwCtZWVIHL6cbH8euOtUZs3x4fRp9ISy19Y/fiWaWaQFzIzoYUuuCDxGvU8
         PS7Q9i/jp+AJg==
Date:   Fri, 27 Jan 2023 13:03:06 +0000
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
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        regressions@leemhuis.info
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Message-ID: <20230127130251.GB30605@willie-the-truck>
References: <20230121021749.55313-1-longman@redhat.com>
 <20230124194805.GA27257@willie-the-truck>
 <fdf76fb2-1da4-2d72-7eb3-21137a7d6845@redhat.com>
 <20230126161110.GB29438@willie-the-truck>
 <af7488b7-9bed-69c2-274f-90ce05f8b435@redhat.com>
 <9861c077-55c6-60f4-02ea-bd0138945c16@redhat.com>
 <a7a82b63-e978-6ee2-38fb-c77ee9fed481@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a82b63-e978-6ee2-38fb-c77ee9fed481@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:56:51PM -0500, Waiman Long wrote:
> On 1/26/23 15:58, Waiman Long wrote:
> > On 1/26/23 15:49, Waiman Long wrote:
> > > On 1/26/23 11:11, Will Deacon wrote:
> > > > On Tue, Jan 24, 2023 at 03:24:36PM -0500, Waiman Long wrote:
> > > > > On 1/24/23 14:48, Will Deacon wrote:
> > > > > > On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
> > > > > > > The user_cpus_ptr field was originally added by commit b90ca8badbd1
> > > > > > > ("sched: Introduce task_struct::user_cpus_ptr to track requested
> > > > > > > affinity"). It was used only by arm64 arch due to
> > > > > > > possible asymmetric
> > > > > > > CPU setup.
> > > > > > > 
> > > > > > > Since commit 8f9ea86fdf99 ("sched: Always preserve
> > > > > > > the user requested
> > > > > > > cpumask"), task_struct::user_cpus_ptr is repurposed to store user
> > > > > > > requested cpu affinity specified in the sched_setaffinity().
> > > > > > > 
> > > > > > > This results in a performance regression in an arm64
> > > > > > > system when booted
> > > > > > > with "allow_mismatched_32bit_el0" on the
> > > > > > > command-line. The arch code will
> > > > > > > (amongst other things) calls force_compatible_cpus_allowed_ptr() and
> > > > > > > relax_compatible_cpus_allowed_ptr() when exec()'ing
> > > > > > > a 32-bit or a 64-bit
> > > > > > > task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
> > > > > > > will always result in a __sched_setaffinity() call
> > > > > > > whether there is a
> > > > > > > previous force_compatible_cpus_allowed_ptr() call or not.
> > > > > > I'd argue it's more than just a performance regression
> > > > > > -- the affinity
> > > > > > masks are set incorrectly, which is a user visible thing
> > > > > > (i.e. sched_getaffinity() gives unexpected values).
> > > > > Can your elaborate a bit more on what you mean by getting unexpected
> > > > > sched_getaffinity() results? You mean the result is wrong after a
> > > > > relax_compatible_cpus_allowed_ptr(). Right?
> > > > Yes, as in the original report. If, on a 4-CPU system, I do the
> > > > following
> > > > with v6.1 and "allow_mismatched_32bit_el0" on the kernel cmdline:
> > > > 
> > > > # for c in `seq 1 3`; do echo 0 >
> > > > /sys/devices/system/cpu/cpu$c/online; done
> > > > # yes > /dev/null &
> > > > [1] 334
> > > > # taskset -p 334
> > > > pid 334's current affinity mask: 1
> > > > # for c in `seq 1 3`; do echo 1 >
> > > > /sys/devices/system/cpu/cpu$c/online; done
> > > > # taskset -p 334
> > > > pid 334's current affinity mask: f
> > > > 
> > > > but with v6.2-rc5 that last taskset invocation gives:
> > > > 
> > > > pid 334's current affinity mask: 1
> > > > 
> > > > so, yes, the performance definitely regresses, but that's because the
> > > > affinity mask is wrong!
> > > 
> > > I see what you mean now. Hotplug doesn't work quite well now because
> > > user_cpus_ptr has been repurposed to store the value set of
> > > sched_setaffinity() but not the previous cpus_mask before
> > > force_compatible_cpus_allowed_ptr().
> > > 
> > > One possible solution is to modify the hotplug related code to check
> > > for the cpus_allowed_restricted, and if set, check
> > > task_cpu_possible_mask() to see if the cpu can be added back to its
> > > cpus_mask. I will take a further look at that later.
> > 
> > Wait, I think the cpuset hotplug code should be able to restore the
> > right cpumask since task_cpu_possible_mask() is used there. Is cpuset
> > enabled? Does the test works without allow_mismatched_32bit_el0?
> 
> BTW, if the test result is from running on a kernel built with the v2 patch,
> it is the unexpected result. That should be fixed in the v3 patch.

The failure listed above is on vanilla v6.2-rc5. Your v2 has other issues,
as described in:

https://lore.kernel.org/r/20230124194805.GA27257@willie-the-truck

Will
