Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E596EF802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbjDZPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbjDZPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:53:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCB6A66;
        Wed, 26 Apr 2023 08:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezm7lkAIAWk6k2KqZIXJi9MfQEDjMQhdmeCnZoMP1ko6efvr6uzbW/VqKgLtvo/YUFblovFqPRHJOsCsVg2hqCMe2tr2bQtFreVT8EzAPtUUSwLz/ch+rq2/2j2rFyW2nI5kFskBBGhZ/qe2Is1TiZr+8Qfn1RqznmA+LWqX44KzQZm7H2jR63U3Bd0SBsgkuy/MBJNJK5QfGa3KrYDbzucU04wRsYMGELg/enCXdQ3M9We2nkkVQDehbXG/GeBHJDmjzmNPKyvUKPA0j6l0PqvsHfR79P1ICEwX9ppUamNIMfocfpUSwEfkS7BufAQXnE5vb8ToiUjHt8qNa7ybcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfQGorfHCp+/ehmc0DLMIsf8gl6tewCw2t3qxX2o5No=;
 b=GnlivIf5FEMKTrgKwSP5SoN/v0kb2CrbfglnRwzyhVhLuUyVs/ldSyd/ofEnWrmFYhehuDHFF1Ncr/7fOxLE6JfKJtk7SRCTm0CVP/sjAa/TvN0ZieLirv/7tpQB/MvgWOpc3sHpf4X+viWaYw7vfw4TMG8Aiz/94BtAW57jQrNZ/WpLPJ0rsfFj+c6vp5OlcahA9yiYvKDHKXQGO87PpEodlICzlHBN+rYlW8AeQPWtKaQR6zV84qcarX52PwEUBzUTU5T6MtLAWj2pzzyAC68oXtN9Bkzh6ZBnubhnnwFs/nOlfK9LFHWzK/JCRu+v04idnbdCbjhqGsMeGBltdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfQGorfHCp+/ehmc0DLMIsf8gl6tewCw2t3qxX2o5No=;
 b=di8RsTSLAbn9MRi1wD48/1JgWCO2J0jw9iazWjEg9J9xSdGMax0CJ13fw6kvzu90tVK6/TiuLyTFFRvU/oxhMpyUYQ/ZHGbnikiH+Zl1rac8VHd2B+Ryxb8VQbHwviakQtfDgEQdxId+RdNIdRX3KpgOVsDA414Ewq9KelvPSHXXe3hvrDCfB6KQJ3EamDxaURVX5flBBrJZkIVvKdm9rflu8eTlm4ByeecsaLxUbrlCPuMaSlOCogOXXhqesvcZyeJYbhhzvMuFXVNulKjj1IuvSdBIdEsNZS8rvj04akjhRIvtUvWtbWDJ6b+jroRrSIExor8WreI+SygeDaPSGg==
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 26 Apr
 2023 15:52:59 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::e) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 15:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 15:52:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 08:52:49 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Apr
 2023 08:52:42 -0700
