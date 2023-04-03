Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612756D53C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjDCVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjDCVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:43:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561B249C4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNQz4Wl8OACWwNbArJ703cjz+VFQULSXX6HbkJxA76ownX7r7eg2l2ApdXt0nvfQLG32RwKkr+r5fizkYsGv9NCNI+zm6yir98WWHvikKncYiICswCIshpMT5mLH86eN4IdgOotJF5ZqgfFX1VZ5bNwPflC757eYnLNuYwy8Ap5aOe2s0lJifsHMX7UKHYpwfjD7qr5ekOPs5fkdpuD858OtxzmOTsEg/TB+vnxpIZOScHN5uiNGmzbR4MWpldWk0UMb1hlYeprwxuozxBkOf1j2FGrzWB9Q6RitfM9U6CLByuyJaNUpvWANOaevPEQe3SiBbvUUxRKyXyBOdwgoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVGPwrm51trozILJE+/NMR8b8BT4ciaimkg0+IeAPkc=;
 b=CYojZ1iiopgZcJG/pGq6BOhYQPHeQEJ4ZVwGjoMT62bPtPqfscrpjEIsXjnXC3PDd25SspNYT/KUR1c7lyT2tyzSttJKylS8c2ZTOV3YBU2g4W5+exAL/iOy1LO7z+zyFraql7UpOrXmCkipsrPSQD2Q7/2e13sCnslSiqdTwLe7aOTuVNhBulzYYi4bLTzRriFuQlcTdgRsgVnk4OsgxmkZ1oi+BegyoMSxi9Vx2WmTWclJ9MAdoKqlmqbbjcTQ+pVNKZLMV0BNmlYwluTydIL0v3SOg7O5dt/Zh3zQYI+mdmZ2y6zEB4FGPEtm8y0rfbtq/p1EtvlH2+Hn6IyMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVGPwrm51trozILJE+/NMR8b8BT4ciaimkg0+IeAPkc=;
 b=tgCglyq1WiR4v3ihM3J7B6u4wafYlzq9UJCc9DlnfIWCH/rHTkAI1om4rmxH95onkvGAY3ZfRIls+X88JYP381d/oAJ8enFV4DGa5ZCD+Mpytxq0RuHyTiPMspq2DDUH7uYrKugCnNq7weNTBUOqpNjN7VaYGivLjMh+lse6gzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 21:41:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 21:41:40 +0000
