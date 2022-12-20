Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0117652660
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLTSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiLTSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:38:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DFDE9F;
        Tue, 20 Dec 2022 10:38:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 293FCB8172E;
        Tue, 20 Dec 2022 18:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECD0C433D2;
        Tue, 20 Dec 2022 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671561511;
        bh=Xj/b06Er8ntqgengAsZZnDqTEhBrCfhXtWgAuFSnylU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REr7hAuAOSJYgw5/ADVLCc+eloLEo7UiZFp/jMsL5nZ5RzTGZ2PspmgYejx0Nwkc7
         W8iGTsYJiZrM5uKoX9qIrEWcHJ3X3kInoflfd5yv33UhtSq+O9tZaScahDCakkzbCK
         zhqNu7/+Z/+Gi2G3c/bmd62tCY4z0OUr4OMz6Fxrrye/JUUGgF8Y2vZYtSfP1bZwG+
         RXH6VteXcmeM7/PzHtYSFHQE1WenXJp/zjy00UlNDY/SltzHKJIE5pHoHtpmAAsaNC
         NQVzs+QMfBZZhOtkw5RIGLoPUyZQ9dZSJZlCJWjBChTbJ0puddBc2sknX7KFcCUJLJ
         xIf3POhdwCzGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0C5A240367; Tue, 20 Dec 2022 15:38:29 -0300 (-03)
Date:   Tue, 20 Dec 2022 15:38:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 2/9] perf report: Ignore SIGPIPE for srcline
Message-ID: <Y6IBJd606FJwXKDw@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
 <20221215192817.2734573-3-namhyung@kernel.org>
 <18594a2a-553a-c2b8-2c4f-6f7563ae3727@linux.intel.com>
 <CAM9d7ciS3H=2OVGGiNg5N6NeyZtfSE6D5kCHmQu_Otem4ByuuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciS3H=2OVGGiNg5N6NeyZtfSE6D5kCHmQu_Otem4ByuuA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 16, 2022 at 10:08:50AM -0800, Namhyung Kim escreveu:
> Hi Andi,
> 
> On Thu, Dec 15, 2022 at 11:25 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> >
> > On 12/15/2022 9:28 PM, Namhyung Kim wrote:
> > > It can get SIGPIPE when it uses an external addr2line process and the
> > > process was terminated unexpectedly.  Let's ignore the signal and move
> > > on to the next sample.  The sample will get the default srcline value
> > > anyway.
> >
> >
> > That's a bit dangerous -- if perf report output is piped to something
> > else you really want to stop on SIGPIPE.
> 
> Maybe we can handle the pipe write errors gracefully, but it'd require
> more changes in many places.
> 
> >
> > You would need to find a way to distinguish those cases.
> 
> Hmm.. ok.  I guess we can just drop this for now.  With checking
> the .debug_line section, problematic cases should be gone mostly.

So just skip this one, ok, I'll cherry pick the rest. Done.

- Arnaldo
