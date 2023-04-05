Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DF86D7DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjDENY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDENY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:24:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF342705
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+Y3ifPY5DGLs0SgqBnq1ya5Yt/H6PM5QioL0/QauhNyFvAIPleNykcKHHCb2iKEGfOJSSmZn/etFTOLo1ucjC+ntIvxejjiGSFP7HbrkLwZiMqFmcC0AwgVW5r8pkDptuUyY1wyLWWr//53QWo4deYYZHfIoft92/5g3yxnTphIuW7EP3DoiczaYzNHegO3PWh0zZ8ULDIwPqAyNruXH73RCoCtdDB0Yoie/g1XSryGXCh+Gn8UMjICPAS7iO2onYHtxsS5rOgt8xrOhpNMkoHyj2ORoEHoYrWz0lRbZXPQCkSHOjtcwInr7i0pg0msDAwEAeRNQkq1Bln53WRRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlTgh3qk89fqzEO8jDS8EObEpPJw3bgHrn5Np/J5vsI=;
 b=IHFfYadYUioZoLCZa+R/pzvqI64QXvYT/i8xHL58QQlxJYcmtdNgFFN/O3jusvNuup96wvDAfDzMoTZLz3S2dSbYXiTGikd7dRW5+LUyZNESiMCIQEShT22v+eDlE2uijziGYWC7gchaCO/BLZ6d9vh8hA4x03CHR91Ew+jtOznIyVdj+OClRN2Odn8FUv4pkp7u+E4P8fmxTPjqzMLBIILayQLEoKe5GKZjc7Fwrj2rqAZhqEjBst+VxFNfIbq/E2HWEDlV37qHn0NEzYc6b9A/Ia27fuS1BydHt3Bze3/2Ma0hjnu2FtK+G6Tx5Jm+EYOGZX/6wdPISAq1gu1oRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlTgh3qk89fqzEO8jDS8EObEpPJw3bgHrn5Np/J5vsI=;
 b=sWPVueBpZTFmFYIyH5Myyr7unIM6R9s4UXJuGKQO83Qibygw2IxlhwBeANLBI3IM66eX3QPwYnygwyK5WeryBmT+a5ZebNcXTlSAerXEGEUhr1sJ2UA94RGjpSOtue6kfl7VOIxGiykWBtsszQivCFH66RwCzCKrmEIWh+nDeZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 13:24:17 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 13:24:17 +0000
