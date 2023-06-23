Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747973BA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjFWOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFWOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:34:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8481992;
        Fri, 23 Jun 2023 07:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtVTlgzd1fKFXGOGsjLCsrYMbqoM7dgDYesliEISUyuceEzVFZ11gkn9UtYfDY0ysQyv7w/ZYEaRxhHP63kRa9z+Idpy3Z//RC/Z02CSd6a2+u+OhazUhgNWRwjwwUo83ANDjuoJofFMK1I+QwuBj0i9g84L59+p/ro0IEm0wzIjo0KEcTN/J0DeCAG7xQ5m3DitkmkFV1tZ7zCT1kP+ga4pdgQPxuNtIGKS3Po68CeeTGJFdYlqVJ8G9E1NPjgj6sL9huNX0JOIOfnmZOPzJzZa6CuZqiQzKqNDMUkyIm3PWQhaKvio2aHljdvUSPomLRrnzCZDoAA+XrdCSe9igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY2GWNHgRFckfBLUJJ0PiNtUGtbWGoW0EWS3nx+LSAE=;
 b=A+Z3IFCG3+4AVe/MBmBoi7bUAk4VVI5/8f/LohQ7GBcMnk1xnPIeWY7uaHNDdGXmOhVtmNnFxZg6M+2a7WdT96uOO2BGfdh0p9YZzARJuvyIeHznLkwqVsNuY32ieMfWZeEAfbyeM5GyYiN45ZLJT6APoNDEltKA/+GeZc0Z0XNfZA9siJTXr7Eq6X2JlSfZ+xsPEvHujWxbjgnpPdaXGAwAuCgx7JhkdUPN9USdHRsOKhAGtyuwleMX/sC2+z+XIEDLD8WKjZwPZY3e+ID2rxrdLHmikpfWZe4mB7weoOc5Fa2GXwpJTNT0uk2aC+JGJDYbnaZtrQo+XB5C2CZ3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY2GWNHgRFckfBLUJJ0PiNtUGtbWGoW0EWS3nx+LSAE=;
 b=tZEUXFlycBVdb/ZrfS2YXM6icITgSNru4F9B6nsqmTteDmloN5/sSLIpl7k/TBgVGsTUWZ20WqwkiDUV+Z9l9dK9rO7/LfIxC1i3/vr4cMPcV8UAzUeSKMw/+CIXlgI0DK2g0n9TAleZGxwIqdtk/ClmkJ579iAjItwPk++EdGgW9YfO3UzuW73sHme+T59k53R3fvpVCLJgB1eHVJVIOXPUuOzhzWSEtUDqXKmEUB08brInlj1CMebceDfUYCilsm/2/TMPWUilP1SutkpOIOOMDPV/Y+rYBUZefjMm+mdbBkz5DLygQfBE+HN2csbLkMoGY/u2aE9aEEkYPs2ETQ==
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 14:34:16 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::85) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 14:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.44 via Frontend Transport; Fri, 23 Jun 2023 14:34:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 23 Jun 2023
 07:34:04 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 23 Jun
 2023 07:33:59 -0700
