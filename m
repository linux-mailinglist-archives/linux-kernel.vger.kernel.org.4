Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05B86922FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjBJQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:10:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F137359C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:10:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA6C61E2A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC10C433D2;
        Fri, 10 Feb 2023 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676045406;
        bh=FWLH5hJ90+zRd86i34u4anxkiyVYs4VM7+qCpFJ6rXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEeQAZI8Vjuwskrtje5UuG24T+Ee2sWUc2aZCnQg+a/wDlZmDumsArZAAzOYaq5i8
         YxV3IvHlEyyc50LQpH353wmgV4qEg3dZGXOEKyP5TiH5gHZBtrLYkwjPzSFrEH+ALa
         GMcgkL0+CocoI7OpBzBtoRhlO0qIoq5mPMA/RVsOL7+W8s4/lm/yRArvlngID8irvU
         0ZaG9owYmMBwCiOTusPEebbkLsfA/z/cKg3V72g+0CO3tbXWiwwfISjjhO0Bb/HrZz
         npNaJ2XSAXgkz+8V8QjMVUF82Es2iWaQhDoTBm7zbH6S3qzAzRJY2WbXCz/cOdXEEx
         UuE1jmQA4YDeQ==
Date:   Fri, 10 Feb 2023 17:10:03 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/6] timers/nohz: Add a comment about broken iowait
 counter update race
Message-ID: <Y+ZsWx4gnx4Cak7D@lothringen>
References: <20230210140917.279062-1-frederic@kernel.org>
 <20230210140917.279062-5-frederic@kernel.org>
 <Y+ZXLy0P0Sggbrxc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ZXLy0P0Sggbrxc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:39:43PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 10, 2023 at 03:09:15PM +0100, Frederic Weisbecker wrote:
> > The per-cpu iowait task counter is incremented locally upon sleeping.
> > But since the task can be woken to (and by) another CPU, the counter may
> > then be decremented remotely. This is the source of a race involving
> > readers VS writer of idle/iowait sleeptime.
> > 
> > The following scenario shows an example where a /proc/stat reader
> > observes a pending sleep time as IO whereas that pending sleep time
> > later eventually gets accounted as non-IO.
> > 
> >     CPU 0                       CPU  1                    CPU 2
> >     -----                       -----                     ------
> >     //io_schedule() TASK A
> >     current->in_iowait = 1
> >     rq(0)->nr_iowait++
> >     //switch to idle
> >                         // READ /proc/stat
> >                         // See nr_iowait_cpu(0) == 1
> >                         return ts->iowait_sleeptime +
> >                                ktime_sub(ktime_get(), ts->idle_entrytime)
> > 
> >                                                           //try_to_wake_up(TASK A)
> >                                                           rq(0)->nr_iowait--
> >     //idle exit
> >     // See nr_iowait_cpu(0) == 0
> >     ts->idle_sleeptime += ktime_sub(ktime_get(), ts->idle_entrytime)
> > 
> > As a result subsequent reads on /proc/stat may expose backward progress.
> > 
> > This is unfortunately hardly fixable. Just add a comment about that
> > condition.
> 
> It is far worse than that, the whole concept of per-cpu iowait is
> absurd. Also see the comment near nr_iowait().

Alas I know :-(
