Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CF607A09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJUPA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:00:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E1175A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666364456; x=1697900456;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ooS/g02rrEhFbNqnPJ7eHJgo/Vorjf5ZQuiW0wKvezk=;
  b=EyFuWIw4zrLjnuMl9kKBTPb5iTCebFvKtFK6jyxpiYCEhmb2g3l0UTIM
   o59DQzf1XUaD7RFwid5mGn1zMwBHjl6Zo7QOaT8k7pJ6DXzR3wKDCDa34
   NMQt2g6MjdLvSkvlvsDv3Kcw/YCPTyCdQdl0zImHlw40Z/0w44VWNssUB
   foKqgG6GZExS0R1m2V8DivZqaqwkn8K+fkkjX8yAQdmg+00b4lIk8deR7
   z3krS5E5Sbc7fc90G4n4GKCqhd4MsC8RVB8xUDNq5PmYFilgqSBLF5hY2
   jEqOzoTrCm8VrJ8EQYIRVT0Uttc0o3vkNAQ5IMxaX8acjJ78wgpJc8ahb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="305756283"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="305756283"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 08:00:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="661635301"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="661635301"
Received: from zhiyizhu-mobl.ccr.corp.intel.com ([10.254.215.216])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 08:00:47 -0700
Message-ID: <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
From:   Zhang Rui <rui.zhang@intel.com>
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        liaoyu15@huawei.com
Date:   Fri, 21 Oct 2022 23:00:44 +0800
In-Reply-To: <20221021062131.1826810-1-feng.tang@intel.com>
References: <20221021062131.1826810-1-feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 14:21 +0800, Feng Tang wrote:
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduced to solve problem that
> sometimes TSC clocksource is wrongly judged as unstable by watchdog
> like 'jiffies', HPET, etc.
> 
> In it, the hardware socket number is a key factor for judging
> whether to disable the watchdog for TSC, and 'nr_online_nodes' was
> chosen as an estimation due to it is needed in early boot phase
> before registering 'tsc-early' clocksource, where all none-boot
> CPUs are not brought up yet.
> 
> In recent patch review, Dave Hansen pointed out there are many
> cases that 'nr_online_nodes' could have issue, like:
> * numa emulation (numa=fake=4 etc.)
> * numa=off
> * platforms with CPU+DRAM nodes, CPU-less HBM nodes, CPU-less
>   persistent memory nodes.
> * SNC (sub-numa cluster) mode is enabled
> 
> Peter Zijlstra suggested to use logical package ids, but it is
> only usable after smp_init() and all CPUs are initialized.
> 
> One solution is to skip the watchdog for 'tsc-early' clocksource,
> and move the check after smp_init(), while before 'tsc'
> clocksoure is registered, where 'logical_packages' could be used
> as a much more accurate socket number.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Hi reviewers,
> 
> I separate the code to 2 patches, as I think they are covering 2
> problems and easy for bisect. Feel free to combine them into one,
> as the 2/2 are a trivial change.
> 
> Thanks,
> Feng
> 
> Changelog:
>  
>  Since RFC:
>  * use 'logical_packages' instead of topology_max_packages(), whose
>    implementaion is not accurate, like for heterogeneous systems
>    which have combination of Core/Atom CPUs like Alderlake (Dave
> Hansen)

I checked the history of '__max_logical_packages', and realized that

1. for topology_max_packages()/'__max_logical_packages', the divisor
   'ncpus' uses cpu_data(0).booted_cores, which is based on the
   *online* CPUs. So when using kernel cmdlines like maxcpus=/nr_cpus=,
   '__max_logical_packages' can get over-estimated.

2. for 'logical_packages', it equals the number of different physical
   Package IDs for all *online* CPUs. So with kernel cmdlines like
   nr_cpus=/maxcpus=, it can gets under-estimated.

BTW, I also checked CPUID.B/1F, which can tell a fixed number of CPUs
within a package. But we don't have a fixed number of total CPUs from
hardware.
On my Dell laptop, BIOS allows me to disable/enable one or several
cores. When this happens, the 'total_cpus' changes, but CPUID.B/1F does
not change. So I don't think CPUID.B/1F can be used to optimize the '__
max_logical_packages' calculation.

I'm not sure if we have a perfect solution here.

thanks,
rui






