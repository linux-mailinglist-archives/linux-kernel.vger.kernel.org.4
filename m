Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC8685CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjBABdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBABdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:33:40 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403B4F37F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:33:37 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P64Bs5ngfz16MYB;
        Wed,  1 Feb 2023 09:31:33 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 09:33:34 +0800
Message-ID: <e3dc7816-ad60-6ee6-e023-5f4932dec375@huawei.com>
Date:   Wed, 1 Feb 2023 09:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
 <20221213120523.141588-1-wangkefeng.wang@huawei.com>
 <20230131163204.2c511663bfece90d56121cc6@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230131163204.2c511663bfece90d56121cc6@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/1 8:32, Andrew Morton wrote:
> On Tue, 13 Dec 2022 20:05:23 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> When the kernel copy a page from ksm_might_need_to_copy(), but runs
>> into an uncorrectable error, it will crash since poisoned page is
>> consumed by kernel, this is similar to Copy-on-write poison recovery,
>> When an error is detected during the page copy, return VM_FAULT_HWPOISON
>> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
>> swapoff, which help us to avoid system crash. Note, memory failure on
>> a KSM page will be skipped, but still call memory_failure_queue() to
>> be consistent with general memory failure process.
> 
> I believe we're awaiting a v4 of this?

Sorry, forget this one.
> 
> Did we consider a -stable backport?  "kernel crash" sounds undesirable...

This one depends on Copy-on-write poison recovery patchset, and I check 
the commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on 
write faults") is not included into stable, and both of them are 
enhancement of COPY_MC feature, so it seems that we don't need to
backport to stable.

> 
> Can we identify a Fixes: target for this?

As it is a part of COPY_MC, I don't think it is need a Fixes tag.

I will resend a new one to address the comments of  HORIGUCHI NAOYA(堀口 
直也).

Thanks.
