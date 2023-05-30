Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8874A715D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjE3Lhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjE3Lho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:37:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39875116
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:37:37 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVr152WdyzsSZ2;
        Tue, 30 May 2023 19:35:21 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 19:37:34 +0800
Message-ID: <6708317e-07c9-5a89-55e5-46ca42f99f88@huawei.com>
Date:   Tue, 30 May 2023 19:37:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] arm64: acpi: Export symbol for acpi_os_ioremap
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <rafael.j.wysocki@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anshuman.khandual@arm.com>,
        <wangkefeng.wang@huawei.com>, <liuyonglong@huawei.com>
References: <20230526121751.41060-1-lihuisong@huawei.com>
 <CAMj1kXHgPbzgPm1Sq5hqqz7RX6sj2axze5F+fvMyfPY=d9=Hhw@mail.gmail.com>
 <d180192a-afad-00dc-426f-3d8d249cdd89@huawei.com>
 <CAMj1kXHk-HTmJzovMFiYStZeZiehS2n01rhGeyOYF_wCn0sHbg@mail.gmail.com>
 <20230530105843.ewgmwb3wyewqoqxo@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230530105843.ewgmwb3wyewqoqxo@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/30 18:58, Sudeep Holla 写道:
> On Mon, May 29, 2023 at 03:31:12PM +0200, Ard Biesheuvel wrote:
>> On Fri, 26 May 2023 at 15:12, lihuisong (C) <lihuisong@huawei.com> wrote:
>>>
>>> 在 2023/5/26 20:39, Ard Biesheuvel 写道:
>>>> (cc Lorenzo)
>>>>
>>>> On Fri, 26 May 2023 at 14:20, Huisong Li <lihuisong@huawei.com> wrote:
>>>>> The driver who calls the acpi_os_ioremap() cannot be compiled if the 'M'
>>>>> is selected for the driver. The compiling log is as follows:
>>>>> -->
>>>>> MODPOST Module.symvers
>>>>> ERROR: modpost: "acpi_os_ioremap" [drivers/soc/hisilicon/xxx.ko] undefined!
>>>>> scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
>>>>> make[1]: *** [Module.symvers] Error 1
>>>>>
>>>>> So this patch exports symbol for acpi_os_ioremap.
>>>>>
>>>> That driver does not exist in mainline.
>>> We have an uploading driver [1] that may use it.
>>>
>>> [1]
>>> https://patchwork.kernel.org/project/linux-soc/patch/20230522072211.8894-2-lihuisong@huawei.com/
>>>
>>>> Why does it need to use acpi_os_ioremap() instead of the ordinary
>>>> memremap/ioremap routines?
>>> This driver needs to ioremap the shared memory space of a PCC subspace.
>>> And @Sudeep suggested that we use this interface.
>>> It is suitable here.
>> I disagree. acpi_io_ioremap() is internal arch plumbing for the ACPI
>> subsystem. I don't see why we should use it here.
>>
> Yes. One reason I suggested this was in past firmware authors had mixed
> the memory allocated for PCC and using acpi_io_ioremap() made sense. But
> I hear you and it make sense to avoid it especially if the driver must
> know what type of memory it is and must be dealing with.
>
>> On arm64, acpi_os_ioremap() cross references the EFI memory map to
>> figure out whether a physical region is memory or device, but a driver
>> should already know that.
> Agreed.
Thank you. will drop this patch.
>
