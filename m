Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A869745F34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGCOz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGCOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A3AE6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688396107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gob2L9tWTmI3nDk3oZVLR+30JlTcWug7s7HdFaK5Nu8=;
        b=R5XgUUKbM8LqcDdsmO2S8MQ5j8B1fpbmjuGCEjHVgvIav+IkuOUkj+W+tZj75eWFsb8N+6
        ik/YhCkHaBg58Ql1BxA40MvrACyHdie1TOMgFcrl/Pdj5ChSwMFA+KgjucF5L1RWIchwaK
        qRtWubhjKaM2pphAw+PfWuPQuwAe4qs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-DkklPGDuPJG8HJR2y-BxoQ-1; Mon, 03 Jul 2023 10:55:04 -0400
X-MC-Unique: DkklPGDuPJG8HJR2y-BxoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB5A38028B2;
        Mon,  3 Jul 2023 14:55:03 +0000 (UTC)
Received: from [10.22.17.92] (unknown [10.22.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1812715230A0;
        Mon,  3 Jul 2023 14:55:03 +0000 (UTC)
Message-ID: <5bc41342-5ba6-68e9-8315-9e5cef65d102@redhat.com>
Date:   Mon, 3 Jul 2023 10:55:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20230628211637.1679348-1-longman@redhat.com>
 <20230703102604.GC4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230703102604.GC4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 06:26, Peter Zijlstra wrote:
> On Wed, Jun 28, 2023 at 05:16:37PM -0400, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
>> perserved even if the task is being moved to a different cpuset. However,
>> that affinity is also being inherited by any subsequently created child
>> processes which may not want or be aware of that affinity.
>>
>> One way to solve this problem is to provide a way to back off from
>> that user provided CPU affinity.  This patch implements such a scheme
>> by using an empty cpumask to signal a reset of the cpumasks to the
>> default as allowed by the current cpuset.
>>
>> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
>> will return an EINVAL error. With this patch, an error will no longer
>> be returned. Instead, the user_cpus_ptr that stores the user provided
>> affinity, if set, will be cleared and the task's CPU affinity will be
>> reset to that of the current cpuset. This reverts the cpumask change
>> done by all the previous sched_setaffinity(2) calls.
>>
> This is a user visible ABI change -- but with very limited motivation.
> Why do we want this? Who will use this?

Yes, this is a visible ABI change, but it should be backward compatible 
as I doubt there are applications out there depending on the fact that 
passing an empty cpumask to sched_setaffinity() must return an error.

Our OpenShift team has actually hit a problem with the recent persistent 
user provided cpu affinity change because they are relying on the fact 
that moving a task to a different cpuset will reset cpu affinity to the 
cpuset default which is no longer true. That is the main reason behind 
this patch to provide a way to reset cpu affinity to the cpuset default.

I am thinking of requesting sched_setaffinity(2) manpage update to 
document the persistent user provided cpu affinity change and the way to 
reset it after this patch is merged upstream.

Cheers,
Longman

