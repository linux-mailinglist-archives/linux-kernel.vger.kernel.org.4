Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8C7089CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjERUs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:48:54 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E6CE7F;
        Thu, 18 May 2023 13:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMn8AD5V1zX+7OnTogNJ6DjUN+RSzxXh6YrGeWOhbsxJ9yH12Aq4PaKje3RQtL8o60j7o185hCYUPkXXR+ZI9JD7MmGUCaW8Qnj/3j34Lo0zngckR8m81MlvOyaBxp4h2y+XfEe6xVZ+82torAIZTM/0RJavyjPCnoPnwBpKEHxR5qdu4mojaxu3lBqMZybkv10PwPIKe4tCyfldHtFdbFEAYlvDrfx6u8kuLfEs2+aH+XLVuI3LSX133tO5aJdjOGdO3l1xzMgVgenxFUHR85ZVt5U5mJLBbzIldBT9ayGZn1+u8lat3U8HnIFsF363IQ4d+OPpfxSOwKH0xAzy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTVdgE/meG3TM4ZwgedWJZhIxyEN+noLT55L/Rhtsqw=;
 b=QyQV8Jt1TIxUFLYckVTu38iWah5TqE5+9QIQLIxEra3uUrjTeVmFo8RIUyqkdQRC7TZx7AlKsuRLGA1Czb9nSdkQNNv9kg2Rla+m6liAb4NgjoLByihzRNa4tL/JRBTBlkhFQkbkAaM8SQA5PjbE5idoOuyS+QiU0CP8snWsTUuQd5IvPS5JBzXCxpSeYmaU3n/kd0q6zo8d9Q7tq/Ry4JsMnywBSy3pxWxj1A2jFFAEwp1KAdLc52E6mQ9fELJdFMvuDI1gE7q7falV0z1luToLP1vxpDD/ytlKlLM0iGMiFSW6RIi8Z3tGWvzRWykLhS4azdecMd/PAm6xJgY5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTVdgE/meG3TM4ZwgedWJZhIxyEN+noLT55L/Rhtsqw=;
 b=JIDMeSAbAckN9aQCEsI6nU6pCloLe/h02VA9gZ3Xw/w87pjEq/SSdmOgNwvtqU+bDtduyv4kfLlFFbyHByy4p4QOvlVQdqJ6pDZHLIm9PKx6i22ANt7wGR9BvXp+nI8bIu685QVZEgFHsAV3Tk2WZnHP4rPyGBCVwmQSH3tMRX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:48:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 20:48:30 +0000
