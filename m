Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAB718454
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjEaOK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjEaOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:10:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483D1987;
        Wed, 31 May 2023 07:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2BiljUrZZTfJBEcts5DmGB6ZjiptPo85N9xgBHJKUQdURejyS39JrMNDesCr9BufjhnmdticUpMACn41djJ0SNvY24fcuMJHggeISmaTiglgGCYOP8TiYkt1DY1T9QU/kYMR9snaoJjeREIr+3j4N6s4+C4Oy28gDSekttxF1XHO1raoJPCwgzlXP2i/MSsZvEprMx0Y2QmTcvtIu5XwQeUMax+b63H8UUDogi3Vr+47psZ0xusTDoX2zczAfjWdl866ic89Z+mn4UpoT8amFZaEZpmcjT1nkkWlNntoTAYjl+2/b9IDLkCCslwEyjfVJlBm76dTr4Pi8b/2LeRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtxROaJ2cZo1BV7fUmgud+j50U5EMZBzNTbpu4eKHKs=;
 b=boFmLhoOfD70+Cj0gkM7arlaF9/Ga/CEVomnbo6NpOezlE46R0jxdqzzwjTZOP3SRtsjemABK2DSuvVfkoHltIYy6hDmeZ60z8GvjMmZuFkz1CaHw894f4mHQO5JgrHFEZjPFKVplvVvHWUlTf4h8vCt9xckkR2RxyuWbDjdI5fJk4jEn3vEXEyUdzyRS/bGDpDx5PZxbczp0rfaboouzW36WYvBD/R4wg02kF1y4pmyo4ONrSg4Yl5fC1V2h/kVLu5OK6NUYoGOlTJ6GIWgtryGv6rCtc+gP9ZwRKOUOsyzyZCupLVwpNs4QeQuplP/Of3lkHhFBn5LdNvhK6zA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtxROaJ2cZo1BV7fUmgud+j50U5EMZBzNTbpu4eKHKs=;
 b=ns+3+TgGYV217fh/mknzE28XO0h8YNhAsk9S+KcdDqzGhF08unZOBnIYwEjkrQX0p2fgNu9Q07+fN+3Z79qLSPm4g2ElW8+Zw6Dt1u9wpuunWzVd14nXtxctA9iQgo5P90NNryrUE9vqRj4+7jHXcNla96BLuyl6V+VzEHGqWtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 13:58:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 13:58:48 +0000
