Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5896725EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjFGMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbjFGMTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:19:34 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867E1BD7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4+mywNDdj1rEmT6KukK7BBIbDAb0xB77cYGlsOIU4mOSyRIvb2VvN8zsP/IX8HtwsxiZZ9H2ZmGTWlOZapwwhOICxe7K+ku0r8ktpk5KBH9/mjF8ASySfm+NT+3P2iQHHEeHwZVn8VbOHE38DEOTLuCEITMB6H11E0f8alflesKCv5L7OFGn3dfQieexUf0RIgICetHOgSX/gxb7yzpDMb1B7axJBWqnUWcPeP4rSHHVMNK3ZdX3XsJIbvkf+AjrV0M46vNtkya2Cam0RiQ0Zljwld7Jzsm0uZ39oEOAtUeHt9vIAjMmaPTMjzKT7cABkKHAwpHTVkHFBXMKCe5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkFJr1bPNuT+2C8dHDYP1vrnChnZ6HuuRkTrWNfHB2Y=;
 b=baYcj84MyHvVIxsqr2gTnE9bOH7zWYMdt5I/OW/1P9vM1zAfbNN17YoN7/cRe4yQK832ckG4Py+cGUGTWOKGAR4cli6PBcmleL7E5tTwmGMLZpnztY+UVOgP2F3PQRTCcCC2ENtxNVi42/5OCmfKvU/ajeekAlMQWd7Cf06K7ZlcEVqHxIl6vU5sRT+RsW5JF7dF086pGluft2FClJztvkJTaoK3ynVjHZkqChGZIvYCUqHNAHpuKnm2GKq823Kx2gUIS8PwNVxLR+IC4t9Vwm9HGArYom95FRpyKQrmVJ9fIidcR2CkDWzEGwfINgSa2Kk9ZKslrgUD/XOIeM7pPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkFJr1bPNuT+2C8dHDYP1vrnChnZ6HuuRkTrWNfHB2Y=;
 b=gBTTgUnk0z+FWUh6HaXOCE3f4Da0ioDDd4JyT2JoQu4Yq1CStNlClWdNrUXL8qWeGv1LfJjcB7Ovq6HfPo5rNJr51iAoWxIWjO5D8/OHH/lRGOlATYKJn+EUWw0CO1FhqedZXwXB36sRhY+mu7dC9bY56S/wrdKE3labQYxQ2zXwAAqyi0fZuYYhe4of+X217jD97myMCExK6nkIWFSV4Ni+fMvj8baLhwoPw5uWOYeLkcp4zHJZw2khO4EKYgdlw+iFYTde6dzw/ko+tbcNWUwxxmP/KmzL27m0N00/wAIRBEBzguH/B0AY0/Erp+PPRFyQskPz6q/xkxBn5ShjMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:19:29 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:19:29 +0000
