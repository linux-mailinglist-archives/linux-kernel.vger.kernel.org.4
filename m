Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2974269E3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjBUPnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjBUPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:43:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309C30ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 07:43:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmNTkeNfiiXYa29BZ3JNKOm10YRQIWZdgh38vlSUK1qlIXAGkMLkrERlSc9ue3i3wMyyENuS4jgdOv4v3P2BOsmtJSboG1rVLX56XfXTEEcXpqzR5CH5tdQt0JMa+VBPvPnszfmFrmRI+rBxVMxVXp8r0KdQ6cxn1RbXn3XhvZtuf51mqLVZWrxYApS8YxQII5Rkt54zYB38qFFuK70KUUy7JG6PJ12yOX0ScBB7JcXORwZymZcUFGNvLo26fHpnuwuBmNroFlkc2dAbD94zM97coYxneQq1ayTHvh9C2Z+FAdqEhOh1XywXpZHqxArwDhI8Plenoe173ddTlKjMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii26yIuEKvN+HlVXYvbuibl4XsQrPqoL66oFzXaLKs0=;
 b=CJlzXibm4AhzY+zOuzpSRmAsiYBtHFLtRrpPCsX9Ni7MjUr9XgWkhhSyiw1yIMue19bLHwERhgXsVtmYNEzs7WRSaL72eJcFufKgjjRdnHDpMaPnegbJVDofocIlj0cMMCEjKPlZzfrTj6eue+DsDndivGj8j9EBl2WXZGZx/XDznMR293hYTYeGBXLt4QdiOl1jlDkNK+ORWbkJN3GVdLJLAgOZBkwOW8p8svkk4mfFw5mmU9H1GQR3bVX9bQvXdKE8HDtPMXMfOYvvulyiFjwC4/PHAPjpWgv/6HMNJvCxYoSQWYECGI3in+WG4585bx7jsR4xLlwOGOVGxOCXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii26yIuEKvN+HlVXYvbuibl4XsQrPqoL66oFzXaLKs0=;
 b=yvWChn9dhMA+KcdJvHYn8Iys7TkTNQrF35D1EbRz1RRbB1PyQkDACKjY4qX2gH1Xhgbwkbkx9Y85YXzTENr4k3RMl/YbXKQA/ha0Sbtzjaxt8R3KtgBGHpp+2C0BIdcLtd3l9ZN98n+zWj5qQ9lSGFuZGMi+w9cMSQxfpJ51JJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB7594.namprd12.prod.outlook.com (2603:10b6:610:140::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 15:43:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 15:43:21 +0000
Message-ID: <3cb5d149-699a-b649-1986-23d7f6783e6f@amd.com>
Date:   Tue, 21 Feb 2023 09:43:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -v2 11/11] x86/sev: Change snp_guest_issue_request()'s
 fw_err argument
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>, linux-coco@lists.linux.dev,
        x86@kernel.org
