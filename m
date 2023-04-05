Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7C6D75B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbjDEHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjDEHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 03:37:46 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016FEE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 00:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZa7H6rBJdGC4waZDsb80eMHXfHlKiau2Ov1FYYnyJjrrsbmyM4GrS0gCTMDJ1DsLCBsgkhnt6G6uIq1f9F4AQzDG04K2XCeq6Ie43erRtDSejeh2UrtlOS8bbwlGXYrdIP3Gq8vULa4LpvxYaQcFWgGdMLWituP2SPG5zoEYDe0ULXEqkJnM+3r8wyOLLndcAMP+AJMLzjCaYw7KcgwULH0WZvawsWq0Nn+o7uYxrnWVEMQPHzQIoWgEAKSID6Q8wOl/nXC8R0g/SFTeQUgMVhbGjYwqwNWN7F2R0gGwXkvMyG8ksLXj9J5Z2MVoV0S/MKaF+lI4IF1zIq60QG35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG138puM5ab++GEyDI7rXGXvtDdBZLxyhfvTs6ZhCDw=;
 b=fql3uXfxNKWO+PZN9Uo2fKCNvgLJDgAiQ+kFoedoPm6EPzGJ5DMhwOkM16bEU565xeeTcjJZAWv/+WG7ow5FC5ACkRPCYv5w9pabdVcoFDyonOx1sGCar8Ix5Fi9WERKFsBEW3kPK2ur7FLhIZ3FYIavMhiTIDKksvOzTnKMizUqoxwOIaOFM9sR1v3gpjMTuQbws0xnkRocBe4+oPry0Os4VEeFJG78yav5s9rHzriEf8XlttvmUEfLNAPjKUtlyn51uPM4hnZKduUOBNWXKFZNPyrr28OqO3wlakwlyPXLgIWJcAvYyRMrdrnn1o/bmn0LK9NRjzee1KMULH86QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG138puM5ab++GEyDI7rXGXvtDdBZLxyhfvTs6ZhCDw=;
 b=NxdbqbPdqf18HyB/+xC0cKZPlSNjYKUUbQH/7Tr7yvkqYsVdAzrOtny6Da/nmAT4AIqWQT7v2F3t5CTGIXcUh9msCYNORJ6k9JPc6w8DVPr5hnRj3NsVolxI3yNK2Rrl3GICnnBQMDMbfr6WxzqtvURICvWJAP35c/UAW3Zw1ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Wed, 5 Apr 2023 07:37:42 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::de58:ace6:16ba:96eb%3]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 07:37:42 +0000
