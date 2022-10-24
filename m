Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D093160AF11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJXPaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiJXP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:29:44 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067F31EC64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxxibyM69QFhPxw/f/llJVBfwzBlSXtUiXN9m0ZETEZKkdVqCPCA/ou3PMHIIdKfhdGqHpIUkPOLmLdwHZgAGrmbOoiYzv6orDbULSuHqfEeG/Yi+Z7VgmZPjy+1LALQ5XtvTdKDIcDUOU6sllp+iWH9MqqgbKT80iL777u2fF6IV31KQPFMRIxeE/F0bUizqn0EceeBFR/G4NphWbTCQ+lLsBc6XfUF/VFOp8YKt9aXcKEZI+o1dyblwDqkZ7lFdHPrlm8zfNEw2Cg/idcdmtxBoQlZH3Shwbow/SIt3WzAkT0+ydvuUTYpPEMQzna0LKgDJYbYB8heCXF9PAAYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG7Eg9i1ggVPISnypN+HJCSR8a8fsolfEj5aA7ABVrg=;
 b=U6U4+UxfdRg8Pad/UVZvOgb7jIQ/oR2/HLyy9zdUFNv2S72wH/Fn82sFF8OsEAVOz+D1k3xntkU6FxDby+Wf7PdGXUer5QGhflGNrV5U37wQ6z+2JIh9EogZnKEVD7hvu/BoN5N2jkT0Vo7G2G1BT6vBiJ7VoFRgzNNRXwvRJRXLIv9ZaK13ICM+Tz3zuFluqLuPMrF58bIhHJ2Wyy7v16HnljQGZYmSACIrs/01aBAzSoVPViw/ITEpziKaHZjLDtccnRihdUHcohgjxh9Z1Xmbu4Dub+g+FjWbbLlLrlX0Zu5RUwUNcYGC9VC2fK2PpqOtFEESsrOQCR3V+jHq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG7Eg9i1ggVPISnypN+HJCSR8a8fsolfEj5aA7ABVrg=;
 b=YbOH8TM++9FWOucSwzF6DMiE/pfzKvWs5hnR4wOVuaKHwZV+g0222GNLs4YKPhPqwziXM/kAnUWTt2dd9kNFFMr7A9rQeNupn4R8UfZ7+AQfPtCbp74cfvZNsvdTMrNeyC7fRpP8mvFBh4PC6e9LLcv1Si9X/RjyZrlCer7xqH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 14:09:41 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 14:09:41 +0000
