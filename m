Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5263EF21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLALPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiLALOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:14:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3203A85E0;
        Thu,  1 Dec 2022 03:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDZS7Gu05ExHKTI7cFdipdwqDGYwPVQ3uxyXOcUW5OhhVic+pUwJSy0YXkcS6u01fgqhzNM0sTMtxf9n4tEqxY/2HYCLKHwo4cPV+0H/n02T5Qjj1U9ni24uT39OrWIvyMInoE2WZ5w2FIbsUo/Xu9BoOL/WdWBxjwfguA3mroeSkUbM2bUOgts44tBWLh9nEtVLq0ZG3gLf4imKBz9AKujYS7Xl+f+eTnZnFx5k6S1RC5xjlNAG2189TR0ovdwgYbUYl2n3D/Zh2MZDHDIyGyk5/A+3LOjP5oC/lXtenZjcVeRe4AhIqiTZR03DiLl4Zx+E6ED8xQgOWiZ/lAMskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftqCKc5LjjA2oDoHeaVC5M9bR94ZqiSXlQklodjO1e8=;
 b=d/YB51b5B0SdyuAaFVR0MlCjTMnJrFE4BMeiNP2N1+zWHAzdhaqfANw5YhzP4iXFZBr+gEuEx7xdyIfmsQzuJ4XPf9gcU/8jwwDU20okvkOCas0f+LUE99EqUy0D7yKGg+FFpP7jdtacgGcDyyR+RlUfLFntvj319uXRT5Fcwoiz4/9Kdu/iNY+2avh+lzZ02myHPTtnAEAGzsm0FIYjKMAe67g7f4hbWJhmjHRM1rWW4balRi3uHzGP3+YxKlHIwYlglXlnqcYSZYhVMHv4cRp+HkFiPkqFvfEqdbGMumEktcAbNrutP/wtjXWrYK/nR5kxb2k+uITGDjruGKKciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftqCKc5LjjA2oDoHeaVC5M9bR94ZqiSXlQklodjO1e8=;
 b=rIWZuC2wmgJHNbtJD/wRGIOIcaiPkyoakDOwhRFVJBEBYNQcgnjmszJW019rdmrNYbIzAkoynAJPXR7zEhincAef1up8v554L5RDyQ4BPwWUUWCEvgIba3ITfxDhkP1cXDvz0EntR0VcPsCXDYMWU1zdhxt/A6xcTzfKmIrZr/E=
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:31d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 11:08:48 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::59) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 11:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 11:08:47 +0000
Received: from [10.254.241.50] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 05:08:43 -0600
Message-ID: <8bd8f53b-948e-637a-d692-78a7ac15c6df@amd.com>
Date:   Thu, 1 Dec 2022 12:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
To:     "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <20221002162528.GA2900147@roeck-us.net>
 <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
 <BY5PR12MB403330D43906BD6D617DB0DC93389@BY5PR12MB4033.namprd12.prod.outlook.com>
 <20221103172432.GB177861@roeck-us.net>
 <DM6PR12MB4044C5194CC4C70A36E2F4F9933D9@DM6PR12MB4044.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <DM6PR12MB4044C5194CC4C70A36E2F4F9933D9@DM6PR12MB4044.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|BL1PR12MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c79631-cdac-4841-af52-08dad38c6b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xgFeBkEzmBEv9JOF2YLZimAM7z4BX27CEKZU9SInlf9rcgfXgA0n+9uUvqpJzuT+bOv1Ph8L3cZxFFWxOwabdXHpkRZoBCpMgh/Rjq1SJcy+/8thXK8k5cy2myD0Ge+RS2QHwUPa4LrGuB/fQFGzsynyiaFD4u0wlffnk7ndO8qJ7VkX2jt9UqQ6JWgPo+yqxe1COB610RmNoy+ICJUFjG2m3Gaf7hbDfgtYlJ5zbLHuaR6x70V68cDveeu1NW3nE2DI4BpIYdnAAtrb/INJX1+qIJpVK1rzB7a7Y/tR62a68tHby3XY5ZwtS7HoOQwnTRB/OX9neOFmZbVcONk1C6GlKLxHK+g2DeUMMC4fCIMV1GRUOEQKlwoZ/aCPYi6zWS7YrpA2V95LO1IRv1nNq6Z2/R+G4qrPJzMbsCxhEKXZ9meNJ60VmyKVqyrySFk4XF60CQ3Xme9RIOmWRpGLGVbsuIAKvQA+v+YIZ+E6RLsvs7MWTPqbAfh7RNAgxRUCDlY2KaGtN0G2FeR5fWHXf0IZg8EeMoX8SEWXhQYT8UhKLo6JPy/Bo8M1CLAygH7Mm8OIR5m3dDivZ0eTMGA/R9Vs8vruZMdbvQ5nYfaWL6Y4xXncG1vv91JahYSQK1hpa+wwdy83Mqo2VLJDLGZR2KSM9PRzS7EEf0qbUf5eIgySCEI1goxtTGY3Sfu9jfIBphbMc2lHmE4A8h7tl4Joe/3j3afk3kwTqVsRBLkGzydqVJ1YcOa+FgLNC6MTjyL/2j5jCK7gc7EfKlSm+A1ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(110136005)(336012)(2906002)(31696002)(316002)(16576012)(36756003)(54906003)(356005)(81166007)(83380400001)(47076005)(82740400003)(82310400005)(426003)(53546011)(36860700001)(86362001)(186003)(40480700001)(26005)(478600001)(2616005)(16526019)(8936002)(8676002)(41300700001)(4326008)(30864003)(70586007)(70206006)(5660300002)(31686004)(44832011)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 11:08:47.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c79631-cdac-4841-af52-08dad38c6b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 11/6/22 16:16, Neeli, Srinivas wrote:
