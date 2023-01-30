Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886F96817B4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjA3ReT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjA3Rdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:33:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D697A80
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675099977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nojJO24UhteNPmsCx+HsdO8ZWDLBCbRPISorctyRNtk=;
        b=OCAXaQBZ+qmpeQFNHzc8DL7ciIcgBR44+yxh89+ZwuhZy0DfncxvIAli2yeG1o+8BN7x1a
        RnNVFZ659k/7iJ7YyMDdb3YFnbWtWrMnIklk+8kuwrW94ZKuiLGROFbc2qmmk6QudPM+FG
        tJ/TvOc39PHf009AsDg9NmbmK5PXkDc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-UA9-8G9EM2m8_sWfxfQFOA-1; Mon, 30 Jan 2023 12:32:53 -0500
X-MC-Unique: UA9-8G9EM2m8_sWfxfQFOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 585721C0754E;
        Mon, 30 Jan 2023 17:32:52 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C542C2166B26;
        Mon, 30 Jan 2023 17:32:51 +0000 (UTC)
Message-ID: <e782060f-0c2f-b287-1eaf-3058eac6dcb4@redhat.com>
Date:   Mon, 30 Jan 2023 12:32:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
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
References: <20230121021749.55313-1-longman@redhat.com>
 <20230124194805.GA27257@willie-the-truck>
 <fdf76fb2-1da4-2d72-7eb3-21137a7d6845@redhat.com>
 <20230126161110.GB29438@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230126161110.GB29438@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 11:11, Will Deacon wrote:
> On Tue, Jan 24, 2023 at 03:24:36PM -0500, Waiman Long wrote:
>> On 1/24/23 14:48, Will Deacon wrote:
>>> On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
>>>> The user_cpus_ptr field was originally added by commit b90ca8badbd1
>>>> ("sched: Introduce task_struct::user_cpus_ptr to track requested
>>>> affinity"). It was used only by arm64 arch due to possible asymmetric
>>>> CPU setup.
>>>>
>>>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>>>> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
>>>> requested cpu affinity specified in the sched_setaffinity().
>>>>
>>>> This results in a performance regression in an arm64 system when booted
>>>> with "allow_mismatched_32bit_el0" on the command-line. The arch code will
>>>> (amongst other things) calls force_compatible_cpus_allowed_ptr() and
>>>> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 64-bit
>>>> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
>>>> will always result in a __sched_setaffinity() call whether there is a
>>>> previous force_compatible_cpus_allowed_ptr() call or not.
>>> I'd argue it's more than just a performance regression -- the affinity
>>> masks are set incorrectly, which is a user visible thing
>>> (i.e. sched_getaffinity() gives unexpected values).
>> Can your elaborate a bit more on what you mean by getting unexpected
>> sched_getaffinity() results? You mean the result is wrong after a
>> relax_compatible_cpus_allowed_ptr(). Right?
> Yes, as in the original report. If, on a 4-CPU system, I do the following
> with v6.1 and "allow_mismatched_32bit_el0" on the kernel cmdline:
>
> # for c in `seq 1 3`; do echo 0 > /sys/devices/system/cpu/cpu$c/online; done
> # yes > /dev/null &
> [1] 334
> # taskset -p 334
> pid 334's current affinity mask: 1
> # for c in `seq 1 3`; do echo 1 > /sys/devices/system/cpu/cpu$c/online; done
> # taskset -p 334
> pid 334's current affinity mask: f
>
> but with v6.2-rc5 that last taskset invocation gives:
>
> pid 334's current affinity mask: 1
>
> so, yes, the performance definitely regresses, but that's because the
> affinity mask is wrong!

Are you using cgroup v1 or v2? Are your process in the root 
cgroup/cpuset or a child cgroup/cpuset under root?

If you are using cgroup v1 in a child cpuset, cpuset.cpus works more 
like cpuset.cpus_effective. IOW, with an offline and then online hotplug 
event, the cpu will be permanently lost from the cpuset. So the above is 
an expected result. If you using cgroup v2, the cpuset should be able to 
recover the lost cpu after the online event. If your process is in the 
root cpuset, the cpu will not be lost too. Alternatively, if you mount 
the v1 cpuset with the "cpuset_v2_mode" flag, it will behave more like 
v2 and recover the lost cpu.

I ran a similar cpu offline/online test with cgroup v1 and v2 and 
confirm that v1 has the above behavior and v2 is fine.

I believe what you have observed above may not be related to my sched 
patch as I can't see how it will affect cpu hotplug at all.

Cheers,
Longman