Message-ID: <d6b6a322-700b-8507-c52e-30ac143f6df1@amd.com>
Date:   Wed, 5 Apr 2023 13:07:28 +0530
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
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <027ac704-2a7b-9ac7-d2c9-584ed840666e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b5d854-1974-4d19-ea9a-08db35a8a343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpn7bTw/ZNLyA1q2TUABb22znhJ9S90xNQR6BFDtwy8PAJStX/huKI1ic3toqUwHPlhn+HBmqPINQ0CG9nuriImwR3t3s+gz8xGKighdZ914bj1eUS/hsXpPEzouvJoHWAiNZyrAqwH9vBBIDmMrx27y4tzM3L7H5EsnUrGuFOg8RizcYNdatoOZu/ShFf3FE+Y8PNrDS72e308PTtBSR+tltD2t4gbx/OHBVlv4zhU2zIJvP/X8SbD6lKrs53RGQSlEf3aGrQdR60LjnGxYNAaRUi10P4sGDg5Qbnm/xwBNajEzvR1/j+/LvKI0F96tEbhnNxJ/rEncKjEuiCEzdJnTBMswehjdnmPJ5s25gKpws60M4PakprZZYk6FQYinW+mrJ5vFqDx6XoIL0GOStL+eT2f5SkunEvTY4vhiOKwqyiC6RiX7H13oQLlkLFC81zWkPbjjv7KBL1PTb+fSF6pW92T4p5r5Cv1k5eL3hhYUBjCQ97zwW0epil+PEYCwa0e9Zvke+BIWL83q/5K/Brwgg87RwuiD2a0d3XvVn31tA/SGHOfS7wQcWjmBlMUwKKMGXyeR2DA7RLRMr4G6pq5UQWSkGELGSsn9Or+JiP9vFWv+bnkKmi/lB5XMtko2pV8KeBm/w14iXD8b+YzhAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(31686004)(478600001)(8676002)(4326008)(66476007)(26005)(5660300002)(6506007)(8936002)(316002)(6486002)(41300700001)(38100700002)(83380400001)(66556008)(66946007)(3450700001)(2906002)(6666004)(6512007)(53546011)(2616005)(31696002)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dllONW9SS09aa01vcEJrdmZCR1d4WkhVZTdibHB6ZHRGMGlNZmJFNVNBZmhh?=
 =?utf-8?B?dTZlTzJKSnU1K0c5aHFHaVFTTkRMZktYLzAyTzVvbG5vTUJncUN1ZEg0bkR6?=
 =?utf-8?B?dStDMmdGRUpvMnd0Z1UvakRNckduNTRnQlo0UDZaeFpvb2tOQWlvRlErQzRN?=
 =?utf-8?B?RE1zbTFHU3Z1Vi9aZTdvdnFUdWhlczVLR2tHdUNiR3RlSG5hdVRGVEtFS3p6?=
 =?utf-8?B?VmtObEsrbFIvRzBKYjJtOUVkbDhIenAvOTR5OVVwVFVsUkVtRkE2cWpUYkpD?=
 =?utf-8?B?cmFSQXIwL0dsUXlqb3gzYkxoY3hRbDdDRi9WT1NBdDI5Tmd5TDl4ZGt0a0Rz?=
 =?utf-8?B?c3JDUitsV0FFS21FZC9XdVlGVFJmc0h5cUlCSTZ6QmtxcHFHWGFJNVpzazBy?=
 =?utf-8?B?WFNhZTZYc0RBaml1ZFhVTDc0Qi9Wa2IyNk9lUzlwaGFic1VHRXVsTnlrenpy?=
 =?utf-8?B?cjA2RnN4OE8zUVdBaktKelJJNTF2Mk5jWnQzS3U0WXhpZXpwalZRMTUzK1dC?=
 =?utf-8?B?bFJDamVubnR0Sy9pc2JleDZsZ045TC9WQm9jeE5WR2h4STBoUmpZeWRRSWtn?=
 =?utf-8?B?RlVzaDY1UEpuVFBZVi84V01tdHc3Zk53Q0srSVFXMGs2eG1VdXNEOG50RTlV?=
 =?utf-8?B?emVZR2hiZHZmWm9tNTNTWWwrc2plNkpZUGZ0SWp1a1FxVUpqSW1UTGEwTzdI?=
 =?utf-8?B?SGJxKy9JUTk1YVBtZGxxeXFaYjJ4YnAvVXdhZUVoVjRmYktXaXM1OHZwMDdZ?=
 =?utf-8?B?RGVMOGRBR0hLMUd0V3ZRanJ2bTBYcHVSaW1YV0lKai9UaHdOS2hQQXVKZVN6?=
 =?utf-8?B?dGFOTG9aTHVhT2YwbU1pWFlCbEdFZmpIWWs2eDhNWjMyWXlmdFQ5NkM4ZnQx?=
 =?utf-8?B?VFRQNFd5ZCtOQ0pZa2R2azJiWWpoa01YZFNpa0RyUmxlV1lWZEdGVDE2T08z?=
 =?utf-8?B?L2hDRWRINnF6M3drajc5OWJMUSszVHl6UmhHS3EzTnQvWXdSSGh2eWRRbVEx?=
 =?utf-8?B?K0p1QWFQbXBvNUdLUjIycXVGOGZScHIzWUhjMkMxNzRsYUlpVjVHOWI5UVRD?=
 =?utf-8?B?NkducUJkR2FJaWIxMGlWOXVCdWRCY2JOZFJzNExaSGF6clZ3aWk2ZyswOWgz?=
 =?utf-8?B?V3g4M1UyV2ZGaWpTMFVYcGk3dGZGaFdRRFV0RGFhc0hGYzhMUEVIRTc3RTlu?=
 =?utf-8?B?STRlL3lmcWJ4YWJVdzdTUWtkTGtJZnNuU2xZSkV4UlkvenRFU3dORTNIeXBD?=
 =?utf-8?B?bDVDekxINWdiaWJmOW4xN2hoN09iaDBZVzFWajRmNHNDOC82eFYvUC92M0Jx?=
 =?utf-8?B?WTNJRkdCRWVNU25jd3NKM3ArRGlMem9JbkZIekRHcjF2cFVNQStZZlB4M0Jq?=
 =?utf-8?B?QWVST2xmdlVJc1Z1UGt5eXNrRStyeVdhczBOeHNnOEZPMm4zRHVXeEMrVFNJ?=
 =?utf-8?B?T2ZLNTNNV3ZPSmY0Ujh6UmxvRTZjS2lOUWJ6akVyWitSMUZXMmtxMXJBd0lX?=
 =?utf-8?B?dDVKOHBpT3JMcytRd0owQlZMcTkzdFdHYkNIaFczY2JseGVvc1haLzU3OWty?=
 =?utf-8?B?U3k0MHNaeEJKdnRqVEhDNEhTbmw4bHlqVE93ejRKTi9mZ3M5VDRoTDYybFJt?=
 =?utf-8?B?ZGkzaHI2N28vZzFnU3dOSUhDbUs0UHlGUGFmVVdYWHNSWVhidWV3V2ZiWkRS?=
 =?utf-8?B?eWVWN2xHVEJ4clBkbGsrWlM1cVpGbmZtY0pDUjQrNStCNllGN05meTZUNTMy?=
 =?utf-8?B?NnRQa09lazVJS2dRd25IbzRMeHNCUFpnOE1NVkVXbjRkK25HWG5tNThtbjB1?=
 =?utf-8?B?Tk9GcDl5eCtqSnFKNGpVOEdWT3R6RExLVXpNY1Q0MmhYQ3k5cnVhWTkzQmdo?=
 =?utf-8?B?Z1JJdzBSTk1LOGkreUVsa3hQNmNHbFZ3NHI2ak82Tk9Idnk2RTJMeFZDejN2?=
 =?utf-8?B?ZmI5VGZGeWtPSTJJUDBJci9VdDRRWGtOUE1UVzFxRDBNMzRoUXZnZXZQejMv?=
 =?utf-8?B?ZjFIMkJTemljeDBlQi8vTUZRNDNhcTJtQ251QWgwQ3c2T3ZTV0dUb1N2YTdq?=
 =?utf-8?B?ZkNSZTNxSHB1bCthY3hpWEVhUzlFdVhxTytFNDlsNDBCTTduT2g3SUNDbzRy?=
 =?utf-8?Q?I207WWqaw8q5Cg2belvgOtDLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b5d854-1974-4d19-ea9a-08db35a8a343
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 07:37:41.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMabXaxPrYitODTGuoxcD3oMDYuzpiIbGTmY965RJpJ0GuLlQLbxjp8Bwj1ZiAbaqCw2rGVsAS7u0vF9CAMldA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/2023 3:11 AM, Tom Lendacky wrote:
> On 3/26/23 09:46, Nikunj A Dadhania wrote:
>> Add support for Secure TSC in SNP enabled guests. Secure TSC
>> allows guest to securely use RDTSC/RDTSCP instructions as the
>> parameters being used cannot be changed by hypervisor once the
>> guest is launched.
>>
>> During the boot-up of the secondary cpus, SecureTSC enabled
>> guests need to query TSC info from Security processor (PSP).
> 
> s/Security processor (PSP)/AMD Secure Processor/
> 
>> This communication channel is encrypted between the security
> 
> here as well.
> 
>> processor and the guest, hypervisor is just the conduit to
> 
> s/hypervisor/the hypervisor/
> 

