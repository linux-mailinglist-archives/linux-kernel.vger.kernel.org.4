Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457136D7FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjDEOiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjDEOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:38:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC1759EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8socbh5E+fewPW67piHFdh3laorD48GsDdDW4vl1eUaRBHOzTUUOzP4I07MXn7FvyU8Ia2940BKuJThTvHSF9sz3YTBs9Va/nv4aelFz3Z5nHXkZLeaa+OTh7FBKF/FWDUIott/T4nIacEQpQUVC1EPcSV0G0+5rER+0Kan+t1Tmr+gKU9EzzfWui8Dc+5fKpnZcpZv/cHrNaTJwVosXXhZHdHWPpk5knFfg8l1c8JKYcL5PJvsAQmZFMYdh2+kjJC9j2wEFuYAQa4bZcjNGqsimQX0gwAjuHHTjiZ7bjZOjb7fiVv7BBgy6LSTBnBknhilC+PLg8ysvwfceoDDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LScsx133yKQWwIWiAH5Y77b5NdN2XkkF6RaZ1v4qi0k=;
 b=bKd+1yu+jJ16q7bswp3IRkm/nOs91nou88nMLQlflxnjB0fR5U1YematfEY/SBHL+U41KCnyVYhyNEmy0i4c7ZSi3MFctddZdraPFarGAHuuuJ5PqkCLm0xiITClwetJWUHHgCPTpk7g2W+VRuKWv30QfltpEUIsKjl+4OjPIMsuv8yCLbjbVy78Cb6DBkfTr+Lk/WUYpsn2SC8oCovqyxncCcKfS8yqYbPYSPUzmr4o33gyFxsBpM8bCqMAGNHHEuk+S5N6oMmzCZtj2xZdc+4DIZ7QzcUUT/zq9QTzlVtb8uUDVdEouQagRnxpjkEVkY86fZLTk1ihBMmgSFE13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LScsx133yKQWwIWiAH5Y77b5NdN2XkkF6RaZ1v4qi0k=;
 b=EyfVQtsggfbm0rQ/TJ9r0ImLGwQvGs3p3+gb16vGA7eRyQxR8t4P4dp/OH36yH4xZ0rfvr8FwD0be9L2/U5XFWE2vtIKs8WPCGTwbhXeENTmeoHwk028ENsGShp9/LrbVFZn+AkJ2y0v4dkqJNknYfHN0fLWPR56kwWkxzP4e6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 14:37:59 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 14:37:59 +0000
