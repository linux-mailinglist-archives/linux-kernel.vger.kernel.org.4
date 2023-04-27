Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E646F0D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjD0Ukc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245540AbjD0Uka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:40:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2126.outbound.protection.outlook.com [40.107.243.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A343C31;
        Thu, 27 Apr 2023 13:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNhfCyFOx3GRjWojDDWNQcgKHxvPuSBDgKXYdBvCMtZ2XaPe9aajfrOX2VmmzasjI+1hD9kjdwwD8/nkUEDpnBP6gbOTTyBuh26w8/Sgw9CX4U/HFpe7UmMaZmKdTjXjA6/eg7TVrt4xsHL0O4KYnUJU0oyzgjJ8UPsfgzzOF4oiveft+PP48IWJvbkd747lBa4fGvD641L37g4/13AfglZsBRW4K8cRpHnA/dqwdpbgTXUHwcaCziIZFn4Lyzj7XBd1vyXStVWTIap0bl6Bg002zP4KVDTKgjjV446aK1gZNvfRc+gbLWtnczBBenx1rGsIF7GxRx3UtgXwAuJsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ2sNsZYzPt8HWn0gQUOQI9w6WgtnB19z41NUC3reos=;
 b=czF2bkEovjUY4IjXXCAh3vaNfsVnZ2+o2VypErW6K1n/5BVLsn6eodD+c+TjrIRw9KHJHz/fH+CDgolYTazfRu7ZhPg38MNCVwUI30hUAQvvCA4girvoOV1ce6oHp9VoLMgHGFpm9UVHgbw0c4FA7u8cbCxVUUicmtrSnloyPMin3vskdUc7R73YuO6YZnGkV59c+tflqudjJMaq+xYYQ4x3LDOgQyUK1Qav4wJtGJX+GreQ/xeB4xDUaecJY6iCJ1FaW3YkUtM5k84rqioHSXHjg9EuIuE1MckOyd5mrgqXkCjcwFg725A08+v3PFoulbek1j8yiE+IY6dXgZC5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ2sNsZYzPt8HWn0gQUOQI9w6WgtnB19z41NUC3reos=;
 b=Sip39HFRT7OTtGND+fGoznq3dzWD0/MSi+I9D7E8S+Jo5AMoC6VCetLFpFMIyQZkktnSeKNqD5RspXr8BB36qr4Wa3f8g4rmU6l1vVbkZhDudRNE11ipoEuSiUJtomMISipI+eIHF6dBqbN/TnKTxytqK8Bhhf2zjHhB/Xc0AB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 SJ0PR01MB7414.prod.exchangelabs.com (2603:10b6:a03:3e0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Thu, 27 Apr 2023 20:40:23 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 20:40:22 +0000
Message-ID: <14ab4f0c-4789-a1d2-5b01-c3e0be9a823f@os.amperecomputing.com>
Date:   Thu, 27 Apr 2023 13:40:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, viresh.kumar@linaro.org,
        scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
References: <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
 <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
 <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
 <f0fd057e-95cb-4a85-00fc-9eb25ef7b9b3@os.amperecomputing.com>
 <ZEZrnWUc2y0w9yY8@arm.com>
 <06ca8066-fce6-d3cf-db37-584c3666f7df@os.amperecomputing.com>
 <ZEl1Fms/JmdEZsVn@arm.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZEl1Fms/JmdEZsVn@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:610:b2::15) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|SJ0PR01MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbcdd3c-8918-4a4e-3322-08db475f9f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LHP2i/DZXmAIQIfp5d/4CuE1+WuvZX1r2zRW2VU/PKRhVaj6qrXrE6PeqtDSvWnP3er0NLMCkBZOS2053391r8BRgDIhC1XOT3fogm1CWGzJV4nq5kEQbdKv5AXqT8PjKYcHBv7mEThXJC/mVfbqweCZTzgcO7JIpaCyKaKZbp2o49AKt5Oa4xrEKOtYYGB+I7J5uBtoSq2sOjh1QxIz8Stx1zWyMWLDGwmtExbCLsLnzSWVHkAdKH+iFYAWnmTbVHBImBnTB+kB+NOZV35bl7DHHj6DwcdJUdWvpAM+REZGzaJwg4ymArGxGGOwWQtOZ36LrRWcRIrrx9WTHtlA7WNv15kjiO5zDooeQEQoYikLpGlqIIUtHX9ztEJtKQNgoIZRUR2s88kstFiOn8VgWlQujaj5wUKhMU9Dxj4TabAl2BDPiGazNd6yU4t66TY1fbW9ibYOs+PxUzK91THkiUmkikShhHnCZjFhBimnXtcQrmCjjvWaIxXUPg+WgI8Edq/bWOMj33d5IbTsg/Pf5ixaOlHXTnY5sCQX5chA7amQm/fLjVSt7GKn3K5NMKhzSOBrAO5S833fG/OLzKSzJVr2ks39Dc3Kc2vks+PJcL8HQG4qcdhm3YnInSVSa+H1l6WhqcAJ310gevB50IdgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39850400004)(451199021)(31686004)(53546011)(966005)(52116002)(66556008)(6666004)(4326008)(6486002)(66476007)(6916009)(54906003)(31696002)(41300700001)(478600001)(316002)(86362001)(66946007)(38100700002)(6506007)(6512007)(26005)(38350700002)(2616005)(8936002)(2906002)(186003)(5660300002)(8676002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um0vWDZDWG5EZmRmZnI3QVl6M1d6TDZFeHQwdGhuYW9NOGVHUGlteEhNejZE?=
 =?utf-8?B?RmtSbkxZbUdOSFg4VkFvS3FBbVl4azVXWmtIdzRtQ2N5Q0Q0enRoNDRBTDVY?=
 =?utf-8?B?cWJSVnhpSDNNYlZyWU5NSEFDeVlaRW11aldjUGNMRGFPSFdOWnVoaWxHZDhP?=
 =?utf-8?B?N1ZaZVNGbFVycFQ4Q2dpdFBMN2QwVzRtTENlSlpnMk41eVNtNG9ZWmozdkk3?=
 =?utf-8?B?NUtINTRjdjUvR1YrUlpYMzFxV0VFbmhzNWVvcGNNMncwTUkwR3dxaGlUeDl0?=
 =?utf-8?B?TXdldk54cDAwQ3JDNXc1UzNYS29qc3FwaUF2Qzc0M2taZTF5SVR2S2w3QXhX?=
 =?utf-8?B?dUZHUWtXRFVETWlkQlVINnQxT0FqMWM5R1E5NVp1bXM4WXBSeGxMQ1BKR0Rx?=
 =?utf-8?B?ZFZTenNKcG10MEpaN1kyQ1M2WmxaZnNUbzR6Vlc2SGtZR3ltajZaamxlK1d5?=
 =?utf-8?B?TUhRQVFncGZlaUkxdlpsbktMY1BEZzdBRUYrQ2JqenlCWldOeTcrdHZPMXNL?=
 =?utf-8?B?RFVOSUpPZTlmMThEbVp0ZDZCSU9SMG5DbjFFeFJEVUNwa1lWa3hxeWk1Mldj?=
 =?utf-8?B?NXlkeFFDSWpOQm1qN0pDQzhyRHlmL2swSTBYOUQzc3JtV2ZUa3BpMTdZNVlQ?=
 =?utf-8?B?Smh1SVBCWmI1cGlFek5XcEJCc2VyV3JZSEMyeUV5RjRVaDlTM0RSNnNMOWJx?=
 =?utf-8?B?M1F2YllMdys0VUN1Wk9lNURid0NRUnYzTm5Ec3lJVWxJM20rdmRaWnMvVEJ4?=
 =?utf-8?B?TlhlbWt5cUlKQXBVV0FZRFpIZHk0azQxVHFmLzJ0U2VjUlZHbGJJRG5nbDNm?=
 =?utf-8?B?d3ErbzRXY2pJSTZjb0VIYmQ4Z0hNWW9SeE03NTlTT1U0MmlJVnE5WnpOWHpG?=
 =?utf-8?B?Wm1lM215cmZUNXQ2RnBsYVc0VUM5SytpYWRxTzFlbzluTUMzQ280UzAwMmdS?=
 =?utf-8?B?SWVYOC9pQ05oSE13OGtKcWljdlNOYyt6dWd1ZTB4RWwyODhKdkhqM094S29w?=
 =?utf-8?B?RFc0WmxGeTBmTWxaVGRuNjhiTzhnSGEyN2wwTThLRUtpWWV0ZGluLzRqRFdo?=
 =?utf-8?B?Sms2TUxXZVJYNnBUVXVoVmRBMExWbjBLV3pDUk14U3VnbVk0eWFmM0sxS01j?=
 =?utf-8?B?L1Ayay9pOXpxanNSYnRtRWVCRUF4YXZjaHdWdU1oWWdqR3FnWjBKOEdvbTdU?=
 =?utf-8?B?Q0pleFlBYk5oNmRxaVVDT1NFVm9vazh3Ymc1cFZoUnFxVDd5NU5IMFZZRHZI?=
 =?utf-8?B?aDlmckx2Sk5rbkFzbStOMHRnMGE4RVBLVmU5cnROQkIyMndJMkE1clpRT3N5?=
 =?utf-8?B?cWw5d2RhWkNGNHNBaVNCNUI3cXgvZlppUHVJdkFQZnRmcGxsNi8zYnhVSndn?=
 =?utf-8?B?ZHVEQU5lNFJjd3JkcVZiQTZqdW1Xa0ZQd1JnbWFNbnFKcC9vanVYU2tHSk5j?=
 =?utf-8?B?azFueVVFN2dYbEgvRFdvTndUeHJ0dVlLNXIvZDRXYmZYQjUzRHNhcFhQdEJO?=
 =?utf-8?B?NnZZaU5HUktoNGxFTVltNlNZTEtLcnJVbUpxa2U0VnAveW1sQm9zUGRqTFRJ?=
 =?utf-8?B?ZTVlcFNLVmNjN2U0b3RHVVM3c3pQQ09qUW5iSDlnTHIzS09iY3N2Rm85MTE0?=
 =?utf-8?B?eGJpd0hPaWVDMlRoUEYxY2tTYlBsZ2d2RkJKNUF5azRZc0Vob3ZqdVozS0dN?=
 =?utf-8?B?M20xV3dWTFNpRGhyanhTbFh5MnFDb1VpQVEvSzEwaUlKTlFGUklEVmxpZXd4?=
 =?utf-8?B?OFJnZWxwUHBLM1A0YWhVeU1kWlg5L1Frbjc2b3JUcFRmVFVCMEpQVis3RE13?=
 =?utf-8?B?bityUkUyVGNrc0J4L2xBeG9kUWNReEZFM1VuTkZ1WjZmK1dpT0x0TWc5bmVi?=
 =?utf-8?B?MGF5bmUvc2hFa1lPNUdoQnkyZkUzVlNVTE5JTllGckZMZHBSTEI2a0pCUFlh?=
 =?utf-8?B?YVdJdS9RTzltVlJYSDVIZmJXSDN5bCtMZVp0Q1ZGWGVrTG1WTVRPemczaVV2?=
 =?utf-8?B?dzU3M3NJT2REQ0xzN1VocnYwWGxmZVJmN3BRdHFRYXRKbFk1aHdvYmZlL2tp?=
 =?utf-8?B?MEFydGEzc242RDJlNUhUcHFBa0s2SUN4YXJpazVkZVVCSWNrWGRsS1BSbC9I?=
 =?utf-8?B?Ymp1ejBBZTdZRFNkVWIvbnZ3ZkFNQndDemtJMThSQmRLYWJpc2l5WEtUakxO?=
 =?utf-8?Q?ZTeaK5seGdESnikPi9rWUb8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbcdd3c-8918-4a4e-3322-08db475f9f61
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 20:40:22.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrEeT+JWuOGo8uMXrvYXHQaRFQf/NpCuOuLa2HrO3SS7SRmawQK96+zLgjbARGhyVt6jFAZpBvpZE7Rwz1bpQT+HAQGkmW6152cTuHv1uHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7414
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/23 12:01 PM, Ionela Voinescu wrote:
> Hi,
>
> + Sumit
>
> On Tuesday 25 Apr 2023 at 18:32:55 (-0700), Yang Shi wrote:
>>
>> On 4/24/23 4:44 AM, Ionela Voinescu wrote:
>>> Hey,
>>>
>>> On Thursday 20 Apr 2023 at 13:49:24 (-0700), Yang Shi wrote:
>>>> On 4/20/23 9:01 AM, Pierre Gondois wrote:
>>>>>>> You say that the cause of this is a congestion in the interconnect. I
>>>>>>> don't
>>>>>>> see a way to check that right now.
>>>>>>> However your trace is on the CPU0, so maybe all the other cores were
>>>>>>> shutdown
>>>>>>> in your test. If this is the case, do you think a congestion could
>>>>>>> happen with
>>>>>>> only one CPU ?
>>>>>> No, other CPUs were not shut down in my test. I just ran "yes" on all
>>>>>> cores except CPU 0, then ran the reading freq script. Since all other
>>>>>> cores are busy, so the script should be always running on CPU 0.
>>>>>>
>>>>>> Since the counters, memory and other devices are on the interconnect, so
>>>>>> the congestion may be caused by plenty of factors IIUC.
>>>>> +Ionela
>>>>>
>>>>> Ionela pointed me to the following patch-set, which seems realated:
>>>>> https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/
>>>> Thanks for the information. I think we do have the similar syndrome. But I'm
>>>> not sure how their counters are implemented, we may not have similar root
>>>> cause.
>>> Yes, my bad, I did not get the chance to read this full thread before
>>> talking with Pierre. In your case you have AMUs accessed via MMIO and in that
>>> case they are accessed though FFH (IPIs and system registers). The root
>>> cause is indeed different.
>> Yeah, but it seems like using larger delay could mitigate both issues.
> Yes, there is a minimum delay required there of 25us due to the way that
> the counters accumulate, which is not too bad even with interrupts
> disabled (to cater to cpufreq_quick_get()).
>
> [..]
>>>>>> Yeah, we should be able to find a smaller irq disable section.
>>>>>>
>>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>>> index c51d3ccb4cca..105a7e2ffffa 100644
>>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>>> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>>>            struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>>>>            u64 delivered, reference, ref_perf, ctr_wrap_time;
>>>>>>>            int ret = 0, regs_in_pcc = 0;
>>>>>>> +       unsigned long flags;
>>>>>>>
>>>>>>>            if (!cpc_desc) {
>>>>>>>                    pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>>>>>> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>>>                    }
>>>>>>>            }
>>>>>>>
>>>>>>> +       local_irq_save(flags);
>>>>>>> +
>>>>>>>            cpc_read(cpunum, delivered_reg, &delivered);
>>>>>>>            cpc_read(cpunum, reference_reg, &reference);
>>>>>>>            cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>>>>>
>>>>>>> +       local_irq_restore(flags);
>>>>>>> +
>>>>>> cpc_read_ffh() would return -EPERM if irq is disabled.
>>>>>>
>>>>>> So, the irq disabling must happen for mmio only in cpc_read(), for
>>>>>> example:
>>>>> I thought the issue was that irqs could happen in between cpc_read()
>>>>> functions,
>>>>> the patch below would not cover it. If the frequency is more accurate
>>>>> with this patch, I think I don't understand something.
>>>> Yeah, you are correct. The irq disabling window has to cover all the
>>>> cpc_read(). I didn't test with this patch. My test was done conceptually
>>>> with:
>>>>
>>>> disable irq
>>>> cppc_get_perf_ctrs(t0)
>>>> udelay(2)
>>>> cppc_get_perf_ctrs(t1)
>>>> enable irq
>>>>
>>>> But this will break cpc_read_ffh().
>>> Can you not disable IRQs in cppc_get_perf_ctrs() only if the registers
>>> are CPC_IN_SYSTEM_MEMORY? Only spanning the reads of the delivered
>>> register and the reference register, which should have minimal delay in
>>> between?
>>>
>>> As in:
>>>
>>> if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
>>>       CPC_IN_SYSTEM_MEMORY(reference_reg))
>>> 	...
>>>
>>> This will and should not affect FFH - the fix for that would have to be
>>> different.
>> It won't work, right? The problem is cppc_get_perf_ctrs() calls cpc_read()s
>> to read delivered and reference respectively, we just can tell whether they
>> are CPC_IN_SYSTEM_MEMORY in cpc_read() instead of in cppc_get_perf_ctrs().
>> So the resulting code should conceptually look like:
>>
>> disable irq
>> read delivered
>> enable irq
>>
>> disable irq
>> read reference
>> enable irq
>>
>> But there still may be interrupts between the two reads. We actually want:
>>
>> disable irq
>> read delivered
>> read reference
>> enable irq
> Yes, this is what I was suggesting above.
>
> I've hacked up the following code. It covers the FFH case as well, with a
> modified solution that Sumit proposed on the other thread:
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 0f17b1c32718..7e828aed3693 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   				(cpc)->cpc_entry.reg.space_id ==	\
>   				ACPI_ADR_SPACE_SYSTEM_IO)
>   
> +/* Check if a CPC register is in FFH */
> +#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
> +				(cpc)->cpc_entry.reg.space_id ==	\
> +				ACPI_ADR_SPACE_FIXED_HARDWARE)
> +
>   /* Evaluates to True if reg is a NULL register descriptor */
>   #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
>   				(reg)->address == 0 &&			\
> @@ -1292,6 +1297,24 @@ EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>    *
>    * Return: 0 for success with perf_fb_ctrs populated else -ERRNO.
>    */
> +
> +struct cycle_counters {
> +	int cpunum;
> +	struct cpc_register_resource *delivered_reg;
> +	struct cpc_register_resource *reference_reg;
> +	u64 *delivered;
> +	u64 *reference;
> +};
> +
> +static int cppc_get_cycle_ctrs(void *cycle_ctrs) {
> +	struct cycle_counters *ctrs = cycle_ctrs;
> +
> +	cpc_read(ctrs->cpunum, ctrs->delivered_reg, ctrs->delivered);
> +	cpc_read(ctrs->cpunum, ctrs->reference_reg, ctrs->reference);
> +
> +	return 0;
> +}
> +
>   int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> @@ -1300,7 +1323,9 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
>   	u64 delivered, reference, ref_perf, ctr_wrap_time;
> +	struct cycle_counters ctrs = {0};
>   	int ret = 0, regs_in_pcc = 0;
> +	unsigned long flags;
>   
>   	if (!cpc_desc) {
>   		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1336,8 +1361,25 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>   		}
>   	}
>   
> -	cpc_read(cpunum, delivered_reg, &delivered);
> -	cpc_read(cpunum, reference_reg, &reference);
> +	ctrs.cpunum = cpunum;
> +	ctrs.delivered_reg = delivered_reg;
> +	ctrs.reference_reg = reference_reg;
> +	ctrs.delivered = &delivered;
> +	ctrs.reference = &reference;
> +
> +	if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
> +		ret = smp_call_on_cpu(cpunum, cppc_get_cycle_ctrs, &ctrs, false);
> +	} else {
> +		if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
> +		    CPC_IN_SYSTEM_MEMORY(reference_reg)) {
> +			local_irq_save(flags);
> +			cppc_get_cycle_ctrs(&ctrs);
> +			local_irq_restore(flags);
> +		} else {
> +			cppc_get_cycle_ctrs(&ctrs);
> +		}
> +	}
> +
>   	cpc_read(cpunum, ref_perf_reg, &ref_perf);
>   
>   	/*
>
> I've only tested this on a model using FFH, with 10us delay, and it
> worked well for me. Yang, Sumit, could you give it a try?

Thanks for the patch. I tested it with 10us delay, it works well for me. 
There was 0 high error in my 3 hours test.

>
> Even with a solution like the above (more refined, of course) there is an
> additional improvement possible: we can implement arch_freq_get_on_cpu()
> for arm64 systems that will use cached (on the tick) AMU cycle counter
> samples and have this function called from show_cpuinfo_cur_freq()
> before/instead of calling the .get() function. But this will only help
> arm64 systems with AMUs accessible though system registers. We'll try to
> submit patches on this soon. But as I mentioned to Sumit on the other
> thread, the returned frequency value from this will be an average over 4ms
> (with CONFIG_HZ=250) and could be up to 4ms old (more than that only if the
> CPU was idle/isolated).
>
> Thanks,
> Ionela.

