Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9E607F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJUTjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJUTjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1532D99;
        Fri, 21 Oct 2022 12:39:40 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LJPbKo025699;
        Fri, 21 Oct 2022 19:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GPZYBQ0k6gzszcp51jceAmjUy2bscuXiB65RpDNZtVk=;
 b=Afzj3RhdFppx+v8xbI86xsuEkaW5NiN33+Aw7Mm/Qu3RrnbKWn3R/q/WUz8ikpSla2Sg
 lYCqG+6tTdoeMFFioLg6c7snWhkPLb7XT/FWbL2JnMNPRfMbUdUORIzysw9qkKnNHOLA
 vJHJhEwbh3eWmS8bG95sBUaNfA7cXMFabI26P/ZxkQqnxVMD1vFNcvf9eCs+M4PpR4/d
 d325VwLxmgC/2aWcDNeankRpgeuOecNOv7/PYHgbpNh52qDC9GKvJQ2Y4DO9XFZzBgvA
 k8/HNs4FTnIw8bpxsn+Wc1/QtJZPWq2H4ie95N7fq5Zb0gM78ENrtnQcwnXn7XZCYL0Y Eg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kc1jugehd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 19:39:14 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29LJZV8n015824;
        Fri, 21 Oct 2022 19:39:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3kapd5n0br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 19:39:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29LJdDje5177944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 19:39:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09F4C58060;
        Fri, 21 Oct 2022 19:39:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F36405805A;
        Fri, 21 Oct 2022 19:39:10 +0000 (GMT)
Received: from [9.160.163.86] (unknown [9.160.163.86])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Oct 2022 19:39:10 +0000 (GMT)
Message-ID: <56929483-56d1-f2b8-9b7e-3fd6388e5f87@linux.ibm.com>
Date:   Fri, 21 Oct 2022 14:39:10 -0500
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
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20221021165650.GA1888515@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GqS9Szf9qUjWXZy28hZIAbp9MzWezgEw
X-Proofpoint-ORIG-GUID: GqS9Szf9qUjWXZy28hZIAbp9MzWezgEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/21/22 11:56, Guenter Roeck wrote:
> On Fri, Oct 21, 2022 at 10:15:58AM -0500, Eddie James wrote:
>> Enable the pre-timeout interrupt if requested by device property.
>>
> I am not inclined to accept this patch without detailed explanation.
> Why would it make sense and/or be desirable to completely bypass the
> watchdog core with this pretimeout support ?


Sorry, I should add more detail.

It doesn't necessarily bypass the watchdog core. It can, if you specify 
reset-type="none". But if not, the watchdog will still fire at the 
appropriate time.

The purpose is to get a stack dump from a kernel panic rather than a 
hard reset from the watchdog. The interrupt will fire a certain number 
of microseconds (configurable by dts property) before the watchdog does. 
The interrupt handler then panics, and all the CPU stacks are dumped, so 
hopefully you can catch where another processor was stuck.


I can submit v2 with this information in the commit message and/or comments.

Thanks,

Eddie


>
> Thanks,
> Guenter
>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/watchdog/aspeed_wdt.c | 53 +++++++++++++++++++++++++++++++++--
>>   1 file changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>> index 0cff2adfbfc9..8e12181a827e 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -5,11 +5,14 @@
>>    * Joel Stanley <joel@jms.id.au>
>>    */
>>   
>> +#include <linux/bits.h>
>>   #include <linux/delay.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_irq.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/watchdog.h>
>>   
>> @@ -26,20 +29,32 @@ struct aspeed_wdt {
>>   
>>   struct aspeed_wdt_config {
>>   	u32 ext_pulse_width_mask;
>> +	u32 irq_shift;
>> +	u32 irq_mask;
>>   };
>>   
>>   static const struct aspeed_wdt_config ast2400_config = {
>>   	.ext_pulse_width_mask = 0xff,
>> +	.irq_shift = 0,
>> +	.irq_mask = 0,
>>   };
>>   
>>   static const struct aspeed_wdt_config ast2500_config = {
>>   	.ext_pulse_width_mask = 0xfffff,
>> +	.irq_shift = 12,
>> +	.irq_mask = GENMASK(31, 12),
>> +};
>> +
>> +static const struct aspeed_wdt_config ast2600_config = {
>> +	.ext_pulse_width_mask = 0xfffff,
>> +	.irq_shift = 0,
>> +	.irq_mask = GENMASK(31, 10),
>>   };
>>   
>>   static const struct of_device_id aspeed_wdt_of_table[] = {
>>   	{ .compatible = "aspeed,ast2400-wdt", .data = &ast2400_config },
>>   	{ .compatible = "aspeed,ast2500-wdt", .data = &ast2500_config },
>> -	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2500_config },
>> +	{ .compatible = "aspeed,ast2600-wdt", .data = &ast2600_config },
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>> @@ -58,6 +73,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>   #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
>>   #define   WDT_CTRL_ENABLE		BIT(0)
>>   #define WDT_TIMEOUT_STATUS	0x10
>> +#define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
>>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>> @@ -243,6 +259,17 @@ static const struct watchdog_info aspeed_wdt_info = {
>>   	.identity	= KBUILD_MODNAME,
>>   };
>>   
>> +static irqreturn_t aspeed_wdt_irq(int irq, void *arg)
>> +{
>> +	struct aspeed_wdt *wdt = arg;
>> +	u32 status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>> +
>> +	if (status & WDT_TIMEOUT_STATUS_IRQ)
>> +		panic("Watchdog pre-timeout IRQ");
>> +
>> +	return IRQ_NONE;
>> +}
>> +
>>   static int aspeed_wdt_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -253,6 +280,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	const char *reset_type;
>>   	u32 duration;
>>   	u32 status;
>> +	u32 timeout = 0;
>>   	int ret;
>>   
>>   	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> @@ -291,6 +319,27 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   	if (of_device_is_compatible(np, "aspeed,ast2400-wdt"))
>>   		wdt->ctrl = WDT_CTRL_1MHZ_CLK;
>>   
>> +	if (config->irq_mask) {
>> +		if (!of_property_read_u32(np, "aspeed,pre-timeout-irq-us", &timeout) && timeout) {
>> +			int irq =  platform_get_irq(pdev, 0);
>> +
>> +			if (irq < 0) {
>> +				dev_warn(dev, "Couldn't find IRQ: %d\n", irq);
>> +				timeout = 0;
>> +			} else {
>> +				ret = devm_request_irq(dev, irq, aspeed_wdt_irq, IRQF_SHARED,
>> +						       dev_name(dev), wdt);
>> +				if (ret) {
>> +					dev_warn(dev, "Couldn't request IRQ:%d\n", ret);
>> +					timeout = 0;
>> +				} else {
>> +					wdt->ctrl |= ((timeout << config->irq_shift) &
>> +						      config->irq_mask) | WDT_CTRL_WDT_INTR;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * Control reset on a per-device basis to ensure the
>>   	 * host is not affected by a BMC reboot
>> @@ -308,7 +357,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>   		else if (!strcmp(reset_type, "system"))
>>   			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
>>   				     WDT_CTRL_RESET_SYSTEM;
>> -		else if (strcmp(reset_type, "none"))
>> +		else if (strcmp(reset_type, "none") && !timeout)
>>   			return -EINVAL;
>>   	}
>>   	if (of_property_read_bool(np, "aspeed,external-signal"))
>> -- 
>> 2.31.1
>>
