Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67563E23F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiK3UkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK3UkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:40:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5819663D77;
        Wed, 30 Nov 2022 12:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2+UnABlNJjMepiWCuXsCEenjaQ7xL+/r/snAMImtx/lNabFc2lP9wpJ415xDDKIjemwwKEszHVdBueZoHQoLBuTgKfgJ0phegmN4+19hoY9+FA7eyV9qnOk4E6pDC5MI8t1iRLOodM2b73jlwHnsSd60/sg5jaIExqCysT5tduuWxn7TzP1zixvWjdpTp6JbFmijzkAw5AZVIFT1Hg7OjqyjvvS0ftY7plWIv9FeO2CTQLKzSrjjIL0bmbOHE9dENEmSRIkEw0asw6VqwAtuhO4zDUgUTYB4p7o3SzMs8+sjHZtzpzaYPP9iYs3BNc6QJUYrF2kaM8CR2LZvKmoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ln1HxUhATHcwT8K+hIZsQ4oHixR5DDbt2CARtE9MIDc=;
 b=Wy/NgiQpU6BQMxnmTW8eleYvrlWMd0r5gdfypsx9a0l9SJJ9GSr3AMSbjBLHMBBM0T87QIPxBfcUJZO2aF0YuSXIn/EBmi0akZHJqCs7s3LHAKF4QPWImW5D4fotjzE6CtgAQEKr7Q1fRinbl7VkVLOecVLevLcbytY8L1jOeFBxfqrEQzOXnqSvYFs8s9Iqh5RVDSXclWVRUdPXS97j6XV2pwatcy8uM06261dZeNGPScu0/p11yHt0FEQleLZNsmjgLBismbev2HgGW+M91Dnc2SnMj9I8Z0peZp36FX9dqak+kQ7bxjeCKavFr4mAdIVGM7Y01ADO3+LaNAIDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ln1HxUhATHcwT8K+hIZsQ4oHixR5DDbt2CARtE9MIDc=;
 b=COxSRRpefyJ3lZ53+S1Kl/Xa6UzGgSCb+XTWck8w/lV3aWA53HhrbOTq0h7IqGM3impQxBfAaVaveGDrNRGebrTUIAgMzYy+wpj00c98W7E7pP21HUrYVB5sjuCpkC9XI1E04951ktM7CCVUgi8w1TSKEMJV0cGE14aL9gcm2Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 20:40:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 20:40:08 +0000
