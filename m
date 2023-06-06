Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95607724543
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbjFFOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjFFOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B510CC;
        Tue,  6 Jun 2023 07:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18916312E;
        Tue,  6 Jun 2023 14:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128ACC4339B;
        Tue,  6 Jun 2023 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060423;
        bh=3M1vwx9dTwVXjFdm37zRRtpfI/afK0Lm2/FTFWCBkvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jtnySrd0kbY8YO+HlrsJbhOYjqHDytkM7mcCBw6QVaDGcB1em2L0zXLXESf76RnHM
         Se92Ajsnyfuy9SmC+AAOGxJLWJYvMjU4l88w4tcTcxiBwxlTWVhZsnK/JUcMb0TYkj
         6ZBUOv15lAC8PQGF/iuLYDdq3UitwSkwLbmEARpZUZ3CcQNFvZa2aWT/w8O9ES3V0Z
         n/8ZVBixBKSCZUi8jjXLLPVzNZeInKNqFiek4Pvisvub/xv12vbAGfb+CpgfJLKggk
         JyfVboe6l/bl2KNKBW5blXVdhC0deyvbORIGAMhgTncA9kX1gCS7cTpADmET1Rzz3y
         Rmf0nnkWEzuAA==
Date:   Tue, 6 Jun 2023 23:06:58 +0900
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
Subject: Re: [PATCH v2 1/2] perf annotate: Handle x86 instruction suffix
 generally
Message-Id: <20230606230658.c1b478f905c82a9f7005034d@kernel.org>
In-Reply-To: <20230524205054.3087004-1-namhyung@kernel.org>
References: <20230524205054.3087004-1-namhyung@kernel.org>
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

On Wed, 24 May 2023 13:50:53 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

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

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
