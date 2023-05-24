Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA970EDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbjEXGOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:14:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F0132;
        Tue, 23 May 2023 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684908868; x=1716444868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BvET74+PGhFIHGpf69Hu1b65MfR/QvNJUm8CVbYFuIc=;
  b=ZRtXs8mOsHpBkQceiKCDqdo+7ZLRbwXUqVZW9aEuvtt+t8dCGrzoXOOI
   EEOYFTifBRGmaYS3pemq/yNtLHZFiGSeB6/NYG5LAE/avb7lUdB/o13P0
   BtL/9eLoeJ1pMzcGQmZG4DJzAw53LWs3vbuqRP6t2OGOm2lJHZFAlGoTP
   /8vsn2JtJWzkuP0TyDHglCPPO72J0jt7d76ZldbF4tZ26x7zvGDeEARln
   RCKnODST/mZvd28xLz+O/IlWqpv1Uf6fEXpQEyLmaYtrnIWqHDcyeRf4w
   Or1w8zF61xawzeCvzCnUl88bey67o1x5aZhqMJRXQ0YFOwv9V01PMr5nN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350982962"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="350982962"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654693856"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="654693856"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.197])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:14:24 -0700
Message-ID: <a51d79b3-6ba4-e85f-0f47-a9a180ea057c@intel.com>
Date:   Wed, 24 May 2023 09:14:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] perf annotate: Remove x86 instructions with suffix
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
References: <20230524052834.1041418-1-namhyung@kernel.org>
 <20230524052834.1041418-2-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230524052834.1041418-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 08:28, Namhyung Kim wrote:
> Not the suffix is handled in the general code.  Let's get rid of them.

Not -> Now ?

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 44 +--------------------
>  1 file changed, 2 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 5c7bec25fee4..714fd8784d99 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -1,48 +1,29 @@
>  // SPDX-License-Identifier: GPL-2.0

Could probably use a comment about how the table works
with suffixes.

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
> @@ -56,7 +37,6 @@ static struct ins x86__instructions[] = {
>  	{ .name = "jl",		.ops = &jump_ops, },
>  	{ .name = "jle",	.ops = &jump_ops, },
>  	{ .name = "jmp",	.ops = &jump_ops, },
> -	{ .name = "jmpq",	.ops = &jump_ops, },
>  	{ .name = "jna",	.ops = &jump_ops, },
>  	{ .name = "jnae",	.ops = &jump_ops, },
>  	{ .name = "jnb",	.ops = &jump_ops, },
> @@ -83,49 +63,31 @@ static struct ins x86__instructions[] = {
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
> @@ -139,11 +101,9 @@ static struct ins x86__instructions[] = {
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