Message-ID: <1b495f25-bc81-6181-e48d-729bf8211dc1@amd.com>
Date:   Wed, 30 Nov 2022 14:40:03 -0600
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
 <764c8eac-7b33-3850-3052-e6444ce496d0@amd.com>
 <5d17741a-c6a6-9ab0-fc05-673337b04a57@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5d17741a-c6a6-9ab0-fc05-673337b04a57@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: e13feb82-97b6-4325-3e49-08dad3131177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgxtlnWc7YEnv16Vh0ATPVrF8G6OtIFPwl3v3wzL5ncjEWvtowH4rk36l7kgFQ2/pgaEuCkLxWSle9qwer9uzEu/WnFQsnr5zPcz9m8ihZvGntSP54RXvrjGHWyzcIn6LEhiTYYQEBZjOWyi9+MvtFxEGaaPHnGIK7PHb3NvynZFTSwBgusCu0rGToR60+LZ7fR5GBIorQur6s6HwitMMm6wnP2YvUhsHVqmyqZDAVrABzEVGfw7ll1s9j+poIvvASO/I+fJ/vgIKT4OVRXu5uSTkWEoPrWcfCyrUJEkviOWfwv0TXBkOfWrN5DS6xKpVbSgj8jdgAtUJKmiYbi6GbL8mrbtfSz2br/yi8UGW+swNv3/fakGUK88/kei7J6NMxiEOqrGyP65+B3JnswChLm+oEU8YID2D4vGpbeAauaMW+1NWkdXwccWWh2hSp3ke9CDxHWEIbE79YbTiA7zQ3nk9s/W5j6tRxfKJFk7OHnR1pcp1qkANTxqpsOW7V++9sKYmPHGB6JyCvQ8prBx3Ru8Ns9LwyqHuFuxUEdIRCdjHThy8CCV6u/b8z70gQuv6W+F0F6Zbqi4OA6M5SK2GQHJYo3yYaLNlL8H7NruUbre/o1mTkT26D6LyhZmeJFv7+l+3P8mOxZ2SbPLMdlfsSotNli4oOwgNTvrXHovrGLUTx/F9v+85D4dXQvFEXl/tXgigQAWyxskWphbhMVAZeC5irj7A+HX79OCZ5MIOVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(7416002)(4326008)(66476007)(8676002)(5660300002)(6666004)(6506007)(2616005)(41300700001)(86362001)(31696002)(38100700002)(316002)(3450700001)(6512007)(26005)(186003)(8936002)(53546011)(36756003)(83380400001)(2906002)(31686004)(6486002)(478600001)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2V1ejVJYzNZWUNaZkFCbFZHZHZsK3ZLVVdmaXBwamFqY0ZMYVBrSkd4dWhX?=
 =?utf-8?B?Y2x3MkJudGE2cEI5MERlaGwzdDlOMWNxK0ZHQ2xLMktLK2s2WlUrR2VaN05t?=
 =?utf-8?B?M1ZtaDhWbU5YT0FZVFV1cXIydHRaYThrMW5MQTB4WUF6SjZYTk5FOW5KYWQv?=
 =?utf-8?B?VnFFSTcxQWszZjAwR1Z5ZHNLN0gxZEF2cmRBeStyalhZSHhWU0ErN0I2ZEpX?=
 =?utf-8?B?SUduMmxFaU9sVFhVenhTaW9MSitIeU1uT3RWb1hFclFXRElVUlpiRFVVcTZF?=
 =?utf-8?B?UFZ1V1NacTBmYW4wdzRGaHE5N0RYTWJQek5CdkVoZmlsczB1clEvQnh1WUhr?=
 =?utf-8?B?d051L1dzQU9kZUtrVjd0RVJhUEZnWjhaMzNqNEFtajZpcTZrQURteVFIcTFS?=
 =?utf-8?B?cmc5TUpDeXd1R25KVGFKRXpkUzJ2Mk1JZERKWHRpTXR2ZGthMENGMTliT0pM?=
 =?utf-8?B?UVJzZm05aU15ajZmeHo5RFc3YnZoSExWZGpvM2tSc3NSRlpYUU1hQ0hyYkdu?=
 =?utf-8?B?enBmV3RjamVGK0xMR3ZoQzJCaHdja1k3bDdkS3k2UDFEVGNBdmQzRkE1amww?=
 =?utf-8?B?TjU1d1oyTTJFa1FhQmw4QTZqKzlHNGd0TGt0bExBQ0dBRmxOZTM2RFpzUW9t?=
 =?utf-8?B?cGw3a1dncHFCeVBsejNoN0NXUWxVUk45RjBRQ2RVTDU3d2JDSmh0QzlHRE1k?=
 =?utf-8?B?NlY3S0JLVFlmb3o2RmRiQ1d5M0ZDRmY5b011VTZQY1BpcVJER1hWSENnZ2VH?=
 =?utf-8?B?UWN5UTAvS0ZjdTZiNWsydTNrS0JmdXZGaGViMVIrS2FiSlBPRWlOdG5HUGpp?=
 =?utf-8?B?RGcvNDkyUXY4YXNZMXp2Uk1wMXUwSmQ3bkwwMHIvR2ZaRXBIb2hhREt4ZWky?=
 =?utf-8?B?cVJSeTdjMnZQZEswVFNiV2R5d1lMZzA1T2VOc0k3MHgzbXdMM1N1emU5OWZu?=
 =?utf-8?B?MXBSQ0VrajlIbSs1ZzJlNURyM3IxTENSMWY2S3l4Um5aY0xVcy8xYkREUHBm?=
 =?utf-8?B?VzdVaVpvZjl4a3d4dVQrc0FlZXZpd1AxTG93TXp2R2paVjliMiszL240QXBz?=
 =?utf-8?B?cDBjM0pPZllVa1J2QjNiKytzc3c2YUVUTi9MOVdWcVZqWVF6RG9Jc0FNRzJJ?=
 =?utf-8?B?WW5ENTNEMjZDWis4QXdsOERGVjdwWUJpc1lUaldibi9jM2dRV09NZlErZWxq?=
 =?utf-8?B?K0tIc0wxVG82RkVhSGNkTjlJTUVadkNPb2xWTHM2RnY1aUlySzM2YzBkSU1B?=
 =?utf-8?B?cU5Hblc0RnZYUjNWRlBkcWNJMFFGZ3ZwNnlTaTdyVVNqWWkyYUw3T0ZLWm5r?=
 =?utf-8?B?VEVxZDRyVEZQbFNSR2RTOHpibzJXOHNLYUxweFNMODhjK1g3Z3ljSE9GM0RH?=
 =?utf-8?B?VU9hTWZwMnpLeVZ3QVhlNHN5NUM1OXAxV2d1czdpSUJWdTk2VEE5T1h5TFlk?=
 =?utf-8?B?amdURU84WVkxK0srTXU4Y0daak1mOU94Qy9zcHlFTjY1WGxXWTJjU1o1Ukx5?=
 =?utf-8?B?VjJLdlE4ekpUWE01Tm5VZndrcUpINFJydjc1SWpybVkzWDR5dVpJdTN3Uk5y?=
 =?utf-8?B?cUJmMi90MEpJQS9BeTd4OWtGbFE2ZVoyT3VQVUdmOTNaWjRHRWY0K0hFMEMz?=
 =?utf-8?B?SURndVFta25VSkZCeXAwcFZnWGVrclIxMlB4RW05Zldmc2hkTWdBak1XOGNF?=
 =?utf-8?B?VWlFelhvQXd1Q1JPRklha3BYOEJiZUIveTl5eFRNRW1JcEd5WXhENjFkaWZ6?=
 =?utf-8?B?dXBBNSt2dUEyVTRiMmhCS1ZvUExQRDIybk9WVU5ydFB6czhQaENtSXpucHNq?=
 =?utf-8?B?Vk05M2tkaTBHcG5XZlhBdnlNbCtLZFVRM082amFITDBpWjkvQmYxY3NBWW5w?=
 =?utf-8?B?MTN6SHYxQlZTb25Ra3NTZ1RjcllTYldKTit1Uk96dDU5ZXE4Zk1IZjA0UUpQ?=
 =?utf-8?B?UVllaDFXTnNHcUs5clB2c3hFRThUUlNIeGRBSDBRQkZpakNkd2JKM3RsZlJw?=
 =?utf-8?B?TlhYQ21SWE5NdFVBd0hNSTlMRVZFQW9DeTQ5UFRwMlhtRW95b0pxUHZtUWN4?=
 =?utf-8?B?RjJMUFZ5OWNVZGRQQUhad0FTZS9jWmFPMFdsVzNDcCs0amtXMXduYjFsNEYr?=
 =?utf-8?Q?0HJg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13feb82-97b6-4325-3e49-08dad3131177
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 20:40:08.0025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf8bi/TIHdKUc8Mnrpu226NkyA5YpIx88axSmcbT6uUnvY36Yg8IvNl/urkczyPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/30/22 14:07, Reinette Chatre wrote:
> Hi Babu,
>
> On 11/30/2022 10:43 AM, Moger, Babu wrote:
>> On 11/22/22 18:12, Reinette Chatre wrote:
>>> On 11/4/2022 1:00 PM, Babu Moger wrote:
>>>> The QoS slow memory configuration details are available via
>>>> CPUID_Fn80000020_EDX_x02. Detect the available details and
>>>> initialize the rest to defaults.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  arch/x86/kernel/cpu/resctrl/core.c        |   36 +++++++++++++++++++++++++++--
>>>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |    2 +-
>>>>  arch/x86/kernel/cpu/resctrl/internal.h    |    1 +
>>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    8 ++++--
>>>>  4 files changed, 41 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>> index e31c98e2fafc..6571d08e2b0d 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>> @@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
>>>>  	if (!r)
>>>>  		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
>>>>  
>>>> +	/*
>>>> +	 * The software controller support is only applicable to MBA resource.
>>>> +	 * Make sure to check for resource type again.
>>>> +	 */
>>> /again/d
>>>
>>> Not all callers of is_mba_sc() check if it is called for an MBA resource.
>>>
>>>> +	if (r->rid != RDT_RESOURCE_MBA)
>>>> +		return false;
>>>> +
>>>>  	return r->membw.mba_sc;
>>>>  }
>>>>  
>>>> @@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>>  	union cpuid_0x10_3_eax eax;
>>>>  	union cpuid_0x10_x_edx edx;
>>>> -	u32 ebx, ecx;
>>>> +	u32 ebx, ecx, subleaf;
>>>>  
>>>> -	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
>>>> +	/*
>>>> +	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
>>>> +	 * CPUID_Fn80000020_EDX_x02 for SMBA
>>>> +	 */
>>>> +	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
>>>> +
>>>> +	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
>>>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>>>  	r->default_ctrl = MAX_MBA_BW_AMD;
>>>>  
>>>> @@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
>>>>  	return false;
>>>>  }
>>>>  
>>>> +static __init bool get_slow_mem_config(void)
>>>> +{
>>>> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
>>>> +
>>>> +	if (!rdt_cpu_has(X86_FEATURE_SMBA))
>>>> +		return false;
>>>> +
>>>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>>> +		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>>  static __init bool get_rdt_alloc_resources(void)
>>>>  {
>>>>  	struct rdt_resource *r;
>>>> @@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
>>>>  	if (get_mem_config())
>>>>  		ret = true;
>>>>  
>>>> +	if (get_slow_mem_config())
>>>> +		ret = true;
>>>> +
>>>>  	return ret;
>>>>  }
>>>>  
>>>> @@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
>>>>  		} else if (r->rid == RDT_RESOURCE_MBA) {
>>>>  			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
>>>>  			hw_res->msr_update = mba_wrmsr_amd;
>>>> +		} else if (r->rid == RDT_RESOURCE_SMBA) {
>>>> +			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
>>>> +			hw_res->msr_update = mba_wrmsr_amd;
>>>>  		}
>>>>  	}
>>>>  }
>>> I mentioned earlier that this can be moved to init of
>>> rdt_resources_all[]. No strong preference, leaving here works
>>> also.
>> I am little confused about this comment. Initialization of
>> rdt_resources_all in core.c is mostly generic initialization. The msr_base
>> and msr_update routines here are vendor specific. I would prefer to keep
>> this in
> This is a contradiction. Yes, rdt_resources_all[] initialization in core.c
> is indeed generic initialization, so why is SMBA there? If this was really
> generic initialization then the entire initialization of SMBA resource
> should rather move to AMD specific code.
>
> SMBA is an AMD only feature yet its resource initialization is fragmented
> with one portion treated as generic and another portion treated as vendor
> specific while it all is vendor specific.
>
> The current fragmentation is not clear to me. Keeping the initialization
> as you have in patch #2 is the simplest and that is what prompted me
> to suggest the move to keep initialization together at that location.
>
>> rdt_init_res_defs_amd.Is that ok?
> The generic vs non-generic initialization argument is not convincing to me. 
> Could you please elaborate why you prefer it this way? I already mentioned
> that I do not have a strong preference but I would like to understand what
> the motivation for this split initialization is.
>
I dont have any strong argument. I was thinking, in case Intel supports
this resource in the future then they only have to change
rdt_init_res_defs_intel.

Thanks

Babu

