Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06663CF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiK3Gf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiK3Gf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:35:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B067312633
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:35:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so996799pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 22:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQzw09s2YwENgPh3kcIlxMFdlq6/U8LtjhKa53FFTXs=;
        b=RKCfaikQnFu+aWmxcV+ef9Xis3fI/MUKtFup79ki8rmGyDjypmJkt3BYFP7uuHnAI3
         PqEaJJaNg25ErXpk9PGY2HmTA+owlJ9vuvxgSnQJIxa6KWqHsu7mFt/5VzdWHfsr3yS6
         tn64oBolsBzlfaIyLlvAZw8wK5e3QKNqZgNqXBjafc/s7S0agcySJ/jT9+YRTCarV35T
         ladoglKs+c2MFPZxGhuC1yJ/rxogOs4QJESXYVMXlGHARfpjPT/wg3k/TKN1MRjOvDt2
         fBUAT03axEEWswFoZYad3CBUkReClt0Ngahy11XGGnCVIemxC5PtdzUk+fNaqiFKqBG4
         Jc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sQzw09s2YwENgPh3kcIlxMFdlq6/U8LtjhKa53FFTXs=;
        b=CRcMumSxNJtGZZ9iHc3nSP4YerlxozJDTyVxUARQrZkohrXoJ17uAUDV/YJb29j+IF
         2JH0t0rKCMvTQZWiIx9sTwKqaegcmcGEyw3CtPP7lh12gvB7waXx5jWvk3zDqGWVog1F
         ntPulnlt+i7MZjXSHNEcPb3Xox4d7AN4uuSpLglT3opLPi6hbYNfF/WHFyBhziefCF0o
         89Ke41Um9gi8RIxgTss/u0kllF8gER8+QoYWrHR9P9MhltAb3LLB+LvYV+TFQ1OZyJjO
         RlwBTTG1B+9/rVH/ea04oGYRJBn0+3kQiOo/V9TXa+nXRxmK9AWBBI25i3b2zv35pECq
         ibfw==
X-Gm-Message-State: ANoB5pkhsxOmzNy260QLwKzbLSvqI8CvNk1wCvW6KqW0vRriOTCPje0v
        1ydgnrZo5m0V0GZn93ijinPh5g==
X-Google-Smtp-Source: AA0mqf4uRhG1Q09/XPdSJXAXV6vZ58q4Y2KRaDLelxB2+eQ8ZntocGSARXeg8Y+GnBjpN+icTBTsIw==
X-Received: by 2002:a17:90a:ae16:b0:218:fada:57fd with SMTP id t22-20020a17090aae1600b00218fada57fdmr30096289pjq.12.1669790156257;
        Tue, 29 Nov 2022 22:35:56 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b0017ec1b1bf9fsm464381plh.217.2022.11.29.22.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 22:35:55 -0800 (PST)
Message-ID: <7ca91933-2e49-1813-bb30-363c540e5139@bytedance.com>
Date:   Wed, 30 Nov 2022 14:35:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH v2 2/2] sched/core: Adjusting the order of
 scanning CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
 <20221026064300.78869-3-jiahao.os@bytedance.com>
 <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 Mel Gorman wrote:
> On Wed, Oct 26, 2022 at 02:43:00PM +0800, Hao Jia wrote:
>> When select_idle_capacity() starts scanning for an idle CPU, it starts
>> with target CPU that has already been checked in select_idle_sibling().
>> So we start checking from the next CPU and try the target CPU at the end.
>> Similarly for task_numa_assign(), we have just checked numa_migrate_on
>> of dst_cpu, so start from the next CPU. This also works for
>> steal_cookie_task(), the first scan must fail and start directly
>> from the next one.
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> 
> Test results in general look ok so
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 

Hi, Peter
These two patches have been Acked-by Mel Gorman.
If you have time, please review these two patches.

Thanks，
Hao
