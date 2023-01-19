Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7597B674BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjATFFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjATFEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:04:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90A74382;
        Thu, 19 Jan 2023 20:51:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BA5FB82623;
        Thu, 19 Jan 2023 16:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DA9C433F2;
        Thu, 19 Jan 2023 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674146392;
        bh=EzuLhfS+PRjXH8DDjLzCLF1bGHoITDNogKA9OB2ppdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTnd95ALmwH1RfdzNVzY3XsWXjhSDLkQP0z+4QwuWJH0j74kwq4YFdY8ucRi99rVM
         j7Xvgcz8TWoGJFsqJqqdkzGPrmeRc9gk2VsuMtuePJKR3iEFczd315/xcgIZysh9IN
         tkQiwy3tdJ4NE5Oztlscdb+w1+5x08D4ifuZzc9mjRuWqZit923u3z2C5YYrNC0uAG
         JrsycoqXtP8nFHVGmwfeN4tiWhEk7lNhM6jqYk/yMeP698743+KyK7rNhtsPulQo5k
         1ou5H+0GO3/OI/c7TSWrsVsXmblV2rr35xAs3Lv2JTP0mZ4M2hcjnqQs4k7Gzaw//s
         WlXh3IaFEFwpQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 311E1405BE; Thu, 19 Jan 2023 13:39:49 -0300 (-03)
Date:   Thu, 19 Jan 2023 13:39:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf buildid: Avoid copy of uninitialized memory
Message-ID: <Y8lyVTwQqzWk0mLd@kernel.org>
References: <20230113185732.134861-1-irogers@google.com>
 <CAP-5=fXg28wcW93tfiN6mdFHj0+eSRE3dL3LTv53bRYuezjZDg@mail.gmail.com>
 <Y8lv6oclCytPk7hN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lv6oclCytPk7hN@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 19, 2023 at 01:29:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 19, 2023 at 08:08:13AM -0800, Ian Rogers escreveu:
> > On Fri, Jan 13, 2023 at 10:57 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > build_id__init only copies the buildid data up to size leaving the
> > > rest of the data array uninitialized. Copying the full array during
> > > synthesis means the written event contains uninitialized memory.  This
> > > was detected by the Clang/LLVM memory sanitizer.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/synthetic-events.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > > index 3ab6a92b1a6d..348d05e4ec03 100644
> > > --- a/tools/perf/util/synthetic-events.c
> > > +++ b/tools/perf/util/synthetic-events.c
> > > @@ -2219,7 +2219,7 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
> > >
> > >         len = pos->long_name_len + 1;
> > >         len = PERF_ALIGN(len, NAME_ALIGN);
> > > -       memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
> > > +       memcpy(&ev.build_id.build_id, pos->bid.data, pos->bid.size);
> > 
> > Ping. Should be an uncontroversial change to fix a copy of
> > uninitialized memory into the perf.data file during synthesis.
> 
> Indeed, applied.

Humm, don't we better do it as:

+       memcpy(&ev.build_id.build_id, pos->bid.data, min(pos->bid.size, sizeof(pos->bid.data));

Lemme check what is setting that pos->bid.size....

Things like sysfs__read_build_id() that does such checks, but perhaps we
should be defensive and do it in this function as well?

- Arnaldo

