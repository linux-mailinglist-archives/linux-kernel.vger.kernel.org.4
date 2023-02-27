Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7466A46E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB0QVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjB0QVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:21:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696DF21941
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:21:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF9AB80D6B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED1AC433D2;
        Mon, 27 Feb 2023 16:21:04 +0000 (UTC)
Date:   Mon, 27 Feb 2023 11:21:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <20230227112102.028b2f81@gandalf.local.home>
In-Reply-To: <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
        <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 16:40:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > When task call the sched_yield, cfs would set the cfs's skip buddy.
> > If there is no other task call the sched_yield syscall, the task would
> > always be skiped when there are tasks in rq.   
> 
> So you have two tasks A) which does sched_yield() and becomes ->skip,
> and B) which is while(1). And you're saying that once A does it's thing,
> B runs forever and starves A?

If Xuewen has an example program that demonstrates the issue (pinning to a
CPU the two tasks), that could be very useful.

> This is a bad solution, SCHED_IDLE tasks have very low weight and can be
> shot really far to the right, leading to other trouble.

Does SCHED_IDLE tasks have to run on a busy CPU? That is, if you have a
SCHED_OTHER task running in a while loop, a SCHED_IDLE task will still get
runtime on that CPU? I always thought SCHED_IDLE tasks were just background
tasks for running when there was nothing else to run?

-- Steve

