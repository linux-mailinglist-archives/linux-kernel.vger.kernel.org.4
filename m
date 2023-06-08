Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A597274A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFHBzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjFHBzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:55:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4B2680
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686189349; x=1717725349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RPeKA+bkklyAvmUBga2XftnRNmMLlRwvXx3SCN4eCEU=;
  b=EkK10H9O/n1t0xPwxh0HB/hJ2k0N0/7fQNIQSmXDqX+588PUvANfhSDq
   AHCKUW7yeS+UlgVq55dRD2G0jwsWkGboJ28SRi9zN+KWwlI85NuYapwbq
   yClgeHPWp9qMjZL5b7XCByJER987R6Q5U36BxJ7Ow+MmZIINzgt/Aph2f
   Z4p2KvBd5SvELXv47AaMf9yK9KEhJn1bKlQG6royVst94dd965NR4+ZQE
   7qKCVCH2HCk5TigQGmUL0jUHtmWRUWbBrwa7Cw60tXU321kMD65TLAC7o
   IXnxBWvUo5e2kEZlD0A+HfFoX8LDAHCq3E6evxiDBOkfa1PneKhFBvxWx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359639997"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="359639997"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="884008520"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="884008520"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2023 18:55:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:55:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 18:55:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 18:55:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 18:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDk+4e1A80RQNcFzRy94ldsZaKvn0mbaAUXxMQpN0oNDoQjrM6Hl31n2px6Yq1XIRFDDaHi+9UsyRoqdSjsjsbsMO30AuohqhSW/hTvQVZArrwYGUpod9hzXkV1oTq2UrTLr0VPP3prr1gV0aWBEq4t90zyEaB/BWEdH2zb8zAIkCGG2hlrVQkhN+pK0xOEca4QaA0uDLfoeWzn/ObVRn64qdB6NjgGo1C9fukeD7Q2rcvRSedVjmKynGHYP8mczghrSsrZjkb5hZYVpqmAbPTneF9XQNDMo74p1fLKRugipaNWRESceVUXSpo/PtbphlBUNoZbD0pjTbhotS+gPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6QSDUVAUFxK4/dd/VyW1RJtEFIKz+p7PftkVtIvbmU=;
 b=FsEsfYJe1KE32Zbh+ch+InTlGypaNA9SQkXS9nRlxxD3l+7f9zzI/XdlcRWUiUq9+pVVhm2F/E461jfLaVTcyUmGeSA8fJZRSUchsMgQZfqsmN2RsBJ6thTCAvj1xO04BkyQPAdGpYg+solZ0VbGsHUOA83qrasX8/S99/fIcQvWwUpE9Ff8gqLrG8pcVbijn/1KJeaOw0wl4iuOAfwC3IXPEUGoY+ztpONwL4D0wbmsxIEqn4x3pJboY7xay9l4RHPUP/mQuuEhtDDyDX7PGr+ofNXRmr4Cxl2kRfw5boCFGpxlwXlAfyBqyy00fxhineJAnLT6Hw/1MsMMidNmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 01:55:45 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 01:55:45 +0000