References: <20230221113428.19324-1-bp@alien8.de>
 <20230221113428.19324-12-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230221113428.19324-12-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:610:cd::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d118e0-37c6-4da6-c215-08db14225c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ5DNt3bUv9Iv0kx6bXVQL3VNwW4kxxNu4VfGTYkwHfZtYJUmXJzcMI4dRi6tmZGtawx4D/5017KwxdY6jiJHd/AhjvsJWujX+ulnwaPWBKD70uXgDoJldAOXLl2Ra4I0Ih6TDSsqFRkKxtGQ7v7TKFR/82aR70Dmmf7wXAYEVHX/jZ/9DAvkZqyqiJ1TQnt4g+s41j1+PkZPdpKrZAuntwsb2mnz1XfcST2FZMAspA91Cu9r6vVRH/Q/zK320I0Za76aMveoH2+dk7+DNVPWursCwRFLp6LjFYuzPOWMXiJzIcyAib32ms3RJbvFQI7vY4N41rk8IN1G7+Z0x8JW8DVe/euVfN/GFFvV+lq6YU+agzQNBPzswM02Ik2swikF/Y1anrN9b3XG2rH397/OG1VASYBQTkQjfHvvsOOg5h59LWganpJ0xpqUYnHQ7aS8P3HhrhBNQ80BiQqR/hS189c9VePc5epyy85hHchXCYzOQ+2v+e1kWCNobiLnr8mFYjy77EAGFgyGYqS67SLzFLFsnEHPsr6Q3Y0hclkksC3kGvWUocCExB3l0woNG9WZnUwauS78opku4/bL1i9Z05ptGAkb9WlAyfSP4aVnppGy2pkSregRLHR/kUhPpqW4i4WwQyMHoPFlGTNQiZY0MAXkkuJtjNm3O9NLp9lEd7jiCIC4HfwNkvZsilq7vKI1GlTEpniiUUZ/JLYW0Z6kUQ1ysHTzbfSCGxq5NqyYGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199018)(83380400001)(5660300002)(8936002)(30864003)(41300700001)(86362001)(4326008)(6486002)(966005)(26005)(186003)(6512007)(66476007)(2906002)(66946007)(66556008)(110136005)(8676002)(316002)(31696002)(54906003)(53546011)(478600001)(2616005)(6506007)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FocUg1ZkNwdmNQclU3SDkyY3JZUXorcUxTOFB4NGo2clhleXIzenBTTnBZ?=
 =?utf-8?B?WnByWmdiL3pOa0h6TG1NNk8yR1M3anBoUVI5ZzZ1cHArQzg1Qlc5NEduazZw?=
 =?utf-8?B?NDVEeFZwcWhrbEFUZXlYWllXYnR0c2EyUTByU1hxNm1HVlFFalIrcGptRTRx?=
 =?utf-8?B?L3lTMWhQRHc2V1U3QTh4Q296OUlVdS9VUFF4ckZVV1ZtWS8vRHA3bmVYcGYv?=
 =?utf-8?B?Y0ljUmdsN292Vll0cm5FdmhpWHhtSldrdEk4OFEvaHBhVm1hZmJJbDAraUcz?=
 =?utf-8?B?eTYrV2tRYzRHUE1mZnF5WExHK0hXbVZiZTBUUG5pelBWZ041MVNMbVFmQlJa?=
 =?utf-8?B?WEhkVnhJc0N2cldsUk1MNVBBSDdmMUhPSVRzL25PUE1UR3VBd2t6R1o3TTlZ?=
 =?utf-8?B?Smpld1kzTVZsVFo0ZEZkRm9LbGpDYWlWanVqSUZQSlIxTm44MDQ5MXZhcVRx?=
 =?utf-8?B?NW5aWWoyc2tQalJPU3BCNlYxWWVJVytPN0Z5bXVuUm9MMSt6Uk85NWROZFll?=
 =?utf-8?B?SkNSTDFVdUhwc001UEN3clFXdXVQSzhYMGpib00zQkwzMWEwOTgybnhaRjZR?=
 =?utf-8?B?K3FsY3NZamRSV2E0UUIxZ1ZObUZUc2tYQ040UzNyM1I4UEtCbmVEYi9kbEgz?=
 =?utf-8?B?Wm5YUE9KZmpMQlZVTFVxUlRGTFYrUytyWU5OTjV3ZE95UmRHd0pONzZZbGxp?=
 =?utf-8?B?MThwejZMdVBFWTdESk1UYnRWUmJWWkwwSTF2bUtGWCszaGRSMFlnSDNwbk05?=
 =?utf-8?B?RXRiLzJBQ0xTa0RKOVNYNThwb0cxZlJMZkRSamxrN0FZVDIwQ2xocmVzK083?=
 =?utf-8?B?TVl5VnZQSG5xeTlYUTJPUGRRa2pNalV2ZE5waERhZnB1by9rejRabUw4RDZK?=
 =?utf-8?B?MzlUamp0SjRJSlpUZnRWNWg1eDdQQ3pTSlVyU0RiWnNxbUc1YzFxRUVSaWhu?=
 =?utf-8?B?Y21YY1J5SWJkTXg3QkxnTS9ncDJoWHhLdzdIbUtDWjNVcThYcHlYT1E5Q2ZO?=
 =?utf-8?B?ci80bmJIaEhSc3lWN3h4Z00xV3JpTDV3M0doa2x6Nzg4S2E2R1BmMmJZNlZI?=
 =?utf-8?B?TDJybE51dTZpR2FFOFVYK2VEbitmb0dHa2EyYWI4UTBIRlMwODYvakJ2OGg2?=
 =?utf-8?B?WFB2RHNoNmZvVWN3RDFkaFVsRlhzRlRuRmxyYmJLQ0cxYVZqZWNJRDIrOHla?=
 =?utf-8?B?ajJNTUZsTldNRXR0ZUl5U3Vnek1ZUFpqd1Z4Unk1bGpTWGV6SkxEVjNPTm9Y?=
 =?utf-8?B?N3YyZnhKbHhjUDU1ZkFPYko4WkM1QXE0R0tHcCtUUC9ZMlllNEJaTjZjWHor?=
 =?utf-8?B?RkhVV2w1WDRvN1dQYnVxbWN1VjNSbkpUSzRTTkM5V3c5WFBrMlJraWgwV244?=
 =?utf-8?B?QjJabEVWMlBiRGUxei9Pa0o3QlUzdmt4QWpOT2FoQ0dwdDB1ODl4ZE1kTEJi?=
 =?utf-8?B?dVRzeUExdFFKQWlZaWwyaUIvR2E3Nit2ZityUkpXa0IrdkZkbE9SMjlBM1kw?=
 =?utf-8?B?YTgzUDVFUU8vYUlJSGFwa2R2TmVYTzZKZk15enp6Wm5kbVZZWFFsSTNzbXp2?=
 =?utf-8?B?cXNxbnlqNDFuZkdhQU5nL2ZDc1A1YUxmREZsai9kVVEyV09pL1MvM2JTeHl4?=
 =?utf-8?B?ODJFaUNjL1dmaGJBK3c2OXpUTEsvNFlac0cvRTBoajdSY0RmSFc0U2JWRG5N?=
 =?utf-8?B?SUovODRLREJ6c1lOc3I1dGNLNU1QSEE4djVicGVhbGxOdHVYeG5DK0tlSjZI?=
 =?utf-8?B?eFRVWEdFYytVV2xPVW5CVTRBVjlwNEY5TjhPZXBLcjN4eGphSldQZDZQbE5m?=
 =?utf-8?B?aU52c2RjZnRERFpEc0ZNV1g3cXhNR3BPdHc3TUJZRXppelU3a1pWaGFId2lj?=
 =?utf-8?B?TWlOeW5oR21vVHE1VUludmM3Wmw2S2VYbnVibThUS1hOQUVzN3B4cjdkMzYw?=
 =?utf-8?B?OEFLU05iNE5Na2I5b1ZmOUorSnNWUVdwQlY5LzNKR3Boa2ZReWs2SG1vQTMz?=
 =?utf-8?B?bk92MEVIYmN6WHNscmg4eE9jRTREcnI5a3lMMC9WQTlMdldIZkMxUWs5SW1Q?=
 =?utf-8?B?bEppN2wwaTBPUlVrdGVEbjROOC9oQmY2VU1JelQrSzUxdGd2ZU9leDV2K0lz?=
 =?utf-8?Q?J0m4rMMqL/qFXqbjsc0a6jTkw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d118e0-37c6-4da6-c215-08db14225c4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 15:43:21.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xc+mK1U8c9M2YPMp7HPDApaG7cuo3/FddRMi7Zhe/E0F7NbI0eLWvoFEV2zD5QqKrhgg7Q5dJOJBpDI9AoY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7594
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 05:34, Borislav Petkov wrote:
> From: Dionna Glaze <dionnaglaze@google.com>
> 
> The GHCB specification declares that the firmware error value for
> a guest request will be stored in the lower 32 bits of EXIT_INFO_2.  The
> upper 32 bits are for the VMM's own error code. The fw_err argument to
> snp_guest_issue_request() is thus a misnomer, and callers will need
> access to all 64 bits.
> 
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's unsigned long*. Change this
> type for issuing the guest request. Pass the ioctl command struct's error
> field directly instead of in a local variable, since an incomplete guest
> request may not set the error code, and uninitialized stack memory would
> be written back to user space.
> 
> The firmware might not even be called, so bookend the call with the no
> firmware call error and clear the error.
> 
> Since the "fw_err" field is really exitinfo2 split into the upper bits'
> vmm error code and lower bits' firmware error code, convert the 64 bit
> value to a union.
> 
>    [ bp: Massage commit message, adjust code. ]
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230214164638.1189804-5-dionnaglaze@google.com
> ---
>   Documentation/virt/coco/sev-guest.rst   | 20 ++++++----
>   arch/x86/include/asm/sev-common.h       |  4 --
>   arch/x86/include/asm/sev.h              |  8 ++--
>   arch/x86/kernel/sev.c                   | 15 ++++----
>   drivers/virt/coco/sev-guest/sev-guest.c | 49 +++++++++++++------------
>   include/uapi/linux/sev-guest.h          | 18 ++++++++-
>   6 files changed, 68 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
> index aa3e4c6a1f90..68b0d2363af8 100644
> --- a/Documentation/virt/coco/sev-guest.rst
> +++ b/Documentation/virt/coco/sev-guest.rst
> @@ -37,11 +37,11 @@ along with a description:
>         the return value.  General error numbers (-ENOMEM, -EINVAL)
>         are not detailed, but errors with specific meanings are.
>   
> -The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
> -The ioctl accepts struct snp_user_guest_request. The input and output structure is
> -specified through the req_data and resp_data field respectively. If the ioctl fails
> -to execute due to a firmware error, then fw_err code will be set. Otherwise, fw_err
> -will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest
> +device.  The ioctl accepts struct snp_user_guest_request. The input and
> +output structure is specified through the req_data and resp_data field
> +respectively. If the ioctl fails to execute due to a firmware error, then
> +the fw_error code will be set, otherwise fw_error will be set to -1.
>   
>   The firmware checks that the message sequence counter is one greater than
>   the guests message sequence counter. If guest driver fails to increment message
> @@ -57,8 +57,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
>                   __u64 req_data;
>                   __u64 resp_data;
>   
> -                /* firmware error code on failure (see psp-sev.h) */
> -                __u64 fw_err;
> +                /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
> +                union {
> +                        __u64 exitinfo2;
> +                        struct {
> +                                __u32 fw_error;
> +                                __u32 vmm_error;
> +                        };
> +                };
>           };
>   
>   2.1 SNP_GET_REPORT
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index b63be696b776..0759af9b1acf 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -128,10 +128,6 @@ struct snp_psc_desc {
>   	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
>   } __packed;
>   
> -/* Guest message request error codes */
> -#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
> -#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
> -
>   #define GHCB_MSR_TERM_REQ		0x100
>   #define GHCB_MSR_TERM_REASON_SET_POS	12
>   #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..30567c72cbd9 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -185,6 +185,9 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
>   
>   	return rc;
>   }
> +
> +struct snp_guest_request_ioctl;
> +
>   void setup_ghcb(void);
>   void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
>   					 unsigned int npages);
> @@ -196,7 +199,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
>   void snp_set_wakeup_secondary_cpu(void);
>   bool snp_init(struct boot_params *bp);
>   void __init __noreturn snp_abort(void);
> -int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
> @@ -216,8 +219,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
>   static inline void snp_set_wakeup_secondary_cpu(void) { }
>   static inline bool snp_init(struct boot_params *bp) { return false; }
>   static inline void snp_abort(void) { }
> -static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
> -					  unsigned long *fw_err)
> +static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>   {
>   	return -ENOTTY;
>   }
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 3f664ab277c4..b031244d6d2d 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -22,6 +22,8 @@
>   #include <linux/efi.h>
>   #include <linux/platform_device.h>
>   #include <linux/io.h>
> +#include <linux/psp-sev.h>
> +#include <uapi/linux/sev-guest.h>
>   
>   #include <asm/cpu_entry_area.h>
>   #include <asm/stacktrace.h>
> @@ -2175,7 +2177,7 @@ static int __init init_sev_config(char *str)
>   }
>   __setup("sev=", init_sev_config);
>   
> -int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
> +int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
>   {
>   	struct ghcb_state state;
>   	struct es_em_ctxt ctxt;
> @@ -2183,8 +2185,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   	struct ghcb *ghcb;
>   	int ret;
>   
> -	if (!fw_err)
> -		return -EINVAL;
> +	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
>   
>   	/*
>   	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
> @@ -2209,16 +2210,16 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
>   	if (ret)
>   		goto e_put;
>   
> -	*fw_err = ghcb->save.sw_exit_info_2;
> -	switch (*fw_err) {
> +	rio->exitinfo2 = ghcb->save.sw_exit_info_2;
> +	switch (rio->exitinfo2) {
>   	case 0:
>   		break;
>   
> -	case SNP_GUEST_REQ_ERR_BUSY:
> +	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
>   		ret = -EAGAIN;
>   		break;
>   
> -	case SNP_GUEST_REQ_INVALID_LEN:
> +	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
>   		/* Number of expected pages are returned in RBX */
>   		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
>   			input->data_npages = ghcb_get_rbx(ghcb);
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 6bc1390b54e8..6b3c1d308353 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -332,11 +332,12 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   	return __enc_payload(snp_dev, req, payload, sz);
>   }
>   
> -static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
> +static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
> +				  struct snp_guest_request_ioctl *rio)
>   {
> -	unsigned long err = 0xff, override_err = 0;
>   	unsigned long req_start = jiffies;
>   	unsigned int override_npages = 0;
> +	u64 override_err = 0;
>   	int rc;
>   
>   retry_request:
> @@ -346,7 +347,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	 * sequence number must be incremented or the VMPCK must be deleted to
>   	 * prevent reuse of the IV.
>   	 */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input, rio);
>   	switch (rc) {
>   	case -ENOSPC:
>   		/*
> @@ -364,7 +365,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   		 * request buffer size was too small and give the caller the
>   		 * required buffer size.
>   		 */
> -		override_err	= SNP_GUEST_REQ_INVALID_LEN;
> +		override_err = SNP_GUEST_VMM_ERR_INVALID_LEN << SNP_GUEST_VMM_ERR_SHIFT;

Would it be better to do?:

	override_err = SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN);

