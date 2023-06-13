Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3472E91A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjFMRM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFMRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:12:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C709170E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:12:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0FBD1FB;
        Tue, 13 Jun 2023 10:13:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB0943F663;
        Tue, 13 Jun 2023 10:12:20 -0700 (PDT)
Message-ID: <fd5d06cd-bda5-0e3e-5f90-d3c5464bfcad@arm.com>
Date:   Tue, 13 Jun 2023 19:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 07/13] sched: Split scheduler execution context
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Connor O'Brien <connoro@google.com>
References: <20230601055846.2349566-1-jstultz@google.com>
 <20230601055846.2349566-8-jstultz@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230601055846.2349566-8-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:58, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Lets define the scheduling context as all the scheduler state in
> task_struct and the execution context as all state required to run
> the task.
> 
> Currently both are intertwined in task_struct. We want to logically
> split these such that we can run the execution context of one task
> with the scheduling context of another.
> 
> To this purpose introduce rq_selected() macro to point to the
> task_struct used for scheduler state and preserve rq->curr to
> denote the execution context.
> 
> NOTE: Peter previously mentioned he didn't like the name
> "rq_selected()", but I've not come up with a better alternative.
> I'm very open to other name proposals.
> 
> Question for Peter: Dietmar suggested you'd prefer I drop the
> conditionalization of the scheduler context pointer on the rq
> (so rq_selected() would be open coded as rq->curr_sched or
> whatever we agree on for a name), but I'd think in the
> !CONFIG_PROXY_EXEC case we'd want to avoid the wasted pointer
> and its use (since it curr_sched would always be == curr)?
> If I'm wrong I'm fine switching this, but would appreciate
> clarification.

IMHO, keeping both, rq->curr and rq->proxy (latter for rq->curr_sched)
would make it easier to navigate through the different versions of this
patch-set while reviewing.

I do understand that you have issues with the function name proxy() not
returning the proxy (task blocked on a mutex) but the mutex owner instead.

The header of v3 'sched: Add proxy execution'
https://lkml.kernel.org/r/20230411042511.1606592-12-jstultz@google.com
mentions:

" ... Potential proxies (i.e., tasks blocked on a mutex) are not
  dequeued, so, if one of them is actually selected by schedule() as the
  next task to be put to run on a CPU, proxy() is used to walk the
  blocked_on relation and find which task (mutex owner) might be able to
  use the proxy's scheduling context. ..."

But as I can see now, you changed this patch header in v4 to explain the
PE model slightly differently.

[...]
