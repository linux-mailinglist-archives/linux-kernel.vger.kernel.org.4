Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C96C24CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCTWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCTWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2FB26A9;
        Mon, 20 Mar 2023 15:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F6AB810FA;
        Mon, 20 Mar 2023 22:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC185C433D2;
        Mon, 20 Mar 2023 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679351837;
        bh=IBBEyGAISWsgD1ZP/NwygwfuZMDNyGdcymw3q6BDNug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQFeSa+BaBuKwg+y09/XwdbpPHxQB8QvAnpuHxVhsb5RTnyBbCSeYFUvFhhs3sLpH
         YFp059df0J3zM6gwIW9gQ+MnAgXhBAEuLJDm386ZmXj/v+nckV1fz0BwXK1oBz83Jn
         i8RoBl/B/eLcQpzGRBsk4jaWerMdG+JwxNhZ08wFCHyKYi4h7GRGTNp4eRn039yQ6H
         eaKejj6Wz7xpYfjoqOQXRiaXgTwAxV5BRJrbcGIK4nAD7TUU9kE3dEcv25pQuOV0Cy
         GmbY3VOZhUA8cDvblqeIG5QJukSekY89ypmAWVdUawr/t5TSxkixZCAnx/JfayV6Hl
         aQJDhbwVZA41w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E6254052D; Mon, 20 Mar 2023 19:37:14 -0300 (-03)
Date:   Mon, 20 Mar 2023 19:37:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf kvm: Fix memory leak
Message-ID: <ZBjgGg3XumiJB/YG@kernel.org>
References: <20230320061619.29520-1-leo.yan@linaro.org>
 <CAP-5=fVBZfTrtp6OUzop3HxL-Aw80FDC+7MPS6UEwDhhfkgk_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBZfTrtp6OUzop3HxL-Aw80FDC+7MPS6UEwDhhfkgk_Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 10:43:11AM -0700, Ian Rogers escreveu:
> On Sun, Mar 19, 2023 at 11:16 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch seris is to address memory leak issues in perf kvm.
> >
> > The first patch introduces refcnt in structure kvm_info, so we can avoid
> > memory leak for it.
> >
> > The second patch explicitly delete histograms entries before program
> > exiting rather than relying on kernel releasing memory space.
> >
> 
> Series:
> Acked-by: Ian Rogers <irogers@google.com>

I applied this, but the second patch may end up delaying tool exit by
traversing data structures holding lots of objects to needless free
them.

There are places in perf where we do it conditionally for that reason.

At some point I want to try signalling we're exiting using some global
variable and then making all memory free operations become nops.

- Arnaldo


 
> Thanks,
> Ian
> 
> > Leo Yan (2):
> >   perf kvm: Support refcnt in structure kvm_info
> >   perf kvm: Delete histograms entries before exiting
> >
> >  tools/perf/builtin-kvm.c   |  6 ++++--
> >  tools/perf/util/hist.c     |  5 +++++
> >  tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+), 2 deletions(-)
> >
> > --
> > 2.39.2
> >

-- 

- Arnaldo
