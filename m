Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F130724546
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbjFFOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjFFOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145BE73;
        Tue,  6 Jun 2023 07:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B362361037;
        Tue,  6 Jun 2023 14:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA459C433EF;
        Tue,  6 Jun 2023 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060462;
        bh=/cjnqgLXCTKkrpyefUhq8rK2+8zhEpKZXJGamvtzO/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bw22lLWBew1T5WloK8h7uPoGCQAg77zWr3HaQzP2W5FL6HbonzqZ51eIAUQPDFQil
         aHM/waSJh/xQkEp34Bgx9ihcKbgqPugwmP94sPk40T9sb8axLhSdeF7JNr6CWGkaBY
         /xD4ZvTxVp58rTR0fHj/xPnj83ct7qWM4oTkB+jYc/kYcrpWkjGD4SH9m5HltJ/Lcj
         UTytrycOk3Mr/aAgaOcFwW0aREwdGGGKvBImiiL0ziOOAKvpdEvbYkDhN8e/xOFQaj
         f35Hvv0qm35AHlwvwRBiJb/AsLJAc6AITvwFgAoIU6FGcVrTM/ZufpA1mqkJHO149I
         777JLolgQJPLQ==
Date:   Tue, 6 Jun 2023 23:07:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf annotate: Remove x86 instructions with
 suffix
Message-Id: <20230606230737.9f42d22a89e0d9e48f655cc1@kernel.org>
In-Reply-To: <20230524205054.3087004-2-namhyung@kernel.org>
References: <20230524205054.3087004-1-namhyung@kernel.org>
        <20230524205054.3087004-2-namhyung@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 13:50:54 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Now the suffix is handled in the general code.  Let's get rid of them.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
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
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
