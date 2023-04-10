Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30416DC581
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDJKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDJKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:04:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846183580;
        Mon, 10 Apr 2023 03:04:48 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pw4HZ2W4Pz17Rv2;
        Mon, 10 Apr 2023 18:01:14 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 18:02:41 +0800
Message-ID: <6cadc27d-57fc-d71e-8edb-63f26c494ea2@huawei.com>
Date:   Mon, 10 Apr 2023 18:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v3 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <ZDAG/Re2CbuMFXOg@kernel.org>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZDAG/Re2CbuMFXOg@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/7 20:05, Simon Horman wrote:
> On Fri, Apr 07, 2023 at 06:02:04AM +0800, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low". Besides, there are few rules need
>> to take notice:
>> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>>     is specified.
>> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>>     and there is enough memory to be allocated under 4G.
>> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>>     specified, a 128M low memory will be allocated automatically for
>>     swiotlb bounce buffer.
>> See Documentation/admin-guide/kernel-parameters.txt for more information.
>>
>> To verify loading the crashkernel, adapted kexec-tools is attached below:
>> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> Are you planning to submit the kexec-tools patches too?

Yes, but current adaptation is a little informal. I will submit them 
later after further tests.


BR,

Jiahao

