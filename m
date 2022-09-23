Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A095E8442
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiIWUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:42:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6263115E4CC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0zeaaJ1XJ/iK8lfOVJYXl9rO8fWp/s7GVXM/MGr5X8yN7uqk1reSRuvnHsV6kSoN6gqa+M0rvnsVSztJCtheV4baYf7WKFwihd06uRwgA+LPzvEoAOR1Ym79d6oiRdFnm5+dyZrNilMdqq060wrNBvlBgW4bjJaPWP2BpFouAcuayMv2jVK/LVzaAPfs9AN1xvkELk6SpRmY9Ofl5J35TWMEVfTX/qwYgLlSmXT+1d3c0Ew3FMPh/AB2w5yU4ISau0GUnrK2NXThOwDq/34gebERaqxrxZmrnRrEsovxmdnt/mWdckPJ8qIcB5ASNq7SV6JDBmqP741+jJN+lsguA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSxLQNCuE8w9k4+unJpZopFwywxRwSTJ6XcHCEygeLk=;
 b=BoaTkoEa0eZlHqfXBRuxTf2fGS7UU56vE2NApkweabcbo5tCJyTegIFkvH+AL4MjGJMP1XAeQ163Eqch8Uqx7B3Sl48ukHNVaFypif9pPKj0J2Il3y0v0W2vJ8+zrxRg6dN0VoHsbZE7keQBEY0TVK047RSuzbhZ0Aw7SkvOOtRFlYwb9UTq9F706lpohhTBs86Y/5yVoucHRYO6aF7AKITCpj5by0aCf0oMYE/o67B5TCyc7FaqFQwqvdJkR8N0iKjEfb2HcvGPJ5lHv+3F8A/SgDEfY5E5sZrkvRnOmftxVp8pMI53vH0XzWnt0KV1ySH3J73I0+wUbEGO4jKwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSxLQNCuE8w9k4+unJpZopFwywxRwSTJ6XcHCEygeLk=;
 b=1HrEK4y6x9MZ8V8MTymnKuFGCJCewcAP+gEFrko8QBWdREjVAEu8+V7aLrrZvghiIkSE1BvJI3T+54/Ygbpg2KZ72wp2xVK+lHuVnGVQjbaDOcCy8qqneidTrZj3t03glj5jQjrt6WuGlN7EUeSqDPX4EKj98HFI2GCzlS47IPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Fri, 23 Sep
 2022 20:36:08 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::c534:ae1c:f7a1:1f33%4]) with mapi id 15.20.5632.021; Fri, 23 Sep 2022
 20:36:08 +0000
