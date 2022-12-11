Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F066491C6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLKCOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKCOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:14:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F912AB7;
        Sat, 10 Dec 2022 18:14:50 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NV7Xf0wWqzJnsN;
        Sun, 11 Dec 2022 10:11:14 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 11 Dec 2022 10:14:48 +0800
Message-ID: <d2dd457e-ee9a-bdee-1efc-fe358d8f49a9@huawei.com>
Date:   Sun, 11 Dec 2022 10:14:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] of: overlay: fix null pointer dereferencing in
 find_dup_cset_node_entry() and find_dup_cset_prop()
To:     Rob Herring <robh@kernel.org>
CC:     <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221206083657.3202856-1-ruanjinjie@huawei.com>
 <20221209205900.GA3808024-robh@kernel.org>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20221209205900.GA3808024-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/10 4:59, Rob Herring wrote:
> On Tue, Dec 06, 2022 at 04:36:57PM +0800, ruanjinjie wrote:
>> when kmalloc() fail to allocate memory in kasprintf(), fn_1 or fn_2 will
>> be NULL, strcmp() will cause null pointer dereference.
>>
>> Fixes: 2fe0e8769df9 ("of: overlay: check prevents multiple fragments touching same property")
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/of/overlay.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index bd8ff4df723d..49c066b51148 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -545,6 +545,11 @@ static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
>>  
>>  		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>>  		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> +		if (!fn_1 || !fn_2) {
>> +			kfree(fn_1);
>> +			kfree(fn_2);
>> +			return -ENOMEM;
>> +		}
>>  		node_path_match = !strcmp(fn_1, fn_2);
> 
> We don't actually care what the return code is, so just change this to:
> 
> node_path_match = !fn_1 || !fn_2 || !strcmp(fn_1, fn_2);
Thank you very much!I'll give the v2 patch soon.
> 
>>  		kfree(fn_1);
>>  		kfree(fn_2);
>> @@ -580,6 +585,11 @@ static int find_dup_cset_prop(struct overlay_changeset *ovcs,
>>  
>>  		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
>>  		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
>> +		if (!fn_1 || !fn_2) {
>> +			kfree(fn_1);
>> +			kfree(fn_2);
>> +			return -ENOMEM;
>> +		}
>>  		node_path_match = !strcmp(fn_1, fn_2);
>>  		kfree(fn_1);
>>  		kfree(fn_2);
>> -- 
>> 2.25.1
>>
>>
> 
