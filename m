Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19F614920
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKALdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKALb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:31:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E21A827
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:30:00 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N1nqm6Nqzz15MCV;
        Tue,  1 Nov 2022 19:29:56 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:29:58 +0800
Subject: Re: [PATCH] x86/cpu: replacing the open-coded shift with BIT(x)
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <puwen@hygon.cn>, <TonyWWang-oc@zhaoxin.com>, <Jason@zx2c4.com>,
        <hca@linux.ibm.com>, <mika.westerberg@linux.intel.com>,
        <mario.limonciello@amd.com>, <tony.luck@intel.com>,
        <andrew.cooper3@citrix.com>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <jithu.joseph@intel.com>,
        <chenyi.qiang@intel.com>, <rafael.j.wysocki@intel.com>,
        <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221101060945.722565-1-cuigaosheng1@huawei.com>
 <Y2DdQwVfU2jFjMRX@hirez.programming.kicks-ass.net>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <76e13f1a-6edc-b923-101c-e059005d180c@huawei.com>
Date:   Tue, 1 Nov 2022 19:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y2DdQwVfU2jFjMRX@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Same as to the other case; UBSAN is broken garbage, stop quoting it.

I have made patch v2 and submitted it, removed the UBSAN warning calltrace,
and merged the patch "x86/cpu: fix undefined behavior in bit shift for intel_detect_tlb"
with it. Thanks!

On 2022/11/1 16:48, Peter Zijlstra wrote:
> On Tue, Nov 01, 2022 at 02:09:45PM +0800, Gaosheng Cui wrote:
>> Replace the open-coded shift with BIT(x) for x86_power to make the
>> code a bit more self-documenting, and we will get a UBSAN issue in
>> arch/x86/kernel/cpu/proc.c, fix it.
>>
>> The UBSAN warning calltrace like below:
>>
>> UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/proc.c:138:25
>> left shift of 1 by 31 places cannot be represented in type 'int'
> Same as to the other case; UBSAN is broken garbage, stop quoting it.
>
> .
