Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE47607C25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJUQZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:25:28 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125891989A0;
        Fri, 21 Oct 2022 09:25:27 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2111018otu.7;
        Fri, 21 Oct 2022 09:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gc70kGbL9d0j2d/EsthLu44LYzEyGZWdvK0hdiHTOLM=;
        b=8KHwlHM1Jm1NvqL5IOWcrukVLWKgvGIcqdQS8kUHyBKKxvB1HZ2b9MAGwvhKNLGneR
         TOVRPO9FUCX/i44eo0aChsKusoglKC5k7o19EsY7w+kvhKI/MvhP/gjnA648B7RRItni
         uYG/oQYtVTeVY3mvjDvb0V+v8DxvBKfpwMtoyROULeWBAT7ByYFRIi6Yl6V+iF3M3vnV
         pznrdZsOr9xSx/g/5TROXnYsex/s1A5cU9I0M2b5WdIybbN3lu6ah+5p88Ko1U8/xYXV
         3Mw8xpPT+P//cWBY29HnE4E1K25kZTQK/ooVmeC2BXKOOdHmSb3RASRlkNd1jXtqwh5N
         dOcw==
X-Gm-Message-State: ACrzQf1f7tQJR1bLUhmyWWHOWhhZ9F6xF7jHVKGGBngs4ie60IojJI3o
        rHP93Fk5+9PYD/lDF1JMtMhpUCKRMC4shR4sYqk=
X-Google-Smtp-Source: AMsMyM7zvO2bXNXiH9Xmm7Nm7RfH62DrrgjpZa0j6SlfPdB+dihwpXqc1pIi0WuCdYeSnlAaLPY/jI3g3usFPEldWO0=
X-Received: by 2002:a9d:3e9:0:b0:661:a8a2:7b96 with SMTP id
 f96-20020a9d03e9000000b00661a8a27b96mr10604547otf.190.1666369526322; Fri, 21
 Oct 2022 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221020192917.3542757-1-namhyung@kernel.org> <0beb829f-82e7-9caa-806e-276adc8e697f@intel.com>
In-Reply-To: <0beb829f-82e7-9caa-806e-276adc8e697f@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 21 Oct 2022 09:25:15 -0700
Message-ID: <CAM9d7chnXa8XEYQiUyn6fJp8MsS+cb+FhaZTQksQbrFqSF_JUQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Do not fail Intel-PT misc test w/o libpython
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
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

Hi Adrian and Ian,

On Thu, Oct 20, 2022 at 10:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/10/22 22:29, Namhyung Kim wrote:
> > The virtuall LBR test uses a python script to check the max size of
> > branch stack in the Intel-PT generated LBR.  But it didn't check whether
> > python scripting is available (as it's optional).
> >
> > Let's skip the test if the python support is not available.
> >
> > Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
> > Cc: Ammy Yi <ammy.yi@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> > index 4c0aabbe33bd..e66b7d977462 100755
> > --- a/tools/perf/tests/shell/test_intel_pt.sh
> > +++ b/tools/perf/tests/shell/test_intel_pt.sh
> > @@ -526,6 +526,12 @@ test_kernel_trace()
> >  test_virtual_lbr()
> >  {
> >       echo "--- Test virtual LBR ---"
> > +     # Check if python script is supported
> > +     libpython=$(ldd $(which perf) | grep -c python)
>
> 'which' might not be installed.  Don't about 'ldd'.
>
> Maybe 'perf version --build-options' can be used instead e.g.
>
> $ perf version --build-options | grep -i libpython | grep -vi off
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT

Thanks for the suggestion, will change.

Thanks,
Namhyung