Message-ID: <0d0ce727-d801-1c63-253d-815f324fac24@nvidia.com>
Date:   Wed, 26 Apr 2023 21:22:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch 6/6] cpufreq: CPPC: use wq to read amu counters on target
 cpu
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>
CC:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <lpieralisi@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <sdonthineni@nvidia.com>, <sanjayc@nvidia.com>,
        <ksitaraman@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230418113459.12860-1-sumitg@nvidia.com>
 <20230418113459.12860-7-sumitg@nvidia.com> <ZEY+kENTxCvHlhvK@arm.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZEY+kENTxCvHlhvK@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: b7633815-4c6c-474d-cfc5-08db466e4f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yO1vBOZy7s9/1fm5o29yEJCV0ONu/6/d52LuD8InuP01gF5NqspnbZlr91GWL+crREmxHZjAwOmGAyN6106mngBhW0UXtT14hWMItrco8pLYoP3GAJULqyT2EnwSE8yokzVTQg5Tx6MyR2vuKrEr9Y6jX8Suk6CFLdp7C1mhH5xIGAHTBVKaVZRfoGTLmG3Rr866Z7Cu/lndvHbMELihRCcEIFsYzxO/DObRSOn9gYDkaDyL26Ymsdy7Pb7RX3IOhPLqYS7Cz5HAhzK5KPc5NWy1ZVHDkaecgPpZ/lbttWa/aSdrCtsehgZsgZ30upCetu+VZLphI7PZyRIat9ZvmR1cnaenO3KSnShoXPrBgAAR5hHxRViqF0X9UvUCmicYhxcuvGoafbmejPySpIoQVhB1O5+4zLpdaKPsfVrkp+/9mS6zwYtAylGMmyCZUsTl7mDOaiVfnXiGqoqrKHLiKDGIxU/0WqHI8pNxLx8SjYvaZbDhK7aSaVno4SPOYMZDr/OlKGe9Ng2MmYxu2vm0OxWHla1vcClXd+582scR5ZM72zZQyRPa6KcET9qBsD0kAWAL82iYtWIW+NURCQ/07Gs7vfAp5aVdbUIV+bATn3IrpsIRDBNKuK/RT5lVVNrPjBPLv8f6D8z+VxZKm9g0lHntMyjs0nFB5Z1lujj9zUAmskDrO8XwWlZnDLce9Zd7U6hrCTW0a73SIyb9AxalLYNFyzKrQW1x6sqeXiTCaRGbr5WflJR9k9rkwTH0HxAVe0H74sXO/eJ32K6CySPxzpcsQ4BfwZAzr9hOkd3yNNXH62GIahRilXNX+9eb7DqQ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(53546011)(2906002)(7636003)(107886003)(6666004)(426003)(26005)(336012)(54906003)(316002)(2616005)(16576012)(34020700004)(16526019)(186003)(40460700003)(36860700001)(36756003)(31696002)(41300700001)(31686004)(966005)(47076005)(8936002)(82310400005)(478600001)(86362001)(70586007)(4326008)(6916009)(8676002)(356005)(70206006)(83380400001)(40480700001)(82740400003)(5660300002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 15:52:58.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7633815-4c6c-474d-cfc5-08db466e4f26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
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

Hi Ionela,

Thankyou for the inputs.

On 24/04/23 14:02, Ionela Voinescu wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Sumit,
> 
> Thank you for the patches!
> 
> On Tuesday 18 Apr 2023 at 17:04:59 (+0530), Sumit Gupta wrote:
>> ARM cores which implement the Activity Monitor Unit (AMU)
>> use Functional Fixed Hardware (FFH) to map AMU counters to
>> Delivered_Counter and Reference_Counter registers. Each
>> sysreg is read separately with a smp_call_function_single
>> call. So, total four IPI's are used, one per register.
>> Due to this, the AMU's core counter and constant counter
>> sampling can happen at a non-consistent time interval if
>> an IPI is handled late. This results in unstable frequency
>> value from "cpuinfo_cur_req" node sometimes. To fix, queue
>> work on target CPU to read all counters synchronously in
>> sequence. This helps to remove the inter-IPI latency and
>> make sure that both the counters are sampled at a close
>> time interval.
>> Without this change we observed that the re-generated value
>> of CPU Frequency from AMU counters sometimes deviates by
>> ~25% as the counters are read at non-determenistic time.
>> Currently, kept the change specific to Tegra241. It can be
>> applied to other SoC's having AMU if same issue is observed.
>>
> 
> To be honest I never liked the need for IPIs but it was the most
> generic solution I could find for an FFH implementation that does not
> assume a dependency between different reads, which is usecase specific.
> 
> Also, for any kind of caching of the counters I'd have to introduce some
> logic that would assume we'd always have two consecutive reads - one for
> the cycle counter and one for the constant counter, and there should be no
> update between them. And then there's the problem of potentially returning
> the same values if there's no update between two sets of reads.
> 
> The only feasible idea based on caching would be to piggy back on the
> frequency invariance engine (FIE) which computes a performance scale
> factor on the tick which can be translated to frequency. But the
> frequency obtained would be an average frequency for the past 4ms, which
> can in turn be at up to 4ms old (or more, if the CPU was idle).
> 
> Would something like this work for you?
> 
> This could also help with a similar issue described at [1] - not an IPI
> related issue, but an issue with similar symptoms.
> 
> [1] https://lore.kernel.org/lkml/20230328193846.8757-1-yang@os.amperecomputing.com/
> 
> Thanks,
> Ionela.
> 

I think yes that will help as it will increase the time period and also
remove the IPI's ?

One thing I am not sure is whether there can be any impact when CPU is
IDLE w.r.t. the delta between the frequency set and get from the counters.

Thank you,
Sumit Gupta

>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 53 +++++++++++++++++++++++++++-------
>>   1 file changed, 43 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 5e6a132a525e..52b93ac6225e 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -46,6 +46,8 @@ static bool boost_supported;
>>   /* default 2usec delay between sampling */
>>   static unsigned int sampling_delay_us = 2;
>>
>> +static bool get_rate_use_wq;
>> +
>>   static void cppc_check_hisi_workaround(void);
>>   static void cppc_nvidia_workaround(void);
>>
>> @@ -99,6 +101,12 @@ struct cppc_freq_invariance {
>>   static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
>>   static struct kthread_worker *kworker_fie;
>>
>> +struct feedback_ctrs {
>> +     u32 cpu;
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0;
>> +     struct cppc_perf_fb_ctrs fb_ctrs_t1;
>> +};
>> +
>>   static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
>>   static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>                                 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
>> @@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
>>        return (reference_perf * delta_delivered) / delta_reference;
>>   }
>>
>> +static int cppc_get_perf_ctrs_sync(void *fb_ctrs)
>> +{
>> +     struct feedback_ctrs *ctrs = fb_ctrs;
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t0));
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(sampling_delay_us);
>> +
>> +     ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t1));
>> +     if (ret)
>> +             return ret;
>> +
>> +     return ret;
>> +}
>> +
>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   {
>> -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>        struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     struct feedback_ctrs fb_ctrs = {0};
>>        u64 delivered_perf;
>>        int ret;
>>
>>        cpufreq_cpu_put(policy);
>> +     fb_ctrs.cpu = cpu;
>>
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>> -     if (ret)
>> -             return ret;
>> -
>> -     udelay(sampling_delay_us);
>> -
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>> +     if (get_rate_use_wq)
>> +             ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_sync, &fb_ctrs, false);
>> +     else
>> +             ret = cppc_get_perf_ctrs_sync(&fb_ctrs);
>>        if (ret)
>>                return ret;
>>
>> -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>> -                                            &fb_ctrs_t1);
>> +     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &(fb_ctrs.fb_ctrs_t0),
>> +                                            &(fb_ctrs.fb_ctrs_t1));
>>
>>        return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>>   }
>> @@ -953,7 +977,16 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
>>
>>   static void cppc_nvidia_workaround(void)
>>   {
>> +     int cpu;
>> +
>>        sampling_delay_us = 25;
>> +
>> +#ifdef CONFIG_ARM64_AMU_EXTN
>> +     cpu = get_cpu_with_amu_feat();
>> +
>> +     if (cpu < nr_cpu_ids)
>> +             get_rate_use_wq = true;
>> +#endif
>>   }
>>
>>   static void cppc_check_hisi_workaround(void)
>> --
>> 2.17.1
>>