>   
>   		/*
>   		 * If this call to the firmware succeeds, the sequence number can
> @@ -377,7 +378,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   		goto retry_request;
>   
>   	/*
> -	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
> +	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
>   	 * throttled. Retry in the driver to avoid returning and reusing the
>   	 * message sequence number on a different message.
>   	 */
> @@ -390,8 +391,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   		goto retry_request;
>   	}
>   
> -	if (fw_err)
> -		*fw_err = override_err ?: err;
> +	if (override_err)
> +		rio->exitinfo2 = override_err;
>   
>   	if (override_npages)
>   		snp_dev->input.data_npages = override_npages;
> @@ -399,9 +400,10 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	return rc;
>   }
>   
> -static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> -				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -				u32 resp_sz, __u64 *fw_err)
> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
> +				struct snp_guest_request_ioctl *rio, u8 type,
> +				void *req_buf, size_t req_sz, void *resp_buf,
> +				u32 resp_sz)
>   {
>   	u64 seqno;
>   	int rc;
> @@ -415,7 +417,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>   
>   	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
> -	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +	rc = enc_payload(snp_dev, seqno, rio->msg_version, type, req_buf, req_sz);
>   	if (rc)
>   		return rc;
>   
> @@ -426,9 +428,11 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	memcpy(snp_dev->request, &snp_dev->secret_request,
>   	       sizeof(snp_dev->secret_request));
>   
> -	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
> +	rc = __handle_guest_request(snp_dev, exit_code, rio);
>   	if (rc) {
> -		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
> +		dev_alert(snp_dev->dev,
> +			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
> +			  rc, rio->exitinfo2);
>   		snp_disable_vmpck(snp_dev);
>   		return rc;
>   	}
> @@ -471,9 +475,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	if (!resp)
>   		return -ENOMEM;
>   
> -	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
>   				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> -				  resp_len, &arg->fw_err);
> +				  resp_len);
>   	if (rc)
>   		goto e_free;
>   
> @@ -511,9 +515,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>   		return -EFAULT;
>   
> -	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> -				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> -				  &arg->fw_err);
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
> +				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
>   	if (rc)
>   		return rc;
>   
> @@ -573,12 +576,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   		return -ENOMEM;
>   
>   	snp_dev->input.data_npages = npages;
> -	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
> +	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
>   				   SNP_MSG_REPORT_REQ, &req.data,
> -				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +				   sizeof(req.data), resp->data, resp_len);
>   
>   	/* If certs length is invalid then copy the returned length */
> -	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
> +	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
>   		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
> @@ -613,7 +616,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (copy_from_user(&input, argp, sizeof(input)))
>   		return -EFAULT;
>   
> -	input.fw_err = 0xff;
> +	input.exitinfo2 = 0xff;

