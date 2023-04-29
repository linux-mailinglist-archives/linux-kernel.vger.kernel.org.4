Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB40C6F22CA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjD2EEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjD2EE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:04:29 -0400
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286F2719;
        Fri, 28 Apr 2023 21:04:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047202;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---.STnJpK0_1682741061;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STnJpK0_1682741061)
          by smtp.aliyun-inc.com;
          Sat, 29 Apr 2023 12:04:22 +0800
Date:   Sat, 29 Apr 2023 12:04:21 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Thomas =?utf-8?B?V2Vp77+9c2NodWg=?=" <linux@weissschuh.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH RFC 33/43] objtool: Add validation for x86 PIE support
Message-ID: <20230429040421.GB126816@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <226af8c63c5bfa361763dd041a997ee84fe926cf.1682673543.git.houwenlong.hwl@antgroup.com>
 <461b3a8d-9ad4-7866-f3b2-369de75fd2e1@csgroup.eu>
 <20230428114338.GB1449475@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428114338.GB1449475@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 07:43:38PM +0800, Peter Zijlstra wrote:
> On Fri, Apr 28, 2023 at 10:28:19AM +0000, Christophe Leroy wrote:
> 
> 
> > > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > > index 5b600bbf2389..d67b80251eec 100644
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -131,6 +131,27 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
> > >          for (insn = next_insn_same_sec(file, insn); insn;               \
> > >               insn = next_insn_same_sec(file, insn))
> > > 
> > > +static struct instruction *find_insn_containing(struct objtool_file *file,
> > > +                                               struct section *sec,
> > > +                                               unsigned long offset)
> > > +{
> > > +       struct instruction *insn;
> > > +
> > > +       insn = find_insn(file, sec, 0);
> > > +       if (!insn)
> > > +               return NULL;
> > > +
> > > +       sec_for_each_insn_from(file, insn) {
> > > +               if (insn->offset > offset)
> > > +                       return NULL;
> > > +               if (insn->offset <= offset && (insn->offset + insn->len) > offset)
> > > +                       return insn;
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> 
> Urgh, this is horrendous crap. Yes you're only using it in case of a
> warning, but adding a function like this makes it appear like it's
> actually sane to use.
> 
> A far better implementation -- but still not stellar -- would be
> something like:
> 
> 	sym = find_symbol_containing(sec, offset);
> 	if (!sym)
> 		// fail
> 	sym_for_each_insn(file, sym, insn) {
> 		...
> 	}
> 
> But given insn_hash uses sec_offset_hash() you can do something similar
> to find_reloc_by_dest_range()
> 
> 	start = offset - (INSN_MAX_SIZE - 1);
> 	for_offset_range(o, start, start + INSN_MAX_SIZE) {
> 		hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, o)) {
> 			if (insn->sec != sec)
> 				continue;
> 
> 			if (insn->offset <= offset &&
> 			    insn->offset + inns->len > offset)
> 				return insn;
> 		}
> 	}
> 	return NULL;
>
Thanks for your suggestion, I'll pick it in the next version.
 
> > > +
> > > +
> > >   static inline struct symbol *insn_call_dest(struct instruction *insn)
> > >   {
> > >          if (insn->type == INSN_JUMP_DYNAMIC ||
> > > @@ -4529,6 +4550,61 @@ static int validate_reachable_instructions(struct objtool_file *file)
> > >          return 0;
> > >   }
> > > 
> > > +static int is_in_pvh_code(struct instruction *insn)
> > > +{
> > > +       struct symbol *sym = insn->sym;
> > > +
> > > +       return sym && !strcmp(sym->name, "pvh_start_xen");
> > > +}
> > > +
> > > +static int validate_pie(struct objtool_file *file)
> > > +{
> > > +       struct section *sec;
> > > +       struct reloc *reloc;
> > > +       struct instruction *insn;
> > > +       int warnings = 0;
> > > +
> > > +       for_each_sec(file, sec) {
> > > +               if (!sec->reloc)
> > > +                       continue;
> > > +               if (!(sec->sh.sh_flags & SHF_ALLOC))
> > > +                       continue;
> > > +
> > > +               list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> > > +                       switch (reloc->type) {
> > > +                       case R_X86_64_NONE:
> > > +                       case R_X86_64_PC32:
> > > +                       case R_X86_64_PLT32:
> > > +                       case R_X86_64_64:
> > > +                       case R_X86_64_PC64:
> > > +                       case R_X86_64_GOTPCREL:
> > > +                               break;
> > > +                       case R_X86_64_32:
> > > +                       case R_X86_64_32S:
> > 
> > That looks very specific to X86, should it go at another place ?
> > 
> > If it can work for any architecture, can you add generic macros, just 
> > like commit c1449735211d ("objtool: Use macros to define arch specific 
> > reloc types") then commit c984aef8c832 ("objtool/powerpc: Add --mcount 
> > specific implementation") ?
> 
> Yes, this should be something like arch_PIE_reloc() or so. Similar to
> arch_pc_relative_reloc().
