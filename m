Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BD5ED34B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiI1DKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiI1DJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:09:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2FF7B1E1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:09:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so552151pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zE7FRbXVPXMEH0b3SCAktRXR5ucy9Cwb3p8sNyPms6k=;
        b=7Gk9byhcd7iaiCUxW9fPwqLZ1MFtkv5Clj4uvCPSsGM1y7EO3tQ93QukOy/hGkhfdm
         AgOrIMM2SjaloUB63geELSqt32Fn6CqeXF8Y3LKmzq4dRYidmX+Q/v5DyJkCykX8Kepd
         XQWR8UO3Cb/E1TUXfavDlTFRpCjjMXXqpBBBPDLAKHbXPWmweIaot6zqT0zTfA4UCgbH
         72/lXNOoaDhFmTLJqvmv4wL1nsD0rEW8cJCvRXTEgksSXk+S88KUM/AkCEVGYnRI8ss0
         T1AFP5cJ5pPcs3PKOu4Rv6JtvSgvyIq2UIiha6M3NczrbtCi42FiC+0X7Yzf5B5sXkJx
         yTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zE7FRbXVPXMEH0b3SCAktRXR5ucy9Cwb3p8sNyPms6k=;
        b=4LLf1zX7qy4kDs7SA8yF+3g4SeM/nJJ8Vf1vtXIbmYoi+UgJNAsbsbg4vmpF80B8G1
         F9nnp8dJeVbOWo2xflR9B9jaHkP2XHOyhbn3TGc/v5VM65FnGMxgW5i2aEAQin5lVF9O
         +A1O4D1HmcNBlOT9dnLKKXDouiYL+CT/Io4GrTfh0AUcPfzjnztAgPI0nIHJMEq+gzY1
         bdGHY5F5VrTdsZbBSU8HUz3u1yFFJ469GKyHrSZAxtuGrbeqssokIevR5+3BUJWhSTqI
         OUihVHyfwN4DE/lpIAUuGALvKod/8tJ+r2bUm+our5gHi/aWIhs4bV4iKnLnStZXqjfE
         1MTg==
X-Gm-Message-State: ACrzQf3uQTP1b7N9vCuMfKhRTibP9vPToN7lQFsa8oiBrL4iyUOUM51U
        S4QR+2xxtWWZlqp57zqR4FtUDw==
X-Google-Smtp-Source: AMsMyM59Ac5doia8SG1Tk6ELgAAt60AKGObQlhx6QKt3jqPT3bnUgFIyecNFAzz02Y9xAJ06qbut/A==
X-Received: by 2002:a17:902:d50f:b0:178:6505:fae3 with SMTP id b15-20020a170902d50f00b001786505fae3mr30442831plg.54.1664334592382;
        Tue, 27 Sep 2022 20:09:52 -0700 (PDT)
Received: from [10.255.19.83] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id lt4-20020a17090b354400b00205e940614dsm274076pjb.34.2022.09.27.20.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 20:09:51 -0700 (PDT)
Message-ID: <4e2aa5c2-3d8c-2a2f-691b-218e23e7271f@bytedance.com>
Date:   Wed, 28 Sep 2022 11:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy type.
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
 <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
 <7ac9abce-4458-982b-6c04-f9569a78c0da@bytedance.com>
 <YzLVTxGHgYp3Es4t@dhcp22.suse.cz>
 <9a0130ce-6528-6652-5a8e-3612c5de2d96@bytedance.com>
 <YzMBnKUo8ny9S/7+@dhcp22.suse.cz>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YzMBnKUo8ny9S/7+@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 9:58 PM, Michal Hocko wrote:
> On Tue 27-09-22 21:07:02, Abel Wu wrote:
>> On 9/27/22 6:49 PM, Michal Hocko wrote:
>>> On Tue 27-09-22 11:20:54, Abel Wu wrote:
>>> [...]
>>>>>> Btw.in order to add per-thread-group mempolicy, is it possible to add
>>>>>> mempolicy in mm_struct?
>>>>>
>>>>> I dunno. This would make the mempolicy interface even more confusing.
>>>>> Per mm behavior makes a lot of sense but we already do have per-thread
>>>>> semantic so I would stick to it rather than introducing a new semantic.
>>>>>
>>>>> Why is this really important?
>>>>
>>>> We want soft control on memory footprint of background jobs by applying
>>>> NUMA preferences when necessary, so the impact on different NUMA nodes
>>>> can be managed to some extent. These NUMA preferences are given by the
>>>> control panel, and it might not be suitable to overwrite the tasks with
>>>> specific memory policies already (or vice versa).
>>>
>>> Maybe the answer is somehow implicit but I do not really see any
>>> argument for the per thread-group semantic here. In other words why a
>>> new interface has to cover more than the local [sg]et_mempolicy?
>>> I can see convenience as one potential argument. Also if there is a
>>> requirement to change the policy in atomic way then this would require a
>>> single syscall.
>>
>> Convenience is not our major concern. A well-tuned workload can have
>> specific memory policies for different tasks/vmas in one process, and
>> this can be achieved by set_mempolicy()/mbind() respectively. While
>> other workloads are not, they don't care where the memory residents,
>> so the impact they brought on the co-located workloads might vary in
>> different NUMA nodes.
>>
>> The control panel, which has a full knowledge of workload profiling,
>> may want to interfere the behavior of the non-mempolicied processes
>> by giving them NUMA preferences, to better serve the co-located jobs.
>>
>> So in this scenario, a process's memory policy can be assigned by two
>> objects dynamically:
>>
>>   a) the process itself, through set_mempolicy()/mbind()
>>   b) the control panel, but API is not available right now
>>
>> Considering the two policies should not fight each other, it sounds
>> reasonable to introduce a new syscall to assign memory policy to a
>> process through struct mm_struct.
> 
> So you want to allow restoring the original local policy if the external
> one is disabled?

Pretty much, but the internal policies are expected to have precedence
over the external ones, since they are set for some reason to meet their
specific requirements. The external ones are used only when there is no
internal policy active.

> 
> Anyway, pidfd_$FOO behavior should be semantically very similar to the
> original $FOO. Moving from per-task to per-mm is a major shift in the
> semantic.  I can imagine to have a dedicated flag for the syscall to
> enforce the policy to the full thread group. But having a different
> semantic is both tricky and also constrained because per-thread binding
> is then impossible.

Agreed. What about a syscall only apply to per-mm? There are precedents
like process_madvice(2).
