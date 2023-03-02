Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24196A7A24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCBDrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:47:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77D3E087
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:47:19 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRxn06YC7zfbPJ;
        Thu,  2 Mar 2023 11:44:36 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 11:47:16 +0800
Message-ID: <95fcd42c-cb41-d280-32a4-97708061fe41@huawei.com>
Date:   Thu, 2 Mar 2023 11:47:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
CC:     <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <bp@suse.de>, <toshi.kani@hp.com>,
        <suresh.b.siddha@intel.com>,
        <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH 1/1] x86/mm/pat: Clear VM_PAT if copy_p4d_range failed
Content-Language: en-US
To:     <dave.hansen@intel.com>, <akpm@linux-foundation.org>,
        <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
References: <20230217025615.1595558-1-mawupeng1@huawei.com>
 <7016f30f-65dd-b1a1-a44a-fb7af689959b@intel.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <7016f30f-65dd-b1a1-a44a-fb7af689959b@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/23 4:03, Dave Hansen wrote:
> On 2/16/23 18:56, Wupeng Ma wrote:
>> dup_mm
>>   dup_mmap
>>     copy_page_range
>>       copy_p4d_range
>>         copy_pud_range
>>           copy_pmd_range
>>             pmd_alloc
>>               __pmd_alloc
>>                 pmd_alloc_one
>>                   page = alloc_pages(gfp, 0);
>>                     if (!page)
>>                       return NULL;
>>     mmput
>>         exit_mmap
>>           unmap_vmas
>>             unmap_single_vma
>>               untrack_pfn
>>                 follow_phys
>>                   WARN_ON_ONCE(1);
> 
> What's the point of that warning in the first place?  I can certainly
> imagine follow_phys() failing for sparse mappings, for instance.  Is
> there some requirement that VM_PFNMAP can't be sparse?

Hi Dave

Thanks for reviewing.

Sorry，I have no idea why warning in the first place.

I think we can delete this WARN_ON_ONCE with another patch?
