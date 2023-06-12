Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5CC72CCE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjFLRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbjFLR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:29:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF519DB;
        Mon, 12 Jun 2023 10:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B888620E7;
        Mon, 12 Jun 2023 17:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F2C433D2;
        Mon, 12 Jun 2023 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590985;
        bh=tVyezW3o2HAblHhWfBLLzXDJWYWq8x5ow1lKCcaOQkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hgXZWmlOMWS0quDcXThICtAZ+0rkyiTG7asel0q5gUhCktm7Oliwo79T3YUOcWqE8
         Q9qPEF4STvIBjwjg9Oa5MJ2tjoIE63DZ3zbk4BTF35APAkJuAYyV71e98NAFYCuG1z
         ZivboAUfiXLvkTA4hJkyEU7WCGwaFNwtYF669u8uNjxHiqUIk5H19neSf9uc0+HgsK
         7LyDMsI+oGuPYVJn3PC0NE3fd892RGzwo96Fcl9wZDfJutPFXH3O3uxffmo+dHUxDa
         rsFElNU+xRUCKgN+jWlWOAOlH04q3NAil12NAR1cjROimwyHUtMeh/NStJvKjZM8i8
         VWhWyhVfikWzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2DC1A40692; Mon, 12 Jun 2023 14:29:42 -0300 (-03)
Date:   Mon, 12 Jun 2023 14:29:42 -0300
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
Message-ID: <ZIdWBl+MZYKI83Mb@kernel.org>
References: <20230612150424.198914-1-james.clark@arm.com>
 <CAP-5=fWu0yCSCB__prps2g=JRDScbhWuimPJHUsU0S_c0ywDhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWu0yCSCB__prps2g=JRDScbhWuimPJHUsU0S_c0ywDhg@mail.gmail.com>
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

Em Mon, Jun 12, 2023 at 09:32:30AM -0700, Ian Rogers escreveu:
> On Mon, Jun 12, 2023 at 8:05 AM James Clark <james.clark@arm.com> wrote:
> >
> > When quitting after running a perf report, the refcount checker finds
> > some double frees. The issue is that map__put() is called on a function
> > argument so it removes the refcount wrapper that someone else was using.
> >
> > Fix it by only calling map__put() on a reference that is owned by this
> > function.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > ---
> >  tools/perf/util/symbol-elf.c | 9 +++++----
> >  tools/perf/util/symbol.c     | 9 +++++----
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index 63882a4db5c7..ec0d7810bbb0 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1365,6 +1365,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> >         struct dso *curr_dso = *curr_dsop;
> >         struct map *curr_map;
> >         char dso_name[PATH_MAX];
> > +       struct map *map_ref;
> 
> nit: can we narrow the scope of this by moving it to the scope where it is used.

Which is what you did in a patch I already processed, its only in
tmp.perf-tools-next as I was going thru the other patches, but this one
is there already.

I'm checking the tools/perf/util/symbol.c part.

- Arnaldo
 
> >
> >         /* Adjust symbol to map to file offset */
> >         if (adjust_kernel_syms)
> > @@ -1390,10 +1391,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> >                         if (kmaps) {
> >                                 int err;
> >
> > -                               map__get(map);
> > -                               maps__remove(kmaps, map);
> > -                               err = maps__insert(kmaps, map);
> > -                               map__put(map);
> > +                               map_ref = map__get(map);
> > +                               maps__remove(kmaps, map_ref);
> > +                               err = maps__insert(kmaps, map_ref);
> > +                               map__put(map_ref);
> >                                 if (err)
> >                                         return err;
> >                         }
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 6b9c55784b56..b3034fd5c0af 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1368,6 +1368,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >         int err, fd;
> >         char kcore_filename[PATH_MAX];
> >         u64 stext;
> > +       struct map *map_ref;
> 
> nit: can we narrow the scope of this by moving it to the scope where it is used.
> 
> Thanks,
> Ian
> 
> >
> >         if (!kmaps)
> >                 return -EINVAL;
> > @@ -1464,10 +1465,10 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >                         map__set_map_ip(map, map__map_ip_ptr(new_map));
> >                         map__set_unmap_ip(map, map__unmap_ip_ptr(new_map));
> >                         /* Ensure maps are correctly ordered */
> > -                       map__get(map);
> > -                       maps__remove(kmaps, map);
> > -                       err = maps__insert(kmaps, map);
> > -                       map__put(map);
> > +                       map_ref = map__get(map);
> > +                       maps__remove(kmaps, map_ref);
> > +                       err = maps__insert(kmaps, map_ref);
> > +                       map__put(map_ref);
> >                         map__put(new_map);
> >                         if (err)
> >                                 goto out_err;
> > --
> > 2.34.1
> >

-- 

- Arnaldo
