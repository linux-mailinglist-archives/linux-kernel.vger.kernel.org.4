Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A713600F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJQMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJQMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961151006;
        Mon, 17 Oct 2022 05:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3223761127;
        Mon, 17 Oct 2022 12:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E426C433C1;
        Mon, 17 Oct 2022 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666010016;
        bh=xOhZ798gL/+y6nBCxEZb+QFOl8ru0dI5jW9R7qV3Dxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTaoaLiDl+L3yaW63mFw6G4kb6wRzQUh1cverewP9Figc0sjRoss5x6ryrfn8IUaT
         fiZ1HFrKsVSvxLp4DpPQxNB0ZLJX+L/tsFc3vR18PdHoTsm6oayMhZVgdc5txiXuRj
         uRLL1O3OQIG2t/murvbZHiVjTf18hO2z0UMx0oREK5TjVRIwnb9cp1ErYukH3VGqqe
         ZGoUW4J7aAXeZep/aOcR+tykQ41DY2jO5D7Yg+C9AAP2GO7QJryxmNrndA9x648pbT
         AdK6Z0wNtSe9b1WgoZokbZQ6fSZUzCfsNRDGF7RyDmE0Y8oBAQyVag1XOWrm/bjpI9
         ZJKo0Sr0afX8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BA1F403B6; Mon, 17 Oct 2022 09:33:34 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:33:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
Message-ID: <Y01Lnh5DqGUPuibf@kernel.org>
References: <20221012111025.30609-1-james.clark@arm.com>
 <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
 <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
 <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com>
 <CAM9d7cg+tTw5vTOycqRciQx8He-WLG0TSdcWa0tyzeu49DmgxA@mail.gmail.com>
 <912a4d0a-51b3-591b-8c8f-f078216d5b35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912a4d0a-51b3-591b-8c8f-f078216d5b35@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 10:47:34AM +0100, James Clark escreveu:
> On 13/10/2022 17:57, Namhyung Kim wrote:
> > On Wed, Oct 12, 2022 at 10:12 AM James Clark <james.clark@arm.com> wrote:
> >> On 12/10/2022 17:50, Namhyung Kim wrote:
> >>> On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
> >>>>> The test already supplies -q to run in quiet mode, so extend quiet mode
> >>>>> to perf_stdio__warning() and also ui__warning() for consistency.
> >>>
> >>> I'm not sure if suppressing the warnings with -q is a good thing.
> >>> Maybe we need to separate warning/debug messages from the output.
> >>
> >> I don't see the issue with warnings being suppressed in quiet mode as
> >> long as errors are still printed. In other cases warnings have already
> >> been suppressed by quiet mode and this site is the odd one out.
> >>
> >> What use case are you thinking of where someone explicitly adds -q but
> >> wants to see non fatal warnings?
> > 
> > I don't have any specific use case.  If it's already suppressed in other
> > cases, I'm fine with it.
> > 
> 
> Actually I may have been mistaken. Seems like quiet is only used for
> "extra info" type messages rather than warnings. Although the commit
> message does say:
> 
>   The -q/--quiet option is to suppress any message. Sometimes users just
>   want to see the numbers and it can be used for that case.
> 
> With 'any' that I would take to include warnings as well. I could move
> warnings to stderr, but this has a much greater chance of breaking
> anyone's workflows that might be looking for warnings on stdout than
> removing warnings when -q is provided.
> 
> Also if warnings are moved to stderr and quiet isn't used, there would
> be no way to suppress warnings in the TUI which might actually be a
> useful feature.
> 
> So I'm still leaning towards the original change, if you are ok with
> that even though it's not done elsewhere?

Namhyung? I tend to agree with James.

- Arnaldo
