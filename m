Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074A27307B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjFNTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:00:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9471A2;
        Wed, 14 Jun 2023 12:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3dYVGVq7EUB079req0qIGjsEE4QjnBFMqevFLQy47rhzQ+/cP68xtTL6y3rY+xsAjLZnVEXvYD3qU1RXW0r+FCqEWLIRw9fP57+dyJyfYNVZJxzLCodDekNV7iNNdHkWdRl/1BTp9ncFxstu33UtbgRIQKubRkpThU50vBFbpxoKNZ5RhDektMy99Qnq5TsGTVEG/+lBbMXfla1bWP3tkPz6TO1hnnfOgbF2h0rABFA7ZozXwYXmLM7PgRMSS+vm/BbWoiiTBLUfeECrf9gghYoda9NMWI+u8f4mB3To44qiX4JQRT5COvu+MdZ0sOQaBZWJ3IDwyxlvmKn467Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0lyJBg+eOKn6o9nuWPQ4pJS1U9RsWG4hRMlpbfpay4=;
 b=iPmUgQRCw1LYBlc2yR8munvYDjIdNKA0xir/mm3xAHjzxjNPRYx5wVutt6SRiXJ/D/ZivUY7UPDHslezNdEoxzauJgGyB4g2ft1TvDwqhzkKXxhafjIMPUdnoYXIR2l6alEF7FV9XwnHi/cMCr2+oMirjqj6eE/NcH6h/kdK8unCtKVHC0z+ntUKvMN4XKch2c0P84E9GczXeJeD3ehdtKZYEwuyc2rHzqcco1p278Obrse11Lcmwsv8jscVFugrq1CEvINY+Ccbv2F7DAGPbvRgW7Wr/1K+czlnE42gMe6LeKVEBi7Ajr1WeksUciz4p3WA2LHNQmApVaMXNW29dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0lyJBg+eOKn6o9nuWPQ4pJS1U9RsWG4hRMlpbfpay4=;
 b=NtjCPXDIOSwuWRp09lMzTg4qoful7pb5XtkXQBuJmjb4ghVggIri+kEx9pOXh1lYwUSm8tSCzWXJbgh8T9VmiKWKitzl44+JSo1vDnAfzDN4F5lEMJXCaokObnAQSOsxaV3ocspLpP5/xWuxomVE5KIv0jeXK0b1q3lLU7Baid1u8EKAHunc5X1oENaHy5Sk+G3d2QQn5+elwaB+S4UxOQmeEb1syLmNDjVlh0CNCurohonmFc0DyPB1hxfzNUODnVWCEmXZijcxqB8Pf92jyQld+kYMnSNaB9hPTBVctqu+s8Ruba5jg87Dn/hxxnG0GgPIUsT/K+rXvrOFsUrXag==
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 19:00:15 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::89) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 19:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 19:00:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 14 Jun 2023
 12:00:03 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 14 Jun
 2023 12:00:00 -0700
