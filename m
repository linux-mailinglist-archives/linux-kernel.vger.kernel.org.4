Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4389F710709
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbjEYINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjEYINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:13:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24819D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:12:53 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRgjG6mK4zYslL;
        Thu, 25 May 2023 16:10:42 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 16:12:50 +0800
Message-ID: <5e0d81c8-5f52-82e5-5509-785e87a9a17e@huawei.com>
Date:   Thu, 25 May 2023 16:12:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <andersson@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
 <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
 <20230525073539.waaa7wpudohullcg@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230525073539.waaa7wpudohullcg@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/25 15:35, Sudeep Holla 写道:
> On Thu, May 25, 2023 at 10:41:51AM +0800, lihuisong (C) wrote:
>> Hi Sudeep,
>>
>> Here, the interface is used to determine whether a port is in use or
>> enabled.
>> If we just use 'status', it cannot inidicates its own meaning by name.
>> What do you think?
>>
> How about "port_status" or "port-status" ?
The meaning of this status is a little board.
How about 'enable'? just a read-only entry.


In addition, I happen to have another problem when replace ioremap() 
with acpi_os_ioremap().

The driver selects 'M' in .config to compile.
The driver cannot be compiled if we use acpi_os_ioremap().
The compiling log is as follows:
-->
make -j80
   CALL    scripts/checksyscalls.sh
   CC [M]  drivers/soc/hisilicon/kunpeng_hccs.o
   MODPOST Module.symvers
ERROR: modpost: "acpi_os_ioremap" 
[drivers/soc/hisilicon/kunpeng_hccs.ko] undefined!
scripts/Makefile.modpost:136: recipe for target 'Module.symvers' failed
make[1]: *** [Module.symvers] Error 1
Makefile:1978: recipe for target 'modpost' failed
make: *** [modpost] Error 2

The driver can be compiled if we selects 'Y' or export symbol for 
acpi_os_ioremap.
So we have to export symbol for acpi_os_ioremap.
I plan to do it in another patch, and not in this series in case of 
blocking the upload of this driver.
What do you think?
