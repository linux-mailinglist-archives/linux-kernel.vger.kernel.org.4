Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE9716E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjE3UEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjE3UDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:03:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D161F3;
        Tue, 30 May 2023 13:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4hPXa1YSSIBa5fuNUv0Fb9MsU3P88rj1MtibQvafk1fFfTJRvnnlLd0+wpGgpf2kuQLm9A1wP2FmhpW3AslmOmwGJaViV+82+I3RgREJaM0w2QB0oixOP3cleR3gtzf3P4jPPvRzHIwlG1NjlsyAIqYF9cbFo9xJ04ZE5YPdU4yH2t/ntCcKuSpo39ZBA+jbhDJkY1X/kXFKeRWyVj6N7rnB0Di+rx5NSUFASFKUAG8p2WswYBi33ZBqUVBaefkvgukoaEX8GKrU+3PeGOQ36150G//LgRAPbXrapOhlo4GsIADDm6da7wBFICe6/evxxEfDYPeNWAUrLrbb1UXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl+OYljQD4C9LS/PzvACvwX/9iw88kYN01a9458Wsa0=;
 b=PoGap6j+woQx2OBpHhbBKLtN+0MWqqbMct5QmnApQafM7oOp6swFNqGsAEz56zK8VQ7MrTuBaZXmPk3fGkjzdv1HaMAP1gI5LPBi97wLCFJQJe7wpiKQUNUU99RkYNRUHR2za8HRbs87tDkrGomaDqO0ciDyfHL9YATM0qpqkgw88cl8DCA9303O9s6RRnbEfee1JbV9VfhyJb0NNor+s9b2mvJWwRc8rqQIZkApDXD2lzADKC5WmqDCQ6IdVzr3Fv5abgepluyCn+Jmxn/CdAk5q6TXHNJCIKxZ5IXilTl/XtNyiA2GKvP5nOlzLVj7JXIDKveNPLzxFc/mjY3rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl+OYljQD4C9LS/PzvACvwX/9iw88kYN01a9458Wsa0=;
 b=Kl+ZJkKSWJ7x4s4+l/VFfZ154Z7NK6RFcrwrBEywZAiMAtYBBu9b1oil6q5JPckk6YYq+jz4HtXwz6MzXD7MWQuMYOuCZfvwnjnj1fSArKVIqsGvAfBbIF28GFFFpxXWNmgwNEGXDwjb/VcP7OoT77LACTZjOD0xlX5ISEWJWzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 20:03:44 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 20:03:44 +0000
