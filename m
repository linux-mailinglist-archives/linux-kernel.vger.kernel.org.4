Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E2366028A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjAFOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjAFOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:50:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464544319B;
        Fri,  6 Jan 2023 06:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673016647; x=1704552647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5BzoGa93/OVMZ6VfRHCQ/6WaBQK1UUhnnBhcz48iiWQ=;
  b=VfCItclPbii5kVDUyPwnWAeKde1/X5ulj9NQFagApUMPPbp1a2JeEdaF
   Dl/uYeAoJY51vqA4qc1KV8x/XhL9a3MCFnvaOh+clF0FbMryuco4jbSBV
   oBQbLLrGjx2WMMCy8w9izAMqFM82HsoIchZHH7lk66L0oGPfacgxwlTX7
   j6ASQSgZV/RJURADa255WIcOfwxxxFaWcbXp4EpJicA2gDBMeSRNEsnn/
   NURdMFGV5KtGy/sCnpvhFLBCDd1MK3RYxr9XeztwA8w1WEKwN93br109O
   ZUADiJozWshFaZf45j/nQRXWBvNfyKOE0q+xqhILMyXZx6o6JxMQ90JjQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="302852687"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="302852687"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:50:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="724458448"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="724458448"
Received: from xiangyuy-mobl.amr.corp.intel.com (HELO [10.212.251.186]) ([10.212.251.186])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 06:50:46 -0800
Message-ID: <a375b136-c4da-0676-7a67-d2308c012b8b@intel.com>
Date:   Fri, 6 Jan 2023 06:50:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>, "bp@alien8.de" <bp@alien8.de>
Cc:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
 <Y7f6RhF8FuK9R399@zn.tnic>
 <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <d6ae35f1e72d4bb8e02f44fe6d9369f1a5f21619.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 06:38, Zhang, Rui wrote:
> My original proposal is that, instead of maintaining model lists in a
> series of different drivers, can we use feature flags instead, and
> maintain them in a central place instead of different drivers. say,
> something like
> 
> static const struct x86_cpu_id intel_pm_features[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,           X86_FEATURE_RAPL | X86_FEATURE_TCC_COOLING),
>         X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,           X86_FEATURE_RAPL | X86_FEATURE_UNCORE_FREQ),
>         ...
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           X86_FEATURE_RAPL | X86_FEATURE_TCC_COOLING),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    X86_FEATURE_RAPL | X86_FEATURE_UNCORE_FREQ),
>         ...
>         {},
> };
> And then set the feature flags based on this, and make the drivers test
> the feature flags.

That works if you have very few features.  SKYLAKE_X looks to have on
the order of 15 model-specific features, or at least references in the code.

That means that the

	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, ...

list goes on for 15 features.  It's even worse than that because you'd
*like* to be able to scan up and down the list looking for, say, "all
the CPUs that support RAPL".  But, if you do that, you actually need a
table -- a really wide table -- for *all* the features and a column for
each.

What we have now isn't bad.  The only real way to fix this is to have
the features enumerated *properly*, aka. architecturally.

I get it, Intel doesn't want to dedicate CPUID bits and architecture to
one-offs.  But, at the point that there are a dozen CPU models across
three or four different CPU generations, it's time to revisit it.  Could
you help our colleagues revisit it, please?