Message-ID: <691d3eb2-cd93-f0fc-a7a4-2a8c0d44262c@nvidia.com>
Date:   Fri, 23 Jun 2023 20:03:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
To:     Beata Michalska <beata.michalska@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <mark.rutland@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
        <ionela.voinescu@arm.com>, <yang@os.amperecomputing.com>,
        <linux-tegra@vger.kernel.org>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
 <ZIwxB5ao96pVPaCc@e120325.cambridge.arm.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZIwxB5ao96pVPaCc@e120325.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfe2e87-560d-4edf-eacf-08db73f6ebe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhaIrHe3TrvLYOpSLR/Ws3k4wIlaegP9+toQgkgwyn60FAZ9d6jXr9+AHWiQrjfIH0AJBzaJH3XEjW9msexjJA+cv5qyQqaT1v84dZ8EW+sYUV1jjAehU0/RVa40cqIqJEhdSd3PCOW1LqiEXr58/GWZEWF6rZ5UvoXHEByOWkc7c+1Vxmq0e+ySxVVISV8nNKkGA/E4nbsUd3SSxihb4zeF0mv8MElErUBJSLNCyc7f4Dz+zRE4OvrhfqafkqW5xkzqYBFIRAhiiZTHOerCb/tm060KTSgDvnBE1PVTBGLICgZ07vzy/Ot+E8ooWu0Zoby2g/gTrAGj1EiEVZ0PZgSeJq1uHrm0o7ouTcYtvcSX72/TaC+DiGPFHCbbDX8R49CsXyvGpinTF2sak7p22JfkZ+uk446yHzwEkfYpbYQqVJUFIwni01CNyWYO5QiDeiRiqEDXcs7ekr8QnsN6pdwoMNxvwtT5FTpctPlX3hlJrGfDQyP+dmpQY9x6LYyG0QRB/7oicfLvh5lHLbcFmPgj1Q7165fSZeCiM/1Up0Eu1zKDee53+SRpOOobbDM2Y+HySbpnuN+NCbTT74i3+3GC418WU+9jlJeUPorc9I8fg8mZPk7WzqpnmZ8Pa5EhD+t8M50qru4J2pS8jh1UXkNGagfPn7rAOKjB7MVlsjlFEJ3scv7dgYP2DG3E8WKf1T4r5/85IAhWQhciPoxSSTkIr1FgfFl1nuCI3RubKov1Xcllar5m+UahYZInTNEUGcMP80SZaJUrBaGMk16MX1Ozoyq31FuJqxG7aAvm3qvZxrqvx126yT01vbCgcO0stz2/MMQbwts9iaP79CsmAw+qP+wYlGwCQiJTte9Af2U=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(6666004)(40460700003)(86362001)(31696002)(966005)(82740400003)(36860700001)(186003)(26005)(426003)(336012)(2616005)(47076005)(40480700001)(36756003)(16526019)(53546011)(356005)(7636003)(83380400001)(8676002)(8936002)(2906002)(7416002)(6916009)(316002)(31686004)(4326008)(41300700001)(70206006)(70586007)(478600001)(54906003)(5660300002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:34:15.7626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfe2e87-560d-4edf-eacf-08db73f6ebe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/06/23 15:23, Beata Michalska wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jun 15, 2023 at 12:29:57AM +0530, Sumit Gupta wrote:
>>
>>
>> On 06/06/23 21:27, Beata Michalska wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> With the Frequency Invariance Engine (FIE) being already wired up with
>>> sched tick and making use of relevant (core counter and constant
>>> counter) AMU counters, getting the current frequency for a given CPU
>>> on supported platforms, can be achieved by utilizing the frequency scale
>>> factor which reflects an average CPU frequency for the last tick period
>>> length.
>>>
>>> With that at hand, arch_freq_get_on_cpu dedicated implementation
>>> gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
>>> which is expected to represent the current frequency of a given CPU,
>>> as obtained by the hardware. This is exactly the type of feedback that
>>> cycle counters provide.
>>>
>>> In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
>>> attribute handler for platforms that do provide cpuinfo_cur_freq, and
>>> yet keeping things intact for those platform that do not, its use gets
>>> conditioned on the presence of cpufreq_driver (*get) callback (which also
>>> seems to be the case for creating cpuinfo_cur_freq attribute).
>>>
>>
>> Tested the change with frequency switch stress test but was getting big
>> delta between set and get freq.
> Would you mind sharing some more data re your testing ?
> The arch_freq_get_on_cpu will provided an average freq for last tick period,
> with an updated occurring on each sched tick so the differences between set
> and get might show up. With your stress testing, if the frequency change comes
> at the end of current tick period, it might not be reflected until next one
> elapses.
> In case of idle states - if the CPU for which the current frequency is being
> requested is in idle mode, the frequency returned will be the last one before
> entering idle, which seems reasonable (?).
> I guess the question here would be what is your tolerance level for those
> differences.

The test waits for 50ms before reading back the set frequency which is
much more than a tick period.

High delta value might be due to the reference counter increments
happening in bursts in Tegra241 SoC as mentioned in [1].
If the CPU is idle for most of the period then observation window will
be small due to AMU counters stopping at WFI. This can cause more error
in Tegra241 as increasing the observation time interval reduces error
percentage.

I created 100% CPU load and then the test is passing. So, looks like we 
will have to create load before the frequency switch test. Please share
if more suggestions.
[1] https://lore.kernel.org/lkml/20230418113459.12860-5-sumitg@nvidia.com/

>> After passing "nohz=off" and commenting "wfi" in "cpu_do_idle()", the
>> delta is less. This confirms that more delta is due to AMU counters
>> stopping at "WFI".
>>
>>    +++ b/arch/arm64/kernel/idle.c
>>    @@ -27,7 +27,7 @@ void noinstr cpu_do_idle(void)
>>            arm_cpuidle_save_irq_context(&context);
>>
>>            dsb(sy);
>>    -       wfi();
>>    +//     wfi();
>>
>> I am not sure if the expected behavior here is right.
> Both CPU_CYCLES and CNT_CYCLES are not incremented in WFI.
>> In our tests, we compare the last set frequency against the re-generated
>> value from counters to confirm that the CPU is actually running at the
>> requested frequency and the counters are working correct. But that won't
>> happen with this change.
>>
>> In [1] and later in the updated patch within [2], we are busy looping
>> on the target CPU and avoid WFI to get the actual frequency.
>>
>> Please share what you think is the right expected behavior.
>>
>> [1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
>> [2] https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#mb898a75fd0c72d166b26b04da3ad162afe068a82
