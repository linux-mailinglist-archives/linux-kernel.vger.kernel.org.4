Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6C65383D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiLUVeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLUVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:34:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F362495D;
        Wed, 21 Dec 2022 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671658459; x=1703194459;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWR8XFB5OtehgHW3vLQLI23M712Bma4MSZCdraS5UIA=;
  b=NBXa+1mqy4MKY5ZPnEAw4F6LNfTwCo0sMeyfz8hW6kcJ9c9EOAM/iFNp
   RiuAxq4NJTq7ls7b///uCkX0gtv+qFAWBIyVbAqHj59630axh9u1i8NGJ
   pUre6mhMgE6M8fqifL8SAA4McDMI4uscL7IyBegEvttzagMaq1sAi/cm4
   V1RP3cn6MmLSFF7rbjKm8bn0pGq3xhETx3LbvNSGX7E3evCrGaqjIks1+
   paaUwI6/rH4wc+ZKcp2ncvdPFw5GNbeuBvDyRvghGiGrUEnieevaYAKCg
   L5Hdx1zZEc43D11lFUU2W6RzJw6lWNj+uDEDyJvi33HanaYfrRcYMaz0Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="406218718"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="406218718"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 13:34:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="896976767"
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="896976767"
Received: from lijieqi-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.64.202])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 13:34:18 -0800
Message-ID: <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Pratyush Yadav <ptyadav@amazon.de>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Date:   Wed, 21 Dec 2022 13:34:18 -0800
In-Reply-To: <20221221155203.11347-1-ptyadav@amazon.de>
References: <20221221155203.11347-1-ptyadav@amazon.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> When a processor is brought offline and online again, it is unable to
> use Turbo mode because the _PSS table does not contain the whole
> turbo
> frequency range, but only +1 MHz above the max non-turbo frequency.
> This
> causes problems when ACPI processor driver tries to set frequency
> constraints. See patch 2 for more details.
> 
Are you using some _PPC constraint to force to limit frequency?
I did a offline/online with PPC=0 with no HWP, I can get to full turbo
range.

[  121.237752] smpboot: CPU 1 is now offline
[  125.734886] x86: Booting SMP configuration:
[  125.734892] smpboot: Booting Node 0 Processor 1 APIC 0x2
[  125.741007] intel_pstate: CPU 1 going online
[  125.741692] intel_pstate: CPU1 - ACPI _PSS perf data
[  125.741698] intel_pstate:      *P0: 2301 MHz, 28000 mW, 0x2a00
[  125.741703] intel_pstate:       P1: 2300 MHz, 28000 mW, 0x1700
[  125.741705] intel_pstate:       P2: 2200 MHz, 26297 mW, 0x1600
[  125.741707] intel_pstate:       P3: 2000 MHz, 23263 mW, 0x1400
[  125.741710] intel_pstate:       P4: 1900 MHz, 21924 mW, 0x1300
[  125.741712] intel_pstate:       P5: 1800 MHz, 20612 mW, 0x1200
[  125.741714] intel_pstate:       P6: 1600 MHz, 17812 mW, 0x1000
[  125.741716] intel_pstate:       P7: 1500 MHz, 16581 mW, 0xf00
[  125.741718] intel_pstate:       P8: 1300 MHz, 13946 mW, 0xd00
[  125.741720] intel_pstate:       P9: 1200 MHz, 12796 mW, 0xc00
[  125.741722] intel_pstate:       P10: 1100 MHz, 11426 mW, 0xb00
[  125.741724] intel_pstate:       P11: 900 MHz, 9250 mW, 0x900
[  125.741726] intel_pstate:       P12: 800 MHz, 7965 mW, 0x800
[  125.741729] intel_pstate:       P13: 700 MHz, 6940 mW, 0x700
[  125.741731] intel_pstate:       P14: 500 MHz, 4738 mW, 0x500
[  125.741733] intel_pstate:       P15: 400 MHz, 3787 mW, 0x400
[  125.741735] intel_pstate: _PPC limits will be enforced
[  125.741740] intel_pstate: policy->max > max non turbo frequency
[  125.741742] intel_pstate: cpu:1 min_policy_perf:4 max_policy_perf:42
[  125.741745] intel_pstate: cpu:1 global_min:4 global_max:42
[  125.741747] intel_pstate: cpu:1 max_perf_ratio:42 min_perf_ratio:4
[  125.742243] intel_pstate: policy->max > max non turbo frequency
[  125.742247] intel_pstate: cpu:1 min_policy_perf:4 max_policy_perf:42
[  125.742251] intel_pstate: cpu:1 global_min:4 global_max:42
[  125.742255] intel_pstate: cpu:1 max_perf_ratio:42 min_perf_ratio:4


It is not clear how to get to this non turbo situation.

Thanks,
Srinivas

> Pratyush Yadav (2):
>   acpi: processor: allow fixing up the frequency for a performance
> state
>   cpufreq: intel_pstate: use acpi perflib to update turbo frequency
> 
>  drivers/acpi/processor_perflib.c | 40
> ++++++++++++++++++++++++++++++++
>  drivers/cpufreq/intel_pstate.c   |  5 ++--
>  include/acpi/processor.h         |  2 ++
>  3 files changed, 45 insertions(+), 2 deletions(-)
> 
> --
> 2.38.1
> 

