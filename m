Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0B7485AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjGEOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB6E57
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688566059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2sLPj5y08qFr+M1Bva5r6C6XJl5+/tytL41ww+T+U4=;
        b=ObVnmY0AmTEYjoQ5yBEzkMNHuexBFHiufgLwYsAHQ6QEbQJd8VTaUcXTsY/UDdBITr1wYs
        D0X0ML0IqvX89meMSCFZjbozgEFYUuAfYyb5vk8TQP4MWu6/wr9q3cc3NKctDTzHPTABUL
        N9Y4Q9lv1bE/1Ius0iIjP8foHFtCIs8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-Mo6YzF_LPKKUxyUHEo39JQ-1; Wed, 05 Jul 2023 10:07:36 -0400
X-MC-Unique: Mo6YzF_LPKKUxyUHEo39JQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A810E299E74B;
        Wed,  5 Jul 2023 14:07:35 +0000 (UTC)
Received: from [10.22.8.133] (unknown [10.22.8.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDB3A1121314;
        Wed,  5 Jul 2023 14:07:34 +0000 (UTC)
Message-ID: <244e207a-95d5-2ff3-d0ec-c974538032af@redhat.com>
Date:   Wed, 5 Jul 2023 10:07:34 -0400
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
 <5bc41342-5ba6-68e9-8315-9e5cef65d102@redhat.com>
 <20230705093752.GW4253@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230705093752.GW4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


On 7/5/23 05:37, Peter Zijlstra wrote:
> On Mon, Jul 03, 2023 at 10:55:02AM -0400, Waiman Long wrote:
>
>> Our OpenShift team has actually hit a problem with the recent persistent
>> user provided cpu affinity change because they are relying on the fact that
>> moving a task to a different cpuset will reset cpu affinity to the cpuset
>> default which is no longer true. That is the main reason behind this patch
>> to provide a way to reset cpu affinity to the cpuset default.
> Where is the sched_setaffinity() in that story?
>
> So somewhere this thing did a sched_setaffinity() and then starts
> playing with cpusets. Instead of adding more sched_setaffinity() calls,
> can't it just remove some?

I don't know the full picture. From what I understand, there is a master 
control process that limit its cpu affinity to just a limited set of 
housekeeping CPUs. It then spawn child processes to be run in different 
containers. The control process doesn't need to change its cpu affinity.

In the past, putting the child processes in a different container 
(cpuset) will reset its affinity to that of the cpuset. That is not true 
anymore because user_cpus_ptr is inherited in the forked child process. 
I have thought about 2 ways to address that. Either we introduce a new 
clone flag to disable the inheritance of users_cpu_ptr or a way to reset 
the cpu affinity to the default which is what this patch does.

Cheers,
Longman


