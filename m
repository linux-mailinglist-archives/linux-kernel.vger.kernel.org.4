Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DFF68C087
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBFOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBFOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:51:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CF25BAC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:51:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56378B8117E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B4C433EF;
        Mon,  6 Feb 2023 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675695108;
        bh=aKJvfXS+xxZnv3cht3EfQwkvwp4dT7OrFf4PKvTWc48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uv4TfxJd3NoBs57skRukIbXGaaywY6Clt/BrkA0majQZzbFhMf5RglHspPDjbengZ
         e1yyfXu/0ysWWsVYe7XfSM39wSbvpXH8DRngL01EI2K7Ga9LCrR7HoijcUvJRt/1ls
         LzT0AhqRJI410Ihf/Wp/C3MHkIVl7aZwHVp8X9wxt7kHuPaEQesx9L+OUO/wbUG74E
         F01XmtH4MTH/iIKB8XiJ1ycZAr7Sj8nIOKYucTGzd7WQvHBcrQrkTW8ocF4XTy2ykm
         EN5aIVuPS1lKnmmTMbDqNv6aezLLVpRhg/+Us/8FhJkVY90DhSGrkwJHdb2SuCQOdq
         FlmxQKER020kQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EA903405BE; Mon,  6 Feb 2023 11:51:44 -0300 (-03)
Date:   Mon, 6 Feb 2023 11:51:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
Message-ID: <Y+EUAEPhU8hVMLsl@kernel.org>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
 <Y9sWImm4v5I/MZId@kernel.org>
 <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
 <Y91su757r43jgdle@kernel.org>
 <Y91uWj6PiGQqI48J@kernel.org>
 <47f5639d-a64e-9c85-a62b-40160d02d3ff@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f5639d-a64e-9c85-a62b-40160d02d3ff@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 06, 2023 at 09:32:00AM -0500, Liang, Kan escreveu:
> 
> 
> On 2023-02-03 3:28 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 03, 2023 at 05:21:15PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Feb 02, 2023 at 09:34:02AM -0500, Liang, Kan escreveu:
> >>> Hi Arnaldo,
> >>>
> >>> On 2023-02-01 8:47 p.m., Arnaldo Carvalho de Melo wrote:
> >>>> Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
> >>>>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>>>
> >>>>> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
> >>>>> are also supported.
> >>>>>
> >>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >>>>> ---
> >>>>
> >>>> Did the kernel bits land upstream?
> >>> Yes, the kernel part has been merged into the tip.git perf/core branch.
> >>>
> >>> Thanks for checking the status. There are two perf tool patches in this
> >>> series, which hasn't been merged. Should I resend them?
> >>
> >> Lemme try cherry-picking just the tooling bits from this series.
> >
> 
> Sorry, I forgot to mention it in this thread.
> I sent V3 with only perf tool patches.
> 
> https://lore.kernel.org/lkml/20230202192209.1795329-1-kan.liang@linux.intel.com/

> 
> > There was a clash with:
> > 
> > commit 3fd7a168bf51497909dbfb7347af28b5c57e74a6
> > Author: Namhyung Kim <namhyung@kernel.org>
> > Date:   Thu Jan 26 13:36:10 2023 -0800
> > 
> >     perf script: Add 'cgroup' field for output
> > 
> > And a minor fuzz on the first patch, I applied manually and resolved the
> > conflict,
> 
> The V3 add a perf test case for the new field. Could you please apply it
> as well?
> 
> Sorry for the inconvenience.

np, I'll pick the test and apply it as well,

Thanks for letting me know,

- Arnaldo
