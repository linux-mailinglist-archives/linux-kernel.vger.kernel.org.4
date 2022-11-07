Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B961F103
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiKGKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiKGKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:46:39 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4F17E30;
        Mon,  7 Nov 2022 02:46:38 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5SZq1VCPz15MQ3;
        Mon,  7 Nov 2022 18:46:27 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:46:36 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 18:46:36 +0800
Subject: Re: [PATCH v2 1/4] crypto: hisilicon/qm - modify the process of regs
 dfx
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20221105095357.21199-1-yekai13@huawei.com>
 <20221105095357.21199-2-yekai13@huawei.com>
 <Y2Y4hWc+cUJ4VZgy@gondor.apana.org.au>
 <45cf9fba-fae6-8279-bfac-f70110df42dc@huawei.com>
 <Y2jGGuewePunGPtl@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <a8bc45c1-4fb1-b99a-fcac-adc9f14f400f@huawei.com>
Date:   Mon, 7 Nov 2022 18:46:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y2jGGuewePunGPtl@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2022/11/7 16:47, Herbert Xu wrote:
> On Mon, Nov 07, 2022 at 02:53:28PM +0800, yekai (A) wrote:
>>
>> On 2022/11/5 18:18, Herbert Xu wrote:
>>> On Sat, Nov 05, 2022 at 09:53:54AM +0000, Kai Ye wrote:
>>>> +static void dfx_regs_uninit(struct hisi_qm *qm,
>>>> +		struct dfx_diff_registers *dregs, int reg_len)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	/* Setting the pointer is NULL to prevent double free */
>>>> +	for (i = 0; i < reg_len; i++) {
>>>> +		kfree(dregs[i].regs);
>>>> +		dregs[i].regs = NULL;
>>>> +	}
>>>> +	kfree(dregs);
>>>> +	dregs = NULL;
>>>> +}
>>> The line that I complained about is still here.
>>>
>>> Cheers,
>> ok
> Just to be clear, it's the last line "dregs = NULL" that I was
> referring to.  It makes no sense to zero a variable that is on
> the stack.
>
> Cheers,

I got it. I will fix it and resend the patch set in the next version.

Thanks
Kai
