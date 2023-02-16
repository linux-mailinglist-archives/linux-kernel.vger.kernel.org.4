Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAD699238
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBPKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBPKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:51:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0F22A00
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:51:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso1722431pjr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nChoiqV2yK6Jy1ylzJ1lVYh06ZMHX2KGT08aNMbO+f0=;
        b=El23xDo4oC8g7+TXtctCcEVoB+mx01JYv93T1FrJMjLYZv4QVl6faN4AiG5cgmhFO+
         NryvTNV/tWkKNNnZ/J1d983Ql/MdTbxU7ANNPSstQBbD565OAAe3Ptxa8covwK0kmKrG
         Wwyob8wtPuRPCoBZXYw3lOdJK/trhSlltZZ6uPe6LaIz5CsoVAmE6h4Aoe+eiNIv3MFP
         TlIfFXLVo8NPPig5zIv+8VXf/fba9BoH3l4jU9LRWtd2nLu2bDW0VOwippdrnI4OkWTN
         cr2BX4vli0syKH1XPJQgz5N5ZJL/23CTBsx+IdNS1Onh4m3G6mRiZzAhwpHf346rJL/t
         npkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nChoiqV2yK6Jy1ylzJ1lVYh06ZMHX2KGT08aNMbO+f0=;
        b=wCOMfzYA6okd2bl80W0gp59E1PzXlg5H8kGYjbJzR1STaBUG6fy0qbRNMb712UDtRt
         t0on0hMcNViKwaENVoBgVVEc2/fb6EBLQ9ohimrs8Gi2BwHqf9FtWGDAv6q51U3puIN1
         4AeiYhrTpEEx74ELD+9hMc5k7cSyLy+KFTmzuEQuzVynYxDeJAv1VAech4TvEoWfhUut
         rNT8RVY2+7WwahTrLZoH8IJEPqM0l+/7V/YV6OFb0P2N9QODBi9iU4LNXiwq4ytANLPI
         HH9D2nLFtNwCyrCl2HcjN30Ov5fNQZsXIVeVFyThaPv+rTewjye4NXe2ALF686O99Ylc
         HraQ==
X-Gm-Message-State: AO0yUKXRTG7/K0M3MojtxOPqMGMk6QXfY2nc/e7KJ/C6IhKXKvqRlJk3
        t5oQcbJfH7QJ5T8waZVk2zEMZw==
X-Google-Smtp-Source: AK7set+SRcz2gDYqS5ySRJL78XzF8sO3NZKUxaITPWdZl8H3wOGhPfc1ttGmSgfIRcP5FGtkdRLyEw==
X-Received: by 2002:a17:902:e5ce:b0:19a:f556:e386 with SMTP id u14-20020a170902e5ce00b0019af556e386mr1186100plf.0.1676544666218;
        Thu, 16 Feb 2023 02:51:06 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902d34b00b0019ac69a6348sm1025261plk.133.2023.02.16.02.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:51:05 -0800 (PST)
Message-ID: <fc6f1ef3-59b7-9f6d-905c-2c8468f8f9bb@bytedance.com>
Date:   Thu, 16 Feb 2023 18:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH 0/2] handle memoryless nodes more appropriately
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rppt@kernel.org, willy@infradead.org, mgorman@techsingularity.net,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
References: <20230215152412.13368-1-zhengqi.arch@bytedance.com>
 <Y+0KKnN8BU6ky6oP@dhcp22.suse.cz>
 <3426457c-99bf-9f7c-f663-c29474d9fa73@bytedance.com>
 <Y+3gb/blCDJnQ0Ik@dhcp22.suse.cz>
 <767893ef-f8c2-c478-f1a0-e785bbf2da09@bytedance.com>
 <Y+3rTq9lBhHnJZ19@dhcp22.suse.cz>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+3rTq9lBhHnJZ19@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/16 16:37, Michal Hocko wrote:
> On Thu 16-02-23 16:21:54, Qi Zheng wrote:
>>
>>
>> On 2023/2/16 15:51, Michal Hocko wrote:
>>> On Thu 16-02-23 07:11:19, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2023/2/16 00:36, Michal Hocko wrote:
>>>>> On Wed 15-02-23 23:24:10, Qi Zheng wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Currently, in the process of initialization or offline memory, memoryless
>>>>>> nodes will still be built into the fallback list of itself or other nodes.
>>>>>>
>>>>>> This is not what we expected, so this patch series removes memoryless
>>>>>> nodes from the fallback list entirely.
>>>>>>
>>>>>> Comments and suggestions are welcome.
>>>>
>>>> Hi Michal,
>>>>
>>>>>
>>>>> This is a tricky area full of surprises and it is really easy to
>>>>
>>>> Would you mind giving an example of a "new problem"?
>>>
>>> The initialization is spread over several places and it is quite easy to
>>> introduce bugs because it is hard to review this area. Been there done
>>> that. Just look into the git log.
>>
>> I understand your concern, but should we therefore reject all revisions
>> to this?
> 
> No, but either somebode is willing to invest a non-trivial amount of
> time and unify the NUMA initialization code that is spread over arch
> specific code in different places or we should just focus on addressing
> bugs.
> 
>>>>> introduce new problems. What kind of problem/issue are you trying to
>>>>> solve/handle by these changes?
>>>>
>>>> IIUC, I think there are two reasons:
>>>>
>>>> Firstly, as mentioned in commit message, the memoryless node has no
>>>> memory to allocate (If it can be allocated, it may also cause the panic
>>>> I mentioned in [1]), so we should not continue to traverse it when
>>>> allocating memory at runtime, which will have a certain overhead.
>>>
>>> Sure that is not the most optimal implementation but does this matter in
>>> practice? Can you observe any actual measurable performance penalty?
>>
>> No, and the original reason for noticing this place was the panic I
>> mentioned in [1] (< NODE_MIN_SIZE). And if we had handled the memoryless
>> node's zonelist correctly before, we wouldn't have had that panic at
>> all.
> 
> Yes, this is another good example of how subtle the code is. Mike has
> posted a patch that simply drops the NODE_MIN_SIZE constrain and I
> believe that is the right thing to do at this stage. There is a non-zero
> risk of regression but at least we will be forced to fix the original
> problem properly or at least document is properly.
> 
>>> Currently we are just sacrificing some tiny performance for a
>>> simplicity.
>> Hmm, I don't think my modification complicates the code.
>>
>>>> Secondly, from the perspective of semantic correctness, why do we remove
>>>> the memoryless node from the fallback list of other normal nodes
>>>> (N_MEMORY), but not from its own fallback list (PATCH[1/2])? Why should
>>>> an upcoming memoryless node continue exist in the fallback list of
>>>> itself and other normal nodes (PATCH[2/2])?
>>>
>>> I am not sure I follow. What is the semantic correctness issue?
>>
>> Sorry for the ambiguity, what I meant was that memoryless nodes should
>> never have been built into any fallback list, not just for performance
>> optimizations.
> 
> Well, I am not 100% sure I agree with you here. The performance would be
> the only reason why to drop those nodes from zonelists. Other than that
> zonelists are a useful abstraction for the node distance ordering. Even
> if those nodes do not have any memory at all in principle there is no
> big difference from depleted nodes.

I see what you mean, no more code for no more bugs (in cases where is no
obvious gain). But I still feel that the current implementation is
rather weird (deleted some, and kept some), and my changes are actually 
very small.

Anyway, let's wait for other people's opinions. :)

-- 
Thanks,
Qi
