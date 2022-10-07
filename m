Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BDA5F7D93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJGS7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJGS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918771FCC5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665169188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQGHWYEn+LWtlygubAjFbTrPolfuQ9vkB0zrJq+x8Yk=;
        b=NiXHjNYaqhAcOvntctWI/Tv601NWka0YtpjI/u6BXp1qpsoIl4cl32yht4C0XjiONzUfAH
        ph7BoX4y1lJuNdXOgNwdur4tkw5RlwC8NtnmkkvGCwOYKmsT2Hvik4tNRc+pSTuZIg8Mx1
        /BJ9KKMal4DvArxauRCh6tIdspBKIdU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-G0jtj07VPp-GbuKeqEGRlw-1; Fri, 07 Oct 2022 14:59:45 -0400
X-MC-Unique: G0jtj07VPp-GbuKeqEGRlw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51AD882821;
        Fri,  7 Oct 2022 18:59:44 +0000 (UTC)
Received: from [10.22.18.97] (unknown [10.22.18.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EDA740EFB3A;
        Fri,  7 Oct 2022 18:59:42 +0000 (UTC)
Message-ID: <463d3d8d-5d6c-6c83-561b-199ab1bd8887@redhat.com>
Date:   Fri, 7 Oct 2022 14:59:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v10 4/5] sched: Handle set_cpus_allowed_ptr(),
 sched_setaffinity() & other races
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220922180041.1768141-1-longman@redhat.com>
 <20220922180041.1768141-5-longman@redhat.com>
 <Y0Af1zT1QQrMo8hf@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y0Af1zT1QQrMo8hf@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 08:47, Peter Zijlstra wrote:
> On Thu, Sep 22, 2022 at 02:00:40PM -0400, Waiman Long wrote:
>> Racing is possible between set_cpus_allowed_ptr() and sched_setaffinity()
>> or between multiple sched_setaffinity() calls from different
>> CPUs. To resolve these race conditions, we need to update both
>> user_cpus_ptr and cpus_mask in a single lock critical section instead
>> of separated ones. This requires moving the user_cpus_ptr update
>> to set_cpus_allowed_common() by putting the user_mask into a new
>> affinity_context structure and using it to pass information around
>> various functions.
>>
>> This patch also changes the handling of the race between the
>> sched_setaffinity() call and the changing of cpumask of the current
>> cpuset. In case the new mask conflicts with newly updated cpuset,
>> the cpus_mask will be reset to the cpuset cpumask and an error value
>> of -EINVAL will be returned. If a previous user_cpus_ptr value exists,
>> it will be swapped back in and the new_mask will be further restricted
>> to what is allowed in the cpumask pointed to by the old user_cpus_ptr.
>>
>> The potential race between sched_setaffinity() and a fork/clone()
>> syscall calling dup_user_cpus_ptr() is also being handled.
> This is still arse-backwards... You're still fixing races you've
> introduced earlier in the series.
>
> Since I don't think telling you again is going to help; I've done it for
> you :/ How's this then?
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/affinity
>
Thank you very much for updating the patch series. Beside the minor nit 
that I talked about in the previous mail, the result looks good to me. 
Do you mind if I send another patch on top of your branch to make the 
adjustment or you want to do it yourself?

Cheers,
Longman