Date:   Wed, 7 Jun 2023 18:55:39 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <ZIE1G9UBAT36kPhJ@a4bf019067fa.jf.intel.com>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230605141332.25948-2-bp@alien8.de>
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 135f14f9-12d2-489f-74af-08db67c3792a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZuIIfkYmwcXLfzN1Pzb+Yk1DQWrGUMwMj2iRDBqa0aoZRLfh8Fqcal+X8xtlgLU2CZoyllKOowDuSQU4Vz6fvNOhGz4uIARzww1/bz39mTlG0IpG0g4B5qH8REHX9PmsLgJe4TD/MroInWyqiLWGT8hjIVOBJoXVvj5+tm9XMtVyHApnB9VMPdKCVoptSqDVbp2ayTxa382s+zqBVs4pMUvJIq9hmvgSRAoqOoMeT0xjASV8R9RuIu0lJ9WBeik2r4cc2QEDXyvoSH9zxVu0Fq4bzfCFq3qpxd95vugL3d8wA++49INg1YdP8hBNTMY7zQlR0ZFo7FputIL8jNLY1y2knX5MqU7rbiPIuXNFOI1U9L97+tEyb6bS8j4T2V1SQlL+ekHNkgH8jk0aOPnaM/O19rT8kDu2St5CK5Bz8ATG9RHEavmsDH/1luQecO2aY0RAs++4fT+gArTKaPkvmerHWhhaJLyHGZV9CUvPYdl3FYIW4YjJZ7CxoCsWp22LMsL7Lkkgxfdv4cTixAmQoWm41HFvsIixo1NMeH9vO6eUqqmV1St3eYoHAaLtXLZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(107886003)(186003)(26005)(6506007)(6512007)(83380400001)(6486002)(6666004)(2906002)(8936002)(8676002)(82960400001)(54906003)(44832011)(478600001)(38100700002)(6916009)(41300700001)(86362001)(5660300002)(316002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fR2dq9Q2PNBuH2HzRhXHVIlEypVcGgpZk3MA030v+7hllIO/22X0SxtqiC2J?=
 =?us-ascii?Q?wnyH1czxFgLQrRXJqCeOqEYK/GKIwCiZrleYTZhuXmnenTAvwsOKF/8SyRfU?=
 =?us-ascii?Q?2vU1v37D93ar4XMRJXj+4CwVRmO23tXm6chXEQA6HnOQRele/oUZ7e6HWHkY?=
 =?us-ascii?Q?H0ShvQZZ2VbwLhL0lV8aRXX+woPdxcw8VqG1jqxQfzsh0mg8iGf/e6KXu/90?=
 =?us-ascii?Q?YkIW7cwP/N+RTt6P4Wq3WAH8p7kBuv25sk+jTBvZUeD9i1YS+8+iZrSX2hCA?=
 =?us-ascii?Q?FXAL5VEuDVLN/CuqYgGvALMyA2aYJ3TBHs9uIcPr7ptxT/Nak4MxgeyaJf7D?=
 =?us-ascii?Q?NXgcSquwkSzYdO1B0CuyijhBr+k8l9TAo6G1CAM4/QX+2y9VE9s4hwGkJ4e9?=
 =?us-ascii?Q?hmt6g54rrq3RwvcnBFeVU5Ev3Bj1RvfOazMAWYWql3HO5yOZSb7sltcGVeRP?=
 =?us-ascii?Q?rVHmWkKfDyzIPN0vVdy1189YzGFuwhcD7JkeQobIuuCxPOJ+xS0Qta9BhYqk?=
 =?us-ascii?Q?2aO9qExbyO0ts81tFt8N1S70FuuzZlsy4hhumdD/7nileOz7EpJZIABwoZXm?=
 =?us-ascii?Q?al38EIeCxwkLy0WkHKZotf0mkkmPzaLRHbyBaoLFDmoPy/HPs9SHXvCxb1iy?=
 =?us-ascii?Q?DBKzf9tt26Ql6W7ZsBONS7QCYmDOAi9IiPWD8Q4gNNL4f3CWNEZf762gRBfH?=
 =?us-ascii?Q?gAGwVAG97zIlx7YJciKWpXqUuyy6pjCoBse7849E3nOTqHquJKTCybqpNMF1?=
 =?us-ascii?Q?rukFmx4QDj2zk1kteu+Csg11hMD83koym9gC1Y487VZHbiviuRTdLGfmfoTV?=
 =?us-ascii?Q?VOq/qdizB3SoS4D6Q/Kwua1Y1m1BkSK0wl/Oek8KgyMQApW9+m8uypNKiJTw?=
 =?us-ascii?Q?OI6mTtblS9FnpT4Tb5L6te5q8JfIkRS+5yMoFklk6+fpJpjEYt1RAHIX6SY6?=
 =?us-ascii?Q?R/7WXAfD2J7BD2te73wq8n0S6dVSP6qnrangIb6lBH+uoBtjdBgNdm2B+gv3?=
 =?us-ascii?Q?sgB2wLgQQEBduNOA7hVOU+hDSURgu+3ARKtRa0RExbzABuMbCa9Z7VLCQYPk?=
 =?us-ascii?Q?4FJcokdd3kEimxJg0efxzux8ztb8QwEOfoaPNIpCcnMzDdHU8wMESrFgG6PF?=
 =?us-ascii?Q?vfE0EMywBmrRt3b4XiwybgIZ82kshTbEGVd92j8URrRMWvh4xJmio7LYyEEu?=
 =?us-ascii?Q?VeVx7Y6w+2CIywS3GLeh46M/dyw1U+DbALOURCAVpdHYxW/CTn4kQ1PWjKCk?=
 =?us-ascii?Q?CRrYGBGAH6zgeVWs4pcNOubEEjC1UaPv4sB8FIKe2q5+mUQuD6YqhMEgAxGL?=
 =?us-ascii?Q?hqux6Qifw33HpQ8+AyB5BomQ0LNt55I0i4oh/cCgRIvGoS7LajwVEtsaudgC?=
 =?us-ascii?Q?LfqTcdCuKNJKOGpeG2+LBsgdnuDasy4JdpW85dEd+UAvVJTaas34mk2JZwby?=
 =?us-ascii?Q?zQlZbtRJBJJ2eqOvO78WWNFdgGhHTF+YlR5eY3xpiEJVmP+Ezll/9PvQML8m?=
 =?us-ascii?Q?8qAUWZAFnDeNtsXE2Nd3PSxoS/zriEeU7qNX+fdMYW5alfZ2GBpP/oD8j4v+?=
 =?us-ascii?Q?KQKa0C8+UzjU4Q5a7ke1qR/AY1QarTZc5nM+mO6n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135f14f9-12d2-489f-74af-08db67c3792a
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:55:45.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjuhnZ82vKeJPPCjAAfg0jTdC25T1hirRM1+2Ii+UWvo7SgV5FYfd+Q54u0cGsb0tymQm6mldDkzGbRDLH8pgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Jun 05, 2023 at 04:13:32PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> It will be used to control microcode loader behavior. Add the first
> chicken bit: to control whether the AMD side should load microcode late
> on all logical SMT threads.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 +++
>  arch/x86/kernel/cpu/microcode/amd.c           |  5 ++-
>  arch/x86/kernel/cpu/microcode/core.c          | 44 +++++++++++++++++++
>  arch/x86/kernel/cpu/microcode/internal.h      | 16 +++++++
>  4 files changed, 71 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/microcode/internal.h
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..b88ff022402c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3228,6 +3228,13 @@
>  
>  	mga=		[HW,DRM]
>  
> +	microcode=	[X86] Control the behavior of the microcode
> +			loader. Available options:
> +
> +			no_late_all - do not load on all SMT threads on
> +			AMD. Loading on all logical threads is enabled by
> +			default.
> +

The default behavior is that the reload happens on all threads for both
early and late. 

The chicken bit in cmdline and the sysfs/control is to  opt-out just in case
they want to change the default behavior? 

When end user changes the behavior, isn't it against the design specification? And if
so, should that result in kernel being tainted after a reload?

Is this reload on all threads required by all models, or only certain
models? I was wondering if the forced reload could be limited to only
affected CPUs instead of doing it on all unconditionally.

>  	min_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory below this
>  			physical address is ignored.
>  
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 87208e46f7ed..76b530697951 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -36,6 +36,8 @@
>  #include <asm/cpu.h>
>  #include <asm/msr.h>
>  
> +#include "internal.h"
> +
>  static struct equiv_cpu_table {
>  	unsigned int num_entries;
>  	struct equiv_cpu_entry *entry;
> @@ -700,7 +702,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
>  
>  	/* need to apply patch? */
> -	if (rev > mc_amd->hdr.patch_id) {
> +	if ((rev > mc_amd->hdr.patch_id) ||
> +	    (rev == mc_amd->hdr.patch_id && !(control & LATE_ALL_THREADS))) {
>  		ret = UCODE_OK;
>  		goto out;
>  	}
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 3afcf3de0dd4..5f3185d2814c 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -40,11 +40,15 @@
>  #include <asm/cmdline.h>
>  #include <asm/setup.h>
>  
> +#include "internal.h"
> +
>  #define DRIVER_VERSION	"2.2"
>  
>  static struct microcode_ops	*microcode_ops;
>  static bool dis_ucode_ldr = true;
>  
> +unsigned long control = LATE_ALL_THREADS;
> +
>  bool initrd_gone;
>  
>  LIST_HEAD(microcode_cache);
> @@ -522,8 +526,32 @@ static ssize_t processor_flags_show(struct device *dev,
>  	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
>  }
>  
> +static ssize_t control_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "0x%lx\n", control);
> +}
> +
> +static ssize_t control_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -ERANGE;
> +
> +	if (val & CONTROL_FLAGS_MASK)
> +		return -EINVAL;
> +
> +	control = val;
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RO(version);
>  static DEVICE_ATTR_RO(processor_flags);
> +static DEVICE_ATTR_ADMIN_RW(control);
>  
>  static struct attribute *mc_default_attrs[] = {
>  	&dev_attr_version.attr,
> @@ -622,6 +650,7 @@ static struct attribute *cpu_root_microcode_attrs[] = {
>  #ifdef CONFIG_MICROCODE_LATE_LOADING
>  	&dev_attr_reload.attr,
>  #endif
> +	&dev_attr_control.attr,

Shouldn't the "control" be under LATE_LOADING? Since this only controls
late-loading behavior? 


