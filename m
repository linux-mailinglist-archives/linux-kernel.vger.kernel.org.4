Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7EE601D75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJQXPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:15:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009A172942
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666048534; x=1697584534;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l4Ei4+lWKUNeU2n0eo9QpW8UqcbZEy0N36LAqt2lVnI=;
  b=L4SDBSlHm4fPJqE1Njy0YQcuOdG0lFX23bV35Ya/wb0JhnCzdnQ5T8Py
   S5FwS5opRZGdFLnDTgJwFSXJn/TROveVr/WfiZBlHUITpJkGoeQfkLlgk
   fa7xfMgV+bihPQoAppdPlm2hzKOHId1KH7HL+fyGayrA7PxrrjBDkdKgF
   zNGUm+xDG4CaVzM2R3Ri3G5bg9P/CY4KT8rB6K+l+hTFWt3w35j0oV7p5
   AXXyP//jPyMYiRjNbWM5atu7dim0cE9U65H6Upd5PnObDcksrqHXdCRpN
   dAm7LXw1POS5bQ3DhcxDLZF0L/nclmWAhHG4+5dVqNjxUy1xuha0s6rtU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="303556988"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="303556988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:15:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691552470"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="691552470"
Received: from mdsouza-mobl1.gar.corp.intel.com (HELO [10.252.51.216]) ([10.252.51.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:15:29 -0700
Message-ID: <ff269ad9-2811-e427-3bb9-5b4c978e80bf@intel.com>
Date:   Mon, 17 Oct 2022 16:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] x86/tsc: use topology_max_packages() in tsc watchdog
 check
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, tim.c.chen@intel.com, liaoyu15@huawei.com
References: <20221017132942.1646934-1-feng.tang@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221017132942.1646934-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 06:29, Feng Tang wrote:
> +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> +	    topology_max_packages() <= 2)
> +		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;

I couldn't help but notice the comment in here:

> void __init calculate_max_logical_packages(void)
> {
>         int ncpus;
> 
>         /*
>          * Today neither Intel nor AMD support heterogeneous systems so
>          * extrapolate the boot cpu's data to all packages.
>          */
>         ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
>         __max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
>         pr_info("Max logical packages: %u\n", __max_logical_packages);
> }

Could you double check for me that the Alder Lake combination Core/Atom
CPUs don't count as "heterogeneous systems" in this case?