Should this be?

	input.exitinfo2 = SEV_RET_NO_FW_CALL;

or make it part of patch #1?

>   
>   	/* Message version must be non-zero */
>   	if (!input.msg_version)
> @@ -644,7 +647,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   
>   	mutex_unlock(&snp_cmd_mutex);
>   
> -	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
> +	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
>   
>   	return ret;
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 256aaeff7e65..b25b728281ca 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -52,8 +52,14 @@ struct snp_guest_request_ioctl {
>   	__u64 req_data;
>   	__u64 resp_data;
>   
> -	/* firmware error code on failure (see psp-sev.h) */
> -	__u64 fw_err;
> +	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
> +	union {
> +		__u64 exitinfo2;
> +		struct {
> +			__u32 fw_error;
> +			__u32 vmm_error;
> +		};
> +	};
>   };
>   
>   struct snp_ext_report_req {
> @@ -77,4 +83,12 @@ struct snp_ext_report_req {
>   /* Get SNP extended report as defined in the GHCB specification version 2. */
>   #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
>   
> +/* Guest message request EXIT_INFO_2 constants */
> +#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
> +#define SNP_GUEST_VMM_ERR_SHIFT		32
> +#define SNP_GUEST_VMM_ERR(x)		(((u64)x) << SNP_GUEST_VMM_ERR_SHIFT)
> +
> +#define SNP_GUEST_VMM_ERR_INVALID_LEN	BIT(0)
> +#define SNP_GUEST_VMM_ERR_BUSY		BIT(1)

These are actually supposed to be numbers, not bits. It works out that 
INVALID_LEN is 1 and BUSY is 2, but the next value (in the GHCB spec) will 
be 3, so lets change these to 1 and 2.

This could be fixed in patch #9 or here as/at the final change.

Thanks,
Tom

> +
>   #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