Message-ID: <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com>
Date:   Wed, 7 Jun 2023 15:19:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <87legvjxat.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb36886-ba1a-4aaa-d881-08db675170ef
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKvlpzzDKNQmHrQYCMDpR7uztxhy5ZpnhQhEVYA2fG4rw+POByzPnGHsVII/gB7CTYLjBrn3LYpNUiO6ITOap0nrigepc6HoUfaMT5jFLMU+N2nqJ5U4PYgaUUnDfb+eC0pDcT6wrMggoDCxKDJ8OCE5TXGX/Zf6szmTCCkRA+CNhdKkNHKqKDWc94Z00vyRbIJqXCvhYecXrE0ALZ4ZC0lHIqvZrPal2PFzdLy5A6XB+4YxgXS2kLWJQce266DHBObQb54lPDjvEBg3ngo5sEqd/IxZxxJlwaHFNezp77MplaIaV50BOVxbKiDQp+qYw19c2I794aixSRxigg5q280Zeyp5juE2lLmFPHq9h7fPCVHtw0rk4Efcp5yRcQ53L98PRd7Zpv9r1IeuEZzmRc+vKU5bDq8UIrCIMnWqsQV+LhVtxcNmDYiXqDNhJAXizqpSk3lveEpoa6+Ql0s7H6wpoTSEV0HqAQGRyLlW2VG72WNfkw1e6fGHeyp8QDxjAAMZyYuVhmv14y/pOPomk70DP0ABTp8W2QeKioMLghjpNzQ3fN/YoICl9vPvHVJnWCoCCIVgow92BgxVUNHLiDUgBxMubSBrNMxIINyfEDGW6maD20HYZelo0FCUl/9uArOL/u6sSecSLon14R7Z0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(66476007)(66946007)(2906002)(4326008)(478600001)(8936002)(8676002)(31686004)(41300700001)(316002)(66556008)(6666004)(5660300002)(6486002)(6506007)(6512007)(38100700002)(186003)(2616005)(83380400001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNyR0liMHRpRGxNU1E0QkFNdlRMTlRTQlRhYVBraG9JZDRFbmE2a1ZEemho?=
 =?utf-8?B?dmF4UXFWMUdWRW1IcCsxR2ZmeGxCR0c3Umx6U0RWRlExWHZrOVBmRmo4emp1?=
 =?utf-8?B?aXNQZWFzMjBXMDZQOUhGQXRYT0pEYkFmTWNrMWc3b1JsREU0RXlKcnJHZzZn?=
 =?utf-8?B?THgyak5yazZTaDZMNThVVitxKy9Xc2E2MGh2TUh4cVF2a012eUlrZXNBaVFn?=
 =?utf-8?B?V3pVaUU3MUh6bi84NkFuUUxKalhKdm42ZHZZNjVWNlRITUlLU3l5bWNKRksv?=
 =?utf-8?B?TnEwMmxncGFyUDNZQlVsMXBSL2FWL3hVeE9sWUZkWXBGNUduV2pVNGlZbFNh?=
 =?utf-8?B?VTVrVDMyUXRBUnRXK2RvSjluellKZXBlYmloOURsaGJ4bW1lTVFHRnQrUkcv?=
 =?utf-8?B?OEhQc3phYjVaMENwdklFa2JKZ2dRVTJ1dVpQOFZTQWxKN2c1SitUbXVORDVI?=
 =?utf-8?B?elBEaWVmb1BBYUlZU01TZGo4Z2ZTU2lJTXB5ZEtNL053b2FuZGVlVFB6cUtx?=
 =?utf-8?B?UzdLZW9tNm5DUW05bmR1QlVrRkY5OHVJczdBemxsYVNwb1c3RU15TG02ZE9u?=
 =?utf-8?B?b0lMbEpNU0JHRzZEOXNFWWFHeDVmVEVvSkg3M2FYUzEyTjZzancyT3llOUMv?=
 =?utf-8?B?YjZmSE5NNWVCdlBRM1p4OTEwNVBhT0VsOGdjRWZjeDBIZnllUVJBeFpWNVBQ?=
 =?utf-8?B?dWdYWS80a2NaV1RoZExxVDVLbTJVOVJBWDRibUh2V2gvaXllVmNRQ2FZbFY2?=
 =?utf-8?B?SzVKd1E5dzhSNzF1SzVHazRNTHBRRlEyRUhHUG9JemV2SHZmRW9HSDB3QVJq?=
 =?utf-8?B?SmVKUC8rbXNuQ0M0ajNqOVRubU1oM1FxQ29OSGVreTNnSmhEOFpQRlY2emxO?=
 =?utf-8?B?bE1PL0Q3d2duekpGRXpaQW5SVlRHU0RncUtNc1cwL3RzM2JvM3EvZW1saVBB?=
 =?utf-8?B?QzArcS9NUlMrOWx0dmVyM1g3NmV3M3JnLzFuVGhBTkg0c095SUU5ZlM4RVht?=
 =?utf-8?B?ZWJUMkNXOWljc2I4aFRyV2plS1FoTm9GNElkWnZvY3RJKzlJQUVuaVIxWXBx?=
 =?utf-8?B?MFlKcTRlOFhURWVRU2s3YkZMRWhvTjBxWUI3UHFBcStzTkJMZ0V2QWJZaGN2?=
 =?utf-8?B?dDVzc0dTdUdyWXVvem4vQ2QzbC9YZmo2Vzg3cVZWWEl6cHZEMEM1bDdwbnRU?=
 =?utf-8?B?b2wyWmlibVhvclhRVzZ3RHBzbko2cDNoWkQyNFJpTXpERENsaEJLTEtBMzNu?=
 =?utf-8?B?WmNrcFowWEFMTnRsOVZBR2o0bytJQ3dzQVJSZHd6Zjd0N2ZuRGd0QVNGZVRm?=
 =?utf-8?B?RTlybUhwUExkRmRIMFQrR3g4ZEREWklRNTNMUjVFTnFMcWQxVHBmWitXRzJQ?=
 =?utf-8?B?aXdTV2FEYTNWRXRodktsMDVnZkdEbVhodEJlcjVHV2Z6U1p4TUVFYUx4bURT?=
 =?utf-8?B?QzN5VTJobzNVcHNhd2RjMGFaUjl0MlJCSUJnYkdTZWpvRHp3L0oxcW9iMzU1?=
 =?utf-8?B?dWowKzcvZzZWZXAwOWpHSXVOVHNEeFgrNWNxbkZhZlUxeWdqMmhXVUtpUXdV?=
 =?utf-8?B?TUliek83bmUreFNoQWtKVnRWUnRSYlFNM2V6T1l2NTBqZmMvZXR3Qlkxenp4?=
 =?utf-8?B?aTBhbGZ2eDhyVmlLY296eTREaWszaTltcVFKZVVvbEh2UXZQamx0NUdlbXJT?=
 =?utf-8?B?UFlrYXZGQTNEUWpvSjBReCt1VVdNaGV3VW05aEpkeDlkdytNSHNiUFEvdnhh?=
 =?utf-8?B?ekVDRmkzV3NDYnhSTmh2OER2NUd5c3pWVFNjSXU2VTFDdDFwTEVCQWJxcmN1?=
 =?utf-8?B?OWs5MDNSSGhYZUh0US9sQ01pcjhiRi9CbzFlU3ZmS1lHS2JYbWo1MlA1VlFj?=
 =?utf-8?B?Ylh5QTJpWERQSVF5eURsZzFhSDJPL1JNakEwQk5qSVdTd2NkMmVYcmZ6THY2?=
 =?utf-8?B?b2YyRS9wZnM0WnQ5blRrelBZVkhjL09USllRQlVaQzlUVEFCSzhZN0xkZGg1?=
 =?utf-8?B?STRRVExZLy80aDJYRnhYS1BtVmM2bWpHZkxRb3Y4QjNFL2JEcHFjQTJZUDho?=
 =?utf-8?B?RnJSYU9BK256d1VHdE5QMFh3Q2hwU0tIcHVQZWt3endwU2tVa1dwRDJBcDRN?=
 =?utf-8?B?c1Zmd0FDTHJCZmRmV05GbnNzYVlDbEh5a1ZxNUNMSUZHeFpFemtZbmhrWXZ0?=
 =?utf-8?Q?8BgQbtjqjZ5+q8trmA/gr8coobMDmLsescglA64hdmTs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb36886-ba1a-4aaa-d881-08db675170ef
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:19:28.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlaPikTkdH8qwnY4C/vvyF8E+vwHGWDDNa5+s12ZOAHbuu/eJIhUKhs1ONnx9acxb5dO7om9TszcOa1BrDqwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.06.23 г. 15:01 ч., Thomas Gleixner wrote:
> On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
>> In addition to disabling 32bit syscall interface let's also disable the
>> ability to run 32bit processes altogether. This is achieved by setting
>> the GDT_ENTRY_DEFAULT_USER32_CS descriptor to not present which would
>> cause 32 bit processes to trap with a #NP exception. Furthermore,
>> forbid loading compat processes as well.
> 
> This is obviously the wrong order of things. Prevent loading of compat
> processes is the first step, no?

You mean to change the sequence in which those things are mentioned in 
the log?

> 
>>   
>> +extern bool ia32_disabled;
>>   #define compat_elf_check_arch(x)					\
> 
> So in patch 1 you add the declaration with #ifdef guards and now you add
> another one without. Fortunately this is the last patch otherwise we'd
> might end up with another incarnation in the next header file.

My bad, will fix it.

> 
>> -	(elf_check_arch_ia32(x) ||					\
>> -	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
>> +	(!ia32_disabled && (elf_check_arch_ia32(x) ||			\
>> +	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64)))
> 
> If I'm reading this correctly then ia32_disabled also prevents binaries
> with X32 ABI to be loaded.
> 
> That might be intentional but I'm failing to find any explanation for
> this in the changelog.
> 
> X32_ABI != IA32_EMULATION

Right, however given the other changes (i.e disabling sysenter/int 0x80) 
can we really have a working X32 abi when ia32_disabled is true? Now I'm 
thinking can we really have IA32_EMULATION && X32_ABI && ia32_disabled, 
I guess the answer is no?

> 
>>   static inline void elf_common_init(struct thread_struct *t,
>>   				   struct pt_regs *regs, const u16 ds)
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 71f8b55f70c9..ddc301c09419 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -2359,6 +2359,11 @@ void microcode_check(struct cpuinfo_x86 *prev_info)
>>   }
>>   #endif
>>   
>> +static void remove_user32cs_from_gdt(void * __unused)
>> +{
>> +	get_current_gdt_rw()[GDT_ENTRY_DEFAULT_USER32_CS].p = 0;
>> +}
>> +
>>   /*
>>    * Invoked from core CPU hotplug code after hotplug operations
>>    */
>> @@ -2368,4 +2373,7 @@ void arch_smt_update(void)
>>   	cpu_bugs_smt_update();
>>   	/* Check whether IPI broadcasting can be enabled */
>>   	apic_smt_update();
>> +	if (ia32_disabled)
>> +		on_each_cpu(remove_user32cs_from_gdt, NULL, 1);
>> +
>>   }
> 
> This issues a SMP function call on all online CPUs to set these entries
> to 0 on _every_ CPU hotplug operation.
> 
> I'm sure there is a reason why these bits need to be cleared over and
> over. It's just not obvious to me why clearing them _ONCE_ per boot is
> not sufficient. It's neither clear to me why CPU0 must do that ($NCPUS -
> 1) times, but for the last CPU it's enough to do it once.

Actually clearing them once per-cpu is perfectly fine. Looking around 
the code i saw arch_smt_update() to be the only place where a 
on_each_cpu() call is being made hence I put the code there. Another 
aspect I was thinking of is what if a cpu gets onlined at a later stage 
and a 32bit process is scheduled on that cpu, if the gdt entry wasn't 
cleared on that CPU then it would be possible to run 32bit processes on 
it. I guess a better alternative is to use arch_initcall() ?

> 
> That aside, what's the justification for doing this in the first place
> and why is this again inconsistent vs. CONFIG_IA32_EMULATION=n?

I'll put it under an ifdef CONFIG_IA32_EMULATION, unfortunately the 
traps.h header can't be included in elf.h without causing build breakage.

> 
> The changelog is full of void in that aspect.
> 
> Thanks,
> 
>          tglx
>          
