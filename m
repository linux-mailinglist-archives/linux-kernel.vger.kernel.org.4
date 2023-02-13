Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4223695352
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjBMVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjBMVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:43:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8214E8B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkJ4irySJQqVu4FUvhAWHnKNsxysxq3HK3u8j45g/F/yOIob2dMV/XN79CY2qrDDCUk4NDSKkaBNCl+Y1EzO/VGXkYE4Bfjiz+EKGb93/UEjDOLB/4vOi4Kt2aTHxbwv+BS24yIxCmIKA8bkGPaTFUq/M+7CPDucubj7ausCwtRQP5OhAp1bxIhkHuwZ25/vrNdFr/cbdf9rXorNh/VVmH0CjXaewT0aaauAOmDpQr8uCGX+hEcFCZSOQCym4dcfoFyno3mZDweSW9M0+R8E/IwVLz93yWemoHe+YmavUrpFjrB4bYuI3fe7cJpYO7LcSuX0eZfZwCnkHIdYZgwg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02X9syFb9nh0f1ajKORPpilI0JnPtPpudV+nym93fQc=;
 b=iq7uQMKPRb+VBh0nMVcQ09TkuAe+VcnccgplEkNWtfjvoGVBgNgiqxoeMPGL2lt1G3M8XglG9/PGSA84UT2x+ay6N9X3uaroyLocHIj0XyfDexGCaNbdHKUHdxjgxm9vW4bdbgxLOIg6pBjTphvVcmdh7Xk3jsFst043t1kPnEk0/P5LaiWf8gV3MicHI+8vATGIpZwPANthpI4SnwKU/OOhjC4bADs/SL3lX1k1LhHXn1iU6zkoqNFhNLKMmgKbLDizlZcAnh3indbS4C0z/algFmgJg8gDheJAOvL325So0J1drSAH+R5kkRtSJ2YikM+LAuGkFaT4XasntrwpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02X9syFb9nh0f1ajKORPpilI0JnPtPpudV+nym93fQc=;
 b=UO8QRKwT6SFmxJnbY+J/oBGt7rowqO5N9JEnGmVBb1DaEA7Woya2SjzrQ9W/Wzs3Gu6tE5+FwbC/q8Ln1BrEQ9sPaWCDLffbsgIy2zh1rlVUELJXXzBQQm6vi8Ore4xKUJM729LaZQfspZEmPDvm4CqQpPKKQANlWiLAdU7P7lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 21:43:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 21:43:30 +0000
