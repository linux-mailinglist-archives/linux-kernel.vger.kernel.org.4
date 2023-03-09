Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7016B210F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCIKQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCIKPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:15:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E86BC0F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:14:39 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 16so697460pge.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678356875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zRjlS/x1jsvYaRzB7frJltPlqGScRQ8RsMJB8GeG8A8=;
        b=PWwo0aIUCjfe13Q7qlY6rxAmoK2xdmWW6koz0OWgwvKXIuMOK3o1ph+kiodD4utt4q
         UR35AHWkL7JXhrvaldUcBocysfrDDnrqC4NgP8JAPRp9JpnIGsJLik12ZHJtUUxIpx8m
         8hZy4NTtnu5lhTzXP2gdRMffcjGEzv2p9yPv43zd641d/UI2iW94/vN1ENJfINrmWs3T
         fqbgjRQDGU1RUl1v023fraZEMrKlhQtrW716lBaeFNpwjGT0yzofa+bfyigzHXdSaOpl
         wMpd9Y3vkRwVAG3p0207+SlUXpruanA/R5I8XgOhWF+O6NVmTlRqUA3Er79Geshj0oxG
         cvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRjlS/x1jsvYaRzB7frJltPlqGScRQ8RsMJB8GeG8A8=;
        b=hSEKHkS9ZtPRNhy96nE3gdl9X2gcE/UfFetmGcV98L2QrnUfc8clsUpUUAZ7/rYxUL
         s08EFJEvmenv6GgGOi6SIujLTW/uUujWqGwouOYv4nbjy1MorW8Lu0T0zk7K6vNqGOCK
         JPVrkmM8qbfhBSUYRCoeYlgayF1OOe/NKXjYDUGjeQK9l4PWzCCuzPbvZzZmWGwRsdOL
         lorIsCtMpt2vN1ojprUt5q4qUvBS/pdzl1TSOkIMNmbnRcXaVC32TU0yk91uxLxxQSyG
         S5qRiJwXvom0eDJWemebfvuo1n2qaZG69iN6D+tRahub5FW5aRyc1ohV7bs1+DWJ0JJs
         vbvg==
X-Gm-Message-State: AO0yUKWydDa23pEEW1J74i//x8a2Jb41iZfCvFxocRWpWetPf3HCRBCo
        3Iq1OQXeZLfRp+YhvVtjujJmNw==
X-Google-Smtp-Source: AK7set/yZ/A0txod0XKplAfsCRbSc43n6gugxtldDG+TfYxLxoPRYJn+eC4d1QtWhT3e2OJNm+5IRw==
X-Received: by 2002:a05:6a00:e0d:b0:5fc:cd83:92f1 with SMTP id bq13-20020a056a000e0d00b005fccd8392f1mr20783930pfb.1.1678356875644;
        Thu, 09 Mar 2023 02:14:35 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b005d55225fc07sm10816891pfn.73.2023.03.09.02.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:14:35 -0800 (PST)
Message-ID: <dcbf7e13-c4c6-4e66-92f1-103d111ec611@bytedance.com>
Date:   Thu, 9 Mar 2023 18:14:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/8] mm: shrinkers: make count and scan in shrinker
 debugfs lockless
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-6-zhengqi.arch@bytedance.com>
 <96f34c88-ca9a-1c3c-e02a-7c5cd1a269e4@suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <96f34c88-ca9a-1c3c-e02a-7c5cd1a269e4@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/9 17:39, Vlastimil Babka wrote:
> On 3/7/23 07:56, Qi Zheng wrote:
>> Like global and memcg slab shrink, also use SRCU to
>> make count and scan operations in memory shrinker
>> debugfs lockless.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/shrinker_debug.c | 24 +++++++-----------------
>>   1 file changed, 7 insertions(+), 17 deletions(-)
>>
>> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
>> index 39c3491e28a3..6aa7a7ec69da 100644
>> --- a/mm/shrinker_debug.c
>> +++ b/mm/shrinker_debug.c
> 
> Forgot to mention that this file should now likely also #include <linux/srcu.h>

Got it. Will do.

Thanks,
Qi

> 
>> @@ -9,6 +9,7 @@
>>   /* defined in vmscan.c */
>>   extern struct rw_semaphore shrinker_rwsem;
>>   extern struct list_head shrinker_list;
>> +extern struct srcu_struct shrinker_srcu;
> 
