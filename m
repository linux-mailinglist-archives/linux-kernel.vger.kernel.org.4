Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871316CD9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjC2Mxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjC2Mxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDD61BFF;
        Wed, 29 Mar 2023 05:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7906461CFB;
        Wed, 29 Mar 2023 12:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60B1C4339B;
        Wed, 29 Mar 2023 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680094409;
        bh=Ghm8hHqhiVj0646dEKOA4hsdTdEvz7tWVhdmECwOt1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHGh5l6lTE/wa1kgNtZWAHbjWrMVK2NJ7NV0v5NGQ0E0v4cppSLcPBWtKcahAX5TW
         HFRoR0f0f7qyZJH0/KtBBQydkzmfeO9sRM6gf9r036ecwi+8iALee66axIOVhrgz1F
         LXnbOStRMJxdlb19uok8hEN1c2SAkHCsda3PIEVEU06/cviEx9WNIsn3yIpKauxsL8
         GxJ8CZWlrI/v5Z2l9jQSXvaPQxq7rlc7ObH/f34iwr2SM4Q2qf0ULlpLVQvVGTJdPJ
         aREbzP0mC9QHnpQlfBcjYsf/EF/LYR7d19hbm1RKFKrOfBzpLmt2aeUlvRXNqpd3Co
         nBZXVRCl9PKCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F0B04052D; Wed, 29 Mar 2023 09:53:27 -0300 (-03)
Date:   Wed, 29 Mar 2023 09:53:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf symbol: Avoid use after free
Message-ID: <ZCQ0x2Ytd22AiabX@kernel.org>
References: <20230328234413.1081014-1-irogers@google.com>
 <67d81a70-1adc-dad4-4592-5e7d67e6c926@intel.com>
 <CAP-5=fXhc-nwVp=HKmycmryYSY6sBrDKGnQ+Ogt+86sHfsT82Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXhc-nwVp=HKmycmryYSY6sBrDKGnQ+Ogt+86sHfsT82Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 28, 2023 at 10:35:07PM -0700, Ian Rogers escreveu:
> On Tue, Mar 28, 2023 at 9:52 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 29/03/23 02:44, Ian Rogers wrote:
> > > If demangling succeeds then sym_name is set to the demangled string
> > > that is freed. Rather than test if sym_name is empty and possibly
> > > use-after-free on the return path, expand out the alternatives.
> >
> > Looks the same as:
> >
> > https://lore.kernel.org/linux-perf-users/20230316194156.8320-2-adrian.hunter@intel.com/
> 
> Sorry for missing that. In the case it returns false, this avoids an
> unnecessary snprintf.

I applied Adrian's fixes,

- Arnaldo
 
> Thanks,
> Ian
> 
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/symbol-elf.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > > index c0a2de42c51b..b7e3e492bff3 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -577,15 +577,17 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
> > >       /* Get the associated symbol */
> > >       gelf_getsym(di->dynsym_data, vr->sym_idx, &sym);
> > >       sym_name = elf_sym__name(&sym, di->dynstr_data);
> > > -     demangled = demangle_sym(di->dso, 0, sym_name);
> > > -     if (demangled != NULL)
> > > -             sym_name = demangled;
> > > -
> > > -     snprintf(buf, buf_sz, "%s@plt", sym_name);
> > > -
> > > -     free(demangled);
> > > +     if (*sym_name == '\0')
> > > +             return false;
> > >
> > > -     return *sym_name;
> > > +     demangled = demangle_sym(di->dso, 0, sym_name);
> > > +     if (demangled != NULL) {
> > > +             snprintf(buf, buf_sz, "%s@plt", demangled);
> > > +             free(demangled);
> > > +     } else {
> > > +             snprintf(buf, buf_sz, "%s@plt", sym_name);
> > > +     }
> > > +     return true;
> > >  }
> > >
> > >  static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
> >

-- 

- Arnaldo
