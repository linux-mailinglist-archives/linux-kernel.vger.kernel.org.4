Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F35BFF25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIUNua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIUNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:50:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F96C752;
        Wed, 21 Sep 2022 06:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B9B62FCB;
        Wed, 21 Sep 2022 13:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99485C433D6;
        Wed, 21 Sep 2022 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663768225;
        bh=zTh4qQT1s9+G0FBfnYWuyD5Y3A+QJXtizOEpvE1gENU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvohrLx6BYTeRsjxL3bq+W2OjquKXZQG0y8KazUxM1pUOtCfvd2RoK+bxPJSdxOEL
         nDm1ktJ4HA6Jatle8dxhuCAs4ivD4DDd+aO3LMRGCWDUJqH73HbUxIlXmrIh6JNpc3
         rV50Bptpft/CbVrnqJVyXPXC8wxwEMVTG+7ILonnkF7aaQ0mQKC449aaAD9pUmafOL
         SHfa5Pdn9YqnDq6xKdHJJ9jQxBL8mU6nyQJTnbEiMXyGGu3tXFDWcVLFh2OHozfxFs
         dHFX0po+fbArP/npNzWlx3n+VQPUiAxwqUMOjLSxW2DVoXenK0frhUmqjSVQQ9S/+S
         K3zUR6ywZUlEw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08E1340856; Wed, 21 Sep 2022 14:50:23 +0100 (IST)
Date:   Wed, 21 Sep 2022 14:50:23 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf record: Save DSO build-ID for synthesizing
Message-ID: <YysWn/W3+dXlZnYG@kernel.org>
References: <20220920222822.2171056-1-namhyung@kernel.org>
 <20220920222822.2171056-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920222822.2171056-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 20, 2022 at 03:28:22PM -0700, Namhyung Kim escreveu:
> When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> it has no idea if it's done already.  Maintain a dsos to check that and skip
> the file access if possible.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> v2 change)
>  * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)

Will wait till I merge perf/urgent into perf/core so that this applies.

- Arnaldo
 
>  tools/perf/util/synthetic-events.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 289ea17ac5f7..cccd293b5312 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -364,11 +364,14 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  }
>  
>  static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
> +					     struct machine *machine,
>  					     bool is_kernel)
>  {
>  	struct build_id bid;
>  	struct nsinfo *nsi;
>  	struct nscookie nc;
> +	struct dso *dso = NULL;
> +	struct dso_id id;
>  	int rc;
>  
>  	if (is_kernel) {
> @@ -376,6 +379,18 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  		goto out;
>  	}
>  
> +	id.maj = event->maj;
> +	id.min = event->min;
> +	id.ino = event->ino;
> +	id.ino_generation = event->ino_generation;
> +
> +	dso = dsos__findnew_id(&machine->dsos, event->filename, &id);
> +	if (dso && dso->has_build_id) {
> +		bid = dso->bid;
> +		rc = 0;
> +		goto out;
> +	}
> +
>  	nsi = nsinfo__new(event->pid);
>  	nsinfo__mountns_enter(nsi, &nc);
>  
> @@ -391,12 +406,16 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
>  		event->__reserved_1 = 0;
>  		event->__reserved_2 = 0;
> +
> +		if (dso && !dso->has_build_id)
> +			dso__set_build_id(dso, &bid);
>  	} else {
>  		if (event->filename[0] == '/') {
>  			pr_debug2("Failed to read build ID for %s\n",
>  				  event->filename);
>  		}
>  	}
> +	dso__put(dso);
>  }
>  
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool,
> @@ -507,7 +526,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  		event->mmap2.tid = pid;
>  
>  		if (symbol_conf.buildid_mmap2)
> -			perf_record_mmap2__read_build_id(&event->mmap2, false);
> +			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
>  
>  		if (perf_tool__process_synth_event(tool, event, machine, process) != 0) {
>  			rc = -1;
> @@ -690,7 +709,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
>  			memcpy(event->mmap2.filename, pos->dso->long_name,
>  			       pos->dso->long_name_len + 1);
>  
> -			perf_record_mmap2__read_build_id(&event->mmap2, false);
> +			perf_record_mmap2__read_build_id(&event->mmap2, machine, false);
>  		} else {
>  			size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
>  			event->mmap.header.type = PERF_RECORD_MMAP;
> @@ -1126,7 +1145,7 @@ static int __perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
>  		event->mmap2.len   = map->end - event->mmap.start;
>  		event->mmap2.pid   = machine->pid;
>  
> -		perf_record_mmap2__read_build_id(&event->mmap2, true);
> +		perf_record_mmap2__read_build_id(&event->mmap2, machine, true);
>  	} else {
>  		size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
>  				"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
> -- 
> 2.37.3.968.ga6b4b080e4-goog

-- 

- Arnaldo
