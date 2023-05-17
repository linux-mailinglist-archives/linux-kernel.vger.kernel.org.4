Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D4706C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEQPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjEQPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B004D3A9C;
        Wed, 17 May 2023 08:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db2CRJ5pdR5GESX51lYotYouHdVqDpiinx469VGD9UwVVA1kMU/OBmpg6Zp3nMes6G9frQWAUs7MYpr9xuPYuLYHQq+TGWKVAq3J6ENdd643nnaG5pYfIt3CbRyBrdQZLdVXK8vy/b3VbkfvZH31mDjHRCG9Gia2C5NnLVyk39eCHuge2VQVViYfDYC0uXzR03ZjF7Co9j0e39+yRCkv98nN+9xd2XMg9ZknUkJKeeoVS0NxlsVoOZn9cPsY2Ep4nHRMsANipPW4NiiTDAu/FZNdOqNySxa9zTPLsM9Rzdf7sRiUVGMhFR3WByT6nvPiIEvI1wNK5aDSz8Tilff4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBG66r+c35VYKloT6KTqYg9+/wVcUcE/tugnyHqGruY=;
 b=DvvFBkzew6hv8n4/mezilQrBgT6cLek5ZDKPf0Nh8J6GZJU+iVnAjgeTfoeFzmGzrGo7HDNKSU0dDEFZO6kuWzOhjewnVPQxEaO8tCOYu/EPqqS/cAHEcQmeePuvrGvFWcQ5BqYLLk+NnoCJzYazjJDb0qhooBKnB9jEtrIHyMOjJRMAiktF5zlAhdAhXY5lQ7nE8xZW5oyRTO4LCt/lmUCxoeFUDSNyojkoWC158uOFrvq8+aEEnQoW/jf1wlv7sVyeHapdUPCg05X7tKVbY3jq5zGG6dy34QbRIupqnrHY9wEOkclKC4d2W4fJUpP0RxTHRprUotojYp8u+Ke76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBG66r+c35VYKloT6KTqYg9+/wVcUcE/tugnyHqGruY=;
 b=Rf2wj5Ovb9JUixfT99sC7EbVFz3A6Ysk50J282jhiN+6P652Q92iB8x6eJ6sD2LU9YP8EKIL/b+FrSHI6nz59Kf2N9ddt6vG+GlAEO7AAlAsthEDrhonwlJQhzvGS1Q1442QcoRMpN8VBsKuPgwJQVSqq4e9P8JW57QymDOB7DX6aMrAJ3R2hzO3WrKWwLNAQjyTDIxmR0QuVP4OV4ACDAkCJey3uVbzBezaJryuHGq4PnukcijXnbSTPgsyXtXnvij1yCzu9MEn81/L2CecybAcvBOoyRUoYzihanM30bE/JrZNEkCHHCcWh+KBqtpP+Ga3/vsrrRQ5lWynicjKqQ==
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 15:03:50 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::29) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 15:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 15:03:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 08:03:36 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 08:03:32 -0700
Message-ID: <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
Date:   Wed, 17 May 2023 20:33:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <linux-acpi@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <lenb@kernel.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        Yang Shi <yang@os.amperecomputing.com>
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: e918fc10-3e5a-43f1-854d-08db56e7ec26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQQiFHyU4XXHyTZa66jrvVkmdoYXTs273hq24UtR+hf+CxK/apmCM0gZ3N4JMDGAeojdPYuYlDTuU/fCc2iJoZpX45QJevQYBBSFErgkP73Bs43XHMREy1rRpRIwMFo+EjvoZdSu3wh8Pc9SjxgLLhbnEb7sZ/X7nnaVnOb74qSVo5jZ9Y1l/qfP9mQDPKgAJoNcntQfrRp6bNm8jZOoPB8rGCfkTeVw+X4+GcN2dpMA5l1nEdKQFM7lBcA9EhHMhCx8Dbks41jOhisZsWOODJbyQLVlogQUPbMl2pWSuNcWLRY75NBX1XhND7/z9Ihh933i8JmQFVI8SA+P1ZqbIkBPuVQ9qC0R/fugj7C5V4ZgcgBEzwX2oM+9UtnCvDtbkbfjp6pjYpkGCPwUn+SmQoWz2vHNI57jKmyJL8YOWAdz+4nXrbnJVOv6z0yI7CbsK/mc97e/EHuNhTxKxOB3+6wUnYbhFYee7O9aUxu7JXitOWNN4/Fl1un1B5UMId66qeDNuVdezdy9KLI/xeWj7op8X78kiNzbYGw6YANQZv+5ihcPYlagvuSrQ8vGM33Zs0FALrn3tkhS/dPWZWdRHvlRlTWGh1KcAKdClVa0V8pIUtqAh1a1jI096ttEhkc4eHtGiBHMlR5l6eZAg1i3HUqBOhI4uhoNZoeJp5/mG3qL7jvpwwsAf7VrUq9cEheKCatvwVCHkCMT8VuUcve0cPRPlg0RNQ1oszasw9sSOnEyAKzv/4Ot6tY/FCkmClizWYqXO+K6JFv3x3kb/4xAMYw7mkycwElX2J3FTkiIMD4utSEPW9Ye4hnoQQrqrVoAnn4WpUQ5CqFjX2YHFolUxxHPGr+koEQTwegF73WfIHg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(8936002)(7416002)(426003)(336012)(2616005)(82310400005)(966005)(47076005)(186003)(82740400003)(83380400001)(36860700001)(356005)(53546011)(7636003)(26005)(16526019)(40460700003)(16576012)(478600001)(31696002)(110136005)(316002)(40480700001)(41300700001)(86362001)(70206006)(54906003)(70586007)(36756003)(4326008)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 15:03:50.0563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e918fc10-3e5a-43f1-854d-08db56e7ec26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/23 13:47, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
> 
> 
> +Ionela, Sumit, Yang,
> 
> Hello Zeng,
> 
> I think solutions around related issues were suggested at:
> 
> [1] https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
> [2] 
> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
> 
> About this patch, it seems to mean that CPPC counters of CPUx are always
> accessed from CPUx, even when they are not AMUs. For instance CPPC
> counters could be memory mapped and accessible from any CPU.
> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
> and [2] had an implementation using it.
> 
> Another comment about PATCH 2/2 is that if the counters are accessed
> through FFH, arm64 version of cpc_read_ffh() is calling
> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
> to specify the function must be called with interrupt enabled.
> 
> I think the best solution so far was the one at [3], suggested by Ionela,
> but it doesn't seem to solve your issue. Indeed, it is not checked whether
> the counters are AMU counters and that they must be remotely read (to
> have the CPU awake),
> 
> Regards,
> Pierre
> 

