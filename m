Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E05EEA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiI1XqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiI1XqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:46:16 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3422BA5C7C;
        Wed, 28 Sep 2022 16:46:16 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso2243365ooo.12;
        Wed, 28 Sep 2022 16:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sLGWPEMedgms3DjxWmz5At+NL9wj0jznCbW7IcNj6KE=;
        b=CbYcysGkXwv7DqfJ2YA2VV4j5GlhspOeRVVCW25cGtroC8Sn3WKX8xViJa757xQ1YO
         uAeY4qBAw6C5iEf9r1IAf0TboPjA0nALYLc1rSA0a0tMrrOIYPgu2atHtbrJm/lKfN6A
         6gjbyZq7uJjWCzmIVTmJ0zeuVlwt5I36XmUwZcDdc/kxfN3yWrgzjyiR5Wp0iSo5Fl20
         25+rvTYNtkLDTQiQ0ewSNfJvcHFWYW56cmoSTj+JYI4VW6dwkYehpGzR58Yo3G4M2Y5Z
         13YSxxcUb6nHpOqrp2R+s4D4CvGUbogBLZvANMbso9OWR2+khP/MK4aW2LJABsf34hre
         ebtg==
X-Gm-Message-State: ACrzQf3apQHVohZ30GQylnhITtg8paYprh/CkUJ1ZFLrxgmHSo0doZZm
        x+jlhqJrUVgzXX4NAsg47cvwcaMpIaU8JPyE/Ic=
X-Google-Smtp-Source: AMsMyM5GzLgG7E32+9+yaELtbc9C5zgQPlrzOb8DOQmaazGQup8YaV2NzVrJaiVnN+dBJjrjU362fvoljiiH8uKFY+k=
X-Received: by 2002:a4a:b4cd:0:b0:476:8f72:5b60 with SMTP id
 g13-20020a4ab4cd000000b004768f725b60mr199120ooo.58.1664408775500; Wed, 28 Sep
 2022 16:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220924165737.956428-1-namhyung@kernel.org> <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com> <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com>
In-Reply-To: <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 28 Sep 2022 16:46:04 -0700
Message-ID: <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
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

On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 27/09/22 20:28, Namhyung Kim wrote:
> > Hi Adrian,
> >
> > On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 24/09/22 19:57, Namhyung Kim wrote:
> >>> The current code propagate evsel's cpu map settings to evlist when it's
> >>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> >>> be updated in perf_evlist__set_maps() later.  No need to do it before
> >>> evlist's cpus are set actually.
> >>>
> >>> Actually we discarded this intermediate all_cpus maps at the beginning
> >>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> >>> an evsel is added after the evlist cpu maps are set.
> >>
> >> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
> >> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
> >> added to the evlist.  It can also remove an evsel from the evlist.
> >
> > Thanks for your review.  I think it's fine to change evsel cpus or to remove
> > an evsel from evlist before calling evlist__create_maps().  The function
> > will take care of setting evlist's all_cpus from the evsels in the evlist.
> > So previous changes in evsel/cpus wouldn't be any special.
> >
> > After this point, adding a new evsel needs to update evlist all cpus by
> > propagating cpu maps.  So I think hybrid cpus should be fine.
> > Did I miss something?
>
> I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
> cpus from the target->cpu_list (using perf record -C) , since after this
> patch all_cpus always starts with the target->cpu_list instead of an empty
> list.  But then, in the hybrid case, it puts a dummy event that uses the
> target cpu list anyway, so the result is the same.
>
> I don't know if there are any cases where all_cpus would actually need to
> exclude some of the cpus from target->cpu_list.

I'm not aware of other cases to reduce cpu list.  I think it'd be fine
if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
should have a correct list anyway and we mostly use the evsel cpus
to do the real work.

Thanks,
Namhyung
