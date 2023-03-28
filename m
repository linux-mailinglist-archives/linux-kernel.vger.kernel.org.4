Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF76CB84C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjC1HiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjC1Hhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:37:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3640E3;
        Tue, 28 Mar 2023 00:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si7h4AjwjcafVGtXPZjKebLv3dU14a8F2cXVn8+Jsq/NJcSgImG1liYx9NKL8yAzwJaE/OdOm2Vyl3OnGDVJLl90vzb34j+2ZNM3UnpN1gP9G0yPuXq3gdaUYm9CVXp9xY0zvjNwLVDOKgGSxkES7i+9wc9hxoX8xGPQiAU9NS6vAyN8IkwCZbnhag3VSPw+0OXD2lcda5dPuIbV06HrBJaIsfV9tK2+uxBL7okGnLSpfqEhwk4njLc592JyCtdi30oXis4F2sz9OByJuST0YMZGocrRBFwOW5aDctR5ebLJ5lwt6AWQW3JcPAWkMHtxe2qoZzE4nPNF4jJmMQFp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU2xXcs5kdtqd5uXrIaRVdV9uzPE5WUJXolVwcAaWFI=;
 b=Wi4EVYmTyMP0DfJWDIlqzX6TRi9xkyNpgpj4HtcHNHLrgsYgGkv8PWkY9cLflC78KTqDSTw1CeAHbaBSEtAH2w2qd7HUGZE5wg6XpAi+PGrsLUFaV6HUAJ0NrOVpBZSsii8NoMBT7bDG4PQE+rifT/JWfiq22Vxy4cDpFAiiDiTlidcgxr9u40pkDH76hmjcWiOjZ9HUC5K4PNjeIwncWvGQcxx7qwt+/jFZzyeFRS4+fklUsr9eOStFWO1F7qBqZ1kYYEaubxvQQ5V6pu2NaYNUyVzEkH+7vgO7EGJ1Lv9HV9/nfxufliXMzAB+FBvK2hsz/tZEXu7TyvYj2qTTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU2xXcs5kdtqd5uXrIaRVdV9uzPE5WUJXolVwcAaWFI=;
 b=xdzdHoAXI2j7hIgDAfnOLoNSjCppmJ5vbZZs1u/LD1yX2fTF560SsTfTXQdmoudIj+w6ENmRheknwNg0GmeaKfI0IwgF6DSD8XU8F0xXn8exuliv3WC5UgoOh+KeptwWMikCnOgcE6macWsAw7SwqQuwFAjYr7rl0zdEexH8c6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:37:16 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 07:37:16 +0000
