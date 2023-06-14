Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732267308A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjFNTnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjFNTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:43:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565E2738
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686771772; x=1718307772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tJiEKMHVVj45mFzkYaIvCRNFEzrRTZCXMm0kfEnkvBA=;
  b=mM4PHkMdQjkbv9BL2qHW92cSbF+KtV3/6kzTDIsmoUTfJ2rPcZPdDKmi
   +dtVveT2r5DNtjuK5hwJ2dfTkQV110+I/F/H1V0x/iqm+v7jxVYCL3bTX
   MfcU3S7q76KnCAU2wCQIHRMB1R4TaJlh73NBNjAsvGkDmR5N46D5cpgjh
   L2xI6Co7LYiFf2ZY18Bjae+vGAm618n7owdLXpv+6/ur3LkUSgf4W5cbS
   92DY9Dny741Fhcb10DZD6/rCxwW30pGjT8yCYz12lvrln024+43oHIK2v
   DoMxEBy9MDrWgOgbaBQ8o5VfryQ3liOgHlOAJ7JAdKsJVK9kiBh+9wv6k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362097672"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362097672"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715332238"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="715332238"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 12:42:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 12:42:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 12:42:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 12:42:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 12:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGf+O6cy5fYHsV8yHmYPt2pO2Mav83bkS98MhUauRHupFxwZ704RWA+Vj3FonF8fVlBD9DY3I178tgUkVCFJDDTGlLuPvWuEejrHV03w9dPVoXEzjI/3cpKn/juyOb2X6Px2BDoN3nJcpGac9nwl7KkhpLzLz0QY7TvZXpLiIGvoWtGXUhYEFVT8qzwruHX55bTdWHiTxezs/ImRy0QhVozuUYfuqOwYj4agXcbdM3WYnqmarAvECj7Qd8umhXpyTYDd6wThMrEH2ZhQQHvCLr/XtKJOCr4Znzdz9VuCyhBnSCy5jAQw+x7t5Mbj/wrv0LDmo4fP4GF/S3IDYkR2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWRQOFXXV45ev3XTz4qlehzqvgd7L2kxShK0fKHJs/0=;
 b=cOehYgQ7NeKFHv/rdGADisRSA4a/mL06/xb+ffVmBoCvDMkIvqRGsqowltZqY2TZSW5q1gptIzhnFH2LWFwbAQx7JXjRawnOljepoJph5tda4jdan2F2xbFkuStSARHrbzQfjN8J91+z4TFNPm7uK/4BfZiamskqgnFLUypT4jRybdHJUjEANwbhb4vObIRSG0N5V3gPk2ovLXi/TWjNJaOuFMORENgz8lRHwFsIFJeDq2llkkg79iTC8Mf2W5BlQPZKP9AzCpU7M+KkxYW1/YaSKxZc3E1AJ1EFuvZgpbhcTHiMgEsu03NdqDbFRE5OghkRXGwvVZEP8cvAnVPnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 19:42:48 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 19:42:47 +0000