Message-ID: <91a4f742-2f93-b8ab-a679-6812f4e4db84@amd.com>
Date:   Wed, 5 Apr 2023 20:07:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-9-nikunj@amd.com>
 <027ac704-2a7b-9ac7-d2c9-584ed840666e@amd.com>
 <d6b6a322-700b-8507-c52e-30ac143f6df1@amd.com>
 <ed2453e8-a95f-9b17-b3e1-a9355e8e04fe@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <ed2453e8-a95f-9b17-b3e1-a9355e8e04fe@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 186b281b-b9f7-4865-6cf3-08db35e35a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBz3zoLcXSzs+GHlQrdjZP5ak6MFQ/91q4xpzwGRiIcHSaCIgy2YoH1Aqh3eYh45k0Ih8Bh0tm7yOZH0P31RNx0T+1ndrFquQgJ/FmoV7NraI/9pP9LSHrEMXAZbA+CdAGcDasxDeocoowAyAT6ipAywlkCYKA8+1VZJUbIVuOD5kqV0D8x2r6KaaUE6pAMuD+Dd9Fp3HKe4tB+X9U6AzMsD2sO5UXrqiRXrxv2JTUUTZD5jP9E46oxC7AEEeAok7HCxJuMkXmFNtxomun3YivDtRE4sSH7lN19ZAu4aQg7HJZn4SCPb4gx1FZJ++YbJUUtm7yPwKav/1BqCzrhTQ/7RCL3BvbZCPhJoFZsv4M7Ecq0DUPj/zFvjOXN2Y9bMzWyLJ2fRGILxoMMJI2AwDZ+DC3VmNsQ3LygesSdndZhkSIZwsV4F2YKmpN6Su6Whdo3sXmiIlwAnn0SEKBX8caLUfoN8jwObP35lW2j8GPPrk4ASROM5fMIebm6d1GHpRS/fCBDaMtL/MBinE+0lgv3p0MOwnZXR0A5pUmR+qV7UxXtacHSA7p2k7Ay/2vT0X8svA3YJefHKqN6CrzYumpHIQijYsFXQanDlYWFXGHCpgkTbcxgslNP5LnuRlgny2OZBG9+6Fsn8HFiRMdCU9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(6666004)(6486002)(36756003)(2616005)(83380400001)(38100700002)(53546011)(6512007)(6506007)(26005)(31696002)(186003)(2906002)(3450700001)(5660300002)(316002)(31686004)(8936002)(41300700001)(66476007)(4326008)(8676002)(66556008)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3MzOU9rOXkycjlhMnVqNVJpY3ZIeVhIalZHYXI4L08veC80RmpINHBBbFQv?=
 =?utf-8?B?bWQwK3R3ejg1MVIxbDA4Y2dyM1hwUkJxMGFvK2ZaeGJ5RUlhSk9QZG1pWTB4?=
 =?utf-8?B?VTI0cXlmNUhCTzhXTWQ1ejhLeUNBZHlSUGtwMjA3V0dONnhHZmhkTFdzVFFk?=
 =?utf-8?B?bTNvZ0dhZE8zMkZGL3o2TzJkbDJSUXRKQ3NMMlZkdUdkLzVPTjJIaytKR0Rt?=
 =?utf-8?B?Mm1uM2RPUEhHUE9FS0Y5K1BWZ25jRFFtUU1jR1FVVmcxd0prWnY0aWlUZHcw?=
 =?utf-8?B?SVkzR2Zlc3BKcElFZi9DVVIyak5keXZ5QWpaZVk5WHBwRjhYdERIZTl3RWt2?=
 =?utf-8?B?NnFsY0VLaXl2VDhodXlCYm9QTVZVaHNoeWdaSHNNSHRqRHdyM1ZDL2Mzb01N?=
 =?utf-8?B?TVlUKzkzL1R1djlPLzFoTWluWG1UZGtJY3lacFRGcEdSOUlhR3BnVWtCeGxQ?=
 =?utf-8?B?TklVNnBydmY1NTRDYmVNYXkrREJiNUhEWXZBRmkwZ2RLM2o4MG5XQkxxUzVF?=
 =?utf-8?B?cjkwQmVYMEEzM2h1amlwcGwxRVFnY0syb2Vyd3EyVDl5K2tvSkNScW43RVBy?=
 =?utf-8?B?UGwra001OVZRUjE5cFFoSTl1VFA5MWc1U3RJb25UR29wMHNDMVNSak5vRHFS?=
 =?utf-8?B?OUdUNHd4aHczUjZzNjcwdTE1WEN6eHo2eDNyeGZtSFpVNEcxM3NWMWxESWVl?=
 =?utf-8?B?NjZuNmNJRG5XMWlGYW02QVNFUTNQazdEYUl2WlZUajRPV2xRZGY1eXEvakk2?=
 =?utf-8?B?TDlpWStUOW4yWHdQQUFFdkUwK0pESis2aGx3eU01SlptYmp1SW9uLzhpeENk?=
 =?utf-8?B?ck9SeCt4RSs4WlV4dnJUbGN0dkx1SE1rOEZsNW05aWt0U1BYTXdiZElIWHBu?=
 =?utf-8?B?bmhDWFdSYy8xRU0yN0JQVm5GTFF1T2RuektFS3FQNXZ5ck9vckk5NzVXeG9U?=
 =?utf-8?B?RXpoWGFrVjE4VEdxZ1JkdytjbUpvTTE2NVN3YUwvaGpMLzZCSjlINjdaYXBM?=
 =?utf-8?B?N3MrZEhBSHJtUmx5WGJQZEpNc2JoaDIzWUhjbDlBTENoVVBET2RSYUJYS0Ix?=
 =?utf-8?B?aExORDlVdUJCa1ZBN0sxZ0VSZzBtcFV5NDRvdlNTY2x4ajlOZEZDNHZYdCtn?=
 =?utf-8?B?Z2RBRW9EWVp2WUJLdVZwbEp0SVFlUUNwRkM5akhINHI0NnROV3BBMHZyYnNU?=
 =?utf-8?B?c1c5OURPb3JDaHpqNXZUa00wQ2N0NTUvay9mUWdpY0VmeXQ2TERiNkxzMllm?=
 =?utf-8?B?emRqZytlTE41b1B4cVcyZVFFcEE4Ti9yTHN4d1BmQ2lKSzJpOUt0dVNkT0Y3?=
 =?utf-8?B?SFZGbENIcHRXWDdmK0RRa0Z3Yk0yYVROLzZIYzAvNXhRV0I2T043UmVuMWMz?=
 =?utf-8?B?Z2dXbEtXVGFJZ1RDa21tdTkxNU51N1I1ejhGbXFML1JOc3BsMXlNVzQvN05F?=
 =?utf-8?B?Z0R2a2dzQ2h2Q1lYMWpiNUNnTE9oNHpuNmZ3RGZQSE9TRDErckhJbW5oczJk?=
 =?utf-8?B?dVQvM3BrVnhOTG1lbzFRdjhhNVhyK1VlVVdmdU9uZDJUdEFPaTFnU0Jna0tC?=
 =?utf-8?B?UFdtMHJmaVk3UjhpbHV4M210bnpwMnUvWkVQbU9TVG8rdHVtakJmOWNSUHdI?=
 =?utf-8?B?WlBJTjJtbWZDTjc4WWlEc3l4NkxkZkF0YUhyQzB2aHgrWTJEMGpHdVhGd3h5?=
 =?utf-8?B?TVZQcXhGUDI0b2NtamhOQUFqMkg5czZMRVZDNGUzOFpJZGc2ODVUc09Fa1lK?=
 =?utf-8?B?U3JjbXZmdWMxTzFhWVBSRWk5ejlkOVMrRDhXdmgzNVFkdnRUQ0lHUld5ZHc4?=
 =?utf-8?B?UWlRdWFSSjlCL2J2Ym9CbjRKSTlmbVVEYlZnc2xpdlZXVTlKVUFNQ2YwNDFS?=
 =?utf-8?B?SmZ6WnpuZVdSbmxnTlhhbDJsci9PR0xLa094TE9kVUsvNk5yeXJtRk9IdG5R?=
 =?utf-8?B?UVB1eG1yK2s5bkw0ZnMvTkZleWprOUI4L3BFamd5c2MvcVIzaklJVFdrWFg4?=
 =?utf-8?B?ZUdBRlB3Q1hSdTVVY3ZaOTNmSHB5a3VPRTR1MGNHdVBLaXFHamJhVG1BZUha?=
 =?utf-8?B?QUs4U0JxZGd5dkx1T2dJME9oQXNHM0h5R0xMeTVQeFpRbU4vdmNKYWIxN0li?=
 =?utf-8?Q?hsUnol0l/xJQVG2IwHIJPsSLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186b281b-b9f7-4865-6cf3-08db35e35a09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 14:37:58.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZGyRiEkXd9qo9n6OblQs7jzgNe0z+6V3rvVjmq+KORUUojxzHTgFAKAb5woXs5EgJfBD+UBwJQec2Hcvf2ekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2023 6:54 PM, Tom Lendacky wrote:
