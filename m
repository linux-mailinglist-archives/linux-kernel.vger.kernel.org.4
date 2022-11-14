Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E526277BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiKNIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiKNIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:30:55 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053F1B78C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:30:52 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N9j8m61k3zqSS1;
        Mon, 14 Nov 2022 16:27:04 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:30:49 +0800
Received: from [10.67.109.54] (10.67.109.54) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 16:30:49 +0800
Subject: Re: [PATCH] mtd: lpddr2_nvm: i2c: mux: reg: Fix possible
 null-ptr-deref
To:     Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114020141.28138-1-tanghui20@huawei.com>
 <20221114090408.7ed0e7c1@xps-13>
CC:     <richard@nod.at>, <vigneshr@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>
From:   Hui Tang <tanghui20@huawei.com>
Message-ID: <61283ee9-5737-e707-d0c6-5d13ea80723d@huawei.com>
Date:   Mon, 14 Nov 2022 16:30:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221114090408.7ed0e7c1@xps-13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.54]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 16:04, Miquel Raynal wrote:
> Hi Hui,
>
> tanghui20@huawei.com wrote on Mon, 14 Nov 2022 10:01:41 +0800:
>
>> It will cause null-ptr-deref when resource_size(add_range) invoked,
>> if platform_get_resource() returns NULL.
>>
>> Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
>> Signed-off-by: Hui Tang <tanghui20@huawei.com>
>> ---
>>  drivers/mtd/lpddr/lpddr2_nvm.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
>> index 367e2d906de0..cf8e86eb4b2c 100644
>> --- a/drivers/mtd/lpddr/lpddr2_nvm.c
>> +++ b/drivers/mtd/lpddr/lpddr2_nvm.c
>> @@ -433,6 +433,8 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
>>
>>  	/* lpddr2_nvm address range */
>>  	add_range = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (IS_ERR(add_range))
>
> platform_get_resource() just returns NULL upon error.

Thanks

>
