Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E586081FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJUXJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUXJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:09:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69B52A934E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9822DB82D8A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 23:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3F1C433D7;
        Fri, 21 Oct 2022 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666393741;
        bh=/209B5q5fAsMzd57io+X83Y3V+4/3rfLq9Maz8bcl6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Col0fq/5u/mfv2kRTF+GOen4HTlJk29yNGMnXqLrGmelTlJig8A057pO8eQ3Weznr
         v+aVKZP14/mAoViQo7itBNV2CShVXZBW3dplXRv1BXZxGhdtoZIgChOqrPLe+DL17N
         p4ioI6WIsWOQNrDgKryxwv11imfNu4KEsr5K6wSj053C4VcNOZBiKMdHsa+H3MZXHn
         ETbdTEHqUbYm1ZhMBcJoSV7YLBsFdr//Caa1CSdE+YtAdnLGQp7PIIR4awUrSjVaMh
         IEtYVoyefRmBAona0/fALTTVfI/MgW1NX878H9JX2c+6WCtVxrgGa+p3lWIiSVQqCm
         3fkP0A4/KfWaw==
Date:   Fri, 21 Oct 2022 16:08:59 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <20221021230859.gysp5v3yzfqz4xgb@treble>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> +#ifdef CONFIG_FINEIBT
> +/*
> + * kCFI						FineIBT
> + *
> + * __cfi_\func:					__cfi_\func:
> + *	movl   $0x12345678,%eax			     endbr64			// 4
> + *	nop					     subl   $0x12345678,%r10d   // 7
> + *	nop					     jz     1f			// 2
> + *	nop					     ud2			// 2
> + *	nop					1:   nop			// 1
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop

All the "CFI" naming everywhere is very unfortunate.  We already have
"call frame information" in both the toolchain and objtool.

The feature is called "kCFI" anyway, can Clang call the symbols
'__kcfi_*'?

> +++ b/tools/objtool/builtin-check.c
> @@ -79,6 +79,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
>  	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
>  	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
> +	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "generate cfi_sites"),

"annotate kernel control flow integrity (kCFI) function preambles" ?

> +++ b/tools/objtool/check.c
> @@ -861,6 +861,62 @@ static int create_ibt_endbr_seal_section
>  	return 0;
>  }
>  
> +static int create_cfi_sections(struct objtool_file *file)
> +{
> +	struct section *sec, *s;
> +	struct symbol *sym;
> +	unsigned int *loc;
> +	int idx;
> +
> +	sec = find_section_by_name(file->elf, ".cfi_sites");
> +	if (sec) {
> +		INIT_LIST_HEAD(&file->call_list);
> +		WARN("file already has .cfi_sites section, skipping");
> +		return 0;
> +	}
> +
> +	idx = 0;
> +	for_each_sec(file, s) {
> +		if (!s->text)
> +			continue;
> +
> +		list_for_each_entry(sym, &s->symbol_list, list) {
> +			if (strncmp(sym->name, "__cfi_", 6))
> +				continue;

Also make sure it's STT_FUNC.

> +
> +			idx++;
> +		}
> +	}
> +
> +	sec = elf_create_section(file->elf, ".cfi_sites", 0, sizeof(unsigned int), idx);
> +	if (!sec)
> +		return -1;
> +
> +	idx = 0;
> +	for_each_sec(file, s) {
> +		if (!s->text)
> +			continue;
> +
> +		list_for_each_entry(sym, &s->symbol_list, list) {
> +			if (strncmp(sym->name, "__cfi_", 6))
> +				continue;

Ditto.

-- 
Josh
