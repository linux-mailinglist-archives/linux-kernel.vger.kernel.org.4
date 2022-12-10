Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4D648CF1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLJDiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLJDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:37:59 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE77201A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 19:37:57 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NTYR15Qp3zJpF9;
        Sat, 10 Dec 2022 11:34:21 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 11:37:55 +0800
Message-ID: <de11c5f6-25e2-5f96-000a-0ba4d2047949@huawei.com>
Date:   Sat, 10 Dec 2022 11:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, Tong Tiangen <tongtiangen@huawei.com>
References: <20221209021525.196276-1-wangkefeng.wang@huawei.com>
 <20221209072801.193221-1-wangkefeng.wang@huawei.com>
 <20221209165015.7de5f7173c534c10875e10fb@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221209165015.7de5f7173c534c10875e10fb@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/10 8:50, Andrew Morton wrote:
> On Fri, 9 Dec 2022 15:28:01 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> When the kernel copy a page from ksm_might_need_to_copy(), but runs
>> into an uncorrectable error, it will crash since poisoned page is
>> consumed by kernel, this is similar to Copy-on-write poison recovery,
>> When an error is detected during the page copy, return VM_FAULT_HWPOISON,
>> which help us to avoid system crash. Note, memory failure on a KSM
>> page will be skipped, but still call memory_failure_queue() to be
>> consistent with general memory failure process.
> Thanks.  Sorry, lots of paperwork and bureaucracy:
>
>
> Is a copy of the oops(?) output available?
>
> Did someone else report this?  If so, is a Reported-by available for
> that?  And a Link: for the Reported-by:, which is a coming thing.
>
> Can we identify a Fixes: target?
>
> Is a cc:stable appropriate?
We are trying to support ARCH_HAS_COPY_MC on arm64[1] and trying to 
recover from CoW faults[2],
also tony do the same thing(recover from CoW) on X86[3]. The kernel copy 
in ksm_might_need_to_copy()
could recover, this is an enhance of COPY_MC, so I think no need to add 
Fixes and stable.

Thanks.

[1] 
https://lore.kernel.org/linux-arm-kernel/20220812070557.1028499-1-tongtiangen@huawei.com/
[2] 
https://lore.kernel.org/linux-arm-kernel/20220812070557.1028499-5-tongtiangen@huawei.com/
[3] 
https://lore.kernel.org/lkml/20221031201029.102123-2-tony.luck@intel.com/


>
