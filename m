Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FD745675
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGCHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGCHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:53:11 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CBC1;
        Mon,  3 Jul 2023 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688370789;
  x=1719906789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/8vdooaz0cjRGKEBG+sx8nQux5u34v68Mot+xTUG+HQ=;
  b=eDihRpCNZP7hq/fSUNfJgCp1C4SMfGe+UZI+O1P3QVC8sYzNCWLlZbac
   dkMo/Qcb6jIgN1RwTC9NVYDRuAqbr9ZBUjTtvHhxOtEBbY3IuQBw3G6d3
   IPJUyNPxEqzYRkDp+JlXxVFzI78eM7gEXJe0FD49hYDBQwH2uGiPprTAa
   ozYKhpEo+smvTgeokuXfWZQgHYDSfdu2h+A3vP3OxzCregvAli//P9GA3
   P4CVptzQLVSDG4FcN9iVG59r6LkNTQ2oC6MFiowGBfgSdMIIfMM3k9GBD
   AUSv+xvXCNP1jTlgzVchkRdZ7dQyE5bQ36LGYaWR1lK2u1R/8eeV5n1eF
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBaU4ZQaiBecv5vzenvm8/8xG9KG7DSV+ww3BMpF6SKt+T/uMFgS1hTzlXXihpk75veejo2MqcR0V4UQz2ANmtfrXRDVvO+CdMlsYGCjsc9VbjflzIzVyZdoNgQkfsHj7XmlirzNF79nkbobvz2925bre4Tphv2cLRQWqKPLaXe4NYvz5oq9i1XFsynUEz0yoG/u8ekCuWiO0QAXLeOTk/B8gOwAAljEL43613F/mRP2SnncDmzPCrPEpRwEfkzcZJq/Q+1xZ4sbSzzCdYI3yUVtj1YanAI/jr7AFHuCMVI6j4U6CHBPXUp1nzmlMMvPrz1TXYtkH/cUSdhgFIPcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8vdooaz0cjRGKEBG+sx8nQux5u34v68Mot+xTUG+HQ=;
 b=RCEU9RtP21GmhEaMybm4Fn2WiyFi/8a8NZ5aXOGk+BVSiDCKGZaf9OpWTdTF8YJbx264e0EqNdb0czTbldRmjL2iSET0hJzLWZn92AddGGItEHZ4EI0t+6FsbQDWRMkYlZD4Rtj+ttkQbtlCOi/qFNo9fzI3ux9TMif3rwQp0xJ0NSJvvETFunvXhYKL7crdLchy30NRMY+wc+dlUc2eNoqYr60QdrXHE0Gvasm0WI7wtLrhn8MOqFLzNnDSZZp4WoVVFqdosvWEmZaFGhAbVQPsjc71zUDxVwwszZxccamzu4OpDwmJbFIc3nk/pfrbhTu6JVuyuNlyW696mClfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8vdooaz0cjRGKEBG+sx8nQux5u34v68Mot+xTUG+HQ=;
 b=pEa68MSn0MZldlyoYiKaao0+OTfccvE4/uBD9Cjtj91Y8C19aiGU30BWS4Z6lzDpYlEXwRiaNubxLtTklV64fNZjmT8xY6KtSkJefntRqD6QN7+jaywhn2hTgmSYKvYO/3PrTRBBNuZ7o33cZ57MVUwq7JvPTrvQQezbAxSA4hM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <abcfb68b-b631-8a7b-e7cb-daefc58f3dde@axis.com>
Date:   Mon, 3 Jul 2023 09:53:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] led: led-class: Read max-brightness from
 devicetree
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
CC:     <kernel@axis.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230630092248.4146169-1-astrid.rost@axis.com>
 <20230630092248.4146169-2-astrid.rost@axis.com>
 <3e8e7834-fe0e-7e92-5472-cb9fd223980e@gmail.com>
