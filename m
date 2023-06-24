Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AD273CD75
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 01:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjFXXja convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFXXj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 19:39:29 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BF10F4;
        Sat, 24 Jun 2023 16:39:28 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-780cf728871so77387639f.0;
        Sat, 24 Jun 2023 16:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687649967; x=1690241967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ap+Rpv8IlS2rc5S0MfXr5NC3itWY6poknvEA/Nr4pHU=;
        b=YvdcBR5NHSFz8KurlAD121cDATS6CI2r2r/1B04idipftgB7il0gcrZL4bo0ZlFtOr
         NVMYWrEjhGdZn7dua1ScJzfGuPM/YB1KWu5vrLfA5QwF3C7tG10p7IJKQ/Lv8+yVkPFB
         4azb6sCulAP6a0VlOHTsPlVW1S/EKEGFoQa5L4+7glJB8yo28/hklNqRAqX3CHNlP8F7
         XmaZ070Cr85KrtzKWOPuQWch59K6Mz9eVInn6NnbNOZKNQCn5/WsTTClP48L8/7GLSaE
         EIRpZ9Pcq2C3jUxWbIXAsgPW2YGVQLB19Tz4oX3EpfnLNSHdDcV/Ouo0J2rckJ4Bwdss
         F4Sw==
X-Gm-Message-State: AC+VfDziXdVl7YNdmr9zW2tba9SCIfdsDaWYS7ruFsJR6TNc7+Gvg8cU
        54VMrfuMcWhEEWIzGYkPvmdq6gpeUm/Uiev9VHc=
X-Google-Smtp-Source: ACHHUZ7lthggP+0zRacQyFtfs6yaIzyiMBtTG9XRN8MESqqHbjEIQE82/9N4px9ijvZZ8H3Cp1TwFitHdsFiN1X1mU4=
X-Received: by 2002:a5e:a901:0:b0:783:4869:e1 with SMTP id c1-20020a5ea901000000b00783486900e1mr1929354iod.19.1687649967583;
 Sat, 24 Jun 2023 16:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230623230139.985594-1-namhyung@kernel.org> <CAP-5=fX6Of3pKjZGLEaNL58opn2veXxOhrY_sQqgY6hgUJeaBw@mail.gmail.com>
In-Reply-To: <CAP-5=fX6Of3pKjZGLEaNL58opn2veXxOhrY_sQqgY6hgUJeaBw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 24 Jun 2023 16:39:15 -0700
Message-ID: <CAM9d7cixNFh7Uym7O+=eLV10a+e7E6eGW_TWcLNtR4kGJ6o9HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf test: Reorder event name checks in stat STD
 output linter
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 4:22 PM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Jun 23, 2023 at 4:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On AMD machines, the perf stat STD output test failed like below:
> >
> >   $ sudo ./perf test -v 98
> >    98: perf stat STD output linter                                     :
> >   --- start ---
> >   test child forked, pid 1841901
> >   Checking STD output: no argswrong event metric.
> >     expected 'GHz' in 108,121 stalled-cycles-frontend  # 10.88% frontend cycles idle
> >   test child finished with -1
> >   ---- end ----
> >   perf stat STD output linter: FAILED!
> >
> > This is because there are stalled-cycles-{frontend,backend} events are
> > used by default.  The current logic checks the event_name array to find
> > which event it's running.  But 'cycles' event comes before those stalled
> > cycles event and it matches first.  So it tries to find 'GHz' metric
> > in the output (which is for the 'cycles') and fails.
> >
> > Move the stalled-cycles-{frontend,backend} events before 'cycles' so
> > that it can find the stalled cycles events first.
> >
> > Also add a space after 'no args' test name for consistency.
> >
> > Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf stat' output")
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Ian Rogers <irogers@google.com>

Applied both to perf-tools-next, thanks!