Date:   Wed, 14 Jun 2023 12:42:41 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 1/8] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZIoYMakfbAU9EOjc@a4bf019067fa.jf.intel.com>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.639116359@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230613121615.639116359@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: d93f7131-a245-4367-e081-08db6d0f876c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RizrXHbRIg6qmaDCZAboqOLWhkR1RI4g2ONvezRZds4F3J95ihszYacFmZZk20m9qkyIgdwATuSf/6/qVBpACxSwa4maLF3HltMYu8Rrzoml+XO5EPcG6i/5HOuCiZT7GZORGIE1gZewlMm8gx65wujO1N4BUz3ZlvIg3kNSpdJfGvvcYAdollt25FWM7PgwG5c0Gqh5OnnMbbXOavRj55Lw/GMVinWdGB8BDT9pHDdo9Du41K1kWegNYVcLiKQ+jdLDiHxoj/1LExrkTfE/wVTE5t5QDsjq4aUwAVNWuHbLZVbM+lo81ZqvxDe6r4Cdv1JzL1bJNLOsNNzabSCch2K74Q1BRD+eCEP3pLAvsHgVaW8uSx8/SxF+Vb+d6G9Qqs+GYh4OrhyMH9AumAdiw10ynsZkN+iuy5V2/g9WuesAJrdAlRQDi6OJsEXL4BwR65tuIYjAeqA8EOR8aH4Aze0mWURuvkiBnIsxvrNBeNG836fQQ2iB2FO/oVwHJNZzg6uhsLbBCZZ0Ddp+JFTMNKqd+dFiZRaaLrHFt6Kp+r4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(2906002)(86362001)(44832011)(966005)(6666004)(6486002)(186003)(83380400001)(6512007)(5660300002)(26005)(6506007)(82960400001)(478600001)(54906003)(6916009)(66946007)(66556008)(4326008)(66476007)(316002)(38100700002)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zw/j1NxAylURqjUBbtVhtp2l5Y8K1qWmjyPUB5mKgZjzRQ+UDSamUbJtF+eF?=
 =?us-ascii?Q?Mv0YgY/Nb1L8fBUyP0soJdXrvPliQpV+n4XbRfiUFLAYPzyibZLR/eag/ZCv?=
 =?us-ascii?Q?p0nNqaU+ZDUj4IHdSghwvwmIVBS97/qtSiVVelcsAZ1p7ERToutm9S3kILhJ?=
 =?us-ascii?Q?dOKOT/GtAj4/BerQyj1fzsYoK5XsjHJ9iwqiR/42Mx7qHlabb3B0kxzXASGg?=
 =?us-ascii?Q?/AP0c9sVAdFXd6NvcIyZKX+F0kaX7JhWkkQWF7J01qNTJAUHxl9q9+BgvPB1?=
 =?us-ascii?Q?iwpjY36AJY3I54z20vQUadgQ0OwhkT5Z4XfxUFM34IEtxo15Kkf5ds992APz?=
 =?us-ascii?Q?iZnOLkzcpT2iFkSNU/wCvV60eIfSmqLFXnqEbKYCDhOHTUGwSQzpxTaOWQ8d?=
 =?us-ascii?Q?ZOjAC+lZ4bT0w3aGgYGrhZC3XQjzmJGX0vV4cJn1BQ5NuP2DGnEUR8w9Cb2D?=
 =?us-ascii?Q?7ihnGPsEEgUjn6QngJiR6NPPmR5M+ixTRV7CksXqGixktoBfFjKknffjLAuK?=
 =?us-ascii?Q?uT+M0GSNZr8zhMurUGSd4OoR6CYT/8DaA2dVbdrYqDFljHjq6wU80YWmryH8?=
 =?us-ascii?Q?ZiMF9/b3QFFwLnNH8eQMS0pJyTLa0G9ekWj0qvkMJckY/MLssYFpml878fHa?=
 =?us-ascii?Q?RuHn0ekhDmXO1nfjfjA8jOIl1Xin/U6CgKyhDw32m38Udpa8lwUXNT4XN1Mk?=
 =?us-ascii?Q?De3MAF2sv+Gxt+gRMLXMAkSLnwyQ4RWcBkN5hLxNIWpElhNIvqA82AGiwRoC?=
 =?us-ascii?Q?7Rd0dGEjy5SkHWjEZTk0paa+gZa1Y7Wtb1Q0uox9x6ttUENXXYkEzljy4qKl?=
 =?us-ascii?Q?Nc1dCM33ZywyvgRx9q38MoQ7NCLP1thzC4CMR1JVaRef5XnrYF33FwaA9Px5?=
 =?us-ascii?Q?TVVaTdQ8FP0TmOgFrIopN44xPTsf51kf3C5udcp9rDQjtzNsMTqkPKts0Au8?=
 =?us-ascii?Q?QoHSzrsYpy/zSeGkbd1eI2MN4bfBwhza+63okoiiC1oGKD4KvnEZaQQsrGr2?=
 =?us-ascii?Q?nr+KzFiLArVCFf0p9xOZe4B3pWpzpYPRwCJTdZMd3OKTq8tTXWovRko2JvZz?=
 =?us-ascii?Q?DrQEuO9Nrw9Wu0HNUpX+7iTUIXnnmqcPBxI6qG9B+YHOYDS35gGucTwBavST?=
 =?us-ascii?Q?43b4VnOxYSpWrvP/MDyv3ngMeFxiPvJ2RHx2nF7bb2jOY40nQKHSjGwv6Sdd?=
 =?us-ascii?Q?iHmPIvK3JNjrbP8uDvjLPspPYDRLnYq6L1oxkpDhtvfSUxSH14Tq4bijHnFO?=
 =?us-ascii?Q?NGsBRotm5OiOJC5j3Z4hw9a/dLDXq8nIXZcw3h93DSYNVrvRIO9ww5/5ob8r?=
 =?us-ascii?Q?987Z9JD59mre8CTJhOOMp1OGzt72cr/QWNZN4YjpYZ4YQU0dBafqOc3UvHNh?=
 =?us-ascii?Q?p1xdnYtURAsSWjJo/cH4GcF5viC4Z0Lo3crRQ63eBzFNfmSHXENMSe+GRLiv?=
 =?us-ascii?Q?XLyptzkQoOE2zg0j6jqYoN7wuipbmuWyV/CuoGoX7uiTXw30/dIwcBWbDno8?=
 =?us-ascii?Q?lK24X0IwW6qO7xxVA3rj7bDcU5DUW2CcTN+ZOmnnkxONYLWJSerOY8XA0WE2?=
 =?us-ascii?Q?7+xG3Ky7O1ZH7JtUcBKQKJt6toiKShW9gOcSXhuZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d93f7131-a245-4367-e081-08db6d0f876c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 19:42:46.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jr+F1C5LObaHstFyxV/PsL+ZYwFuaSNeABZU/A5XYBQnWt/suVoKxwBTPfJDA0mWMnpGyvy2Ty+JBiMsND8ayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Jun 13, 2023 at 02:17:55PM +0200, Thomas Gleixner wrote:
