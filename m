Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C302712741
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbjEZNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbjEZNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:12:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341D119
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 06:12:42 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QSQHp3FSNzLnkw;
        Fri, 26 May 2023 21:09:42 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 21:12:39 +0800
Message-ID: <d180192a-afad-00dc-426f-3d8d249cdd89@huawei.com>
Date:   Fri, 26 May 2023 21:12:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <sudeep.holla@arm.com>, <rafael.j.wysocki@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anshuman.khandual@arm.com>,
        <wangkefeng.wang@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
References: <20230526121751.41060-1-lihuisong@huawei.com>
 <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/26 20:39, Ard Biesheuvel 写道:
> (cc Lorenzo)
>
> On Fri, 26 May 2023 at 14:20, Huisong Li <lihuisong@huawei.com> wrote:
>> The driver who calls the acpi_os_ioremap() cannot be compiled if the 'M'
>> is selected for the driver. The compiling log is as follows:
>> -->
>> MODPOST Module.symvers
>> ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undefined!
>> scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
>> make[1]: *** [Module.symvers] Error 1
>>
>> So this patch exports symbol for acpi_os_ioremap.
>>
> That driver does not exist in mainline.

We have an uploading driver [1] that may use it.

[1] 
https://patchwork.kernel.org/project/linux-soc/patch/20230522072211.8894-2-lihuisong@huawei.com/

>
> Why does it need to use acpi_os_ioremap() instead of the ordinary
> memremap/ioremap routines?
This driver needs to ioremap the shared memory space of a PCC subspace.
And @Sudeep suggested that we use this interface.
It is suitable here.
>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   arch/arm64/kernel/acpi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index dba8fcec7f33..ec0414caf3d1 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -354,6 +354,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>>          }
>>          return ioremap_prot(phys, size, pgprot_val(prot));
>>   }
>> +EXPORT_SYMBOL(acpi_os_ioremap);
>>
>>   /*
>>    * Claim Synchronous External Aborts as a firmware first notification.
>> --
>> 2.33.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
