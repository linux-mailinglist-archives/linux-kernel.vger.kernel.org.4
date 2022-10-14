Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EFF5FF44D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJNUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJNUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181541D81A4;
        Fri, 14 Oct 2022 13:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A330361C21;
        Fri, 14 Oct 2022 20:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4887C433D6;
        Fri, 14 Oct 2022 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665778158;
        bh=ACIavGWuHHjo4qJ/zfSJg2qQbJjr1pDrG1EYEd+FsYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJUQLS80RP934Y58s/J7kwVFaLeyblbG2n6qc/cthLttwUb9RJKQ90eKYAsmxDzK/
         JFMeORWy8l6LBeq+sEob1QOL268iwoK5/jU8OpkQyVYOuUOP6iAoom0lOt2NKH0xaU
         LrB7xSz4Uv6k5TP0rwWplcn3CG9kWmW3ONULigZ4MS4ds//pv+kz5DcYfh60h7p7EC
         D2ANLotcj+g0x5hZwW3sGq12MtG6ytJk3B16DDarm66ZWkTLQlEYQeisrEh/TI2sTX
         Uv00EJklwEI0YpKN2y+YQxrsqs2IpAyZyq1FTscEmT5v5xXOgE471BsqL3419VIkh9
         Q3HRKT5NfH7yw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E30774062C; Fri, 14 Oct 2022 17:09:15 -0300 (-03)
Date:   Fri, 14 Oct 2022 17:09:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf intel-pt: Fix system_wide dummy event for hybrid
Message-ID: <Y0nB6wPETSXfUHYC@kernel.org>
References: <20221012082259.22394-1-adrian.hunter@intel.com>
 <20221012082259.22394-3-adrian.hunter@intel.com>
 <CAM9d7chCGw-iXUiD+Bj3azTdVdYz21KtBOhR5ZbLoVuFXE6nbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chCGw-iXUiD+Bj3azTdVdYz21KtBOhR5ZbLoVuFXE6nbA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 12, 2022 at 09:25:14AM -0700, Namhyung Kim escreveu:
> On Wed, Oct 12, 2022 at 1:23 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > User space tasks can migrate between CPUs, so when tracing selected CPUs,
> > system-wide sideband is still needed, however evlist->core.has_user_cpus
> > is not set in the hybrid case, so check the target cpu_list instead.
> >
> > Fixes: 7d189cadbeeb ("perf intel-pt: Track sideband system-wide when needed")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied both fixes.

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/arch/x86/util/intel-pt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> > index 793b35f2221a..af102f471e9f 100644
> > --- a/tools/perf/arch/x86/util/intel-pt.c
> > +++ b/tools/perf/arch/x86/util/intel-pt.c
> > @@ -866,7 +866,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> >                  * User space tasks can migrate between CPUs, so when tracing
> >                  * selected CPUs, sideband for all CPUs is still needed.
> >                  */
> > -               need_system_wide_tracking = evlist->core.has_user_cpus &&
> > +               need_system_wide_tracking = opts->target.cpu_list &&
> >                                             !intel_pt_evsel->core.attr.exclude_user;
> >
> >                 tracking_evsel = evlist__add_aux_dummy(evlist, need_system_wide_tracking);
> > --
> > 2.25.1
> >

-- 

- Arnaldo
