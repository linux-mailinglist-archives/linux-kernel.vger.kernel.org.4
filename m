Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404B0711B57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbjEZAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241012AbjEZAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:36:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6B1A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685061371; x=1716597371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdVWmFLqGcdqPJRp6HWDTAW4YZnKoHDjemJFuwShyT8=;
  b=OIU6sqtXy+aDKEu0+M8WMvHS2gzE7Z87iu06Pu9PdG4WTb948NODeJWC
   FhE36lWUBnF168cPRmT5+YO5BHd0p8SoK6d9ZIVd3oiHaKWPZy0mOKoFe
   wRw9Wa1+3VlT6+tEnYjyW0Ge9wgxIcMZb7sYyWqZ03mvcFDUsHFZaX2Di
   bjs2uTytrtSJeWFl2gcWI9GWuh+HR4mu16pEbKj4nc/OAXIM4t8RAQzTB
   BszfYrORkIhosMG8AxZ2SUalFcoTKywSNbVdSKgOf3eAK9WF9SZ3lxpcC
   4nWc7k89C0fSZXtJoIWh6LGLqEw2J5wymi2GjkUaInAH3A83uVEhlhi0y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="382315557"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="382315557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682537887"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="682537887"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 17:35:51 -0700
Date:   Thu, 25 May 2023 17:34:26 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode: move microcode_mutex declaration
Message-ID: <ZG/+kqmiQKwtEmQz@araj-dh-work>
References: <20230522062713.427998-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522062713.427998-1-christian.gmeiner@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:27:12AM +0200, Christian Gmeiner wrote:
> The microcode_mutex is only used when CONFIG_MICROCODE_LATE_LOADING
> is enabled. Move it into the ifdef block.
> 
> Fixes a compiler unused-variable warning seen on gcc.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Thanks Christian

I tried to compile with W=1 but not sure why I'm not getting that error
when CONFIG_MICROCODE_LATE_LOADING=n

I'm using GCC 12.2.0 on a ubuntu system.

But  your change seems fine.


> ---
>  arch/x86/kernel/cpu/microcode/core.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 3afcf3de0dd4..4f6ebadba2fb 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -49,20 +49,6 @@ bool initrd_gone;
>  
>  LIST_HEAD(microcode_cache);
>  
> -/*
> - * Synchronization.
> - *
> - * All non cpu-hotplug-callback call sites use:
> - *
> - * - microcode_mutex to synchronize with each other;
> - * - cpus_read_lock/unlock() to synchronize with
> - *   the cpu-hotplug-callback call sites.
> - *
> - * We guarantee that only a single cpu is being
> - * updated at any particular moment of time.
> - */
> -static DEFINE_MUTEX(microcode_mutex);
> -
>  struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
>  
>  struct cpu_info_ctx {
> @@ -323,6 +309,20 @@ void reload_early_microcode(unsigned int cpu)
>  static struct platform_device	*microcode_pdev;
>  
>  #ifdef CONFIG_MICROCODE_LATE_LOADING
> +/*
> + * Synchronization.
> + *
> + * All non cpu-hotplug-callback call sites use:
> + *
> + * - microcode_mutex to synchronize with each other;
> + * - cpus_read_lock/unlock() to synchronize with
> + *   the cpu-hotplug-callback call sites.
> + *
> + * We guarantee that only a single cpu is being
> + * updated at any particular moment of time.
> + */
> +static DEFINE_MUTEX(microcode_mutex);
> +
>  /*
>   * Late loading dance. Why the heavy-handed stomp_machine effort?
>   *
> -- 
> 2.40.1
> 
