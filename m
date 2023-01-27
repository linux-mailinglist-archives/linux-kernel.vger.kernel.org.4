Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046667DC15
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjA0CDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjA0CDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:03:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45738A4C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674784616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y9g3tyHKgw0UCy61304oqjJ6PLf03Rwdk1a5DwE6d54=;
        b=Xbx0opmaRXfTKgV6AeZYN/BKUYmRXoZfAJ5G3sX9bkJ/cqEgHisohjTXWoEQCuXkaXi7Um
        oIVD15WF5EzrRltYgKQ+oDUNXyjge/sUw3J6Xlyw3L35O9RbI8/mghoyoINWYuZOcCXR0v
        brleMXJR1eqRhGvx5FEfoO8bxv0XShI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-iCUwQUDxM4Se9i_alrqVzw-1; Thu, 26 Jan 2023 20:56:53 -0500
X-MC-Unique: iCUwQUDxM4Se9i_alrqVzw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 815A4185A78B;
        Fri, 27 Jan 2023 01:56:52 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE6A9492B01;
        Fri, 27 Jan 2023 01:56:51 +0000 (UTC)
Message-ID: <a7a82b63-e978-6ee2-38fb-c77ee9fed481@redhat.com>
Date:   Thu, 26 Jan 2023 20:56:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] sched: Store restrict_cpus_allowed_ptr() call state
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
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
 <af7488b7-9bed-69c2-274f-90ce05f8b435@redhat.com>
 <9861c077-55c6-60f4-02ea-bd0138945c16@redhat.com>
In-Reply-To: <9861c077-55c6-60f4-02ea-bd0138945c16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 15:58, Waiman Long wrote:
> On 1/26/23 15:49, Waiman Long wrote:
>> On 1/26/23 11:11, Will Deacon wrote:
>>> On Tue, Jan 24, 2023 at 03:24:36PM -0500, Waiman Long wrote:
>>>> On 1/24/23 14:48, Will Deacon wrote:
>>>>> On Fri, Jan 20, 2023 at 09:17:49PM -0500, Waiman Long wrote:
>>>>>> The user_cpus_ptr field was originally added by commit b90ca8badbd1
>>>>>> ("sched: Introduce task_struct::user_cpus_ptr to track requested
>>>>>> affinity"). It was used only by arm64 arch due to possible 
>>>>>> asymmetric
>>>>>> CPU setup.
>>>>>>
>>>>>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user 
>>>>>> requested
>>>>>> cpumask"), task_struct::user_cpus_ptr is repurposed to store user
>>>>>> requested cpu affinity specified in the sched_setaffinity().
>>>>>>
>>>>>> This results in a performance regression in an arm64 system when 
>>>>>> booted
>>>>>> with "allow_mismatched_32bit_el0" on the command-line. The arch 
>>>>>> code will
>>>>>> (amongst other things) calls force_compatible_cpus_allowed_ptr() and
>>>>>> relax_compatible_cpus_allowed_ptr() when exec()'ing a 32-bit or a 
>>>>>> 64-bit
>>>>>> task respectively. Now a call to relax_compatible_cpus_allowed_ptr()
>>>>>> will always result in a __sched_setaffinity() call whether there 
>>>>>> is a
>>>>>> previous force_compatible_cpus_allowed_ptr() call or not.
>>>>> I'd argue it's more than just a performance regression -- the 
>>>>> affinity
>>>>> masks are set incorrectly, which is a user visible thing
>>>>> (i.e. sched_getaffinity() gives unexpected values).
>>>> Can your elaborate a bit more on what you mean by getting unexpected
>>>> sched_getaffinity() results? You mean the result is wrong after a
>>>> relax_compatible_cpus_allowed_ptr(). Right?
>>> Yes, as in the original report. If, on a 4-CPU system, I do the 
>>> following
>>> with v6.1 and "allow_mismatched_32bit_el0" on the kernel cmdline:
>>>
>>> # for c in `seq 1 3`; do echo 0 > 
>>> /sys/devices/system/cpu/cpu$c/online; done
>>> # yes > /dev/null &
>>> [1] 334
>>> # taskset -p 334
>>> pid 334's current affinity mask: 1
>>> # for c in `seq 1 3`; do echo 1 > 
>>> /sys/devices/system/cpu/cpu$c/online; done
>>> # taskset -p 334
>>> pid 334's current affinity mask: f
>>>
>>> but with v6.2-rc5 that last taskset invocation gives:
>>>
>>> pid 334's current affinity mask: 1
>>>
>>> so, yes, the performance definitely regresses, but that's because the
>>> affinity mask is wrong!
>>
>> I see what you mean now. Hotplug doesn't work quite well now because 
>> user_cpus_ptr has been repurposed to store the value set of 
>> sched_setaffinity() but not the previous cpus_mask before 
>> force_compatible_cpus_allowed_ptr().
>>
>> One possible solution is to modify the hotplug related code to check 
>> for the cpus_allowed_restricted, and if set, check 
>> task_cpu_possible_mask() to see if the cpu can be added back to its 
>> cpus_mask. I will take a further look at that later.
>
> Wait, I think the cpuset hotplug code should be able to restore the 
> right cpumask since task_cpu_possible_mask() is used there. Is cpuset 
> enabled? Does the test works without allow_mismatched_32bit_el0?

BTW, if the test result is from running on a kernel built with the v2 
patch, it is the unexpected result. That should be fixed in the v3 patch.

Cheers,
Longman

