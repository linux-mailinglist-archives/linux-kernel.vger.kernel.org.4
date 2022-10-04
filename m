Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F415F4809
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJDRHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJDRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B04356C0;
        Tue,  4 Oct 2022 10:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 112DEB80D63;
        Tue,  4 Oct 2022 17:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08C9C43470;
        Tue,  4 Oct 2022 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664903262;
        bh=cfuYWnUnLF3oyQfiCEANznX/wJ0xdE1PYwmKb3Zjcpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIBSnyPMGKCjTJTX+TjkcvICndjoiMIaM+H+gqTBscRYVfMx/seS5VyCDR+loHg5V
         +ubJ+xjWtxb9fVWMP9u9mFiMnY6vrvt0J5T1WPLhznF5RL9pbqghsL/LLJ4Or6NjvV
         F0R+K6Ht6SaI6WDIbecDbcJhLwuwGVqDq+twClQh2C0Ks/jw5CEy1gwhkL2jTv7rlq
         Dy1TikLCYBcm65znYQE7qCJegTdP8rCumiulk0uxADIH5P01zLq5TrDmESWbjBoFXO
         KLMuM1cPqv3AFRT4+g0LEtr/wf5C+wTdwiIZ3uYSQHH0oGfzZ1msEzi4MjV1jVw9SQ
         o9Lw1qwpIZ9cg==
Received: by mail-ua1-f41.google.com with SMTP id d3so4410429uav.7;
        Tue, 04 Oct 2022 10:07:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf0+oSVTntGFPmzQXgH8KWSVHoA/Z+Qc3WurP9wFWQSY5DG+OrVs
        1EzUbsXI4HC5eZDGDe1v6xuk+VL4pNul8JcuuA==
X-Google-Smtp-Source: AMsMyM5R0EOu9eL0BN+NRipjnzbeCa0CWFT6+krUrQ6/aIpUPkOQd4aZi5GLco4ZK72si4+RcwN6JGCS2lXv8AJWMoA=
X-Received: by 2002:ab0:70c8:0:b0:39f:7528:6289 with SMTP id
 r8-20020ab070c8000000b0039f75286289mr12133566ual.36.1664903261540; Tue, 04
 Oct 2022 10:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
 <20220914-arm-perf-tool-spe1-2-v2-v3-1-8189fc04dcc6@kernel.org> <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
In-Reply-To: <YzU/o3kxS/BYpJhn@leoy-yangtze.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Oct 2022 12:07:30 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
Message-ID: <CAL_Jsq+3pt_yr5LLFNR-DsXQycD-_gd5fum8QbfxUzHPR-zfJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Skip and warn on unknown format 'configN' attrs
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 1:48 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Rob,
>
> On Wed, Sep 14, 2022 at 03:08:34PM -0500, Rob Herring wrote:
>
> [...]
>
> > +void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
> > +{
> > +     struct perf_pmu_format *format;
> > +
> > +     list_for_each_entry(format, &pmu->format, list)
> > +             if (format->value >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {
> > +                     pr_warning("WARNING: '%s' format '%s' requires 'perf_event_attr::config%d'"
> > +                                "which is not supported by this version of perf!\n",
> > +                                pmu->name, format->name, format->value);
> > +                     return;
> > +             }
> > +}
>
> Though I saw you and Namhyung have discussion in underway, this patch
> set is fine for me.  I validated the patches at my side (with a bit
> hacking in Arm SPE driver for faking invert filter).  You could add my
> tested tag for this patch set:
>
> Tested-by: Leo Yan <leo.yan@linaro.org>
>
> But I want to remind two things after I used "perf test" to validate
> this patch set:
>
>   $ ./perf test list
>   6: Parse event definition strings
>   6:1: Test event parsing
>   6:2: Test parsing of "hybrid" CPU events
>   6:3: Parsing of all PMU events from sysfs
>   6:4: Parsing of given PMU events from sysfs
>   6:5: Parsing of aliased events from sysfs
>   6:6: Parsing of aliased events
>   6:7: Parsing of terms (event modifiers)
>   $ ./perf test -v 6
>
> The first one is this patch set introduces segmentation fault for the
> case "Parsing of aliased events" (See tests/parse-events.c).  But the
> issue is caused by the test case itself; we need to add below line into
> test_event_fake_pmu() for initialisation list header.

Thanks.

>     INIT_LIST_HEAD(&perf_pmu__fake.format);

I ended up fixing this in perf_pmu__warn_invalid_formats() instead as
the test dealing with internal stuct pmu details didn't seem right:

+       /* fake pmu doesn't have format list */
+       if (pmu == &perf_pmu__fake)
+               return;
+

>
> The second question is for testing config3 in "perf test".  You could
> see the file tests/parse-events.c has included several test cases for
> config/config1/config2.  It's good to add the same testing for config3
> as well, please see test__checkevent_pmu() and test__checkterms_simple()
> for relevant code.

Okay, will add in the next version.

Rob
