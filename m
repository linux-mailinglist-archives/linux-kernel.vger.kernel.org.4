Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C97173A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjEaCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjEaCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:19:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B071C113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:19:54 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QWCdV68m0zTkwp;
        Wed, 31 May 2023 10:19:42 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 10:19:52 +0800
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
To:     Baoquan He <bhe@redhat.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
 <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5beb1883-5391-1b75-d8cd-2152478b9e72@huawei.com>
Date:   Wed, 31 May 2023 10:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/31 8:17, Baoquan He wrote:
> On 05/27/23 at 08:34pm, Zhen Lei wrote:
>> The check '(crashk_res.parent != NULL)' is added by
>> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
>> stale now. Because if 'crashk_res' is not reserved, it will be zero in
>> size and will be intercepted by the above 'if (new_size >= old_size)'.
>>
>> Ago:
>> 	if (new_size >= end - start + 1)
>>
>> Now:
>> 	old_size = (end == 0) ? 0 : end - start + 1;
>> 	if (new_size >= old_size)
> 
> Hmm, I would strongly suggest we keep that check. Even though the
> current code like above can do the acutal checking, but its actual usage
> is not obvious for checking of crashk_res existence. In the future,
> someone may change above calculation and don't notice the hidden
> functionality at all behind the calculation. The cost of the check is
> almost zero, right?

The cost of the check is negligible. The only downside is that it's hard to
understand why it's added, and I only found out why by looking at the history
log. In my opinion, the above 'Now:' is the right fix.

> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kexec_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 22acee18195a591..d1ab139dd49035e 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
>>  	end = start + new_size;
>>  	crash_free_reserved_phys_range(end, crashk_res.end);
>>  
>> -	if ((start == end) && (crashk_res.parent != NULL))
>> +	if (start == end)
>>  		release_resource(&crashk_res);
>>  
>>  	ram_res->start = end;
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
