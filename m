Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079870EDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjEXGLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:11:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAB132;
        Tue, 23 May 2023 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684908691; x=1716444691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O8+zjVGkmsV8WxLXPH1S//zGH1GxEA5OLj1YtPlPvMQ=;
  b=C/Dzk0WTSPlNJ1JNwR6ESwKGSnhYnfddFfRiEwD8cjYfzlewLxs4Trzu
   WTi5MOPPxdcdX488EO3uEi2HETFOkufR7kUmzoMelns0OGM1S5j2+J4Rt
   A+//nBTMII+JTgLXNDbOMOGO2+YuO0LwIcJ5LrTL4pMmOH+DGG57dfZU1
   /nsoGfkrdxgRc83lOaH/oo5sc8oaERcMBUDR74wTMpazI3G70MOeIH2Cy
   KL1Uzslkil9F6FRTOWV7MD4FG7KySW+MpiM+4OhDJJsro6Q1sRwfeQZG/
   s8xT0l071PqoiVyAIsdTafsZ6WgT9TcYXf6YtLnXEC1yC0F8dVoWXYgsX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="352313648"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="352313648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="735039598"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="735039598"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.223.197])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:11:27 -0700
Message-ID: <b054012a-94ee-fb86-da35-d3359b8b4683@intel.com>
Date:   Wed, 24 May 2023 09:11:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] perf annotate: Handle x86 instruction suffix
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
References: <20230524052834.1041418-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230524052834.1041418-1-namhyung@kernel.org>
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
> Most of x86 instructions can have size suffix like b, w, l or q.

(AT&T mnemonics)

> Instead of adding all these instructions in the table, we can handle
> them in a general way.  For example, it can try to find an instruction
> as is.  If not found, it'd try again without the suffix if it's one of
> the allowed suffixes.

I guess it might be possible that xyz is in the table but xyz<suffix>
is a completely different instruction?

> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
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

