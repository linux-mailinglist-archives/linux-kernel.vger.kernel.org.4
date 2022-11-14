Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD2628AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiKNVBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiKNVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:01:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFD17E3F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:01:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMwsyak1YPSpPXPAtK9x87wO9EGBLLHtdTqiHaC/kazInmQKiFEVLq2/F9q4cg5zmcOPBNwD+sLGjwQoR1MtcaCs2BDkxkN3b0sMhdL1wcov+ksCubYw/q4LMi1f2qnp4DKZBfmhdbN4nyJWHn0GyiBJQds1Y6EVrSIx1w/ZlW9kzClRvaXqrGnwC/AIVLhVnB/bSUzb0YQ9xUDJPRw39HZL4PCwnBfg1trXtmR7PqujAJDSslLgHKewG5MHgffNCET/upERCVe2QB8BxeslrC2Wv42Bz3JKH4+pJKfldI4Dy8T+HpDrBywSdP6sQH7yYxnzI+fr9dsDW/CeNr251g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEsZwJbnRzibvAmWCQzwrSz0hAvDgfc2dNQpry0aed8=;
 b=ejSW4xvU36qZRj9PdnUPrhvZ/YJRXi3htpef7OwVokCaeI1vKxi2usMUdgROdS5+POd33QDbatWrZbdylHgcjAIcPuB3PTfnSRjDe/pd83REl/1ScwjU2zRRMW6K+nJq3kFhSaa/qQ418ZnVm3pkOXE86jpIf3vcSFarxIxekqym8ZnFNBHQ1Izk/6uA38oDWMZ+pArZ0CTvhiRVUtB09kQZuoFLfmA696YA8PumsxtSOnu7N/sY+2y86wCun0r5FwLk1W6KlUaXq0RcaO2DVwJ9a+XeKh31pf7C43dWQCJzVNs5Ph3V7WvP7RJh/cGMEkUtub2eWsQaUP7wFmr9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEsZwJbnRzibvAmWCQzwrSz0hAvDgfc2dNQpry0aed8=;
 b=deuGD3IgvctpAwhmlzqlhI00SElH1R7m2PGwNPCX198odFb0ez2DESNy8+687L0H4jGiTyeB5m6Fj6gepImqIw0j/1E2asZDhxEV6aNbCaXH/si4ENNPF6uS95Gp+iurwsXhzyRW7FXzuiaUojN+PrQHijALMfMG7lzkKkqsWkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 21:01:13 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:01:13 +0000