Message-ID: <8e755438-4b1f-b3d6-b2b8-a5efcca813bc@nvidia.com>
Date:   Thu, 15 Jun 2023 00:29:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
To:     Beata Michalska <beata.michalska@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        <will@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <sudeep.holla@arm.com>, <ionela.voinescu@arm.com>,
        <yang@os.amperecomputing.com>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230606155754.245998-1-beata.michalska@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4a4cc2-7c08-49eb-db8f-08db6d09961c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZkvXC969SlModFeUQrgD34Es70ODztsuFxBZJFolGEm5T3gZXPp8ZlpDkdltQ35wda0vJknvk4n8PFTpVKcTj+mNYNF6imbkgtrvFPOe1C4vMubRFnGXch/4yKjjE2mKADnTJ/5OQEvBh0nargCiRPWgiq1Y+87m29jceNyjzpkoxEVYKk4EddW+QTnzCn43hqaMJWncIlH/UHWfYDryO3j9NHskhEcokdW2AcxlsdF0+M7izT6behugbT62X3VAnNYG6XJxIyrbfD8oix1O6ElgcLyqK7+0Oye/gKoA+d7M493ZDyPLKGZak+nDh5mpiD1d6VA1Ghj3yPufovR1yeVd/+DVg2yA/JVjFyPld73M/Ckc1amy62mmXLp6umsOXWXm3L+2nKgbFSDqON7qL0UtfXcH5b708e8P72seirgDl/XuLUkMtFX/AnUq/uwxRxS4RwoJbtObx4fmPKs/kQGTfy+y3P8CryZFHUFW9yNpjO1jBrkcJr5wWuvY7hYV+Nl1lEBHyfn/mJkcPOazY4RCNiqKeCUwnBHJGjtmsxg3S8PLLAwYnwYV0Zg6PNlSlzG7pJpCXsRQfhnVYifoxISsN8zRN/2sMlxbt1/l1yw/noLvZzQcSXjQdGAS/WtzZH9mCYd4YDZ6h53rSYTULaQxtETOGylfb9mDJYvN+GotYDPIQbGXtztQyk330WvscJ0368q3cZC2n3ybU6w7PGyOq1lBqMnIiQC0sQd+U0fFDikJjtMQxto9VKAp4/Lr96GYTtB9xnFBKYHWotwgmPLqwBP7EMdE/kVhdS6L4DY+WJ0oJwaAIVPfqitnKdDkgjCQ8Kh7St7g5yfTHD2NRZ3mVl6XlzyNBZ/z36fbGe8MT22F34zcFEoAOFfg+dg
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(426003)(336012)(47076005)(2616005)(83380400001)(36860700001)(82740400003)(7636003)(356005)(86362001)(40480700001)(82310400005)(31696002)(36756003)(40460700003)(478600001)(54906003)(110136005)(70206006)(6666004)(16576012)(4326008)(966005)(8936002)(2906002)(5660300002)(7416002)(8676002)(31686004)(70586007)(316002)(16526019)(53546011)(41300700001)(186003)(107886003)(26005)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:00:14.2570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a4cc2-7c08-49eb-db8f-08db6d09961c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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



On 06/06/23 21:27, Beata Michalska wrote:
> External email: Use caution opening links or attachments
> 
> 
> With the Frequency Invariance Engine (FIE) being already wired up with
> sched tick and making use of relevant (core counter and constant
> counter) AMU counters, getting the current frequency for a given CPU
> on supported platforms, can be achieved by utilizing the frequency scale
> factor which reflects an average CPU frequency for the last tick period
> length.
> 
> With that at hand, arch_freq_get_on_cpu dedicated implementation
> gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
> which is expected to represent the current frequency of a given CPU,
> as obtained by the hardware. This is exactly the type of feedback that
> cycle counters provide.
> 
> In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
> attribute handler for platforms that do provide cpuinfo_cur_freq, and
> yet keeping things intact for those platform that do not, its use gets
> conditioned on the presence of cpufreq_driver (*get) callback (which also
> seems to be the case for creating cpuinfo_cur_freq attribute).
> 

Tested the change with frequency switch stress test but was getting big 
delta between set and get freq.
After passing "nohz=off" and commenting "wfi" in "cpu_do_idle()", the
delta is less. This confirms that more delta is due to AMU counters
stopping at "WFI".

   +++ b/arch/arm64/kernel/idle.c
   @@ -27,7 +27,7 @@ void noinstr cpu_do_idle(void)
           arm_cpuidle_save_irq_context(&context);

           dsb(sy);
   -       wfi();
   +//     wfi();

I am not sure if the expected behavior here is right.
In our tests, we compare the last set frequency against the re-generated
value from counters to confirm that the CPU is actually running at the
requested frequency and the counters are working correct. But that won't
happen with this change.

In [1] and later in the updated patch within [2], we are busy looping
on the target CPU and avoid WFI to get the actual frequency.

Please share what you think is the right expected behavior.

[1] https://lore.kernel.org/lkml/20230418113459.12860-7-sumitg@nvidia.com/
[2] 
https://lore.kernel.org/lkml/cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com/T/#mb898a75fd0c72d166b26b04da3ad162afe068a82
