Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB95FBFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJLDzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLDzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:55:37 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6641A476E7;
        Tue, 11 Oct 2022 20:55:36 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so11410413ooi.5;
        Tue, 11 Oct 2022 20:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybHzhD2pPizAeeXQb/YjlSiUKqRewEOBpM2hPa2QoIU=;
        b=BcOqE9uLA0rQvbO4f1i2eETcXFJ5jY+/87BjkdNIETNFKIq2JVmy4f7a8OmpIC8l3n
         UhXxCC3VBjVRbBH3kPr+4169uwlM2+z4zBH70PpPheh3kBkH6MA6b/D3gqvKWbwxS3jv
         EL5FEVCXl+NwsDc2dd51fVhJT4SgQfMWdGkfQtOHW2ByJz2UdYDgkk0NpBkCMMGvNoPN
         n0Xf+I4SBIBjakY3/eseet0VzCeQJxM+YlxzfedGhUxZkvuVzmoPCSvhCf95Tveh+pMk
         jWJFV70FKP38dH328+wi1obf1lDnxG/6gtMcEUyHQ1+EhrlL/KStPq/mL+GwXZEHveTW
         /7Rw==
X-Gm-Message-State: ACrzQf2XjeSCvMfh8Ox2Ba2BSfpAiVz87A+FeKG5e3/7ggvTkmrpoNyM
        kD6jxLAbtvS1eIJ6hII3NFSUBRcw1ov0kQDwaYg=
X-Google-Smtp-Source: AMsMyM4zPQE+dli32wYjxj1l56vjHdrOaYXGyQuDipE8r2Am0DDQB+iAsNxdpCMxwAXrNAqzsf7j2RWFomAEJbrAit0=
X-Received: by 2002:a9d:6848:0:b0:661:a608:cbc3 with SMTP id
 c8-20020a9d6848000000b00661a608cbc3mr4502119oto.206.1665546935511; Tue, 11
 Oct 2022 20:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
 <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com> <CAP-5=fUK8VXZAyjTVQ3e88F5AeYfEF5PP-=k=PoFONWpXE+XVA@mail.gmail.com>
In-Reply-To: <CAP-5=fUK8VXZAyjTVQ3e88F5AeYfEF5PP-=k=PoFONWpXE+XVA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 20:55:24 -0700
Message-ID: <CAM9d7cgfkZUi-n0rnBUHLErpXA4aSzY0yNUbpjpLF3Z2JKenZA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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

On Mon, Oct 10, 2022 at 11:14 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Oct 10, 2022 at 10:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Andi,
> >
> > On Mon, Oct 10, 2022 at 5:25 PM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > >
> > > On 10/10/2022 10:35 PM, Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > Current perf stat code is somewhat hard to follow since it handles
> > > > many combinations of PMUs/events for given display and aggregation
> > > > options.  This is my attempt to clean it up a little. ;-)
> > >
> > >
> > > My main concern would be subtle regressions since there are so many
> > > different combinations and way to travel through the code, and a lot of
> > > things are not covered by unit tests. When I worked on the code it was
> > > difficult to keep it all working. I assume you have some way to
> > > enumerate them all and tested that the output is identical?
> >
> > Right, that's my concern too.
> >
> > I have tested many combinations manually and checked if they
> > produced similar results.  But the problem is that I cannot test
> > all hardwares and more importantly it's hard to check
> > programmatically if the output is the same or not.  The numbers
> > vary on each run and sometimes it fluctuates a lot.  I don't have
> > good test workloads and the results work for every combination.
> >
> > Any suggestions?
>
> I don't think there is anything clever we can do here. A few releases
> ago summary mode was enabled by default. For CSV output this meant a
> summary was printed at the bottom of perf stat and importantly the
> summary print out added a column on the left of all the other columns.
> This caused some tool issues for us. We now have a test that CSV
> output has a fixed number of columns. We added the CSV test because
> the json output code reformatted the display code and it would be easy
> to introduce a regression (in fact I did :-/ ). So my point is that
> stat output can change and break things and we've been doing this by
> accident for a while now. This isn't a reason to not merge this
> change.
>
> I think the real fix here is for tools to stop using text or CSV
> output and switch to the json output, that way output isn't as brittle
> except to the keys we use. It isn't feasible for the perf tool to
> stand still in case there is a script somewhere, we'll just accumulate
> bugs and baggage. However, if someone has a script and they want to
> enforce an output, all they need to do is stick a test on it (the
> Beyonce principle except s/ring/test/).

Thanks for your opinion.

I agree that it'd be better using JSON output for machine processing.
Although there are records of historic perf stat brekages, it'd be nice
if we could avoid that for the default output mode. :)
Let me think about if there's a better way.

Thanks,
Namhyung
