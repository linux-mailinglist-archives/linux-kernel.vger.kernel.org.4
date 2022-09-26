Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B035EABFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiIZQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiIZQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:03:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE41261B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:52:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id go6so6535837pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=XqslfmbW07ju9IFhgHQRoaxnh119HB9GroIqSODrifE=;
        b=R65VQeSNaeE0CR46yxIyKozGRffTNT9NvActVqL+W122uFMn/u0sS/Oq2m+NeQ7cRQ
         BoWvzm5oYiKlbnMHm2dnAV+3RNcY4JyDoBM++1PfCCA8bltRVdm4B0vtWXYWyXxsdlTX
         lupND7PqhU3qPCkgqUH6yv+ncilEkFhgr3/isz8JhdyFumeKDfRIPdU6Y4aRjIFkMRxO
         HOxZWS5TTPOA6lwb+d/FpfD3Ew2lgqm+GYGiiK3db5FwJYWenkwWWeSUgRbXJKyHYmxj
         t7ulmLy0rFLbpFMxvUJ3RwFqOswChA+TPdmSm27sd5aM1rOlmmUaiMtws4vbRniMi5Av
         nJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=XqslfmbW07ju9IFhgHQRoaxnh119HB9GroIqSODrifE=;
        b=oeXKl46UlB3+IOqYBo5P6ucCvPOznlkFylsekx+m1uuC7zI4cNMQduReCVtNqtkOfB
         wbCvXcc36BqEAkqbDhitIyaEOUS0uYVrOt5TFofdixq5jnFVG4JzXh0/GdO9lwqmnWbI
         lc4OJTWWRyfCA7nvWN0ByT2ZCVt0dlU4dd21meF1Kgiv1YkyZx22mwHfR2Qv1uYQjsot
         6TGYwUCSuXYonrw96qSdNxgv5mB6gMN45brUVjd0EeiVBnNmVbO48T6O0vtfWdnTNyLK
         S5YhnrM7ZpHg1woQ7k7kAwinSr/ugUfQtikYCe5x1anl7eE/pFhjlwOq0Sib5dJFnCHF
         OUzg==
X-Gm-Message-State: ACrzQf3GC04qqHOO+fkDHA3NMh46uDkFDySHxCxy5EfbIrgtwi4F4bEl
        RAKCwGAXj2M8TvaYK4QlnJs=
X-Google-Smtp-Source: AMsMyM4ub4gfuQcnvKuWIFAZSMIE6mm0hvcAR6kHiRsk2FgaosM/ZyMENPKmotKiaR+PgbB6VpS5uQ==
X-Received: by 2002:a17:902:8c81:b0:178:1701:cd with SMTP id t1-20020a1709028c8100b00178170100cdmr22755171plo.138.1664203949831;
        Mon, 26 Sep 2022 07:52:29 -0700 (PDT)
Received: from [0.0.0.0] ([2a11:3:200::30d3])
        by smtp.gmail.com with ESMTPSA id 141-20020a621493000000b0053dfef91b0bsm12160710pfu.205.2022.09.26.07.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:52:29 -0700 (PDT)
Message-ID: <df8ca380-8eb8-5f5e-9f0b-32029ad077b1@gmail.com>
Date:   Mon, 26 Sep 2022 22:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RESEND PATCH v7 0/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
To:     peterz@infradead.org
Cc:     gautham.shenoy@amd.com, vincent.guittot@linaro.org,
        tim.c.chen@linux.intel.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        juri.lelli@redhat.com, mingo@redhat.com, guodong.xu@linaro.org,
        hesham.almatary@huawei.com, john.garry@huawei.com,
        shenyang39@huawei.com, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        wuyun.abel@bytedance.com, Yicong Yang <yangyicong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220915073423.25535-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20220915073423.25535-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Does it still have a chance for 6.1?

It should be stable for now since I got no new comment for this whole review cycle and
it can still be applied cleanly on tip/sched/core.

However appreciation for any comment if there're!

Thanks.

On 9/15/2022 3:34 PM, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This is the follow-up work to support cluster scheduler. Previously
> we have added cluster level in the scheduler for both ARM64[1] and
> X86[2] to support load balance between clusters to bring more memory
> bandwidth and decrease cache contention. This patchset, on the other
> hand, takes care of wake-up path by giving CPUs within the same cluster
> a try before scanning the whole LLC to benefit those tasks communicating
> with each other.
> 
> [1] 778c558f49a2 ("sched: Add cluster scheduler level in core and related Kconfig for ARM64")
> [2] 66558b730f25 ("sched: Add cluster scheduler level for x86")
> 
> Change for RESEND:
> - Collect tag from Chen Yu and rebase on the latest tip/sched/core. Thanks.
> Link: https://lore.kernel.org/lkml/20220822073610.27205-1-yangyicong@huawei.com/
> 
> Change since v6:
> - rebase on 6.0-rc1
> Link: https://lore.kernel.org/lkml/20220726074758.46686-1-yangyicong@huawei.com/
> 
> Change since v5:
> - Improve patch 2 according to Peter's suggestion:
>   - use sched_cluster_active to indicate whether cluster is active
>   - consider SMT case and use wrap iteration when scanning cluster
> - Add Vincent's tag
> Thanks.
> Link: https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/
> 
> Change since v4:
> - rename cpus_share_resources to cpus_share_lowest_cache to be more informative, per Tim
> - return -1 when nr==0 in scan_cluster(), per Abel
> Thanks!
> Link: https://lore.kernel.org/lkml/20220609120622.47724-1-yangyicong@hisilicon.com/
> 
> Change since v3:
> - fix compile error when !CONFIG_SCHED_CLUSTER, reported by lkp test.
> Link: https://lore.kernel.org/lkml/20220608095758.60504-1-yangyicong@hisilicon.com/
> 
> Change since v2:
> - leverage SIS_PROP to suspend redundant scanning when LLC is overloaded
> - remove the ping-pong suppression
> - address the comment from Tim, thanks.
> Link: https://lore.kernel.org/lkml/20220126080947.4529-1-yangyicong@hisilicon.com/
> 
> Change since v1:
> - regain the performance data based on v5.17-rc1
> - rename cpus_share_cluster to cpus_share_resources per Vincent and Gautham, thanks!
> Link: https://lore.kernel.org/lkml/20211215041149.73171-1-yangyicong@hisilicon.com/
> 
> Barry Song (2):
>   sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
>   sched/fair: Scan cluster before scanning LLC in wake-up path
> 
>  include/linux/sched/sd_flags.h |  7 +++++++
>  include/linux/sched/topology.h |  8 +++++++-
>  kernel/sched/core.c            | 12 ++++++++++++
>  kernel/sched/fair.c            | 30 +++++++++++++++++++++++++++---
>  kernel/sched/sched.h           |  3 +++
>  kernel/sched/topology.c        | 25 +++++++++++++++++++++++++
>  6 files changed, 81 insertions(+), 4 deletions(-)
> 
