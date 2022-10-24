Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC160A189
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJXL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJXL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:27:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D925AC77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:27:22 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mwt2s60GlzmVKK;
        Mon, 24 Oct 2022 19:22:29 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 19:27:20 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 19:27:19 +0800
Message-ID: <e5d65c14-b1a3-7f30-e8db-9e292f576f45@huawei.com>
Date:   Mon, 24 Oct 2022 19:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] init/main: Use strtobool for param parsing in
 set_debug_rodata()
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <ardb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
References: <20221024093817.3003291-1-tongtiangen@huawei.com>
 <Y1ZwaYLckR8/IDh5@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Y1ZwaYLckR8/IDh5@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/24 19:00, Mark Rutland 写道:
> On Mon, Oct 24, 2022 at 09:38:17AM +0000, Tong Tiangen wrote:
>> Aftern parsing "full", we can still use strtobool rather than "on" and
>> "off" parsing in set_debug_rodata().
>>
>> Fixes: 2e8cff0a0eee ("arm64: fix rodata=full")
> 
> Why do you think this is a fix; what do you believe is broken?
> 
> As noted in the commit message for 2e8cff0a0eee, we *deliberately* don't use
> strtobool() here so that we don't accept garbage values like "ful".
> 
> NAK to this patch as it stands.
> 
> Thanks,
> Mark.

Hi Mark:

Ok, missing that.

Thanks,
Tong.

> 
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   init/main.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index aa21add5f7c5..f420e20b1fa3 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1463,13 +1463,7 @@ static int __init set_debug_rodata(char *str)
>>   	if (arch_parse_debug_rodata(str))
>>   		return 0;
>>   
>> -	if (str && !strcmp(str, "on"))
>> -		rodata_enabled = true;
>> -	else if (str && !strcmp(str, "off"))
>> -		rodata_enabled = false;
>> -	else
>> -		pr_warn("Invalid option string for rodata: '%s'\n", str);
>> -	return 0;
>> +	return strtobool(str, &rodata_enabled);
>>   }
>>   early_param("rodata", set_debug_rodata);
>>   #endif
>> -- 
>> 2.25.1
>>
> 
> .
