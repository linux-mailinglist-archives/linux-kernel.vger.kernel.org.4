Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E391735CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjFSRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjFSRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:02:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA885197
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UusvHbJubuHCkgkgN+Ddav4nW2CzWjHSZpaKhn44BDhMS6Kwb861z/Yrqs0m6KfnF2M5Hk3Zx5aTpjrczEypQirG9P2wc4m32bECTB0jAdKONQ+UgPULVLcvpYGYz8AhHiFlQXJCPp6s8+1mOQ0OkZm46a/FAeeUI+7Gg9X2QsdHOsdSuUuZjSr9rO8vNvlcs85Ru4YbKnFy6/huIYRGU+F3tWe6xwls3cyj2gIcrB/ATcnxH8x34ZHlR4QXzBOA565Ep3Tdi/vaY96NhYhgtkterNer/zmKEpDRB5dQNRVJcuOzWfc4jwvDPekn042BY8LA4oFS3iAhwvye3HECjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ePY0QPH6CkEPaMdMiZDRtPEe8XETJTGiYrcuKMmpYA=;
 b=KtD4laXoz1XYzsFvjvZGLmEWHYfzu1ds7x63PYfrkR7EYQY79RPuQOW6YUJxFqzqkDh3NaFkmb2fG/mA3CXEvNVQVi+Ce6W+6vnde4qLyGLfaOsWJlZW6lr1IJTsW86wBmdG6yckgJe1wCt+WRaBMkHln09Oyj0VKnjJ8ozVMtah1UDtJuu99vDbFozqI+dqkNTdhjBhSO7/gTPchcWBltOatkS/ej4wtK5EsF6Ig7Pc7b4srWepEKUgmX197LyK/cc5dehbMFd4e8wm4PmEKdLDbMftyqBjccRBpbTEKnNhUmrF8aAZTwXXujqp2SFHx+UWr5J7ry+O1U1MLfl7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ePY0QPH6CkEPaMdMiZDRtPEe8XETJTGiYrcuKMmpYA=;
 b=Vc2OWcaYFhcNMmzr4nmyK1lZHcBAlXSHZvNsemextGYWTgEUZv8LkuK0PqMUTacdlFJFkI1IlAY10fXiYAsQ3rzGsLCPrv6ZY8d8HHItpNbiJ/stFj7xnYn9cnTqxvRTOu7OYaW914MIQc2zC5IHVb6sgAvG6+61EpW7dohGU5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 17:02:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 17:02:22 +0000
