Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414965CF8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjADJci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:32:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D81AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:32:32 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nn48z159LzRqpS;
        Wed,  4 Jan 2023 17:30:59 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 17:32:30 +0800
Message-ID: <e793813c-b2b9-0924-5310-aefb1ab52e48@huawei.com>
Date:   Wed, 4 Jan 2023 17:32:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   mawupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH 0/4] return EINVAL for illegal user memory range
To:     <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
References: <20221205034108.3365182-1-mawupeng1@huawei.com>
 <d13ea810-e9a8-2741-11ce-5e20f1ba0334@redhat.com>
Content-Language: en-US
In-Reply-To: <d13ea810-e9a8-2741-11ce-5e20f1ba0334@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/2 21:22, David Hildenbrand wrote:
> On 05.12.22 04:41, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>> The return value of mlock is zero. But nothing will be locked since the
>> len in do_mlock overflows to zero due to the following code in mlock:
>>
>>    len = PAGE_ALIGN(len + (offset_in_page(start)));
>>
>> However this problem appear in multiple syscalls.
>>
>> Since TASK_SIZE is the maximum user space address. The start or len of
>> mlock shouldn't be bigger than this. Function access_ok can be used to
>> check this issue, so return -EINVAL if bigger.
> 
> I assume this makes sure that what we document holds:
> 
> EINVAL (mlock(),  mlock2(),  and  munlock()) The result of the addition
>     addr+len was less than addr (e.g., the addition may have
>     resulted in an overflow).
> 
> So instead of adding access_ok() checks, wouldn't be the right think to do checking for overflows?

I agree with you. Do checking only for overflows do seems nice since we need to keep
backward-compatibility.

> 
> 