Message-ID: <6c37d6f5-95d3-71a3-760f-68be535cceab@amd.com>
Date:   Tue, 28 Mar 2023 09:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] soc: xilinx: Use of_property_present() for testing DT
 property presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310144725.1545315-1-robh@kernel.org>
 <c6a5dc7f-46bf-8f1e-0a9c-2614d5f1824d@amd.com>
 <CAL_JsqKy7qWDkU3z1p0oTn1umLzWchKw86Zu8mKzugDWQXJF-w@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAL_JsqKy7qWDkU3z1p0oTn1umLzWchKw86Zu8mKzugDWQXJF-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 285b1775-bc24-451d-090f-08db2f5f40d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0jXf+ub9skz6YODmNeumHiRRh9tyZoCyc6UcQfskSWc2z0J/ODhCLrp0gwYOOTOO6odIWtIWVd96YZSeFwJnBRj2apCTaYgRJ6QyE/4nPJy1Cvj6Jjub+UIC51eGqrBVxffABwni6+1NcO/d0tBqcwV9VRNq8hMAV0i7KWywcFJgtcJ/FIL7jcmwgt5oEyUr37VUHURNlEGDeBLqhjiDxSMbM/ugY0kq+utbwcLIX86fXD6dWrHtk6/jxLNb6noiF5akVQXWQhZK+k7ChMHzp7TtAW0VCdq7bTwNEtzY4GwWEK4X/baw68xIM1KFWHYivLiIyBrVjwLXCb+tGpoQTQYu8Im10G7l1f9b6vQyXIudy53OzauLnPCkOTWGO9glekA28JwcWmmGSTVv2dYNMefr+WFJ3XxNlAdyXIQ+wpUZ06wkjjAc7xVjlFDywysUUWEL3Qe7TjJgfBb/8pX9pJ5Wd6/nCuICZTCO6LfQIpa1rzf2w8qn9LAhoYKoLl5FO5dpmpTvol6O1rB877sJQLJ0aeAUtMTkW+05srO+kQ9oI6Je6P8hEWXeLGrqhTvQ5wL/Ewg0HbAPseFiLSkTzj6und5W4+hVVwCQMCHj6sh4hydy/38WyPox1besTFZF7mJZATeXcLBYiDCeBrBBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(31696002)(44832011)(36756003)(2906002)(31686004)(26005)(6916009)(6666004)(83380400001)(966005)(2616005)(6486002)(478600001)(66476007)(316002)(4326008)(6512007)(66556008)(66946007)(8676002)(186003)(8936002)(53546011)(6506007)(5660300002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGErNDJJOHVkc0w2dXdwMTR6aHdYTDFjMU0wNGxVSlNrMTM0S2p6a2sxdlIr?=
 =?utf-8?B?ZXVWTDFSV1c1WDJ5Q0dPQVA3U2xhT2JCM08renpSenpzUmlGdS95TWUxK1NS?=
 =?utf-8?B?M1hFYTRJTjBoMG11aXdzSElzRXRib3dmbWtGUjVKUGQzaUJWRU14R3lVR3JN?=
 =?utf-8?B?Z3VpTW5odThQMnRaSkFjcU95eDE0Yjl4VS9GM2hOMm51K0o1OGlMWUt5YzNw?=
 =?utf-8?B?djhSczc5UG9wMGJBV0hTbTJqd1BTNi9iTHl6YUl5YWk2MTJEUlluSi9jNkhS?=
 =?utf-8?B?MWNEOFV5NlcwQjBkekl2d3ZKa1RTbGJCS0FXcU9tVWpDOGpxYndySkZhVWI5?=
 =?utf-8?B?QnBMeDdDTEkvVXUrdmJaeXhqMDNvUUM5d0ZaWUpGL2NHa2p4NERpZThBUFVx?=
 =?utf-8?B?MWdVZVJTVmRMUS81QWxIK2VSSjk5M3k4Zi9LeFY3SU5uUzE2RVh4M0pQMWFE?=
 =?utf-8?B?eHBxTjZ3MWpSRGNocEtXOVMveDJOZi8vbWg5VFVwV1pZNnJuSXJoa2QwQ0Jp?=
 =?utf-8?B?aWtPTmpvTjZKMVhZbE1iZ2RXdEcwQi8yK3ZTMEFjc2RjMWNrcUU3aVU5cXVF?=
 =?utf-8?B?eEc2L2lKTUVaRXYwQ2pWbDA5Z25VS0dKeVpWUG9MQXRsR2drMTRReXA0RFJF?=
 =?utf-8?B?dDZ3Wjg5V0JKVGZvY3MyWlpEVklEeWxWcWprTEhNdnJDSEJkdnNTbUdYYWkz?=
 =?utf-8?B?NXA3VjVuK2hsMXFJR0NmR3p3SWM5RERYL1JqcVphaWhTMkpwMWVEZnphSjZK?=
 =?utf-8?B?ZHZPSWd5bFNsRzhuOWt2ekV5NW5sd2hDZ3Y4TGRyRURLcGI5RlJQK1ZxSHla?=
 =?utf-8?B?SmgvMUxYcERBN2htelNtTUc5Y2dUcmFpQkRheU9vejVnSWpXSm0zZWErRXR1?=
 =?utf-8?B?RXAwdllySS9CRS9YYzhWbjZ2N1k3VHJFbVQ4c1BaVVEydktlMUJ1TWJhVzl6?=
 =?utf-8?B?OFkrQ3hQWkRHU05RLzZnSy83TzBpbGNrSitGdVBqYVpSM3F5THJkSVRoeTA0?=
 =?utf-8?B?OERFd0VkSlVvL2QzSThQcTZvOFpUU2lXVU1DS2ZJRE1LU2MwU0psTi81TlVl?=
 =?utf-8?B?TjRNMGdPMHAvRFpOdlgrMkJXWTYwajRWREc0TCs4L3pQV1lHUUJVVWNqOXBG?=
 =?utf-8?B?WlVMQ3Q4L09DazNnSlNDSnZaUkZtYkNLOEVrZ29SRkEvOXdiK0xvck80NjVx?=
 =?utf-8?B?dDh0QjV6RGhueVVmVWRCdDVRRlRmRy9ka09sbnREM1F0UFBNS1o5OS9tTldp?=
 =?utf-8?B?ZDV6RWZtcHMzeVRERTRicFFTQUtTN1lvbmVETkpnUngwSm9KV2xqWHRDdzZa?=
 =?utf-8?B?MHdqVW1PYnBLdGpkTTErYVQ5VHlTVGo3amJmKzNoRjlVRllIN0FQSXcwaTVl?=
 =?utf-8?B?TkdMQUVuSDFiNUw4MVlaNVVOMFZGVHU0YXhRT0RyQ3FjSnVnOUlsU29HWUJE?=
 =?utf-8?B?WmFiTVNaRE5xbUpvbUZUK1hwN2VmdHVKRS9nQkpkVU80Wi9aemZvajh6Zlpo?=
 =?utf-8?B?ZTByVGd5eUZkaFBtaThwV29xejllaWQ3MXBZU0NVVyt3UGhXRUgwditrTkl4?=
 =?utf-8?B?WGZjY2dLYnh1T2tPOElIV29HZ3JXejVvQkFrMjZseWFyd2M0Z1BWTlE1eHJ6?=
 =?utf-8?B?TVk1U1dWWW5WcW0xdWxabjRKU1JnSFNuS2FISjhtRG52THA0cGhITWtZaHVR?=
 =?utf-8?B?cTZ6TUM3V2JTamJkcmtsa3NyWWYxaThHOU5CVFoveFdvM0w2VmIwTG0xMVFV?=
 =?utf-8?B?T2N5c2ZBbjlnUk44VFZzS3RsMk5hR0xnQ25hazMybUR1a2ZFdEJKMVRpVUhI?=
 =?utf-8?B?K0RyQVYyN0RpY2VKcWd4VitTRklqeXgwTWZ2RUpyMEJYQ0J2SjgzYW5uS2g0?=
 =?utf-8?B?S21VcEoyNGRGVVVsUE43UjdOWkNyWGUvQnVnbHNlRGp2dXA3TjdZemVVUmx4?=
 =?utf-8?B?cTFrcjU2ZWM3UlBTenpSVUg5NnFGeFI0aThnR2owRUhRVUpxalZEb1RwVXNz?=
 =?utf-8?B?VEtRdWFnM3cwRUg5Q3VwaE1LTFM1dk95RndCZ2hNdlZrc2Z3VXdiVnNFeita?=
 =?utf-8?B?djVkMWlWVmllRCswQnZidHN1WlI4MUVaZ0RLRDNGcFBUeVJCVU4wMWM3WC9m?=
 =?utf-8?Q?+tIMZtF1FtiMuBLdRuHG0/0Lm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285b1775-bc24-451d-090f-08db2f5f40d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:37:16.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iO0qKMEbKH2LnT9mOByF4yBaHOh3BsPT7Fh5uJZJj493LAx7Y2cP2/n9w/O5HQFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 14:23, Rob Herring wrote:
> On Mon, Mar 13, 2023 at 5:19 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 3/10/23 15:47, Rob Herring wrote:
>>> It is preferred to use typed property access functions (i.e.
>>> of_property_read_<type> functions) rather than low-level
>>> of_get_property/of_find_property functions for reading properties. As
>>> part of this, convert of_get_property/of_find_property calls to the
>>> recently added of_property_present() helper when we just want to test
>>> for presence of a property and nothing more.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>    drivers/soc/xilinx/zynqmp_power.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
>>> index 78a8a7545d1e..641dcc958911 100644
>>> --- a/drivers/soc/xilinx/zynqmp_power.c
>>> +++ b/drivers/soc/xilinx/zynqmp_power.c
>>> @@ -218,7 +218,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>>>           } else if (ret != -EACCES && ret != -ENODEV) {
>>>                   dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
>>>                   return ret;
>>> -       } else if (of_find_property(pdev->dev.of_node, "mboxes", NULL)) {
>>> +       } else if (of_property_present(pdev->dev.of_node, "mboxes")) {
>>>                   zynqmp_pm_init_suspend_work =
>>>                           devm_kzalloc(&pdev->dev,
>>>                                        sizeof(struct zynqmp_pm_work_struct),
>>> @@ -240,7 +240,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
>>>                           dev_err(&pdev->dev, "Failed to request rx channel\n");
>>>                           return PTR_ERR(rx_chan);
>>>                   }
>>> -       } else if (of_find_property(pdev->dev.of_node, "interrupts", NULL)) {
>>> +       } else if (of_property_present(pdev->dev.of_node, "interrupts")) {
>>>                   irq = platform_get_irq(pdev, 0);
>>>                   if (irq <= 0)
>>>                           return -ENXIO;
>>> --
>>> 2.39.2
>>>
>>
>> Waiting for v2 because of missing of.h header reported by lkp.
>> https://lore.kernel.org/all/202303120017.BIw01Y21-lkp@intel.com/
> 
> It's a false positive. The header change is in v6.3-rc1, but 0-day is
> applying these to branches not yet updated to rc1.

ok. applied.

Thanks,
Michal

