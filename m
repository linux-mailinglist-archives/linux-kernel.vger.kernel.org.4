Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09656688920
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjBBVoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjBBVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:44:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA52367C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675374292; x=1706910292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MmULTzOhwLf9svNR1oYyEtTOFrrdU5ErPgK0IebqNP4=;
  b=JPpVvbw1u3L2skd7u73krJVQNdUFWVVr6eOTK89yiFB1FgV9GVx4ekPb
   seNPxNDw5cOkkkEZlo5cmDq3wxm5tPbuhexCTgx40XN/qXRKz3r+D2iOM
   HxDO0pdwIlcN8OUv4T/TBCbPv59ltaGeYDRh04rAOjAHmmtCjBwa1CqUv
   gWJfppcM0L8ZFXEK2+ATxVl24ZusbV16AbM6eTQuMIyWuiyYGgLDN5Kvy
   +tI4mkjK/obTOdcfZZQ2bwSWW7pYXU+wnK8Ccv9Kfxx+wL3ZLmxq8pG0h
   yb6LCL5iGS4GiHZwBTkMi81N5AaFFWPPk0x5P0DYUVOG2QVFW3+AMHsbh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330706729"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="330706729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 13:44:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="658890631"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="658890631"
Received: from amroy1-mobl1.amr.corp.intel.com (HELO desk) ([10.212.178.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 13:44:44 -0800
Date:   Thu, 2 Feb 2023 13:44:42 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     tglx@linutronix.de, bp@alien8.de, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <20230202214442.ffqwk2can6b5ivpz@desk>
References: <20230202180858.1539234-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202180858.1539234-1-leitao@debian.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:08:58AM -0800, Breno Leitao wrote:
> Right now it is not possible to disable CPU vulnerabilities mitigations
> at build time. Mitigation needs to be disabled passing kernel
> parameters, such as 'mitigations=off'.
> 
> This patch creates an easy way to disable mitigation during compilation

s/This patch creates/Create/

  Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
  instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to
  do frotz”, as if you are giving orders to the codebase to change its
  behaviour.

  https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

> time (CONFIG_DEFAULT_CPU_MITIGATIONS_OFF), so, insecure kernel users don't
> need to deal with kernel parameters when booting insecure kernels.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/cpu.c     |  5 +++++
>  security/Kconfig | 11 +++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6c0a92ca6bb5..497e9a3d3d77 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2727,8 +2727,13 @@ enum cpu_mitigations {
>  	CPU_MITIGATIONS_AUTO_NOSMT,
>  };
>  
> +#ifdef CONFIG_DEFAULT_CPU_MITIGATIONS_OFF
> +static enum cpu_mitigations cpu_mitigations __ro_after_init =
> +	CPU_MITIGATIONS_OFF;
> +#else
>  static enum cpu_mitigations cpu_mitigations __ro_after_init =
>  	CPU_MITIGATIONS_AUTO;
> +#endif

With the 80 char limit gone, I think below is more readable:

#ifdef CONFIG_DEFAULT_CPU_MITIGATIONS_OFF
static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_OFF;
#else
static enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
#endif

>  static int __init mitigations_parse_cmdline(char *arg)
>  {
> diff --git a/security/Kconfig b/security/Kconfig
> index e6db09a779b7..a70427dc6ace 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -258,6 +258,17 @@ config LSM
>  
>  	  If unsure, leave this as the default.
>  
> +config CONFIG_DEFAULT_CPU_MITIGATIONS_OFF

CONFIG_ is implicit, this needs to be:

config DEFAULT_CPU_MITIGATIONS_OFF

> +	bool "Disable mitigations for CPU vulnerabilities by default"
> +	default n
> +	help
> +	  This option disable mitigations for CPU vulnerabilities by default.

s/disable/disables/

> +	  This improves system performance, but it may also expose users
> +	  to several CPU vulnerabilities.
> +	  This has the same effect as passing `mitigations=off` kernel
> +	  parameter. The mitigations could be enabled back passing the
> +	  'mitigations' parameter.
> +
>  source "security/Kconfig.hardening"
>  
>  endmenu
> -- 
> 2.30.2
> 