Message-ID: <027ac704-2a7b-9ac7-d2c9-584ed840666e@amd.com>
Date:   Mon, 3 Apr 2023 16:41:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/11] x86/sev: Add Secure TSC support for SNP guests
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-9-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-9-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:207:3c::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aa816d-9f06-49e3-c445-08db348c355f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpbieNePuF/LYliK0ive/pPwC0PLWUXrDSraZQ2zj37++QMIxFJik484utQLbxjxkBCc9vlYyYylGAU1hbQyr9PVn3nkyDk9+bOEzjnx8e6ANffQcd2CkZ1DlJsJ3GtbLu+zmJj1J50nnO5bEfqrrDb4W0aSzUKEKHR31Lu00jOCKGFX2Ujourcp+Pk3YLK7iKIU1KTBlPAwZLn84QHi9Low2PHMyB/VCEbkXs1m6LimeJqKsv4IcfmDTe+laDKdJGvugeMyCZSmwL0u//5K//7uWkIDcYy5bO35dq8S/18LxAPVgcQePNIrVHC51GbtD2XuywRbrspUsclloDTQscKmXxQWj+v+aPmREFyjWzskrtQQy0jdgJIBCeI8DUT5jGuGAuQEo81d/63H3JPJnMs9SOZNCBL18vtCvnX59u8blwAloSNIGUKK7k+7JMc53gNLzaed1uMxfJNiFcO8jDcXOIlsIIhHx1cWKQgK0ogb/yEbSqEM62lmpeaIyLxNwUhilQ3SJ7JjJtVrOSK+QfJ31WVw9fccCZtzZ2FZcZe471E1G0qaaFCUUE1vEnxekat9mOXWaIgP4tqADBstZs5T+kYN8pwswswF1ebLD1Mqi5DYBontJQCXEGMCffYiuWA6SfZksgD9ykGUmZIgMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(31696002)(86362001)(2906002)(36756003)(31686004)(53546011)(2616005)(186003)(83380400001)(26005)(6666004)(6486002)(6512007)(6506007)(66476007)(66946007)(66556008)(478600001)(8676002)(41300700001)(5660300002)(38100700002)(316002)(30864003)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29UMmh6blVPMC9oKzQweFJKSmdQOWJ2dFdJSjZsaExWbnJhRzhGbHkyR0N2?=
 =?utf-8?B?QUtUZGZDWUFNR3Iwblpoam5pMjFLTXkrYnNTcUR2SVowdDdaTVQ3azF1V0kr?=
 =?utf-8?B?NVdxSU0wNjJKN0hjajZFeHZkZ2gvYTY1ZFNUTWJYUkRoWGpPZUFMRk83OVF4?=
 =?utf-8?B?T01GM0JwRmZUT3pUU29nS3drb0xDc292cnQ0NFlOcmlXUjZkZkt2NUJxN3JP?=
 =?utf-8?B?Uy85S3JORDh0d0pHNHBVdVZjc0VZUnZVYzZ4QmM0eUcxU2k5c04zbE9UQmJu?=
 =?utf-8?B?Ukt0dC9iRjAvZURuSTZ3cjYrMlhMYnZKYmhnZGZBSFB0QkJqcDNsVHNNTFF0?=
 =?utf-8?B?RFQ4SnFaYk8vdmxTelY4dTVZRnRvdTNNV084bkJFZzF5aTNlTUUyQUloZ1hN?=
 =?utf-8?B?cWRaZEFHNkRlU0pYVHdkRUJwUWtrb2RXbHFkMWtBbTMxR3cwZ0RqSzRqNDJL?=
 =?utf-8?B?SG00ckJQV0lSNEZqQWRTVWdsbVJVVFdTWlIrU3RuL210Und1MFdSUkdJd2oz?=
 =?utf-8?B?Ym5rSW05SDRqMURHZzVES3hRcnBKcUgraWFTSWRTQ1EvZUlQUnZ6N1hsMkVp?=
 =?utf-8?B?Sk5qbVRLRVRqQU5Vc1I3OHlGKzRkblpBOXQwdVVJVGhhK1hzVEFnaENqWTdh?=
 =?utf-8?B?MzRDQXU0dU5Gd0RXNTM2VDFaeVBpTjErTS9YY0lRZnBIN0hqTGl5NE9NckxU?=
 =?utf-8?B?U1Q2eFIxZmJKRUZvWENtTlhUZ2gvWm9IeURZckdiUDN2MnVSWUtYRk4yb3JZ?=
 =?utf-8?B?cE5CWGNEQkdMTWk2SFUwQzdmeDQ4ZmV4bTVwTUdJd2lhN3dkWHF2R0RLWUFV?=
 =?utf-8?B?NzdhYjQ2MFBoN3JwNHN1QzgxT0lybGlRS3dEeWxzY2Y1aENmdUNpcU9NbjdE?=
 =?utf-8?B?RkRrRysrd294aTU1V2E2M1p5TVkvK0Fnci9Fd1R2dTYxOU1Jck5QMU1nUXd5?=
 =?utf-8?B?ZmZ6UHdsdzBzR3QyYXQ0anRBRjh6Qk9iVmJVUXpGSjhzWGhVRTNjUHZSOUJK?=
 =?utf-8?B?VHVtdXFLRFVBaUpDZ0h0SjNidkJhWDltREhQbXNpd3FCcnhleEtWM3YvODJy?=
 =?utf-8?B?OU04YUdIRkw0UC9KMGFyY3lrMzFQL3oydC9oSzFwME9DQ3NWeWVtNU5xYXJo?=
 =?utf-8?B?YzRxSEVBbitPSXgzbUtjbmFiZlptS2dxVHJ5TDFuT3IxWE44UTFtTFdHY05O?=
 =?utf-8?B?WTNnajZQWVVscmVKRWhBbGJza3hKUGpnU2lkOTNETHdXTUphMlJJSDdGTWNS?=
 =?utf-8?B?L1JuUWduRUUzQjJTRjdiWXNTc2pRUTd2Nmp4aEJXMEJOQWttYUxxMmJZUGxk?=
 =?utf-8?B?NGYvQXpVamNBM0dmZUhiZDVlS3gxTWRwdGdaMTI2cWFmdkJuQm5jNm5JYTRp?=
 =?utf-8?B?Uk9mYi9ZLzN3QXFacllvMy9NTlVqSE1BTDZ1UEhBNmdqcTBHdWRINk9sd2Vo?=
 =?utf-8?B?OUJqK05XYkxBTDhPV3A1VTVUa2hWNCt4cUljK2EyY0czYlRZYWFDekFhZWVx?=
 =?utf-8?B?OExqbVdQZHpMbGpiS3QvUHBlM0wzekF0THJVcFo3TUR4TThTUFpWVFJORVVW?=
 =?utf-8?B?Qi9DTTBNbjFkTFAwd1pjR1JmeEp0TDllVVdGOERON0Vya2I2M1ZzOWtHWWdY?=
 =?utf-8?B?WnpOc2tNYWRNcngzWEZKb0Y2ckFLdGFKZGh6b0hhMmo3NjBWMnlXbkNqdXd1?=
 =?utf-8?B?TXNuUXJnbElMaWF4UDJxdWRqWG1QaXZLOHBnQlViYzIza0JZNzk5dVJjYVIy?=
 =?utf-8?B?NHFIWkhZMVk2NzVoQlJoeFUvNk5BQ2V6RnBYcEhQcENHbnhtNTJITmJtZ0Q1?=
 =?utf-8?B?WGQ1SjQzbEdiSkxOMmtPS0pvZFprenhxTUMvdElzODdKZVpkQzg0NmxaNXov?=
 =?utf-8?B?ZHhWbUNZbWtNazBEbnBKYWFENnJpbGIwTWNQMmI0MHVBRUtJMEdhUlhkeXRI?=
 =?utf-8?B?K0M0ZjlnQitWYmFqbjdRMXdKQm05QjlRZStuTkdxOFY5Sm1IWWpONmcvR25v?=
 =?utf-8?B?UXYyN21JZ0twRndONmJGNThVdjFtRFpxbXlNdGhraG5FdEdZRDI4enBSTE9K?=
 =?utf-8?B?Nlh6QTNyNEg5cDBIWXFGSU1VcnN6YW5kQ3ZvV1d4ODJUWVhZcnFFSldEYzBi?=
 =?utf-8?Q?DAlYShweOKuRCXC+Xv2lCyl+h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aa816d-9f06-49e3-c445-08db348c355f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:41:39.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DinbNabnep93S1sgYgD+Oqx+cXKXGey9enYIYNZtqOagCeMTEC1qDQKyUN5z+cxliIYXY1LNIWyslK9HHKFndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> Add support for Secure TSC in SNP enabled guests. Secure TSC