I think the solution in [1] is simple and solves all the three cases.
Also, it provides better accuracy between the set and get frequency as 
compared to [3].

This can be merged and can later still be improved in Upstream.

If OK, I can send new version by changing the patch to apply for all ARM 
SoC's with AMU and not specific to Tegra.

Thank you,
Sumit Gupta

> 
> On 5/16/23 15:32, Zeng Heng wrote:
>> As ARM AMU's document says, all counters are subject to any changes
>> in clock frequency, including clock stopping caused by the WFI and WFE
>> instructions.
>>
>> Therefore, using smp_call_on_cpu() to trigger target CPU to
>> read self's AMU counters, which ensures the counters are working
>> properly during calculation.
>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 30 +++++++++++++++++++-----------
>>   1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..910167f58bb3 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -837,9 +837,24 @@ static int cppc_perf_from_fbctrs(struct 
>> cppc_cpudata *cpu_data,
>>       return (reference_perf * delta_delivered) / delta_reference;
>>   }
>>
>> +static int cppc_get_perf_ctrs_smp(void *val)
>> +{
>> +     int cpu = smp_processor_id();
>> +     struct cppc_perf_fb_ctrs *fb_ctrs = val;
>> +     int ret;
>> +
>> +     ret = cppc_get_perf_ctrs(cpu, fb_ctrs);
>> +     if (ret)
>> +             return ret;
>> +
>> +     udelay(2); /* 2usec delay between sampling */
>> +
>> +     return cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
>> +}
>> +
>>   static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   {
>> -     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>> +     struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>       u64 delivered_perf;
>> @@ -847,19 +862,12 @@ static unsigned int 
>> cppc_cpufreq_get_rate(unsigned int cpu)
>>
>>       cpufreq_cpu_put(policy);
>>
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>> -     if (ret)
>> -             return ret;
>> -
>> -     udelay(2); /* 2usec delay between sampling */
>> -
>> -     ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>> +     ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);
>>       if (ret)
>>               return ret;
>>
>> -     delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>> -                                            &fb_ctrs_t1);
>> -
>> +     delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
>> +                                            fb_ctrs + 1);
>>       return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
>>   }
>>
