Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8266D6CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjDDS5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjDDS5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:57:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2103.outbound.protection.outlook.com [40.107.96.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24216170F;
        Tue,  4 Apr 2023 11:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV8OmSjwWRIeSWJOGOx06K6rRPXdLUnTX38zeoZlQkFKXIWx0xTp9I9Q9cciwCXvuwTOwsQZZ2iwBn7daooQEjsjoNa+T5A945fXgW4fdiv0C3IbxH1SJ5JFKImgaXBNQs8TWtVY0ZTZy5rAY1FsnLBz2dW4QrD/JLwhdelJn9rGuCs8CzqN44nrUwtvJZlYmfW8heiNC4G3TVtgt9wlfwzcnaApjuO8rhIHcSBrRId+S9N47wOQTtQO6PwoTUry/c/z4ILBKu/q+IIG1AoQqpk1jRPrUgtZTDhcIKNv+PpIEDNQHMYYp39DHpKlZTfIDOvOHFvSAEwcNpIy7UKpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqEEG/U1y00cjajC9P+2bXVLEHxCPNdrlc7Ld+zcmlA=;
 b=g7aNfrpXcimERESEGVwoj7Mz/EDkwg6/hPIQ/8KToiA/8XI9oXggoGb2nOgZRMvSkJx48bf2RWE5746sy78zyZNiq0IL8vHR1xCv6GHg1mAxoOAmUzNErIYhdcQVIDxSJZvktIm3zHgn3DGsg8ucNN4Hdez6PMz2i93E3AOSkmaT0qOCh9nAaY6CF6I28EbmN3BkKvsWcY9ReIudiTfhLAxjH58woRiOs3zjrS+lbAzdneiLW9X1RbUwTkx7T7AbJib8fnU1rrwKVZ7he2jU032Qc70AHQ0Av6Xj5w+XZuq99RJ6lRbl4n8pha8Z2tdfSvvbkHkXhFWH6/KqN6b4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqEEG/U1y00cjajC9P+2bXVLEHxCPNdrlc7Ld+zcmlA=;
 b=Q0D3DeShsHKFH+BRgb28haW1MzwfrVAKg8a5IZNFG/KS1dEkma95pBZ0jC6jvla/p2zX9y9I4/CLak2TODYYJN+Z/QXg1HFziGN36HTD0tZXswrDPuTaoCm4gPFLP8SycKwoiuPILnRGPKftsfJhYmzzast1KeF6TLN/IKZaa74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BY3PR01MB6516.prod.exchangelabs.com (2603:10b6:a03:368::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28; Tue, 4 Apr 2023 18:57:36 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6277.028; Tue, 4 Apr 2023
 18:57:36 +0000
Message-ID: <29f6d4f0-9844-efcf-5fd9-03611580afd3@os.amperecomputing.com>
Date:   Tue, 4 Apr 2023 11:57:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rafael@kernel.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, lukasz.luba@arm.com,
        ionela.voinescu@arm.com
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <20230330035612.ekh2lpqzohggg6uf@vireshk-i7>
 <b9e94d15-ee49-aa8c-e0fb-1243a91825cd@arm.com>
Content-Language: en-US
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <b9e94d15-ee49-aa8c-e0fb-1243a91825cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::10) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BY3PR01MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b9731a-b8bd-4c2b-b10a-08db353e743e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwI3GifoZ80RgUp1s+aonXVdIHUegp3TBhTAx61xgLQMwmyltZZ9ORrtQWH6oT9tD+HB8Ke9kp4gCNS+Ftd8hhgoMo50MUu9U4p2+Iyxyv77TEENIXgOI84vbj9WoP9NEkO4NxFrXk92EYFSgKckq24BZM26xYtW0xhLB5Us0gTGLBis+JcDC+wILSYgo9apCf3jsbmBh2rFAHbB0ToG7CXRkPduFoY527vWeDjaObxfkEOaFQf1P7dIj8KlmTe9LmObksQGDWPBTpDx1nFrKz+BqRQLVoyqfNPwPLxVRExeOAL6HRTSlqj/rx7Xx8S3KORQ8xEmDtcxo6OPbOTUV0r0njg2kQnziDeHkmSpKwtXCOhFzJG/alk4kY8CbgZw200ls+1MgLsVBjNXejGw1CIZea0F9ookpXP2uyVLP39im8sXeh43Mf0+vUDZtgEE2DmBRsUIB0vZABF+A5ultslQNj7gCQ0RrF0a1oXboRkgtAEVipIAnkk9I9+lha6oTjOZNBEa/aCwxdUeAjN5GLLOHNrsIsQFBgmz+1xzLncJbgJLmg3XBRnbmVLQNjpa8hK7TfrdR6M+BzV0We6AuYK51X5KCL3NbfD1cmEKPXBqpOzkV4AacKUEEAiCJH6NpV0GNCmGncAaYjyrUybAEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(346002)(366004)(136003)(451199021)(31696002)(86362001)(2906002)(31686004)(38100700002)(2616005)(6666004)(6486002)(52116002)(478600001)(53546011)(186003)(83380400001)(6512007)(6506007)(26005)(4326008)(66556008)(66476007)(66946007)(41300700001)(8936002)(8676002)(5660300002)(110136005)(316002)(38350700002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdCdUphV3dONzdmeEdGNFl6ZjZzeFFDcldSOEJ1K3QvTmJJT3pyTVJYenZO?=
 =?utf-8?B?dEc4REJJVVpLejV1VjBJVERnWW9aQ2k4VHovaWZqcW0yemhVL3U3T2tBZzIx?=
 =?utf-8?B?dGwrbWtYa2NNUXh2Rk1CNHdlZG42b2JVZzBwMEljbitnWVV5WkRwVGorNWVR?=
 =?utf-8?B?QU9XS0txUktlb0hsU0RnZWw1NnUxMCtSMkgxMU90ZURBKzhOa1VkeE9nOFFi?=
 =?utf-8?B?RWNPOEE4MlRBRUJHelBGdlJmd2lLeVBWMnZKVlEyV013UHhVYnVnZHZmZUt4?=
 =?utf-8?B?SmpyZkxvMlI2UWU0b1ZnOG5iYzYwVG1xTTlsY0V0VTdXcHZLdVJEMTN2cE9a?=
 =?utf-8?B?M01ZOWQ1TUY3NndUeVhLWGlaYVVES1d1cmdkWWg3QnVuNlVtTVdaakVTay9m?=
 =?utf-8?B?UXY5WE1HeFdzNTJwS2hNcjhQSGFhbTBCWFB4TWJ0K0tqQzd2QzZLK01DYUta?=
 =?utf-8?B?b3pVZGpuS2dqWWNGd1c0S2VMdC9VT3FpakxZZmFHSC9CZ25XVk1jSTRiMzEv?=
 =?utf-8?B?Ky9RaWNTV0ZySXhMSWVFOVhaQ0QrY3pvUktwSWdsU213MVVaTWlXbzF3K3hv?=
 =?utf-8?B?aG5naTRmR3FVWTJlcVQvTnRCT0pnTTliS2s4L0RBZDVDSFFmeVR4OUQ2bGdI?=
 =?utf-8?B?KzBsSzNJYXpTMWZ6bGhRb1N5akt3VGhjRmNsc3luMDljeWZBNEpjYjQvdGJR?=
 =?utf-8?B?MklBak5lUVhlV3ZSUEd5ZnNkcGFFeVhucVVRbWVWMjFLZ0FEczlFTjl0NGpu?=
 =?utf-8?B?Y2R1QXVod3htbWxEdkRkdlV6dWtMdUlrTXk2VUJkTDB4YXhYZ2FnLzNjQ21y?=
 =?utf-8?B?Y25QVXc0QTBQM2hEaUhxcmlqUk8veDQ4REZtSUhxVGNFZUdEbmJub1Z1MStX?=
 =?utf-8?B?VjY3aW5HMXY5N1hZQXFEajR0a0puNVg3SjhQWGZPUnpGckdWcHA4QkczVFYz?=
 =?utf-8?B?MGZXc1BCNExNenFzd3kxRHFCN2t0aDR4a1Y5cmJ4WjVCNVFqUDdQOS9lZldu?=
 =?utf-8?B?L0JMMjUyT2xRL0lkOXoxaE5xeWs2WFduZFVlQUJ3TXltdHZZeG5mY2NpcFhx?=
 =?utf-8?B?b2ZmM1IzejdCVW82WDBzbXUwZWhWSlFwd1ZyVXF3ZERQbXgwQ2JYSWpzc1ky?=
 =?utf-8?B?WnZaR2RXSEdSSUZua25ZWHo4bk5UNUFuWUlBLzVnU2tSREJjL05ISHlSYjdr?=
 =?utf-8?B?MHE2NVdNR0VQWERrZUNPVzl3WG5DY3JmeXcrbjRsMzdSNXZ0VTRUcUpWNjc3?=
 =?utf-8?B?RUxiWlllZUxwbzZxbGNJbEkwWHBqSnN4RjhtSUdIcmI3QkxoUWN4YzBJZStM?=
 =?utf-8?B?Njc3aExSZ2NyajZaeFF1aDBNRkFXMm5lc243cUVyUytOWVphTVpGWktkTWxQ?=
 =?utf-8?B?dHR0ODNDL0FqeWpUYTFKLy9ZSXRQRGc3SHNucThsRVR2MVF2MGxXblZzN3Bt?=
 =?utf-8?B?N0lXeUZ6ekhKY3UwZENmUWN3Z3Rud3RiK0pIYVA3YlRHdFlNRlRoamNHT0Ix?=
 =?utf-8?B?UEN1RElramJYTXJlczVkMnI5V1p4THJNNll2Z2VhSjBCd1dWSW1jVENHdkdw?=
 =?utf-8?B?YTdxSkVnU3YvVlRZaU9GM3VqNGFRZGkxZGtuNjZEQktMcUFwNUNjQ3d6MXF4?=
 =?utf-8?B?OHFuS2pIK0w3UU1VMTcwSjZtaG10cEpNelhZazhsdEFqelEzdFJVZnJxMkVP?=
 =?utf-8?B?K3NOK0h5SXZ6T0lLL3pxcERTYUNHc216TzZmc2tmUytiRFlVN0pvTXBtY3Bm?=
 =?utf-8?B?eUpTZlNUT21zQUxOajkwWFVMd3pOVWt5NmZmRkx5VTdsSnhaa2xsOXd2STl5?=
 =?utf-8?B?VVYrczFqOUZUbnAxb1JHMjBDK29rZ1N4T0czQnZvMGd0OGFkUkZ0V0VURENy?=
 =?utf-8?B?ajVvKzlxVEsyaWIxSHJqM2VZWnAzZDV3OEx6STdvZWw5VkdHUmo0YU84OGc3?=
 =?utf-8?B?bndoRnQzRGFVR1AzNEtUMjlycWlqUE5JMkZxbGRpNFlBQkZFTlMxSnB2YzBt?=
 =?utf-8?B?b3krYkFLQWYyZVN5aGtTQlBTNVJiYTI5VDhIRjNnZkdpekRiTmwyeEZsTHNZ?=
 =?utf-8?B?TU8yOG4xdjRBZ01TUW9Pdy9tRUZYRlA0eXRFYURTY3UxSHo0SEdFTTJ1clVS?=
 =?utf-8?B?aU5CbmRKQkRoSFNqUVZpdVd4UXRiektocm9zdGJFcEdwWHNQaTBVOUZ1cWlI?=
 =?utf-8?Q?BxJjLkL61okTsd/2wWwizTQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b9731a-b8bd-4c2b-b10a-08db353e743e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:57:35.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRr1VgAoyau82t5JiP0ZnAU2QEsGnp/B1dHAe0Tz0NJYAtv3dySFxIr2HUbjlYhpYXrkje/svYysHGOGvJ2wYbk7pQx6utfl1Ev1NLyVyXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6516
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/23 2:53 AM, Pierre Gondois wrote:
> Hello,
>
> On 3/30/23 05:56, Viresh Kumar wrote:
>> + few folks.
>>
>> On 28-03-23, 12:38, Yang Shi wrote:
>>> When testing CPPC cpufreq on our platform, we noticed the error may 
>>> be quite
>>> high and the high error may happen quite often.  For example, on a 
>>> platform
>>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded 
>>> (100% load),
>>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  
>>> And the
>>> high error (> 1%) happened 256 times out of 2127 samples (sampled 
>>> every 3
>>> seconds) in an approximate 2hrs test.
>>>
>>> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  
>>> The
>>> below is the results.
>>>
>>> 100us:
>>> The highest error is 4GHz, 22 times out of 3623 samples
>>>
>>> 1ms:
>>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>>
>>> 10ms:
>>> No high error anymore
>>>
>>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to 
>>> avoid
>>> high measurement errors.
>>>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 022e3555407c..c2bf65448d3d 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -851,7 +851,7 @@ static unsigned int 
>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>       if (ret)
>>>           return ret;
>>>   -    udelay(2); /* 2usec delay between sampling */
>>> +    mdelay(10); /* 10msec delay between sampling */
>>>         ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>       if (ret)
>>> -- 
>>> 2.39.2
>>
>
> Just 2 considerations:
> -
> When using the schedutil governor, frequencies should be updated with
> a period of cppc_cpufreq_get_transition_delay_us().
> This period should be 1ms if CPPC doesn't rely on PCC channels, otherwise
> the value depends on the PCC channel (cf. cppc_get_transition_latency()).
>
> If the evaluation duration for the perf/ref counters is higher than this
> period, I think this would mean that multiple frequency update would 
> happen
> while trying to evaluate the current frequency of a CPU.
>
> -
> There is a TimeWindowRegister field in CPPC (cf. enum 
> cppc_regs::TIME_WINDOW
> and ACPI 6.5 s8.4.6.1.2.5 "Time Window Register") that should 
> approximately
> match what this patch aims to solve.
> """
> When Autonomous Selection is enabled, values written to the Time 
> Window Register are ignored. Reads of the Time
> Window register indicate minimum length of time (in ms) between 
> successive reads of the platform’s performance
> counters.
> """
> The only issue being that we should be in the case where Autonomous 
> Selection
> is disabled, where the description of the register is different.
>

Thanks for the points. IIUC, the delay should be limited by the two 
factors. So it should be max(cppc_cpufreq_get_transition_delay_us(), 
Time Winder Register)?

> Regards,
> Pierre

