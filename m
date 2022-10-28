Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E7A6114F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJ1Opd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ1OpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:45:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16CE371A8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onm7o8fmgtdxO7qeiTJ4hxIRYO3bBJY6q6l3OtQwkqtVdPVpfF+WfF7d9WBD7Z9Gpv5PQ7DeyYSn2TRQiGMcbwBP2//O9huuH10lPxvrU0+x9NzX7HLGVXty9AUu8onkQR3m4fksf9AMWWMg0jhAxk2UyQkC7eBRjMX1VD5M4i0atbuT7/Qal/4NqqyDyIRjXjzCuAaEdibhrIThwgfLoBFbnvqKHd5xNH9zC7Nt4TXcgxpQ9Qayk1PNKU22xulo6Y5pR+lYcHcxJVIYmLahXc+q4Kdwj8wyu9Dx/T7IFiA1g4cvGIjPefxTxpBkAAFbngNZQhWcNefWYTe04myirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkorc6DWHSXuVsl1CaeLj67JnqOdaJ6NBI4GE4t3wGM=;
 b=fwWCOCttIlg8x8UMy8XYNUGn4YFPhlv2CvS/OBIGfyBc+wTwV/HijVhLje8T30RqSnyF2X6QvCE4ZzlKlUA12+n8wM3HckvUE8qXbp7++Iw/eBddN4JyxhR6svO8/boZrgn8Cus3+BFoD2WQoVdYLdMrITRfPoCe4F4hdXFQXWEyv8AslpLAfWlOnpSSU2nJDaIVl/yfTKJ1HlDbH+7kTNR0K1ymNnzzPaMv0eD1mOrFP5s7E5P8T42UmZOpmhzAAL7vyIumtMXgPsmhkXf2kEJZZEZFjkRLYQBEg/PkIkscPnamJ8pqXxd68nsE7X5Z8bFkN7jQ0hRjwqQP/10ICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkorc6DWHSXuVsl1CaeLj67JnqOdaJ6NBI4GE4t3wGM=;
 b=1vFkM1avWSh0oD+MIkvBXHakFDv/naTVF7TEWx7iaU9tTKVEmjhEGR/8rgyVAd+s2RWbGJhNaU4BMp2+cEET0iiqow85GXkAiW5BHvGU1AoqO+yyc+EavQEx9mdfgD7DBzVW8s3HOcIJy9tdDC8U5g5EBjPsQg1AFPq37JVUXxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 14:45:12 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:45:12 +0000
