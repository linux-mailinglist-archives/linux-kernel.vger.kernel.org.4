Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0D7333DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345679AbjFPOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbjFPOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:43:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C530F1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Rpo3Qrh1P0e60oXjGYAsbC0oxcG5ErnolcmsNGypPI=; b=LaKMDQQbWuL972NkWJq2jkoAm1
        bE5y26fhj3zZ+y9rmbh/7JV1a5I+6/6egEOvXM1iFCJaKou4QvRffYlRVCPr5nUrP1O4Nw17BP2bn
        1BmQp0XYiXKgfhYhvHhT/9GrqY75mInOZuyycir1NwZQFqkTRMt6RIIgKk2GjYlXTWcvvQgIt1Pq0
        NNVlieQrqkkzhGD2m1Kcgy5NPh8yV4T7yc/yQtYRguS7tFUkk7JBqT2vCFYUnU65P+/HneZ6xNjpg
        psEpKtckF81Z/YGrI9i4jSWqihI18mucRavWqICJUKDxVSDcfsL/YLiOha3rq2ITV6qmcLULbXfvY
        e1ezIavw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qAAfr-0095XF-Cn; Fri, 16 Jun 2023 14:43:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41500300208;
        Fri, 16 Jun 2023 16:43:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2366D2135D73E; Fri, 16 Jun 2023 16:43:37 +0200 (CEST)
Date:   Fri, 16 Jun 2023 16:43:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1 3/3] powerpc: WIP draft support to objtool check
Message-ID: <20230616144337.GQ83892@hirez.programming.kicks-ass.net>
References: <cover.1686922583.git.christophe.leroy@csgroup.eu>
 <8fbf16dd6a89e1b5b05244bd5e0746410674829e.1686922583.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbf16dd6a89e1b5b05244bd5e0746410674829e.1686922583.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Few comments..

On Fri, Jun 16, 2023 at 03:47:52PM +0200, Christophe Leroy wrote:

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0fcf99c91400..f945fe271706 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -236,6 +236,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"x86_64_start_reservations",
>  		"xen_cpu_bringup_again",
>  		"xen_start_kernel",
> +		"longjmp",
>  	};
>  
>  	if (!func)
> @@ -2060,13 +2061,12 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  	 * instruction.
>  	 */
>  	list_for_each_entry_from(reloc, &table->sec->reloc_list, list) {
> -
>  		/* Check for the end of the table: */
>  		if (reloc != table && reloc->jump_table_start)
>  			break;
>  
>  		/* Make sure the table entries are consecutive: */
> -		if (prev_offset && reloc->offset != prev_offset + 8)
> +		if (prev_offset && reloc->offset != prev_offset + 4)

Do we want a global variable (from elf.c) called elf_sizeof_long or so?

>  			break;
>  
>  		/* Detect function pointers from contiguous objects: */
> @@ -2074,7 +2074,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		    reloc->addend == pfunc->offset)
>  			break;
>  
> -		dest_insn = find_insn(file, reloc->sym->sec, reloc->addend);
> +		if (table->jump_table_is_rel)
> +			dest_insn = find_insn(file, reloc->sym->sec, reloc->addend + table->offset - reloc->offset);
> +		else
> +			dest_insn = find_insn(file, reloc->sym->sec, reloc->addend);

		offset = reloc->addend;
		if (table->jump_table_is_rel)
			offset += table->offset - reloc->offset;
		dest_insn = find_insn(file, reloc->sym->sec, offset);

perhaps?

>  		if (!dest_insn)
>  			break;
>  
> @@ -4024,6 +4022,11 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
>  	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
>  		return true;
>  
> +	/* powerpc relocatable files have a word in front of each relocatable function */
> +	if ((file->elf->ehdr.e_machine == EM_PPC || file->elf->ehdr.e_machine == EM_PPC64) &&
> +	    (file->elf->ehdr.e_flags & EF_PPC_RELOCATABLE_LIB) &&
> +	    insn_func(next_insn_same_sec(file, insn)))
> +		return true;

Can't you simply decode that word to INSN_NOP or so?
