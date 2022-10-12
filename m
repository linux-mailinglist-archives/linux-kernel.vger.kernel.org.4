Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520D05FBFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJLD6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJLD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:58:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C24B4AD;
        Tue, 11 Oct 2022 20:58:52 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-131ea99262dso18224317fac.9;
        Tue, 11 Oct 2022 20:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fN4Rni4jGwkw15y0j6ev8lSPVxwgaeF2vMkVARXcjSE=;
        b=OleGlH58RDdGmOBT1x8mKmDK6fmCFscx7ucYYVRL459i0GpIP6H9uAB5svKQ+HY467
         VKoY2RkygrrR6X8d9ik10BiotWk3PU6SPzcOeqAVgW6sTBaLY08oVDwnrqLCI4kfsXAr
         wXme/lC0a85mDzcBC7XuFSf/coe7KkjkQLjsupKBqbfbhQPdb+QMkgfowYLfy2dqKLAh
         OTUpG5/kdfMtLFvCKXcvqhn/kIhv9bWe+71nxoDKbBEDerFUPK4jEksyKnuyxg+TOhtF
         4O7l5zqyL0Mr5i3vn5QRSeGxlm9zXxuDa7ulPgCUg2qLkrAejN7yEceBUKyO4uemgmO1
         x7Mg==
X-Gm-Message-State: ACrzQf12UPOaowtabX3hdatZe2uaHvkyuWYClT2ndUlnQZdssa9mXjFD
        Y3815d1NUEs6bSOB99PggLSVX23dG2QqUmMuahng3b4d
X-Google-Smtp-Source: AMsMyM63mTGKjlbXS3Tu+oPX7FPioKqJ9+bKaSf2Ig7Ko4zcy0dRt9bw6wHqzYtl8BhzV196ZEuh8/2/klAKM2KgV6Y=
X-Received: by 2002:a05:6870:82ac:b0:133:34b:6f10 with SMTP id
 q44-20020a05687082ac00b00133034b6f10mr1414365oae.218.1665547131632; Tue, 11
 Oct 2022 20:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
 <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com> <c65f10bd-e486-42d7-b221-dd763623775d@linux.intel.com>
In-Reply-To: <c65f10bd-e486-42d7-b221-dd763623775d@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 20:58:40 -0700
Message-ID: <CAM9d7cg=yKnA3EFs8-K5ag0=DVNjBPhmxamcXn_Xon3OnTxMSA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
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

On Tue, Oct 11, 2022 at 4:57 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> >> My main concern would be subtle regressions since there are so many
> >> different combinations and way to travel through the code, and a lot of
> >> things are not covered by unit tests. When I worked on the code it was
> >> difficult to keep it all working. I assume you have some way to
> >> enumerate them all and tested that the output is identical?
> > Right, that's my concern too.
> >
> > I have tested many combinations manually and checked if they
> > produced similar results.
>
> I had a script to test many combinations, but had to check the output
> manually
>
>
> > But the problem is that I cannot test
> > all hardwares and more importantly it's hard to check
> > programmatically if the output is the same or not.
>
> Can use "dummy" or some software event (e.g. a probe on some syscall) to
> get stable numbers. I don't think we need to cover all hardware for the
> output options, the different events should be similar, but need some
> coverage for the different aggregation. Or we could add some more tool
> events just for testing purposes, that would allow covering different
> core scopes etc. and would easily allow generating known counts.

Even if we can get a stable number, it still needs to know cpu topology
for different aggregation modes to verify the count.  Also I'm afraid that
cpu hotplug can affect the aggregation.

Thanks,
Namhyung
