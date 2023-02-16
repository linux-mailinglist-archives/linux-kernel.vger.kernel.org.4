Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB46992A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjBPLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjBPLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:03:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CF268F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:03:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jk14so1647770plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZesZ6O765cPopeyel8yKHxm28ifXaTYkteY+hv+F5nc=;
        b=qS79uQP9tK+tFDTR4rZ8X8fvvYzODLZ0MAjR1P8T9m5/aN9U666FR8fOvLZvU62KJb
         /Jfl9dje7cd9iRjTruRqe4QlKUAXLaDj1aUw/6QPtPzOXi7EKfYClzLoby+LSCZFiP/4
         BdpjKSekvIMkDkRfWhXX6Iu9Xz4RxfiMqEplcVKJzYe31xN6N9LR0HiP5gUT6LiN9sSf
         RZZGKWXR9Y3qvHMdxku6/0pdm0uvgHRyDKK0ANaNsWuiWR9zztzvMT8CRGuapbGOEhRE
         oGM08PJfHk1gUgYL+4CQ/zWP5nlZAsdkg1vyP3rCxI+t1JYrIyrmf9FO9kjIFXiAfkwM
         rcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZesZ6O765cPopeyel8yKHxm28ifXaTYkteY+hv+F5nc=;
        b=IRTaVwy0mBpbRIHMz8QoYMph+Kdtq7vB8OLh48Co4llNUtSFsvTtZy9o5DocZuTRj3
         w9Zc7/vPyKRxw1J8H8Mqb9aAAs56+nOkjvC66kpew/CAz0GTnF2bHrHZtIEZHQ6Uxhqg
         h1nqQmemGj6zFeD41aBxknpjwKbcVvyXD+lbVCW8HrWH4zw2Du60+cYFNv2vnjfq2YbO
         kohk8snRWhVQ5JUSB/nsLxbZEzZZ/TNjeCh1VCoRMT1aZtDPJINZIQuxMECmBWb4TIH0
         ezkHT+9618btIvURqGjDX02JTK14YlqNdg75PDsaDx2aLUD4gqnA71z4x7tXd+wS/Xt9
         J9ew==
X-Gm-Message-State: AO0yUKVzXaDbY41XwJKaLRXjWKVOtPDcmSsGaED025Pmi3f+AxAQrhH1
        cGtyqRanycsL7MWxHUL7EAM6yA==
X-Google-Smtp-Source: AK7set9k7mN5Id553IfFvspFJotRYHTYjINaH96bAFxRYOjdEylLggakRhZbMS+bcDU4VTQNFrKMXg==
X-Received: by 2002:a17:902:f68f:b0:19a:6b03:c375 with SMTP id l15-20020a170902f68f00b0019a6b03c375mr6909254plg.0.1676545386135;
        Thu, 16 Feb 2023 03:03:06 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b00198f1de408csm1018874plj.268.2023.02.16.03.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:03:05 -0800 (PST)
Message-ID: <65da1862-364b-9500-4be7-a463a12e6a7f@bytedance.com>
Date:   Thu, 16 Feb 2023 19:02:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
To:     Hillf Danton <hdanton@sina.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20230216084902.1486-1-hdanton@sina.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230216084902.1486-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/16 16:49, Hillf Danton 写道:
> On Thu, 16 Feb 2023 15:11:48 +0800 Peng Zhang <zhangpeng.00@bytedance.com>
>> There is softlockup under fio pressure test with smmu enabled:
>> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
> 
> What is your kernel version?
Rcu stall occurs in kernel version 5.4.
The test where the softlockup happened was not done by me, so I don't 
know the kernel version.
However, it is the same as the code logic of fq_flush_timeout in the 
mainline kernel.

>> This is because the timer callback fq_flush_timeout may run more than
>> 10ms, and timer may be processed continuously in the softirq so trigger
>> softlockup and rcu stall. We can use work to deal with fq_ring_free for
>> each cpu which may take long time, that to avoid triggering softlockup
>> and rcu stall.
>>
>> This patch is modified from the patch[1] of openEuler.
> 
> Because of a timer hog observed on your system with 128 CPUs for instance
> does it make any sense to ask Peter to apply the patch for his 2-CPU box?
What is 2-CPU box?
