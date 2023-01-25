Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF60767B88B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjAYR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjAYR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:29:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C928D12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 09:28:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQHiIGarFDu91eBskCs0HbFXvebo1nK1YYO6DETkW/5R7IYREbPgO6t3wL1w/xTDB1wsCLg6OX4eAZ7GLL6oYNpYUI1zauCZMGg2t3zy9xwS/9kB16vcVHg9LK3LDeNzdPVMgjCPAQw9piMVXrteCdD4aZzxO/h18E+MUrinTniLmp1pQteK0ip6kmol+yTuups8t9DuuCE42XSSWkZIBn/01AD1+vGwqCIgx+t5cM3jEuZPg6Nxsgkn8n7Cuzl9i+D4KQJJwH4K58CkwL+/QyEG0aUncS0Fg+EWhJYsgpcAvFZvEEkMVyO6DTXug+lTPwNToT7o49BKkswuHcVbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgbKEJd+M53vXBKgGmTU9jWKZZ/3GFC71f7dFYf8fvc=;
 b=hP7DYH587YCNZ40lSB0T/gLoWVDqd17vrib4Z2Tbm8dYYM/LcpARgIXmj5Guouv/RFnqKUoyCLJLfr+q430BCV+UAGUa67eQhydszTvOBL88sEbqOx0iU5SKKZ4tSxapr8jad8h4vX8vvIRjdeFehAuv23Snw0yYQZkbmOc/2st2ORgs9O2XFQeMmGcc3CYnyNJE0AHexzcSTIVeHaKDzTaneRHQQ12ETMnyidaoqqRIeF83EmpR5en1veQL5hMFQzHdFVntOHNoepOwKfYmxckkmMj27P30LtYKwyA2tZMnhQyuEgXrRkjQyJle1jcZ7zZHV2T9wKGqRRBD5MB9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgbKEJd+M53vXBKgGmTU9jWKZZ/3GFC71f7dFYf8fvc=;
 b=bGX0z97l/IBvSmdHBeUGR87CQKudMQmR8JV0uF5v9VC1Io6A++s7l0Qf+1IyYHWJ78Nq5IR8FW8zk8tTiM5qDatIlIzIOtxy66OFxwHlWEEkez+wxiHmTtzTavnxfsj8a+SuuJlQnXZUxHHUC+QCpUwH+Vc2DYLippm1SB4Bv4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 17:28:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 17:28:30 +0000
