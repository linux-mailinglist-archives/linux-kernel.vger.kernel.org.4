Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF86153A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiKAUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKAUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:55:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE3F02E;
        Tue,  1 Nov 2022 13:55:18 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1Jxxtx010107;
        Tue, 1 Nov 2022 20:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gq7zMRKMMJJ1+BRHtkvn/RZIGn3VakFg8gY5IoLnE5o=;
 b=eJK70Obm9cReUEZHaBGK4CDZisMS00WDqKHQrB/v7IuDEnAoS/2vTvOZ6cPYXW+BBL9w
 T+pSowY720/e23w4OBrQijvqPYf3ZHyIj6CI7kY9fq1WC3xQqQwUUZlNIEr8/hxTpNmx
 U7xs4EgXgoOYMTknzwQCaMy+23BdIayQfCEo/dtxO6sq2bIBvdr1smXJcZhLoTm3GE6n
 do/JTjpepwwvQ1pVoPXCasmlG9vI4xBnbC0GbZ3empHMxwxK8y/Nx1gGSQ1RoUdKnh8+
 qqNVHebPKrPXfNw1Xv4FzSovPeVdkRxWHrzr0/FiiSae9hb4Z36MccfZX+RhZRslOP67 jA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjruguq3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:54:53 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1KpqvQ004358;
        Tue, 1 Nov 2022 20:54:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3kguta6cns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:54:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KsrB013042342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:54:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE705805A;
        Tue,  1 Nov 2022 20:54:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAE1F58060;
        Tue,  1 Nov 2022 20:54:50 +0000 (GMT)
Received: from [9.160.92.229] (unknown [9.160.92.229])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:54:50 +0000 (GMT)
Message-ID: <8b74ecdd-40aa-90c8-0180-eccf65f3440f@linux.ibm.com>
Date:   Tue, 1 Nov 2022 15:54:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] watchdog: aspeed: Add pre-timeout interrupt support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-2-eajames@linux.ibm.com>
 <20221021165650.GA1888515@roeck-us.net>
 <56929483-56d1-f2b8-9b7e-3fd6388e5f87@linux.ibm.com>
 <00d859b0-f766-4322-fe58-095d4f84e954@roeck-us.net>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <00d859b0-f766-4322-fe58-095d4f84e954@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3qMk-uWf1DD-rKMsU2LZufWDpieLtEo
X-Proofpoint-ORIG-GUID: v3qMk-uWf1DD-rKMsU2LZufWDpieLtEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/21/22 23:00, Guenter Roeck wrote:
> On 10/21/22 12:39, Eddie James wrote:
>>
>> On 10/21/22 11:56, Guenter Roeck wrote:
>>> On Fri, Oct 21, 2022 at 10:15:58AM -0500, Eddie James wrote:
>>>> Enable the pre-timeout interrupt if requested by device property.
>>>>
>>> I am not inclined to accept this patch without detailed explanation.
>>> Why would it make sense and/or be desirable to completely bypass the
>>> watchdog core with this pretimeout support ?
>>
>>
>> Sorry, I should add more detail.
>>
>> It doesn't necessarily bypass the watchdog core. It can, if you 
>> specify reset-type="none". But if not, the watchdog will still fire 
>> at the appropriate time.
>>
>> The purpose is to get a stack dump from a kernel panic rather than a 
>> hard reset from the watchdog. The interrupt will fire a certain 
>> number of microseconds (configurable by dts property) before the 
>> watchdog does. The interrupt handler then panics, and all the CPU 
>> stacks are dumped, so hopefully you can catch where another processor 
>> was stuck.
>>
>>
>> I can submit v2 with this information in the commit message and/or 
>> comments.
>>
>
> You did not answer the question why you do not use the pretimeout 
> functionality
> supported by the watchdog core.


I misunderstood your question and I wasn't actually aware of the 
pretimeout support in the core. I have sent v2 using the core pretimeout.


Thanks,

Eddie


