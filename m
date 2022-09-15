Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8A5B92EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIODLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIODLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:11:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC1910B1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:11:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l65so16713919pfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Df4Q+p21i6BAOOxlyeKYbdBPwLSo5on6XAFItnq9J4g=;
        b=dmLow7cHYA2K37pcmPrH+JGrq2Z60p4HWDZLEWZWnvBjiqRP8ugHXXDURmE8yy/wpu
         sXzy/ur6rVh9gZwl0tiHyhLnd6LCSO28lwm0M4igEkqyWT1ERr8yhOmMv+JOy00mesUY
         xfNM9llme21N9zKlWGpTXMT46nLmsyH6MI6AfG6NqSeDD3jGZhLGIej7YmGBTNsDLZ5f
         Fm/Vm73MHGWCRSH4GWloXSRQOcr90xq0VFWkvgyoOpELp8VPbniIILWZBu7xuEo536rr
         hP5+wBupIFwoxagNT0z5FVt4rE9coenAPzj+8mV+JnSuqpqWbI/oXLxUyl23yLeeAmfG
         js0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Df4Q+p21i6BAOOxlyeKYbdBPwLSo5on6XAFItnq9J4g=;
        b=QjvQQUwZkDzBSt275OvvhAoSYEWUFm0PGTK3JxLv8pP4w+m1qOM4TcMQEcfwPuxwdl
         hozUeiNnG55f90YWeHrD5zNaXXYp09WzjaDO5oqFmOdNZ6UDjFDyFzwm8YEvQOwzLASU
         Wv/DPoIw2b6QVQOqrdcMRnJKyJrywhUWxNOLqGbdS7wl8HCOfCNgLbuZfvGqxdxiaSJy
         P0ieIlYo6ld8fxP7/BCgD1NUHUn8/acRLn3C9pEBJLsgPdI82kE0eLkw57dTpXXpJso9
         jSJUKNs8KgFlYKpW9C4/g9rXCIevgKxst81tvm2GIXGFDS/DlrrIgRY8blXC4daBUrXt
         u10g==
X-Gm-Message-State: ACgBeo15jOu/o2ql5C7xVOFaOZSNJ8hzbrbCxIuigaURzRuxCN07hIWv
        RcklPyw+zhtmm6KoNoC+2jKdwQ==
X-Google-Smtp-Source: AA6agR4t1QcHo1qc8Cw0CuyaOB37e6/cBNVlJKDMMK9qtYgNPGwvEme1XQi0aVNVFBXwiq5YgQoNaA==
X-Received: by 2002:a63:5915:0:b0:438:d560:c4d3 with SMTP id n21-20020a635915000000b00438d560c4d3mr18364128pgb.240.1663211470897;
        Wed, 14 Sep 2022 20:11:10 -0700 (PDT)
Received: from [10.255.16.83] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id y34-20020a631822000000b0041d6d37deb5sm10427311pgl.81.2022.09.14.20.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 20:11:10 -0700 (PDT)
Message-ID: <ad2af462-8984-f83a-c9df-d8bf66fbee89@bytedance.com>
Date:   Thu, 15 Sep 2022 11:11:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v5 4/5] sched/fair: Skip SIS domain scan if fully busy
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-5-wuyun.abel@bytedance.com>
 <95bbbc9b927abf3c756e6cce810be69e85985541.camel@linux.intel.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <95bbbc9b927abf3c756e6cce810be69e85985541.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 8:22 AM, Tim Chen wrote:
> On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
>> If a full domain scan failed, then no unoccupied cpus available
>> and the LLC is fully busy.  In this case we'd better use cpus
>> more wisely, rather than wasting it trying to find an idle cpu
>> that probably not exist. The fully busy status will be cleared
>> when any cpu of that LLC goes idle and everything goes back to
>> normal again.
>>
>> Make the has_idle_cores boolean hint more rich by turning it
>> into a state machine.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 35 +++++++++++++++++-
>>   kernel/sched/fair.c            | 67 ++++++++++++++++++++++++++++------
>>   2 files changed, 89 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 816df6cc444e..cc6089765b64 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -77,10 +77,43 @@ extern int sched_domain_level_max;
>>   
>>   struct sched_group;
>>   
>> +/*
>> + * States of the sched-domain
>> + *
>> + * - sd_has_icores
>> + *	This state is only used in LLC domains to indicate worthy
>> + *	of a full scan in SIS due to idle cores available.
>> + *
>> + * - sd_has_icpus
>> + *	This state indicates that unoccupied (sched-idle/idle) cpus
>> + *	might exist in this domain. For the LLC domains it is the
>> + *	default state since these cpus are the main targets of SIS
>> + *	search, and is also used as a fallback state of the other
>> + *	states.
>> + *
>> + * - sd_is_busy
>> + *	This state indicates there are no unoccupied cpus in this
> 
> Suggest reword to
> 
> .. indicates that all cpus are occupied in this ...

OK, I will make a update in next version!

Thanks,
Abel
