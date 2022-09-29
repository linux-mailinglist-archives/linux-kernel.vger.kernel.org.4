Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85FE5EED12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiI2FJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiI2FJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:09:40 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C0101B;
        Wed, 28 Sep 2022 22:09:34 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso275616otb.2;
        Wed, 28 Sep 2022 22:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IydL5kbnqeXOevEVuS9ouWA+i4vymY53i4zI/bO3x9M=;
        b=Q1XgaQB0b3+QsXJP4HbRf2OzKNWobak2y5ffXja08fG3K8EjVrUlYIqZaDpAvJwh0l
         GkQ1I26BM2SuFaqOk/rldCJOJvcnmjF5zeVlY6qU6CXnaAcZI67UwcfmfrQE5s3AhPvg
         mlgXdmxQH16JFbRqyzIPP4cwPG0qDF8BRf6DkmsVbHmEBM2yRCB59IM3pdnPrRHNHXok
         5o3dKaoL5aFKMxs1xlzfLyePoCPbBq285zqGXgGps2SvNtLrO4u3huCTOKKq9ftR9tKX
         3io/mK5qFfjOhrYXqz/ykx+TGyE09wPjhBDuFzoSqPvvFAi3XhYqtvHmEhWAL+q/N6YO
         2tpw==
X-Gm-Message-State: ACrzQf1KqTB42b11tU9vlD3EjSFS7MM90nFwBiB9W0oLsG6b8URCq/AH
        n4fyCgTyzhfARxpmOixYsU8ndHDBpz2VLlO5mYo=
X-Google-Smtp-Source: AMsMyM4hETyVV8KenOkqGDFFx4cZyAqRlRlhCjBEim/esahHSI2CxXS4UkYc5bxpLvYgsiqH+iyo3dVwlPQv/iUYS3g=
X-Received: by 2002:a05:6830:1351:b0:65b:e0a8:d0e8 with SMTP id
 r17-20020a056830135100b0065be0a8d0e8mr611900otq.190.1664428173757; Wed, 28
 Sep 2022 22:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com> <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com> <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
 <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
In-Reply-To: <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Sep 2022 22:09:22 -0700
Message-ID: <CAM9d7ciDvCOsFE68NG6jRb02DdDEOmRf_h7XizdDLGBz0RX95Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 7:08 PM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > On 27/09/22 20:28, Namhyung Kim wrote:
> > > > Hi Adrian,
> > > >
> > > > On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >>
> > > >> On 24/09/22 19:57, Namhyung Kim wrote:
> > > >>> The current code propagate evsel's cpu map settings to evlist when it's
> > > >>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> > > >>> be updated in perf_evlist__set_maps() later.  No need to do it before
> > > >>> evlist's cpus are set actually.
> > > >>>
> > > >>> Actually we discarded this intermediate all_cpus maps at the beginning
> > > >>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> > > >>> an evsel is added after the evlist cpu maps are set.
> > > >>
> > > >> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> > > >> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> > > >> added to the evlist.  It can also remove an evsel from the evlist.
> > > >
> > > > Thanks for your review.  I think it's fine to change evsel cpus or to remove
> > > > an evsel from evlist before calling evlist__create_maps().  The function
> > > > will take care of setting evlist's all_cpus from the evsels in the evlist.
> > > > So previous changes in evsel/cpus wouldn't be any special.
> > > >
> > > > After this point, adding a new evsel needs to update evlist all cpus by
> > > > propagating cpu maps.  So I think hybrid cpus should be fine.
> > > > Did I miss something?
> > >
> > > I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> > > cpus from the target->cpu_list (using perf record -C) , since after this
> > > patch all_cpus always starts with the target->cpu_list instead of an empty
> > > list.  But then, in the hybrid case, it puts a dummy event that uses the
> > > target cpu list anyway, so the result is the same.
> > >
> > > I don't know if there are any cases where all_cpus would actually need to
> > > exclude some of the cpus from target->cpu_list.
> >
> > I'm not aware of other cases to reduce cpu list.  I think it'd be fine
> > if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
> > should have a correct list anyway and we mostly use the evsel cpus
> > to do the real work.
> >
> > Thanks,
> > Namhyung
>
> The affinity changes made it so that we use all_cpus probably more
> often than the evsel CPU maps for real work. The reason being we want
> to avoid IPIs so we do all the work on 1 CPU and then move to the next
> CPU in evlist all_cpus. evsel CPU maps are used to make sure the
> indices are kept accurate - for example, if an uncore event is
> measured with a CPU event:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404

Right, I meant it'd check the evsel cpus eventually even if it iterates
on the evlist all_cpus.  The evlist_cpu_iterator__next() will skip a
CPU if it's not in the evsel cpus.

Thanks,
Namhyung