> allows guest to securely use RDTSC/RDTSCP instructions as the
> parameters being used cannot be changed by hypervisor once the
> guest is launched.
> 
> During the boot-up of the secondary cpus, SecureTSC enabled
> guests need to query TSC info from Security processor (PSP).

s/Security processor (PSP)/AMD Secure Processor/

> This communication channel is encrypted between the security

here as well.

> processor and the guest, hypervisor is just the conduit to

s/hypervisor/the hypervisor/

> deliver the guest messages to the security processor. Each
> message is protected with an AEAD (AES-256 GCM). Use minimal
> GCM library to encrypt/decrypt SNP Guest messages to communicate
> with the PSP.
> 
> Moreover, the hypervisor should not be intercepting RDTSC/RDTSCP
> when Secure TSC is enabled. A #VC exception will be generated if
> the RDTSC/RDTSCP instructions are being intercepted. If this should
> occur and Secure TSC is enabled, terminate guest execution.

This seems like a separate patch.

> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   arch/x86/include/asm/sev-guest.h | 18 +++++++
>   arch/x86/include/asm/sev.h       |  2 +
>   arch/x86/include/asm/svm.h       |  6 ++-
>   arch/x86/kernel/sev-shared.c     |  7 +++
>   arch/x86/kernel/sev.c            | 92 +++++++++++++++++++++++++++++---
>   arch/x86/mm/mem_encrypt_amd.c    |  6 +++
>   include/linux/cc_platform.h      |  8 +++
>   7 files changed, 131 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-guest.h b/arch/x86/include/asm/sev-guest.h
> index 834cdae302ad..d5ed041ce06b 100644
> --- a/arch/x86/include/asm/sev-guest.h
> +++ b/arch/x86/include/asm/sev-guest.h
> @@ -37,6 +37,8 @@ enum msg_type {
>   	SNP_MSG_ABSORB_RSP,
>   	SNP_MSG_VMRK_REQ,
>   	SNP_MSG_VMRK_RSP,
> +	SNP_MSG_TSC_INFO_REQ = 17,
> +	SNP_MSG_TSC_INFO_RSP,
>   
>   	SNP_MSG_TYPE_MAX
>   };
> @@ -75,6 +77,22 @@ struct snp_guest_req {
>   	u8 msg_type;
>   };
>   
> +struct snp_tsc_info_req {
> +#define SNP_TSC_INFO_REQ_SZ 128
> +	/* Must be zero filled */
> +	u8 rsvd[SNP_TSC_INFO_REQ_SZ];
> +} __packed;
> +
> +struct snp_tsc_info_resp {
> +	/* Status of TSC_INFO message */
> +	u32 status;
> +	u32 rsvd1;
> +	u64 tsc_scale;
> +	u64 tsc_offset;
> +	u64 tsc_factor;

This should be a u32 ...

> +	u8 rsvd2[96];

Which then makes this 100.

> +} __packed;
> +
>   int snp_send_guest_request(struct snp_guest_dev *dev, struct snp_guest_req *req);
>   bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id);
>   
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 36868e21c3e0..d05cbab5e9e0 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -218,6 +218,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>   void snp_set_wakeup_secondary_cpu(void);
>   bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
> +bool __init snp_secure_tsc_prepare(void);
>   int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
> @@ -238,6 +239,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
>   static inline void snp_set_wakeup_secondary_cpu(void) { }
>   static inline bool snp_init(struct boot_params *bp) { return false; }
>   static inline void snp_abort(void) { }
> +static inline bool __init snp_secure_tsc_prepare(void) { return false; }
>   static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
>   					  unsigned long *fw_err)
>   {
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 770dcf75eaa9..c781f8e0aae4 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -404,7 +404,9 @@ struct sev_es_save_area {
>   	u8 reserved_0x298[80];
>   	u32 pkru;
>   	u32 tsc_aux;
> -	u8 reserved_0x2f0[24];
> +	u64 tsc_scale;
> +	u64 tsc_offset;
> +	u8 reserved_0x300[8];
>   	u64 rcx;
>   	u64 rdx;
>   	u64 rbx;
> @@ -536,7 +538,7 @@ static inline void __unused_size_checks(void)
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x1c0);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x248);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x298);
> -	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x2f0);
> +	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x300);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x320);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x380);
>   	BUILD_BUG_RESERVED_OFFSET(sev_es_save_area, 0x3f0);
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 3a5b0c9c4fcc..1c22025b298f 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -912,6 +912,13 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
>   	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
>   	enum es_result ret;
>   
> +	/*
> +	 * RDTSC and RDTSCP should not be intercepted when Secure TSC is
> +	 * enabled. Terminate the SNP guest when the interception is enabled.
> +	 */
> +	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
> +		return ES_VMM_ERROR;
> +
>   	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
>   	if (ret != ES_OK)
>   		return ret;
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3750e545d688..280aaa1e6aad 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -72,6 +72,10 @@ static struct ghcb *boot_ghcb __section(".data");
>   /* Bitmap of SEV features supported by the hypervisor */
>   static u64 sev_hv_features __ro_after_init;
>   
> +/* Secure TSC values read using TSC_INFO SNP Guest request */
> +static u64 guest_tsc_scale __ro_after_init;
> +static u64 guest_tsc_offset __ro_after_init;
> +
>   /* #VC handler runtime per-CPU data */
>   struct sev_es_runtime_data {
>   	struct ghcb ghcb_page;
> @@ -1107,7 +1111,7 @@ static void *alloc_shared_pages(size_t sz)
>   	return page_address(page);
>   }
>   
> -static int snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
> +static int __init snp_setup_psp_messaging(struct sev_guest_platform_data *pdata)
>   {
>   	u64 gpa;
>   	int ret;
> @@ -1406,6 +1410,80 @@ bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>   }
>   EXPORT_SYMBOL_GPL(snp_assign_vmpck);
>   
> +static int __init snp_get_tsc_info(void)
> +{
> +	u8 buf[SNP_TSC_INFO_REQ_SZ + AUTHTAG_LEN];
> +	struct snp_tsc_info_resp tsc_resp = {0};
> +	struct snp_tsc_info_req tsc_req;
> +	struct snp_guest_req req;
> +	struct snp_guest_dev dev;
> +	int rc, resp_len;
> +
> +	/*
> +	 * The intermediate response buffer is used while decrypting the
> +	 * response payload. Make sure that it has enough space to cover the
> +	 * authtag.
> +	 */
> +	resp_len = sizeof(tsc_resp) + AUTHTAG_LEN;
> +	if (sizeof(buf) < resp_len)
> +		return -EINVAL;
> +
> +	/* Zero the tsc_info_req */
> +	memzero_explicit(&tsc_req, sizeof(tsc_req));
> +	memzero_explicit(&req, sizeof(req));
> +
> +	dev.pdata = platform_data;
> +	if (!snp_assign_vmpck(&dev, 0))
> +		return -EINVAL;
> +
> +	req.msg_version = MSG_HDR_VER;
> +	req.msg_type = SNP_MSG_TSC_INFO_REQ;
> +	req.req_buf = &tsc_req;
> +	req.req_sz = sizeof(tsc_req);
> +	req.resp_buf = buf;
> +	req.resp_sz = resp_len;
> +	req.fw_err = NULL;
> +	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
> +	rc = snp_send_guest_request(&dev, &req);
> +	if (rc)
> +		goto err_req;
> +
> +	memcpy(&tsc_resp, buf, sizeof(tsc_resp));
> +	pr_debug("%s: Valid response status %x scale %llx offset %llx factor %llx\n",
> +		 __func__, tsc_resp.status, tsc_resp.tsc_scale, tsc_resp.tsc_offset,
> +		 tsc_resp.tsc_factor);
> +
> +	guest_tsc_scale = tsc_resp.tsc_scale;
> +	guest_tsc_offset = tsc_resp.tsc_offset;
> +
> +err_req:
> +	/* The response buffer contains the sensitive data, explicitly clear it. */
> +	memzero_explicit(buf, sizeof(buf));
> +	memzero_explicit(&tsc_resp, sizeof(tsc_resp));
> +	memzero_explicit(&req, sizeof(req));
> +
> +	return rc;
> +}
> +
> +bool __init snp_secure_tsc_prepare(void)
> +{
> +	platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
> +	if (!platform_data)
> +		return false;
> +
> +	/* Initialize the PSP channel to send snp messages */
> +	if (snp_setup_psp_messaging(platform_data))
> +		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +	if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {

Should this be checked before allocating memory and calling 
snp_setup_psp_messaging()?

Also, I notice here you use the cc_platform_has() function but in previous 
patches you check sev_status directly. And you don't implement support for 
CC_ATTR_GUEST_SECURE_TSC until the last patch instead of now.

You can't get here until SNP_FEATURES_PRESENT is updated.

> +		if (snp_get_tsc_info())
> +			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +		pr_info("SecureTSC enabled\n");
> +	}

Blank line.

Thanks,
Tom

> +	return true;
> +}
> +
>   static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>   {
>   	struct sev_es_save_area *cur_vmsa, *vmsa;
> @@ -1506,6 +1584,12 @@ static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
>   	vmsa->vmpl		= 0;
>   	vmsa->sev_features	= sev_status >> 2;
>   
> +	/* Setting Secure TSC parameters */
> +	if (cc_platform_has(CC_ATTR_GUEST_SECURE_TSC)) {
> +		vmsa->tsc_scale = guest_tsc_scale;
> +		vmsa->tsc_offset = guest_tsc_offset;
> +	}
> +
>   	/* Switch the page over to a VMSA page now that it is initialized */
>   	ret = snp_set_vmsa(vmsa, true);
>   	if (ret) {
> @@ -2698,11 +2782,7 @@ static int __init snp_init_platform_device(void)
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return -ENODEV;
>   
> -	platform_data = kzalloc(sizeof(*platform_data), GFP_KERNEL);
> -	if (!platform_data)
> -		return -ENOMEM;
> -
> -	if (snp_setup_psp_messaging(platform_data))
> +	if (!platform_data->ctx)
>   		return -ENODEV;
>   
>   	if (platform_device_add_data(&sev_guest_device, platform_data, sizeof(*platform_data)))
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 9c4d8dbcb129..7d2388e52b8f 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -215,6 +215,11 @@ void __init sme_map_bootdata(char *real_mode_data)
>   	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
>   }
>   
> +void __init amd_enc_init(void)
> +{
> +	snp_secure_tsc_prepare();
> +}
> +
>   void __init sev_setup_arch(void)
>   {
>   	phys_addr_t total_mem = memblock_phys_mem_size();
> @@ -501,6 +506,7 @@ void __init sme_early_init(void)
>   	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
>   	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
>   	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
> +	x86_platform.guest.enc_init		     = amd_enc_init;
>   }
>   
>   void __init mem_encrypt_free_decrypted_mem(void)
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd1c12f..e081ca4d5da2 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -90,6 +90,14 @@ enum cc_attr {
>   	 * Examples include TDX Guest.
>   	 */
>   	CC_ATTR_HOTPLUG_DISABLED,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_SECURE_TSC: Secure TSC is active.
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using AMD SEV-SNP Secure TSC feature.
> +	 */
> +	CC_ATTR_GUEST_SECURE_TSC,
>   };
>   
>   #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
