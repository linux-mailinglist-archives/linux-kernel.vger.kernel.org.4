Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C2710548
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjEYFYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239665AbjEYFXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:23:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491CDE6;
        Wed, 24 May 2023 22:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684992125; x=1716528125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XNWpTPyxdlMWL7w5HAAM69URFIMUwREePVbeKrWhWYU=;
  b=isaGBg+EzSCLte75MEaxkxg21xwSmC7uDxEty7yoeFJMeE/ZEffhMrx7
   blcr/FhzoC2hg06aAiXWFj07uxK034WO1qkQKYvwhgc44TJdTdgzcNGyi
   IWUByafOrpzu+ft/atCIeOf+1XQHqzLLUlmEwEjlDL24sKYfG/E0B2u1v
   2Q/b29VMNE9VXmLv4PPz26XRpDXXg216eavdMea8Tgkesj4uNgIJd15CS
   RYab6Ytmqy0rOpAv5CNjJQOlgSpVgSoSwVHMsqNqSZOHW9aOVJXiGBkyx
   WAY4Tz+uUg91+jkoXUhK8Ue+CVw3iC6DsJ4K4Pxb0qw1Cv3TzMTAUjQSE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338361213"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338361213"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="816901884"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="816901884"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:22:01 -0700
Message-ID: <9274da26-a5db-3d31-a446-df585d54c529@intel.com>
Date:   Thu, 25 May 2023 08:21:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] perf annotate: Remove x86 instructions with suffix
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20230524205054.3087004-1-namhyung@kernel.org>
 <20230524205054.3087004-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230524205054.3087004-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 23:50, Namhyung Kim wrote:
> Now the suffix is handled in the general code.  Let's get rid of them.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/annotate/instructions.c | 52 ++++-----------------
>  1 file changed, 10 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 5c7bec25fee4..5f4ac4fc7fcf 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -1,48 +1,37 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * x86 instruction nmemonic table to parse disasm lines for annotate.
> + * This table is searched twice - one for exact match and another for
> + * match without a size suffix (b, w, l, q) in case of AT&T syntax.
> + *
> + * So this table should not have entries with the suffix unless it's
> + * a complete different instruction than ones without the suffix.
> + */
>  static struct ins x86__instructions[] = {
>  	{ .name = "adc",	.ops = &mov_ops,  },
> -	{ .name = "adcb",	.ops = &mov_ops,  },
> -	{ .name = "adcl",	.ops = &mov_ops,  },
>  	{ .name = "add",	.ops = &mov_ops,  },
> -	{ .name = "addl",	.ops = &mov_ops,  },
> -	{ .name = "addq",	.ops = &mov_ops,  },
>  	{ .name = "addsd",	.ops = &mov_ops,  },
> -	{ .name = "addw",	.ops = &mov_ops,  },
>  	{ .name = "and",	.ops = &mov_ops,  },
> -	{ .name = "andb",	.ops = &mov_ops,  },
> -	{ .name = "andl",	.ops = &mov_ops,  },
>  	{ .name = "andpd",	.ops = &mov_ops,  },
>  	{ .name = "andps",	.ops = &mov_ops,  },
> -	{ .name = "andq",	.ops = &mov_ops,  },
> -	{ .name = "andw",	.ops = &mov_ops,  },
>  	{ .name = "bsr",	.ops = &mov_ops,  },
>  	{ .name = "bt",		.ops = &mov_ops,  },
>  	{ .name = "btr",	.ops = &mov_ops,  },
>  	{ .name = "bts",	.ops = &mov_ops,  },
> -	{ .name = "btsq",	.ops = &mov_ops,  },
>  	{ .name = "call",	.ops = &call_ops, },
> -	{ .name = "callq",	.ops = &call_ops, },
>  	{ .name = "cmovbe",	.ops = &mov_ops,  },
>  	{ .name = "cmove",	.ops = &mov_ops,  },
>  	{ .name = "cmovae",	.ops = &mov_ops,  },
>  	{ .name = "cmp",	.ops = &mov_ops,  },
> -	{ .name = "cmpb",	.ops = &mov_ops,  },
> -	{ .name = "cmpl",	.ops = &mov_ops,  },
> -	{ .name = "cmpq",	.ops = &mov_ops,  },
> -	{ .name = "cmpw",	.ops = &mov_ops,  },
>  	{ .name = "cmpxch",	.ops = &mov_ops,  },
>  	{ .name = "cmpxchg",	.ops = &mov_ops,  },
>  	{ .name = "cs",		.ops = &mov_ops,  },
>  	{ .name = "dec",	.ops = &dec_ops,  },
> -	{ .name = "decl",	.ops = &dec_ops,  },
> -	{ .name = "decq",	.ops = &dec_ops,  },
>  	{ .name = "divsd",	.ops = &mov_ops,  },
>  	{ .name = "divss",	.ops = &mov_ops,  },
>  	{ .name = "gs",		.ops = &mov_ops,  },
>  	{ .name = "imul",	.ops = &mov_ops,  },
>  	{ .name = "inc",	.ops = &dec_ops,  },
> -	{ .name = "incl",	.ops = &dec_ops,  },
> -	{ .name = "incq",	.ops = &dec_ops,  },
>  	{ .name = "ja",		.ops = &jump_ops, },
>  	{ .name = "jae",	.ops = &jump_ops, },
>  	{ .name = "jb",		.ops = &jump_ops, },
> @@ -56,7 +45,6 @@ static struct ins x86__instructions[] = {
>  	{ .name = "jl",		.ops = &jump_ops, },
>  	{ .name = "jle",	.ops = &jump_ops, },
>  	{ .name = "jmp",	.ops = &jump_ops, },
> -	{ .name = "jmpq",	.ops = &jump_ops, },
>  	{ .name = "jna",	.ops = &jump_ops, },
>  	{ .name = "jnae",	.ops = &jump_ops, },
>  	{ .name = "jnb",	.ops = &jump_ops, },
> @@ -83,49 +71,31 @@ static struct ins x86__instructions[] = {
>  	{ .name = "mov",	.ops = &mov_ops,  },
>  	{ .name = "movapd",	.ops = &mov_ops,  },
>  	{ .name = "movaps",	.ops = &mov_ops,  },
> -	{ .name = "movb",	.ops = &mov_ops,  },
>  	{ .name = "movdqa",	.ops = &mov_ops,  },
>  	{ .name = "movdqu",	.ops = &mov_ops,  },
> -	{ .name = "movl",	.ops = &mov_ops,  },
> -	{ .name = "movq",	.ops = &mov_ops,  },
>  	{ .name = "movsd",	.ops = &mov_ops,  },
>  	{ .name = "movslq",	.ops = &mov_ops,  },
>  	{ .name = "movss",	.ops = &mov_ops,  },
>  	{ .name = "movupd",	.ops = &mov_ops,  },
>  	{ .name = "movups",	.ops = &mov_ops,  },
> -	{ .name = "movw",	.ops = &mov_ops,  },
>  	{ .name = "movzbl",	.ops = &mov_ops,  },
>  	{ .name = "movzwl",	.ops = &mov_ops,  },
>  	{ .name = "mulsd",	.ops = &mov_ops,  },
>  	{ .name = "mulss",	.ops = &mov_ops,  },
>  	{ .name = "nop",	.ops = &nop_ops,  },
> -	{ .name = "nopl",	.ops = &nop_ops,  },
> -	{ .name = "nopw",	.ops = &nop_ops,  },
>  	{ .name = "or",		.ops = &mov_ops,  },
> -	{ .name = "orb",	.ops = &mov_ops,  },
> -	{ .name = "orl",	.ops = &mov_ops,  },
>  	{ .name = "orps",	.ops = &mov_ops,  },
> -	{ .name = "orq",	.ops = &mov_ops,  },
>  	{ .name = "pand",	.ops = &mov_ops,  },
>  	{ .name = "paddq",	.ops = &mov_ops,  },
>  	{ .name = "pcmpeqb",	.ops = &mov_ops,  },
>  	{ .name = "por",	.ops = &mov_ops,  },
> -	{ .name = "rclb",	.ops = &mov_ops,  },
> -	{ .name = "rcll",	.ops = &mov_ops,  },
> +	{ .name = "rcl",	.ops = &mov_ops,  },
>  	{ .name = "ret",	.ops = &ret_ops,  },
> -	{ .name = "retq",	.ops = &ret_ops,  },
>  	{ .name = "sbb",	.ops = &mov_ops,  },
> -	{ .name = "sbbl",	.ops = &mov_ops,  },
>  	{ .name = "sete",	.ops = &mov_ops,  },
>  	{ .name = "sub",	.ops = &mov_ops,  },
> -	{ .name = "subl",	.ops = &mov_ops,  },
> -	{ .name = "subq",	.ops = &mov_ops,  },
>  	{ .name = "subsd",	.ops = &mov_ops,  },
> -	{ .name = "subw",	.ops = &mov_ops,  },
>  	{ .name = "test",	.ops = &mov_ops,  },
> -	{ .name = "testb",	.ops = &mov_ops,  },
> -	{ .name = "testl",	.ops = &mov_ops,  },
> -	{ .name = "testq",	.ops = &mov_ops,  },
>  	{ .name = "tzcnt",	.ops = &mov_ops,  },
>  	{ .name = "ucomisd",	.ops = &mov_ops,  },
>  	{ .name = "ucomiss",	.ops = &mov_ops,  },
> @@ -139,11 +109,9 @@ static struct ins x86__instructions[] = {
>  	{ .name = "vsubsd",	.ops = &mov_ops,  },
>  	{ .name = "vucomisd",	.ops = &mov_ops,  },
>  	{ .name = "xadd",	.ops = &mov_ops,  },
> -	{ .name = "xbeginl",	.ops = &jump_ops, },
> -	{ .name = "xbeginq",	.ops = &jump_ops, },
> +	{ .name = "xbegin",	.ops = &jump_ops, },
>  	{ .name = "xchg",	.ops = &mov_ops,  },
>  	{ .name = "xor",	.ops = &mov_ops, },
> -	{ .name = "xorb",	.ops = &mov_ops, },
>  	{ .name = "xorpd",	.ops = &mov_ops, },
>  	{ .name = "xorps",	.ops = &mov_ops, },
>  };

