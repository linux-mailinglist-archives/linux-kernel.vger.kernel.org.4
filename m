Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726E5F1052
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiI3Q4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiI3Q4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:56:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD891A6EA5;
        Fri, 30 Sep 2022 09:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F9DB82961;
        Fri, 30 Sep 2022 16:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC19C433D7;
        Fri, 30 Sep 2022 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664556967;
        bh=fv9rgvbcr2cSVD9DcqU0Y0j86/fEUEzhMuDoX4SSQVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIbUeKfuWrNG8yUB2RKxRAIkZ+ng2fU62fcjYBcBXzNI/BBMh6hUcoyjZJTRIYiHc
         Xh5LZH+yQDD0sDfx+lCtZTXuDyIfK8HPwcWvm0cmcTZRk8mzrmAqi+hCvKqWh67xEe
         +sKmmDmH6hDb8JK4q6qBY4Y3l+vJo5yWv7fOviBW+3FWuOETcgBnQ0t4dIoBw+Kdt6
         RkQ58zNA27JJBoA1AHrXPpTHr7zC6n2YlaN13SSTjxdwRJ+R5FL+nubtCPuEoEJCK9
         D5n+4X60kwaCAlRFRrn0D6G8gAARvxj05Z6uO2HtDhdA8G8rIwj3nsEV5ZDmcGh1Z+
         o7JpywQCZaXTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EF314062C; Fri, 30 Sep 2022 13:56:05 -0300 (-03)
Date:   Fri, 30 Sep 2022 13:56:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
Message-ID: <Yzcfpez4tLtebdda@kernel.org>
References: <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
 <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com>
 <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
 <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
 <CAM9d7ciDvCOsFE68NG6jRb02DdDEOmRf_h7XizdDLGBz0RX95Q@mail.gmail.com>
 <63905e96-55d5-1aa2-5dbe-167b9aecad8c@intel.com>
 <CAM9d7ciXESTPXZobir4KirSnh1NXHwENc4WpZTudgawUZOL71Q@mail.gmail.com>
 <37452f10-365d-f496-3cb2-b80481f5f079@intel.com>
 <CAM9d7chuK=QqmM=YVFZa9fO6RG7o2gJSrrTMZhegj3sFdLD3mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chuK=QqmM=YVFZa9fO6RG7o2gJSrrTMZhegj3sFdLD3mQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 30, 2022 at 09:44:49AM -0700, Namhyung Kim escreveu:
> On Fri, Sep 30, 2022 at 5:50 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 29/09/22 23:42, Namhyung Kim wrote:
> > > On Wed, Sep 28, 2022 at 10:19 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>
> > >> On 29/09/22 08:09, Namhyung Kim wrote:
> > >>> On Wed, Sep 28, 2022 at 7:08 PM Ian Rogers <irogers@google.com> wrote:
> > >>>>
> > >>>> On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >>>>>
> > >>>>> On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>>>>>
> > >>>>>> On 27/09/22 20:28, Namhyung Kim wrote:
> > >>>>>>> Hi Adrian,
> > >>>>>>>
> > >>>>>>> On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>>>>>>>
> > >>>>>>>> On 24/09/22 19:57, Namhyung Kim wrote:
> > >>>>>>>>> The current code propagate evsel's cpu map settings to evlist when it's
> > >>>>>>>>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> > >>>>>>>>> be updated in perf_evlist__set_maps() later.  No need to do it before
> > >>>>>>>>> evlist's cpus are set actually.
> > >>>>>>>>>
> > >>>>>>>>> Actually we discarded this intermediate all_cpus maps at the beginning
> > >>>>>>>>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> > >>>>>>>>> an evsel is added after the evlist cpu maps are set.
> > >>>>>>>>
> > >>>>>>>> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> > >>>>>>>> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> > >>>>>>>> added to the evlist.  It can also remove an evsel from the evlist.
> > >>>>>>>
> > >>>>>>> Thanks for your review.  I think it's fine to change evsel cpus or to remove
> > >>>>>>> an evsel from evlist before calling evlist__create_maps().  The function
> > >>>>>>> will take care of setting evlist's all_cpus from the evsels in the evlist.
> > >>>>>>> So previous changes in evsel/cpus wouldn't be any special.
> > >>>>>>>
> > >>>>>>> After this point, adding a new evsel needs to update evlist all cpus by
> > >>>>>>> propagating cpu maps.  So I think hybrid cpus should be fine.
> > >>>>>>> Did I miss something?
> > >>>>>>
> > >>>>>> I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> > >>>>>> cpus from the target->cpu_list (using perf record -C) , since after this
> > >>>>>> patch all_cpus always starts with the target->cpu_list instead of an empty
> > >>>>>> list.  But then, in the hybrid case, it puts a dummy event that uses the
> > >>>>>> target cpu list anyway, so the result is the same.
> > >>>>>>
> > >>>>>> I don't know if there are any cases where all_cpus would actually need to
> > >>>>>> exclude some of the cpus from target->cpu_list.
> > >>>>>
> > >>>>> I'm not aware of other cases to reduce cpu list.  I think it'd be fine
> > >>>>> if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
> > >>>>> should have a correct list anyway and we mostly use the evsel cpus
> > >>>>> to do the real work.
> > >>>>>
> > >>>>> Thanks,
> > >>>>> Namhyung
> > >>>>
> > >>>> The affinity changes made it so that we use all_cpus probably more
> > >>>> often than the evsel CPU maps for real work. The reason being we want
> > >>>> to avoid IPIs so we do all the work on 1 CPU and then move to the next
> > >>>> CPU in evlist all_cpus. evsel CPU maps are used to make sure the
> > >>>> indices are kept accurate - for example, if an uncore event is
> > >>>> measured with a CPU event:
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404
> > >>>
> > >>> Right, I meant it'd check the evsel cpus eventually even if it iterates
> > >>> on the evlist all_cpus.  The evlist_cpu_iterator__next() will skip a
> > >>> CPU if it's not in the evsel cpus.
> > >>>
> > >>> Thanks,
> > >>> Namhyung
> > >>
> > >> Perhaps an alternative is to be explicit about deferring map
> > >> propagation e.g.
> > >
> > > Thanks for your patch.  Yeah, we can use this.
> > >
> > > But I still think it'd be better doing it unconditionally
> > > since any propagation before perf_evlist__set_maps
> > > will be discarded anyway.  With this change, other
> > > than perf record will collect all cpus before _set_maps
> > > and then discard it.  It seems like a waste, no?
> > >
> > > Or else, we can have allow_map_propagation initialized
> > > to false and set it to true in perf_evlist__set_maps().
> > >
> >
> > That sounds fine.
> 
> Thanks!
> 
> Arnaldo, how do you want to handle it?  I can send v2 for the
> whole series, but I think you already applied it.  Then do you
> want me to send this change on top?

Send v2 for the whole series, I haven't yet published it so I can
replace.

- Arnaldo