Message-ID: <775d8042-639a-1ae6-c099-9411e6027f40@amd.com>
Date:   Sat, 24 Sep 2022 02:05:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ACPI: processor idle: Practically limit "Dummy wait"
 workaround to old Intel systems
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220922184745.3252932-1-dave.hansen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220922184745.3252932-1-dave.hansen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::22) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: a9abd4cb-05a7-4d9f-3024-08da9da33e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcTI1fNM/+EETkXtjojMz+/ZqQ8UFc5OpluIU55OYULClazB1NJ4K17wdCmhbgQmgtcabKDepHDgdfrW8hBDUpwS69MYURaODEm4ARJStyYk3efAEX6ZZhtAzHcqyJzuKN62xIdj8p/UP4isaLFFnxja+SaW+912s4Gh5kcgm5bQMfvqwRHnQhhObfnXZ7UDqI+fkfu55D7mIl4a1AvlWaQjopB0jyLdyyBMF82/CLT7/IB8RunrOQXUWDdd5lxcceXohatA0895tsJxjB8P633HV0GzUyCcTB051qyjhnC1vmqxMtw/NnYVaWbyx3jbv4lCSkU5mrC5VqIDZ4erxeTQc8YJU/j5aVXtyhyhzvCIZhvNSHg5BpXXaJ9QzKyMJcIlScyputl4c7AaxudZrU750SLNxQykZPOrieLluTXqJg9Nwwetz6p8tW7fhdx9ReYHkDjlHt0g8Oyb6KDRD2Mbw1hz5AGz+E3BfxMB9GcNGMMUEbcCamOQKVlqe8Y4+0+hQ1PuEhNRiUeef4N5Q3KWgVAPfLxZUZtPOOMhrSZLLjzqbsLqWU232OG9zjOs1epctD4NPvWpdmxTPKIeeqF1vheUTM5VmWsaGwa609GnRXmWRDF06LkkHd3E/HN1lzt10n7H21LNfdqjxos25YmotNqMI5ob/l08ugCSRY2pMCOa/YT+NVtlVZtJ3IzxNQIUqjqER5nDTlnRerqwQxYNJlpb6zJSFeLvY1fuB1WeurakqA0+l3cKQkXN2f7WU6J2WxCHItYKID0kwTaAbslPmHDbEBvmh5b9r5IfaHxcuydxtKOe/xODJ4Rzi37pbMc2I4W4d7LE/dSTmlWJs00UxKNQdMCBuy8a8DtKbcDF6ZQ16vP/UkiQFCDAWXnx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(478600001)(966005)(6486002)(316002)(31686004)(36756003)(6506007)(2616005)(83380400001)(38100700002)(31696002)(5660300002)(66556008)(8936002)(26005)(6512007)(41300700001)(6666004)(53546011)(54906003)(66946007)(66476007)(8676002)(186003)(86362001)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blV3V29tdVR3TWVWT2UxRjNLbTJzcEJRR3hneXE3SmI1NzhYeUN5MzEwL0xG?=
 =?utf-8?B?QnE4N1RxWXpoQjB3M3VRbHViU1I4Y25WK1pxY0NrVUthcFdELzNNVW4rQ3lH?=
 =?utf-8?B?Sk15NjhIMWxBOFpBZXVXMTA2YW5zRHE2WEN5SHVqazcwSUlEYlVUc2IrTG9x?=
 =?utf-8?B?aEVwOG5lc0Y5OTVJT1U4QnBtOXpTWlNGbXVBMDNmV3gza1JVbmpxcjhiMldM?=
 =?utf-8?B?VmZNbWhKRW1TdHp5U2lBUEhyTkg1R2Rteks1LzErRE1venNVNisvZ2hnbFRt?=
 =?utf-8?B?dVFXUHdDdXVSMnVwdnhwTjZuMnZ3cnVTdnM3ZitUYlhwNFNBeGRQS0ZISGp5?=
 =?utf-8?B?UE8veGNxYnJGRWpjYlMvYnUxMkJCSUxmWStQbTE3VytCUDNTcUpiUmluL2RD?=
 =?utf-8?B?Zjk2MHpxekJTa2NibDhtUXUrK2ttSjJoSTNtMWFqTEFCbVh5djE4ODE1UWY2?=
 =?utf-8?B?dENreUNXeE5aQXFnOS9IcmtIc0Z2RVBlUjZtMSt6T2ZnUnIzL25NU2RoUFZQ?=
 =?utf-8?B?VWtEZ001dTFoUXJJNzlkRWpnVlFKU1RZeDlwa29adkRUM2ZsSXF3cmU5SUdu?=
 =?utf-8?B?QWlZeER6MGZNTHZyLzkvOUV6N2p2MGtkRzVkZWtYbE9XbVRaV29KL0RCTXIw?=
 =?utf-8?B?Ykk1ckpqZFpTSEUybFNRUCtwVE9paTQyTW41OW00STRUenJrUnRrZmd1TFNv?=
 =?utf-8?B?RHZDSXBscnpQS3doODhad2xtcDR3VEREZ3ZQS0JQMVpHRGpZMWYyQWtaL3Jk?=
 =?utf-8?B?dVdMM0huYVBqUDFKN3FmaENhendUdUxUcTBENjBoODc0c0NVYWZKdEVoMUNW?=
 =?utf-8?B?QTBOZ2hxMTl5WHNEY3cxajhRemo0ME9mQmN2SHE1TGZEblB3ZXZUR01kRG1I?=
 =?utf-8?B?S1BHNlFSWW9zd0tBYmhYeGY3b2FhRFlMOThEWFIxRm50TE1BUkptaUd6QjhK?=
 =?utf-8?B?OXdJSEE4QUhRWFZ2L3c3R2tibVNNYktXUFIzZmthaG0yZXoxN2JucWZDOG94?=
 =?utf-8?B?SzlaSmFpZm8rc3d4WlZGd2ZVV1NsUWlXYWx3VWhUcEhKTlVROTd0SnBmZTI3?=
 =?utf-8?B?VkJwK1ZaU2l1UFliNWtsOGd1WHJIejJaNkxzNlp1VEY0TnhmSkRYdHBoakhi?=
 =?utf-8?B?UHFYL2dTUTFYd1dCWjJWcFlTQUlySHB1UklwYUU2Qk5yYlZPZ2hEYzQrQ0Qw?=
 =?utf-8?B?b29zVlZMTFAxUXl6RVlhajZLM1ZvMDlHSFJQcWUrdTgvL0F4T1lGcmU2NW8z?=
 =?utf-8?B?eUcvNEhHMlJRSG5tNHM4SDJtLy90ZSt0M1k1M1dBKzhhL2plVjB0dUh4KzNT?=
 =?utf-8?B?cUsvMlozb1pxUGlHa1NWZDkvUW5LRnB6UWxvbllMU0NsWWFLanNSUzJnUmJ6?=
 =?utf-8?B?Z1BSRWgxb3NXMXV3ZjY5YXNUUDhERU11cGdFT1BzcDQxdm1kckVZL1dYQW1C?=
 =?utf-8?B?Y3MxRGpnaXRlQng5SU9PcGM5TmdyQ3NYSGRGL1dNampNT2s3ZnNIMmFlaTIy?=
 =?utf-8?B?UmF3WEc1SGtFSEZrU1NyYjYrNGZEbHNOWDhjaUl5Zkw4L1h0aG1ETDF0U2R4?=
 =?utf-8?B?eWJCbWhQNG53dFU3RTNsSm0rUEkwOW1oWkM1R1NPV1RIMGN0L0M3aG4xZ1My?=
 =?utf-8?B?a1ZiQmFuQ0tpaGUvN2FNcmdqcnM5c21xdTlYNGh5MDk1ZmR1bkpyOUduL1Mx?=
 =?utf-8?B?aWY4aEdYaE4vMHNEcU9jWS8xTVVLem9xQUhZZjlCRXV2bmJnUk1NTTFWMEl4?=
 =?utf-8?B?WjJTdkpEcjBtL2k4RUxORmFGZ3UvU1hEb3VhdEoxWXF0VXNCUGhNWGt4Yngx?=
 =?utf-8?B?UEE0d1NUZnpVNGtGWW9JOTdyc2s3ZnVyRUJSZ0dBSC9NN2ZwbkFjOEZhQ0xT?=
 =?utf-8?B?OVd3SXpkWndaMWdkTmxzSXBwU1E2My9nbkhwS2FwUmZMb3NyNFduSFdMT0ZC?=
 =?utf-8?B?WVh4M1pTOHNWcVQxc0xvWVpwZDNLREwwTFBOQjRlNkczZmNvOGZQVTFxNzNE?=
 =?utf-8?B?bHRSSmx6TWlvSTlsUWdkZmVCbENybjlnRzdjSUFqNStZVVIxWkd5RFljcVFj?=
 =?utf-8?B?T0EyeFNuQklYTkU5ZU9mZVlad0pBOGlJQm1uWFZGb1oyelo5NW4wVGhnQVdk?=
 =?utf-8?Q?Tzw+L+lhdQ0sd78Le3rwiixw+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9abd4cb-05a7-4d9f-3024-08da9da33e74
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 20:36:08.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHH5MkCe5nHA401YZsIwtUHX7ydcva86wf5su7muHONnzAav021TyJzTiEMchAB0huVij2e6JLbuETZBaDCTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

