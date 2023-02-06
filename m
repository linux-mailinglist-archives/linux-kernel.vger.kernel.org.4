Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE368B374
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBFAwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFAwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:52:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FCB126ED
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 16:52:13 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P972d2VW3znVxp;
        Mon,  6 Feb 2023 08:50:01 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 08:52:09 +0800
Message-ID: <de4149c7-0e6e-2035-3fb8-2f9da9633704@huawei.com>
Date:   Mon, 6 Feb 2023 08:52:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
CC:     <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kuleshovmail@gmail.com>,
        <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 0/4] Add overflow checks for several syscalls
Content-Language: en-US
To:     <david@redhat.com>, <akpm@linux-foundation.org>
References: <20230128063229.989058-1-mawupeng1@huawei.com>
 <0b193743-b3ad-6e05-f6bb-ae5653fd5ef0@redhat.com>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <0b193743-b3ad-6e05-f6bb-ae5653fd5ef0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/4 1:10, David Hildenbrand wrote:
> On 28.01.23 07:32, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> While testing mlock, we have a problem if the len of mlock is ULONG_MAX.
>> The return value of mlock is zero. But nothing will be locked since the
>> len in do_mlock overflows to zero due to the following code in mlock:
>>
>>    len = PAGE_ALIGN(len + (offset_in_page(start)));
>>
>> The same problem happens in munlock.
>>
>> Add new check and return -EINVAL to fix this overflowing scenarios since
>> they are absolutely wrong.
>>
>> Similar logic is used to fix problems with multiple syscalls.
>>
>> Changelog since v2[2]:
>> - modified the way of checking overflows based on Andrew's comments
>>
>> Changelog since v1[1]:
>> - only check overflow rather than access_ok to keep backward-compatibility
> 
> Do you have some test cases and could we add them to LTP, for example?

The basic idea is setting param len to ULONG_MAX. while will overflow if PAGE_ALIGN(len).

Here are some simple examples:

mlock(addr, ULONG_MAX);
set_mempolicy_home_node(addr, ULONG_MAX, 0, 0);
mbind(addr, ULONG_MAX, MPOL_BIND, &nodemask, max_node, MPOL_MF_MOVE_ALL);
msync(addr, ULONG_MAX, MS_ASYNC);

> 
