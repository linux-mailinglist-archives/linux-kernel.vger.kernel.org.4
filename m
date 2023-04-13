Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EECA6E0892
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDMIFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDMIFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:05:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4CDD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5um94p1h5uO7Sc2MYImSiUcDUS968xF9MGetdiv3K2g=; b=TG8mHfG54ucPO3Q1y3XWkXyIds
        frLfGnLFuzO6DunRMcKmNQLWtXOPFlaQ0ZINhnDIE67BPploHT6T2VEu9r046x5aGd8S0wP4pusvW
        jUqfIDKJHCB/FIsIrXuHahNUnEx0g9gFjTLVgZQxuk/n1b0N7IQGjW/0BoYWSJM9uEfHCkIVazBvf
        ElwVvkWqTuN9/b82P5M3UTUCrCFOOaE+hseqmOul0UWj0e4quVxDACYO3OqhWlDUGZ0XI6n6xaWBA
        DINoyQJrHAN5tTuLEwbw+hZ5iC4Z7m7m2leQP482HZsfvxdiJwTjLgheVFtlcrUWP9GAanIoWhfCe
        8PVB1Jew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmrxQ-007cih-IE; Thu, 13 Apr 2023 08:05:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F59D30008D;
        Thu, 13 Apr 2023 10:05:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77B5E235CC4A0; Thu, 13 Apr 2023 10:05:27 +0200 (CEST)
Date:   Thu, 13 Apr 2023 10:05:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 5/9] objtool: Add verbose option for disassembling
 affected functions
Message-ID: <20230413080527.GG4253@hirez.programming.kicks-ass.net>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cadacc719db1e792c335309056960ca6f71139e.1681325924.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:03:20PM -0700, Josh Poimboeuf wrote:
> When a warning is associated with a function, add an option to
> disassemble that function.
> 
> This makes it easier for reporters to submit the information needed to
> diagnose objtool warnings.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/Documentation/objtool.txt |  5 ++
>  tools/objtool/builtin-check.c           |  5 ++
>  tools/objtool/check.c                   | 77 +++++++++++++++++++++++++
>  tools/objtool/include/objtool/builtin.h |  1 +
>  4 files changed, 88 insertions(+)
> 
> diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
> index 8e53fc6735ef..4d6c5acde7a3 100644
> --- a/tools/objtool/Documentation/objtool.txt
> +++ b/tools/objtool/Documentation/objtool.txt
> @@ -244,6 +244,11 @@ To achieve the validation, objtool enforces the following rules:
>  Objtool warnings
>  ----------------
>  
> +NOTE: When requesting help with an objtool warning, please recreate with
> +OBJTOOL_VERBOSE=1 (e.g., "make OBJTOOL_VERBOSE=1") and send the full
> +output, including any disassembly below the warning, to the objtool
> +maintainers.
> +
>  For asm files, if you're getting an error which doesn't make sense,
>  first make sure that the affected code follows the above rules.
>  
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 7c175198d09f..5e21cfb7661d 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -93,6 +93,7 @@ static const struct option check_options[] = {
>  	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
>  	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
>  	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
> +	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
>  
>  	OPT_END(),
>  };
> @@ -118,6 +119,10 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
>  		parse_options(envc, envv, check_options, env_usage, 0);
>  	}
>  
> +	env = getenv("OBJTOOL_VERBOSE");
> +	if (env && !strcmp(env, "1"))
> +		opts.verbose = true;
> +
>  	argc = parse_options(argc, argv, check_options, usage, 0);
>  	if (argc != 1)
>  		usage_with_options(usage, check_options);

No real objection; but I do feel obliged to point out that:
OBJTOOL_ARGS="-v" achieves much the same.