Message-ID: <3f1b0015-9393-a441-ce5f-79b39c3e8ee7@amd.com>
Date:   Fri, 28 Oct 2022 09:45:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/4] x86/sev: Change snp_guest_issue_request's fw_err
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-3-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221024224657.2917482-3-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0119.namprd02.prod.outlook.com
 (2603:10b6:208:35::24) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d880e24-cecc-447c-ceac-08dab8f30499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0d3bnvanVOKItuVM8OEvr0NM0Zx98Lr4wd39p8ftdmK4TSo9fWEDgqE050ydC2LRlmtB0PuSx3vZjFW9Qn6JEZLAQzH4tLLMpuz7ynzPtP9B1jGg7ktKwfrjNHprUVS4Q+9FLPqsPzl/ULJXkiwkh/x2L68M7GfqPuoWNbc48FahU25I4uVFUMz7+TJHQp17a/GF32yMUU/J64nCugNrYeOFWNiflqCZ699X19K/yhztg0DAxNKoQmYduxHrv+Zwq7gowJFrVxsqfBjHJSFCqPWb0rhnfHbc0K0zkssXNsaSolsC3LbtjlTqua4h5IUagcrul+lWiNiLXc1wuRYoIkGAmtXFTbZy5irQ8KNC5dMRIrBLxX8dzZm0DHRyGGWb4OowCQT4Fi1EqO1PJmV9u5AXkJXCSEnDJorDHjgUrR2lT4EjhSG1ewqEiQ4vCHU0fXHxr4bodcklJl0DqcfL3QC7KRGeOwtGr8ic2gXVzwJcrQFmX60ue1UbrGinFnQcDWEJ7zGsekGv0vEg8N/EPhg46VJgAAiC7NKhSGvIx0zT59IHQm8oFUSo9WogMgultZMylhHXMkVgCs38+XA/BVmy/u8ADqu1Pq0KZzw/3xL9XgolCh8MsBmy5TDtv1F5/gLvwfE1M8ePy4Q6z4f9b1d70ZVBfWzax57+sifFVTce/ObMtIn1g7sji7Tuy526LYG/xFYrXvVN1bIC2j6J4OrokpQZgkp/UhHLQOhTCQi58bEkXBD8AbkuDUBQdHkwACBMxrMUXDMg2GU/AnNiy53YD/P0efuCKOu7MOQ4Ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(31696002)(86362001)(36756003)(31686004)(38100700002)(186003)(53546011)(2906002)(26005)(6666004)(478600001)(83380400001)(2616005)(6512007)(6506007)(66946007)(5660300002)(54906003)(66556008)(6486002)(8676002)(8936002)(4326008)(41300700001)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXIwOGpPMjR0Ynd4QTBZWmJOdFpUSWdySkZoNFBlUXVGYTBiQUVTRTZCMEFz?=
 =?utf-8?B?UkdTV3JEdDFaQ2hiZW1naTdHR1FVMExTNkRVMHJxL2hpQzFJT0Vud1FLazNB?=
 =?utf-8?B?dTR0OFZvbnVadVNkNmlTNFlrMHZHeW1jMjlDa0RvT2kxbHdyT2gvQi9RejEr?=
 =?utf-8?B?MzkxcmlRRS9zb2VXZWJ2L0k2Z2ZSTlU2eVNzb0ZNay91N2pUK1dwL0YxVjEv?=
 =?utf-8?B?S0JiUXZUYVVmRjZQSWNrVmxaK0tQWlNrWFYrVC9NYi9YWHgvb3p1ZlhyTXpa?=
 =?utf-8?B?UDY2cVNzK0lUbTc1NWJWN083c2xtNmFBYzRFZHd4SlErQTVUeUJodGpwdUUw?=
 =?utf-8?B?WmVZRkZpTXd5TWtUa2JuaHl0U1hDV1kxUFJxUTNiblBYMFlYU3FZTUNqU0pp?=
 =?utf-8?B?UVlOUCtIMzdWK2lwMHVqNCtON2FsRXcxWHVJUGswMnUvZmloQ20yeTdMMnVX?=
 =?utf-8?B?UCtPc05TRllBQzN0aENnOVJBdDk0eCtiTU9SQU1NOTg5SjNRQzZSN0lDNXFn?=
 =?utf-8?B?eHZucnoxS3RVVmVTdGFLcFFKZ3NzWld2THU2L1pMUlNCcWJvcEhZRGVTQ0sv?=
 =?utf-8?B?ZEhpOXdLRTBYYzVSOGN6bnZCaWlYVUdsWkVpbWhHdllueFJhcmhJckFJZFJl?=
 =?utf-8?B?U3JLSGFuMTZUS2xSVElyOS83VGdjblVzSWZuRS9xbnYyMXNiWFd4Y3N1bFJ4?=
 =?utf-8?B?Vzh5dXdFM3MvdDRxbHZ2OWlrNGY2cGllekJuUDMzeW1qWHNzeURiMWJUS3Bj?=
 =?utf-8?B?UXNTazcrZWphTUh3ZDh0WHZ5VW0xV3RmSnhvLzhDM25JalNhSHhKUFBBRmth?=
 =?utf-8?B?S3I5K2JOWnRhVDRQNVY4SVlPUStReWwwc2tYVDllbTc3RTd2bWZpVzRtNzds?=
 =?utf-8?B?NG9MbEtDc2M2SngrRFF1akRxUnNHdVZzcEtJeXlSVC8weWY4V2Jud2xva3Z0?=
 =?utf-8?B?V01MVFdyc1NMV3lTU2hPa1J5cFg0ZmJLVmFDa1d3RFJLNUpjRHBTL01JOTQ3?=
 =?utf-8?B?QmUvSUx1MlFWRzBmT2pQZThIUGJGdXdrNXJqb3c5ZHl0emxGVkRMeVdtTE1F?=
 =?utf-8?B?cDNXOThkSHl3ZFArUU4wemozQ2F4NFI3YVU3K053MWZiaFhiZHhIYUVxNWRq?=
 =?utf-8?B?eHZXK01lOXppUCtCSDRVT0s2TW90b1l6ckl5REFRcC95NUxPdzhPS3puSWRL?=
 =?utf-8?B?Y0pnWEVqZUdYU0doWFR1alRZVzZMN2JnTG5zRFU5WGdadVZHTERBMlE2Uk56?=
 =?utf-8?B?b25LVDNKWTNRYmlGSkdtL1VoSWxnZWpva09HWUVSRlRURG45YTNLQmMydzNy?=
 =?utf-8?B?OWN2cUljSWNBOXlqYUNObmJxYko0R3pjQmF2SVQ0VkdFcitXZDZWODhrL2dy?=
 =?utf-8?B?UUZjaUdmdFBPS2JXd0RGYmNDVXEyRlZZcTlzU2t3R05zYWVRQTdTUVk5Y04z?=
 =?utf-8?B?b3VFK2c2N0pvTWJXZFZZcHRTeURnZHFleWxRYlZJTXBTekNwOHltNXphWW0w?=
 =?utf-8?B?KzlvdnZ6YkNlaDk5bGlTS1c2K0FIVkprV05GWDE2Z04rMVlpcExVUmNuOW9J?=
 =?utf-8?B?T2QxNUhRMlJ1WVdBbU5QWFBzRThDVUUxTzdtT3FnWitENXNyUWNHRHBUVHd5?=
 =?utf-8?B?dmQ2ZWt1NEpUdlR5cDhiTzdDM2s4ODI3R1N0cTdZK2phSGhOUVZJWkFvY1JV?=
 =?utf-8?B?bzZrY3dZU05oQXBnakZxRGpCdThHajhSVUZMSHVNcE9Zbk9sakF0Z2Z6RXhV?=
 =?utf-8?B?UXQrNzNrc0RVRnJUMkU2M2lyVHg0RmowMklJNUVzV1R1S0g4b0xmSkkzZWs5?=
 =?utf-8?B?Y0pIeEhIVi8wWFBWVjAyK3gxbDBLRzlrOGxPL01BRWgzdngvY3hoajJ5d09L?=
 =?utf-8?B?bVFiQ2czVm1pZ05KcTREU0RQc3hQMDlpOVpIeVFoL09zdDJtNGRndGQrSUN1?=
 =?utf-8?B?M1FjTzJZYlhOL1NWaU1DSXZWR2FMVUpaeDY3WTJWeVVZTUp0VjNsMjVCT0k1?=
 =?utf-8?B?Zy9FbUtYY0RaZG9sdjJZSDVpYjhYbXA3R1ZENlJQNmEzOGwxUXJURkVpcm03?=
 =?utf-8?B?U3IrRmhUajRmNWZpQzR5WlBUQzg2ZEJPeEM1QnRHT2tWUDhZUnY0Ukc2amQ0?=
 =?utf-8?Q?tCvzOl2/rTLJZitYr2e0uZ0e5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d880e24-cecc-447c-ceac-08dab8f30499
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:45:12.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F//uyaekQT/og3S2EBI+BCUirDH7SshiL08ZF3CRv4fMBMK3qNwTi+SMe+tDpo6GJBzMOIXNwjG3iZHbce+6Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:46, Dionna Glaze wrote:
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

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/include/asm/sev.h |  4 ++--
>   arch/x86/kernel/sev.c      | 10 ++++++----
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
