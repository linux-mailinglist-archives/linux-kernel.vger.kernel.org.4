Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D76983FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBOS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBOS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:58:57 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DD3BD88;
        Wed, 15 Feb 2023 10:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1676487532;
        bh=fvEcUnHEx5ztRRI3eUizYkio/MyOz/x+Kw4OFi1gFXA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eLbyf4X11+peGKKsJWOzzT+wakEuiq4Vspyu43c/LAfYhmAmIqS8agwtaO6d5E2Ga
         ePl+N8c9x4RFkGC7tQveKn2lyH5gfYnwJ0JkvIYrsd5IraZcUUhijhaHkPmFpOdq9k
         cc8zc8F/xIRP9eijB7WkhZkiHqW4s1qGCR/KIHWEfELMXw6GaK/oqTzmSKrV2117yo
         3GMuT1VMtjf9JBeYWP/7+4KGo0xQYF0wqDyqVarCP3PUx06xAakYq1YlzxHqZaDnoU
         S1VginEGAm43JGhgiv4RFRNyyJq3ZZYdg1cqTiOd5MNSTBdF9DqN941kp+R1xSi0aI
         CJUpG8VrcovfQ==
Received: from [172.16.0.188] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PH6mr3P0szlcF;
        Wed, 15 Feb 2023 13:58:52 -0500 (EST)
Message-ID: <f53d0ff8-5f46-ca89-ec3d-b88d8f2db187@efficios.com>
Date:   Wed, 15 Feb 2023 13:58:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <849b233c-b094-849d-a8fe-9b53cde33c80@efficios.com>
 <63b28ab6-1a5b-0031-8860-51bc66d80ee5@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <63b28ab6-1a5b-0031-8860-51bc66d80ee5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15 12:16, Alejandro Colomar wrote:
[...]
>>>
>>>>> +user-space performs any side-effect
>>>>> +(e.g. storing to memory).
>>>>> +.IP
>>>>> +This field is always guaranteed to hold a valid CPU number in the range
>>>>> +[ 0 ..  nr_possible_cpus - 1 ].
>>>>
>>>> Please use interval notation:
>>>> 	[0, nr_possible_cpus)
>>>> or
>>>> 	[0, nr_possible_cpus - 1]
>>>> whichever looks better to you.
>>>>
>>>> We did some consistency fix recently:
>>>> <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=147a60d792a5db8f3cb93ea16eefb73e16c1fb91>
>>>>
>>>> Also, do we have a more standard way of saying nr_possible_cpus?
>>>> Should we say nproc?
>>
>> nproc(1) means:
>>
>>          Print  the number of processing units available to the current
>>          process, which may be less than the number of online processors
>>
>> Which is the number of cpus currently available (AFAIU the result of the
>> cpuset and sched affinity).
>>
>> What I really mean here is the maximum value for possible cpus which can
>> be hotplugged into the system. So it's not the maximum number of
>> possible CPUs per se, but rather the maximum enabled bit in the possible
>> CPUs mask.
>>
>> Note that we could express this differently as well: rather than saying
>> that it guarantees a value in the range [0, nr_possible_cpus - 1], we
>> could say that the values are guaranteed to be part of the possible cpus
>> mask, which would actually more accurate in case the possible cpus mask
>> has a hole (it tends to happen with things like lxc containers nowadays).
>>
>> Do you agree that we should favor expressing this in terms of belonging
>> to the possible cpumask set rather than a range starting from 0 ?
> 
> On 2/15/23 18:12, Mathieu Desnoyers wrote:
>> Actually, the field may contain the value 0 even if 0 is not part of the
>> possible cpumask. So forget what I just said about being guaranteed to
>> be part of the possible cpus mask.
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
> 
> I don't have a full understanding, so I will trust you for deciding what is
> best.  I'll try to understand it, but my kernel knowledge is rather limited :)
> 
> I suggest writing a detailed description, instead of (or complementary to it)
> just using a range, since readers might wonder as I did, what nr_possible_cpus
> is (it's not really described anywhere so far).  With a worded description,
> we can later improve it if we find it not clear enough, but should be enough
> for an initial page.

After giving it some thoughts, I think the most precise description 
would be that the cpu number is guaranteed to be either 0, or the CPU 
number on which the registered thread is running. Let's not bring in 
notions of possible cpus (those come from 
/sys/devices/system/cpu/possible) unless it's absolutely required.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