Message-ID: <ce305ca6-959f-8b39-79e0-ba77b000413f@amd.com>
Date:   Mon, 24 Oct 2022 09:09:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 2/4] x86/sev: Change snp_guest_issue_request's fw_err
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221021165943.1968044-1-dionnaglaze@google.com>
 <20221021165943.1968044-3-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221021165943.1968044-3-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:33::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: bb18c84f-f770-4f57-b72d-08dab5c96512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5CAnMbPh3B8jYbe9rI6UZjchzdRpkpri+QdtxAmuDiIbCqUvSMTcFtcYLlubawEz6iWF8BACat/qSBxpFNrs1tDGb1p7pEQj231kEHmBWvk6d9B5JyBziMAHtGDGmk0czcyuo9KAz5MFQKj3tvo/74HL4Uqe0WiPIPpb+9dsYJ6KtB5U4sZ9cZwTqSW6Rt5mOHwgwQwW/XUzpgw7tEEEaoCcxI4WLpnJzYNYj61cf4DZGESBBTi2/Sk7Rl9yL8PFKHk/wLah9p081DXmVwTYoFpju04pSJNKvxjU4Hksz/7Qu7E5A4vyTLPfJnZpRpHKZQtzhHjW7vLUWaQBkUwvtbkMxKHlTBEFWvhlbkC0c52dCVqcfkQI17m+ep79qlPV3rcZHhajVfArQyZSl5JH+6ZEOdfy2iMT9l1fhIGZ1EUdg3mVrQ7aHwxJyaYOjZ26FZ7Vc/OynbqOWs48WDYdgpDsbh6/Z07D6LOmdqfxKBhu1krFdHoddRa84TR4CKXxoGGv5IKtf6D6BelDBtknBClSNzRlZeV1v4gEe6+2Q810F9Cpq++tdHNgBVr3HbFrWIHo4tEHuqLnUg9chpCF+mAsKK0KiqgH6deFmQ8m3Sd5Un92oUhTtB5kqiAb78H5nUBC5kmDM/y/cGJRedQPDqUmvKW342SY3Lopacb7YREqgNMp/KKQhiHWdLogLZzXgrblV42+j70Lchd+TPcUsK2us28I3Nf39hIepbJgou4WGAfBFep89S/aFpxKJYElfxbzmVymMODInxSJQ47Z6am/TFxO2hBER7obToPa0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(41300700001)(26005)(8936002)(6512007)(5660300002)(66946007)(66556008)(54906003)(53546011)(8676002)(6506007)(36756003)(4326008)(66476007)(316002)(38100700002)(186003)(2906002)(2616005)(83380400001)(31696002)(86362001)(31686004)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtCMWw3dlplNC9OYVBFNW1XODNNb0g3d2JXd3p2eDNTcUtITURLVnpyOHZi?=
 =?utf-8?B?NFF6YkwyUVZjUkJhN1VnT0l6QmxZUFJtQllDT1VuZkNtbG9vcXlFVmhTWWt3?=
 =?utf-8?B?MXZPb2JRK1BheEZBandpeTZEL0JWNThwWEVUNUQ1WXpoRy9DbVFoNHpuZVFU?=
 =?utf-8?B?dHdQU05oNkFtK01DaVlhRFlvb1pJOGZoU0hvb0x5aUlNWHIxRlRUaWxHMWtN?=
 =?utf-8?B?QVZmNlpETVhLZzJNK3k5YVErdkhlSTRHZHZGVUQ0MVZmdlNkQ3ZsSHh1eDNG?=
 =?utf-8?B?aXBobG4rcmVpaSsrNkFDUHR0cThXSGllR1kwMkxnbUxoZWRMZlh3OEtSL25U?=
 =?utf-8?B?RDdzTnBMQUl5azVWK0F1ZGE4U1M1aHQ3cW1HaEVxSy9uakk3MzNkb0lFMFRZ?=
 =?utf-8?B?UldPOGl1UzREa0dwbHRMNEN6VWJ5b2luNGtkbEF0cUpPVnJ4c3NUT0tKVTNH?=
 =?utf-8?B?VHJtWGl5Zmd4OFVmdklRbHJaYmtMZGpKUkR6bGhiUkdWTDgwNHcva0g5amxJ?=
 =?utf-8?B?L2RXNnVkNmROdTMveWlUa0hiWjYxaFpjREM5UGdEWHZFMUNXbUxuSENmK3pK?=
 =?utf-8?B?c3NVVkxtTG9VOFlYN0dYN1ByMFdLNjJDVXh0U01DdDcvb1RMd0llcGF2bE9G?=
 =?utf-8?B?b3RsTS9za2pEbk5iNXl4UDZ4cGtOa1RVM2lPZXJLbE5Jd0MzakFickVwRUM3?=
 =?utf-8?B?Tkx4Z0NTc2xUYUxqMk9zK29xNWgyRGhLbmhJZjU2eVpOTXZoOFN4L1NkUC9L?=
 =?utf-8?B?UWxBUkhNT1NuMndoaEZkSVNVY25JSW1wVTJINjIweFlRb2xVc01GeTgwUnNn?=
 =?utf-8?B?Q3FPcEswQXQ5T3RiWURaL1RMK203Lyt4YklpVzZtRHYvUVZYOXIvRWtPdEJw?=
 =?utf-8?B?MTZaTXg5ODBrNGxRYi96bk1MQTFyTWJ0dFVnV0FUL0xjenRWNGVMUUNxVTVu?=
 =?utf-8?B?RVNEZEh6bEtISzE0TzFPQStWK1c2WFd4L3hJOXNiRU5zRmw1U0IxbVdHeVhU?=
 =?utf-8?B?TXp3dEYvOWNibWZ5R24ydDVFS0VKejF6bWFadnpzRHVVMklGbVM0Sm1UdTdM?=
 =?utf-8?B?TFBYbnJXT0Q4TVo0RVVPZmV2T0hSbEtLRkpNL0FpQ3RiSThNQ2JHbjV1dlpX?=
 =?utf-8?B?QWdaMEplR25xcDhmcTFvQi8zT2xJVGwvNUVuUHZQVkhLZFZsN25uZmJkNHlM?=
 =?utf-8?B?RVlQQnZoUkUvdGx5TWpRTkd5T243MU15SGNoT2lTUTYxcGE2N1V5dHNURFpr?=
 =?utf-8?B?RFZNSFAveVRhcnlaV3hqWGdoSStYQ2g0eE4xN1VWc241Q2VXYlpXOEgyQ0NX?=
 =?utf-8?B?T1VkcU80MVhZWlZlVEg3ZkFUS28ySXduNWU0ZFJiVDhFdnlEOVZ5aVVKNW1l?=
 =?utf-8?B?SUgrd2RsUlc1VGE2VCt0dGdmaG1IRFo4UzZLL1ZScXZ6TnBqRVRSc0hSWUhW?=
 =?utf-8?B?cjJqM3BpWmxieFZDTmFnZFpnNVkrOGd2TzRSbTRaTlhUdnNORHV5UHFnaDlL?=
 =?utf-8?B?ZVJSdThZdVRVdUM0L2xIcnFTczBEMERERi8wVHBQNTQ2cjM5cTVuRGVKZ0FJ?=
 =?utf-8?B?VHlNSDJrd0R5WWdOTjBYRHZ5Q2F2d2FhZ2lXa0ZLbHlhWVZxUTZKbFY1U2FQ?=
 =?utf-8?B?MXcwK1J3ZlJEanRqREpvNndsOHdRY0h3VWlDaC9weWV5Ky9SM2hkNnMyYmlT?=
 =?utf-8?B?eXV6RnQyeGlPdmNwNGRmT2dHeVJaclV6bFFpYjdsNWc2UXJSMEFWMVc4dE8w?=
 =?utf-8?B?djhaL01HbXpuTlRZajZRenhMejFSNjZhNVV1U3BkTFhOM3BJeG8vMSt4WUJk?=
 =?utf-8?B?Z2k5SVlSakRXbzlQZ0Y0K1FOemh6TkIzUHJPVG01NThqOG1NUm54OVJrSXhH?=
 =?utf-8?B?WWFZeXdVZVMralZmOENhaU5QTHdybjNaby9QU1BMd1VRVjBXb0NJKzloWkxG?=
 =?utf-8?B?UEdEeFZYdG9HN0F0blJyQ3RmOW91TVMvZm41TC91cTRBNW5jaVpvaEt3UnQw?=
 =?utf-8?B?RjV0cTRVNWw2aEQyYUp5dHE1T3BPMUx0KzJIUDIrQXhGa3IvaEtvMXowZC93?=
 =?utf-8?B?YUJOT1Fwc2ZieXRiOVFIYk1jSTV0TDFrc2dsT1lKRWdPTFpMdXlTcmsybWt5?=
 =?utf-8?Q?BOVnFjAfh+1pHfJVf98gD+I8F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb18c84f-f770-4f57-b72d-08dab5c96512
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:09:41.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUnh/ZmOARWw2c2XalXZ8MWY1Mhco7S0k9XxyGVJDEu2NuOnhTMUy+bAgjhLxedcV7YttNQUwJ6WxwWYi/B06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 11:59, Dionna Glaze wrote:
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
> 
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's previous unsigned long*.
> The signature change requires the follow-up change to
> drivers/virt/coco/sev-guest to use the new expected type in order to
> compile.
> 
> The firmware might not even be called, so we bookend the call with the
> no firmware call error and clearing the error.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   arch/x86/include/asm/sev.h |  4 ++--
>   arch/x86/kernel/sev.c      | 11 ++++++++---
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..8ebd78b6a57c 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -196,7 +196,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>   void snp_set_wakeup_secondary_cpu(void);
>   bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
> -int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
> @@ -217,7 +217,7 @@ static inline void snp_set_wakeup_secondary_cpu(void) { }
>   static inline bool snp_init(struct boot_params *bp) { return false; }
>   static inline void snp_abort(void) { }
>   static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
> -					  unsigned long *fw_err)
> +					  unsigned long *exitinfo2)


