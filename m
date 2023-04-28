Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010676F16F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjD1LoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjD1LoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:44:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43EB527E;
        Fri, 28 Apr 2023 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p3Oy8/XFssf434wpPuB8bKcFx8SHb9PcbiyecF6e45Q=; b=lOhHWODdlld7cJYyZV8Nq1qime
        Z2CLZ0SsBONImZx92ZRCif2HiRNPBfCRPyjScGL+RJ5/5X74WFOvkN4/if0/oJlI6dfVDrR93EfdA
        UYLsx21Jt8q+Lef+JkzV/UMoeaDx2xXVbc7nK/cPMnBcYwe3eiavEjKPVBgKaWqNqa/r5vgaJyHTk
        jBYAnXsEMdYL6BgIZJtzuujR/c7dO9Pf4exKTMwgs5ycMiUIXp3e3TpiGrxYQfx9E+hl3MygA3xtN
        RC4P+lEk0Cs/QY40D5XGgppLJRJGu9sbCLRKKbPP8RxKL+Wlagyz9HO6PEQ3LGM3n7tJ9a34Oc0xc
        YLasnXPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1psMVp-004XzS-Mq; Fri, 28 Apr 2023 11:43:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3E68300581;
        Fri, 28 Apr 2023 13:43:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB13C3221A782; Fri, 28 Apr 2023 13:43:38 +0200 (CEST)
Date:   Fri, 28 Apr 2023 13:43:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH RFC 33/43] objtool: Add validation for x86 PIE support
Message-ID: <20230428114338.GB1449475@hirez.programming.kicks-ass.net>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <226af8c63c5bfa361763dd041a997ee84fe926cf.1682673543.git.houwenlong.hwl@antgroup.com>
 <461b3a8d-9ad4-7866-f3b2-369de75fd2e1@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461b3a8d-9ad4-7866-f3b2-369de75fd2e1@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 10:28:19AM +0000, Christophe Leroy wrote:


> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 5b600bbf2389..d67b80251eec 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -131,6 +131,27 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
> >          for (insn = next_insn_same_sec(file, insn); insn;               \
> >               insn = next_insn_same_sec(file, insn))
> > 
> > +static struct instruction *find_insn_containing(struct objtool_file *file,
> > +                                               struct section *sec,
> > +                                               unsigned long offset)
> > +{
> > +       struct instruction *insn;
> > +
> > +       insn = find_insn(file, sec, 0);
> > +       if (!insn)
> > +               return NULL;
> > +
> > +       sec_for_each_insn_from(file, insn) {
> > +               if (insn->offset > offset)
> > +                       return NULL;
> > +               if (insn->offset <= offset && (insn->offset + insn->len) > offset)
> > +                       return insn;
> > +       }
> > +
> > +       return NULL;
> > +}

Urgh, this is horrendous crap. Yes you're only using it in case of a
warning, but adding a function like this makes it appear like it's
actually sane to use.

A far better implementation -- but still not stellar -- would be
something like:

	sym = find_symbol_containing(sec, offset);
	if (!sym)
		// fail
	sym_for_each_insn(file, sym, insn) {
		...
	}

But given insn_hash uses sec_offset_hash() you can do something similar
to find_reloc_by_dest_range()

	start = offset - (INSN_MAX_SIZE - 1);
	for_offset_range(o, start, start + INSN_MAX_SIZE) {
		hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, o)) {
			if (insn->sec != sec)
				continue;

			if (insn->offset <= offset &&
			    insn->offset + inns->len > offset)
				return insn;
		}
	}
	return NULL;

> > +
> > +
> >   static inline struct symbol *insn_call_dest(struct instruction *insn)
> >   {
> >          if (insn->type == INSN_JUMP_DYNAMIC ||
> > @@ -4529,6 +4550,61 @@ static int validate_reachable_instructions(struct objtool_file *file)
> >          return 0;
> >   }
> > 
> > +static int is_in_pvh_code(struct instruction *insn)
> > +{
> > +       struct symbol *sym = insn->sym;
> > +
> > +       return sym && !strcmp(sym->name, "pvh_start_xen");
> > +}
> > +
> > +static int validate_pie(struct objtool_file *file)
> > +{
> > +       struct section *sec;
> > +       struct reloc *reloc;
> > +       struct instruction *insn;
> > +       int warnings = 0;
> > +
> > +       for_each_sec(file, sec) {
> > +               if (!sec->reloc)
> > +                       continue;
> > +               if (!(sec->sh.sh_flags & SHF_ALLOC))
> > +                       continue;
> > +
> > +               list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> > +                       switch (reloc->type) {
> > +                       case R_X86_64_NONE:
> > +                       case R_X86_64_PC32:
> > +                       case R_X86_64_PLT32:
> > +                       case R_X86_64_64:
> > +                       case R_X86_64_PC64:
> > +                       case R_X86_64_GOTPCREL:
> > +                               break;
> > +                       case R_X86_64_32:
> > +                       case R_X86_64_32S:
> 
> That looks very specific to X86, should it go at another place ?
> 
> If it can work for any architecture, can you add generic macros, just 
> like commit c1449735211d ("objtool: Use macros to define arch specific 
> reloc types") then commit c984aef8c832 ("objtool/powerpc: Add --mcount 
> specific implementation") ?

Yes, this should be something like arch_PIE_reloc() or so. Similar to
arch_pc_relative_reloc().