On 9/23/2022 12:17 AM, Dave Hansen wrote:
> Old, circa 2002 chipsets have a bug: they don't go idle when they are
> supposed to.  So, a workaround was added to slow the CPU down and
> ensure that the CPU waits a bit for the chipset to actually go idle.
> This workaround is ancient and has been in place in some form since
> the original kernel ACPI implementation.
> 
> But, this workaround is very painful on modern systems.  The "inl()"
> can take thousands of cycles (see Link: for some more detailed
> numbers and some fun kernel archaeology).
> 
> First and foremost, modern systems should not be using this code.
> Typical Intel systems have not used it in over a decade because it is
> horribly inferior to MWAIT-based idle.
> 
> Despite this, people do seem to be tripping over this workaround on
> AMD system today.
> 
> Limit the "dummy wait" workaround to Intel systems.  Keep Modern AMD
> systems from tripping over the workaround.  Remotely modern Intel
> systems use intel_idle instead of this code and will, in practice,
> remain unaffected by the dummy wait.

I've run 30 runs of tbench with 128 clients on a dual socket Zen3 system
(2 x 64C/128T) and do not see any massive regression like I used to when
we were hitting the dummy wait issue:

Kernel        : baseline      baseline + C2 disabled   baseline + this patch

Min (MB/s)    : 2215.06       33072.10 (+1393.05%)     30519.60 (+1277.82%)
Max (MB/s)    : 32938.80      34399.10                 32699.30
Median (MB/s) : 32191.80      33476.60                 31418.90
AMean (MB/s)  : 22448.55      33649.27 (+49.89%)       31545.93 (+40.52%)
AMean Stddev  : 17526.70      680.14                   1095.39
AMean CoefVar : 78.07%        2.02%                    3.47%

