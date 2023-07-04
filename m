Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D174681B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGDDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGDDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:51:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A771B6;
        Mon,  3 Jul 2023 20:51:12 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qw82s464lz1HCqB;
        Tue,  4 Jul 2023 11:50:45 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 11:51:09 +0800
Message-ID: <f6764156-ec85-ad0a-f0b7-030f24f4dee4@huawei.com>
Date:   Tue, 4 Jul 2023 11:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v5 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230511085139.1039088-1-chenjiahao16@huawei.com>
 <20230511085139.1039088-2-chenjiahao16@huawei.com>
 <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
 <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
 <5c80666c-e6e2-8fa6-50b6-89536315925e@huawei.com>
 <ZKD3tEBknEiF4PZK@MiWiFi-R3L-srv>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZKD3tEBknEiF4PZK@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/2 12:06, Baoquan He wrote:
> On 07/01/23 at 05:51pm, chenjiahao (C) wrote:
> ......
>> I have sent v6 patches, implementing the logic above. That fixes the
>> retrying
>>
>> logic and should be aligned with Arm64 code.
> Hmm, it has improved much, while there's still issue which need be
> fixed. You missed the case that crsahkernel low is specified as zero
> explicitly. Obviously your v6 is not able to handle that well. Means
> your v6 is not aligned with the current arm64 code completely.
>
> crashkernel=xM,high crashkernel=0M,low
>
>>
>> Please let me know if there is any problem remains.
> Earlier, I posted below RFC patchset to try to unify the
> crashkernel=,high support on x86, arm64 and risc-v, the generic arch.
> Wondering what you think about it. risc-v can be added in with very few
> change to get the crahskernel=,high support.
>
> [RFC PATCH 0/4] kdump: add generic functions to simplify crashkernel crashkernel in architecture
>
> Surely, the crashkernel=,high support can be added independently in
> advance. Later my patchset can unify them and remove the duplicated code
> in risc-v. It's up to you and risc-v maintainers/reivewers to take one.
> Anyway, I will add comment to your v6 to point out the issue.

It would be great if crashkernel parsing and reserving logic could be
unified on multiple architectures, the code would be more straightforward
and easy to use. I will have a more in-depth review of your RFC patchset
later.

Meanwhile, I will continue to update my patchset on risc-v, just wishing
to complement this feature earlier. When your unify solution get applied,
simply remove the duplicate part is OK. Before that, I will update my
risc-v code and further align with the Arm64 logic.

Thanks for your carefully review, I will fix the issue above and send
v7 patchset soon.

Thanks,
Jiahao

>
> Thanks
> Baoquan
>
