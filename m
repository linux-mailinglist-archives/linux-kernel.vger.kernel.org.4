Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA607102F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjEYCl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYCl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:41:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2EF5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:41:54 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRXMN2HggzsSXn;
        Thu, 25 May 2023 10:39:44 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 10:41:51 +0800
Message-ID: <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
Date:   Thu, 25 May 2023 10:41:51 +0800
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
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230523093922.f2y4wrz3vkzi7kmw@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


在 2023/5/23 17:39, Sudeep Holla 写道:
> On Mon, May 22, 2023 at 03:22:10PM +0800, Huisong Li wrote:
>> The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
>> for ensuring cache coherent on HiSilicon SoC. The performance of
>> the application may be affected if some hccs ports are in non-full
>> lane status, have a large number of CRC errors and so on.
>>
>> This driver provides the query interface of the health status and
>> port information of HCCS on Kunpeng SoC.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   MAINTAINERS                          |    6 +
>>   drivers/soc/Kconfig                  |    1 +
>>   drivers/soc/Makefile                 |    1 +
>>   drivers/soc/hisilicon/Kconfig        |   19 +
>>   drivers/soc/hisilicon/Makefile       |    2 +
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 1287 ++++++++++++++++++++++++++
>>   drivers/soc/hisilicon/kunpeng_hccs.h |  196 ++++
>>   7 files changed, 1512 insertions(+)
>>   create mode 100644 drivers/soc/hisilicon/Kconfig
>>   create mode 100644 drivers/soc/hisilicon/Makefile
>>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
>>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index eddbc48c61e9..fe0e796e8445 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9399,6 +9399,12 @@ S:	Maintained
>>   W:	http://www.hisilicon.com
>>   F:	drivers/spi/spi-hisi-sfc-v3xx.c
>>   
>> +HISILICON KUNPENG SOC HCCS DRIVER
> s/HCCS/HCCS INFO or QUERY/ ?
>
>> +M:	Huisong Li <lihuisong@huawei.com>
>> +S:	Maintained
>> +F:	drivers/soc/hisilicon/kunpeng_hccs.c
>> +F:	drivers/soc/hisilicon/kunpeng_hccs.h
>> +
>>   HMM - Heterogeneous Memory Management
>>   M:	Jérôme Glisse <jglisse@redhat.com>
>>   L:	linux-mm@kvack.org
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 4e176280113a..d21e75d69294 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
>>   source "drivers/soc/canaan/Kconfig"
>>   source "drivers/soc/fsl/Kconfig"
>>   source "drivers/soc/fujitsu/Kconfig"
>> +source "drivers/soc/hisilicon/Kconfig"
>>   source "drivers/soc/imx/Kconfig"
>>   source "drivers/soc/ixp4xx/Kconfig"
>>   source "drivers/soc/litex/Kconfig"
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 3b0f9fb3b5c8..531f46f3ad98 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>>   obj-y				+= fsl/
>>   obj-y				+= fujitsu/
>>   obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>> +obj-y				+= hisilicon/
>>   obj-y				+= imx/
>>   obj-y				+= ixp4xx/
>>   obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
>> new file mode 100644
>> index 000000000000..87a1f15cbedb
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +menu "Hisilicon SoC drivers"
>> +	depends on ARCH_HISI || COMPILE_TEST
>> +
>> +config KUNPENG_HCCS
> Ditto, add INFO or QUERY to the name as HCCS alone suggests it is some
> driver to manage the above bus protocol which is not correct.
>
>> +	tristate "HCCS driver on Kunpeng SoC"
>> +	depends on ACPI
>> +	depends on ARM64 || COMPILE_TEST
>> +	help
>> +	  The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
>> +	  for ensuring cache coherent on HiSilicon SoC. The performance of
>> +	  the application may be affected if some hccs ports are in non-full
>> +	  lane status, have a large number of CRC errors and so on.
>> +
>> +	  Say M here if you want to include support for querying the health
>> +	  status and port information of HCCS on Kunpeng SoC.
>> +
>> +endmenu
>> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
>> new file mode 100644
>> index 000000000000..226e747e70d6
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> new file mode 100644
>> index 000000000000..20a506a04bb7
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -0,0 +1,1287 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * The Huawei Cache-Coherent System (HCCS) is a bus protocol standard for
>> + * ensuring cache coherent on HiSilicon SoC.
>> + *
>> + * Copyright (c) 2023 Hisilicon Limited.
>> + * Author: Huisong Li <lihuisong@huawei.com>
>> + *
>> + * HCCS driver for Kunpeng SoC provides the following features:
>> + * - Retrieve info as belows each port:
> [snip]
>
>> + *    - port type
>> + *    - lane mode
>> + *    - using status
> perhaps just status, "using status" doesn't sound correct to me.
>
>
Hi Sudeep,

Here, the interface is used to determine whether a port is in use or 
enabled.
If we just use 'status', it cannot inidicates its own meaning by name.
What do you think?

/Huisong

[snip]