s/unsigned long/u64/

>   {
>   	return -ENOTTY;
>   }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a428c62330d3..5a402df7549e 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -22,6 +22,7 @@
>   #include <linux/efi.h>
>   #include <linux/platform_device.h>
>   #include <linux/io.h>
> +#include <linux/psp-sev.h>
>   
>   #include <asm/cpu_entry_area.h>
>   #include <asm/stacktrace.h>
> @@ -2175,7 +2176,7 @@ static int __init init_sev_config(char *str)
>   }
>   __setup("sev=", init_sev_config);
>   
> -int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, u64 *exitinfo2)
>   {
>   	struct ghcb_state state;
>   	struct es_em_ctxt ctxt;
> @@ -2186,9 +2187,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return -ENODEV;
>   
> -	if (!fw_err)
> +	if (!exitinfo2)
>   		return -EINVAL;
>   
> +	*exitinfo2 = SEV_RET_NO_FW_CALL;
> +
>   	/*
>   	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
>   	 * a per-CPU GHCB.
> @@ -2218,9 +2221,11 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
>   			input->data_npages = ghcb_get_rbx(ghcb);
>   
> -		*fw_err = ghcb->save.sw_exit_info_2;
> +		*exitinfo2 = ghcb->save.sw_exit_info_2;

Looks like you can do "*exitinfo2 = ghcb->save.sw_exit_info_2;" just 
before the "if (ghcb->save.sw_exit_info_2) {". That would eliminate the 
need to assign it in each branch of the if.

Thanks,
Tom

>   
>   		ret = -EIO;
> +	} else {
> +		*exitinfo2 = 0;
>   	}
>   
>   e_put:
