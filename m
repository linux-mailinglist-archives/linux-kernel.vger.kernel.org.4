Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2AA6DDBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDKNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDKNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:17:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC330FE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:17:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e18-20020a17090ac21200b00246952d917fso6356774pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681219053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYzMqMQLWwJeC6OGUwmJWcqketmIRYbxIgkEUyuEFt4=;
        b=P1erKL2EU4UpxT3LNTe4A5/bZ8blCn0k9bzNo/S562ki4ed2xT7q7WtfsuY1bJt4rs
         X+hWnFXwZSOGMWe53hmqw4kufYfrMOQrJ0Bd8zld2rnQv0a9JIyOX9mii3aPzX3mAX2F
         HcLbqqUFZmx74vhjdKoyBNgwTuz838ddshZe2qotABo4tHJH1B8sqN/fq/b5Mb6M+u5u
         0LvNHchxcevPWHmxTzgk6xauQkC0R9cI6ZyJt+Zv9rVp0N8TZcaFBeNGTWHEKo6msBkI
         KERk1aC60cvZl3R3KieEsJZKgCwW9UoBCNMScvmIPUmywUUl2gVLQ4aiVpld2gEuyqcr
         jFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYzMqMQLWwJeC6OGUwmJWcqketmIRYbxIgkEUyuEFt4=;
        b=j7pl9lqjLqRrGMFb24DpUCCsDvqKl8a/PtKMbYVz4/UAazGfRnRjj5h2g6X3P+/9J6
         cFOmu3fy4v2VLYMKiQ8QYNAOWdNz1ptzZU3iovHIwGDopjBED/M24Af8HqxqlO0WwHqE
         aD75mlffVfD/VjGiiO2ejm+PheXCRsx9jD3XK2vnJiP6FnmFyVFehTNMaDYZamV1P941
         EOMlEH8Xpo/ggRVdGApNsQjaHyd2hEpTXRUiIjjKjrTZ3o2ZO/txXqQuo+nc2ib+GMj0
         4UQSZjO2mDU2FVHdJ7lJ3KYnL/141PLYMICP2whTwWFJkY0EoevEL405HlA9yl/JHwTZ
         +35A==
X-Gm-Message-State: AAQBX9drCqunpoHyX/jfHEleNtneKsdxpQtA1x+/paGPDiDNGdpbT9ol
        Nrt8dHE7FO/GXgx7jkikmlPy/A==
X-Google-Smtp-Source: AKy350YAGaeIEzPbfbi2Wxc4GVr9yYYxoy6vhvkknSyhnDHERSJjog9wfEWDOpHDUCdeEii5MO3thw==
X-Received: by 2002:a05:6a20:ba95:b0:d9:ec4b:82c8 with SMTP id fb21-20020a056a20ba9500b000d9ec4b82c8mr14565681pzb.48.1681219053308;
        Tue, 11 Apr 2023 06:17:33 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b00638ac6f9a0bsm3601096pfo.11.2023.04.11.06.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:17:32 -0700 (PDT)
Message-ID: <e6ff9768-f41d-553c-e858-1b244a461526@bytedance.com>
Date:   Tue, 11 Apr 2023 21:17:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: Re: Re: [PATCH v4] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        Zefan Li <lizefan.x@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20230411065816.9798-1-ligang.bdlg@bytedance.com>
 <3myr57cw3qepul7igpifypxx4xd2buo2y453xlqhdw4xgjokc4@vi3odjfo3ahc>
 <aa3382b4-4046-988f-42ea-8812dba7882b@bytedance.com>
 <ZDVcwuiu3rWEFiTE@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <ZDVcwuiu3rWEFiTE@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 21:12, Michal Hocko wrote:
> On Tue 11-04-23 21:04:18, Gang Li wrote:
>>
>>
>> On 2023/4/11 20:23, Michal Koutný wrote:
>>> Hello.
>>>
>>> On Tue, Apr 11, 2023 at 02:58:15PM +0800, Gang Li <ligang.bdlg@bytedance.com> wrote:
>>>> +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>>>> +		if (nodes_equal(cs->mems_allowed, task_cs(current)->mems_allowed)) {
>>>> +			css_task_iter_start(&(cs->css), CSS_TASK_ITER_PROCS, &it);
>>>> +			while (!ret && (task = css_task_iter_next(&it)))
>>>> +				ret = fn(task, arg);
>>>> +			css_task_iter_end(&it);
>>>> +		}
>>>> +	}
>>>> +	rcu_read_unlock();
>>>> +	cpuset_read_unlock();
>>>> +	return ret;
>>>> +}
>>>
>>> I see this traverses all cpusets without the hierarchy actually
>>> mattering that much. Wouldn't the CONSTRAINT_CPUSET better achieved by
>>> globally (or per-memcg) scanning all processes and filtering with:
>>
>> Oh I see, you mean scanning all processes in all cpusets and scanning
>> all processes globally are equivalent.
> 
> Why cannot you simple select a process from the cpuset the allocating
> process belongs to? I thought the whole idea was to handle well
> partitioned workloads.
>

Yes I can :) It's much easier.

>>> 	nodes_intersect(current->mems_allowed, p->mems_allowed
>>
>> Perhaps it would be better to use nodes_equal first, and if no suitable
>> victim is found, then downgrade to nodes_intersect?
> 
> How can this happen?
> 
>> NUMA balancing mechanism tends to keep memory on the same NUMA node, and
>> if the selected victim's memory happens to be on a node that does not
>> intersect with the current process's node, we still won't be able to
>> free up any memory.
> 
> AFAIR NUMA balancing doesn't touch processes with memory policies.

