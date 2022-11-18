Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048262F4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiKRM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiKRM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:27:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEA99E9F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:27:03 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDGHM0ZNSzRp9g;
        Fri, 18 Nov 2022 20:26:39 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 20:27:01 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 20:27:01 +0800
Subject: Re: [PATCH] locking/lockdep: fix null-ptr-deref in check_prev_add()
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
        <bvanassche@acm.org>
References: <20221118083102.4011977-1-yangyingliang@huawei.com>
 <Y3dbsSUwIp8yfT3l@hirez.programming.kicks-ass.net>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <9894a9e3-3e75-f33e-ff81-4233a77d7439@huawei.com>
Date:   Fri, 18 Nov 2022 20:27:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y3dbsSUwIp8yfT3l@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/18 18:17, Peter Zijlstra wrote:
> On Fri, Nov 18, 2022 at 04:31:02PM +0800, Yang Yingliang wrote:
>> I got a null-ptr-deref report as following:
>>
>> general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
>> KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
>> CPU: 0 PID: 500 Comm: systemd-udevd Tainted: G        W          6.1.0-rc5-00144-gabd8ea84ca72-dirty #1320
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:check_prevs_add+0x2f8/0x2780
>> Call Trace:
>>   <TASK>
>>   __lock_acquire+0x2ae8/0x3d60
>>   lock_acquire+0x195/0x4e0
>>   fs_reclaim_acquire+0x119/0x160
>>   kmem_cache_alloc_node+0x47/0x310
>>   __alloc_skb+0x205/0x2d0
>>   devlink_compat_running_version+0x10b/0x6a0
>>   dev_ethtool+0x285/0x380
>>   dev_ioctl+0x16c/0xff0
>>   sock_do_ioctl+0x1ae/0x220
>>   sock_ioctl+0x55f/0x600
>>   __x64_sys_ioctl+0x156/0x1d0
>>   do_syscall_64+0x37/0x90
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> If in use bit of lock_class is not set, hlock_class() returns NULL,
> Why is that a valid premise?
>
> That is; you think it is OK for a held_lock to not have an in-use
> lock_class?
It's not OK, before this crash, there is a WARN_ON in hlock_class().
But I think it shouldn't make system crash, so I add this check.
>
> I'm thinking there's more to this problem you found.
I will debug more to find out why in-use bit is not set.

Thanks,
Yang
>
>
> .
