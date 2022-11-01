Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF86149E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKALvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiKALuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:50:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B71B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 04:48:10 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1p8h5wdvzpVTF;
        Tue,  1 Nov 2022 19:44:36 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 19:48:08 +0800
Subject: Re: [PATCH] x86/cpu: fix undefined behavior in bit shift for
 intel_detect_tlb
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <tony.luck@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <pbonzini@redhat.com>, <chenyi.qiang@intel.com>,
        <jithu.joseph@intel.com>, <alexs@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221031114340.4185587-1-cuigaosheng1@huawei.com>
 <Y1/AAegYuyZPxH04@hirez.programming.kicks-ass.net>
 <Y1/AaJOcgIc/INtv@hirez.programming.kicks-ass.net>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <bdb64d3b-bfe2-6505-c24a-770675b697bb@huawei.com>
Date:   Tue, 1 Nov 2022 19:48:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <Y1/AaJOcgIc/INtv@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

We don't need to add UBSAN calltrace, so I have merged the patch with another
patch("x86/cpu: replacing the open-coded shift with BIT(x)"), please ignore
this patch,thanks for review this patch!

On 2022/10/31 20:32, Peter Zijlstra wrote:
> On Mon, Oct 31, 2022 at 01:30:57PM +0100, Peter Zijlstra wrote:
>> On Mon, Oct 31, 2022 at 07:43:40PM +0800, Gaosheng Cui wrote:
>>> Shifting signed 32-bit value by 31 bits is undefined, so changing
>>> significant bit to unsigned. The UBSAN warning calltrace like below:
>>>
>>> UBSAN: shift-out-of-bounds in arch/x86/kernel/cpu/intel.c:948:21
>>> left shift of 1 by 31 places cannot be represented in type 'int'
>> Is it really? Shouldn't -fstrict-overflow define this case?
> -fno-strict-overflow that is, which implies -fwrapv which ensures 2s
> complement, at which point shifting signed numbers is fully defined.
>
> .