>
> Guenter
>
>> Thanks,
>>
>> Eddie
>>
>>
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>>> ---
>>>>   drivers/watchdog/aspeed_wdt.c | 53 
>>>> +++++++++++++++++++++++++++++++++--
>>>>   1 file changed, 51 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>>>> b/drivers/watchdog/aspeed_wdt.c
>>>> index 0cff2adfbfc9..8e12181a827e 100644
>>>> --- a/drivers/watchdog/aspeed_wdt.c
>>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>>> @@ -5,11 +5,14 @@
>>>>    * Joel Stanley <joel@jms.id.au>
>>>>    */
>>>> +#include <linux/bits.h>
>>>>   #include <linux/delay.h>
>>>> +#include <linux/interrupt.h>
>>>>   #include <linux/io.h>
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/of.h>
>>>> +#include <linux/of_irq.h>
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/watchdog.h>
>>>> @@ -26,20 +29,32 @@ struct aspeed_wdt {
>>>>   struct aspeed_wdt_config {
>>>>       u32 ext_pulse_width_mask;
>>>> +    u32 irq_shift;
>>>> +    u32 irq_mask;
>>>>   };
>>>>   static const struct aspeed_wdt_config ast2400_config = {
>>>>       .ext_pulse_width_mask = 0xff,
>>>> +    .irq_shift = 0,
>>>> +    .irq_mask = 0,
>>>>   };
>>>>   static const struct aspeed_wdt_config ast2500_config = {
>>>>       .ext_pulse_width_mask = 0xfffff,
>>>> +    .irq_shift = 12,
>>>> +    .irq_mask = GENMASK(31, 12),
>>>> +};
>>>> +
>>>> +static const struct aspeed_wdt_config ast2600_config = {
>>>> +    .ext_pulse_width_mask = 0xfffff,
>>>> +    .irq_shift = 0,
>>>> +    .irq_mask = GENMASK(31, 10),
>>>>   };
>>>>   static const struct of_device_id aspeed_wdt_of_table[] = {
>>>>       { .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>>>>       { .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
>>>> -    { .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
>>>> +    { .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>>>>       { },
>>>>   };
>>>>   MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>>   #define   WDT_CTRL_RESET_SYSTEM        BIT(1)
>>>>   #define   WDT_CTRL_ENABLE        BIT(0)
>>>>   #define WDT_TIMEOUT_STATUS    0x10
>>>> +#define   WDT_TIMEOUT_STATUS_IRQ        BIT(2)
>>>>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY    BIT(1)
>>>>   #define WDT_CLEAR_TIMEOUT_STATUS    0x14
>>>>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION BIT(0)
>>>> @@ -243,6 +259,17 @@ static const struct watchdog_info 
>>>> aspeed_wdt_info = {
>>>>       .identity    = KBUILD_MODNAME,
>>>>   };
>>>> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
>>>> +{
>>>> +    struct aspeed_wdt *wdt = arg;
>>>> +    u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>>>> +
>>>> +    if (status & WDT_TIMEOUT_STATUS_IRQ)
>>>> +        panic("Watchdog pre-timeout IRQ");
>>>> +
>>>> +    return IRQ_NONE;
>>>> +}
>>>> +
>>>>   static int aspeed_wdt_probe(struct platform_device *pdev)
>>>>   {
>>>>       struct device *dev = &pdev->dev;
>>>> @@ -253,6 +280,7 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>>       const char *reset_type;
>>>>       u32 duration;
>>>>       u32 status;
>>>> +    u32 timeout = 0;
>>>>       int ret;
>>>>       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>>> @@ -291,6 +319,27 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>>       if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
>>>>           wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>>>> +    if (config->irq_mask) {
>>>> +        if (!of_property_read_u32(np, "aspeed,pre-timeout-irq-us", 
>>>> &timeout) && timeout) {
>>>> +            int irq =  platform_get_irq(pdev, 0);
>>>> +
>>>> +            if (irq < 0) {
>>>> +                dev_warn(dev, "Couldn't find IRQ: %d\n", irq);
>>>> +                timeout = 0;
>>>> +            } else {
>>>> +                ret = devm_request_irq(dev, irq, aspeed_wdt_irq, 
>>>> IRQF_SHARED,
>>>> +                               dev_name(dev), wdt);
>>>> +                if (ret) {
>>>> +                    dev_warn(dev, "Couldn't request IRQ:%d\n", ret);
>>>> +                    timeout = 0;
>>>> +                } else {
>>>> +                    wdt->ctrl |= ((timeout << config->irq_shift) &
>>>> +                              config->irq_mask) | WDT_CTRL_WDT_INTR;
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>>       /*
>>>>        * Control reset on a per-device basis to ensure the
>>>>        * host is not affected by a BMC reboot
>>>> @@ -308,7 +357,7 @@ static int aspeed_wdt_probe(struct 
>>>> platform_device *pdev)
>>>>           else if (!strcmp(reset_type, "system"))
>>>>               wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
>>>>                        WDT_CTRL_RESET_SYSTEM;
>>>> -        else if (strcmp(reset_type, "none"))
>>>> +        else if (strcmp(reset_type, "none") && !timeout)
>>>>               return -EINVAL;
>>>>       }
>>>>       if (of_property_read_bool(np, "aspeed,external-signal"))
>>>> -- 
>>>> 2.31.1
>>>>
>
