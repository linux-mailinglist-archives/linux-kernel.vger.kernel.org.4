Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B3639EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiK1BPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiK1BPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:15:30 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D4BC30
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 17:15:26 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NL6rM5HmWzJnx4;
        Mon, 28 Nov 2022 09:12:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 09:15:24 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 09:15:24 +0800
Subject: Re: [PATCH] kernfs: fix potential null-ptr-deref in
 kernfs_path_from_node_locked()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tejun Heo <tj@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221123020419.1867-1-thunder.leizhen@huawei.com>
 <Y35Qgw4Q8XYD5Did@slm.duckdns.org>
 <ba083b44-93d5-37c4-380c-8e0249b2333c@huawei.com>
 <ba46adff-3604-9ccf-b1c5-83411f6652d9@huawei.com>
 <55041efe-7443-d576-287b-49d1221fced2@huawei.com>
 <164f759d-23b8-0a68-e68e-2f0a46318e94@huawei.com>
 <Y4HpqJUINYTDLTrr@kroah.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1902f7d9-2dcf-acf4-44d6-8c26ff48ea6d@huawei.com>
Date:   Mon, 28 Nov 2022 09:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y4HpqJUINYTDLTrr@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/26 18:25, Greg Kroah-Hartman wrote:
> On Sat, Nov 26, 2022 at 05:49:50PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/11/24 10:52, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2022/11/24 10:28, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2022/11/24 10:24, Leizhen (ThunderTown) wrote:
>>>>>
>>>>>
>>>>> On 2022/11/24 0:55, Tejun Heo wrote:
>>>>>> On Wed, Nov 23, 2022 at 10:04:19AM +0800, Zhen Lei wrote:
>>>>>>> Ensure that the 'buf' is not empty before strlcpy() uses it.
>>>>>>>
>>>>>>> Commit bbe70e4e4211 ("fs: kernfs: Fix possible null-pointer dereferences
>>>>>>> in kernfs_path_from_node_locked()") first noticed this, but it didn't
>>>>>>> fix it completely.
>>>>>>>
>>>>>>> Fixes: 9f6df573a404 ("kernfs: Add API to generate relative kernfs path")
>>>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>>>
>>>>>> I think the right thing to do is removing that if. It makes no sense to call
>>>>>> that function with NULL buf and the fact that nobody reported crashes on
>>>>>> NULL buf indicates that we in fact never do.
>>
>> kernfs_path_from_node
>>     -->kernfs_path_from_node_locked
>>
>> EXPORT_SYMBOL_GPL(kernfs_path_from_node)
>>
>> I've rethought it. The export APIs need to do null pointer check, right?
> 
> No, callers should get this right.  Are there any in-tree ones that do
> not?

Thanks. I got it.

> 
> thanks,
> 
> greg k-h
> .
> 

-- 
Regards,
  Zhen Lei
