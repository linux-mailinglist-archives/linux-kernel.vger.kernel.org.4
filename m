Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62773A98D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjFVUfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFVUfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:35:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2093.outbound.protection.outlook.com [40.107.243.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A3DC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI3gInA1XMR9Thfekp2hTD26hgaPiet1MAuXrwFTlyDQj/p6J3sSmprdn4OFZL07GFSZM/qDvmEBaXTVesrXWNm3WptHvcXtlWT1Cbjqp8VZ9bPp3H9qlbd2BUDzyjnbZhoC9SiUR/gx58r0eceba/Dt7GFr48p2yvT9kLV9vZevTz1f4yL2rgFb0s7XHgWNKIzifZHK3hoHZpeOJCpxBX+0ZBk2K3/Wp95qXzlQbm9Vj98XVF0qIQ0nrgZjaI4WzWFt6mFOIOzfyiTgoH8SyuvmgwAIuFcHAVVxnza/yN8qMSdRvmDwFoy550TXbSf+AuRP85fSI7vO0o1JG0ecwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuxxeb3AN2YcAB0osaist31d9B7xaTpbe6Z5cRQfrUw=;
 b=kXGW6zvK4YAW/cUE1sxFmcsvkJ8dADEepBF6PYQgvIY35zyREV7TmRQ38Jj3ew2F8SlB+8vzc8aQrxX00wNMz8mRLzHWgUTKik/MlafjN9WxjXEWpjbmlfRA9/1ifxBw/wvsf04j/kTZNkIKblXaudhTRH8lU2C5yKgqnC2/XaRlMLznqymb8XhOvVpkPr/6DdjZR8VK9wD7bYv775xb4BvqRzAV/6A8OOgGoX2tWNtZu3zyrKrsv2SbJNSedYySrJ7JTvJ3RLJNXDGIeQwoKwbIspfrmFJkaB1UxK8nEgt+RaTkOwi/soUtjXTSLoBPgjoTxu1kTTBnlv2gAkq1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuxxeb3AN2YcAB0osaist31d9B7xaTpbe6Z5cRQfrUw=;
 b=TprZOyen0lTlfcoixK61uuh3dMrzmi9YOEWfqVosqi82A6bHcmtpXrvlcJglUDZG3YPHcM21x62TKwX7fqWHxZOefPTh7hOkIgsox+LEHD+11U6Tu2Lixg5nUsMtds0aOnx99sGXZM75qzb+cR3Hix6oQk9bjfGf1eeUaF642Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 SA0PR01MB6218.prod.exchangelabs.com (2603:10b6:806:d8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.36; Thu, 22 Jun 2023 20:35:18 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 20:35:17 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <dvhart@amperecomputing.com>
Subject: Re: [PATCH v3] arm64: sdei: abort running SDEI handlers during crash
In-Reply-To: <20230607195546.2896-1-scott@os.amperecomputing.com>
References: <20230607195546.2896-1-scott@os.amperecomputing.com>
Date:   Thu, 22 Jun 2023 13:35:14 -0700
Message-ID: <86bkh7xmkd.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:610:11a::21) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|SA0PR01MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: c482afdd-84e8-458d-272d-08db736030bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpOrUSR0Fief7eSdXI7fJB3mDSHyGJmC3PSJKCLFMzBUiaWFtodf6P6bwfSFHbOiHxHE2f2xka6ieCeH/JTwbnsK7lt3rgfBxR6Is2VlET7vGAt49PkdbB6sLdeJMYtR92nB9qkiFCjyOG/oDLYWddukPbBox7GOzqLt+ucVmF2tuE6SducyqevdB7wryXy9UUh8dX1jXVHoYLA1oQUXYJqmsqFlWqRaszhQWTaH4NFnYrmciynG91Z1DP3sCdaCjquUIkbKlCAPwmGM4ydXJx7NpNfFHN2TEIFAlnWYcVVz17gCEIUigDBmO1s/cM9SsUdxwoNvkyyhkkIIY3Xg4YuWgsuHLucXJjYa5LmKMw50gT44huA2RjLwcuAtP4H7SHz4ntFrj1QZlk9g4hv3t+9z8R7hRu+O5g4HawIhIXYyhORkYt5houDI/Yv/gAcORK13yhzQpz+1NTR6u+VlqcQb1Iv+YUbBVrsv39ETpOFemHPiHnB7CRk7dCxWT9D1LPf52HKkZqW9WOmaySIv/8oYRwy/xRJYEwhJRpTgoTfRqjrcCZ3CeeS6yxk1IIX2cIK5uwdXZhNCXXFnZ9cs8q9Kr08rVs9zIaZzKZpDq4JcPB97QI2NG0EnKWq0F8gfaubFlSsPUKcmbRNoLyjs7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(451199021)(26005)(6666004)(4326008)(478600001)(54906003)(6512007)(9686003)(186003)(107886003)(6486002)(6506007)(2906002)(52116002)(966005)(8936002)(8676002)(66556008)(66476007)(66946007)(6916009)(316002)(41300700001)(5660300002)(86362001)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1i6dc7koMFkgQ05jUbMCPh1DDuaIZ/Bg4Tka5BG6Zex1TLgoLgEwogpiaUIu?=
 =?us-ascii?Q?zepAo3iEIlR93CNxQhn8IUs1WGL72QyCuRYyr6VpIVEzqbvgSP2Sqtfq2D99?=
 =?us-ascii?Q?zTMWnoaghp23ZhKf3Sjuc3BWjLEqfLuhLHVIifkYcqo71ONy4iHRUa7OM5na?=
 =?us-ascii?Q?WF9l8DspqWD8Y6n2zSRLMwsgvp9FpHkKr86Qe6YRX67CNwH//ccgchGH/HRo?=
 =?us-ascii?Q?X14D3EVPLT4T5eZ54+hn7rsKt88HaAPptWEGHFIqm2QJ8fw79QmxuG5nTNnZ?=
 =?us-ascii?Q?Jj/N95QaJpqBnuSg50URJftZekUahuOrFNaRDniakoh+TYFfDTs0lwW/PaWE?=
 =?us-ascii?Q?Ou+guvOfVy5qM9CJflp5HXAYLOIhuzMbSTvrj70umF72ZOwTrMH2fn5f3WCP?=
 =?us-ascii?Q?K5AJuHWwpFMq+UCpCYB97ZJOOsMQ6+lPamtnQ6D4CqUu4oBGHEKLw3rv0rlN?=
 =?us-ascii?Q?9C+T6x9coPMbyH+l5jvARMbacz8sblYb/SPDuLI2qGgwbD6Jcj9iKNhdL8sk?=
 =?us-ascii?Q?g3YdBsxFArPefTbaAFCC2bWLLIv5F3DX67X39bDsHVz7SkTVAEv4V3/UVveB?=
 =?us-ascii?Q?0b3KT8D6t0ljvSke5j++KEqDY89XBV0hEUhGwmMCfk+XRnTC4RyP5kzp4Nzi?=
 =?us-ascii?Q?O6tMD7VLKJh5S99c2uEHuKWCFwV9w8Y4UHCg1Vp8FJjsaGsnFuFyItLnLw6M?=
 =?us-ascii?Q?WmT5sHCJQCGw5nhvS19QvrHtkzqvo4UiVMF6SBmn6P7olfEOp8a1nyQwbh8x?=
 =?us-ascii?Q?Gj+ispljaE7xWz5jwz7YbSKS9WiI13UVaPu3hneOFscCsEdgZoLvIK/Z0jz7?=
 =?us-ascii?Q?Ga0sTOtLj4b0x8knuCBCU79pKY7SifTHETvlA5zo6bysPyxAub1Dz6KsEH4f?=
 =?us-ascii?Q?MtuROZrVKwrgQO8tEi8XZt44Kt2kwI45m5IZz2mYeoOJdSEFPvApa1nVl3oV?=
 =?us-ascii?Q?SIicug2888/6PGaGWPvchTMOpCRfj4mFtVzRbYdrD2NnEfuFQZMmhKE7tcTD?=
 =?us-ascii?Q?KYFYpQoljRNfGxNDj2/fUupKaBBstKQdupWSNjuVOKS/64pfNBCSwI9DKjWJ?=
 =?us-ascii?Q?O3Cg5cY/4yJsZTPLUX5c8EKCd6iCzBuCP1g1A26vLtT3I3TnGhYFON4OEsf+?=
 =?us-ascii?Q?/C0JqVReBg3wPiKTL3u/G7iTAyBaCV1fcRlWJwUi6L2uU+gWHjSdhsmXVbhD?=
 =?us-ascii?Q?AqU+OUkshi3U8+ViVgC5seuPd5hhr1LEr/bp04CXw2K6Y8Kkde83mU9SfY3g?=
 =?us-ascii?Q?rIgM6qVoBB/PicFXwI3469MDDsy838j8XJcjeDWH/qCUyU08cni9xUrXkwuo?=
 =?us-ascii?Q?EDNatoy69B6FBO632ow2YFsOPWpPFOdo003EtqDs6Z5spKo6+DaDMxKc4JVE?=
 =?us-ascii?Q?/amEKIzfCEnXnhn3mckVEXb/WQQSwqd/xgz56y4H09N42lwYBaJErnPA5HFI?=
 =?us-ascii?Q?4eGdc9+QiMgnl0grnv21JdRn6rg8eRvMouNx+YpEOfSwxq3DT1l3o+FrL/1Y?=
 =?us-ascii?Q?dakEMrEWNjoQogZIqgp/kJCtiXZthTqVS+5KwBuGUKQGJh4hyvKwo3DdTvdB?=
 =?us-ascii?Q?rJxsomGrdtTZOPWGsPqf9wfMVQhnYjd8MR7yWV+17eEai3ppF0jh0kL1hZZi?=
 =?us-ascii?Q?oXxqZ/+fw48A6Z6Q3F4myDI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c482afdd-84e8-458d-272d-08db736030bc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:35:17.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xwkm+vLNvQbzNCDH+xERCAv5c7JvmFlSG2iWx34oiaI46AiTsO44BNexGypQNBeLTzWHkNEvxBZmaNXCzg1j7T31pHC+fC2bi155tIXoRLlXIDiUw5b7m/n+0SARr6q2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6218
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
>
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.
>
> Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>

Ping on this one

> ---
>  Changes since v2:
>  - Dropped the patch fiddling with the sdei conduit.
>  v2 Link: https://lore.kernel.org/linux-arm-kernel/20230329202519.6110-1-scott@os.amperecomputing.com/
>
>  Changes since v1:
>  - Store the active SDEI event being handled per-cpu, use the per-cpu active
>    handler information to know when to abort.
>  - Add prints before attempting to abort sdei handlers.
>  v1 Link: https://lore.kernel.org/linux-arm-kernel/20230204000851.3871-1-scott@os.amperecomputing.com/
>
>  arch/arm64/include/asm/sdei.h |  8 ++++++++
>  arch/arm64/kernel/entry.S     | 25 +++++++++++++++++++++++++
>  arch/arm64/kernel/sdei.c      |  3 +++
>  arch/arm64/kernel/smp.c       | 27 +++++++++++++++++++++++----
>  4 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
> index 4292d9bafb9d..dc2f038a61ef 100644
> --- a/arch/arm64/include/asm/sdei.h
> +++ b/arch/arm64/include/asm/sdei.h
> @@ -17,6 +17,11 @@
>  
>  #include <asm/virt.h>
>  
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
> +DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
> +#endif
> +
>  extern unsigned long sdei_exit_mode;
>  
>  /* Software Delegated Exception entry point from firmware*/
> @@ -29,6 +34,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
>  						   unsigned long pc,
>  						   unsigned long pstate);
>  
> +/* Abort a running handler. Context is discarded. */
> +void sdei_handler_abort(void);
> +
>  /*
>   * The above entry point does the minimum to call C code. This function does
>   * anything else, before calling the driver.
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ab2a6e33c052..e49f72b5fb63 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1007,6 +1007,12 @@ SYM_CODE_START(__sdei_asm_handler)
>  	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
>  #endif
>  
> +	cbnz	w4, 1f
> +	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
> +	b	2f
> +1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
> +2:	str	x19, [x5]
> +
>  #ifdef CONFIG_VMAP_STACK
>  	/*
>  	 * entry.S may have been using sp as a scratch register, find whether
> @@ -1072,6 +1078,13 @@ SYM_CODE_START(__sdei_asm_handler)
>  
>  	ldr_l	x2, sdei_exit_mode
>  
> +	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
> +	cbnz	w3, 1f
> +	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
> +	b	2f
> +1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
> +2:	str	xzr, [x5]
> +
>  alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
>  	sdei_handler_exit exit_mode=x2
>  alternative_else_nop_endif
> @@ -1082,4 +1095,16 @@ alternative_else_nop_endif
>  #endif
>  SYM_CODE_END(__sdei_asm_handler)
>  NOKPROBE(__sdei_asm_handler)
> +
> +SYM_CODE_START(sdei_handler_abort)
> +	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
> +	adr	x1, 1f
> +	ldr_l	x2, sdei_exit_mode
> +	sdei_handler_exit exit_mode=x2
> +	// exit the handler and jump to the next instruction.
> +	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
> +1:	ret
> +SYM_CODE_END(sdei_handler_abort)
> +NOKPROBE(sdei_handler_abort)
> +
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index 830be01af32d..255d12f881c2 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -47,6 +47,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
>  DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
>  #endif
>  
> +DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
> +DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
> +
>  static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
>  {
>  	unsigned long *p;
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4e8327264255..ea1595b51590 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1047,10 +1047,8 @@ void crash_smp_send_stop(void)
>  	 * If this cpu is the only one alive at this point in time, online or
>  	 * not, there are no stop messages to be sent around, so just back out.
>  	 */
> -	if (num_other_online_cpus() == 0) {
> -		sdei_mask_local_cpu();
> -		return;
> -	}
> +	if (num_other_online_cpus() == 0)
> +		goto skip_ipi;
>  
>  	cpumask_copy(&mask, cpu_online_mask);
>  	cpumask_clear_cpu(smp_processor_id(), &mask);
> @@ -1069,7 +1067,28 @@ void crash_smp_send_stop(void)
>  		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
>  			cpumask_pr_args(&mask));
>  
> +skip_ipi:
>  	sdei_mask_local_cpu();
> +
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +	/*
> +	 * If the crash happened in an SDEI event handler then we need to
> +	 * finish the handler with the firmware so that we can have working
> +	 * interrupts in the crash kernel.
> +	 */
> +	if (__this_cpu_read(sdei_active_critical_event)) {
> +		pr_warn("SMP: stopped CPUs from SDEI critical event handler "
> +			"context, attempting to finish handler.\n");
> +		sdei_handler_abort();
> +		__this_cpu_write(sdei_active_critical_event, NULL);
> +	}
> +	if (__this_cpu_read(sdei_active_normal_event)) {
> +		pr_warn("SMP: stopped CPUs from SDEI normal event handler "
> +			"context, attempting to finish handler.\n");
> +		sdei_handler_abort();
> +		__this_cpu_write(sdei_active_normal_event, NULL);
> +	}
> +#endif
>  }
>  
>  bool smp_crash_stop_failed(void)
> -- 
> 2.40.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