> On 4/5/23 02:37, Nikunj A. Dadhania wrote:
>> On 4/4/2023 3:11 AM, Tom Lendacky wrote:
>>> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>>>> Add support for Secure TSC in SNP enabled guests. Secure TSC
>>>> allows guest to securely use RDTSC/RDTSCP instructions as the
>>>> parameters being used cannot be changed by hypervisor once the
>>>> guest is launched.
>>>>
>>>> During the boot-up of the secondary cpus, SecureTSC enabled
>>>> guests need to query TSC info from Security processor (PSP).
>>>
>>> s/Security processor (PSP)/AMD Secure Processor/
>>>
>>>> This communication channel is encrypted between the security
>>>
>>> here as well.
>>>
>>>> processor and the guest, hypervisor is just the conduit to
>>>
>>> s/hypervisor/the hypervisor/
>>>
>>
>> Sure, will change commit message
>>
>>>> deliver the guest messages to the security processor. Each
>>>> message is protected with an AEAD (AES-256 GCM). Use minimal
>>>> GCM library to encrypt/decrypt SNP Guest messages to communicate
>>>> with the PSP.
>>>>
>>>> Moreover, the hypervisor should not be intercepting RDTSC/RDTSCP
>>>> when Secure TSC is enabled. A #VC exception will be generated if
>>>> the RDTSC/RDTSCP instructions are being intercepted. If this should
>>>> occur and Secure TSC is enabled, terminate guest execution.
>>>
>>> This seems like a separate patch.
>>
>> Sure.
>>
>>>>
>>>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>>>> ---
>>
>>>> diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
>>>> index 834cdae302ad..d5ed041ce06b 100644
>>>> --- a/arch/x86/include/asm/sev-guest.h
>>>> +++ b/arch/x86/include/asm/sev-guest.h
>>
>>>> +#define SNP_TSC_INFO_REQ_SZ 128
>>>> +    /* Must be zero filled */
>>>> +    u8 rsvd[SNP_TSC_INFO_REQ_SZ];
>>>> +} __packed;
>>>> +
>>>> +struct snp_tsc_info_resp {
>>>> +    /* Status of TSC_INFO message */
>>>> +    u32 status;
>>>> +    u32 rsvd1;
>>>> +    u64 tsc_scale;
>>>> +    u64 tsc_offset;
>>>> +    u64 tsc_factor;
>>>
>>> This should be a u32 ...
>>>
>>
>> Right, will correct.
>>  
>>>> +    u8 rsvd2[96];
>>>
>>> Which then makes this 100.
>>
>> Yes.
>>
>>>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>>>> index 3750e545d688..280aaa1e6aad 100644
>>>> --- a/arch/x86/kernel/sev.c
>>>> +++ b/arch/x86/kernel/sev.c
>>
>>>> +bool __init snp_secure_tsc_prepare(void)
>>>> +{
>>>> +    platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
>>>> +    if (!platform_data)
>>>> +        return false;
>>>> +
>>>> +    /* Initialize the PSP channel to send snp messages */
>>>> +    if (snp_setup_psp_messaging(platform_data))
>>>> +        sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>>>> +
>>>> +    if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
>>>
>>> Should this be checked before allocating memory and calling snp_setup_psp_messaging()?
>>
>> No, as we need guest messaging to work without Secure TSC as well.
> 
> My take is that the sev-guest driver should establish the key it is going to use at the time the driver is loaded. > snp_setup_psp_messaging() should be called by whatever is going to use guest messaging.

Should sev-guest also call snp_setup_psp_messaging() ? 

As per the current design:
* snp_secure_tsc_prepare populates platform_data (probably I should rename it snp_prepare_psp_messaging)
* In snp_init_platform_device() platform_data is copied using platform_device_add_data().

sev-guest driver in sev_guest_probe() uses this platform_data populated by snp_secure_tsc_prepare().

> 
> Having a generic routine that is accessed by both the kernel and the driver should be the goal. Maybe it is best to only have the vmpck_id be part of any structure and then the appropriate key and sequence number are used based on that id when the request is made.

I understand what you are suggesting, let me think over this and I will come back.

> The sev_guest_platform_data struct can just hold context information (it doesn't need the secrets_gpa any more since everything is now in sev.c which knows what that value is) for whatever is using guest messaging.

We are using snp_assign_vmpck() in the sev-guest driver that is dependent on secrets_gpa, we can get rid of that dependency I think.

>>
>>  
>>> Also, I notice here you use the cc_platform_has() function but in previous
>>> patches you check sev_status directly.
>>
>> For sev-shared.c, cc_platform_has() is not available when compiling boot/compressed.
>>
>> I will change the below call site to cc_platfrom_has() after testing.
>>
>> arch/x86/kernel/sev.c:  if (regs->cx == MSR_IA32_TSC && (sev_status & MSR_AMD64_SNP_SECURE_TSC)) {
>>
>>> And you don't implement support for
>>> CC_ATTR_GUEST_SECURE_TSC until the last patch instead of now.
>>
>> This is to make sure that SECURE_TSC is enabled only after the last patch.
>> As cc_platform_has() is being used at multiple places to enable the feature.
> 
> But you terminate long before that in snp_check_features() since you don't update SNP_FEATURES_PRESENT with SECURE_TSC until the last patch, right?

Yes, that correct. I will implement full support for CC_ATTR_GUEST_SECURE_TSC  in this patch.

Regards
Nikunj

