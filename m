Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC8710547
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjEYFYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbjEYFXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:23:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA02E70;
        Wed, 24 May 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684992103; x=1716528103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AMlFALKRgaD3sGqBBgG4FaHOFvkt6VqSpWEMBgJWUSY=;
  b=lhEjXqDBTyKf9ICApBgMHgSDg/Z8o0tdwduav4X01k83aGS0gJdk+N6X
   5B7zEFaI5cjjE0eVWWpiRSpv8M/ckOx2Y1R6pMtSd3DreeueOQFYk61yL
   w2f0fs/vtPkkccvGZt9PvB6o/FbTmXWgYxFTvcj52SlsmBdM5iYupRxbt
   u22XTQ7TFvc7ehGWKL29WEKJ+wqAIn1RJkY3IdIFjsnE0Xs8XYOVw5mAA
   PzIddIr+Ir9oWwvcqz+kOldAyC9OR65H31tFYfxr3Nob5C8iwrQw9NRtp
   hYUvlp31qDbchF1wdhRhGBSsJ+l1guzm2sQdexsUvgrrwus+MPu1NQChq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338361165"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338361165"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="816901815"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="816901815"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.63])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 22:21:36 -0700
Message-ID: <d6ef6936-e885-46db-40d6-e3cfbd1b2c22@intel.com>
Date:   Thu, 25 May 2023 08:21:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] perf annotate: Handle x86 instruction suffix
 generally
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230524205054.3087004-1-namhyung@kernel.org>
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
> In AT&T asm syntax, most of x86 instructions can have size suffix like
> b, w, l or q.  Instead of adding all these instructions in the table,
> we can handle them in a general way.
> 
> For example, it can try to find an instruction as is.  If not found,
> assuming it has a suffix and it'd try again without the suffix if it's
> one of the allowed suffixes.  This way, we can reduce the instruction
> table size for duplicated entries of the same instructions with a
> different suffix.
> 
> If an instruction xyz and others like xyz<suffix> are completely
> different ones, then they both need to be listed in the table so that
> they can be found before the second attempt (without the suffix).
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/annotate.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index b708bbc49c9e..7f05f2a2aa83 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -70,6 +70,7 @@ struct arch {
>  	struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
>  	bool		sorted_instructions;
>  	bool		initialized;
> +	const char	*insn_suffix;
>  	void		*priv;
>  	unsigned int	model;
>  	unsigned int	family;
> @@ -179,6 +180,7 @@ static struct arch architectures[] = {
>  		.init = x86__annotate_init,
>  		.instructions = x86__instructions,
>  		.nr_instructions = ARRAY_SIZE(x86__instructions),
> +		.insn_suffix = "bwlq",
>  		.objdump =  {
>  			.comment_char = '#',
>  		},
> @@ -720,6 +722,26 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
>  	}
>  
>  	ins = bsearch(name, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
> +	if (ins)
> +		return ins->ops;
> +
> +	if (arch->insn_suffix) {
> +		char tmp[32];
> +		char suffix;
> +		size_t len = strlen(name);
> +
> +		if (len == 0 || len >= sizeof(tmp))
> +			return NULL;
> +
> +		suffix = name[len - 1];
> +		if (strchr(arch->insn_suffix, suffix) == NULL)
> +			return NULL;
> +
> +		strcpy(tmp, name);
> +		tmp[len - 1] = '\0'; /* remove the suffix and check again */
> +
> +		ins = bsearch(tmp, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
> +	}
>  	return ins ? ins->ops : NULL;
>  }
>  

