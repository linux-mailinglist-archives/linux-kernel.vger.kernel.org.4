Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1434A6EF99F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjDZRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDZRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:51:07 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B210EA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyQK2VmIu2ZZaskql/D6t6zC3jynS1HG7ylipVptv28Igzs5V+mmiHxQiLxzU/wOsCC1Iu/RzcPxy4Cw9BOWoW4VBLwuVrQk/18O338FFYjT1d1srqC8SniKsEIQQFrEfV7yvoW3pcxgr/ciQX0e7Gevy/B6J3gScyr5RuN0CRAWldnfioEOMwmk4udr58/YbyUpC0wGKiKG3TDXmNQdwdoayLd7wLt6HKDTqG0cC+Dt9MhMUingquzwGP5SK1Q0N0/OSwfZBks3REOOsAeW85pHjszMEVXcGVBJxKf6DGof37KtD98xAsDVY1X9qk269BWSaSGlp93SaGBBB6KaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNGQXvqvlztNxDzmx+y7US0+tU3PRQgpqR22QGASiYc=;
 b=iDa3jJcPEoRLqdC7TgPg9mauETb+YnVoa6hLIXsKUVBWmcCSiggQpO0AeXPBbF4t3ywbNpEUyRH4nFveN7GVZuNRYfsc4RutQSn7V8md7y7REnMpsl6GUTPTNjyXNKgN4zDJQwfqFjnsA9gBYBy9ZDOhlIHJf02e//d1D1MkO6UA5qvLApUjTEs1Nowt/ntONeThZ+ALGpAWRYR66kLsnuMFGnw5/3NU+ZUJ3OmBZRZA0vZWUDvpspE1OweE0hBKP3mEfstq0KeTeVjvWTy7pFtJVrKKTC23Cglq4QLJAC2H8yMI4EWCVbZAHa7L1vu63PYpYKL2iJTq/nQ0ALLfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNGQXvqvlztNxDzmx+y7US0+tU3PRQgpqR22QGASiYc=;
 b=HzyoC8d6DuIKWSqgdBCA8JET2ss4vCB/vj4tAGRbLpUv7t/IScxR0GBvdHpWkYBdd+y4Wlr3gAg/BDXWUDDMQPWkN8VOhLzr/+iPamwYRsr1HJHpFXAj3LNCQDYTk32jBCEmauaDLVjHVHS77hiIO0xkSUdZXAMnqifA8XHCHpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 17:51:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 17:51:03 +0000
