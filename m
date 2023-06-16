Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC0733225
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbjFPN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFPN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:27:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8061993
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E9261648
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C46C433C8;
        Fri, 16 Jun 2023 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686922042;
        bh=HUJ5PO7QL/5rV0beVfosspKiaBRwlra55dH3FmfgxbA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEqipxETpI3cUOtsInhnIHn5EIuWVs+zy3IQ0tUjNEaquOxfL7gG8wvopbig3a2JN
         qqje3cRT5evAvi5pzOO5xWZhr4ZoxDeuz9Xu8xh5P7yd6ZpFn9X6FsmIMmkDBBchNF
         4/P2bPgfUGjao2Z/a3EY0CcbSreo94rQvGLDLbebk3lEBRNheIwYhS/3ptOXsBXJnF
         vNUFV4/hF8spEjhz6qkJCT2131FRtkigdRvDnpwzGOoaxB71tc1pmRhRAnVsrJVxCL
         yWpMpiNVeqT5ZrpU7Mn+EdHVAZnGgdhsXNO3t5n6RAHO94/2xTGkMpwnCaBs/2/UyA
         GPWuFkYIbCZrQ==
Message-ID: <becaa46c-f32c-2e93-757f-13998bd8bced@kernel.org>
Date:   Fri, 16 Jun 2023 15:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <20230616115149.GK83892@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230616115149.GK83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 13:51, Peter Zijlstra wrote:
> On Thu, Jun 08, 2023 at 05:58:18PM +0200, Daniel Bristot de Oliveira wrote:
>> From: Juri Lelli <juri.lelli@redhat.com>
>>
>> Starting deadline server for lower priority classes right away when
>> first task is enqueued might break guarantees, as tasks belonging to
>> intermediate priority classes could be uselessly preempted. E.g., a well
>> behaving (non hog) FIFO task can be preempted by NORMAL tasks even if
>> there are still CPU cycles available for NORMAL tasks to run, as they'll
>> be running inside the fair deadline server for some period of time.
>>
>> To prevent this issue, implement a starvation monitor mechanism that
> 
> Why should this be prevented?  FIFO can be preempted by a higher
> priority FIFO/RR, or in this case by DEADLINE, and always by stop_task.

Yeah, but in the context of "real-time throttling" the user is not asking to run things
as SCHED_DEADLINE, they are just running FIFO, and expecting it not to have SCHED_OTHER
jumping in front of them.

If we do not "deffer" the starting of the server for a point in which the starvation
is eminent, we can create some anomalies... for example:

A Interrupt wakes up a FIFO and a CFS task, which will will run first? The CFS!

A FIFO schedules a deferred work on a kworker... the kworker will preempt the
FIFO.

It is counter intuitive for the majority of people out there... It will
be counter-intuitive for most of PREEMPT_RT users :-/. From one day to the other
their tests using cyclictest will... break...

> Just accept this.
> 
> Anything that's build around FIFO-99 not getting preempted is just plain
> broken. Don't try and pander to broken
