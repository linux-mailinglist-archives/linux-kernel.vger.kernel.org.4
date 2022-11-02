Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27C616018
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiKBJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiKBJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:41:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5042182D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:41:33 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2MMr6RXhzHvTp;
        Wed,  2 Nov 2022 17:41:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:41:31 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:41:31 +0800
Subject: Re: [PATCH] locking/refcount: Use REFCOUNT_WARN() to simplify code
To:     Will Deacon <will@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220316125114.1177-1-thunder.leizhen@huawei.com>
 <20220404093103.GA22875@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <649a91cf-5a43-e9b6-7071-03fc3fd3039a@huawei.com>
Date:   Wed, 2 Nov 2022 17:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220404093103.GA22875@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/4 17:31, Will Deacon wrote:
> On Wed, Mar 16, 2022 at 08:51:14PM +0800, Zhen Lei wrote:
>> To avoid the check "new > val" appears twice, and make the style
>> consistent with that in refcount_warn_saturate().
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  lib/refcount.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/refcount.c b/lib/refcount.c
>> index a207a8f22b3ca35..d36aa3fa728f53b 100644
>> --- a/lib/refcount.c
>> +++ b/lib/refcount.c
>> @@ -84,7 +84,7 @@ bool refcount_dec_not_one(refcount_t *r)
>>  
>>  		new = val - 1;
>>  		if (new > val) {
>> -			WARN_ONCE(new > val, "refcount_t: underflow; use-after-free.\n");
>> +			REFCOUNT_WARN("underflow; use-after-free");
>>  			return true;
>>  		}
> 
> Acked-by: Will Deacon <will@kernel.org>

Can anyone pick up this patch? It seems to have been forgotten.

> 
> Will
> .
> 

-- 
Regards,
  Zhen Lei
