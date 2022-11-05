Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6961A6B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKEBjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEBjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:39:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A69631C;
        Fri,  4 Nov 2022 18:39:12 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N40XD0rP1zRntL;
        Sat,  5 Nov 2022 09:39:08 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 09:39:10 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 09:39:10 +0800
Subject: Re: [PATCH 1/3] crypto: hisilicon/qm - modify the process of regs dfx
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20221029094801.43843-1-yekai13@huawei.com>
 <20221029094801.43843-2-yekai13@huawei.com>
 <Y2TV6Cz7XPYj4SZO@gondor.apana.org.au>
 <851c1b30-ee30-145b-c77c-17166cd6e426@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <63b64287-b402-c4c9-c977-e8d76dcbe686@huawei.com>
Date:   Sat, 5 Nov 2022 09:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <851c1b30-ee30-145b-c77c-17166cd6e426@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/4 18:07, yekai (A) wrote:
>
> On 2022/11/4 17:05, Herbert Xu wrote:
>> On Sat, Oct 29, 2022 at 09:47:59AM +0000, Kai Ye wrote:
>>> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
>>> index 363a02810a16..832cfd9a7728 100644
>>> --- a/drivers/crypto/hisilicon/qm.c
>>> +++ b/drivers/crypto/hisilicon/qm.c
>>> @@ -1722,8 +1722,22 @@ static int qm_regs_show(struct seq_file *s, void *unused)
>>>  
>>>  DEFINE_SHOW_ATTRIBUTE(qm_regs);
>>>  
>>> +static void dfx_regs_uninit(struct hisi_qm *qm,
>>> +		struct dfx_diff_registers *dregs, int reg_len)
>>> +{
>>> +	int i;
>>> +
>>> +	/* Setting the pointer is NULL to prevent double free */
>>> +	for (i = 0; i < reg_len; i++) {
>>> +		kfree(dregs[i].regs);
>>> +		dregs[i].regs = NULL;
>>> +	}
>>> +	kfree(dregs);
>>> +	dregs = NULL;
>> What's the point of this last NULL assignment?
>>
>> Cheers,
> To prevent pointer reuse and reduce register data security risks. So the original code setting the pointer is NULL.
>  
> Thanks
> Kai
I misunderstood the pointer. There is no security data in the pointer. It is only a value transferred as a structure.
This patch-set does not modify the logic. Can i add an extra patch to delete this redundant line next version?

Thanks
Kai