Message-ID: <d6db0885-2695-23db-ac98-b3a0dd499d87@amd.com>
Date:   Mon, 14 Nov 2022 15:01:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 2/4] x86/sev: Change snp_guest_issue_request's fw_err
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-3-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221104230040.2346862-3-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e217dd-0429-41b0-79bd-08dac6835d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZNsLLlIIh9wzhghh0ywk8Z/i5wkTVLsbnTWDU40o3bQ9FuQ/fNUFfNB0C0hkYJx57wkO9JJX83KDtEfeIZilu11srQBOy9hh5s1rdF7sUuz2o63rs8mGn7ToTw7/hc3Vy21g0hhpcLWIQfwS8LLd5JE0XbRaT8tzO8vQfykb0yu4gu1uoW7RC000GFLR6D6aGZsbtuXL2iiTC4PDahw1AtypWpW+hysLHFCiEvBvaH9nrUCMRibq2vN3M0Ba5Mf79N6QUHeUZqLkcZ2jv+Ff3bXRDhuz9G5SO6pxsBs8ye6KRV+RvNLcsrSH9n8DPZgmRjq+MIz7mgV7KMbt9ywl32VmoDKrljTFF5u3pa0YuM/ieL3nPZk0NxjBIW4oYVkuSEDAvsy5FCyVXFo+9ObyQE7CTdy7hIJimRsgr1gEoWQBkRnLUrqrGFvXaQjlM8owR7M83Fq8eIK0tUcR5iDJuyAWTkO3CPkGFexTyTxYDsFx32fTQcRJbDRekzhe+TDRhJVfL0LdB49TFjcoP65lheL7Yzf5w00VhrsIFTQRtlV6IAE53oXwE1sUVgKKOVPsEWtLKmkxWhyaUzD1Tz02+6bpCwj29P1D/jWA7vBIU8xRrw9Y8uqCBtWDTUFGWyusR7cNcV/ZYsWeaJFYRYw3mV8R8MLl3o+jKwyx8+wEnoCZDp/TiOvLJWTEj4QKOATcF4S61Tqfjsod93PBvZJh2IsHtS5nRjJn8cdi/kEnUM1i0hz/m6c33PT1IprP5D9cj2E/eWXEQNyCJpCJeis4QNwKP5LCEU45s2rNXu5wUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199015)(31686004)(38100700002)(478600001)(6486002)(31696002)(83380400001)(86362001)(2906002)(7416002)(186003)(53546011)(36756003)(8676002)(6506007)(4326008)(8936002)(2616005)(66946007)(316002)(26005)(66476007)(5660300002)(41300700001)(6512007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGoyS0swREdRa2VwdnE0YUFuZW5QTjRjeG9RN1lPVzMvZUVUd25iaXY2dmZk?=
 =?utf-8?B?azZ4aU9IWUdjeDJkRmI3UW5UWlNEMXczS2E2M1I1NERYS3p6TUZDMHVXcWkx?=
 =?utf-8?B?aXlaTEhZNE9rdzFSYU1zMDZ0eUtNYjJxbmNlcmM5OWhFaXF5TlVaVTBDWTZj?=
 =?utf-8?B?Z2EyajhNK05nMjd4Tk1wLzBaajcrelRNOXNZWm5wMTJUajZIT3JFcVhuK1ls?=
 =?utf-8?B?ejNBZmV4YzhJbE9GYzBBajVzTkpjaFF6SFRITlFHdElJVk5UYXlMMkV3UmJ0?=
 =?utf-8?B?eWp6M2FPNmZLcUFBKzFvejRJVkZtakVmOGw0WjRidEZiWHcybktGQWpwNzBB?=
 =?utf-8?B?bVB3MVQxU2RLaWRLMEZGdXd4TUxhcThaMDlzK25WMUh1N1FFcjVjVjlrN29L?=
 =?utf-8?B?MHREREVSYWNJcWJtWlljQ0ZSNGNCMzF5VmhmOHF0SEJLMGtEL1NMRE91T2Nl?=
 =?utf-8?B?dXdCc05Qd29hOFUvSjFjd0hxekFWdzZBdFgrelhFM2h1ZTJ2RjhseFdjYS96?=
 =?utf-8?B?YkIxWTl6SGZ0a25vWWFHRzU4bllsazNXWkVnSVV3MkQ2NVVuam9GTitYNUJq?=
 =?utf-8?B?N3pJTVorM1BJdThYeU5HanV3WTg4cUtqYitkMjZRR0dmRkg3QlYzMXBaSjhO?=
 =?utf-8?B?UmpJWnR1Nkx5RkdNaUJvVUFKVVFEdW1nd3M0QlJRRUtNUGsxQVdRSFJIMXJH?=
 =?utf-8?B?S1RYT3BRNUFjdG1YYTFuQzd0M3psMTJZRDNMUjVUTjAyY0V1cVg1VElWQWtu?=
 =?utf-8?B?TXluZVlRNkk5dk1oSzB5SVdqaklsOUtBYkxvK2JleXNSLzlwQzZheG5uWUhT?=
 =?utf-8?B?RERhQml5d3UzSWZUakcwVGVzV0hTdFdGcUdkVHFaTFlZT2ZvS1lCUzdVQm02?=
 =?utf-8?B?eTl5WmZyU0Vnd1NjT29GY2o3OEIrY29ZSitXeSsrOXFFWjU5WCsrN2drYUJ3?=
 =?utf-8?B?b2o3M1YzMVZ0aStvSmplTDhUMlNEaVpnVm1kSjlwMHpGQjRuaDk1MGtnbkx4?=
 =?utf-8?B?cWVNL2RINldSN3ZxZ2JyVnB3QzhFWkdIU2tvYnNCdHhKNEZ1TndGT3JwYVBq?=
 =?utf-8?B?ekdNRG9HOGJ0cDdCSUVWTmk1ZXZtNzc5TWR3QTdRcEFmZnRCb0VhaUdxVVJL?=
 =?utf-8?B?VEdISXpmRlJaNldGZW9NTjdKN2tWYVNjVjFsYmVhOTZPNmVZYjF5cHN6TEcw?=
 =?utf-8?B?SVpzVCtLYlVSS3F3UEdUc2pWUUs2WlBGcTVpbWEraisvWUM0c2E5WGp6Q3l3?=
 =?utf-8?B?UjBjeFdsLzVUNi9aQk4vWDBOU0tqcXRRQjZMeDFtMEdLZTEvNjE2YzNWSWha?=
 =?utf-8?B?WDZmN0FFTDBFTlFBSGlTNUIwZi81SmVOY3JHWmF3d1cvSTZhOEdNeC9BODZG?=
 =?utf-8?B?UEZFWFRZRlIyK2VWZXR0eU5sUFFNeFFVcFZ2S21CS3NoNVFLcjZMOHdwVit5?=
 =?utf-8?B?OUV4RXByZ3Nzd2xkblNqcm1tRkZDYnhLTThndnZ4K1lvY0Q0cTJtVGtITktN?=
 =?utf-8?B?eHZPeWVqdFdKbHZxZjdSQ0lrTXpWUFRaZUQ0TGt4Z2d0eVFBYkxUSnk0eHpk?=
 =?utf-8?B?dUdxb3dPamtRTnRpUVY2b25kK0M5WkUzMnZDZ0xRcmRDQytpOHVZVVByWnBQ?=
 =?utf-8?B?cVNyNy9DeGtVcWsxSUhOdHh3b2lDSUhSc0hDM0grY1pIMjJpRHdnZVltdzJG?=
 =?utf-8?B?TVVTMWFXVDAwUmQ4a25acGQzSGJYaitMaXZOYTY4RUNxNUhCK0FuMTgyS3Bi?=
 =?utf-8?B?c2x3QS9zcmJwQUdGQXRiQ3ZseTJQZGR5VkdSY2RoNE84WUpGSkdoMk13K3pH?=
 =?utf-8?B?TzkrcXh2Ty9QbEFvblY5dWRpQVdGMW44NzVqMi9oVU5wakx5aVBJcURSTVlW?=
 =?utf-8?B?Z2dsTnNlYWIwMHdZQ0VscktIVjk1ZW5WVnJ2R01ZbjZCSDRGei8vUjdqUEZy?=
 =?utf-8?B?aExnVDV6VnRid1ovWXRDUzlBZFRZejNkQ0w2SGZ3YTJ5aC9RejV6dm1KNldw?=
 =?utf-8?B?ejZKQURvNTFReFR0Mk5SZGg5dTd4WjFhcTg4UE9CdUJQTVp4U1RHN3JHdE5o?=
 =?utf-8?B?b3BIZXJjNTNwQ0FBNUUzU2FtRUZLZlJHa0dOcGUrYUdoUVhHRkdNa3c5SUlN?=
 =?utf-8?Q?la53+xHApJUp0GhmPwV0N6MJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e217dd-0429-41b0-79bd-08dac6835d7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:01:13.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15nrOIcEQah4Ez/MIOd4NX6r8QOj0kc20B1iTPM3sCp646FN1x6qHrhdXBhZb1WLRzO6H7ZC7Q8b+YPf/BlVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 18:00, Dionna Glaze wrote:
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
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Venu Busireddy <venu.busireddy@oracle.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Michael Sterritt <sterritt@google.com>
> 
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/include/asm/sev.h |  4 ++--
>   arch/x86/kernel/sev.c      | 10 ++++++----
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..05de34d10d89 100644
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
> +					  u64 *exitinfo2)
>   {
>   	return -ENOTTY;
>   }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a428c62330d3..148f17cb07b5 100644
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
> @@ -2212,14 +2215,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   	if (ret)
>   		goto e_put;
>   
> +	*exitinfo2 = ghcb->save.sw_exit_info_2;
>   	if (ghcb->save.sw_exit_info_2) {
>   		/* Number of expected pages are returned in RBX */
>   		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
>   		    ghcb->save.sw_exit_info_2 == SNP_GUEST_REQ_INVALID_LEN)
>   			input->data_npages = ghcb_get_rbx(ghcb);
>   
> -		*fw_err = ghcb->save.sw_exit_info_2;
> -
>   		ret = -EIO;
>   	}
>   
