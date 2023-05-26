Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB0712C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjEZSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBFBC;
        Fri, 26 May 2023 11:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81DB965216;
        Fri, 26 May 2023 18:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D33C433D2;
        Fri, 26 May 2023 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685125323;
        bh=pTVkh6fAtAW06pgHJybZYnhMRrsdxJAwfCoTL1SGV8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ct+krYMT71oWNsyXvFLRlwHmI4uXiIlibU9JpUiGdj/tsc/fdwULEWOI2NIOQdiqF
         V7FvlQ8ndK7APEOq1bYGz3fT3JyNOUQjHG9fkihEPJNpOzx+tuthZKd3eyZhXXWt4K
         DQhIXDaEYES4znsoxYkIAJ4/DSt5kRenGM6TZaq5MWvkjb4TdPJiO/bgK616IZy4je
         Q93nusgo4NAOWHfcD+qeON4h05/7ycVbu4yUfOqQ6MSO05l7lMH9YSS9pTYZzcFsXX
         edCHV7iBL6KQY6udb7C5XzpkrPnGXcezYRmYdaKSRHlh02oIbicOVfZr66LjZyEpsO
         J8Jq5E4a7HgrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E7E7403B5; Fri, 26 May 2023 15:22:01 -0300 (-03)
Date:   Fri, 26 May 2023 15:22:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf bpf filter: Fix a broken perf sample data naming in
 BPF
Message-ID: <ZHD4yTkysn5LJZA6@kernel.org>
References: <20230525000307.3202449-1-namhyung@kernel.org>
 <64705755d6ae_2023020859@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64705755d6ae_2023020859@john.notmuch>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 25, 2023 at 11:53:09PM -0700, John Fastabend escreveu:
> Namhyung Kim wrote:
> > BPF CO-RE requires 3 underscores for the ignored suffix rule but it
> > mistakenly used only 2.  Let's fix it.
> > 
> > Fixes: 3a8b8fc31748 ("perf bpf filter: Support pre-5.16 kernels where 'mem_hops' isn't in 'union perf_mem_data_src'")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > index cffe493af1ed..fb94f5280626 100644
> > --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> > @@ -25,7 +25,7 @@ struct perf_sample_data___new {
> >  } __attribute__((preserve_access_index));
> >  
> >  /* new kernel perf_mem_data_src definition */
> > -union perf_mem_data_src__new {
> > +union perf_mem_data_src___new {
> >  	__u64 val;
> >  	struct {
> >  		__u64   mem_op:5,	/* type of opcode */
> > @@ -108,7 +108,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
> >  		if (entry->part == 7)
> >  			return kctx->data->data_src.mem_blk;
> >  		if (entry->part == 8) {
> > -			union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
> > +			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
> >  
> >  			if (bpf_core_field_exists(data->mem_hops))
> >  				return data->mem_hops;
> > -- 
> > 2.41.0.rc0.172.g3f132b7071-goog
> > 
> > 
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>

Thanks, applied.

- Arnaldo

