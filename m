Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2C732293
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbjFOWO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjFOWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:14:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA5296C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686867256; x=1718403256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o6CzlnOxUp7Pn23UIx3PBDccZCaI5gkIID8mocI167g=;
  b=daDlw3z6GB+u8bYWoMsRpr9l5SJkJxLkcakFIUr6iPpZJzvUwnzWvHB8
   B3Y/b9+IhcvdvN8+TAzA7QnLDq2x93sAAAXDRzo41e4qgLE1TEfNOIgJj
   1k8cWSW/VmcytjlMWZLyZJQdcJKv1Ipikh4GhyNLboSS/rrYAY/IOMoKi
   JbXlRFdhnyjNzEwdAEw5ldMCISMvJT1vX/KSpqQcBzRo8p0MM3i92Lo1T
   FpVf2bGSqVIyf8epeMtVVQoIg1NH0nVj+D5JPuGIQAVv2LvnJ/i9HthED
   /ESeus24kqF4DfUIcZKyOdOORkaOXjLjgdOBjM1v6R6RSy6BGXC7H5wdD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356543710"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356543710"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:13:54 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745846573"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745846573"
Received: from ckale-mobl1.amr.corp.intel.com (HELO desk) ([10.212.176.170])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:13:54 -0700
Date:   Thu, 15 Jun 2023 15:13:47 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     jpoimboe@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/bugs: Create an option to disable MDS
Message-ID: <20230615221347.6ghb4d33tituxht4@desk>
References: <20230615164417.3588162-1-leitao@debian.org>
 <20230615164417.3588162-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615164417.3588162-2-leitao@debian.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 09:44:12AM -0700, Breno Leitao wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 182af64387d0..50f12829dce9 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -269,6 +269,7 @@ static void x86_amd_ssb_disable(void)
>  /* Default mitigation for MDS-affected CPUs */
>  static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
>  static bool mds_nosmt __ro_after_init = false;
> +#define MDS_WARN_MSG "WARNING: Microarchitectural Data Sampling (MDS) speculative mitigation disabled!\n"
>  
>  static const char * const mds_strings[] = {
>  	[MDS_MITIGATION_OFF]	= "Vulnerable",
> @@ -278,11 +279,17 @@ static const char * const mds_strings[] = {
>  
>  static void __init mds_select_mitigation(void)
>  {
> -	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
> +	if (!boot_cpu_has_bug(X86_BUG_MDS)) {
>  		mds_mitigation = MDS_MITIGATION_OFF;
>  		return;
>  	}
>  
> +	if (cpu_mitigations_off() || !IS_ENABLED(CONFIG_MITIGATE_MDS)) {
> +		mds_mitigation = MDS_MITIGATION_OFF;
> +		pr_err(MDS_WARN_MSG);
> +		return;

Why does compile time config needs to be so restrictive that it does not
allow runtime override with mds= cmdline?

I believe Kconfig should only be setting the mitigation default,
allowing users to select mitigation at runtime:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 182af64387d0..50e1ca4ea68b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -267,7 +267,11 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_MDS)
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+#else
+static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_OFF;
+#endif
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