Message-ID: <724f03d8-91e9-e870-f063-65c2e98b6ee5@amd.com>
Date:   Wed, 25 Jan 2023 11:28:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13 1/4] virt/coco/sev-guest: Add throttling awareness
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
References: <20230124211455.2563674-1-dionnaglaze@google.com>
 <20230124211455.2563674-2-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230124211455.2563674-2-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:610:4d::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d30f3d-7e0a-413b-3855-08dafef99352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZ3GMbdqzY6/VJtj69ls95Cal2cL2fF6dF6+6wJ7ICxfTHfUa2HzJJVGM6sIZ4hVqGTD6SDemL9POoWlv3TibDB9e3MjcOytlue0X55lQoAdjJHooXgO2Xi/AShPe6lfiecjwr3JFJkPgeoLVzBRgLkQ3kBlB0etHPgr8/4rb5zgtpZeKiaz0SHhrIAm7iwh0PsWt3qHKm1/5Q/KE5XOf6iTT9myHuVm+h4t/jOPzTM6fW2ml/M6fPfEOeVzTUBrWsXvT4Stc8w179cEuWQRw2hvux1gQIVxN9jeRxeKUcuUkUMbqYB5wy0fVa4QURxI5e1MSVWlspuRAqV9MHXzt3bfiVz1cZ8UNq7XmQTuDHjuIgapAcc2aA64j1oCM5Y0tbL5cESUj70LJrykSZJ5kdZqMRzb5TjktZ1Nr/ZyODnxUenV4eHmIMb6mvCSMenxDhAEROz22WWVN8kRJE/XbD7aAVjen28Zc2/ygB7h5QLg48zb/ZNHYONz4IRzj6PizujMvQzKJSK4rhxJL0gnHhxsoeNF+OTLTRESp5ChEaUcD/Ppn8WnUrKVd2cnk2TeiOJR1NtRTYDE43z+fBP5x4h6a8HRG7ZXxENDCe1btIY5IR1rqB8hC5aIq7i6YKemDR8yTgnpccfCI/oSR3zDbHWYIQgwKaNaN7uT+gAul2+Ga/EJBzg6rZl3jsk7FHEhpaLuEIKueGtEhjH6wxtIDLFS9L/NzwPdyJBxfCTlYAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(38100700002)(26005)(83380400001)(53546011)(2616005)(54906003)(478600001)(66556008)(8676002)(66476007)(186003)(31686004)(6486002)(31696002)(66946007)(36756003)(2906002)(86362001)(7416002)(41300700001)(5660300002)(6666004)(6506007)(316002)(6512007)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnRFZ0c0UHp5SWZEd1hHdHRZQ3VESldOeHUrZldaMXdOUjBhQXo3K0phVjVC?=
 =?utf-8?B?L2MrdS9nOWUxeHZablFMU3pINHZpV3NLSk5BUXBGQjgwaS9YYUNiOHpBR3py?=
 =?utf-8?B?MjZXQzRTRmtwLyttYzdhWUNlTjVpYkY2NzBtZi95cC9EU2tka3I1d2Q5cnoz?=
 =?utf-8?B?MWxFOVVnSTJxUEVqc3FkcktmdmYvUERvTnlwNm1ieE9tdHJwKzZEL3ZJVWdp?=
 =?utf-8?B?d0xmKzBSeXdzc3o2bFQwKzZlQlJDZzI1RUUxQTVPQUV2bmdWQ1hUV3BhSkFu?=
 =?utf-8?B?eSsxMlE4aGJwU0ViYnRqdmJNYjZYNk9MUTNQYlBieW4xZjZxb2ZzZVlabFJj?=
 =?utf-8?B?dTZVWG5LemthNEhTSit6NEtwZXgyR3JIb2hvLzRKS01FUm9ETG9RdllTbXYw?=
 =?utf-8?B?VDUvbVlHQ0d4bnFIbTMwZG5XQlNjTVhDZ2piVGl4aTRMRlZJV1Z1T2RpeVpE?=
 =?utf-8?B?bnVSWXJoblA3aWVjVklEOXo4clFzMENMMG9KcGszZ1Jvcm1NNHY3Ykhld0Ju?=
 =?utf-8?B?a0U2MUJ4cmRUZlBiaVVuYklrUnJXajFPOXBaS00xN2Z3WXhLYm5xNEQ1bmp1?=
 =?utf-8?B?RUE0Y0YxeTBpZmxjTG5pem1jeHpjRFBRRFFla0VLVWxFcHBvZllGbGNHb3Vx?=
 =?utf-8?B?RXE1NXkyMHhpT01wSWMwcGcvTmV0emZLdy83MW5vekxZWnRvNXVuUUZ2clYy?=
 =?utf-8?B?OVY2TDdaRkJvc3g2MDF1WEhwdHQyRnNZQklPM05tVmt0TVJoRG8vWURjUmth?=
 =?utf-8?B?aGZBZWpTY0d5emdjLzcvZ2dYZ2hianVEbE9QVUZrNW5sOVBJdFdmOUtWZmR5?=
 =?utf-8?B?QnhxZXpzM2FPQktYeWIxZGV5aTdCQkJ2R3Q3bHgzclRUWCtiRTdYbldHK3lL?=
 =?utf-8?B?b1FqK3IrL2liQkh4dzZOdTdjRmUvbUx3MEhITjVGWGZFcXQ5TDlLNlQwTTFD?=
 =?utf-8?B?Mi9qYnRtZUo3VWFkblBYK28xaHZ0V0Rvc0ZwVDFsUG0wZlZXc1RZN1MwdEVN?=
 =?utf-8?B?amtyQm1DaTJKWVFjZmo3aTN4ajgzNE5acGVZRVdxL0RFTzFDQmpqL2d5RVBj?=
 =?utf-8?B?K3UxZ29zYXZyTVNncmp0YjF4ZzFqRVdvRktnWGpOS2dGTkUvdi9ab1I3N3Av?=
 =?utf-8?B?L1o0ZDQ0ek1DNllXbERQYi9YbmF3L285SlV6d2pOWGl5RU50ajdpVFdmYm9Y?=
 =?utf-8?B?NUVBVzZ2Z3djOHRqUUZjTDd5TldCbm56aGx1RXlmR3N5Y1BidmUrSG5GNFdC?=
 =?utf-8?B?NlM3Wk1DaFRhd0o1MFo3ZVM2SkM1ZXVrck5JSXlxR21nUE80WEdUam94SjY4?=
 =?utf-8?B?U2JsdHVkSzJ3ZStGNU5uWjJXbURLbk5zYlZXVkdKa2Zqejc0Sng0TU1PTFh1?=
 =?utf-8?B?MzlEMUZxeHNDZmRIZkhEOXZmNjAvTVRjYlNvdTNQRG1pVGV1aHNnbWh5eFNG?=
 =?utf-8?B?OUtUTWQyVENhcjMrbXdHelpFQ29aQ0JxaWtwWU5QT3JuZVQzTVRnRHFTWCs2?=
 =?utf-8?B?ZnFET04xQUtzVEh2V3ZqajloOWRkd2ZDMFNURkdKVzF5anBPOEEvekJUblBM?=
 =?utf-8?B?RnhsQlFsUU84UVFyMVA0NzJnMWYzN2J3OERYUDQydmtjdnR6RlJGOWorcmJJ?=
 =?utf-8?B?ejk1RjJ0ZkJqQjVyMklUNmpIMVlickIxM2xacHlHMXZUTnUvelZTVEI3TWZO?=
 =?utf-8?B?RURBTU0vN2RkOFIzV0Z2ektNM0p3aE5saVpzSnBiaW9VRVplUTJuMTlmaUZ0?=
 =?utf-8?B?YzMwaU1GM1YxaXpZU3ZSSitRZHFHa1VRWUtsbmNWQnVWK1owYUV0cXJkeFQ4?=
 =?utf-8?B?azBwaGRpeDVIZVZVajFVVW9IOWRXTWxRM1g0Sm1mTmRrdENPOW4wOUhTY1E2?=
 =?utf-8?B?bWYzVHJ1enVyY3ErYmxmY2NKanI1SHBzOGxIN0txRGRVdDlsSVJmcHpoTlZl?=
 =?utf-8?B?RGZrMUdNYjd6cytwcE1PTW8wMlFOT0FMNy9mSGlUNk5ueWdTaXAxSTR4Wk9V?=
 =?utf-8?B?dUwyY1NFcngrejh2S2ZHQ3c4UDgwU0FVME41akxza0JQOEpjV200VUFMVnl0?=
 =?utf-8?B?WS9nY0NGdkVsQjU1SU54UU1MTDM0RkNJblMyQWtaTjgzUzY4d1B0ak5oQUtN?=
 =?utf-8?Q?oqBB1nDMRMxY8POohLi0UP9P8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d30f3d-7e0a-413b-3855-08dafef99352
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:28:30.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4KyBYkPvQig4RVMMvNQTY4mNJqcpJPyL95b4VsGAh4CuwsfzCBvlWL5TtR8OImyALVkmVikwZe1iPUAW0Xdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 15:14, Dionna Glaze wrote:
> The host is permitted and encouraged to throttle guest requests to the
> AMD-SP since it is a shared resource across all VMs. Without
> throttling-awareness, the host returning an error will immediately lock
> out access to the VMPCK, which makes the VM less useful as it can't
> attest itself. Since throttling is expected to be a common occurrence, a