Sure, will change commit message

>> deliver the guest messages to the security processor. Each
>> message is protected with an AEAD (AES-256 GCM). Use minimal
>> GCM library to encrypt/decrypt SNP Guest messages to communicate
>> with the PSP.
>>
>> Moreover, the hypervisor should not be intercepting RDTSC/RDTSCP
>> when Secure TSC is enabled. A #VC exception will be generated if
>> the RDTSC/RDTSCP instructions are being intercepted. If this should
>> occur and Secure TSC is enabled, terminate guest execution.
> 
> This seems like a separate patch.

Sure.

>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---

>> diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
>> index 834cdae302ad..d5ed041ce06b 100644
>> --- a/arch/x86/include/asm/sev-guest.h
>> +++ b/arch/x86/include/asm/sev-guest.h

>> +#define SNP_TSC_INFO_REQ_SZ 128
>> +    /* Must be zero filled */
>> +    u8 rsvd[SNP_TSC_INFO_REQ_SZ];
>> +} __packed;
>> +
>> +struct snp_tsc_info_resp {
>> +    /* Status of TSC_INFO message */
>> +    u32 status;
>> +    u32 rsvd1;
>> +    u64 tsc_scale;
>> +    u64 tsc_offset;
>> +    u64 tsc_factor;
> 
> This should be a u32 ...
>

Right, will correct.
 
>> +    u8 rsvd2[96];
> 
> Which then makes this 100.

Yes.

>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index 3750e545d688..280aaa1e6aad 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c

>> +bool __init snp_secure_tsc_prepare(void)
>> +{
>> +    platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
>> +    if (!platform_data)
>> +        return false;
>> +
>> +    /* Initialize the PSP channel to send snp messages */
>> +    if (snp_setup_psp_messaging(platform_data))
>> +        sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>> +
>> +    if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
> 
> Should this be checked before allocating memory and calling snp_setup_psp_messaging()?

No, as we need guest messaging to work without Secure TSC as well.

 
> Also, I notice here you use the cc_platform_has() function but in previous 
> patches you check sev_status directly. 

For sev-shared.c, cc_platform_has() is not available when compiling boot/compressed.

I will change the below call site to cc_platfrom_has() after testing.

arch/x86/kernel/sev.c:  if (regs->cx == MSR_IA32_TSC && (sev_status & MSR_AMD64_SNP_SECURE_TSC)) {

> And you don't implement support for 
> CC_ATTR_GUEST_SECURE_TSC until the last patch instead of now.

This is to make sure that SECURE_TSC is enabled only after the last patch.
As cc_platform_has() is being used at multiple places to enable the feature.

> You can't get here until SNP_FEATURES_PRESENT is updated.
> 
>> +        if (snp_get_tsc_info())
>> +            sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>> +
>> +        pr_info("SecureTSC enabled\n");
>> +    }
> 
> Blank line.

Sure

Regards
Nikunj

