Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C676E0C61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDMLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDMLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:24:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F0393EA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1I4etcfiRyCSA4iLI5RjXTzObddm+AdCsg9VNZ/Ehx8=; b=UKrR1XZL+HX/p5lntf9fxkXJ6y
        iPtSSjiJcHN9lxnf4+zibGFFOnc1sUXOyD6Cd2wkq/bAHTfhG7tJ8QYh5fMsHhMkOyinQzjt0v0Xy
        gfNS5vH7QOccE4rvNG3M329G63ijygtXDoNd1m9fkF0zVo3i7+vHe7F0yFIYf1vbCOkuisZByR4Cg
        QbEqsTD8zxbJIfvjFkMi+dgDFRwAmdB6Ums01YNlbmeg2jh7GSW6k/ipAU5XtjiWyRAku1u4weEwZ
        wxkb6qPxYBXAZq+pbystTZFXaUc28UNnH2dZRPxH86Rh0umx+yjgDJpZYz/oesmqOqJTVBFNvr7/s
        5LKbnzxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmv3y-00Eihp-2L;
        Thu, 13 Apr 2023 11:24:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F5CC30002F;
        Thu, 13 Apr 2023 13:24:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EBDE267A808D; Thu, 13 Apr 2023 13:24:26 +0200 (CEST)
Date:   Thu, 13 Apr 2023 13:24:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 3/3] objtool: Generate ORC data for __pfx code
Message-ID: <20230413112426.GM4253@hirez.programming.kicks-ass.net>
References: <cover.1681331135.git.jpoimboe@kernel.org>
 <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3344e51f3e87102f1301a0be0f72a7689ea4a4.1681331135.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:26:15PM -0700, Josh Poimboeuf wrote:
> Allow unwinding from prefix code by copying the CFI from the starting
> instruction of the corresponding function.  Even when the NOPs are
> replaced, they're still stack-invariant instructions so the same ORC
> entry can be reused everywhere.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 2f3136145b2e..3f27a0278bf8 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4123,6 +4123,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
>  static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
>  {
>  	struct instruction *insn, *prev;
> +	struct cfi_state *cfi;
>  
>  	insn = find_insn(file, func->sec, func->offset);
>  	if (!insn)
> @@ -4151,6 +4152,19 @@ static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
>  	if (!prev)
>  		return -1;
>  
> +	if (!insn->cfi) {
> +		/*
> +		 * This can happen if stack validation isn't enabled or the
> +		 * function is annotated with STACK_FRAME_NON_STANDARD.
> +		 */
> +		return 0;
> +	}
> +
> +	/* Propagate insn->cfi to the prefix code */
> +	cfi = cfi_hash_find_or_add(insn->cfi);
> +	for (; prev != insn; prev = next_insn_same_sec(file, prev))
> +		prev->cfi = cfi;
> +
>  	return 0;
>  }

FWIW, this makes the whole thing hard rely on the prefix being single
byte NOPs -- which they are, but perhaps we should assert this?
