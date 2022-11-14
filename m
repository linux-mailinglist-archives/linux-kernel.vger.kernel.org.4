Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58868627BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiKNLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiKNLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:15:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4E6174
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:11:21 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9mnz1YN8zRpK3;
        Mon, 14 Nov 2022 19:11:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:11:19 +0800
Message-ID: <c7bc7aa8-8753-e099-f8f2-8624feac6870@huawei.com>
Date:   Mon, 14 Nov 2022 19:11:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] xen: add missing free_irq() in error path
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
CC:     "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221114070702.1887144-1-ruanjinjie@huawei.com>
 <4b735f01-6028-d7dc-d715-8c56c790a8ad@epam.com>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <4b735f01-6028-d7dc-d715-8c56c790a8ad@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/14 18:45, Oleksandr Tyshchenko wrote:
> 
> On 14.11.22 09:07, ruanjinjie wrote:
> 
> Hello
> 
> 
>> free_irq() is missing in case of error, fix that.
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> 
> 
> Nit: neither subject nor description mentions which subsystem current 
> patch targets.
> 
> I would add "xen-platform:" or "xen/platform-pci:" at least.
> 
Thank you very much!
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Thanks.
> 
>> ---
>>   drivers/xen/platform-pci.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
>> index 18f0ed8b1f93..6ebd819338ec 100644
>> --- a/drivers/xen/platform-pci.c
>> +++ b/drivers/xen/platform-pci.c
>> @@ -144,7 +144,7 @@ static int platform_pci_probe(struct pci_dev *pdev,
>>   		if (ret) {
>>   			dev_warn(&pdev->dev, "Unable to set the evtchn callback "
>>   					 "err=%d\n", ret);
>> -			goto out;
>> +			goto irq_out;
>>   		}
>>   	}
>>   
>> @@ -152,13 +152,16 @@ static int platform_pci_probe(struct pci_dev *pdev,
>>   	grant_frames = alloc_xen_mmio(PAGE_SIZE * max_nr_gframes);
>>   	ret = gnttab_setup_auto_xlat_frames(grant_frames);
>>   	if (ret)
>> -		goto out;
>> +		goto irq_out;
>>   	ret = gnttab_init();
>>   	if (ret)
>>   		goto grant_out;
>>   	return 0;
>>   grant_out:
>>   	gnttab_free_auto_xlat_frames();
>> +irq_out:
>> +	if (!xen_have_vector_callback)
>> +		free_irq(pdev->irq, pdev);
>>   out:
>>   	pci_release_region(pdev, 0);
>>   mem_out:
> 