Message-ID: <22e96dfd-21af-681c-22d2-12bcc082f63e@amd.com>
Date:   Mon, 13 Feb 2023 15:43:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v14 1/3] virt/coco/sev-guest: Add throttling awareness
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
References: <20230213172525.575766-1-dionnaglaze@google.com>
 <20230213172525.575766-2-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230213172525.575766-2-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:610:cc::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: b9edcde7-be91-4c3d-2f55-08db0e0b58cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awucppNi1EjfeU3oOJhULr65waI3uPT7YIPS7llfL7XMeRhILM3WUN+PqdPrwnsUni23DfpXf9ys+gpF4pKjhGn1aCTgWmW9zSp6fccfCL01Fao5kk4WuoKcO8EfMVsh9HpQYbN8OgUbj6UpCvjjLxR//JW0F2eY6/dCd6gYvIwdc6/FmcZy8F0jZ1Rlf1BaKZqxKnIsJP1edXQCoIg1u8J787u9KZ67EQvafoGVQKVOShjoew9LP7EivkM96gx+gwaJhkPjitF0S/4k7A+b3MCKbQ15D9yR7mxug9C58a4dfRY6/Wk8HrcmyDYAx9mOWRzkSkEmqWGfYc5GBsWvYQiK07RQ4A2DlYrCkKPsWTOnLhp2F9Mp1dodncxzUCfi5yVVVsCBcM/NjV+gb03BNY2PRK4xdq1+eSyzOneRchnyZRKIqx98QQEi+6CPIu7sPxBFmlMgNA5KcU8Uv6i5tHQtOBbbK2QasjKKdD9rEI6IJvovo3eK69GRLPH5xQ2uD9JOFxn5Btx/DBcojH2zVw5PA0mxEuuZNEjts5X0dO5xVvpOdGIMrda2utmbNV+yXfy+kDTsAoTcYPUMjp7Ce2lxDcxDQTAyH2tkaznPK98vl0r/MciHH5HvhxDtaeOZH5DLSu9i0CL8o8acvi1J5RYvE7t6iOrqWM4Rc6R+ZCfZwrqkVOJ1saqLiL8GES6UtVnaDvCokV2K4QeJdqgzL6IUyfHtR6MkXJa7MoqfYDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(186003)(6512007)(26005)(31686004)(316002)(66899018)(53546011)(6506007)(2616005)(6486002)(478600001)(8676002)(66556008)(66946007)(66476007)(54906003)(4326008)(6666004)(8936002)(7416002)(41300700001)(83380400001)(5660300002)(2906002)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNqRkdqdTI0YTAzQzRvbkVFUEJ5UjlNMDR4V1o3TXhQUHFldkJ3MWpLUzFN?=
 =?utf-8?B?d0J2WGZwQXBhbGIrWHlrTWRndEF4ZFZ2NlBQZVNweEpaMVpxYm1KTGhIcFFW?=
 =?utf-8?B?WUtjZGFRNzV1bnorOFVZMjNZbkU5dVlnVVJjUEJXQnJ3TDkwcG51RUlaSVZ2?=
 =?utf-8?B?L0N2bTFZNERwYndvelhsMVFCeHNUZ0ZkVU01a0ZJYncrNXAycHJKMWNjTlVl?=
 =?utf-8?B?dFZpT1RxQTV3N0k5S3E4Mnh3ZTMrNXpsZnJPSGttWFpJMS91SEFCZ3dNYklD?=
 =?utf-8?B?bzhKQndqdk85b29KQjVmVkY1Y3ZFOGhwdFJzSHYwMHdvTjJuUVcrRlJoNVBl?=
 =?utf-8?B?OEdqZkVIN3BrRnVCcEJoQzVCb09ac0FyMElBcnRHU3NDR2t5WUowUmZ3WFlZ?=
 =?utf-8?B?djFUL2pJRkR0WElZSThRKzRmb0FuMnAxVHBtUHNmYy92N3lrRm90Z2JqRzFD?=
 =?utf-8?B?aitOUkZmczd1enFuNlY0Nmd0TVdLMk51VjVMWnkyRWtIcHJGYXJ0emZjVDVK?=
 =?utf-8?B?eWdjYjZUVkJOSXl5cTJZbERmaWROVjNUWDNpNmt2amwxMGYvS1g1R3NGVXRX?=
 =?utf-8?B?R3BJNXkxMDBkbGJ4aWc1amgxQlQ3VGNGdzYwMzBtczJEbXNHT0RZWHkybHJk?=
 =?utf-8?B?WmRyQjVyc0t0aGhFcEVyMWxRNVErUDkraHJmTDJTVDdtNXc3KzlPY2Y2cXEx?=
 =?utf-8?B?R2NmU05BRjFPZ01ka1JXaWdOWlUxM3g1MU1YTjkvMGpFSFZVa3dHRUZsUXlu?=
 =?utf-8?B?YmRvRVhhU3hGQTNucFhrSk5lcHhpaDRWTVd5a1VnNEdEY1ZBNVprNWdqd1RL?=
 =?utf-8?B?M3RQd0VEK09iSExEdFBVaGkzN1VxVVhrUjV4eHpjbUdyd3R3Z2lYYms2SG1u?=
 =?utf-8?B?bXhRaHVmSzl4L0NhM3lQQlZlTFZtWE1zTkJmZVdvblZyWnVBbFBseUY5a1hQ?=
 =?utf-8?B?NG9aVzZHQVZqOTFvQnRYK1hmZTNBYm9DSmZVR0kwQnQxV3hTNGk3VVErSVhh?=
 =?utf-8?B?eDhXQnVBV1JVUi96ZVlEV3Fmei9ZWW9GMmprbm9VNzNFc3BFbElHT082bExh?=
 =?utf-8?B?dEhZL1IyN1RmRm1jM3k0QVFjR2VOODNJZVFUWDNaZmpSOGt1Z3NHNWZHbUsz?=
 =?utf-8?B?NnIwWUgxQW9rMm1ZRG50bTFrSkdEdVM1bHdycXFzQzZka3lHVE01Qjl2N1dk?=
 =?utf-8?B?alI3NytWSm1PVzdKckJ5SjBsWFpOdStlTmxubk9CTENMeTZ3Rk8zanBsNkk5?=
 =?utf-8?B?bTYvaEtZRDBZNVF0TVdLNERKb0I0NEl2K2VLM2F0UHN2RUc3R3I4OFJGNWZO?=
 =?utf-8?B?QmJTOHdiQW01RVBaeHpMT2dmYlNZT0FYLy8vTVA4aElMbExuUGh0NDJianZE?=
 =?utf-8?B?TWYzSVdQN2Z3S09LQS9SUDRtV2lRWGRMbkpHcENCZmh0VzBWU2F5UFBRQ0hF?=
 =?utf-8?B?ekh0dGNWVnA1cUN0WDhOUTA4L2x3KzNPSEN0VDlHYzlsc1BQM3ZsaFpwL3ZT?=
 =?utf-8?B?ZTVUdjFlZDdzSkJ1YWNTa2FGak5VemppOVEwMjBYK0w3b2tnNytvN0R1TnNP?=
 =?utf-8?B?Qks5WDcrWkpmb3NoSGw5aGlnNGRsVkI1UTFvV2VSRkwyNUI2dTVhak1vQWFh?=
 =?utf-8?B?VkxtemRPVzRWR0Myd1FUU2tZc2t4RFpoUHB0bVJ0dWY5M1I1M2FuR2ZWYjZT?=
 =?utf-8?B?Z04xOFNndTZyUW03SmppYTRkRW1Dc2syK2k4bU55T1p5VWlBUzR5SWVHd1J6?=
 =?utf-8?B?NEc4cXpUK0sram1VWkluOWpJcWZHcDI0L1RPRUtNU0h1WndMRFNJdjhJaE5v?=
 =?utf-8?B?UUlPS0hYY1NCc21QMWpsdnNzYU42S3pHcFdOQURRL1o5cWtoajdETXdBRUlj?=
 =?utf-8?B?TGx5clIzUkYzZnhWWGN4eG5nTDdNN0hNYmN3NnExQ0JGWmtpNEZ0R1lrNVBX?=
 =?utf-8?B?OXVkbnJiN29JcldQdVh6aTBsaEdGZGFrYlZsRlhlamh0U2djcGgvdUpuaXkz?=
 =?utf-8?B?dGdORWN6SUc1QlZXb2JNWCtSZVEydE1hV1hlQ1dwK2lESWRrNHNFdW5xWjlQ?=
 =?utf-8?B?dS9CdEh1TUFDMVI0elB2a3RZcVRDTnBDdjFvSzRHUmt0TlFHMFpOVjJPVUsx?=
 =?utf-8?Q?kkz0TsLJ8l+efOdIFx25PB+eD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9edcde7-be91-4c3d-2f55-08db0e0b58cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 21:43:30.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnFi0OymeMSrShxi6qyxkj/EWRxZ+segi0z3uHZIJGq+ZABnxY/eaP1fjXdEy/plLxUE0CA2e86fJk65F4zBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 11:25, Dionna Glaze wrote:
> The host is permitted and encouraged to throttle guest requests to the
> AMD-SP since it is a shared resource across all VMs. Without
> throttling-awareness, the host returning an error will immediately lock
> out access to the VMPCK, which makes the VM less useful as it can't
> attest itself. Since throttling is expected for a host to protect itself
> from an uncooperative guest, a cooperative host can return a VMM error
> code that the request was throttled.
> 
> The driver interprets the upper 32 bits of exitinfo2 as a VMM error code.
> For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
> must remain in the kernel to complete the request with the current
> sequence number. Returning without finishing the request allows the
> guest to make another request but with different message contents. This
> is IV reuse, and breaks cryptographic protections.
> 
> A quick fix is to retry for a while and then disable the VMPCK and
> return to user space.
> 
> A guest request may not make it to the AMD-SP before the host returns to
> the guest, so the err local variable in handle_guest_request must be
> initialized the same way fw_err is. snp_issue_guest_request similarly
> should set fw_err whether or not the value is non-zero, in order to
> appropriately clear the error value when zero.
> 
> The IV reuse fix for invalid certs_len needs modification to work with
> throttling, since a single retry with a modified exit_code may be
> throttled without retry and result in a locked-out VMPCK. Instead,
> change the exit_code as before and jump to the same retry label, and
> deal with the error code fixup by checking if the exit_code had to be
> changed.
> 
> Another issue that must be fixed is how crypto results are written to
> shared memory. The solution is to double-buffer messages.

This should really be a new, separate patch.

> 
> The encryption algorithms read and write directly to shared unencrypted
> memory, which may leak information as well as permit the host to tamper
> with the message integrity. Instead copy whole messages in or out as
> needed before doing any computation on them.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <Borislav.Petkov@amd.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Venu Busireddy <venu.busireddy@oracle.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Michael Sterritt <sterritt@google.com>
> 
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request
> NAEs")

This shouldn't line wrap.

> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   arch/x86/include/asm/sev-common.h       |  3 +-
>   arch/x86/kernel/sev.c                   |  3 +-
>   drivers/virt/coco/sev-guest/sev-guest.c | 54 +++++++++++++++++++++----
>   3 files changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b8357d6ecd47..b63be696b776 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -128,8 +128,9 @@ struct snp_psc_desc {
>   	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
>   } __packed;
>   
> -/* Guest message request error code */
> +/* Guest message request error codes */
>   #define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
> +#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
>   
>   #define GHCB_MSR_TERM_REQ		0x100
>   #define GHCB_MSR_TERM_REASON_SET_POS	12
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 679026a640ef..a908ffc2dfba 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2212,14 +2212,13 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   	if (ret)
>   		goto e_put;
>   
> +	*fw_err = ghcb->save.sw_exit_info_2;
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
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 4ec4174e05a3..4945f2dd97a2 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -30,6 +30,7 @@
>   #define DEVICE_NAME	"sev-guest"
>   #define AAD_LEN		48
>   #define MSG_HDR_VER	1
> +#define ACCEPTABLE_REQUEST_RETRY_DURATION (60*HZ)
>   
>   struct snp_guest_crypto {
>   	struct crypto_aead *tfm;
> @@ -43,7 +44,13 @@ struct snp_guest_dev {
>   
>   	void *certs_data;
>   	struct snp_guest_crypto *crypto;
> +	/* request and response are in unencrypted memory */
>   	struct snp_guest_msg *request, *response;
> +	/*
> +	 * Avoid information leakage by double-buffering shared messages
> +	 * in fields that are in regular encrypted memory.
> +	 */
> +	struct snp_guest_msg secret_request, secret_response;
>   	struct snp_secrets_page_layout *layout;
>   	struct snp_req_data input;
>   	u32 *os_area_msg_seqno;
> @@ -263,14 +270,17 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
>   static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
>   {
>   	struct snp_guest_crypto *crypto = snp_dev->crypto;
> -	struct snp_guest_msg *resp = snp_dev->response;
> -	struct snp_guest_msg *req = snp_dev->request;
> +	struct snp_guest_msg *resp = &snp_dev->secret_response;
> +	struct snp_guest_msg *req = &snp_dev->secret_request;
>   	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
>   	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
>   
>   	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
>   		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
>   
> +	/* Copy response from shared memory to encrypted memory. */
> +	memcpy(resp, snp_dev->response, sizeof(*resp));
> +
>   	/* Verify that the sequence counter is incremented by 1 */
>   	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
>   		return -EBADMSG;
> @@ -294,7 +304,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>   static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
>   			void *payload, size_t sz)
>   {
> -	struct snp_guest_msg *req = snp_dev->request;
> +	struct snp_guest_msg *req = &snp_dev->secret_request;
>   	struct snp_guest_msg_hdr *hdr = &req->hdr;
>   
>   	memset(req, 0, sizeof(*req));
> @@ -322,22 +332,34 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *fw_err)
>   {
> -	unsigned long err;
> +	unsigned long err = 0xff;
> +	unsigned long start_time = jiffies;
> +	u64 orig_exit_code = exit_code;
>   	u64 seqno;
>   	int rc;
> +	unsigned int certs_npages = 0;
>   
>   	/* Get message sequence and verify that its a non-zero */
>   	seqno = snp_get_msg_seqno(snp_dev);
>   	if (!seqno)
>   		return -EIO;
>   
> +	/* Clear shared memory's response for the host to populate. */
>   	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>   
> -	/* Encrypt the userspace provided payload */
> +	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
>   	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
>   	if (rc)
>   		return rc;
>   
> +	/*
> +	 * Write the fully encrypted request to the shared unencrypted
> +	 * request page.
> +	 */
> +	memcpy(snp_dev->request, &snp_dev->secret_request,
> +	       sizeof(snp_dev->secret_request));
> +
> +retry:
>   	/*
>   	 * Call firmware to process the request. In this function the encrypted
>   	 * message enters shared memory with the host. So after this call the
> @@ -346,6 +368,20 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	 */
>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>   
> +	/*
> +	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> +	 * throttled. Retry in the driver to avoid returning and reusing the
> +	 * message sequence number on a different message.
> +	 */
> +	if (err == SNP_GUEST_REQ_ERR_BUSY) {
> +		if (jiffies - start_time > ACCEPTABLE_REQUEST_RETRY_DURATION) {
> +			rc = -ETIMEDOUT;
> +			goto disable_vmpck;
> +		}
> +		cond_resched();
> +		goto retry;

It looks like you will ensure throttling by continually calling the 
hypervisor for 60 seconds, shouldn't there be a delay here?

> +	}
> +
>   	/*
>   	 * If the extended guest request fails due to having too small of a
>   	 * certificate data buffer, retry the same guest request without the
> @@ -354,7 +390,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	 */
>   	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
>   	    err == SNP_GUEST_REQ_INVALID_LEN) {
> -		const unsigned int certs_npages = snp_dev->input.data_npages;
> +		certs_npages = snp_dev->input.data_npages;
>   
>   		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
>   
> @@ -366,8 +402,12 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   		 * of the VMPCK and the error code being propagated back to the
>   		 * user as an ioctl() return code.
>   		 */
> -		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +		cond_resched();
> +		goto retry;
>   
> +	}

Nit, add a blank line here.

Thanks,
Tom

> +	if (orig_exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> +	    exit_code != orig_exit_code) {
>   		/*
>   		 * Override the error to inform callers the given extended
>   		 * request buffer size was too small and give the caller the