Content-Language: en-US
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <3e8e7834-fe0e-7e92-5472-cb9fd223980e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::15) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|PAVPR02MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f709370-bce7-469d-39ea-08db7b9a87c1
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDWupPl7/VZfFCcm17JZSKcJUGViDh4zD2KP1wFqqdsdkh5yLlsETYZWpungjDVTSKuPq3YXgOEJXnAJKGjAWpoC1qf0GHMCiKL7CRZyWx24otKHQrfom37daJKjdgyZ7hRWkeZfMn0t9GJ+QU5KGxqFP7g/3bgMxml6MKHpq3XgDE4QPEXBU75Gs3sKMKvdLiyoTWB6ghCIHQ2exNExZVJojBUoqEEH/ZufXPJVA2wThGjcVLweMvdWXiTBgzLY4+R0VMDWiUv9/ff5SdcSFbPYG3lF0tGwZk8r7LL/aPSUtQ3tx5Ax+YZvOM4AEy0vaiUS8fuadurggkmpmC0Yo21Cf+sBtp1cYalfyHvQcYrfZvjuSVH5ZxzJpoJwsvlvIpKmmKvfpm42XPKm3iefdUyp2JX8NyYGnX6BD2cPFeJvYSOy3yWZY0sqvRFzn6UQAs+nhTjjMo/l0zfpqVYHmIqtXSXyoGt6PH4ZE9hf3hzeMnEQlCAzWiT0SPB6baiY4YSJamVJ3I/bWywNI8nUw8MUoKd0lLNYI7fFRBNO/6S6X7UC0xLmmwt0RZHHDotWefQ3dsBlJ2QrBOBzYmsfu8uYm5BisksZ6KiXopdZgsJn6hHE8o8DQykzKpGEhQkb6ruYDS67Dtc7s7uTa6NfNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6512007)(966005)(6506007)(53546011)(6486002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9DclVZUk9TdHplTysxUDNRREd5K3o3MEVYY2wwSjRadm0wZkVmYkExRGxQ?=
 =?utf-8?B?T2NRV0JDSm5SZGZPaUVEU2Vxd1plakFTRW85dGh4T2JqN2VnVDQwQk9mdXEz?=
 =?utf-8?B?UjBHNWkrQ2lSRjVLWklyZ0pnZ2RqdUhhR0kvdXZ3USthbExlaVo4SDZTMlBx?=
 =?utf-8?B?UjJoT3BUSEt6Z3ZhOW95R1pETWJMdjB4cUEvNUN2S0ljcXpQUXhEa2U5b0M0?=
 =?utf-8?B?bjZmejBzbVo2SDREVVF1ODR5eXZVNzdDdnFLS1U5R0VvUEltWnV5SnQxazF0?=
 =?utf-8?B?RXBycktvUURSRG9BVmkyQzhxb2luYWpZcXgxbGNVbk9VS04wTVBEN1lhMjQ1?=
 =?utf-8?B?Nm9XMmZoK0xRN3h1RmlubTNlUVAxbVh3U2taMEttN0VMMEZhU0VRcDFtRzRh?=
 =?utf-8?B?UTBFQXFVTHMvNG9MMzZiN0pvMTQyMmVLUHVxU2ZTQzRxTUU2V3VLSXE3L1gr?=
 =?utf-8?B?TlZ2REtPVENqS0VSR0RIQjNaaGlOT0NNYW13cFVIR1gyR3dZSXo1MXN2WDN0?=
 =?utf-8?B?QjdPMWVTK1p0UkVxbU9Wb2o4TjVUSVlHbmlvVWh4bDI2eHZ4blFXZmMvSEYw?=
 =?utf-8?B?eWlvNUIxbDF3YWV0MWVXRG8yNzQ5VS9TRTRXQjBYZnNsM0h3MEEyNHNNRHJH?=
 =?utf-8?B?M04vWjRhcGZmaVFDc29lcGNPaGpYaWFlMjRUY1FDbnhqZGV5eE5WenJDRkRo?=
 =?utf-8?B?OHhBVU14TmgwQ25LOEpJb2NtdHdCQzZMQ3gwSGt6M2ZjTCs2QkgwLzRaTjlM?=
 =?utf-8?B?enBEcm1Cb24zVkNZcVU2cndxclM1dCtER3BKTEtYL2hSVlNzdkR5eFRrc3V2?=
 =?utf-8?B?YjVqek9HaFJhMS8wYTh2U1hJaFNVZ0VsTGlyUjBlbzJJaEhid3FydDdsbjUz?=
 =?utf-8?B?OVErM0srdmVTZTFiTWdkOW0yZWxyaUR0ZzVCY0ovMHVpQWdHRHhkODhNLy9y?=
 =?utf-8?B?cGt3TndweStweVVObDFwYlpKWFp4cmlpVGJpMUc0S2tpeWFDSk1wdFk4aHBv?=
 =?utf-8?B?YjNTc1pyaU9VRXRGV1ZzbW1zcmdiaXVQUFJ4N0ZqaktuN3hpRE85aW1vRE4v?=
 =?utf-8?B?UkVyUHJkNi9VWVJVWDBPNmRGWnNjSGxQTTg4ckY2eXJIem1zYklRTG02Lzd5?=
 =?utf-8?B?dlhDNGlMVUxZaS9iWUVRTjNqc1dqQXZJZm9sQVVyQ01CYVZwT1NMeEM1Q09B?=
 =?utf-8?B?VERmSW1ZM2hJRVVWdE1BdS9SdVpLRUlzRE5nODNiaVd2aWZqYjlwckZGbEdp?=
 =?utf-8?B?SUtYeGN5dHhvQjY2R281MTBmSTlGbkVGdnp5MmhNQ3UrdjFGUzBCdDlMcktC?=
 =?utf-8?B?enlBR2kxRldRRG5udEl2OUNrZE4wZ1FBcjAvTUxtT084RWNPWFhnc1czaERK?=
 =?utf-8?B?TXUvNm4xenFjL09FUUZHQW04cVZLeUtDaUJ3RXFjTGp0djNzVUNvQWl6OEQ2?=
 =?utf-8?B?WXl6UUhCM1lCUFZSR1daZmt1dlVoUFViejNzZFVYaEk4aXVMTjdXT2lsS2dY?=
 =?utf-8?B?cWJaVUt6OHplZ3VkZFNYM2dJbzFqbW9xbzVEWFlyWm1mTzRBM2tNbFcwUUw5?=
 =?utf-8?B?SUpMVnR1aEtZdEVvSDIrZ1I5cHNvczRBclhSRVNmRnFHelE0RmdxMVBMQzkr?=
 =?utf-8?B?RWg1bzlUK01xTWc3NkRuNnJHL3c5T0hXeWVyeFBwNXdqOEdtTGV0QlRiU0ND?=
 =?utf-8?B?NEVKRzZySkZyQkR4S3RWYkc3V0F2dHhmbFBmZkg1UEsvS0J2SmdzVGdwdmM5?=
 =?utf-8?B?RXptR2J6azZXa1lDK1Y5dDYwQm5PZE1XUU9HcUozaVNVRFFxSEhpMlpCcDVm?=
 =?utf-8?B?SENPcmh5VGVMRzFzdngyOGpyanBoWStZTHZNNFlSb1VwZ3FpUm0ydlAzTlhT?=
 =?utf-8?B?akV2SGx1VHRMWnczQlRJa3RhcjJaNDNtWHpDWXdJeGJHdjBJd3o2L0oxNmk0?=
 =?utf-8?B?elRXekZGbzhFd3ZENjU3dEszZ1oySFYyOGd3LzlLeVMwVW5HS3VtN3lpdSt0?=
 =?utf-8?B?RHBFVUhadHVBTGdjR20vd1VEN3lSZkhaSG9VUStWRlhYRWpSeUJjb0k2OXNn?=
 =?utf-8?B?LzZQNEp5SWtyaU1uSHdOQWNaVkU3RUpUemRLem1TVThHYVB3RmxZTTNvOVd4?=
 =?utf-8?Q?lQTw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f709370-bce7-469d-39ea-08db7b9a87c1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:53:03.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/HSkg+gvFAVgmZpcqjlRisA6VYCNZT8buxaqkYwJChNZZTxYIoc4fmejLVz8RHlsms3D8p3ILiXquysHsdluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9794
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacek,

I am having problems with the PWM controller LP5024.

https://www.ti.com/product/LP5024

There is no such a calculation in the data-sheet like:
max_brightness = max_current / constant.

I also assume it is depending on the type of LEDs and circuit, which are 
connected.

It supports two current modes: 25,5 mA and and 35 mA, both is to high 
for the LEDs I have.

For max_brightness seems to be everything inside the kernel, but reading 
the value from devicetree. I first thought I could add it in the lp50xx
driver, but Andy and Rob thought that I better put it into the general 
parts. And of course drivers having led-max-microamp should better use it.

Please, let me know if you have a better suggestion.

Astrid





On 7/1/23 13:09, Jacek Anaszewski wrote:
> Hi Astrid,
> 
> On 6/30/23 11:22, Astrid Rost wrote:
>> Add max-brightness in order to reduce the current on the connected LEDs.
>> Normally, the maximum brightness is determined by the hardware, and this
>> property is not required. This property is used to set a software limit.
>> It could happen that an LED is made so bright that it gets damaged or
>> causes damage due to restrictions in a specific system, such as mounting
>> conditions. Note that led-max-microamp should be preferably used, if it
>> is supported by the controller.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   drivers/leds/led-class.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>> index 9255bc11f99d..ce652abf9336 100644
>> --- a/drivers/leds/led-class.c
>> +++ b/drivers/leds/led-class.c
>> @@ -457,6 +457,10 @@ int led_classdev_register_ext(struct device *parent,
>>               if (fwnode_property_present(init_data->fwnode,
>>                               "retain-state-shutdown"))
>>                   led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
>> +
>> +            fwnode_property_read_u32(init_data->fwnode,
>> +                "max-brightness",
>> +                &led_cdev->max_brightness);
>>           }
>>       } else {
>>           proposed_name = led_cdev->name;
> 
> We have led-max-microamp for that and every LED class driver is supposed
> to calculate its max brightness level basing on it.
> 
