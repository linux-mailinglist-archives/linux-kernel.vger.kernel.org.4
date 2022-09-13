Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F04B5B65D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIMCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIMCr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:47:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E653012
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:47:54 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRSWg4ZNgzHnvC;
        Tue, 13 Sep 2022 10:45:51 +0800 (CST)
Received: from [10.67.110.83] (10.67.110.83) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 13 Sep
 2022 10:47:52 +0800
Subject: Re: [PATCH v3 1/2] squashfs: add the mount parameter
 theads=<single|multi|percpu>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        <linux-kernel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <yi.zhang@huawei.com>,
        <wangbing6@huawei.com>, <zhongjubin@huawei.com>,
        <chenjianguo3@huawei.com>
References: <20220816010052.15764-1-nixiaoming@huawei.com>
 <20220902094855.22666-1-nixiaoming@huawei.com>
 <20220902094855.22666-2-nixiaoming@huawei.com>
 <46301691-6196-ca3b-7a20-099d7b87c2ec@squashfs.org.uk>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <2a9e294d-ffcc-906c-12e9-013e87ef7c4d@huawei.com>
Date:   Tue, 13 Sep 2022 10:47:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <46301691-6196-ca3b-7a20-099d7b87c2ec@squashfs.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 23:50, Phillip Lougher wrote:
> On 02/09/2022 10:48, Xiaoming Ni wrote:
>> Squashfs supports three decompression concurrency modes:
>>     Single-thread mode: concurrent reads are blocked and the memory 
>> overhead
>> is small.
>>     Multi-thread mode/percpu mode: reduces concurrent read blocking but
>> increases memory overhead.
>>
>> The corresponding schema must be fixed at compile time. During mounting,
>> the concurrent decompression mode cannot be adjusted based on file read
>> blocking.
>>
>> The mount parameter theads=<single|multi|percpu> is added to select
>> the concurrent decompression mode of a single SquashFS file system
>> image.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> Additional review comment ...
> 
> [SNIP]
> 
>> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
>> index 32565dafa7f3..fd4e70d45f3c 100644
>> --- a/fs/squashfs/super.c
>> +++ b/fs/squashfs/super.c
>> @@ -47,10 +47,12 @@ enum Opt_errors {
> 
> [SNIP]
> 
>> +#ifdef CONFIG_SQUASHFS_DECOMP_SINGLE
>> +    opts->thread_ops = &squashfs_decompressor_single; > +#elif 
>> CONFIG_SQUASHFS_DECOMP_MULTI
> 
> this should be
> 
> #elif defined CONFIG_SQUASHFS_DECOMP_MULTI
> 

Thanks for your comment, I'll fix it in the next patch version

>> +    opts->thread_ops = &squashfs_decompressor_multi;
>> +#elif CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
> 
> this should be
> 
> #elif defined CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU
> 

Thanks for your comment, I'll fix it in the next patch version

> Phillip
> 
>> +    opts->thread_ops = &squashfs_decompressor_percpu;
>> +#endif
>>       fc->fs_private = opts;
>>       fc->ops = &squashfs_context_ops;
>>       return 0;
> 
> 
> .

Thanks
Xiaoming Ni