Message-ID: <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
Date:   Wed, 26 Apr 2023 12:51:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com> <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:805:ca::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 966d2bec-e4d3-4f1f-89bd-08db467ecd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lexSUeIjDtB+m6rGE8kHCRYpD+01eKh3ki191zC7PZrYVzYGvrD98hPdGWGdjbnOahvMuYikiMQf3rv0iF8Nsy19yyi8q6WVciB8trGjUkwZGdKmMdgy0ExFtduRzRzofgt6qawzO+zUGwEh2SqIbzDCYgFgVGZWkLogbCJD891mYEeEC1UYLOZarZbR99824OexznDfBZQUafc0dVeHo9aA8aGD4He8PP3mrL679+KXqOuJ+NdUjtiIshyejpiWWqxQHZAgJVFvmkpfOkavuLrU5A+N60t2PPrKdwMZi6WYe7v350fKSDESoTSttCTFxbu7vR4rd4kbU64qmpq9Yc3ipeXLXU+l9kmdhPnIP0fYEN7a3WEJ+i8UNiY6B5QcNXPvh/Ili0wEOh1PzqzdTqw/hBfAN9ds45i66Ar3OD3YNH2fL0L8LXEV2cOz2NANCWHg+dINGX6xYseD16Z0QEcUIlmyCI2l4b3F6917goNsoATuQlDxc4YX8AUXjfrpalBSWGSKPMOxcc2U85JWDn2jlpaGpxsU38AzmpfYRJ2lp2/+iBGX7J2DCS8+DWBJbX0Huzn76Q8aWEhmu3Acic3+lwmEN8aUzfsmYjXNPZZZhjuuI3/t0XWvfG/J5Y96r5SzHZzEpP6l8gn/C4N9zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(36756003)(86362001)(31696002)(54906003)(478600001)(110136005)(6486002)(8936002)(38100700002)(8676002)(41300700001)(66556008)(66946007)(316002)(2616005)(4326008)(83380400001)(186003)(66476007)(26005)(6512007)(6506007)(31686004)(53546011)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1RIcEtxWS9DK1gvNUdtL1RhZWRIRVl6a2FPclNhYXg0dllUOGJQOU91bHNO?=
 =?utf-8?B?SU9Od3k3cGI0bGpZUTdTcFdZN3RtVFd4a21KQlNqcmZKaWpjV1Q2VUpRZHVT?=
 =?utf-8?B?eWtPM28wOUZBaEkxdDEyYVFTblppQlpSTm01NUdxRlJ0NzhaODh2MnNaZWpO?=
 =?utf-8?B?TkxTNEhkWnBXSlVRL29rUFovOC9GZlRtZkRYcDZnT0pxTXpjVUhCcEF5cnhu?=
 =?utf-8?B?eDhyNmswYllCc0dDS2JRbEdvaXo1Z1N2NzZDM3dpYmU5Ni9Lb2tBOWkrQlBR?=
 =?utf-8?B?QkdtWEVJNW9nWE5jZEYzT3NzTXRCbFZwMTZOcHBRYklzTTJjd1FqWUpjVlMz?=
 =?utf-8?B?NUpWOEZDdjRyK3lEMTg2Z3ZDTmllRXRxSTd3NWJOR2VRK2JHRy9WNTdYdUFL?=
 =?utf-8?B?MlY4eEh3Z0xGYzdzbGRBRTRuNkRnUDVFZ1JZK0pPdXYwK1Evd1pSZ0ZDcngz?=
 =?utf-8?B?Z1FQTFN1b01SMWxLWno2TEwxQWdoSHl0SFRKekJtTEk5WWtYN050M2FLTlNt?=
 =?utf-8?B?Wnk5UTR4eTJueWd3RElraHRVWFhRSlBFMlZWdWZWZGFGRzk1eCtzbVZZdmVv?=
 =?utf-8?B?WDc2OGtia1VySjlSL3dQWktwMkFzMXZkNjgydkIyWFp4Y3hoNlJ3aDdlNjk3?=
 =?utf-8?B?Sk1zQXFLT0VLeUxKUEk3UWtkNmI2cjhjeGhGWFRMSGxtNkJZbmFEMGJzYmQ1?=
 =?utf-8?B?UXJHQjVYQWJjdHN0VHB3V05zQTJkb1RKZVQzc25WNHl1YXdHWVZXTWpNK3NX?=
 =?utf-8?B?Q2UzNENKMndRRGc2Rm5oSDRuWkVVc2pkb2JOaGFJQVJBb0x2WUdncmQzYS9D?=
 =?utf-8?B?UWhocW9nSG1OdlVhV0oyRlBEOUpTcmxkQVJ4QlNCdW1Sb3pqYWo3RDcrUUdP?=
 =?utf-8?B?YlZZU1RMTGJsS2FNYS9mNFZraENUcmNoME9BT3ZyNlpSd3NLWndlMHpqanlo?=
 =?utf-8?B?V2IyMlNXS2NJV2crMVo2RVUxSER1bUdYMXhnSExxUkJ5TFFvUlFsMENFL2NL?=
 =?utf-8?B?RmN1cDB2MHpEbTljUGhGNllvYWdpeFppcGpqUCtlZWd0S1pCQUZWRisrcHo2?=
 =?utf-8?B?bW1VTmNrMk5FcHIwM0c1QnRnVUExcXpmUk9EVVVkN2RJWVc5dERHVnkra2sy?=
 =?utf-8?B?VWJoY2xMQVlkUVJZS3JNZ2crWVQzS1p2L2dCYjZQV1JtU2RISjQxelpYZ2tI?=
 =?utf-8?B?bDRnVlJMR3dMTXl5SVQ1T2c4VHBKTHIyRG9VVDhSZmF0UmhtOVNXK1djQy9I?=
 =?utf-8?B?L1B0WlZzT01Kc3VNTTlzTDIrdENMM2JNSjRJUlc3NSs1b2FiODRsdmVmOEE2?=
 =?utf-8?B?SFFJTXVZSkhaVVYvdnRhL2lRVSswWFJQdkVFSkVlc1hDamlJSXpUbndabm1L?=
 =?utf-8?B?YS80SWtZNVFLWVdkT2tLM2wzdnJFOTgzR0JBWnF0alk0L1dnOU8rZXh5WEhI?=
 =?utf-8?B?S3BIR0l4czRxOUs3ZnB1eWZ0dUFMT0VjVzUwZWc4Q3FNVlJPRXkvcWJyTThR?=
 =?utf-8?B?ZnhBV1hVaXFDbnN1em4rd3JQcmZMN0ZGY0hDSTJ4S3lKWUNpRDRuSzlHRUgw?=
 =?utf-8?B?MlNwbTVYL1hIU0FTS3hVQ2FXSHJEc3J1dDZKbmxmY2w3R08vOFpONE1HR1o4?=
 =?utf-8?B?TGJuaVZVckI4RTlwYm0xdzBsNGRoSVdjMEo1a202UWdhTHhlR2hTdDNteG8y?=
 =?utf-8?B?Q3VtQm9HblNoQjdlU3dadjZNRG42bmk3VmppOU9SQlQ1VlhGazlneDZLTFdr?=
 =?utf-8?B?Ym1GYUI4b3RTUFpWOG90L3ZPS3JjK3VGS2ZIWmNkU2tuT3lKL1k3S3J5N0Qz?=
 =?utf-8?B?ditNdzBiTytFTkl0MVpRZUNnUUNKT3ZTK2ZIQ0VTQkFIMVJ5TTVYcHMwUU0v?=
 =?utf-8?B?UWR2SmZ4NjJENGVBY0p0Z0E1Mi9ob1p6dk4yMVNjbWNscmY3VituRGRNRndv?=
 =?utf-8?B?VDFSVTNNRlNZT2pPVXBwZjFMbm1HenBtZWdSa2krcFNVUnUybjBNVERnRktm?=
 =?utf-8?B?S3pFSlppbloxVklGWXh3eWRPNzVnSUNnVWRDek5Pd04vSm1CUXV5RHhuaEd0?=
 =?utf-8?B?UEpZSkoxOVVKeHdrOGJzVXNPL3FJVmk0cTR4cmVkKytOa0pvcUhUN1F4ajdI?=
 =?utf-8?Q?sbZn1bSS7uiCk3HPUg5ylrIjh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966d2bec-e4d3-4f1f-89bd-08db467ecd8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 17:51:03.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY9AZOvuO5alTMdy6mEGOqCDkSYhNFh5RDZC3tm5TdAUxhdJKKzoS7BqXhz4f4D8qlX9XKFMxcFVV7Sm+F+/fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 12:37, Tony Battersby wrote:
> On 4/26/23 12:37, Thomas Gleixner wrote:
>> The problem really seems to be that the control CPU goes off before the
>> other CPUs have finished and depending on timing that causes the
>> wreckage. Otherwise the mdelay(100) would not have helped at all.
>>
>> But looking at it, that num_online_cpus() == 1 check in
>> stop_other_cpus() is fragile as hell independent of that wbinvd() issue.
>>
>> Something like the completely untested below should cure that.
>>
>> Thanks,
>>
>>          tglx
>> ---
>>   arch/x86/include/asm/cpu.h |    2 ++
>>   arch/x86/kernel/process.c  |   10 ++++++++++
>>   arch/x86/kernel/smp.c      |   15 ++++++++++++---
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> --- a/arch/x86/include/asm/cpu.h
>> +++ b/arch/x86/include/asm/cpu.h
>> @@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
>>   int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
>>   int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
>>   
>> +extern atomic_t stop_cpus_count;
>> +
>>   #endif /* _ASM_X86_CPU_H */
>> --- a/arch/x86/kernel/process.c
>> +++ b/arch/x86/kernel/process.c
>> @@ -752,6 +752,8 @@ bool xen_set_default_idle(void)
>>   }
>>   #endif
>>   
>> +atomic_t stop_cpus_count;
>> +
>>   void __noreturn stop_this_cpu(void *dummy)
>>   {
>>   	local_irq_disable();
>> @@ -776,6 +778,14 @@ void __noreturn stop_this_cpu(void *dumm
>>   	 */
>>   	if (cpuid_eax(0x8000001f) & BIT(0))
>>   		native_wbinvd();
>> +
>> +	/*
>> +	 * native_stop_other_cpus() will write to @stop_cpus_count after
>> +	 * observing that it went down to zero, which will invalidate the
>> +	 * cacheline on this CPU.
>> +	 */
>> +	atomic_dec(&stop_cpus_count);

This is probably going to pull in a cache line and cause the problem the 
native_wbinvd() is trying to avoid.

Thanks,
Tom

>> +
>>   	for (;;) {
>>   		/*
>>   		 * Use native_halt() so that memory contents don't change
>> --- a/arch/x86/kernel/smp.c
>> +++ b/arch/x86/kernel/smp.c
>> @@ -27,6 +27,7 @@
>>   #include <asm/mmu_context.h>
>>   #include <asm/proto.h>
>>   #include <asm/apic.h>
>> +#include <asm/cpu.h>
>>   #include <asm/idtentry.h>
>>   #include <asm/nmi.h>
>>   #include <asm/mce.h>
>> @@ -171,6 +172,8 @@ static void native_stop_other_cpus(int w
>>   		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
>>   			return;
>>   
>> +		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
>> +
>>   		/* sync above data before sending IRQ */
>>   		wmb();
>>   
>> @@ -183,12 +186,12 @@ static void native_stop_other_cpus(int w
>>   		 * CPUs reach shutdown state.
>>   		 */
>>   		timeout = USEC_PER_SEC;
>> -		while (num_online_cpus() > 1 && timeout--)
>> +		while (atomic_read(&stop_cpus_count) > 0 && timeout--)
>>   			udelay(1);
>>   	}
>>   
>>   	/* if the REBOOT_VECTOR didn't work, try with the NMI */
>> -	if (num_online_cpus() > 1) {
>> +	if (atomic_read(&stop_cpus_count) > 0) {
>>   		/*
>>   		 * If NMI IPI is enabled, try to register the stop handler
>>   		 * and send the IPI. In any case try to wait for the other
>> @@ -208,7 +211,7 @@ static void native_stop_other_cpus(int w
>>   		 * one or more CPUs do not reach shutdown state.
>>   		 */
>>   		timeout = USEC_PER_MSEC * 10;
>> -		while (num_online_cpus() > 1 && (wait || timeout--))
>> +		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
>>   			udelay(1);
>>   	}
>>   
>> @@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
>>   	disable_local_APIC();
>>   	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>>   	local_irq_restore(flags);
>> +
>> +	/*
>> +	 * Ensure that the cache line is invalidated on the other CPUs. See
>> +	 * comment vs. SME in stop_this_cpu().
>> +	 */
>> +	atomic_set(&stop_cpus_count, INT_MAX);
>>   }
>>   
>>   /*
>>
> Tested-by: Tony Battersby <tonyb@cybernetics.com>
> 
> 10 successful poweroffs in a row with wbinvd() enabled.  As I mentioned
> before though, I don't have an AMD CPU to test the SME cache
> invalidation logic.
> 
> I will reply with my patch with an updated title and description.
> 
> Tony
> 
> 