Message-ID: <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com>
Date:   Tue, 30 May 2023 15:03:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <87leh5iom8.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a28d12-c18a-4b27-6fb2-08db6148f884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkuw3U47JZGOMBiso4u2EISSINBIxZTeKi1Cf92rI/a1L2X6rtvDckWexW34yz0JJqpHgIkov9Kxte6+A5O9bjt28aduBFwBLA9R7TQdtTVivc3GGOEjINC1goae2531T3dUep2vcJwUXhLo7ApMEJ0i5dv7Jlot2+3ePuD4shV6g5tNz85FrR99yAiXXKjy7w5nyZYFbvMIfvi3ocK4mjtK+z5jG/68IIp8CtKhFjSuLLnhe0etGRW9H6aHbQHf4u40osE45j+8MihASescGzhC2x9w/rrJbzy3X08IxkaKE5IscQMkEMty5RCbXUBT0zuy9ktU/bxGvrmXUCGI18mIzG3+TZIVf6ECP+xtTXBLAo6n8Mh958ih8CepKrmNx4Xm+LhDGUw+GpfN7Ztaq3sxS+6GdeOIZHchqJXzET/E9obNM6Z3/zE+ltU34L4hEa+qU+/h6G2wKh/M3+1hGirqcwSVEql7XAWAezCR4ldGfeJ+TckNPNLy2+BhXY+gD060HB10yBxsngQFiYh7nhN9p+cxboPRw+eV1KcB8Ku7O1f3K4Yv0fI7a0sdP05Hm/RQ52GgjZk3HXxcmZs43jRugKAsHdEoVwrrQgWxYck63IrP0td3al2stp+nwlCFh0/QJbLSHi0rpNkO4rWRyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(316002)(6666004)(38100700002)(41300700001)(6486002)(36756003)(478600001)(7406005)(7416002)(86362001)(2906002)(31696002)(2616005)(186003)(83380400001)(31686004)(6512007)(6506007)(110136005)(5660300002)(4326008)(26005)(53546011)(54906003)(66556008)(66476007)(8676002)(66946007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU8rNG9wNUN5YzZDZFhPTWRZN2xpSHJYYkNYblM5elp5RXU1OGdVOUkzYks1?=
 =?utf-8?B?S3pkcWR6TDhWWHQwR3ZVUWxuM2ZpNFNnUU82SnRua05YTDdLcGNsc25vK3J4?=
 =?utf-8?B?WFZvNmt5c3g5THZRbDBtWnFzeGREWlV1dldCSDV4VTdVQmxOT0k1L2RaZVZY?=
 =?utf-8?B?L3dkUnE3cU9vRkdMcXQ1QXlOdmM5VjdNWHJnZnhyUmdveGJYZWZMK2JDZzAv?=
 =?utf-8?B?OHJhbVB6OWY1SGpSQ1NXbDZkY2NJRGpHQWJVVnJLc1M4eXBtR3lBMTE2YmxU?=
 =?utf-8?B?MExXV2ViVHd5cGpaMExDQnlrc0NLVFNtQjlvN0JYbVIyTWJVbmZKRmVGQ1Uz?=
 =?utf-8?B?Nm5vVTV4WGx5MU5Udjc1ZGN3WEdyaEx5UVcwNWhlTmwranArUHBJU3ZyUWZZ?=
 =?utf-8?B?WGRkQ3Q5NGhHYS9tVC9iQ3RHamU1b3pWN2dHRjJUY2k2VlEvSTd4cjhQc2JT?=
 =?utf-8?B?Z2l2QXl5SitmZE4yajh4aWxOU2tkQVFSOVRHTlN6UnZjWkxUaHlvbWtjSUlV?=
 =?utf-8?B?MHJqMThlRVRRUjEveXI0N1hXY3JtZmJpY2FuTEhOSjlONmJ0c1NCaUtwT251?=
 =?utf-8?B?eEhIdGprTUJzaVRMNDNReVR5V1BtRUllOVdManR2bnNLcGtleVZDTzJwODN1?=
 =?utf-8?B?SS9XTGYyb3lXZVRXank5V2sxZEdmTzVzcSs0TkZGL1Y0T1pTT3pvazN2NFJl?=
 =?utf-8?B?WGh3Wk5aY2VjOUZTYWZucEJaK0ZST1NHY3FpQnNsQ250Zkc4Vk1nQy9HaUUv?=
 =?utf-8?B?Q1dYNlhyMDRWR1NTUTl0cVl4bmgreFFUckRvRVAvMW1LWU5IakRORFhOV0Ex?=
 =?utf-8?B?SEgweGt0V2kxdXV0Q25FcWE0aU1YVXpsVGN1K2k2ZnM0ZzZNeE5QNlRKdUlQ?=
 =?utf-8?B?dkxRUnY2ZFRDb2diVlVLQmIzRVJZN0NDNnZkUXN1U01nOWRUS01FWjZGZ0I0?=
 =?utf-8?B?YWVLbXorZjJtS294cG1XeVVpb0w2Q1Y3bitSTUhzbU91cnNob3RrRWNyaXpm?=
 =?utf-8?B?OXJzeVpldmd1NWt0TW5FejloV1E2WWNqcFUzYTlQUnBiQURoc1FxZnlLNjVL?=
 =?utf-8?B?aktsT21pU3g5Rk8wQ0pCUTF2S0twVHgzaWRVRStRM0tMTDlRdngraE1NTy9Y?=
 =?utf-8?B?eS9tajZFaFZPSDZMTUVhY085cGF4SG83dlpSN1lLdXhoaDVBQWN5NEY1dk16?=
 =?utf-8?B?Q1pva21ZRVVWRzdBVGd5YWNqR2RZYlc3bXBqQzY3VCtUVVhsVnQzeWlTYU1w?=
 =?utf-8?B?RE9CRDNyMWdoeFQ3S1VkWnR1UDRqV2oyclcyWGxJclhoZHY3dlZmbDVDalFa?=
 =?utf-8?B?bk11eVdlQnFDQWlDbzdvSDNxLzVqR1Y1eFlVYS95ZHhrN241V2JOK1BveHQ0?=
 =?utf-8?B?SmllNm5xVHhXblBaeUZUYVIxcTFiamhLem1XaHdycWRCbW5WeFpEQ25waHAw?=
 =?utf-8?B?Y2R2YXdMYnd3c1FBU3Q0S1FqOFowQVVpVWtMNDZzNm0yb2pxSGs1d0NGZWtt?=
 =?utf-8?B?ek80eHJqVkFzZzExYWNVek9VY3VUWm0weWt2MXBCb0dzWXFlY2hISmh4ZXVY?=
 =?utf-8?B?RjlqZFJ4ekNBZ3RlUnJhaWZmL3RoaGh5eXQzRW5hdDlteVM0bWRyTHBtSzQv?=
 =?utf-8?B?RkN5Z3E5bDFMKzN0bXpYSDhDSUFGVnhYVXgzSHRrdzlqT28ydFZ2R0NweTMw?=
 =?utf-8?B?RFI0dHJXTUdBL0ZjQVdkSmoyeGdsYXNlSVA3dnFUVVArR0pMSk1RcVhNVitM?=
 =?utf-8?B?L1gxOUZHNmxUQ2xrVEsvZE1vYy90ZFhqWkExVVgvbVN0WVQyQXQwQnJucEZ2?=
 =?utf-8?B?bHlZbGdKOGorOFZMaVIxMS9xRy9Ec2lTRTNNeGFFM3FDejF0ditJbHRFdGVo?=
 =?utf-8?B?aVFuMldSU3lqeWdLbFRIYkhQc3JiY2p1dWxMajdIWU9MUVo2SUhGdHpLRFho?=
 =?utf-8?B?M2ZsODhpWURTRWZmZWszWjM3czdrUXE4eG5uckt3bDlXTHlRazgxKzZvZGZH?=
 =?utf-8?B?VjM2bUxTUE1RUFRybFhDQ0lFbTJjdVgzK2YxaEJIT0hnQ051V05TbXo4ZVFJ?=
 =?utf-8?B?eDdvVE10THdkWlc1blpLRkpkL2lzam1OWm82blo5cGI3MmhwKzlGZ0dZb095?=
 =?utf-8?Q?qQoP6+yBoDjs0UKQbfGHQcD0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a28d12-c18a-4b27-6fb2-08db6148f884
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 20:03:44.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgYQExJGs99BJ7SAy++R+HNsumPeMSNB7pUuIBtjQITEK/DyzCxa7KE4G8CnxYJqvrym+6sNkJedUrrwcXbSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 14:51, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 09:56, Sean Christopherson wrote:
>> On Tue, May 30, 2023, Thomas Gleixner wrote:
>>> On Tue, May 30 2023 at 15:29, Kirill A. Shutemov wrote:
>>>> On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
>>>>> The decision to allow parallel bringup of secondary CPUs checks
>>>>> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
>>>>> parallel bootup because accessing the local APIC is intercepted and raises
>>>>> a #VC or #VE, which cannot be handled at that point.
>>>>>
>>>>> The check works correctly, but only for AMD encrypted guests. TDX does not
>>>>> set that flag.
>>>>>
>>>>> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
>>>>> definitely works for both AMD and Intel.
>>>>
>>>> It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
>>>> report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
>>>> we want it.
>>>
>>> Right. Did not think about that.
>>>
>>> But the same way is CC_ATTR_GUEST_MEM_ENCRYPT overbroad for AMD. Only
>>> SEV-ES traps RDMSR if I'm understandig that maze correctly.
>>
>> Ya, regular SEV doesn't encrypt register state.
> 
> That aside. From a semantical POV making this decision about parallel
> bootup based on some magic CC encryption attribute is questionable.
> 
> I'm tending to just do the below and make this CC agnostic (except that
> I couldn't find the right spot for SEV-ES to clear that flag.)

Maybe in sme_sev_setup_real_mode() in arch/x86/realmode/init.c? You could 
clear the flag within the CC_ATTR_GUEST_STATE_ENCRYPT check.

Thanks,
Tom

> 
> Thanks,
> 
>          tglx
> ---
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -871,5 +871,7 @@ void __init tdx_early_init(void)
>   	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
>   	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>   
> +	x86_cpuinit.parallel_bringup = false;
> +
>   	pr_info("Guest detected\n");
>   }
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -2,6 +2,7 @@
>   #ifndef _ASM_X86_PLATFORM_H
>   #define _ASM_X86_PLATFORM_H
>   
> +#include <linux/bits.h>
>   #include <asm/bootparam.h>
>   
>   struct ghcb;
> @@ -177,11 +178,14 @@ struct x86_init_ops {
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
> @@ -1287,6 +1287,11 @@ bool __init arch_cpuhp_init_parallel_bri
>   		return false;
>   	}
>   
> +	if (!x86_cpuinit.parallel_bringup) {
> +		pr_info("Parallel CPU startup disabled by the platform\n");
> +		return false;
> +	}
> +
>   	smpboot_control = STARTUP_READ_APICID;
>   	pr_debug("Parallel CPU startup enabled: 0x%08x\n", smpboot_control);
>   	return true;
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