Message-ID: <a7580b4c-09f3-da32-8547-5b0193709c16@amd.com>
Date:   Thu, 18 May 2023 15:48:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 18/20] x86: efistub: Avoid legacy decompressor when
 doing EFI boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230508070330.582131-1-ardb@kernel.org>
 <20230508070330.582131-19-ardb@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230508070330.582131-19-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:806:27::25) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4b8c53-4709-472f-c623-08db57e13ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOsGfqTuKwoGjhKbw8uFR5+zkKCfnn/7L/POCX8NfVsk+flrbcBErGmprR3rLcpsOdHzkrdjmkxD1CQ4zk7gAraZVH7pAh6VTnZhNcZEu9QGPpG+gmKtqzOOiXcnKWjuovjFth2BAdkOkjhZ16un00tW1qq3MvXRKHh9ujNTIoMOCG2OFgTqs7/gI+jY6pOaXsihy37N1Hvois3dKYP9y5LchCinc1MVA9lTSkf2W9Z4YooT3vCLVKsNj3VFwBS8a1PARqxu6B+bJQ5uLzWfvg4CCqfqTy/45X58cBrQaa1ncI10QMIjEQwAS6y/m6BHS1nHFoVWJpsB5Bk2i/77lza/jHiz50JwSBbq6sPCrSOfcOj7TYXaTOwe/FaXxGwswyTS8Z3RsZtYIhR0rCXRBHjLX49owmP2RmJem8hslonlHbTyp6HPjBefqRpFMWZKnLYj5UQn5mY2XFt61h9Mvaeq65FEoj35hrU9jUl2AhzcGhjDagwOslreT94A4ZkfRMpPZMWJEr4amTlSjSLNauqT6tVnc0o8I5BObF5x+11EPU2jcx/yiLbzcsl/BXr+svAafg1OcWOTHNvACr01jCHtgJXzHyhSJo5wiljiZmsa6+nHlDBRyGgKc1tozVH2ZBEoBY5D4TrkI2wwH5BOkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(30864003)(478600001)(41300700001)(4326008)(8936002)(31686004)(8676002)(316002)(54906003)(7416002)(6666004)(6486002)(66556008)(66946007)(66476007)(5660300002)(53546011)(26005)(6512007)(6506007)(38100700002)(186003)(2616005)(83380400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZIMDhvU0NoYm1vcFRRenV3S2VuRjFtZzNiQWJrR1pGM2oweDZwelVwV1VM?=
 =?utf-8?B?VWgxKzVkaVF0OFlVWEs0VlFFck1KRDRQQlljcDZ2ZkZRV2EvZEttY2FxdVZZ?=
 =?utf-8?B?OEFBdmpheVErRHpFSThFUzBwQ3ozR1B3ajUyMSsydTE4RHgxemlVb2VyS1Rs?=
 =?utf-8?B?Q1ZXVUpMVkZQdm5HSlZ0RGRzVkwyc01vbUNRL0JvU3ZzVXNLb2FubjF6ZlZW?=
 =?utf-8?B?aFZLRzB1c3RidklmYUJVY3o0WjBhOW1lY1JHRXBEaEpYQjE0Mk0rMURzYkhU?=
 =?utf-8?B?eUd3QU16RmZ5VUc1clNkb3A1UTdSbjQrdTdKd29PTG4wbmdjbXBaNjZxb1pz?=
 =?utf-8?B?WUgzR3pJdGxoNUlpQkFFWU9DTkZhUFQzL2pkemtlQnNQcjc2WUl2V0RxcUJw?=
 =?utf-8?B?WG1mYXcrNktqckdaQTIxNUZNQis3b25yNm1XVmN4SHlLaVJzVDBmdTV4RWcr?=
 =?utf-8?B?UGUvRkVEVW1zZThlUWV2MWVqUWlKRVdTYXdacHNPd0lhcmhRSFRSZnFJMzFM?=
 =?utf-8?B?eGhmWmNzWGgzdFIvOFZUYWRLQzQ2RHloM3A0NjZBQVNsTVB1RUt0OVE4R1N6?=
 =?utf-8?B?YUQ5ZDNDWVhROTNTS2puT1ZtTE42TkZ2Si9KbGZ5M0M5dVpoSTQxOUNwOUNG?=
 =?utf-8?B?SktiZnc4Yy9EVTRPbTlmVGlIQm1JLys2THo1NG51OGVGWmp0WUpzcXZuc3Jq?=
 =?utf-8?B?WjFLY28xUUJocTN0d2hVaDYxOVdrUFNOZXliaGFzUVZIc3pScXozU1YyMUtZ?=
 =?utf-8?B?RS9MelpzUzVvYVhjelV0b1RKbEhDUDJCSnNPR1JDRXdRRjVFZ3NENW9JUGxG?=
 =?utf-8?B?ejl4dmlsN21IOTR5bmFqdTNyeVFCTXAwSTZ6Q3pVRzg5QXdxSElGZGQySy9Q?=
 =?utf-8?B?NHJQamZsaDhCem1JMVpsK3BmQ1NFWlplV0o5NTdaN3RuVU9iT04rOW1oNEpP?=
 =?utf-8?B?WHQwK0gwTW9Ub1F6R3JrYmQrQTI4ckF1MGdBU0NsemE1OWlyck12bElSd2hF?=
 =?utf-8?B?Uk1UWFpoV0VzSGt6dGxPMVFidVdTNldkdi9STHNodE83NytIeVJZckFvTkw5?=
 =?utf-8?B?THAwdncrdGxqS1FtS1FJTTlZdjg1RklIRkRTb1QzVmN3dTdJRkNUZG1jalpl?=
 =?utf-8?B?RWZoelVkQjE5bWtKVU0xbGgwaS9scmtRTXdHMHdJQUgvTTNTbk9tWnpEQ1dm?=
 =?utf-8?B?dmwzL2V6TGlyU0ZDTkRsOXdoYndrWWNzd0d0Y01SMHU5U3ZTZ3dzd2liMWZ0?=
 =?utf-8?B?L3Q3NDliYkhtT0kzNDdQNEp0WDJVbDZJTjFhZkRPV08rZ0FmNElBZEhSd1pk?=
 =?utf-8?B?Z3E4N2RRb0MrTVZwWDhQRGhuVEhHajYyZUEvMTQxVWhRNVlnMFp6K1RoNW9N?=
 =?utf-8?B?cG9WYVNWeW83V0JGRjRiWHZKMUl0ZHphMzFyWW5QQ3hxTFd6MUt1UFM2cWNr?=
 =?utf-8?B?eEZjY2JiMWs0Ym12K2hjOVFpTnFpNGNpamx5WUREQWV1d3d0OXJlNjR2RnQy?=
 =?utf-8?B?L01rMWtzZVdVT2UzNTVqUmhvRDlncnRCamJTSE9nWGFkWDNFMlBrNzlyaFll?=
 =?utf-8?B?Q1gwR2JZbEVWS3I2MHFUSVU4WU9Jc3FLR1RmcVdhSWh6SkV0NGYyODBZNXdv?=
 =?utf-8?B?UHFrSmthdmY5OGJZRkNBMjR4VUY2MStnNGJPTWRxU0E5QUJ3eTc4eGdnbGgx?=
 =?utf-8?B?MUQwUHVQV3JDdzVuVTY4aFQ2amdMRUdtelpJaE5USllIRHBONjBnTU5CS0Uw?=
 =?utf-8?B?QzdVRWtzWkVHeUdxczgrYWhHc3Zpc3cwQVJHbmZjQnE1aGJVNkFmd1VpWlgy?=
 =?utf-8?B?Q2xONC9Id1E5NHBydDVTZEp6MHRScnRoeFlYR1EybGQ4SVJsV2NkKzVCYzNT?=
 =?utf-8?B?YXBhUE9GdDNWcWxQRk13VmgxUjJkcWx0M3UyNkNyWDJDSWwvcEFHNDY5WWpB?=
 =?utf-8?B?bnpXazEyUnU3YVBqSmZ6V3ZyVzdKMnRtd3g1VjRwSVZORE9XaldsNm52U3dw?=
 =?utf-8?B?UkgvM1pERlN0b1N2WjdaZS9hMitqT0JQamFUdlFTczNlTlgrUXphRHdiZjcr?=
 =?utf-8?B?Skd0VlU1VExuUFpnRGhGc0dqYVN0dHlZU2k4N0xTNjF4MGl6QnhvV1Z1RU9h?=
 =?utf-8?Q?f8gyu7COWMGYwKdvAx3FM3P9g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4b8c53-4709-472f-c623-08db57e13ca3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:48:30.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBpTM96BsWOrU8D1JgEHgsTMMCVx75DeN5E+lHWZAV8hc+g3g0uGM7eu4UWoj+A/y5Bxu/ZdhK/LB3LGC0RJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 02:03, Ard Biesheuvel wrote:
> The bare metal decompressor code was never really intended to run in a
> hosted environment such as the EFI boot services, and does a few things
> that are problematic in the context of EFI boot now that the logo
> requirements are getting tighter.
> 
> In particular, the decompressor moves its own executable image around in
> memory, and relies on demand paging to populate the identity mappings,
> and these things are difficult to support in a context where memory is
> not permitted to be mapped writable and executable at the same time or,
> at the very least, is mapped non-executable by default, and needs
> special treatment for this restriction to be lifted.
> 
> Since EFI already maps all of memory 1:1, we don't need to create new
> page tables or handle page faults when decompressing the kernel. That
> means there is also no need to replace the special exception handlers
> for SEV. Generally, there is little need to do anything that the
> decompressor does beyond
> 
> - initialize SEV encryption, if needed,
> - perform the 4/5 level paging switch, if needed,
> - decompress the kernel
> - relocate the kernel
> 
> So let's do all of this from the EFI stub code, and avoid the bare metal
> decompressor altogether.

This patch crashes SEV guests, probably because of the BSS is accessed 
encrypted and results in ciphertext for what would be a zero for a non-SEV 
guest. After pushing patch #19 everything started working again. From a 
bisectability perspective, you probably want patch #19 before this one.

Thanks,
Tom

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/boot/compressed/Makefile       |   5 +
>   arch/x86/boot/compressed/efi_mixed.S    |  58 +------
>   arch/x86/boot/compressed/head_32.S      |  22 +--
>   arch/x86/boot/compressed/head_64.S      |  34 ----
>   arch/x86/include/asm/efi.h              |   7 +-
>   drivers/firmware/efi/libstub/x86-stub.c | 176 +++++++++-----------
>   6 files changed, 95 insertions(+), 207 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 6b6cfe607bdbdfaa..f3289f17f820f982 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -74,6 +74,11 @@ LDFLAGS_vmlinux += -z noexecstack
>   ifeq ($(CONFIG_LD_IS_BFD),y)
>   LDFLAGS_vmlinux += $(call ld-option,--no-warn-rwx-segments)
>   endif
> +ifeq ($(CONFIG_EFI_STUB),y)
> +# ensure that we'll pull in the static EFI stub library even if we never
> +# reference it from the startup code
> +LDFLAGS_vmlinux += -u efi_pe_entry
> +endif
>   LDFLAGS_vmlinux += -T
>   
>   hostprogs	:= mkpiggy
> diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
> index 4ca70bf93dc0bdcd..dec579eb1caa16d5 100644
> --- a/arch/x86/boot/compressed/efi_mixed.S
> +++ b/arch/x86/boot/compressed/efi_mixed.S
> @@ -49,9 +49,12 @@ SYM_FUNC_START(startup_64_mixed_mode)
>   	lea	efi32_boot_args(%rip), %rdx
>   	mov	0(%rdx), %edi
>   	mov	4(%rdx), %esi
> +#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
>   	mov	8(%rdx), %edx		// saved bootparams pointer
>   	test	%edx, %edx
>   	jnz	efi64_stub_entry
> +#endif
> +
>   	/*
>   	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
>   	 * shadow space on the stack even if all arguments are passed in
> @@ -245,10 +248,6 @@ SYM_FUNC_START(efi32_entry)
>   	jmp	startup_32
>   SYM_FUNC_END(efi32_entry)
>   
> -#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
> -#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
> -#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
> -
>   /*
>    * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
>    *			       efi_system_table_32_t *sys_table)
> @@ -256,8 +255,6 @@ SYM_FUNC_END(efi32_entry)
>   SYM_FUNC_START(efi32_pe_entry)
>   	pushl	%ebp
>   	movl	%esp, %ebp
> -	pushl	%eax				// dummy push to allocate loaded_image
> -
>   	pushl	%ebx				// save callee-save registers
>   	pushl	%edi
>   
> @@ -266,48 +263,8 @@ SYM_FUNC_START(efi32_pe_entry)
>   	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
>   	jnz	2f
>   
> -	call	1f
> -1:	pop	%ebx
> -
> -	/* Get the loaded image protocol pointer from the image handle */
> -	leal	-4(%ebp), %eax
> -	pushl	%eax				// &loaded_image
> -	leal	(loaded_image_proto - 1b)(%ebx), %eax
> -	pushl	%eax				// pass the GUID address
> -	pushl	8(%ebp)				// pass the image handle
> -
> -	/*
> -	 * Note the alignment of the stack frame.
> -	 *   sys_table
> -	 *   handle             <-- 16-byte aligned on entry by ABI
> -	 *   return address
> -	 *   frame pointer
> -	 *   loaded_image       <-- local variable
> -	 *   saved %ebx		<-- 16-byte aligned here
> -	 *   saved %edi
> -	 *   &loaded_image
> -	 *   &loaded_image_proto
> -	 *   handle             <-- 16-byte aligned for call to handle_protocol
> -	 */
> -
> -	movl	12(%ebp), %eax			// sys_table
> -	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
> -	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
> -	addl	$12, %esp			// restore argument space
> -	testl	%eax, %eax
> -	jnz	2f
> -
>   	movl	8(%ebp), %ecx			// image_handle
>   	movl	12(%ebp), %edx			// sys_table
> -	movl	-4(%ebp), %esi			// loaded_image
> -	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
> -	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
> -	/*
> -	 * We need to set the image_offset variable here since startup_32() will
> -	 * use it before we get to the 64-bit efi_pe_entry() in C code.
> -	 */
> -	subl	%esi, %ebp			// calculate image_offset
> -	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
>   	xorl	%esi, %esi
>   	jmp	efi32_entry			// pass %ecx, %edx, %esi
>   						// no other registers remain live
> @@ -318,15 +275,6 @@ SYM_FUNC_START(efi32_pe_entry)
>   	RET
>   SYM_FUNC_END(efi32_pe_entry)
>   
> -	.section ".rodata"
> -	/* EFI loaded image protocol GUID */
> -	.balign 4
> -SYM_DATA_START_LOCAL(loaded_image_proto)
> -	.long	0x5b1b31a1
> -	.word	0x9562, 0x11d2
> -	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
> -SYM_DATA_END(loaded_image_proto)
> -
>   	.data
>   	.balign	8
>   SYM_DATA_START_LOCAL(efi32_boot_gdt)
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 8ee8749007595fcc..3f9b80726070a8e7 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -84,19 +84,6 @@ SYM_FUNC_START(startup_32)
>   
>   #ifdef CONFIG_RELOCATABLE
>   	leal	startup_32@GOTOFF(%edx), %ebx
> -
> -#ifdef CONFIG_EFI_STUB
> -/*
> - * If we were loaded via the EFI LoadImage service, startup_32() will be at an
> - * offset to the start of the space allocated for the image. efi_pe_entry() will
> - * set up image_offset to tell us where the image actually starts, so that we
> - * can use the full available buffer.
> - *	image_offset = startup_32 - image_base
> - * Otherwise image_offset will be zero and has no effect on the calculations.
> - */
> -	subl    image_offset@GOTOFF(%edx), %ebx
> -#endif
> -
>   	movl	BP_kernel_alignment(%esi), %eax
>   	decl	%eax
>   	addl    %eax, %ebx
> @@ -150,15 +137,10 @@ SYM_FUNC_START(startup_32)
>   	jmp	*%eax
>   SYM_FUNC_END(startup_32)
>   
> -#ifdef CONFIG_EFI_STUB
> +#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
>   SYM_FUNC_START(efi32_stub_entry)
> -	add	$0x4, %esp
> -	movl	8(%esp), %esi	/* save boot_params pointer */
> -	call	efi_main
> -	/* efi_main returns the possibly relocated address of startup_32 */
> -	jmp	*%eax
> +	jmp	efi_main
>   SYM_FUNC_END(efi32_stub_entry)
> -SYM_FUNC_ALIAS(efi_stub_entry, efi32_stub_entry)
>   #endif
>   
>   	.text
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bcf678aed81468e3..320e2825ff0b32da 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -146,19 +146,6 @@ SYM_FUNC_START(startup_32)
>   
>   #ifdef CONFIG_RELOCATABLE
>   	movl	%ebp, %ebx
> -
> -#ifdef CONFIG_EFI_STUB
> -/*
> - * If we were loaded via the EFI LoadImage service, startup_32 will be at an
> - * offset to the start of the space allocated for the image. efi_pe_entry will
> - * set up image_offset to tell us where the image actually starts, so that we
> - * can use the full available buffer.
> - *	image_offset = startup_32 - image_base
> - * Otherwise image_offset will be zero and has no effect on the calculations.
> - */
> -	subl    rva(image_offset)(%ebp), %ebx
> -#endif
> -
>   	movl	BP_kernel_alignment(%esi), %eax
>   	decl	%eax
>   	addl	%eax, %ebx
> @@ -346,20 +333,6 @@ SYM_CODE_START(startup_64)
>   	/* Start with the delta to where the kernel will run at. */
>   #ifdef CONFIG_RELOCATABLE
>   	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
> -
> -#ifdef CONFIG_EFI_STUB
> -/*
> - * If we were loaded via the EFI LoadImage service, startup_32 will be at an
> - * offset to the start of the space allocated for the image. efi_pe_entry will
> - * set up image_offset to tell us where the image actually starts, so that we
> - * can use the full available buffer.
> - *	image_offset = startup_32 - image_base
> - * Otherwise image_offset will be zero and has no effect on the calculations.
> - */
> -	movl    image_offset(%rip), %eax
> -	subq	%rax, %rbp
> -#endif
> -
>   	movl	BP_kernel_alignment(%rsi), %eax
>   	decl	%eax
>   	addq	%rax, %rbp
> @@ -481,19 +454,12 @@ SYM_CODE_START(startup_64)
>   	jmp	*%rax
>   SYM_CODE_END(startup_64)
>   
> -#ifdef CONFIG_EFI_STUB
>   #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
>   	.org 0x390
> -#endif
>   SYM_FUNC_START(efi64_stub_entry)
>   	and	$~0xf, %rsp			/* realign the stack */
> -	movq	%rdx, %rbx			/* save boot_params pointer */
>   	call	efi_main
> -	movq	%rbx,%rsi
> -	leaq	rva(startup_64)(%rax), %rax
> -	jmp	*%rax
>   SYM_FUNC_END(efi64_stub_entry)
> -SYM_FUNC_ALIAS(efi_stub_entry, efi64_stub_entry)
>   #endif
>   
>   	.text
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 419280d263d2e3f2..24fa828eeef7d9dd 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -88,6 +88,8 @@ static inline void efi_fpu_end(void)
>   }
>   
>   #ifdef CONFIG_X86_32
> +#define EFI_X86_KERNEL_ALLOC_LIMIT		(SZ_512M - 1)
> +
>   #define arch_efi_call_virt_setup()					\
>   ({									\
>   	efi_fpu_begin();						\
> @@ -101,8 +103,7 @@ static inline void efi_fpu_end(void)
>   })
>   
>   #else /* !CONFIG_X86_32 */
> -
> -#define EFI_LOADER_SIGNATURE	"EL64"
> +#define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
>   
>   extern asmlinkage u64 __efi_call(void *fp, ...);
>   
> @@ -216,6 +217,8 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
>   
>   #ifdef CONFIG_EFI_MIXED
>   
> +#define EFI_ALLOC_LIMIT		(efi_is_64bit() ? ULONG_MAX : U32_MAX)
> +
>   #define ARCH_HAS_EFISTUB_WRAPPERS
>   
>   static inline bool efi_is_64bit(void)
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 33d11ba78f1d8c4f..59076e16c1ac11ee 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -15,16 +15,13 @@
>   #include <asm/setup.h>
>   #include <asm/desc.h>
>   #include <asm/boot.h>
> +#include <asm/kaslr.h>
>   #include <asm/sev.h>
>   
>   #include "efistub.h"
>   
> -/* Maximum physical address for 64-bit kernel with 4-level paging */
> -#define MAXMEM_X86_64_4LEVEL (1ull << 46)
> -
>   const efi_system_table_t *efi_system_table;
>   const efi_dxe_services_table_t *efi_dxe_table;
> -u32 image_offset __section(".data");
>   static efi_loaded_image_t *image = NULL;
>   static efi_memory_attribute_protocol_t *memattr;
>   
> @@ -275,33 +272,9 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
>   	}
>   }
>   
> -void startup_32(struct boot_params *boot_params);
> -
> -static void
> -setup_memory_protection(unsigned long image_base, unsigned long image_size)
> -{
> -#ifdef CONFIG_64BIT
> -	if (image_base != (unsigned long)startup_32)
> -		adjust_memory_range_protection(image_base, image_size);
> -#else
> -	/*
> -	 * Clear protection flags on a whole range of possible
> -	 * addresses used for KASLR. We don't need to do that
> -	 * on x86_64, since KASLR/extraction is performed after
> -	 * dedicated identity page tables are built and we only
> -	 * need to remove possible protection on relocated image
> -	 * itself disregarding further relocations.
> -	 */
> -	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
> -				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
> -#endif
> -}
> -
>   static const efi_char16_t apple[] = L"Apple";
>   
> -static void setup_quirks(struct boot_params *boot_params,
> -			 unsigned long image_base,
> -			 unsigned long image_size)
> +static void setup_quirks(struct boot_params *boot_params)
>   {
>   	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
>   		efi_table_attr(efi_system_table, fw_vendor);
> @@ -310,9 +283,6 @@ static void setup_quirks(struct boot_params *boot_params,
>   		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
>   			retrieve_apple_device_properties(boot_params);
>   	}
> -
> -	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
> -		setup_memory_protection(image_base, image_size);
>   }
>   
>   /*
> @@ -432,6 +402,7 @@ static void __noreturn efi_exit(efi_handle_t handle, efi_status_t status)
>   		asm("hlt");
>   }
>   
> +static __alias(efi_main)
>   void __noreturn efi_stub_entry(efi_handle_t handle,
>   			       efi_system_table_t *sys_table_arg,
>   			       struct boot_params *boot_params);
> @@ -465,7 +436,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>   	}
>   
>   	image_base = efi_table_attr(image, image_base);
> -	image_offset = (void *)startup_32 - image_base;
>   
>   	status = efi_allocate_pages(sizeof(struct boot_params),
>   				    (unsigned long *)&boot_params, ULONG_MAX);
> @@ -853,20 +823,82 @@ static void efi_5level_switch(void)
>   #endif
>   }
>   
> +static void efi_get_seed(void *seed, int size)
> +{
> +	efi_get_random_bytes(size, seed);
> +
> +	/*
> +	 * This only updates seed[0] when running on 32-bit, but in that case,
> +	 * we don't use seed[1] anyway, as there is no virtual KASLR on 32-bit.
> +	 */
> +	*(unsigned long *)seed ^= kaslr_get_random_long("EFI");
> +}
> +
> +static void error(char *str)
> +{
> +	efi_warn("Decompression failed: %s\n", str);
> +}
> +
> +static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
> +{
> +	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
> +	unsigned long addr, alloc_size, entry;
> +	efi_status_t status;
> +	u32 seed[2] = {};
> +
> +	/* determine the required size of the allocation */
> +	alloc_size = ALIGN(max((unsigned long)output_len, kernel_total_size),
> +			   MIN_KERNEL_ALIGN);
> +
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
> +		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
> +
> +		efi_get_seed(seed, sizeof(seed));
> +
> +		virt_addr += (range * seed[1]) >> 32;
> +		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
> +	}
> +
> +	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
> +				  seed[0], EFI_LOADER_CODE,
> +				  EFI_X86_KERNEL_ALLOC_LIMIT);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	entry = decompress_kernel((void *)addr, virt_addr, error);
> +	if (entry == ULONG_MAX) {
> +		efi_free(alloc_size, addr);
> +		return EFI_LOAD_ERROR;
> +	}
> +
> +	*kernel_entry = addr + entry;
> +
> +	adjust_memory_range_protection(addr, kernel_total_size);
> +
> +	return EFI_SUCCESS;
> +}
> +
> +static void __noreturn enter_kernel(unsigned long kernel_addr,
> +				    struct boot_params *boot_params)
> +{
> +	/* enter decompressed kernel with boot_params pointer in RSI/ESI */
> +	asm("jmp *%0"::"r"(kernel_addr), "S"(boot_params));
> +
> +	unreachable();
> +}
> +
>   /*
> - * On success, we return the address of startup_32, which has potentially been
> - * relocated by efi_relocate_kernel.
> + * On success, we jump to the relocated kernel directly and never return.
>    * On failure, we exit to the firmware via efi_exit instead of returning.
>    */
> -asmlinkage unsigned long efi_main(efi_handle_t handle,
> -				  efi_system_table_t *sys_table_arg,
> -				  struct boot_params *boot_params)
> +asmlinkage void __noreturn efi_main(efi_handle_t handle,
> +				    efi_system_table_t *sys_table_arg,
> +				    struct boot_params *boot_params)
>   {
>   	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
> -	unsigned long bzimage_addr = (unsigned long)startup_32;
> -	unsigned long buffer_start, buffer_end;
>   	struct setup_header *hdr = &boot_params->hdr;
>   	const struct linux_efi_initrd *initrd = NULL;
> +	unsigned long kernel_entry;
>   	efi_status_t status;
>   
>   	efi_system_table = sys_table_arg;
> @@ -892,60 +924,6 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>   		goto fail;
>   	}
>   
> -	/*
> -	 * If the kernel isn't already loaded at a suitable address,
> -	 * relocate it.
> -	 *
> -	 * It must be loaded above LOAD_PHYSICAL_ADDR.
> -	 *
> -	 * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
> -	 * is defined as the macro MAXMEM, but unfortunately that is not a
> -	 * compile-time constant if 5-level paging is configured, so we instead
> -	 * define our own macro for use here.
> -	 *
> -	 * For 32-bit, the maximum address is complicated to figure out, for
> -	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
> -	 * KASLR uses.
> -	 *
> -	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
> -	 * loaded by LoadImage, but rather by a bootloader that called the
> -	 * handover entry. The reason we must always relocate in this case is
> -	 * to handle the case of systemd-boot booting a unified kernel image,
> -	 * which is a PE executable that contains the bzImage and an initrd as
> -	 * COFF sections. The initrd section is placed after the bzImage
> -	 * without ensuring that there are at least init_size bytes available
> -	 * for the bzImage, and thus the compressed kernel's startup code may
> -	 * overwrite the initrd unless it is moved out of the way.
> -	 */
> -
> -	buffer_start = ALIGN(bzimage_addr - image_offset,
> -			     hdr->kernel_alignment);
> -	buffer_end = buffer_start + hdr->init_size;
> -
> -	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
> -	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
> -	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
> -	    (image_offset == 0)) {
> -		extern char _bss[];
> -
> -		status = efi_relocate_kernel(&bzimage_addr,
> -					     (unsigned long)_bss - bzimage_addr,
> -					     hdr->init_size,
> -					     hdr->pref_address,
> -					     hdr->kernel_alignment,
> -					     LOAD_PHYSICAL_ADDR);
> -		if (status != EFI_SUCCESS) {
> -			efi_err("efi_relocate_kernel() failed!\n");
> -			goto fail;
> -		}
> -		/*
> -		 * Now that we've copied the kernel elsewhere, we no longer
> -		 * have a set up block before startup_32(), so reset image_offset
> -		 * to zero in case it was set earlier.
> -		 */
> -		image_offset = 0;
> -	}
> -
>   #ifdef CONFIG_CMDLINE_BOOL
>   	status = efi_parse_options(CONFIG_CMDLINE);
>   	if (status != EFI_SUCCESS) {
> @@ -963,6 +941,12 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>   		}
>   	}
>   
> +	status = efi_decompress_kernel(&kernel_entry);
> +	if (status != EFI_SUCCESS) {
> +		efi_err("Failed to decompress kernel\n");
> +		goto fail;
> +	}
> +
>   	/*
>   	 * At this point, an initrd may already have been loaded by the
>   	 * bootloader and passed via bootparams. We permit an initrd loaded
> @@ -1002,7 +986,7 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>   
>   	setup_efi_pci(boot_params);
>   
> -	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
> +	setup_quirks(boot_params);
>   
>   	status = exit_boot(boot_params, handle);
>   	if (status != EFI_SUCCESS) {
> @@ -1012,7 +996,7 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>   
>   	efi_5level_switch();
>   
> -	return bzimage_addr;
> +	enter_kernel(kernel_entry, boot_params);
>   fail:
>   	efi_err("efi_main() failed!\n");
>   
