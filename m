Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D855D6191FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKDH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKDH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:29:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814229818
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:29:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so3927395pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4AHL1ArkJMP3VpINV7IHJ4y63gC8hPEBDPsjyBu0Lg=;
        b=bPiz7ubzYRgIPCRk153B6vhHC66tGoLIwKswz5o0o3S220F8ZM7Hrr9iS1LKuWQ0v5
         Y7oG0vc0KDSRZ125liALnU8OdSozAaqu41OIkcfXZ1WpyFnd6uE248H6RpyZRKL4h4xI
         AfUsstQCepECnNKYx+3c0/ugs7P0A6VuNAzc7I/srvq611UrGuMHOf4A3yVkMt9zz8aJ
         7vzBZfoXgCpfqTSjQv1bDhbUpD1CxFJJULUThTO+irx8pF38ywmETvBrBAN8AALVAtks
         I3JHff2Y6Y7W0J+eTDGexvyNFsBw5dCcPS+BzSlXf/sUS/udgKf75r2fLoIjevrdg0U6
         2c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4AHL1ArkJMP3VpINV7IHJ4y63gC8hPEBDPsjyBu0Lg=;
        b=gK5EkBLI/X49ZJsFNdEETw0OHU1OxA95tMcG7aLySIGPVJ67lu7sQUUM6zIQgviI5v
         gdn9QgpdAmuUJ4slU5qmGsrhzgmujFWC/u2NWEXAdCnuiIyOWfVK1menfkELudvDL+Ft
         INwm3o5qO19CMKfXRpUHnzB+noVNKSoBdNhjHiNoxoJEiQOpD1YbN2+yVvw88SYt0XuY
         kbbFMCEq6myj4H917UNzgeyp5mpeXOxIyda6ChlzIYTXjR26XlvPY1uQJGnb1daskErc
         3DWftAzOTbjW0Vq8ds5DozRbIK+oUgD6pLGlXpGGFxjrwp+iH/24VEoVwz/1a2ZAdUul
         /XYw==
X-Gm-Message-State: ACrzQf1QdIxsc4nAmCCVEIGa7VZxjmk9ShtaanD0uF91fC2NoB1yTMld
        v1kVFejreMhl/Kjj2fqmtI1m7A==
X-Google-Smtp-Source: AMsMyM4Dh/iKPrU3+g9LmKwN1ZUXkfJrZftaGT/64+GcMTuTj7qgcg9/MQ7KSdbTV8mL4/SUQQMyOA==
X-Received: by 2002:a17:902:d4c7:b0:187:17bd:44df with SMTP id o7-20020a170902d4c700b0018717bd44dfmr28589886plg.108.1667546979057;
        Fri, 04 Nov 2022 00:29:39 -0700 (PDT)
Received: from [10.255.7.141] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709026e0200b00186a6b63525sm1895442plk.120.2022.11.04.00.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 00:29:38 -0700 (PDT)
Message-ID: <4f7253a0-a6dd-6d81-e3dd-49c334406373@bytedance.com>
Date:   Fri, 4 Nov 2022 15:29:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20221019122859.18399-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 10/19/22 8:28 PM, Abel Wu wrote:
> This patchset tries to improve SIS scan efficiency by recording idle
> cpus in a cpumask for each LLC which will be used as a target cpuset
> in the domain scan. The cpus are recorded at CORE granule to avoid
> tasks being stack on same core.
> 
> v5 -> v6:
>   - Rename SIS_FILTER to SIS_CORE as it can only be activated when
>     SMT is enabled and better describes the behavior of CORE granule
>     update & load delivery.
>   - Removed the part of limited scan for idle cores since it might be
>     better to open another thread to discuss the strategies such as
>     limited or scaled depth. But keep the part of full scan for idle
>     cores when LLC is overloaded because SIS_CORE can greatly reduce
>     the overhead of full scan in such case.
>   - Removed the state of sd_is_busy which indicates an LLC is fully
>     busy and we can safely skip the SIS domain scan. I would prefer
>     leave this to SIS_UTIL.
>   - The filter generation mechanism is replaced by in-place updates
>     during domain scan to better deal with partial scan failures.
>   - Collect Reviewed-bys from Tim Chen
> 
> ...
> 