> Tony reported intermittent lockups on poweroff. His analysis identified the
> wbinvd() in stop_this_cpu() as the culprit. This was added to ensure that
> on SME enabled machines a kexec() does not leave any stale data in the
> caches when switching from encrypted to non-encrypted mode or vice versa.
> 
> That wbindv() is conditional on the SME feature bit which is read directly
> from CPUID. But that readout does not check whether the CPUID leaf is
> available or not. If it's not available the CPU will return the value of
> the highest supported leaf instead. Depending on the content the "SME" bit
> might be set or not.
> 
> That's incorrect but harmless. Making the CPUID readout conditional makes
> the observed hangs go away, but it does not fix the underlying problem:
> 
> CPU0					CPU1
> 
>  stop_other_cpus()
>    send_IPIs(REBOOT);			stop_this_cpu()
>    while (num_online_cpus() > 1);         set_online(false);
>    proceed... -> hang
> 				          wbinvd()
> 
> WBINVD is an expensive operation and if multiple CPUs issue it at the same
> time the resulting delays are even larger.

Is this situation similar to what happened with the unexpected wakeups from
mwait_play_dead()? 

i.e the wbinvd() takes a while, and when CPU0 moves ahead, the previous
kernel marches past the wbinvd() instruction since we didn't wait to ensure
this has indeed completed?

native_machine_halt()
{
	machine_shutdown()->stop_other_cpus() 
	stop_this_cpu();<---- Unbalanced atomic_dec()?
}

