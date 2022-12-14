Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150564CEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiLNRfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLNRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:35:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48384E25;
        Wed, 14 Dec 2022 09:35:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D731361B79;
        Wed, 14 Dec 2022 17:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1456FC433EF;
        Wed, 14 Dec 2022 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671039304;
        bh=gc8zeNDEuZKdGQgmQ907LP9lyq1u/4yg+3L7iqX/3KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCV0Fd/a9Y0U5jszw4Y4B/oOHklPRieIYq40WRRza9kmAVVjO2pZ1jZ/13nrMo1kA
         N41D8kUyiBukl/c+nKUxJsfoEizz6H/l0o57t0zZx5ENef3YCSk1UlRSe3A7weKRw2
         ftkY9lA9z9hOXtIAw5v7d5Jk4ls04s1AodfklQWm8ls+1lEdz9rcyqL/R5EFQUb2ct
         cx7SB65Pk34+N8CvuiTe+rML+dSJt/UaHLq16XmZ1vBddcjlU9W9Hb3tCya99zgP6z
         jUJF9AjVC8ThptasDNqV7hxfjv71hSyId4bPWm5yDhsVbW1Z6cAsLUt20k11l22mnT
         b+ISWAXnCIACg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A20440367; Wed, 14 Dec 2022 14:35:01 -0300 (-03)
Date:   Wed, 14 Dec 2022 14:35:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila 
        <adrian.herrera@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, songliubraving@fb.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <Y5oJRXnlRju3gDxl@kernel.org>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com>
 <Y5iPsjF/lEsEldU8@kernel.org>
 <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
 <Y5ngs0bh/R8xPFvo@kernel.org>
 <Y5nyYeVWpLA/IH1E@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5nyYeVWpLA/IH1E@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 14, 2022 at 11:57:21PM +0800, Leo Yan escreveu:
> On Wed, Dec 14, 2022 at 11:41:55AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Dec 13, 2022 at 08:40:31AM -0800, Namhyung Kim escreveu:
> > > Hi,
> > > 
> > > On Tue, Dec 13, 2022 at 6:44 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
> > > > >
> > > > >
> > > > > On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> > > > > > The described --delay behaviour is to delay the enablement of events, but
> > > > > > not the execution of the command, if one is passed, which is incorrectly
> > > > > > the current behaviour.
> > > > > >
> > > > > > This patch decouples the enablement from the delay, and enables events
> > > > > > before or after launching the workload dependent on the options passed
> > > > > > by the user. This code structure is inspired by that in perf-record, and
> > > > > > tries to be consistent with it.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> > > > > > Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> > > > > > Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> > > > > > ---
> > > > > >  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
> > > > > >  1 file changed, 32 insertions(+), 24 deletions(-)
> > > > >
> > > > > Looks good to me. Fixes the counter delay issue and the code is pretty
> > > > > similar to perf record now. Although I would wait for Leo's or Song's
> > > > > comment as well because they were involved.
> > > >
> > > > I think I didn't notice Leo's ack, it still applies, so I'm doing it
> > > > now.
> > > 
> > > I think the BPF counters should be enabled/disabled together.
> > 
> > Ok, so I removed this one and applied Namhyung's.
> 
> I can guess why Adrián doesn't enable/disable BPF counters together :)
> 
> Since 'perf stat' doesn't enable BPF counters with other normal PMU
> events in the first place, I believe this is deliberately by Song's
> patch fa853c4b839e ("perf stat: Enable counting events for BPF
> programs"), it says:
> 
> "'perf stat -b' creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps".
> 
> IIUC, when loading eBPF (counter) program, perf tool needs to handle
> eBPF program map specially (so that perf tool can know the latest eBPF
> program's map in kernel).
> 
> I don't know anything for eBPF counter, so this is why I am still a bit
> puzzle which way is right to do (bind vs separate eBPF counters).  But
> I personally prefer to let eBPF counter to respect delay, so it's fine
> for me to apply Namhyung's patch.

"I'm fine" can be read as an Acked-by, right? :-)

- Arnaldo
