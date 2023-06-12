Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70D72CD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjFLRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFLRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D152DB;
        Mon, 12 Jun 2023 10:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A4B62C5D;
        Mon, 12 Jun 2023 17:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB9DC433D2;
        Mon, 12 Jun 2023 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686591636;
        bh=DBOArNbl1Gan2eVetkUGytlr1Ev3uY469ssfcHd7XhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGFvoH3vAImrBE2n2TAYr9cne12VdZuPDzNKkd0y9oCt1WC818DoUOkPc8+vwee1O
         wXYGoY7HiZ3kd3poKmzalHKIV8HK7aK9C3RFxieBKGRvfG7V1L6In8BVt+5olkEpoM
         GW5taIhNUN+BuJagSRIJtGwPlMmbhTxJAIvhiNBiFoCgztvXZHnkggMlkUxc/6soSX
         lcxBeBeOjYSMYudOQmskNn2eJSCM0xXG/K8eM0wGvDf94vGyskk7mZxgKmQrx1ERwO
         qkTR1XLN8RcOM1kmEH0s9BeiQ9k2TXKpaAVazT1Z+ueQalULjXE/RcXPEZku1GN5F1
         JB/TNRY8Nqukw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4850140692; Mon, 12 Jun 2023 14:40:33 -0300 (-03)
Date:   Mon, 12 Jun 2023 14:40:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf map: Fix refcount errors on Arm with
 -DREFCNT_CHECKING=1
Message-ID: <ZIdYkRHj8tkaxgED@kernel.org>
References: <20230612150424.198914-1-james.clark@arm.com>
 <CAP-5=fWu0yCSCB__prps2g=JRDScbhWuimPJHUsU0S_c0ywDhg@mail.gmail.com>
 <ZIdWBl+MZYKI83Mb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIdWBl+MZYKI83Mb@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 12, 2023 at 02:29:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jun 12, 2023 at 09:32:30AM -0700, Ian Rogers escreveu:
> > On Mon, Jun 12, 2023 at 8:05 AM James Clark <james.clark@arm.com> wrote:
> > >
> > > When quitting after running a perf report, the refcount checker finds
> > > some double frees. The issue is that map__put() is called on a function
> > > argument so it removes the refcount wrapper that someone else was using.
> > >
> > > Fix it by only calling map__put() on a reference that is owned by this
> > > function.
> > >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > > ---
> > >  tools/perf/util/symbol-elf.c | 9 +++++----
> > >  tools/perf/util/symbol.c     | 9 +++++----
> > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > > index 63882a4db5c7..ec0d7810bbb0 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -1365,6 +1365,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> > >         struct dso *curr_dso = *curr_dsop;
> > >         struct map *curr_map;
> > >         char dso_name[PATH_MAX];
> > > +       struct map *map_ref;
> > 
> > nit: can we narrow the scope of this by moving it to the scope where it is used.
> 
> Which is what you did in a patch I already processed, its only in
> tmp.perf-tools-next as I was going thru the other patches, but this one
> is there already.
> 
> I'm checking the tools/perf/util/symbol.c part.

I narrowed the scope and removed the symbol-elf.c part, end result:

From 6fd34445b8c94aa7f519fb0b1ed45c7ef9f6cc4e Mon Sep 17 00:00:00 2001
From: James Clark <james.clark@arm.com>
Date: Mon, 12 Jun 2023 16:04:24 +0100
Subject: [PATCH 1/1] perf map: Fix double 'struct map' reference free found
 with -DREFCNT_CHECKING=1

When quitting after running a 'perf report', the refcount checker finds
some double frees. The issue is that map__put() is called on a function
argument so it removes the refcount wrapper that someone else was using.

Fix it by only calling map__put() on a reference that is owned by this
function.

Committer notes:

Narrowed the map_ref scope as suggested by Ian, removed the symbol-elf
part as it was already fixed by another patch, from Ian.

Signed-off-by: James Clark <james.clark@arm.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230612150424.198914-1-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6b9c55784b56a4be..d275d3bef7d54a40 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1458,16 +1458,18 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		list_del_init(&new_node->node);
 
 		if (RC_CHK_ACCESS(new_map) == RC_CHK_ACCESS(replacement_map)) {
+			struct map *map_ref;
+
 			map__set_start(map, map__start(new_map));
 			map__set_end(map, map__end(new_map));
 			map__set_pgoff(map, map__pgoff(new_map));
 			map__set_map_ip(map, map__map_ip_ptr(new_map));
 			map__set_unmap_ip(map, map__unmap_ip_ptr(new_map));
 			/* Ensure maps are correctly ordered */
-			map__get(map);
-			maps__remove(kmaps, map);
-			err = maps__insert(kmaps, map);
-			map__put(map);
+			map_ref = map__get(map);
+			maps__remove(kmaps, map_ref);
+			err = maps__insert(kmaps, map_ref);
+			map__put(map_ref);
 			map__put(new_map);
 			if (err)
 				goto out_err;
-- 
2.37.1