> Hi Guenter,
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Thursday, November 3, 2022 10:55 PM
>> To: Neeli, Srinivas <srinivas.neeli@amd.com>
>> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
>> <shubhrajyoti.datta@amd.com>; Simek, Michal <michal.simek@amd.com>;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
>> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
>> <git@amd.com>
>> Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
>> watchdog support
>>
>> On Thu, Nov 03, 2022 at 04:51:14PM +0000, Neeli, Srinivas wrote:
>>> HI Guenter,
>>>
>>>> -----Original Message-----
>>>> From: Neeli, Srinivas <srinivas.neeli@amd.com>
>>>> Sent: Tuesday, October 11, 2022 11:57 AM
>>>> To: Guenter Roeck <linux@roeck-us.net>
>>>> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
>>>> <shubhrajyoti.datta@amd.com>; Simek, Michal
>> <michal.simek@amd.com>;
>>>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
>>>> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
>>>> kernel@lists.infradead.org; devicetree@vger.kernel.org; git
>>>> (AMD-Xilinx) <git@amd.com>
>>>> Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
>>>> watchdog support
>>>>
>>>> Hi,
>>>>
>>>>> -----Original Message-----
>>>>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
>> Roeck
>>>>> Sent: Sunday, October 2, 2022 9:55 PM
>>>>> To: Neeli, Srinivas <srinivas.neeli@amd.com>
>>>>> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
>>>>> <shubhrajyoti.datta@amd.com>; Simek, Michal
>>>> <michal.simek@amd.com>;
>>>>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
>>>>> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
>>>>> kernel@lists.infradead.org; devicetree@vger.kernel.org; git
>>>>> (AMD-Xilinx) <git@amd.com>
>>>>> Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
>>>>> watchdog support
>>>>>
>>>>> On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
>>>>>> Versal watchdog driver uses window watchdog mode. Window
>>>>>> watchdog
>>>>>> timer(WWDT) contains closed(first) and open(second) window with
>>>>>> 32 bit width. Write to the watchdog timer within predefined
>>>>>> window periods of time. This means a period that is not too soon
>>>>>> and a period that is not too late. The WWDT has to be restarted
>>>>>> within the open window time. If software tries to restart WWDT
>>>>>> outside of the open window time period, it generates a reset.
>>>>>>
>>>>>> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
>>>>>> ---
>>>>>>   drivers/watchdog/Kconfig       |  17 ++
>>>>>>   drivers/watchdog/Makefile      |   1 +
>>>>>>   drivers/watchdog/xilinx_wwdt.c | 286
>>>>>> +++++++++++++++++++++++++++++++++
>>>>>>   3 files changed, 304 insertions(+)  create mode 100644
>>>>>> drivers/watchdog/xilinx_wwdt.c
>>>>>>
>>>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>>>> index
>>>>>> 688922fc4edb..9822e471b9f0 100644
>>>>>> --- a/drivers/watchdog/Kconfig
>>>>>> +++ b/drivers/watchdog/Kconfig
>>>>>> @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
>>>>>>   	  To compile this driver as a module, choose M here: the
>>>>>>   	  module will be called of_xilinx_wdt.
>>>>>>
>>>>>> +config XILINX_WINDOW_WATCHDOG
>>>>>> +	tristate "Xilinx window watchdog timer"
>>>>>> +	depends on HAS_IOMEM
>>>>>> +	select WATCHDOG_CORE
>>>>>> +	help
>>>>>> +	  Window watchdog driver for the versal_wwdt ip core.
>>>>>> +	  Window watchdog timer(WWDT) contains closed(first) and
>>>>>> +	  open(second) window with 32 bit width. Write to the
>> watchdog
>>>>>> +	  timer within predefined window periods of time. This
>> means
>>>>>> +	  a period that is not too soon and a period that is not too
>>>>>> +	  late. The WWDT has to be restarted within the open
>> window time.
>>>>>> +	  If software tries to restart WWDT outside of the open
>> window
>>>>>> +	  time period, it generates a reset.
>>>>>> +
>>>>>> +	  To compile this driver as a module, choose M here: the
>>>>>> +	  module will be called xilinx_wwdt.
>>>>>> +
>>>>>>   config ZIIRAVE_WATCHDOG
>>>>>>   	tristate "Zodiac RAVE Watchdog Timer"
>>>>>>   	depends on I2C
>>>>>> diff --git a/drivers/watchdog/Makefile
>>>>>> b/drivers/watchdog/Makefile index cdeb119e6e61..4ff96c517407
>>>>>> 100644
>>>>>> --- a/drivers/watchdog/Makefile
>>>>>> +++ b/drivers/watchdog/Makefile
>>>>>> @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) +=
>>>>> m54xx_wdt.o
>>>>>>
>>>>>>   # MicroBlaze Architecture
>>>>>>   obj-$(CONFIG_XILINX_WATCHDOG) += of_xilinx_wdt.o
>>>>>> +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) += xilinx_wwdt.o
>>>>>>
>>>>>>   # MIPS Architecture
>>>>>>   obj-$(CONFIG_ATH79_WDT) += ath79_wdt.o diff --git
>>>>>> a/drivers/watchdog/xilinx_wwdt.c
>>>>>> b/drivers/watchdog/xilinx_wwdt.c new file mode 100644 index
>>>>>> 000000000000..2594a01c2764
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/watchdog/xilinx_wwdt.c
>>>>>> @@ -0,0 +1,286 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Window watchdog device driver for Xilinx Versal WWDT
>>>>>> + *
>>>>>> + * Copyright (C) 2022, Advanced Micro Devices, Inc.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/clk.h>
>>>>>> +#include <linux/interrupt.h>
>>>>>> +#include <linux/io.h>
>>>>>> +#include <linux/ioport.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/of_address.h>
>>>>>> +#include <linux/watchdog.h>
>>>>>> +
>>>>>> +#define XWWDT_DEFAULT_TIMEOUT	40
>>>>>> +#define XWWDT_MIN_TIMEOUT	1
>>>>>> +#define XWWDT_MAX_TIMEOUT	42
>>>>>> +
>>>>>> +/* Register offsets for the WWDT device */
>>>>>> +#define XWWDT_MWR_OFFSET	0x00
>>>>>> +#define XWWDT_ESR_OFFSET	0x04
>>>>>> +#define XWWDT_FCR_OFFSET	0x08
>>>>>> +#define XWWDT_FWR_OFFSET	0x0c
>>>>>> +#define XWWDT_SWR_OFFSET	0x10
>>>>>> +
>>>>>> +/* Master Write Control Register Masks */
>>>>>> +#define XWWDT_MWR_MASK		BIT(0)
>>>>>> +
>>>>>> +/* Enable and Status Register Masks */
>>>>>> +#define XWWDT_ESR_WINT_MASK	BIT(16)
>>>>>> +#define XWWDT_ESR_WSW_MASK	BIT(8)
>>>>>> +#define XWWDT_ESR_WEN_MASK	BIT(0)
>>>>>> +
>>>>>> +#define XWWDT_PERCENT		50
>>>>>> +
>>>>>> +static int xwwdt_timeout;
>>>>>> +static int xclosed_window_percent;
>>>>>> +
>>>>>> +module_param(xwwdt_timeout, int, 0644);
>>>>>> +MODULE_PARM_DESC(xwwdt_timeout,
>>>>>> +		 "Watchdog time in seconds. (default="
>>>>>> +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT)
>> ")");
>>>>>
>>>>> There is no reason to make this writeable. There are means to set
>>>>> the timeout in runtime. Those should be used.
>>>>
>>>> Accepted and will update in V2.
>>>>>
>>>>>> +module_param(xclosed_window_percent, int, 0644);
>>>>>> +MODULE_PARM_DESC(xclosed_window_percent,
>>>>>> +		 "Watchdog closed window percentage. (default="
>>>>>> +		 __MODULE_STRING(XWWDT_PERCENT) ")");
>>>>>
>>>>> The above is problematic. This should really not be set during
>>>>> runtime, and the behavior is pretty much undefined if it is
>>>>> changed while the watchdog is running. It should really be set
>>>>> using devicetree and not be changed in the running system.
>>>>
>>>> Accepted and will update in V2.
>>>>>
>>>>>> +
>>>>>> +/**
>>>>>> + * struct xwwdt_device - Watchdog device structure
>>>>>> + * @base: base io address of WDT device
>>>>>> + * @spinlock: spinlock for IO register access
>>>>>> + * @xilinx_wwdt_wdd: watchdog device structure
>>>>>> + * @clk: struct clk * of a clock source
>>>>>> + * @freq: source clock frequency of WWDT  */ struct xwwdt_device {
>>>>>> +	void __iomem *base;
>>>>>> +	spinlock_t spinlock; /* spinlock for register handling */
>>>>>> +	struct watchdog_device xilinx_wwdt_wdd;
>>>>>> +	struct clk *clk;
>>>>>> +	unsigned long	freq;
>>>>>> +};
>>>>>> +
>>>>>> +static bool is_wwdt_in_closed_window(struct watchdog_device
>> *wdd) {
>>>>>> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
>>>>>> +	u32 csr, ret;
>>>>>> +
>>>>>> +	csr = ioread32(xdev->base + XWWDT_ESR_OFFSET);
>>>>>> +
>>>>>> +	ret = (csr & XWWDT_ESR_WEN_MASK) ? !(csr &
>>>>> XWWDT_ESR_WSW_MASK) ? 0 :
>>>>>> +1 : 1;
>>>>>
>>>>> This is confusing.
>>>>>
>>>>> 	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr &
>>>> XWWDT_ESR_WSW_MASK);
>>>>>
>>>>> should do the same and would be easier to understand, though I am
>>>>> not sure if it is correct (making the point that the expression is
>> confusing).
>>>>>
>>>> Accepted and will update in V2.
>>>>
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int xilinx_wwdt_start(struct watchdog_device *wdd) {
>>>>>> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
>>>>>> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev-
>>>>>> xilinx_wwdt_wdd;
>>>>>> +	u64 time_out, closed_timeout, open_timeout;
>>>>>> +	u32 control_status_reg;
>>>>>> +
>>>>>> +	/* Calculate timeout count */
>>>>>> +	time_out = xdev->freq * wdd->timeout;
>>>>>> +
>>>>>> +	if (xclosed_window_percent) {
>>>>>> +		closed_timeout = (time_out *
>> xclosed_window_percent) /
>>>>> 100;
>>>>>> +		open_timeout = time_out - closed_timeout;
>>>>>> +		wdd->min_hw_heartbeat_ms =
>> xclosed_window_percent *
>>>>> 10 * wdd->timeout;
>>>>>> +	} else {
>>>>>> +		/* Calculate 50% of timeout */
>>>>>
>>>>> Isn't that a bit random ?
>>>>
>>>> Versal Window watchdog IP supports below features.
>>>>   1)Start
>>>>   2)Stop
>>>>   3)Configure Timeout
>>>>   4)Refresh
>>>>
>>>> Planning to take closed window percentage from device tree parameter.
>>>> If the user hasn't passed the closed window percentage from the
>>>> device tree, by default, taking XWWDT_PERCENT value which is 50.
>>>>
> 
> Does above explanation looks fine to you ?
> 
>>>>>
>>>>>> +		time_out *= XWWDT_PERCENT;
>>>>>> +		time_out /= 100;
>>>>>> +		wdd->min_hw_heartbeat_ms = XWWDT_PERCENT *
>> 10 *
>>>>> wdd->timeout;
>>>>>
>>>>> min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior
>>>>> of changing it when starting the watchdog is undefined. This will
>>>>> likely fail under some conditions.
>>>>
>>>> As I said in above comments versal watchdog IP supports
>>>> reconfiguration of timeout, so every restart we are updating
>>>> min_hw_heartbeat_ms based on timeout.
>>>>
> 
> After stop we are reconfiguring the min_hw_heartbeat_ms, do you think still it will fail ?.
> 
>>>>>
>>>>>> +	}
>>>>>> +
>>>>>> +	spin_lock(&xdev->spinlock);
>>>>>> +
>>>>>> +	iowrite32(XWWDT_MWR_MASK, xdev->base +
>>>>> XWWDT_MWR_OFFSET);
>>>>>> +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
>>>>> XWWDT_ESR_OFFSET);
>>>>>> +
>>>>>> +	if (xclosed_window_percent) {
>>>>>> +		iowrite32((u32)closed_timeout, xdev->base +
>>>>> XWWDT_FWR_OFFSET);
>>>>>> +		iowrite32((u32)open_timeout, xdev->base +
>>>>> XWWDT_SWR_OFFSET);
>>>>>> +	} else {
>>>>>> +		/* Configure closed and open windows with 50% of
>> timeout
>>>>> */
>>>>>> +		iowrite32((u32)time_out, xdev->base +
>>>>> XWWDT_FWR_OFFSET);
>>>>>> +		iowrite32((u32)time_out, xdev->base +
>>>>> XWWDT_SWR_OFFSET);
>>>>>> +	}
>>>>>
>>>>> This if/else should not be necessary by using appropriate
>>>>> calculations
>>>> above.
>>>>> Anyway, this is moot - as said above, changing min_hw_heartbeat_ms
>>>>> after probe is unexpected, and the code will have to be changed to
>>>>> use a fixed value for the window size. With that, all calculations
>>>>> can and should be done in the probe function.
>>>>>
>>>>>> +
>>>>>> +	/* Enable the window watchdog timer */
>>>>>> +	control_status_reg = ioread32(xdev->base +
>> XWWDT_ESR_OFFSET);
>>>>>> +	control_status_reg |= XWWDT_ESR_WEN_MASK;
>>>>>> +	iowrite32(control_status_reg, xdev->base +
>> XWWDT_ESR_OFFSET);
>>>>>
>>>>> Why is this enabled unconditionally ? I would assume that a user
>>>>> specifying a 0-percentage window size doesn't want it enabled.
>>>>
>>>> Plan to add a check for closed window percentage. If user tries to
>>>> configure 100% of closed window, driver configures XWWDT_PERCENT
>> value.
>>>> Configuring 100% of closed window not suggestible.
>>>>
> 
> Do you have any feedback on above explanation ?.
> 
>>>>>
>>>>>> +
>>>>>> +	spin_unlock(&xdev->spinlock);
>>>>>> +
>>>>>> +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd) {
>>>>>> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
>>>>>> +	u32 control_status_reg;
>>>>>> +
>>>>>> +	spin_lock(&xdev->spinlock);
>>>>>> +
>>>>>> +	/* Enable write access control bit for the window watchdog
>> */
>>>>>> +	iowrite32(XWWDT_MWR_MASK, xdev->base +
>>>>> XWWDT_MWR_OFFSET);
>>>>>> +
>>>>>> +	/* Trigger restart kick to watchdog */
>>>>>> +	control_status_reg = ioread32(xdev->base +
>> XWWDT_ESR_OFFSET);
>>>>>> +	control_status_reg |= XWWDT_ESR_WSW_MASK;
>>>>>> +	iowrite32(control_status_reg, xdev->base +
>> XWWDT_ESR_OFFSET);
>>>>>> +
>>>>>> +	spin_unlock(&xdev->spinlock);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
>>>>>> +				   unsigned int new_time)
>>>>>> +{
>>>>>> +	struct xwwdt_device *xdev = watchdog_get_drvdata(wdd);
>>>>>> +	struct watchdog_device *xilinx_wwdt_wdd = &xdev-
>>>>>> xilinx_wwdt_wdd;
>>>>>> +
>>>>>> +	if (watchdog_active(xilinx_wwdt_wdd))
>>>>>> +		return -EPERM;
>>>>>
>>>>> Why ? This will be the most common case and means to change the
>>>> timeout.
>>>>
>>>> Versal Watchdog supports reconfiguration of timeout. If we try to
>>>> reconfigure timeout without stopping the watchdog, driver returns
>>>> error immediately. Reconfiguration of timeout, Stop and Refresh not
>>>> allowed in closed window.
>>>> User can trigger set timeout any point of time, So avoiding
>>>> reconfiguring the timeout feature using driver API if the watchdog is
>> active.
>>>>
> 
> Please share your comments on this.
> 

I see that there are still some pending questions on this thread.
Could you please take a look at it?
If you think that would be better to send v2 and better describe the problematic 
parts as the part of commit message that should be also fine.

Thanks,
Michal
