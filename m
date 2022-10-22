Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC63608DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJVPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:04:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E982D265C44
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KhxJI8WFJVHZQHq/VjjyjAylrs5IiNKA97KuMQXpglU=; b=MJhYqw3EecJCmQblJmgvBGfCoS
        YMNP+VDunmFZsBuKTRT4cxf97KI18tE77HOEJ6k+My3us60LpSRgrvySTRkOlhTbwezuFprQkwJlW
        7b7/AX1k4LKGmZ0KR+wnw20CbTs4uSOL67aG3e/fKaZbSTZ4L3SXvc2NtLRjsRCvzMFPTBqhBnCrc
        681qwXHRIoawDP5+87sKwi0upfx4bXn9Td1IYosEyfa+XLgw9ndxhJ5ievOfAI7YoL5tEveJFYgTM
        My3iRqJRFz9Brmos9D3nXtK9BCB+6qGqrs3xWmNkDhSjSc9zPLmWYjnHjjs8hg4i6r0Vnm1/O5NQN
        B1VIATQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omG2Q-00DzdM-FQ; Sat, 22 Oct 2022 15:03:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A7F130006D;
        Sat, 22 Oct 2022 17:03:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 491132080B95A; Sat, 22 Oct 2022 17:03:45 +0200 (CEST)
Date:   Sat, 22 Oct 2022 17:03:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y1QGUXSc43rInacJ@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <20221021230859.gysp5v3yzfqz4xgb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021230859.gysp5v3yzfqz4xgb@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:08:59PM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_FINEIBT
> > +/*
> > + * kCFI						FineIBT
> > + *
> > + * __cfi_\func:					__cfi_\func:
> > + *	movl   $0x12345678,%eax			     endbr64			// 4
> > + *	nop					     subl   $0x12345678,%r10d   // 7
> > + *	nop					     jz     1f			// 2
> > + *	nop					     ud2			// 2
> > + *	nop					1:   nop			// 1
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> > + *	nop
> 
> All the "CFI" naming everywhere is very unfortunate.  We already have
> "call frame information" in both the toolchain and objtool.
> 
> The feature is called "kCFI" anyway, can Clang call the symbols
> '__kcfi_*'?

I think the compiler patch is already merged in clang, not sure that's
still an option, Sami?

> > +++ b/tools/objtool/builtin-check.c
> > @@ -79,6 +79,7 @@ const struct option check_options[] = {
> >  	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"),
> >  	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
> >  	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
> > +	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "generate cfi_sites"),
> 
> "annotate kernel control flow integrity (kCFI) function preambles" ?

Sure.

> > +++ b/tools/objtool/check.c
> > @@ -861,6 +861,62 @@ static int create_ibt_endbr_seal_section
> >  	return 0;
> >  }
> >  
> > +static int create_cfi_sections(struct objtool_file *file)
> > +{
> > +	struct section *sec, *s;
> > +	struct symbol *sym;
> > +	unsigned int *loc;
> > +	int idx;
> > +
> > +	sec = find_section_by_name(file->elf, ".cfi_sites");
> > +	if (sec) {
> > +		INIT_LIST_HEAD(&file->call_list);
> > +		WARN("file already has .cfi_sites section, skipping");
> > +		return 0;
> > +	}
> > +
> > +	idx = 0;
> > +	for_each_sec(file, s) {
> > +		if (!s->text)
> > +			continue;
> > +
> > +		list_for_each_entry(sym, &s->symbol_list, list) {
> > +			if (strncmp(sym->name, "__cfi_", 6))
> > +				continue;
> 
> Also make sure it's STT_FUNC.

OK.
