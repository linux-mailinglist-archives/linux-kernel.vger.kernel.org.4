Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C476F1652
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbjD1LDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbjD1LCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:02:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2391422E;
        Fri, 28 Apr 2023 04:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTDiJj8jmDCGKwKsW7WHEVIeJeuyoSE+lhsjmLqyxAD8dXZVaUxMSx4BffyFty3BoaHI7jxXuJQkDznserJQEhrGpXYK7ooITWrQC1rHmhX51hphCSFnTbiZW07HS3TAsnChp236/zQ+AZL4UfjwzceZLgYkcbJh0IkWx2XW2bZIitE4RGVtf9HLAysbH2Zi4bNOojffRFsOdg1Z6+6QDmKlp2HvGCg8d+WNIHrwMKkBcIFou1csd6PZpNt6aqmn7XRgafhfw86GQRnyqu1h+rkhoLE+fxmQKllEOO0WAAyeARc3bQX0t92qaR0KsE3SvZSQi3eGx5A2JQlrM6Wvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz2V9eHbfzyKz1yUtl8ixMf6klyV4GDTYkrLKcjMh+U=;
 b=AZPz+A0Q/A34eAN5OWyXazctQBls7j9Tgyxon1Baki7HciTqH4opw865HEiL0rSsr13MjZNbDjgw9iLAJ+450JA3o8VsJGIeGiWV9QjUK+MPrA+uux9nUoCR9L6gelqSLse1sGbDZhV7Wwt5nO/K3DrCeaWj1BUk625HmMDajksMHM+eg4iNCLd43nLWdje//URlkudd2WLRLflVkj5BmuMc29+3pIvxloFXjR5GiKAGmY2z/EE+ZXQLUct76HtcjbchZApAGoHIAc8tLLH6kUnUXSNW/FD0HROFtf/XMa/dy6RX08p3w2w2lRBq3A+WuBlDFAYxWnes4TsRHQjRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz2V9eHbfzyKz1yUtl8ixMf6klyV4GDTYkrLKcjMh+U=;
 b=uIRgA+e1x7jWtlvG85D19TfrQQua5XH6jVEzUNp/akee24+Y0rcprinqGoKFEsGbKIdDjxpPvkfJUWuvS+O40ZsAmhiGC2mUmHGT5VN+NgXGC9pF+xEhufXDyuUckoNmcHopUPTmQKsxLfQjC6AhhHrsQKG+UTdpALF+Q1OMZ5q8GqmIhpJwnKZfIpZWop6+9uWIwQPHQtGlaMLxtQvdGtk8eQss7RLQUgrzSEX6VttyNye8xHNysgqB/636DuL+v7n7F6rW90DhP4XYQSf6ZEKjO/o9Qw1pX5X25741EHfKpV66CHOvAjFNNZgxqTLGuHn52DCfiyJ3AzCP8c010A==
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 11:02:36 +0000
Received: from DS1PEPF0000E64F.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::55) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 11:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E64F.mail.protection.outlook.com (10.167.18.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Fri, 28 Apr 2023 11:02:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 04:02:26 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 04:02:22 -0700
Message-ID: <3186fce7-679c-f1da-363b-bbc31cf68f06@nvidia.com>
Date:   Fri, 28 Apr 2023 16:32:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Yang Shi <yang@os.amperecomputing.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
CC:     Pierre Gondois <pierre.gondois@arm.com>, <viresh.kumar@linaro.org>,
        <scott@os.amperecomputing.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Krishna Sitaraman <ksitaraman@nvidia.com>,
        Sanjay Chandrashekara <sanjayc@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>
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
 <14ab4f0c-4789-a1d2-5b01-c3e0be9a823f@os.amperecomputing.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <14ab4f0c-4789-a1d2-5b01-c3e0be9a823f@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64F:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a4f681-97ea-48f0-50b5-08db47d8127d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUX7RMXR6MIRGlxgJW7wpLvIiheQvMZMltzLEAuC/NwbL0L7NESRpDmt9WNYQM+1klQHD/nayZzXhv3wi34ZShqk0Te8KcuomDa6bwyauK3FBRPV9SzJFT7uNKV+ANWSAr9L+vo4RA6Vld4aR4NKeB/D2mxnox9MED4HuIsKV8Uc5Ym8AuSRAD+LViQ5ID37ICJDfejlqQdJuEZOIvJaJm22JaUq0zLggS0rCDsV3/u1BiAN3uhaQhRit2vyqn1QlbT4L3R2JQvB5NBby+gOdQmADdNGZTlvWqEIykjlHBk+LYyxTfjx8jsp33AQCSl/Z9Nbl0j5NR3QKGV4ndVV9jE7mRmWn6qt633qhNBj2yESoTxNpPuKWcK4B5V75OEocZlwxvKHeXHnRmFvDCHjfQGsBF6IZqoE3i6WQ5O9tp38DtkQ5MPao0DecQZFHs9Mf7I7wf68ui7tpAfdhcgCNKS6ktjqiaplmeGytCXI7cYyIuL1nK+2qx13KiYEWIfK/Y6PtTIvOp25xqq97FyVkzVUdsIt62k2Ig9APQ6XJKOPxXiL2h7JdGE6HC/DGV+pDi2r/n4ADzU88CRAuI3V3l8F4namVx+zrF+xydcXLBQTypf9OVVykJCcj+vcAa8I9aEfSRLaEOMHiakx5p/Dzp1JMBI3IFap3TV7GxXpfxoc94M7vFKquyy8BVMUDTWiQalGaXIY0QDe4skfKjlBETVBAKEw2BZATBIBsAUxXFmTmRSGVKS/T3DM803dTgr/UaTLGIjb1Ik5SA1s7Ny7DWIsi3TrrVEz6E5ZGxPA2BWRtgQk21lvJJ/1ExxlfeB7
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70586007)(70206006)(16576012)(316002)(4326008)(110136005)(54906003)(5660300002)(40480700001)(7636003)(41300700001)(8936002)(356005)(8676002)(2906002)(40460700003)(16526019)(82740400003)(186003)(53546011)(966005)(107886003)(26005)(31696002)(426003)(83380400001)(82310400005)(336012)(86362001)(2616005)(36756003)(31686004)(36860700001)(478600001)(47076005)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 11:02:35.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a4f681-97ea-48f0-50b5-08db47d8127d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/23 02:10, Yang Shi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/26/23 12:01 PM, Ionela Voinescu wrote:
>> Hi,
>>
>> + Sumit
>>
>> On Tuesday 25 Apr 2023 at 18:32:55 (-0700), Yang Shi wrote:
>>>
>>> On 4/24/23 4:44 AM, Ionela Voinescu wrote:
>>>> Hey,
>>>>
>>>> On Thursday 20 Apr 2023 at 13:49:24 (-0700), Yang Shi wrote:
>>>>> On 4/20/23 9:01 AM, Pierre Gondois wrote:
>>>>>>>> You say that the cause of this is a congestion in the 
>>>>>>>> interconnect. I
>>>>>>>> don't
>>>>>>>> see a way to check that right now.
>>>>>>>> However your trace is on the CPU0, so maybe all the other cores 
>>>>>>>> were
>>>>>>>> shutdown
>>>>>>>> in your test. If this is the case, do you think a congestion could
>>>>>>>> happen with
>>>>>>>> only one CPU ?
>>>>>>> No, other CPUs were not shut down in my test. I just ran "yes" on 
>>>>>>> all
>>>>>>> cores except CPU 0, then ran the reading freq script. Since all 
>>>>>>> other
>>>>>>> cores are busy, so the script should be always running on CPU 0.
>>>>>>>
>>>>>>> Since the counters, memory and other devices are on the 
>>>>>>> interconnect, so
>>>>>>> the congestion may be caused by plenty of factors IIUC.
>>>>>> +Ionela
>>>>>>
>>>>>> Ionela pointed me to the following patch-set, which seems realated:
>>>>>> https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/
>>>>> Thanks for the information. I think we do have the similar 
>>>>> syndrome. But I'm
>>>>> not sure how their counters are implemented, we may not have 
>>>>> similar root
>>>>> cause.
>>>> Yes, my bad, I did not get the chance to read this full thread before
>>>> talking with Pierre. In your case you have AMUs accessed via MMIO 
>>>> and in that
>>>> case they are accessed though FFH (IPIs and system registers). The root
>>>> cause is indeed different.
>>> Yeah, but it seems like using larger delay could mitigate both issues.
>> Yes, there is a minimum delay required there of 25us due to the way that
>> the counters accumulate, which is not too bad even with interrupts
>> disabled (to cater to cpufreq_quick_get()).
>>
>> [..]
>>>>>>> Yeah, we should be able to find a smaller irq disable section.
>>>>>>>
>>>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>>>> index c51d3ccb4cca..105a7e2ffffa 100644
>>>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>>>> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>>>>            struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>>>>>            u64 delivered, reference, ref_perf, ctr_wrap_time;
>>>>>>>>            int ret = 0, regs_in_pcc = 0;
>>>>>>>> +       unsigned long flags;
>>>>>>>>
>>>>>>>>            if (!cpc_desc) {
>>>>>>>>                    pr_debug("No CPC descriptor for CPU:%d\n", 
>>>>>>>> cpunum);
>>>>>>>> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>>>>                    }
>>>>>>>>            }
>>>>>>>>
>>>>>>>> +       local_irq_save(flags);
>>>>>>>> +
>>>>>>>>            cpc_read(cpunum, delivered_reg, &delivered);
>>>>>>>>            cpc_read(cpunum, reference_reg, &reference);
>>>>>>>>            cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>>>>>>
>>>>>>>> +       local_irq_restore(flags);
>>>>>>>> +
>>>>>>> cpc_read_ffh() would return -EPERM if irq is disabled.
>>>>>>>
>>>>>>> So, the irq disabling must happen for mmio only in cpc_read(), for
>>>>>>> example:
>>>>>> I thought the issue was that irqs could happen in between cpc_read()
>>>>>> functions,
>>>>>> the patch below would not cover it. If the frequency is more accurate
>>>>>> with this patch, I think I don't understand something.
>>>>> Yeah, you are correct. The irq disabling window has to cover all the
>>>>> cpc_read(). I didn't test with this patch. My test was done 
>>>>> conceptually
>>>>> with:
>>>>>
>>>>> disable irq
>>>>> cppc_get_perf_ctrs(t0)
>>>>> udelay(2)
>>>>> cppc_get_perf_ctrs(t1)
>>>>> enable irq
>>>>>
>>>>> But this will break cpc_read_ffh().
>>>> Can you not disable IRQs in cppc_get_perf_ctrs() only if the registers
>>>> are CPC_IN_SYSTEM_MEMORY? Only spanning the reads of the delivered
>>>> register and the reference register, which should have minimal delay in
>>>> between?
>>>>
>>>> As in:
>>>>
>>>> if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
>>>>       CPC_IN_SYSTEM_MEMORY(reference_reg))
>>>>     ...
>>>>
>>>> This will and should not affect FFH - the fix for that would have to be
>>>> different.
>>> It won't work, right? The problem is cppc_get_perf_ctrs() calls 
>>> cpc_read()s
>>> to read delivered and reference respectively, we just can tell 
>>> whether they
>>> are CPC_IN_SYSTEM_MEMORY in cpc_read() instead of in 
>>> cppc_get_perf_ctrs().
>>> So the resulting code should conceptually look like:
>>>
>>> disable irq
>>> read delivered
>>> enable irq
>>>
>>> disable irq
>>> read reference
>>> enable irq
>>>
>>> But there still may be interrupts between the two reads. We actually 
>>> want:
>>>
>>> disable irq
>>> read delivered
>>> read reference
>>> enable irq
>> Yes, this is what I was suggesting above.
>>
>> I've hacked up the following code. It covers the FFH case as well, with a
>> modified solution that Sumit proposed on the other thread:
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 0f17b1c32718..7e828aed3693 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, 
>> cpc_desc_ptr);
>>                               (cpc)->cpc_entry.reg.space_id ==        \
>>                               ACPI_ADR_SPACE_SYSTEM_IO)
>>
>> +/* Check if a CPC register is in FFH */
>> +#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&  \
>> +                             (cpc)->cpc_entry.reg.space_id ==        \
>> +                             ACPI_ADR_SPACE_FIXED_HARDWARE)
>> +
>>   /* Evaluates to True if reg is a NULL register descriptor */
>>   #define IS_NULL_REG(reg) ((reg)->space_id ==  
>> ACPI_ADR_SPACE_SYSTEM_MEMORY && \
>>                               (reg)->address == 0 &&                  \
>> @@ -1292,6 +1297,24 @@ EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>>    *
>>    * Return: 0 for success with perf_fb_ctrs populated else -ERRNO.
>>    */
>> +
>> +struct cycle_counters {
>> +     int cpunum;
>> +     struct cpc_register_resource *delivered_reg;
>> +     struct cpc_register_resource *reference_reg;
>> +     u64 *delivered;
>> +     u64 *reference;
>> +};
>> +
>> +static int cppc_get_cycle_ctrs(void *cycle_ctrs) {
>> +     struct cycle_counters *ctrs = cycle_ctrs;
>> +
>> +     cpc_read(ctrs->cpunum, ctrs->delivered_reg, ctrs->delivered);
>> +     cpc_read(ctrs->cpunum, ctrs->reference_reg, ctrs->reference);
>> +
>> +     return 0;
>> +}
>> +
>>   int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs 
>> *perf_fb_ctrs)
>>   {
>>       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> @@ -1300,7 +1323,9 @@ int cppc_get_perf_ctrs(int cpunum, struct 
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>       int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>       struct cppc_pcc_data *pcc_ss_data = NULL;
>>       u64 delivered, reference, ref_perf, ctr_wrap_time;
>> +     struct cycle_counters ctrs = {0};
>>       int ret = 0, regs_in_pcc = 0;
>> +     unsigned long flags;
>>
>>       if (!cpc_desc) {
>>               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -1336,8 +1361,25 @@ int cppc_get_perf_ctrs(int cpunum, struct 
>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>               }
>>       }
>>
>> -     cpc_read(cpunum, delivered_reg, &delivered);
>> -     cpc_read(cpunum, reference_reg, &reference);
>> +     ctrs.cpunum = cpunum;
>> +     ctrs.delivered_reg = delivered_reg;
>> +     ctrs.reference_reg = reference_reg;
>> +     ctrs.delivered = &delivered;
>> +     ctrs.reference = &reference;
>> +
>> +     if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
>> +             ret = smp_call_on_cpu(cpunum, cppc_get_cycle_ctrs, 
>> &ctrs, false);
>> +     } else {
>> +             if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
>> +                 CPC_IN_SYSTEM_MEMORY(reference_reg)) {
>> +                     local_irq_save(flags);
>> +                     cppc_get_cycle_ctrs(&ctrs);krish
>> +                     local_irq_restore(flags);
>> +             } else {
>> +                     cppc_get_cycle_ctrs(&ctrs);
>> +             }
>> +     }
>> +
>>       cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>
>>       /*
>>
>> I've only tested this on a model using FFH, with 10us delay, and it
>> worked well for me. Yang, Sumit, could you give it a try?
> 
> Thanks for the patch. I tested it with 10us delay, it works well for me.
> There was 0 high error in my 3 hours test.
>
With this change, the delta between the set and get freq has reduced
from ~25% to <10% and occasionally ~15%. Tried with the delay of
10, 25, 50, 75 us.

With the change in [1] & '25us' delay in [2], the delta was <5%.
[1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
[2] https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/

Thank you,
Sumit Gupta

>>
>> Even with a solution like the above (more refined, of course) there is an
>> additional improvement possible: we can implement arch_freq_get_on_cpu()
>> for arm64 systems that will use cached (on the tick) AMU cycle counter
>> samples and have this function called from show_cpuinfo_cur_freq()
>> before/instead of calling the .get() function. But this will only help
>> arm64 systems with AMUs accessible though system registers. We'll try to
>> submit patches on this soon. But as I mentioned to Sumit on the other
>> thread, the returned frequency value from this will be an average over 
>> 4ms
>> (with CONFIG_HZ=250) and could be up to 4ms old (more than that only 
>> if the
>> CPU was idle/isolated).
>>
>> Thanks,
>> Ionela.
> 
