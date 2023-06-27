Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25E740676
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjF0Waw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0Wau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:30:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87799
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687905048; x=1719441048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSSdhZBBsp8RxGDoee8DqcxbnRYNP8tzATpe2FLeM/Y=;
  b=IXYtAICq02MH4zwBjMZ9AR6f6PBPzQBxgxp6hxHHJUDhDElRQ7k8R7M/
   SJiwNsyVIllgkfdbPxnNYji//5W9C59LPMOLgmmcCPg+I674xWV+AcV01
   l8GHmDzxr1mcY4FLjKYhDo+MGvsrAicMxOx95m3HfyyK7n9aof5CBW5xU
   zBsii4TcmUhZZsuRTcNBbw7HLr1WNj+pV/89Cz9x91DqMNZtkOcjxfx26
   2sMcMyfvq5WS8p4wXgF1RREN6pkyITn1y3ySDnU6cOFSsOJCePDTB73/v
   GRmBPnxypTolnikaUVPLH95jyLhngI4h9zj3upQnbRy7qDzl37gAlrMCR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365151518"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="365151518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="890830362"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="890830362"
Received: from mmitlehn-mobl2.amr.corp.intel.com (HELO desk) ([10.209.78.185])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 15:30:47 -0700
Date:   Tue, 27 Jun 2023 15:30:40 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <20230627223040.bjacsmaotlderpdu@desk>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <ZJseCvXVKFHu84Sv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJseCvXVKFHu84Sv@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:36:10AM -0700, Breno Leitao wrote:
> Hello Pawan,
> 
> On Wed, Jun 21, 2023 at 12:41:01PM -0700, Pawan Gupta wrote:
> > On Wed, Jun 21, 2023 at 11:36:53AM -0700, Breno Leitao wrote:
> > > If I understand where you want to go, you think we should create a
> > > single patchset that creates a CONFIG_<MITIGATION> for each mitigation,
> > > and move get it under CONFIG_SPECULATION_MITIGATIONS.
> > 
> > Yes, a single series (or a patch) that adds config for each mitigation
> > would be good.
> 
> I've been working on this request, and I may need your help to validate
> the wordings and dependencies (as in architecture/vendors where the
> problem needs to be mitigations) for each entry.

Kconfig text looks fine to me. (Some comments on arch/vendor dependency
are down below).

> Also, I want to make sure I am not missing anything. Here is what I have
> so far. Is it in the right direction?
> 
> --
> Author: Breno Leitao <leitao@debian.org>
> Date:   Thu Jun 15 08:04:16 2023 -0700
> 
>     x86/bugs: Break down mitigations configurations

How about this?

x86/bugs: Add a separate config for each mitigation

>     Create an entry for each CPU mitigation under
>     CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
>     them at compilation time.
>     
>     If a mitigation is disabled at compilation time, it could be enabled at
>     runtime using kernel command line arguments.
>     
>     Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..10ea7884eddd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2649,6 +2649,100 @@ config SLS
>  	  against straight line speculation. The kernel image might be slightly
>  	  larger.
>  
> +config MITIGATE_MDS
> +	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
> +	depends on CPU_SUP_INTEL && X86_64

Architecture/vendor dependency is resolved at runtime during bug
enumeration (using CPU family/model). I don't think there is a need to
add explicit dependency here unless it creates runtime issues. And for
these configs it doesn't.

MDS and some of the other mitigations works for 32-bit kernel as well.
Dependency on X86_64 here is not correct, it makes 32-bit systems
vulnerable.

> +	default y
> +	help
> +	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
> +	  a hardware vulnerability which allows unprivileged speculative access
> +	  to data which is available in various CPU internal buffer. Deeper
> +	  technical information is available in the MDS specific x86 architecture
> +	  section: Documentation/arch/x86/mds.rst.
> +
> +config MITIGATE_TAA
> +	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
> +	depends on CPU_SUP_INTEL && X86_64

Ditto.

> +	default y
> +	help
> +	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
> +	  vulnerability that allows unprivileged speculative access to data
> +	  which is available in various CPU internal buffers by using
> +	  asynchronous aborts within an Intel TSX transactional region.
> +
> +config MITIGATE_MMIO_STALE_DATA
> +	bool "Mitigate MMIO Stale Data hardware bug"
> +	depends on CPU_SUP_INTEL && X86_64

Ditto for and all the others.

[...]
> @@ -1286,7 +1316,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  
>  	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
>  	if (ret < 0)
> -		return SPECTRE_V2_CMD_AUTO;
> +		return cmd;

In the same function, below code also needs to return the compile time
default:

        if (i >= ARRAY_SIZE(mitigation_options)) {
                pr_err("unknown option (%s). Switching to AUTO select\n", arg);
                return SPECTRE_V2_CMD_AUTO;
        }

[...]
> @@ -2119,7 +2153,12 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
>  #define pr_fmt(fmt)	"L1TF: " fmt
>  
>  /* Default mitigation for L1TF-affected CPUs */
> +

Extra newline.

> +#if IS_ENABLED(CONFIG_MITIGATE_L1TF)
>  enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
> +#else
> +enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_OFF;
> +#endif
>  #if IS_ENABLED(CONFIG_KVM_INTEL)
>  EXPORT_SYMBOL_GPL(l1tf_mitigation);
>  #endif
