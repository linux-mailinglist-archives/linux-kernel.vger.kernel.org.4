Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47576CF6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjC2XXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjC2XXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:23:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20728.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::728])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C481BF6;
        Wed, 29 Mar 2023 16:22:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifMbPBbxt69d0OOwlskIhsfwuzi0yuJe/YG4fuj6az75JtQ4S0UamCl7d2vW/HUyUOQ6xjdIPrgr0l8oMMOE2rt+PbkxTaz/lAvmLkmZ2mWvkpJHnPnHNJQg4Xj5TkhGETN/c+U5oMvG+MNEIFNcC/Wg3ifIrJpvgnPzqM5kNPi6f9TNqsF0E9+AWe72EN7IzLIgj9Npym6v0qDCKI1FnyDf9rw2J57byWivR9HyZMpN9yLWFF2x2CeeuJZGs3/6bk3XrXkgWKZLqQ6ElAksJl8HvrnY80sYM0ovKV8z9fnrBhEITenAdIBaVhJVBRScyEJ9FdLlLBuebvVNyZPJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h87qAQw503LW/j9dSqiDWktSUX03JdGscryuqo1WTuA=;
 b=WPZYhZv7o29afy/QuVqWFz1VWKCLKKcIQc8MtLE4aWLRFWe0FYEHJwXcZrSSmsPxiv3nSO8cqKxndhRUGvX8bVKJmAy1pXraKxFcQcFqJy++DoqevlrzjmJoW6yB+WFEMNISqe6Wr6r9AQWrnU72E/vSmkISIfuODKS9ccTJjC1KrIHlS6A6y2z5stX7j3bzYKfnPGUBfGjROJOyiuQK2YSQ4ZpVFUH0z5e3AQKI8Rf62zKV4Hw4iShtwlSvQMogKL9oRHgGtQtyE7zQkSF9hZ2aspdDdjjQ9APZqu0iBb01WtpKgvHmgMAgoo1wqWNvhdGoVhmCaYNrK6Z3QOfpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h87qAQw503LW/j9dSqiDWktSUX03JdGscryuqo1WTuA=;
 b=NP5nBHBxP5xoRLCABgxa2QzmWmkGjzYjcDlxRXxLzFdsZBB3PrWjWkiCK3HuXh5JQVirDiMHzhhqEyFDaHS7kAd4l1ppSkGNxrDWZsqGeswbYa6uUZWwU2cBdfvJMCn5Wepn+WM4xnAavksifiwGMSDGoaAMs8280qE9nnARS7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BN0PR01MB7006.prod.exchangelabs.com (2603:10b6:408:16f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.18; Wed, 29 Mar 2023 23:22:53 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6277.013; Wed, 29 Mar 2023
 23:22:53 +0000
Message-ID: <cb61cb4f-c6ba-5a7d-bb36-61bed9c5dd56@os.amperecomputing.com>
Date:   Wed, 29 Mar 2023 16:22:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:610:cc::25) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BN0PR01MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d50270-db3b-40f9-1ed6-08db30ac84eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhLfQ2lzGhVeBn20Z1Mh0DZoHJg5TNJwfNBhNc7DbhnZnc4MmCmxi3EEnjpZIm3cJ+5X9o4XNexKHark4Th4fjTlKvD4KfbzO3oAdfmegaqy0UxyXgyxO4OQEx7lFeNuGm1CHeHuoXzLkt9ZXkBOQd/C7KwwNbOcz6vAfz6g3MTCkMxf1u4WqbCKO8OminIc2/pcXtKJ7GqO938TJvDKgmLGv62mlO2Fqn2GbSGNuROsoMslSgygfe2kAh3h+ju1J+ZaQ20oZakJTUqUM3UNmFhsnlVDJbOitUVUwM0kL0y5JFO/RWDvxyrcjnNtBbC+/JvKZj2SIgz/TG8Jm3RgjSqYygyPrGjd34go+Iym3w6us4MF4UAtCpF9cgCEuola4VMpT7hrrJCKSahkyn8TPMs5JZovPhcM1GG5pbCVxFvRU7p4QDM6XjVHjSLsIM/1B7M51IT5OwDtnmeGficGRiWaM9WRukrDo+w/55aSsRrK39dF3egxIoEoUmxTaSLEFC2UvpbtrW/APnmICOM48PsiaW4zPLcoW+5Z8Sirw7RyuIpi50KeqeMoazqKl2cnSoBo2oh5lCUzPDXSoeoBVwhXFujSypp4bNWCjQU8cS3BqWGNo6Wt3QD722fYgNNdpyZdPPqx1dyOub0QjIFWiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39850400004)(451199021)(31686004)(66476007)(52116002)(66946007)(478600001)(6486002)(4326008)(66556008)(6916009)(316002)(8676002)(31696002)(86362001)(2616005)(83380400001)(186003)(6666004)(8936002)(6512007)(6506007)(53546011)(26005)(2906002)(41300700001)(38350700002)(38100700002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxBdFRqeENqVkk0UGNMQmFDZXFKNElKS1QxVVNTUmp5MG5vMTVJV3JpVnlF?=
 =?utf-8?B?Rmhoc1hmWnVnekd6ZnRwbDB3WURHT2o1anoxOHBwL3lXK1cxbis5VnEvTnZF?=
 =?utf-8?B?MldiVmZDZzZtcDZ0bzNpc2lvNGJDa3VGRkdoRlV6cTRNaktjMkJUeVg4cThK?=
 =?utf-8?B?dmpGUHhsSXRESU1FdlNMMnRyMUg1aGw2eHFyWDlaWHJrWVJmYm1PVmN3ZzNy?=
 =?utf-8?B?ZUhKU3ZINUlmREtoc3o1aFNNSGY5SmZ1alFKOXJNMTJSL29xbjZHOFZhZ0tU?=
 =?utf-8?B?d3ZmQnRXN0V2cDE0WGJZa1hvSDZub0RQRXZXNFBxTUprZHpNbUEzclBhNUdU?=
 =?utf-8?B?bTFWdzVUM1RIUUhHbkFCWVIyYzlCSDlkb3VZbGpOcHE4UitmbnlnYXN4V3Jh?=
 =?utf-8?B?T09DV3I0bWtMMnYyOHgrZ2NLZERic01MaXNtdm1HRTgyeGxCbjI1UDY4WW4w?=
 =?utf-8?B?ZWFmSUlOa0dkNXpjNTFSMnZIN3RWdklmMm1BNzhvMS9rUGQyaTRvU3kzWFdH?=
 =?utf-8?B?bjFjcDlMZ2hqWWJlU0FiWEU3ZWpSczhXc2lPekVlb3lucWEyYVhzNmNiOTZM?=
 =?utf-8?B?N2gwcytIYitWclNTT3hpZ1I4N2VQTEUwMUQ5TXkwZk5jTEFCQ0Q2Q0x3Zmxq?=
 =?utf-8?B?OFBYRWd0S1F5ZFQ5Wll2SUh5eERQSjZ6QnhMQklDbXhpMXhpQjUzRTZXdi92?=
 =?utf-8?B?VkdFY0VwRmIrR3VMT0YrdTR3SGFBTVRYWlZDYkZnc3E4UVdlQnV4STEwakJU?=
 =?utf-8?B?RWk3SzMzNDUwUlRhazlzQlBYY1IyYUJaeWtBMnhlZ0Q0eFA3NFllOG9PZ0hj?=
 =?utf-8?B?UVl2TFl3RlpjK2JFZnlLcFhaWWtsN1BHUkNJOHRyamN2VkxFckpNTzhIZVJs?=
 =?utf-8?B?U2JCSHNISGo5QVlOZzFWRGhGbmxzZ1dWQVFrV3ZOc0NRUUM4aXMySzBQWGV5?=
 =?utf-8?B?TUgzaThJbE5MQTNtanpjaEltSnM0QnZyMWcyVnBPdmNmclIyNkxSa29ialZR?=
 =?utf-8?B?OGdlOVNZZEtwbVZoT01CalBBQ2czb1htMUxjM0NKM2p0RXBLa29yZnc2M2d3?=
 =?utf-8?B?L3VVYytUN1FMWkpOZDNtSjhKQ1gwcWJxVU5OTmpTNXhYMHpIdjYrRjdPenI0?=
 =?utf-8?B?OGZldDVtZGV2YzJpTldBVGtZYUxGNkZrQTBKS2hBOHRneDRybElJR29DRm9S?=
 =?utf-8?B?SkJGK2VWV2dvWmc2QTFPV1FsRUJWRS9ON29Ycmp5cEoxSnhIZi9qSEV2MTc4?=
 =?utf-8?B?ZUhubWp5aWlvQTBSZU9IN2NDMnlSdnIyQSs2TWtYTjc3Y2tQdjcwSWw4RnFP?=
 =?utf-8?B?NnFKNThUMGlCczZtZVEvWHo4MVpFNUVnV2UzdEVuUnA2R0JHd2pNcWlnZUN4?=
 =?utf-8?B?L2tlV1FkRng2Ym5GRy9sMXZ4QWhUWXJHdko0TTlBRUVUeHc4dks3OVdlRmxD?=
 =?utf-8?B?V2Q5WXUxaVMxL1ZyMFduNFpDMU9ERU1ia0hZdGN6UVZ4RzhlT2FiNi9idHUx?=
 =?utf-8?B?VjNJYUlPVlI5NnRqUVlmeVJmcUhZaGZqemJiRmRUSml4U1U0TGYwVWxEbTIy?=
 =?utf-8?B?Q3Q4OTk5cDZZU00xRTV0Vm40T0pOTmtQa1A4eHVJTzVmcmtGK05obVhoOWEx?=
 =?utf-8?B?d0RSZEpZV0dLVHdGVEhMSVJxbTZWaGtIVklUZEZaS2dvS0Y5RGhlL1NIOVNM?=
 =?utf-8?B?VHBPTGpEMWdWN2NBc3RBcjU2MEdJTkJpVDJiVjN2SEZGRjd2bjJiTFVzWHUz?=
 =?utf-8?B?TEpmb0U2R2RNTFBaaCtBK0xUc2pmalEwU0VSc2VHSjlmYll1TExkLzV0MjRW?=
 =?utf-8?B?L3RzREhWaW14MEVoQ3JINll6TGplMlYwWUIwZ01mUEhaWTlTUEovM0c1OXEx?=
 =?utf-8?B?UGNDKzN2MThYd210OGY0bWVnbFR0ZnlkU1BWdVNlTVhXYnZkSzU1ZnZrWDlQ?=
 =?utf-8?B?eFozdkMyTWJGWGZneWtCbDMzNFVBSjNDWmcvc3VIek1EM1lVMXZYVDRiSFZz?=
 =?utf-8?B?UVkxd01OVGhCSnVyMTZtUm9OMzl3Rk1TZUxGYjRSWFhjQ3ZFR2xNeWoxRGZG?=
 =?utf-8?B?cDJFZmNFT1hqdnRHL0s3UjU0VThKWVZIRHN0V0xGaTM2eHRGNjRQOWZHc0ph?=
 =?utf-8?B?K2F6aC95SmttRmN3OXBWVmJRRENwbGZCOWJPUjlHbS9qNVFYVXRiVy9IR3pa?=
 =?utf-8?Q?oRdZflNh4Cz9ijcDdTqn3D8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d50270-db3b-40f9-1ed6-08db30ac84eb
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:22:52.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ0OGID9Hrlz+1HojgrEPh/KANZsUJWtdpgs6ROXtYUuUbRRlvMi6CnQpOR9fASwbRyrmqgPIcUpq5KdEj3Dp3A866Usgb3DaE+40TVtsDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7006
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>> When testing CPPC cpufreq on our platform, we noticed the error may be quite
>> high and the high error may happen quite often.  For example, on a platform
>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
>> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
>> seconds) in an approximate 2hrs test.
> The description above is a bit cryptic IMV.  For example, it is not
> particularly clear what "high error" means.

The max freq is approximately 2.8GHz, but reading cpuinfo_cur_freq 
showed 3.x GHz ~ 4GHz sometimes. The error seems high.

>
>> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
>> below is the results.
>>
>> 100us:
>> The highest error is 4GHz, 22 times out of 3623 samples
>>
>> 1ms:
>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>
>> 10ms:
>> No high error anymore
>>
>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
>> high measurement errors.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..c2bf65448d3d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>          if (ret)
>>                  return ret;
>>
>> -       udelay(2); /* 2usec delay between sampling */
>> +       mdelay(10); /* 10msec delay between sampling */
> This function can be called with interrupts off, so it cannot spin for 10 ms.

I didn't notice it may be called with irq off, if so 10ms spin sounds 
too long. Is 100us fine? It can't eliminate the high error completely, 
but alleviate it a lot. Or any other suggestion?

Thanks,
Yang

>
>>          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>          if (ret)
>> --