Message-ID: <220eb0c4-ace2-d67c-8680-fc9cd361f873@amd.com>
Date:   Mon, 19 Jun 2023 12:02:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [patch v3 2/7] x86/smp: Dont access non-existing CPUID leaf
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.322186388@linutronix.de>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230615193330.322186388@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0205.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6accca-899a-4684-95dc-08db70e6f2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dj6R8l53a2RHviqZGtjO5jKduuzMu/sg0P4ai/kIL4JbpfM6isRKkwdGTdUTHul8UZtbHI4D40vSEwu04XU/8CcDgGc2fzk9LYmeEQfWR6ci6cKgnKfsSG/pIpGfIKR2esvIGadA3Rj5nkEqtL3NjM+QOFGQEj6NZOgCHEdgRnsMwfVqEtjSrBdXqUq+BFW3d0h1CedYjXef4gYKpQV9aTwX4MqidQjBIg23K24MqawwaNxUQs7yceRSmtCjkCluGmDEBdVpTzErJGmn44d8uAf7XVG1UQksB8xLYpPSXDT9Cfr9XEZq5AfUk3iLHbd/5xzlaRPgrMQ2McQm81m+dBSv126dAtF4t1UQyFw1imPHHl3R3KBoffSWEGndbqQCI0xHAT4jnbf+qJimzcyOuLAXhMD8LFmtXvo9mFf9XttTbkUjLrwgky+tyBe/XCS55EzZLlSnHZP8FTZwBgFcwIO5zVGxiv64ApIU769UYL5b7dhSRhq4Mr4nh/PFMsYDqXuCzW+LLoL1lGNL9zDL89sVp2ZxLWBLwuVc0V0vIl3yS/XMhxLOjOok6VScPMkKNQCiSNIw6voPhR1pNXvqRa2HgvyueL/GAofLq/kas4jKLv23tPLHJcUzgAz4JvCHWKIT+P0CC40z1zdsgQ5SKHOwwKfDDj1ernlpaxDIJZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(31696002)(478600001)(2906002)(54906003)(966005)(6666004)(6486002)(2616005)(110136005)(86362001)(36756003)(26005)(186003)(6506007)(6512007)(8936002)(8676002)(66476007)(66556008)(66946007)(53546011)(5660300002)(38100700002)(316002)(4326008)(83380400001)(31686004)(41300700001)(192303002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWp1NWFTL3A3WVJvNXFhazI0MmZWclVKdUlDd2Zhbnl0ZHBuUnBlYTk0b0My?=
 =?utf-8?B?dG55Y1BIWnpMVjVWNG1uTVhkRGtXZXYwL2Yxc1ZPTGt6bGVoZWRxSS9kcEh3?=
 =?utf-8?B?T0pTeHhvcFo3WFNUTElQSXZOand0b2JGVzVUdnVqM0p2L1ZwOTVhU0VwbGgv?=
 =?utf-8?B?SnFaTFhSWFE1dEp4cXd1dkF5K3NrNTB2N1V3Y1h3SXVlNnlEMXJOTDhNbjAr?=
 =?utf-8?B?UjEzbWdMVk00elVzTy9LRCszRXhwNkV6dTNDOThtODA2eTlKbG40ZlBySEJF?=
 =?utf-8?B?TjlHdHVKdkFhci9jVW1mQ1lFdzRpSEZZbFc3MGtDRzZKdmJZVk5rc2tRazQ2?=
 =?utf-8?B?ck84Z1FBUHlMSzQ3dlRrU0RVYndENVg0d0RBenZhK01aS0N4YVhwS2tydHpB?=
 =?utf-8?B?OFNIbk0wWTlyWHN2aXZNSWVmSUFZMjFVUFNBRUYycXlzaDJPSkltYlVzZWVQ?=
 =?utf-8?B?WmtmZ0c3bUJDdk9kZURxeUp0L1ZKUXhJWC9iRm5vY0JvaUw4YjBIZTJrUnR0?=
 =?utf-8?B?U3YybFV4SW44ZFV1TzVRMnEwbTR4MGhvWVRjaWdCZFBYTXMxaVA4MUJyTlpn?=
 =?utf-8?B?YjNRKzA0NHhWZUpxZ2pGRmYrUjRpODlrejMyN2tpUS8wTXppNUtEQmJVNUF5?=
 =?utf-8?B?Ynk4UHczSjJBMnRaQlZ2VXdETXc0NW5scUxEQ1RxRlVKejc4RzY4STg3anRC?=
 =?utf-8?B?ZlhMVTFaVXE1UTdhRGJaNWNsSGZkYVBhaDFNeHVjZXBkSmhtWWhHT1FmNFlL?=
 =?utf-8?B?TmNCTkxrL3dzbVZkSTgwdjZsQ0FHVzl3RzRIYno0Ulk4N0Z5WTExSUIvTUxQ?=
 =?utf-8?B?aGN6Y0NPZ0tPdklYWkZIQnhBbC80dE0rcGhmWEdsdkRrcnFlZkFEdW1rL1N4?=
 =?utf-8?B?VSsyV1FKaU5yZWFYNHZZbytodU5qYmpHdGdsODl3dmJXb1djNDNDZHZ5WStB?=
 =?utf-8?B?Z0FpbzVQRk5aalpLeFg0ZFRaaTU1SjVHUlZZOUlhckF2bkJGUWlTeXZJNlVu?=
 =?utf-8?B?QlVrZkVWaTNUczBrTjJSMy9jbnhuTjlXS0ZrWktFNzFBcWN4UHMwOXk5UlV6?=
 =?utf-8?B?NjdjTEpUcnB2cTBFcFZWZ3MrRHNmamxtNmgzcFJRcHdNWlpFNjVhcE1SUjJT?=
 =?utf-8?B?K2RtWE1qcjFtOHBHN0czWGg2QVJ6M0J4Q3VSaDlQZDZ6YTcyWW81aWlDUE1l?=
 =?utf-8?B?T2czR3lrOFhtbWRhZ1BkUi96Y1E3b1IyMFZrcktFOFYyZUpHQ2xybEVobnpO?=
 =?utf-8?B?Uy9XOFk0dTJoemZiQ3kreW1sZmpjV1ExWTJadFlJK1NHekNKa2FUZ013alU5?=
 =?utf-8?B?L1Q1dUptbGIzclRQQnlxbHF5ODdGa1ZoWVlKRExsWFFhd2FwOWR4blFQOWJQ?=
 =?utf-8?B?SmN5MEVOUkM4Q21JMHZwUjVXTk4zSW9zeUZSL2M5cXVMaDZvSnpXZVhEdWFs?=
 =?utf-8?B?c3B6Q29aWXdKUVFOTkU5MGJZeU10cEw4a1pndnlpQ1hKNnY3ZGVWamdIQjhk?=
 =?utf-8?B?OUxaaEJFc0NaNjRGeTZCd1pQR0dCWC9DcWtUSjQ2bXBKTHA1YVJnSFdMellR?=
 =?utf-8?B?QkszKzlucVdCblB6MmhkTkUvWGlxY213TVI1T3NtU0tnZ1IrVStJWk5VMGg2?=
 =?utf-8?B?VzMzcGJNTjlDUG5CTGFoNzNxbUcvdDhsdlRTa0RTaXZZQk9qM1d0OHBlUmhF?=
 =?utf-8?B?Q0VoMithSmczYldmeUJtbEw0dTRiUmwrOTE3MGhSTlorVmlUR3EybHpzM0ZQ?=
 =?utf-8?B?N00ybmVyc0ZlbE9pK2lnS3hwWTk2d2FiUFNHQVhSdzZXSE15U2VPNEYvTlo2?=
 =?utf-8?B?a1RYQlczNldIRGdNdWQ2MmE5d0tJTERLYWg0WnFuYUdqTFlURlMzQ1A5c1hs?=
 =?utf-8?B?K2w1L0Y1R05vdnUxLzczOGlac0ZSdVZoclBTbVhoam9rMzdZOXk0UXdmWnVh?=
 =?utf-8?B?cGllVXJLOUYvekdlMzVGUUpMeGRPbzhoQlYxcmgwSjlFdklqMEpMcUlSM09Y?=
 =?utf-8?B?VEdxb1ZJdzVFaUFBaUViTjBmN2Fxc1E1ZktzV0w1ZVZQRFlsVHVxaGFMZm9O?=
 =?utf-8?B?S3dKZWQ0LzVhcFRnd25RcWZ4WW56SHFrK0pTbE9mZlVHWUlXekx1SFA0QlJ6?=
 =?utf-8?Q?uhIhj5RhtfPGdLtAap1Rz4l7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6accca-899a-4684-95dc-08db70e6f2ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 17:02:22.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKcDeBwJXjkJaDm08sf+DaIOaYQ+5ryT0PeUyQhEVKWxuIDOwsCL8phosGGa0rhehRrECKkNuixBNguBBCB1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/15/2023 3:33 PM, Thomas Gleixner wrote:
> From: Tony Battersby <tonyb@cybernetics.com>
>
> stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. CPUs
> return the content of the highest supported leaf when a non-existing leaf
> is read. So the result of the test is lottery except on AMD CPUs which
> support that leaf.
>
> While harmless it's incorrect and causes the conditional wbinvd() to be
> issued where not required.
>
> Check whether the leaf is supported before reading it.
>
> [ tglx: Adjusted changelog ]
>
> Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")

Thanks for this fix.
This particular patch should probably also CC to stable.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
> ---
>   arch/x86/kernel/process.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -763,6 +763,7 @@ struct cpumask cpus_stop_mask;
>   
>   void __noreturn stop_this_cpu(void *dummy)
>   {
> +	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
>   	unsigned int cpu = smp_processor_id();
>   
>   	local_irq_disable();
> @@ -777,7 +778,7 @@ void __noreturn stop_this_cpu(void *dumm
>   	 */
>   	set_cpu_online(cpu, false);
>   	disable_local_APIC();
> -	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
> +	mcheck_cpu_clear(c);
>   
>   	/*
>   	 * Use wbinvd on processors that support SME. This provides support
> @@ -791,7 +792,7 @@ void __noreturn stop_this_cpu(void *dumm
>   	 * Test the CPUID bit directly because the machine might've cleared
>   	 * X86_FEATURE_SME due to cmdline options.
>   	 */
> -	if (cpuid_eax(0x8000001f) & BIT(0))
> +	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
>   		native_wbinvd();
>   
>   	/*
>
