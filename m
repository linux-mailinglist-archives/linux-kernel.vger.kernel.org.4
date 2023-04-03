Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254AD6D3BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 04:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDCCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDCCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 22:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10201AF3F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680487556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAhFc04JfjGFT2q4K6JpbQmjJVkjMrZwudB6EN7Isyc=;
        b=A9ZAOvf5k79sIcFYWBN1pBbG7UFa99dq6SWryMiS4VJ53zDS4PY/BNrrKxNy1J1BzQNpSK
        ZIXQ4udpvHbwiQRntgS4zWdBhT70Rem11NfGoHxlDLQE5bbbdWx4ZLm9o5K89kBix38zbO
        PMZnB24jw7MOzvQBbIIEVgzquEPBO6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-jR0gc_AqPnmmKcxMC0VJDg-1; Sun, 02 Apr 2023 22:05:52 -0400
X-MC-Unique: jR0gc_AqPnmmKcxMC0VJDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1467685C06A;
        Mon,  3 Apr 2023 02:05:52 +0000 (UTC)
Received: from [10.22.8.120] (unknown [10.22.8.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C711640C6EC4;
        Mon,  3 Apr 2023 02:05:51 +0000 (UTC)
Message-ID: <d0be6b59-11ee-f899-19e5-b84eba003ac8@redhat.com>
Date:   Sun, 2 Apr 2023 22:05:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: A couple of TSC questions
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
 <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
 <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
 <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/23 22:00, Paul E. McKenney wrote:
> On Sun, Apr 02, 2023 at 09:04:04PM -0400, Waiman Long wrote:
>> On 3/31/23 13:16, Paul E. McKenney wrote:
>>> On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
>>>> On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
>>>>> On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
>>>>>> On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
>>> [ . . . ]
>>>
>>>>>>>> Second, we are very occasionally running into console messages like this:
>>>>>>>>
>>>>>>>> Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
>>>>>>>>
>>>>>>>> This comes from check_tsc_sync_source() and indicates that one CPU's
>>>>>>>> TSC read produced a later time than a later read from some other CPU.
>>>>>>>> I am beginning to suspect that these can be caused by unscheduled delays
>>>>>>>> in the TSC synchronization code, but figured I should ask you if you have
>>>>>>>> ever seen these.  And of course, if so, what the usual causes might be.
>>>>>>> I haven't seen this error myself or got similar reports. Usually it
>>>>>>> should be easy to detect once happened, as falling back to HPET
>>>>>>> will trigger obvious performance degradation.
>>>>>> And that is exactly what happened.  ;-)
>>>>>>
>>>>>>> Could you give more detail about when and how it happens, and the
>>>>>>> HW info like how many sockets the platform has.
>>>>>> We are in early days, so I am checking for other experiences.
>>>>>>
>>>>>>> CC Thomas, Waiman, as they discussed simliar case here:
>>>>>>> https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
>>>>>> Fun!  ;-)
>>>> Waiman, do you recall what fraction of the benefit was provided by the
>>>> first patch, that is, the one that grouped the sync_lock, last_tsc,
>>>> max_warp, nr_warps, and random_warps global variables into a single
>>>> struct?
>> The purpose of the first patch is just to avoid false cacheline sharing
>> between the watchdog cpu and another cpu that happens to access a nearby
>> data in the same cacheline.
>>
>> Now I realize that I should have followed up with this patch series. The
>> problem reported in that patch series happen on one system only, I believe.
> Thus far I am seeing eight systems, but out of a large number.  So this
> is very much preliminary.
>
>>> And what we are seeing is unlikely to be due to cache-latency-induced
>>> delays.  We see a very precise warp, for example, one system always
>>> has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
>>> Another is at the insanely large value of about 2^64/10, and shows some
>>> variation, but that variation is only about 0.1%.
>>>
>>> But any given system only sees warp on about half of its reboots.
>>> Perhaps due to the automation sometimes power cycling?
>>>
>>> There are few enough affected systems that investigation will take
>>> some time.
>> Maybe the difference in wrap is due to NUMA distance of the running cpu from
>> the node where the data reside. It will be interesting to see if my patch
>> helps.
> Almost all of them are single-socket systems.
>
> If the problem sticks with a few systems, I should be able to test
> patches no problem.  If it is randomly distributed across the fleet, a
> bit more prework analysis will be called for.  But what is life without
> a challenge?  ;-)

If it is happening on a single socket system, maybe it is caused by 
false cacheline sharing. It is hard to tell unless we find a way to 
reproduce it.

Cheers,
Longman