The range is well within the variation we've normally seen with tbench
on the test platform.

> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Mario Limonciello <Mario.Limonciello@amd.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Borislav Petkov <bp@alien8.de>

Can you please add a cc to stable?

Cc: stable@vger.kernel.org

> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Link: https://lore.kernel.org/all/20220921063638.2489-1-kprateek.nayak@amd.com/
> ---
>  drivers/acpi/processor_idle.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 16a1663d02d4..9f40917c49ef 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -531,10 +531,27 @@ static void wait_for_freeze(void)
>  	/* No delay is needed if we are in guest */
>  	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return;
> +	/*
> +	 * Modern (>=Nehalem) Intel systems use ACPI via intel_idle,
> +	 * not this code.  Assume that any Intel systems using this
> +	 * are ancient and may need the dummy wait.  This also assumes
> +	 * that the motivating chipset issue was Intel-only.
> +	 */
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)

Based on Andreas's comment, this problem is not limited to Intel chipsets
and affects at least the AMD Athlon on VIA chipset (circa 2006)
(https://lore.kernel.org/lkml/Yyy6l94G0O2B7Yh1@rhlx01.hs-esslingen.de/)
To be on safer side, the exception could be made for AMD Fam 17h+ and also
Hygon as pointed out by Peter, where we know the dummy wait is unnecessary.
Extending the condition you proposed, we can have:

	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
	     (boot_cpu_data.x86_model >= 0x17)))
		return;

It is not pretty by any means which is why we can use a x86_BUG_STPCLK to
limit the dummy op to only affected processors. This way, the x86 vendor
check and family check can be avoided in the acpi code. A v2 has been sent
out tackling the problem this way:
https://lore.kernel.org/lkml/20220923153801.9167-1-kprateek.nayak@amd.com/

> +		return;
>  #endif
> -	/* Dummy wait op - must do something useless after P_LVL2 read
> -	   because chipsets cannot guarantee that STPCLK# signal
> -	   gets asserted in time to freeze execution properly. */
> +	/*
> +	 * Dummy wait op - must do something useless after P_LVL2 read
> +	 * because chipsets cannot guarantee that STPCLK# signal gets
> +	 * asserted in time to freeze execution properly
> +	 *
> +	 * This workaround has been in place since the original ACPI
> +	 * implementation was merged, circa 2002.
> +	 *
> +	 * If a profile is pointing to this instruction, please first
> +	 * consider moving your system to a more modern idle
> +	 * mechanism.
> +	 */
>  	inl(acpi_gbl_FADT.xpm_timer_block.address);
>  }
>  

The patch, as it is, solves the problem we've seen on the newer AMD
platforms with large core density that use IOPORT based C-states.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
--
Thanks and Regards,
Prateek