Message-ID: <ed2453e8-a95f-9b17-b3e1-a9355e8e04fe@amd.com>
Date:   Wed, 5 Apr 2023 08:24:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
Content-Language: en-US
To:     nikunj@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-9-nikunj@amd.com>
 <027ac704-2a7b-9ac7-d2c9-584ed840666e@amd.com>
 <d6b6a322-700b-8507-c52e-30ac143f6df1@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d6b6a322-700b-8507-c52e-30ac143f6df1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c77e5b1-b74f-4470-988b-08db35d90e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfiLaWmB7iQazWP3zQ9U/ObNFLnDqIJFkzUGnEJytYNautuR9cJ6rM3oiToBw6uRdMYaLrapfInmIq5p09kTJD+ZP7w31zVeJDS5T0f7MZT5jPB+garF8fydsCAcHa9QuxSM+Nhw/kgxOc62AwpYNSgiD+Q/NTcLajcdnQbFAyn34kFqHjSVuq2ktDmvQ38bPUavF1bwQhaHxlEMuMb5EI3JIP8aoZgzOD/xu8HIx2QyTHr9MemO2/Z1WhwrVBC8buI5Hp2G/13J4jUQe7/uQ9RjDpBb1z6OW23oYBrq7eESqtokifk2LJohKYn00oX3hMwx7jILVfiJ802O4JGSKiHXWooFKAtN8kc2K78vuiu8/xIzDfIdoZ99E4ZBSfAjoOLMnRr8vc6Of3Pv96lf2u/GTWQsJuLdP59LogQdyVLgp0md1NoOWIfi5UX8B2KfXrYJKWjbADnVHnOm/VuxcBxDRbbn6rSCtPLGiYEHD7/z+BWScmbQ62K+ORSxLbaFIcnfo13f0jjYUcyLSRBSHIVl9tomTNyyT2S+bK6nGrDUpNfvH2cGnA/jE4xUORCMko8fDoXMrNBaSq6ojJ96jEzZb5yBrWb5JNFMQHanqHq2kzzzcPUL7Fgu9qEEqDZibAivbMmsB7SSnxXHlilh7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(5660300002)(86362001)(53546011)(6506007)(83380400001)(26005)(6666004)(6512007)(31696002)(186003)(38100700002)(8936002)(8676002)(2616005)(41300700001)(66946007)(6486002)(36756003)(4326008)(66476007)(66556008)(478600001)(316002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZScTNYRFgvNkt4OVlsajlHeXAwNTZzVnR1cDVxZkd1c0w2aDNaNUF5cjI1?=
 =?utf-8?B?NGlHaFBzVDd5bU5ZbXF0K1VoVUF0VlBxV1R3aWZRRnZyWU9Wak5UTld5TnVj?=
 =?utf-8?B?QVNyYlBFbURZdC91akM5TDZDVFgrb1BDdjZML05VVURtcmhPYVRCcTRaY2xr?=
 =?utf-8?B?bDBvdjZOMzRDSFVpeW5Ic3JieFdKZkZiOWdvQUViUlNOUUp4aFp6d0U1Q1o3?=
 =?utf-8?B?Wkx6K2RaZkRjbjhkZEllYitZMkZjR2dNdjdkOE5DNysrNGl3TlpUQzY0NTR3?=
 =?utf-8?B?WHdOZEpxbkkwZHZseWUzaXBkeTVxUlR3NkI0M1ZiY0tIWVpBcktYbWdESlcx?=
 =?utf-8?B?RGFDTHZiZ2dBSDFRRGhwcDl4MkhpWC9aR28vdmRxaUQzOEVrd1RQSU9weFBj?=
 =?utf-8?B?MW9tVDZKcmxOTVlFRVJwZVF6alBLNUVqN1YrMk94UER2Sk1YZnNTdloxa3Jm?=
 =?utf-8?B?MmZqSEgxTFBXZ3Q3ek5pUmhKRHhCRms0Mkpud2M0SmVvSkZMNndiK3A2dlQr?=
 =?utf-8?B?cFZTcGhqNlA0VFNyZ2x6VExycWNTcXdCeWR4L3FWYlFaaFozb3NtQjRHeGk3?=
 =?utf-8?B?ZmprQ3FKTzF1elQ5NEdpUlRjemYvaTVZSXdZaFF3R2J2ejNTTVdaODFhUFQy?=
 =?utf-8?B?NmVoRDlvTEF5eGxabStBdll3VDM2RytnUWxKV1A0UElEQjhGdlR3RTRmRGk4?=
 =?utf-8?B?QUdwMW92TzZDMTJsSFNzWDBSTG5WWjlhWmZNRU1lSDcyYXZ2OXdMWW1hZ3dQ?=
 =?utf-8?B?TUhOdXQ5L25IZEtrd0xrVGVyUmIzcDBLYjNSR2pvNlZ3M3ROOEhadHZoRVpu?=
 =?utf-8?B?bytNR1BrazVuM25ON0Zvb2pEUHJmVDIvNm1OdmpvNGpzVzhIU2VoTjRyeHRR?=
 =?utf-8?B?MGdtOXVMTFNXRFNaczYyRWFCcVNTUnVZYnJwWnQwc2dpeTdCMk55QmJvTkd1?=
 =?utf-8?B?Z29sdVltT3FmSlZrY0M2YVY3aXBpTldEM1U5S1BSckptaGFPSkgvWHlJdVY3?=
 =?utf-8?B?ZThvbG5NUk5KQllMRnVET3lrdTcrQ3ZSUlhIK0xGUDZyZVZINFNuTEl2dXhJ?=
 =?utf-8?B?clJWNVRCUzhSaWhYQm8xOG9YVDk0MmZjK3Z2N0hVWmxzUU03bHg5YTJXQjZs?=
 =?utf-8?B?d2pNek84OHJoRXNVSnBERXRyMTFaYkkxUDBFTEQxdDhrMENaUlUwZGZoQXZY?=
 =?utf-8?B?eDlrb0prd3FqbmU4bllTbzNmS0E4QnhUa2RiUHNLUGdCY1lqRzZqWU0rNmtT?=
 =?utf-8?B?TjJzL2dYdHFGcS9lU0hseDRqK3p0dVZQcUFSK29uWC9iYy9ZczUvVDVUZXNw?=
 =?utf-8?B?T2M3R1BOQ09Ma2MyWmVHTkk1bmFnVGxOa0R6SGpHWkFKendkcXIvMm1VSTRJ?=
 =?utf-8?B?QWdIUlJIZmNQaGJyOXlMVVpibjRUYVZuY3ozN2duTlVKYnVFZHdKYWwvaUcv?=
 =?utf-8?B?TDAySHJxMjdlRWJLalIrcmQxKzRXQXJKZEJkMXo5UHNnaUhFTlduS1YyeUNM?=
 =?utf-8?B?amNmZmJTZ05zdjc2eXNmWUhVc25aM0I0RG1GcStmTExYdnE5aVdQQ3kzdUQ2?=
 =?utf-8?B?dk80L29QeWpDM1gyeDRHVUJqZXJiT1VobkxzSE5qSHlRd2RxbzlPaVJLTkZY?=
 =?utf-8?B?dzV5MFdPaVdFU2I1MHNZSE5kdkVta2lsVDJ1Lzczcm9OSk9EMUVwZUhYUXFC?=
 =?utf-8?B?bjlQZ1NoL2pvWHZrWXFuT0FVK0dsbkRBbVZQMWJYYW1HczJvVDdaQzRkSGtF?=
 =?utf-8?B?bGNvVmhUTDAzd1l6c0hEYzgrQWJZNVlPWWlzVnFWbVBuV0gvNEZQcWt1Y3Ri?=
 =?utf-8?B?K3RKc1ZKVU9td3pEVDRGNDdTZnFQK2V1RHRNcHJ1QzB4OTdzejRnR0RBZytD?=
 =?utf-8?B?NzVTSlhpQVg2UCs0b2M0UWM3Mk9CZEUvQVIvYmdON3dLRC82S095TFpqY0VO?=
 =?utf-8?B?dExqbkM1K0hxYXJFVEN3dUpiVVBhditoV2RRM2h6U3l1VCtEVS9MaXN2UXQ3?=
 =?utf-8?B?UCtHMVFXcEkyRHhaSFl2M2dubGxYM2Y2TEk1cDlQV21rdVd4ZlVOSTNicHhN?=
 =?utf-8?B?ajZ4dlV5OVlyeDFwRXpMU01zanQzRDd5dURvSHlxcm9wN2RBV0RBL21IVi82?=
 =?utf-8?Q?Lvoqxz814Ze9Xi6f516X2+ec9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77e5b1-b74f-4470-988b-08db35d90e83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 13:24:17.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaZLi98+sct8t3ksdsIKPGFzrPvZdw4Q6Btd/x0iLkqDB+4+2Bw46uZQnZ2+XJUAKLMtf54TB37ynYMWkmdweg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 02:37, Nikunj A. Dadhania wrote:
> On 4/4/2023 3:11 AM, Tom Lendacky wrote:
>> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>>> Add support for Secure TSC in SNP enabled guests. Secure TSC
>>> allows guest to securely use RDTSC/RDTSCP instructions as the
>>> parameters being used cannot be changed by hypervisor once the
>>> guest is launched.
>>>
>>> During the boot-up of the secondary cpus, SecureTSC enabled
>>> guests need to query TSC info from Security processor (PSP).
>>
>> s/Security processor (PSP)/AMD Secure Processor/
>>
>>> This communication channel is encrypted between the security
>>
>> here as well.
>>
>>> processor and the guest, hypervisor is just the conduit to
>>
>> s/hypervisor/the hypervisor/
>>
> 
> Sure, will change commit message
> 
>>> deliver the guest messages to the security processor. Each
>>> message is protected with an AEAD (AES-256 GCM). Use minimal
>>> GCM library to encrypt/decrypt SNP Guest messages to communicate
>>> with the PSP.
>>>
>>> Moreover, the hypervisor should not be intercepting RDTSC/RDTSCP
>>> when Secure TSC is enabled. A #VC exception will be generated if
>>> the RDTSC/RDTSCP instructions are being intercepted. If this should
>>> occur and Secure TSC is enabled, terminate guest execution.
>>
>> This seems like a separate patch.
> 
> Sure.
> 
>>>
>>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>>> ---
> 
>>> diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
>>> index 834cdae302ad..d5ed041ce06b 100644
>>> --- a/arch/x86/include/asm/sev-guest.h
>>> +++ b/arch/x86/include/asm/sev-guest.h
> 
>>> +#define SNP_TSC_INFO_REQ_SZ 128
>>> +    /* Must be zero filled */
>>> +    u8 rsvd[SNP_TSC_INFO_REQ_SZ];
>>> +} __packed;
>>> +
>>> +struct snp_tsc_info_resp {
>>> +    /* Status of TSC_INFO message */
>>> +    u32 status;
>>> +    u32 rsvd1;
>>> +    u64 tsc_scale;
>>> +    u64 tsc_offset;
>>> +    u64 tsc_factor;
>>
>> This should be a u32 ...
>>
> 
> Right, will correct.
>   
>>> +    u8 rsvd2[96];
>>
>> Which then makes this 100.
> 
> Yes.
> 
>>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>>> index 3750e545d688..280aaa1e6aad 100644
>>> --- a/arch/x86/kernel/sev.c
>>> +++ b/arch/x86/kernel/sev.c
> 
>>> +bool __init snp_secure_tsc_prepare(void)
>>> +{
>>> +    platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
>>> +    if (!platform_data)
>>> +        return false;
>>> +
>>> +    /* Initialize the PSP channel to send snp messages */
>>> +    if (snp_setup_psp_messaging(platform_data))
>>> +        sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>>> +
>>> +    if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
>>
>> Should this be checked before allocating memory and calling snp_setup_psp_messaging()?
> 
> No, as we need guest messaging to work without Secure TSC as well.

My take is that the sev-guest driver should establish the key it is going 
to use at the time the driver is loaded. snp_setup_psp_messaging() should 
be called by whatever is going to use guest messaging.

Having a generic routine that is accessed by both the kernel and the 
driver should be the goal. Maybe it is best to only have the vmpck_id be 
part of any structure and then the appropriate key and sequence number are 
used based on that id when the request is made.

The sev_guest_platform_data struct can just hold context information (it 
doesn't need the secrets_gpa any more since everything is now in sev.c 
which knows what that value is) for whatever is using guest messaging.

> 
>   
>> Also, I notice here you use the cc_platform_has() function but in previous
>> patches you check sev_status directly.
> 
> For sev-shared.c, cc_platform_has() is not available when compiling boot/compressed.
> 
> I will change the below call site to cc_platfrom_has() after testing.
> 
> arch/x86/kernel/sev.c:  if (regs->cx == MSR_IA32_TSC && (sev_status & MSR_AMD64_SNP_SECURE_TSC)) {
> 
>> And you don't implement support for
>> CC_ATTR_GUEST_SECURE_TSC until the last patch instead of now.
> 
> This is to make sure that SECURE_TSC is enabled only after the last patch.
> As cc_platform_has() is being used at multiple places to enable the feature.

But you terminate long before that in snp_check_features() since you don't 
update SNP_FEATURES_PRESENT with SECURE_TSC until the last patch, right?

Thanks,
Tom

> 
>> You can't get here until SNP_FEATURES_PRESENT is updated.
>>
>>> +        if (snp_get_tsc_info())
>>> +            sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>>> +
>>> +        pr_info("SecureTSC enabled\n");
>>> +    }
>>
>> Blank line.
> 
> Sure
> 
> Regards
> Nikunj
> 
