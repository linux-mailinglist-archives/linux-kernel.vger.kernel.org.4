Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BC687E33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBBNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBBNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:02:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208498EB77;
        Thu,  2 Feb 2023 05:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E51E3B82659;
        Thu,  2 Feb 2023 13:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBFAC433EF;
        Thu,  2 Feb 2023 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675342858;
        bh=I0+XpsfrXiVq4NvEITPXhBwMxT7p8ZjJTJTvge/hres=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAjsjxwkjObm/cxEp/X8gz+pQL/2Nk3RGbA2VMYjM0TqAuYA294c0hFu9HHWMRS6r
         tZEiNpA1cgPxGr7P5wfL2gFJSMaNdXQZgWggexxz4YX98CFDj07L5kw9spE7cPex6R
         ccxKEElIpl2ejeLQMjmYajDjhy1Ctma2FFS+mDr9Fiky5DMeIfLzq0mg/lPsmSEGEB
         DQgRhBGi6YxjUAObefBiGqJkNIXIGIF3YIp7hE4uVXwndSUg94lr1W2ovq4Grl7gNw
         Zpih1ZcNj1V4dkiAKyHXj4xcqamUips8kuwVuVs3HwddmpGU7t7on0kTNYkoRKcBvD
         FFmbvzjCXfkBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDE5C405BE; Thu,  2 Feb 2023 10:00:55 -0300 (-03)
Date:   Thu, 2 Feb 2023 10:00:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Carsten Haitzler <Carsten.Haitzler@arm.com>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Script style improvements in lib/coresight.sh
Message-ID: <Y9u0B2RBiZYrJ5Kk@kernel.org>
References: <20230201214945.127474-1-didi.debian@cknow.org>
 <b13301b1-104f-ebb5-6b2a-3d6cc3eba8a3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13301b1-104f-ebb5-6b2a-3d6cc3eba8a3@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 02, 2023 at 08:38:46AM +0000, Carsten Haitzler escreveu:
> On 2/1/23 21:49, Diederik de Haas wrote:
> > These 2 patches improve the efficiency and quality of the
> > lib/coresight.sh script.
> >
> > The first one uses grep's `-c` parameter to count the results instead of
> > piping it to `wc -l`.
> > The second one replaces the use of backticks (`...`) with $(...) as the
> > former has several potential issues while the latter does not.
> >
> > Diederik de Haas (2):
> >    perf test: Replace 'grep | wc -l' with 'grep -c'
> >    perf test: Replace legacy `...` with $(...)
> >
> >   tools/perf/tests/shell/lib/coresight.sh | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> >
> ACK to all of this series.

Thanks, added to the two patches, that I processed yesterday, still in
tmp.perf/core.

- Arnaldo
