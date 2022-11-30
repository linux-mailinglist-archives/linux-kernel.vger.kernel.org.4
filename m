Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56363DF19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiK3Sns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiK3Snj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:43:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6082A268;
        Wed, 30 Nov 2022 10:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+cRs0gCu1VegmYM5GkGkofTp10f/cu9Dok+ZvAsgdr1nUGgrq9n8H1tsCLPHYZtZnsLJlxD6g0fUu1T0FsEXNe6mxU6ciRaEjJJHdF1Bpuvu4YGhuuI1XSxLnfHnRQoU9URX6GV14O9DR5+I6E8YhpjFT8I7X294+VcwQiIH3nJF36Hmji1glir2eBpvX3A5eKR4/XSj4SrRm0SLcD85bJ8ei0/+dUSQgpJ2wcoKGo+Px1K6+qOEf9Y1hYuxOmJRZ2evAijzniG63kcgEznBnBZBA/qmDlY1vyrhQHjg5VgFDj7Z5jA+r0ngFOz8EQA2Oz5wqrPET/4zalqjbPYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOjjAt/NyJbKn+856p1PP2MzsyDGDOiUyqRyrYeaPbI=;
 b=O/eSkplzD5F9XOd8LVLhAvHpS9UDBzUunaciPnUAXZNCJvrknQjzRVvLv0Ail+auXSz0P8KzFFFGO9Dd+wA9HiQr53/fD9Jy6TMrctofAGli1IWJ4LRc3nQUjv12fCj42b8RQn9l2GrlZnWmLTqzVqB6f3qSEmWLcxURs25x0HV295ZviHEqQDPpTQfp/9OGvSsOi+rbaQ+TrBn5Z4XWZwZzKWS5UQm6UhPOIcDXFrAWC/jWxJoybYUtpE80X5nIAfo+xdZDGci/+1zbHvEG17rcF+B76Lv7ddHIc+v5WwqtLqG9BCn33VFMQ/enw2Ootd8alVP1xTu7lbyGE5i4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOjjAt/NyJbKn+856p1PP2MzsyDGDOiUyqRyrYeaPbI=;
 b=CFz9pYo0Jz4FoMDpSZB7xNBhBW4JZlHbtKmWCVjcZHv9MM9ljku/jvYezSLX6AyVMP9sATZ/65WseNjzY58AjyhXGixqGq7Kn04n3H1OpusGPliEs2lsu9cIblaJIMt71wnMujbxtmMdXBfDq4EI5rawK8xjBJ/amCmWK34V/1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 18:43:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 18:43:35 +0000