It's not expected to be a common occurrence, but a host should protect 
itself from an un-cooperative guest.

> cooperative host can return a VMM error code that the request was
> throttled.
> 
> The driver interprets the upper 32 bits of exitinfo2 as a VMM error code.
> For safety, since the encryption algorithm in GHCBv2 is AES_GCM, control
> must remain in the kernel to complete the request with the current
> sequence number. Returning without finishing the request allows the the
> guest to make another request but with different message contents. This
> is IV reuse, and breaks cryptographic protections.
> 
> A guest request may not make it to the AMD-SP before the host returns to
> the guest, so the err local variable in handle_guest_request must be
> initialized the same way fw_err is. snp_issue_guest_request similarly
> should set fw_err whether or not the value is non-zero, in order to
> appropriately clear the error value when zero.
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
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> ---
>   arch/x86/include/asm/sev-common.h       |  3 ++-
>   arch/x86/kernel/sev.c                   |  3 +--
>   drivers/virt/coco/sev-guest/sev-guest.c | 11 ++++++++++-
>   3 files changed, 13 insertions(+), 4 deletions(-)
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

It was probably a short cut to use BIT_ULL() to start with because the 
error codes are not intended to be single bit positions, e.g., the next 
value will be 3.

So these should really be:

#define SNP_GUEST_REQ_INVALID_LEN	(1ULL << 32)
#define SNP_GUEST_REQ_ERR_BUSY		(2ULL << 32)

Thanks,
Tom

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
> index 4ec4174e05a3..3d6551fdf06f 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -322,7 +322,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *fw_err)
>   {
> -	unsigned long err;
> +	unsigned long err = 0xff;
>   	u64 seqno;
>   	int rc;
>   
> @@ -338,6 +338,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	if (rc)
>   		return rc;
>   
> +retry:
>   	/*
>   	 * Call firmware to process the request. In this function the encrypted
>   	 * message enters shared memory with the host. So after this call the
> @@ -346,6 +347,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	 */
>   	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>   
> +	/*
> +	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> +	 * throttled. Retry in the driver to avoid returning and reusing the
> +	 * message sequence number on a different message.
> +	 */
> +	if (err == SNP_GUEST_REQ_ERR_BUSY)
> +		goto retry;
> +
>   	/*
>   	 * If the extended guest request fails due to having too small of a
>   	 * certificate data buffer, retry the same guest request without the
