Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0163653B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiKWQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiKWQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:03:51 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104B5E3EA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:03:50 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHQn54Mp3zqSV2;
        Wed, 23 Nov 2022 23:59:53 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 00:03:49 +0800
Subject: Re: [PATCH 0/2] x86/xen: Fix memory leak issue
To:     Juergen Gross <jgross@suse.com>, <boris.ostrovsky@oracle.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <jeremy@goop.org>
CC:     <x86@kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
References: <20221119085923.114889-1-xiujianfeng@huawei.com>
 <33b9d446-9907-ded6-114e-ce6c43cc3446@suse.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <22003e76-0aae-e699-f231-85f8313e4a36@huawei.com>
Date:   Thu, 24 Nov 2022 00:03:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <33b9d446-9907-ded6-114e-ce6c43cc3446@suse.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2022/11/23 23:23, Juergen Gross 写道:
> On 19.11.22 09:59, Xiu Jianfeng wrote:
>> The new string allocated by kasprintf() is leaked on error path
>>
>> Xiu Jianfeng (2):
>>    x86/xen: Fix memory leak in xen_smp_intr_init{_pv}()
>>    x86/xen: Fix memory leak in xen_init_lock_cpu()
>>
>>   arch/x86/xen/smp.c      | 16 ++++++++++++----
>>   arch/x86/xen/smp_pv.c   |  8 ++++++--
>>   arch/x86/xen/spinlock.c |  3 ++-
>>   3 files changed, 20 insertions(+), 7 deletions(-)
>>
> 
> Hmm, I think it would make more sense to always store the name generated
> via kasprintf() in the percpu variable (independently from succeeding to
> bind the irq), and in the related free function to always kfree() it and
> set it to NULL again.
> 
> This would result in less code.

Thanks, It's good to me, already sent v2.
> 
> 
> Juergen
