Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238D74F004
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGKNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C312F;
        Tue, 11 Jul 2023 06:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF002614DD;
        Tue, 11 Jul 2023 13:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04486C433C8;
        Tue, 11 Jul 2023 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689081606;
        bh=uOS4JfNufBFC0X+cPyi5FCg/wfbG6rddahqbtej+cxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jtIZOuwVUA6gRzzifFEtONSM8PLmeN4AmB5mo68yP9DT34i44Aa22wqsbGhjsCT8J
         ZPXjkFA8ZD6l9Km+x9yAaekLi//ruuOFKGDVdIbCKBweHTTwCYQvUSYjSc3Ze3SOfU
         JqrNdXZoBar9mDR5v8LW5NYZrIMK4nqAQgmlsM/Ruiv9/sPZQJW/jl7HSxT4CCgkfl
         JeeZjHd9IXp7UyoLjnpIeu7ROxLcYRuqFlc68iyXBPsxa0KrxpxjmjzxHg/i/FpUoN
         P9PhfeuvKLLlYn0K4D5Q7LdM3eYPjVmCOnq11N0tRkUYRuC/Apwp7IBG5MWp7eiPEa
         EzK+qIxMkDD6g==
Date:   Tue, 11 Jul 2023 22:20:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Georg =?UTF-8?B?TcO8bGxlcg==?= <georgmueller@gmx.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: read DWARF files from the correct CU
Message-Id: <20230711222000.d316cf7fd643cb4203ea1204@kernel.org>
In-Reply-To: <ZK1RyVue7OMXzVl4@kernel.org>
References: <5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net>
        <20230615200147.664346-3-georgmueller@gmx.net>
        <ZK1RyVue7OMXzVl4@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 09:57:45 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Jun 15, 2023 at 10:01:37PM +0200, Georg Müller escreveu:
> > After switching from dwarf_decl_file() to die_get_decl_file(), it is not
> > possible to add probes for certain functions of certain binaries:
> > 
> >  $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
> >  A function DIE doesn't have decl_line. Maybe broken DWARF?
> >  A function DIE doesn't have decl_line. Maybe broken DWARF?
> >  Probe point 'match_unit_removed' not found.
> >     Error: Failed to add events.
> > 
> > The problem is that die_get_decl_file() uses the wrong CU to search for
> > the file. elfutils commit e1db5cdc9f has some good explanation for this:
> > 
> >     dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_file
> >     attribute. This means the attribute might come from a different DIE
> >     in a different CU. If so, we need to use the CU associated with the
> >     attribute, not the original DIE, to resolve the file name.
> > 
> > This patch uses the same source of information as elfutils: use attribute
> > DW_AT_decl_file and use this CU to search for the file.
> 
> Thanks, applied to the perf-tools branch, that will be submitted for
> Linux v6.5.

Thanks Arnaldo and Georg,

It sounds perfect reason why that happened. I didn't expect the case that
the attribute comes from another CU...

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> - Arnaldo
>  
> > Fixes: dc9a5d2ccd5c ("perf probe: Fix to get declared file name from clang DWARF5")
> > Signed-off-by: Georg Müller <georgmueller@gmx.net>
> > Link: https://lore.kernel.org/r/5a00d5a5-7be7-ef8a-4044-9a16249fff25@gmx.net/
> > ---
> >  tools/perf/util/dwarf-aux.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index b07414409771..137b3ed9897b 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -478,8 +478,10 @@ static const char *die_get_file_name(Dwarf_Die *dw_die, int idx)
> >  {
> >  	Dwarf_Die cu_die;
> >  	Dwarf_Files *files;
> > +	Dwarf_Attribute attr_mem;
> > 
> > -	if (idx < 0 || !dwarf_diecu(dw_die, &cu_die, NULL, NULL) ||
> > +	if (idx < 0 || !dwarf_attr_integrate(dw_die, DW_AT_decl_file, &attr_mem) ||
> > +	    !dwarf_cu_die(attr_mem.cu, &cu_die, NULL, NULL, NULL, NULL, NULL, NULL) ||
> >  	    dwarf_getsrcfiles(&cu_die, &files, NULL) != 0)
> >  		return NULL;
> > 
> > --
> > 2.41.0
> > 
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