But the last stop_this_cpu() in native_machine_halt() would 
make the count go negative? Maybe that's OK since no one is waiting for it
to go zero at that point?

> 
> But CPU0 already observed num_online_cpus() going down to 1 and proceeds
> which causes the system to hang.
> 
> Make this more robust by adding a counter which is set to the number of
> online CPUs before sending the IPIs and decremented in stop_this_cpu()
> after the WBINVD completed. Check for that counter in stop_other_cpus()
> instead of watching num_online_cpus().
> 
> Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
> Reported-by: Tony Battersby <tonyb@cybernetics.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/all/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
> ---
>  arch/x86/include/asm/cpu.h |    2 ++
>  arch/x86/kernel/process.c  |   10 ++++++++++
>  arch/x86/kernel/smp.c      |   15 ++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> 
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
>  int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
>  int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
>  
> +extern atomic_t stop_cpus_count;
> +
>  #endif /* _ASM_X86_CPU_H */
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -759,6 +759,8 @@ bool xen_set_default_idle(void)
>  }
>  #endif
>  
> +atomic_t stop_cpus_count;
> +
>  void __noreturn stop_this_cpu(void *dummy)
>  {
>  	local_irq_disable();
> @@ -783,6 +785,14 @@ void __noreturn stop_this_cpu(void *dumm
>  	 */
>  	if (cpuid_eax(0x8000001f) & BIT(0))
>  		native_wbinvd();
> +
> +	/*
> +	 * native_stop_other_cpus() will write to @stop_cpus_count after
> +	 * observing that it went down to zero, which will invalidate the
> +	 * cacheline on this CPU.
> +	 */
> +	atomic_dec(&stop_cpus_count);
> +
>  	for (;;) {
>  		/*
>  		 * Use native_halt() so that memory contents don't change
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -27,6 +27,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/proto.h>
>  #include <asm/apic.h>
> +#include <asm/cpu.h>
>  #include <asm/idtentry.h>
>  #include <asm/nmi.h>
>  #include <asm/mce.h>
> @@ -171,6 +172,8 @@ static void native_stop_other_cpus(int w
>  		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
>  			return;
>  
> +		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
> +
>  		/* sync above data before sending IRQ */
>  		wmb();
>  
> @@ -183,12 +186,12 @@ static void native_stop_other_cpus(int w
>  		 * CPUs reach shutdown state.
>  		 */
>  		timeout = USEC_PER_SEC;
> -		while (num_online_cpus() > 1 && timeout--)
> +		while (atomic_read(&stop_cpus_count) > 0 && timeout--)
>  			udelay(1);
>  	}
>  
>  	/* if the REBOOT_VECTOR didn't work, try with the NMI */
> -	if (num_online_cpus() > 1) {
> +	if (atomic_read(&stop_cpus_count) > 0) {
>  		/*
>  		 * If NMI IPI is enabled, try to register the stop handler
>  		 * and send the IPI. In any case try to wait for the other
> @@ -208,7 +211,7 @@ static void native_stop_other_cpus(int w
>  		 * one or more CPUs do not reach shutdown state.
>  		 */
>  		timeout = USEC_PER_MSEC * 10;
> -		while (num_online_cpus() > 1 && (wait || timeout--))
> +		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
>  			udelay(1);
>  	}

If we go down the INIT path, life is less complicated.. 

After REBOOT_VECTOR IPI, if stop_cpus_count > 0, we send NMI to all CPUs.
Won't this completely update the atomic_dec() since CPUs in hlt() will also
take the NMI correct? I'm not sure if this is problematic.

Or should we reinitialize stop_cpus_count before the NMI hurrah?

>  
> @@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>  	local_irq_restore(flags);
> +
> +	/*
> +	 * Ensure that the cache line is invalidated on the other CPUs. See
> +	 * comment vs. SME in stop_this_cpu().
> +	 */
> +	atomic_set(&stop_cpus_count, INT_MAX);

Didn't understand why INT_MAX here?

