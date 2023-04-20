Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038F6E8E58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjDTJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjDTJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:38:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7876C5FF6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:37:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C79741480;
        Thu, 20 Apr 2023 02:37:50 -0700 (PDT)
Received: from [10.168.10.72] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8F33F5A1;
        Thu, 20 Apr 2023 02:37:03 -0700 (PDT)
Message-ID: <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
Date:   Thu, 20 Apr 2023 11:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Content-Language: en-US
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20230416213406.2966521-1-davidai@google.com>
 <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 03:11, David Dai wrote:
> On Tue, Apr 18, 2023 at 10:18 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
> 
> Hi Dietmar, thanks for your time,
> 
>> On 16/04/2023 23:34, David Dai wrote:
>>> A userspace service may manage uclamp dynamically for individual tasks and
>>> a child task will unintentionally inherit a pesudo-random uclamp setting.
>>> This could result in the child task being stuck with a static uclamp value
>>
>> Could you explain this with a little bit more detail? Why isn't the
>> child task also managed by the userspace service?
> 
> See Qais’ reply that contains more detail on how it’s being used in
> Android. In general, if a dynamic userspace service will adjust uclamp
> on the fly for a given task, but has no knowledge or control over if
> or when a task forks. Depending on the timing of the fork, a child
> task may inherit a very large or a small uclamp_min or uclamp_max
> value. The intent of this patch is to provide more flexibility to the
> uclamp APIs such that child tasks do not get stuck with a poor uclamp
> value when spawned while retaining other sched attributes. When
> RESET_ON_FORK is set on the parent task, it will reset uclamp values
> for the child but also reset other sched attributes as well.

OK, in this case, why not just change behavior and always reset the
uclamp values at fork?

Do we anticipate a use-case in which uclamp inheritance would be required?

Let's not over-complicate the sched_[sg]etattr() unnecessarily.

[...]

>> Does this issue happen with uclamp mainline or only with Android's
>> slightly different version (max- vs. sum aggregation)?
> 
> I’m using the version of uclamp that’s in Linus’ tree. How uclamp is
> aggregated is unrelated to the problem I’m trying to solve with this
> patch. Which is to extend the uclamp APIs to have finer control for
> the uclamp inheritance of child tasks.

OK, I see.
