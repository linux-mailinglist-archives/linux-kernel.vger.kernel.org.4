Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB975FBF76
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJLDO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLDOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:14:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69271E27
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:14:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so15064792plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6f3RnKO5dXYr5Fm4sR2uAmWCpZHFDyj5bmlZqC9hdVs=;
        b=1UcTlWrc6PSvrj+S6k3xXlBpu6epdcoK1T7EnXL2mSJtMkz2ph8LUDdFRJiXvFXsuw
         53ON6YqAXI4WiabJg0r/y8v28eeOyL10YBNNHBj4OpVOhMgGadlAk3WZcaAnD7AbEZhb
         oOij2iKjg1JQsJmZa2/OnuKmNdc496OENtchf8BCoC2cxyyYoWFTKqPXzBWGcT3Rv7Ob
         gJnPZefsUHtY7owDvsUdD0HGJV0Hnk/Anj84TCNAxKT8bCUaOTubXPZQOurRSZKQEEcR
         CagBT7luAW1xJAiSKvQQSrfR/7WpBWYDGwj58yxvoSbycAUkNucKYVfTRnIIt6r7RmKv
         /Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6f3RnKO5dXYr5Fm4sR2uAmWCpZHFDyj5bmlZqC9hdVs=;
        b=FXvl5U2iqseNJ03c5gKT4arF66zGDaoXAxvLGceMTpMAAX/OM958fTJNeCBTKeiYEI
         zdpJXc4lIYrz3Y1FPUnJsg2wLyR8rlG9lVRTlVOBOJ21Hw8COrrYMgnq1nr77dw32de2
         uF40u/j1A1sy+1RnjBfRcGqegp5G6yycF2MN0nuSr+Da0M9BpOURAofLhUsLps3DqhFW
         m0XtgRm7+BSKrOkxR7dYSQmkMaX0c/ull64MhL3HMb7KMxu8PF8cYIS51JXBYYf3doZY
         3sHs9HGr+XOPIkDfjUK/eE8jit5m8PaBQYUvz+1m77MqLDq45yepz8Qr/MHeLgmHmrQd
         Typg==
X-Gm-Message-State: ACrzQf1TF+Z/sLvCKrjyD/15up5eJsC0rQNCMi+gu2/Y3Z8XgfHB324J
        EIZovpjMdLFzeaF5G+IGkGXqFQ==
X-Google-Smtp-Source: AMsMyM7fTv9DgyIIZ1/dWpYNVSQI2Bw8ZDsd5YMNIMsEe6ZPZw0RC/cYlKCfDwu+MmQQv4Ih5ut43Q==
X-Received: by 2002:a17:90b:4b83:b0:20c:5ac8:1e30 with SMTP id lr3-20020a17090b4b8300b0020c5ac81e30mr2683317pjb.71.1665544483672;
        Tue, 11 Oct 2022 20:14:43 -0700 (PDT)
Received: from [10.255.14.157] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id w124-20020a626282000000b00562784609fbsm9594961pfb.209.2022.10.11.20.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 20:14:43 -0700 (PDT)
Message-ID: <85145c75-f2f6-a393-daa2-967251cc3443@bytedance.com>
Date:   Wed, 12 Oct 2022 11:14:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Michal Hocko <mhocko@suse.com>,
        Frank van der Linden <fvdl@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
 <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
 <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 3:29 AM, Michal Hocko wrote:
> On Tue 11-10-22 10:22:23, Frank van der Linden wrote:
>> On Tue, Oct 11, 2022 at 8:00 AM Michal Hocko <mhocko@suse.com> wrote:
>>>
>>> On Mon 10-10-22 09:22:13, Frank van der Linden wrote:
>>>> For consistency with process_madvise(), I would suggest calling it
>>>> process_set_mempolicy.
>>>
>>> This operation has per-thread rather than per-process semantic so I do
>>> not think your proposed naming is better.
>>
>> True. I suppose you could argue that it should have been
>> pidfd_madvise() then for consistency, but that ship has sailed.
> 
> madvise commands have per mm semantic. It is set_mempolicy which is
> kinda special and it allows to have per task_struct semantic even when
> the actual allocation is in the same address space. To be honest I am
> not really sure why that is this way because threads aim to share memory
> so why should they have different memory policies?
> 
> I suspect that the original thinking was that some portions that are
> private to the process want to have different affinities (e.g. stacks
> and dedicated per cpu heap arenas). E.g. worker pools which want to be
> per-cpu local with their own allocations but operate on shared data that
> requires different policies.
> 
>>>> Other than that, this makes sense. To complete
>>>> the set, perhaps a process_mbind() should be added as well. What do
>>>> you think?
>>>
>>> Is there any real usecase for this interface? How is the caller supposed
>>> to make per-range decisions without a very involved coordination with
>>> the target process?
>>
>> The use case for a potential pidfd_mbind() is basically a combination
>> of what is described for in the process_madvise proposal (
>> https://lore.kernel.org/lkml/20200901000633.1920247-1-minchan@kernel.org/
>> ), and what this proposal describes: system management software acting
>> as an orchestrator that has a better overview of the system as a whole
>> (NUMA nodes, memory tiering), and has knowledge of the layout of the
>> processes involved.

This is exactly why we are proposing pidfd/process_set_mempolicy().

> 
> Well, per address range operation is a completely different beast I
> would say. External tool would need to a) understand what that range is
> used for (e.g. stack/heap ranges, mmaped shared files like libraries or
> private mappings) and b) by in sync with memory layout modifications
> done by applications (e.g. that an mmap has been issued to back malloc
> request). Quite a lot of understanding about the specific process. I
> would say that with that intimate knowledge it is quite better to be
> part of the process and do those changes from within of the process
> itself.

Agreed, the orchestrator like system management software may not have
enough knowledge about per address range. And I also don't think it is
appropriate for orchestrators to overwrite tasks' mempolicy as well,
they are set for some purpose by the apps themselves. So I suggested
a per-mm policy which have a lower priority than the tasks'.

Thanks & BR,
Abel
