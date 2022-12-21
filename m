Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DEE6533C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLUQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLUQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82A21E10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671639006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jyDhjLmF0yuKJcSug8zaEHQQtFh7en/D8zWB4PkRC4=;
        b=WaTVqxGGypt3IYnCtf/s5oXfBUg8urktV18dGtMrHGRP1aIqw9d8ofRDmVtN0WrOxE/pP/
        4sIukHws/uNFICKczmcrzwH6hH6BE6yJYpPVVrQ3W7B8KL7KOrJAmD6EXSU8u7TIVcMvfq
        3kmPLTcOtTqNOlSJo51HuuSXRqjBNZc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-0DMu-u19PH6nzDC3fUP_nQ-1; Wed, 21 Dec 2022 11:10:03 -0500
X-MC-Unique: 0DMu-u19PH6nzDC3fUP_nQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EE3C3C10231;
        Wed, 21 Dec 2022 16:10:02 +0000 (UTC)
Received: from [10.22.33.5] (unknown [10.22.33.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 704DF14152F4;
        Wed, 21 Dec 2022 16:10:01 +0000 (UTC)
Message-ID: <f11add5c-6ac0-17f0-302b-9a6d5120d08a@redhat.com>
Date:   Wed, 21 Dec 2022 11:10:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Content-Language: en-US
To:     Zhang Qiao <zhangqiao22@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/22 10:19, Zhang Qiao wrote:
> hi folks,
>
>      I found problem about s64 overflow in max_vruntime().
>
>      I create a task group GROUPA (path: /system.slice/xxx/yyy/CGROUPA) and run a task in this
> group on each cpu, these tasks is while loop and 100% cpu usage.
>
>      When unregister net devices, will queue a kwork on system_highpri_wq at flush_all_backlogs()
> and wake up a high-priority kworker thread on each cpu. However, the kworker thread has been
> waiting on the queue and has not been scheduled.
>
>      After parsing the vmcore, the vruntime of the kworker is 0x918fdb05287da7c3 and the
> cfs_rq->min_vruntime is 0x124b17fd59db8d02.
>
>      why the difference between the cfs_rq->min_vruntime and kworker's vruntime is so large?
>      1) the kworker of the system_highpri_wq sleep for long long time(about 300 days).
This is an interesting problem. That means if the kworker has been 
sleeping even longer, like 600 days, it may overflow u64 as well. My 
suggestion is to cap the sleep time dependency of the vruntime 
computation to a max value that cannot overflow s64 when combined with a 
max load.weight. IOW, if the tasks are sleeping long enough, they are 
all treated to be the same.
>      2) cfs_rq->curr is the ancestor of the GROUPA, cfs->curr->load.weight is 2494, so when
> the task belonging to the GROUPA run for a long time, its vruntime will increase by 420
> times, cfs_rq->min_vruntime will also grow rapidly.
>      3) when wakeup kworker thread, kworker will be set the maximum value between kworker's
> vruntime and cfs_rq->min_vruntime. But at max_vruntime(), there will be a s64 overflow issue,
> as follow:
>
> ---------
>
> static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
> {
> 	/*
> 	 * vruntime=0x124b17fd59db8d02
> 	 * min_vruntime=0x918fdb05287da7c3
> 	 * vruntime - min_vruntime = 9276074894177461567 > s64_max, will s64 overflow
> 	 */
> 	s64 delta = (s64)(vruntime - min_vruntime);
> 	if (delta < 0)
> 		min_vruntime = vruntime;
>
> 	return min_vruntime;
> }
>
> ----------
>
> max_vruntime() will return the kworker's old vruntime, it is incorrect and the correct result
> shoud be cfs_rq->minvruntime. This incorrect result is greater than cfs_rq->min_vruntime and
> will cause kworker thread starved.
>
>      Does anyone have a good suggestion for slove this problem? or bugfix patch.
>
Cheers,
Longman

