Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB83E6872A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBBBA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBBBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:00:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E005C0F9;
        Wed,  1 Feb 2023 17:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66D59619BA;
        Thu,  2 Feb 2023 01:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9989CC433D2;
        Thu,  2 Feb 2023 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675299654;
        bh=wPPcyoksH9Ff/Pc0cGKVYYC4iNhKHyL6DmBiuX/Ypi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pauJBK1JegDeIVnk3kBO/3jkwiE5BhBFMkTkNjOVIJMogulN4zUs2qdshzkfZGZ3t
         jpmqtNkbFIdakbOTdbagpF9P0uSXHft/WDb3W7ndXPfRaUYX9D4Ga25h1iPEdwG+l1
         20lSYX53+5ioynsEy4LMYwJWwQh3HHTysQqAd8Caw0SxA9gYHby7J5U0ULfnatDv3B
         sucLihTlK4SkBqljONcuDfqQBGBz4DBWyDV5hPKpwj72AaGFy7UzFy4eCCMt4LUvnY
         QRsH6sC71mhQZMOArq7drcYsyuuoIPbGrR4GeufAD5OdH/0QIwfPqoxMwxc9T6N4As
         mdsK1c4Lz7YUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A6A1405BE; Wed,  1 Feb 2023 22:00:51 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:00:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>
Subject: Re: [PATCH v2] perf/util: Symbol lookup with kcore can fail if
 multiple segments match stext
Message-ID: <Y9sLQ1Iy5LJAaJ8L@kernel.org>
References: <20230124223531.GB1962@templeofstupid.com>
 <20230125183418.GD1963@templeofstupid.com>
 <7b5f872a-f52e-7129-e956-90e97ec7d911@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b5f872a-f52e-7129-e956-90e97ec7d911@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 03:29:54PM +0200, Adrian Hunter escreveu:
> On 25/01/23 20:34, Krister Johansen wrote:
> > This problem was encountered on an arm64 system with a lot of memory.
> > Without kernel debug symbols installed, and with both kcore and kallsyms
> > available, perf managed to get confused and returned "unknown" for all
> > of the kernel symbols that it tried to look up.
> > 
> > On this system, stext fell within the vmalloc segment.  The kcore symbol
> > matching code tries to find the first segment that contains stext and
> > uses that to replace the segment generated from just the kallsyms
> > information.  In this case, however, there were two: a very large
> > vmalloc segment, and the text segment.  This caused perf to get confused
> > because multiple overlapping segments were inserted into the RB tree
> > that holds the discovered segments.  However, that alone wasn't
> > sufficient to cause the problem. Even when we could find the segment,
> > the offsets were adjusted in such a way that the newly generated symbols
> > didn't line up with the instruction addresses in the trace.  The most
> > obvious solution would be to consult which segment type is text from
> > kcore, but this information is not exposed to users.
> > 
> > Instead, select the smallest matching segment that contains stext
> > instead of the first matching segment.  This allows us to match the text
> > segment instead of vmalloc, if one is contained within the other.
> > 
> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> > v2:
> >   - Correct whitespace, add comments, and fix-up subject. (Feedback from Adrian
> >     Hunter)
> > ---
> >  tools/perf/util/symbol.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index a3a165ae933a..98014f937568 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1368,10 +1368,23 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >  
> >  	/* Find the kernel map using the '_stext' symbol */
> >  	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
> > +		u64 replacement_size = 0;
> > +
> >  		list_for_each_entry(new_map, &md.maps, node) {
> > -			if (stext >= new_map->start && stext < new_map->end) {
> > +			u64 new_size = new_map->end - new_map->start;
> > +
> > +			if (!(stext >= new_map->start && stext < new_map->end))
> > +				continue;
> > +
> > +			/*
> > +			 * On some architectures, ARM64 for example, the kernel
> > +			 * text can get allocated inside of the vmalloc segment.
> > +			 * Select the smallest matching segment, in case stext
> > +			 * falls within more than one in the list.
> > +			 */
> > +			if (!replacement_map || new_size < replacement_size) {
> >  				replacement_map = new_map;
> > -				break;
> > +				replacement_size = new_size;
> >  			}
> >  		}
> >  	}
> 

-- 

- Arnaldo