Message-ID: <c4e8d060-deb5-bce9-cb65-cd0dc9ed7735@amd.com>
Date:   Wed, 31 May 2023 08:58:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch] x86/smpboot: Fix the parallel bringup decision
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name> <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name> <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx> <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name> <87wn0pizbl.ffs@tglx>
 <ZHYqwsCURnrFdsVm@google.com> <87leh5iom8.ffs@tglx>
 <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com> <871qiximen.ffs@tglx>
 <b6323987-059e-5396-20b9-8b6a1687e289@amd.com> <87ilc9gd2d.ffs@tglx>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <87ilc9gd2d.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9cb5d1-b8b6-422e-33eb-08db61df2755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzAmz9SFY2eJh6vMKmZxjFl0l64ppKu3/HM7wuk9+Rgg4pPEP1A8sYGCrSE6+jBmzowRfVDiClRSxCiYLN/cdMAGsCT0s6X+08EPYRm6bETMwmfYT4amLYITyeb0wpxgwBiLILYk+FMBkfeF8gb+OowQ91NNqiaXNscwPt3u9beogaKyxu5WXPJe0dWCKRNc5hHWZc3TnHWqpkeeyEWKx2v6CdRxagfTp7xtRdCxAiHo8LolmWL9E7G/WY5GiLszoEszQH+Wfh2bg9F4kqFDYQdqpcTpRAooePWwBni5ce/0YbXNYTjf2ozVQo/x+efpjaSd+8CAvt1kOYQz8oEwob8JAXc8Ro7c/pTKcVGZZI3mXPv8Ed4oWUzUCKu8/Duu/voPeQL3ydtE3aFg2IxdCIwWpVSCQ6Du/L1oM9uVAKbC7iICVq5H6nZuALVyBqQrJQHRcyKNhbmWiSnrVDK6C2REIUfsDLBv6+C3AlQ94v5+pK4wiWJrm7tIVTSivagLb3qIiXNZYK6Nd7VL2lgSrUtZWtvMllAAqkqVIuuKJCcteqqjqxBDjFAJ0xxCZCdQZoR/aVddFQsuSMjo9PRSU115U1lJnUjyiju0BMlRw9/H1Hhq7kQQ+IDQbFQizQxnPKIZa/U5RsrjeTbvZtOeXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199021)(6486002)(6666004)(478600001)(186003)(36756003)(53546011)(26005)(6506007)(6512007)(83380400001)(2616005)(38100700002)(86362001)(31696002)(4326008)(316002)(66556008)(66476007)(66946007)(41300700001)(2906002)(7406005)(7416002)(31686004)(5660300002)(110136005)(8936002)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGNoenZtcWtSa0Fnd3R6U3ExQkRaNzF5LzRFeCs5aFllTy9rUmVNRVJRbG5G?=
 =?utf-8?B?VG41TGlhd2hDNDB5OWNXVE9WTGFwVTNJaVp4NmJXTGZwMnhmV1VpeG9vR1VZ?=
 =?utf-8?B?RXVvMkNDRHZkNUFvelJzZ1ZlYmZaM2dsbzZVb3gwK2toNDF1NEh2UFRRQ0lm?=
 =?utf-8?B?TFZvWUFUU1FlNC93U2hWUVdvNjZpdENqYmxjZW41NGFqSFpWQ0NyME5relNN?=
 =?utf-8?B?RVpPbmh6M215V2FRNUk5c2EyTE9RcUZpUE5tSkowaElPTkxQcHNQZ0d1Zjg5?=
 =?utf-8?B?S2VXRmloYlVheFg2aVVkeXIrNGNnbjRlUFdibDZiUVFweGFjRU1uYVk5eFBO?=
 =?utf-8?B?SUdJakVsb0wyK2VGVFhicDgwRWRKa2tjUUZlSmRKQm9GTjhHSm0zOWhtNDZP?=
 =?utf-8?B?eEdLdXdKNVB4RU42dEhLOGJ4dmZaaDZZR3ZSbjhyU2lUNXBhSkVCMGlGM3d3?=
 =?utf-8?B?anpwTkJ5ZkVocWV1RVQ3a2xtMyt1eS9RZ2ZnR2xoWTJZWTMvMW1EUkJmVGdw?=
 =?utf-8?B?UGxXVjlKKzdjVHUzZ3VHTTdpYXFqMmt3ZXlDaUVBczIvSkMzRDJBWUNBTDE0?=
 =?utf-8?B?dWVaZGRwcmhad0VJUXJzZ29WaWhhTkhwdFdVakVLZ0ZvUmNIOU1pNmJ3aStC?=
 =?utf-8?B?Y3NyRU9sUXN1TnhDbWpBUXBnUkhiSWdGUXBucEUzdkhROGliTnlzZ3ZHQnNS?=
 =?utf-8?B?cEhrR0lyV2QydmczVkd2UzY5VmFkMjhKbFVlS1pFaS91TmNORkFrZ1g3MDlm?=
 =?utf-8?B?cWVZbVVGK053dDhLVTZVbVJwUFVOQnlHOXJxZHRyQ2lhTnh1REpzU2pqWUpz?=
 =?utf-8?B?bUZQQkNRRnpucjVuZE4wS1phM09IejlUVllrcUFrckRVMG11RjBSTVhMZmsv?=
 =?utf-8?B?RjJMbHhYY0ZRMldpeXREZEo3Tm5zWjhYZjlmTGZKNXNkOTFmUkpoYm03Ykxh?=
 =?utf-8?B?aXN1U3BWQnhJd09CZEkxNDlQZTB1ZW5TSElaaCtPVk80T0tiUktEY2gxbXUw?=
 =?utf-8?B?ZVMrSm9DRWFjSE9xeG5nZk1XVHplUjRtU1lkaUhPSGtCUEpwY1BRcXdYRTJ5?=
 =?utf-8?B?V3kvZXdmRG5lZTI4V0hjd1lzMTJZbUxWa3lRSGpnbnNsNXhncFVnRnJrSnRk?=
 =?utf-8?B?VC9LUW9Pb0NyTW1ZNWtVS1JNRnJRWkFiZUhKenBIQXJvQVB5SGpYWUlOckR6?=
 =?utf-8?B?aVFOV2N5ek84RVphNXI2aTU2MFZRL2p6QUpjSG1iajM2RjFPcHlSdktsRjN5?=
 =?utf-8?B?azlndWkreDlFUkpkSFZaWlp3UlFFOWhYV1l2ZUpUR24vMUlPb2tOZ01HUU40?=
 =?utf-8?B?akptYjh2RkRBOXVKazU5dWpIM1lTTjRmU1lPUG9jcmpWdVpKbitiMG1PY3Ir?=
 =?utf-8?B?TzFMWExnS2tJT3dBdk5xN0YzMjVSd3VNdGx2VnVuS2lhM0IzdkpSWkhib2VI?=
 =?utf-8?B?cUFpcDBXK3pNY0NEd0tLeTQ5SmJRcU5JeHR4WjNxT1RhaUZib3JzZ3FQdGtv?=
 =?utf-8?B?Wis4VUVCVTlIOStqRUxna1JtcVplMTRHZm9PeU0yRmI1OHY0cDR6Vk9OSXpE?=
 =?utf-8?B?U0FlcE5yWHpabEtnSVRhRHJuMUF5RTlVMXJaazBZS081SjVKb0hxWVkrVjNa?=
 =?utf-8?B?KzRYcFV3aHoxMnM3WUtYb0ticTM1UVM1SGFwQVN3M2N1S1pkMzZCQXU3Wmpu?=
 =?utf-8?B?V3E0V0paZmxRd2dWa05xOEZWVDMzUGJDOXZ6ZjNIdnFmQzBranY2VWU1bnZU?=
 =?utf-8?B?cVA3d0NxQVZLU0tRUEMzbzArQUxXL0UyWlFldnArTktmRi9iYmVwdjB5ZENR?=
 =?utf-8?B?QWlaWDVFbEFNekhZWVBJcE9XZER2VmpudUR5UkQ3VkdFeEJHdk5CbTdDbFRL?=
 =?utf-8?B?L0VKMFh1b05ObkRqNWNvYUpxN1V5SkZPSVhFN2Z0bzVXeDRsUXVqcmJsNWk3?=
 =?utf-8?B?K0ZHWlZOUVRtdStHOFJBMDhSUGU1VUdnZ1FWQURRM09ocVJKNXFMRVBlUk1J?=
 =?utf-8?B?dWpXSmFEaWRqYnBkbkp6d0J6d0VrRzRobzBWQnpoTGJOQ1VxYndYYWNsRlNx?=
 =?utf-8?B?ZHJhbmExVFNoVXhJUEhqUlpZYUswMjd2dTB3MDlhV25OWDdnQUlnMUlGTHdY?=
 =?utf-8?Q?N80BHVCoJMzH+lm69lWrGA3GD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9cb5d1-b8b6-422e-33eb-08db61df2755
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:58:47.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88Y4Jy7srjnspesxLBMjsqFOTBNL9rgFVHeVNC0hsaZzxgwsRjwVWWFOSAH8I9y4LORY8ikBNHMwAi2nZedIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 02:44, Thomas Gleixner wrote:
> The decision to allow parallel bringup of secondary CPUs checks
> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
> parallel bootup because accessing the local APIC is intercepted and raises
> a #VC or #VE, which cannot be handled at that point.
> 
> The check works correctly, but only for AMD encrypted guests. TDX does not
> set that flag.
> 
> As there is no real connection between CC attributes and the inability to
> support parallel bringup, replace this with a generic control flag in
> x86_cpuinit and let SEV-ES and TDX init code disable it.
> 
> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Still works for SEV-ES/SEV-SNP with parallel boot properly disabled.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/coco/tdx/tdx.c         |   11 +++++++++++
>   arch/x86/include/asm/x86_init.h |    3 +++
>   arch/x86/kernel/smpboot.c       |   19 ++-----------------
>   arch/x86/kernel/x86_init.c      |    1 +
>   arch/x86/mm/mem_encrypt_amd.c   |   15 +++++++++++++++
>   5 files changed, 32 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -871,5 +871,16 @@ void __init tdx_early_init(void)
>   	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
>   	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>   
> +	/*
> +	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
> +	 * bringup low level code. That raises #VE which cannot be handled
> +	 * there.
> +	 *
> +	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
> +	 * implemented seperately in the low level startup ASM code.
> +	 * Until that is in place, disable parallel bringup for TDX.
> +	 */
> +	x86_cpuinit.parallel_bringup = false;
> +
>   	pr_info("Guest detected\n");
>   }
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -177,11 +177,14 @@ struct x86_init_ops {
>    * struct x86_cpuinit_ops - platform specific cpu hotplug setups
>    * @setup_percpu_clockev:	set up the per cpu clock event device
>    * @early_percpu_clock_init:	early init of the per cpu clock event device
> + * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
> + * @parallel_bringup:		Parallel bringup control
>    */
>   struct x86_cpuinit_ops {
>   	void (*setup_percpu_clockev)(void);
>   	void (*early_percpu_clock_init)(void);
>   	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
> +	bool parallel_bringup;
>   };
>   
>   struct timespec64;
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1267,23 +1267,8 @@ void __init smp_prepare_cpus_common(void
>   /* Establish whether parallel bringup can be supported. */
>   bool __init arch_cpuhp_init_parallel_bringup(void)
>   {
> -	/*
> -	 * Encrypted guests require special handling. They enforce X2APIC
> -	 * mode but the RDMSR to read the APIC ID is intercepted and raises
> -	 * #VC or #VE which cannot be handled in the early startup code.
> -	 *
> -	 * AMD-SEV does not provide a RDMSR GHCB protocol so the early
> -	 * startup code cannot directly communicate with the secure
> -	 * firmware. The alternative solution to retrieve the APIC ID via
> -	 * CPUID(0xb), which is covered by the GHCB protocol, is not viable
> -	 * either because there is no enforcement of the CPUID(0xb)
> -	 * provided "initial" APIC ID to be the same as the real APIC ID.
> -	 *
> -	 * Intel-TDX has a secure RDMSR hypercall, but that needs to be
> -	 * implemented seperately in the low level startup ASM code.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
> -		pr_info("Parallel CPU startup disabled due to guest state encryption\n");
> +	if (!x86_cpuinit.parallel_bringup) {
> +		pr_info("Parallel CPU startup disabled by the platform\n");
>   		return false;
>   	}
>   
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -126,6 +126,7 @@ struct x86_init_ops x86_init __initdata
>   struct x86_cpuinit_ops x86_cpuinit = {
>   	.early_percpu_clock_init	= x86_init_noop,
>   	.setup_percpu_clockev		= setup_secondary_APIC_clock,
> +	.parallel_bringup		= true,
>   };
>   
>   static void default_nmi_init(void) { };
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -501,6 +501,21 @@ void __init sme_early_init(void)
>   	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
>   	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
>   	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
> +
> +	/*
> +	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
> +	 * parallel bringup low level code. That raises #VC which cannot be
> +	 * handled there.
> +	 * It does not provide a RDMSR GHCB protocol so the early startup
> +	 * code cannot directly communicate with the secure firmware. The
> +	 * alternative solution to retrieve the APIC ID via CPUID(0xb),
> +	 * which is covered by the GHCB protocol, is not viable either
> +	 * because there is no enforcement of the CPUID(0xb) provided
> +	 * "initial" APIC ID to be the same as the real APIC ID.
> +	 * Disable parallel bootup.
> +	 */
> +	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
> +		x86_cpuinit.parallel_bringup = false;
>   }
>   
>   void __init mem_encrypt_free_decrypted_mem(void)
