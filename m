Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDF687337
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBBB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:58:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BA222E4;
        Wed,  1 Feb 2023 17:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86FB5619C2;
        Thu,  2 Feb 2023 01:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D45C433D2;
        Thu,  2 Feb 2023 01:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675303090;
        bh=kZQCkIrpYr5NaUJeLusnw3cpPKk0s/wuRL25DGKqcWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iYJV9teGK4ZqWAxAYVBC9fyurpORguDN7dm3EVYT+mYuABrI0FxFqA0Ao6v3zQA8H
         kbqUV7XXjpqh+Zc65qcBRW3AGY+B/4cMTd0Yh6JAvkNqCHAmpOJNP05suf6iptF2Zd
         ozZHUY5ApdwXmActbU+QbMU3/hgP2E/UroJTC9ZF6x6RCA5iung9WDgY6gM32LE7Gg
         FH4peIiNV1iUd/lwq9uuw79a8v/TmMl2vNQhuU1O+uHcGiaKFLEg4p+6axjvzUpEE+
         b8zMm5QWH95I5A+io0FplSFLmpPSLBLlfPEWmn+LaehsGUrBKngG1GxIO4Z+iAi3QC
         SB+LI/KfGyfbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 47967405BE; Wed,  1 Feb 2023 22:58:08 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:58:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 0/4] perf: Add more syscalls to benchmark
Message-ID: <Y9sYsC3bKPGop+U2@kernel.org>
References: <1668052208-14047-1-git-send-email-yangtiezhu@loongson.cn>
 <c71e9666-c62a-83ae-0d7b-580dc717e9f1@loongson.cn>
 <dbf82707-df17-466b-f882-aa4e25d4f629@loongson.cn>
 <CAM9d7cgH0zK-DUmUV7yw1BJBvgyxWys9zPuB5Q7dQQwta=XcGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgH0zK-DUmUV7yw1BJBvgyxWys9zPuB5Q7dQQwta=XcGA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 06, 2023 at 01:04:42PM -0800, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Jan 5, 2023 at 5:23 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >
> >
> > On 12/03/2022 05:19 PM, Tiezhu Yang wrote:
> > >
> > >
> > > On 11/10/2022 11:50 AM, Tiezhu Yang wrote:
> > >> Tested on x86_64, arm64, mips64 and loongarch64.
> > >>
> > >> Tiezhu Yang (4):
> > >>   tools x86: Keep list sorted by number in unistd_{32,64}.h
> > >>   perf bench syscall: Introduce bench_syscall_common()
> > >>   perf bench syscall: Add getpgid syscall benchmark
> > >>   perf bench syscall: Add execve syscall benchmark
> > >>
> > >>  tools/arch/x86/include/uapi/asm/unistd_32.h | 23 ++++++---
> > >>  tools/arch/x86/include/uapi/asm/unistd_64.h | 23 ++++++---
> > >>  tools/perf/bench/bench.h                    |  2 +
> > >>  tools/perf/bench/syscall.c                  | 76
> > >> +++++++++++++++++++++++++++--
> > >>  tools/perf/builtin-bench.c                  |  2 +
> > >>  5 files changed, 108 insertions(+), 18 deletions(-)
> > >>
> > >
> > > Ping, any more comments?
> > >
> > > Thanks,
> > > Tiezhu
> >
> > Hi all,
> >
> > If this patch series has no value and is not acceptable,
> > or what should I do to update, please let me know.
> 
> I'm so sorry about being late a lot.
> I don't have any objection to this series.
> 
> For the execve bench, I think it's actually fork + execve
> then maybe it makes sense to have a fork only bench
> to compare the execve part precisely.
> 
> But it can be added later, so
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied.

- Arnaldo