Message-ID: <764c8eac-7b33-3850-3052-e6444ce496d0@amd.com>
Date:   Wed, 30 Nov 2022 12:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759202922.3281208.6231300030834095574.stgit@bmoger-ubuntu>
 <d2209b3d-374c-efdd-a91f-217f1db3b4bf@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d2209b3d-374c-efdd-a91f-217f1db3b4bf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: b39b2463-7bab-443f-cebc-08dad302c9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMMkNa8av18Bqgd2z8+CAaWXyGfyXpD8AtdtjMdLF/1WGUH01uQPCiHliNwYy33x9JEHQfs0rUh1jOkeOkUNDlcdSYHnGBR+3iPE8IZoZvpCVginwoDs+HPLtDv7q4aO5AsYtnHrr8ghneop4vOMgigtm+SKxO+ob39zNfwLND/SOhnbtm56s4GEklgszirOBOxLR1NNAPgKKxOrvlLzUu6yXh7q0+ZCNecj0XKmrhGTOA0cwJER4EKYlQGMoewDhz8/S+4PRsuQdgqcL/V7EHMfXn0zAvO2E/rlz0EQLKnVpEyta9yal3v2PoQvtSgnFjvx2NMajCxZBy5kOPJkHdlm7tleen2dOViblI1FMLz3JwR5bRIc2Kktolda+/JhIYSOL875JaYg9EEOFQkPC6kVBRUr4yoFUQvU/xsZYGZbalvpzIR+0vodDmDwTL1TaGiWo/YsDtxMCuIL+lqZWMfeRBNmJBC2qR8Noxy72oFc27z8vmc6UdiITS9M49gSSYocbI+49W0K6xMxgnrYY21dEbh+qs2inG6LYXvsTQt2RXbIhUe1zQu75Z977+7Z+HM+aRbTY/92worvMG1qHowMXVuJ7My/bNwZbduxdUK2b2ktBpoRK4pb+MbwRSkrr41Qr7yo9O8Uie6VLQKwDpeUZp/hJzDnrLrdDKR7ezXdkucABXzeg+9Qc58UUg1JxbuHH3RUB1dCivX0OXI5WI3+i0qv409bagdyAJZpiMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(6486002)(6666004)(31696002)(6506007)(478600001)(31686004)(186003)(2616005)(36756003)(41300700001)(4326008)(8676002)(53546011)(66476007)(66556008)(7416002)(6512007)(316002)(5660300002)(26005)(2906002)(86362001)(66946007)(83380400001)(8936002)(3450700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldUUDZZSkthZmgwUTdNQ2VUTk1lNnVUVUE0bGdtQlRXcUVySTBYN3hRWGZQ?=
 =?utf-8?B?Wk9tenpOTXpFeUd0L2VQNksxdFJtdE9Eak5vNUs2WHpLRlpDMzE1SGlvcUhv?=
 =?utf-8?B?S0ltQ2RmdXQxbStLM2lzckpqV2ZPZVZSN0l2RnRFNEg0Szl4OGVwYXdJMmtJ?=
 =?utf-8?B?RW1iNGZBZzRSa0YycWtrdG94SGZ4Sm5TZnVScFFjWXlyTC9Tb0FnZFljZWEr?=
 =?utf-8?B?V1pBY2dBZnJDOElJZVBVU3BHRGNrL2w0bjl5aVl2NmJwUWN5Y2tJRVhVdVF0?=
 =?utf-8?B?eHpRV1JueGtMem9UZXQ5OG9JaU9yMkMrRjZDcDM4VUhrb3ZrdTl2WkdCUzY5?=
 =?utf-8?B?amhFMFQyWEkyVWlRbEdsbCtZcGtLb1ROK2Q0MWhnSTliM0d4RHRTdC9raHg0?=
 =?utf-8?B?L1dQMGM1c2dibVZqVkJFVGE5VW9UaHlhYmNua0w2QUI2V3ZwYmtpWC81QW5N?=
 =?utf-8?B?QUhFZnRKQnBjalFHcjlUSjdpamJZTnpCdXd0OFNTUE1pRnFuTmtTd1EzSzRz?=
 =?utf-8?B?a3dYdzAzcm5jU0pwT2FraFdzcEVMMFZJbGhUcTFveUVzTUwrSCtwSDZocnc0?=
 =?utf-8?B?RUZWd0FwZUhQZW9sM0lmWmpYSEJaZEliajhlb0hCWmYxZklQcFgrMjUrQjRZ?=
 =?utf-8?B?L2dLd2VpNW5LdDN0THZtbWJhT0w5TE9NejNZWXoybWlHWDl6a1JMNUhzV3h4?=
 =?utf-8?B?ZUgyL1B2SnVodkxXRUtleHptcFQ2Vm43a2JHenRsMTV6bTNXK3ZlQ2dPN0JZ?=
 =?utf-8?B?U3pUendiK1hVbVJJVm1KUEJiU21tR1pvVFVHN3Vud2ppejN0dE9qbTUyNFhQ?=
 =?utf-8?B?dmlyQ2h0cGN0N1JPd2hYeGovQ0F2VU40UHdMWkc4eG5tZ0EzMG9YOTlJMTQr?=
 =?utf-8?B?RU4vZmV3Q1hYWDllcG43YVhXaXVPZ0VrM2ZmMVZ3NHV1NUtQU080NStMdGhj?=
 =?utf-8?B?Y09ldFdLdmI2aTN1QkFYK0d4eFd2QVVRQ1BFYjNwb0llUml6QU80SHVhRFBl?=
 =?utf-8?B?R0FRc1JoMHdqQXB5VkV0UlEwY3JkZUhQNkhsRXJJc2E0aW9aT0dSdXUwempJ?=
 =?utf-8?B?OXlyRXIzTm1ENnh0VkpUWThVdTdzdkx1V0gycFpOZDVLcldJSmpDVDR5cmdv?=
 =?utf-8?B?dXRrRSsrMUhHVUtrSVNFWTBYMkNidTV6RjV6R2E2K2tnbzhrdDc4UUtwV0tL?=
 =?utf-8?B?UStvblBiL1dUcUtiU3d5WHo1aUJJN2dxYmdEclNtY3R1aVhWOWZnemVwMDV5?=
 =?utf-8?B?TnRhOTlhTlh5V2JUQTFWRGtzWktXMUYzZU8vaWFOSUpVaGd2R3hkOHNtaXo0?=
 =?utf-8?B?cjhJV3BkVGxENXNUN3VURDQrcW5Da3lNT2NYWGwyT3BtTXBBb0pJNVBKZ0E4?=
 =?utf-8?B?enhMSHNmN2hORjd6WjI2Y2V1ZzZoT0pvU0x4VWc1ejAyVnhZL3B4azJaWnM2?=
 =?utf-8?B?T2dUUHNmTEczSTg2U2I4OWF6MWFvcUdNUXpoK3U2TVo1akU4anprUng5ak1n?=
 =?utf-8?B?RzNXQ0lYd2tYczZNMWl4VThMWCt0b0FGWmJBOTlGdDArbFRlazRQZC9Qa2dB?=
 =?utf-8?B?TzZaMEFBY1BVUTFaa0tiQmtRN3pvNGNiSUN1V0xvOWMwaEkvNlZ3Z1lvZG9o?=
 =?utf-8?B?Um5lQWs5TFlnLzE3bjJSb0NyUnQ4ckJPdGhYMXNZN0trRENrZHQ5N0dXaWE5?=
 =?utf-8?B?WnlTdVJJaXFsNFVPa3F2S3NUaCttREF5anRoT3phWmU4MUM3Q0g3VWZqbDRp?=
 =?utf-8?B?OWRENGtpa21CS3dwZCtyWlJuODNNOWlvbjJmZkJ0aGI3SmZ2YzJZY0orWEFF?=
 =?utf-8?B?S1dUeGh4Y2MrRTBCUlEvd05XUlRjdHZ6UytRY3JQU3paclZIblFEZGRscEVx?=
 =?utf-8?B?VWdOdE9mc0U5Q0p3MTM0c0VDRXBqL2NWVmt5b1Z3NDY5U0hFajI1K3hiTExk?=
 =?utf-8?B?UmIxaTZ6NEdUSGg1WlQ1NWMyc1d3MHJIQU91M2ovZjFxdXhPVDNKLzF5eFM4?=
 =?utf-8?B?MnVCZlBldEc2aEV4eFFJSFZ6MDBxVU9ZV3QvZUg5QTljb3BXUk4yZlQ0NW0r?=
 =?utf-8?B?ckVybnhJSE9HMUdJY1NNd0Z6c2xzMysxZGh1b3JuRHQzcnBFdTVXbjRqNDk5?=
 =?utf-8?Q?bDHo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39b2463-7bab-443f-cebc-08dad302c9d0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 18:43:35.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUfz4ziOSabgaH6NLZIQEfIkvVMzo8t3xKKZ5qhWsvdo5zoUwEVsGxyjWlzjlqhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 11/22/22 18:12, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/4/2022 1:00 PM, Babu Moger wrote:
>> The QoS slow memory configuration details are available via
>> CPUID_Fn80000020_EDX_x02. Detect the available details and
>> initialize the rest to defaults.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>>  arch/x86/kernel/cpu/resctrl/internal.h    |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>>  4 files changed, 41 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index e31c98e2fafc..6571d08e2b0d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>>  	if (!r)
>>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>>  
>> +	/*
>> +	 * The software controller support is only applicable to MBA resource.
>> +	 * Make sure to check for resource type again.
>> +	 */
> /again/d
>
> Not all callers of is_mba_sc() check if it is called for an MBA resource.
>
>> +	if (r->rid != RDT_RESOURCE_MBA)
>> +		return false;
>> +
>>  	return r->membw.mba_sc;
>>  }
>>  
>> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	union cpuid_0x10_3_eax eax;
>>  	union cpuid_0x10_x_edx edx;
>> -	u32 ebx, ecx;
>> +	u32 ebx, ecx, subleaf;
>>  
>> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
>> +	/*
>> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
>> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
>> +	 */
>> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
>> +
>> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>  	r->default_ctrl = MAX_MBA_BW_AMD;
>>  
>> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>>  	return false;
>>  }
>>  
>> +static __init bool get_slow_mem_config(void)
>> +{
>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
>> +
>> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
>> +		return false;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
>> +
>> +	return false;
>> +}
>> +
>>  static __init bool get_rdt_alloc_resources(void)
>>  {
>>  	struct rdt_resource *r;
>> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>>  	if (get_mem_config())
>>  		ret = true;
>>  
>> +	if (get_slow_mem_config())
>> +		ret = true;
>> +
>>  	return ret;
>>  }
>>  
>> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>  			hw_res->msr_update = mba_wrmsr_amd;
>> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
>> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
>> +			hw_res->msr_update = mba_wrmsr_amd;
>>  		}
>>  	}
>>  }
> I mentioned earlier that this can be moved to init of
> rdt_resources_all[]. No strong preference, leaving here works
> also.

I am little confused about this comment. Initialization of
rdt_resources_all in core.c is mostly generic initialization. The msr_base
and msr_update routines here are vendor specific. I would prefer to keep
this in

rdt_init_res_defs_amd.Is that ok?

Thanks
Babu


