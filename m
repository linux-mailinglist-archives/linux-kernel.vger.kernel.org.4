Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B355FABEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJKFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJKFi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:38:59 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B47B1F7;
        Mon, 10 Oct 2022 22:38:58 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id x188so5870993oig.5;
        Mon, 10 Oct 2022 22:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MO3GTwTzaxtHQ9IWhNQHIjFihMTCSzWT4EomKUbg50=;
        b=1waROP4H5wdaitF77b76xmM2fVm33Fdq5EyVC/hKw73tPalt8fYtA2VqnwCrP9IIq3
         p6QwPTHPfFLXh+a/eLJWS9h4b9NGivlS/70OlsHR9I2AkF5asbnvobRq5IHDGzljNemQ
         WaHjYDvY7zfFaXqZB24vymNpaqs5+iomzF035xjdTkU50LrzuA8SsUYwz9l7M9FksndF
         u+f5a0Qe4Bf9e78yCwNLj+HKgi93rYs/yIYBvW2SMauHUBoQxNOIgqxaKBPNBHxJmuVE
         N141wSB7k6EpvK1nNdxVX8JvFH6o00PGrATO/1DMtdU7mbP5j0aaIgdnncE4boUdDEv4
         2XSw==
X-Gm-Message-State: ACrzQf0zXPtucqQz15qAQLdeiY4IDUvp/OE0LXFwBnFwhaV3CAjoBHpa
        Exp7bSznzYQTE1b1jN9kupLDyP1wAgxpnohoPo8=
X-Google-Smtp-Source: AMsMyM4itmFMaCe3LunczpVT6hEVDpFzCwiDgubNDgByiny/bH+MABbR4nsiiEk18HmlOHsFVBlsJdDA1mYrZ8XOSx8=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr10422277oib.209.1665466737685; Mon, 10
 Oct 2022 22:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
In-Reply-To: <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Oct 2022 22:38:46 -0700
Message-ID: <CAM9d7chavgTHwFdU4m=GRx9kwSX1Pi8w58rgQc4nP_X-bpnbUQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, Oct 10, 2022 at 5:25 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/10/2022 10:35 PM, Namhyung Kim wrote:
> > Hello,
> >
> > Current perf stat code is somewhat hard to follow since it handles
> > many combinations of PMUs/events for given display and aggregation
> > options.  This is my attempt to clean it up a little. ;-)
>
>
> My main concern would be subtle regressions since there are so many
> different combinations and way to travel through the code, and a lot of
> things are not covered by unit tests. When I worked on the code it was
> difficult to keep it all working. I assume you have some way to
> enumerate them all and tested that the output is identical?

Right, that's my concern too.

I have tested many combinations manually and checked if they
produced similar results.  But the problem is that I cannot test
all hardwares and more importantly it's hard to check
programmatically if the output is the same or not.  The numbers
vary on each run and sometimes it fluctuates a lot.  I don't have
good test workloads and the results work for every combination.

Any suggestions?

Thanks,
Namhyung
