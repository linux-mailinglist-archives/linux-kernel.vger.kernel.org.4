Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF4687358
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBBCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBCew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:34:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BB6C100;
        Wed,  1 Feb 2023 18:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24743619C6;
        Thu,  2 Feb 2023 02:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467D6C433EF;
        Thu,  2 Feb 2023 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675305290;
        bh=w7axNIyDbb9s6F+CkgIBCYQF7+/2qyeSkh/uF2REEcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6qAPVavwJ8qNC3pXKIUSvkpUiBJD6Ou+wraLfNo4bpatMCjlVu+dt7kl9rTMxx+h
         4sSqcDPgAyMYQGRVetlJLBq8Ou+RSl9kqx6S4RdIUUrYnD033mDHpf+QyTcWaejSZc
         hrNXwOsdeneNr+K6GeXW64XKFVt5+MGk3tBNezGedbG9PDUhIN27rnwf4B7FiFxWfZ
         obi3JR6iq3YnvmRHkYMZ6VpPygzVPEOvn6cz1Dv509fF+N56PDYaInh3jHt760+pDa
         ZI7Djp5EV1x3LB9MpSJ9Urhag8qbjqRO6RvzKmi0h4RiMTTFtbDnlFOG0qczjVW4fq
         G5NHpS/UszdLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 607D7405BE; Wed,  1 Feb 2023 23:34:46 -0300 (-03)
Date:   Wed, 1 Feb 2023 23:34:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v3 1/2] perf script: Show branch speculation info
Message-ID: <Y9shRsZuhGgpNi25@kernel.org>
References: <cover.1675057032.git.sandipan.das@amd.com>
 <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
 <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
 <Y9gj5spCa8JcTY/X@kernel.org>
 <Y9sOH5p6ffMi91wd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9sOH5p6ffMi91wd@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 01, 2023 at 10:13:03PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 30, 2023 at 05:09:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 30, 2023 at 04:04:58PM +0530, Sandipan Das escreveu:
> > > On 1/30/2023 11:29 AM, Sandipan Das wrote:
> > > > Show the branch speculation info if provided by the branch recording
> > > > hardware feature. This can be useful for optimizing code further.
> > > > 
> > > > The speculation info is appended to the end of the list of fields so any
> > > > existing tools that use "/" as a delimiter for access fields via an index
> > > > remain unaffected. Also show "-" instead of "N/A" when speculation info
> > > > is unavailable because "/" is used as the field separator.
> > > > 
> > > > E.g.
> > > > 
> > > >   $ perf record -j any,u,save_type ./test_branch
> > > >   $ perf script --fields brstacksym
> > > > 
> > > > Before:
> > > > 
> > > >   [...]
> > > >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL
> > > >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
> > > >   [...]
> > > > 
> > > > After:
> > > > 
> > > >   [...]
> > > >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> > > >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> > > >   [...]
> > > > 
> > > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > > > ---
> > > >  tools/perf/builtin-script.c |  5 +++--
> > > >  tools/perf/util/branch.c    | 15 +++++++++++++++
> > > >  tools/perf/util/branch.h    |  2 ++
> > > >  tools/perf/util/evsel.c     | 15 ++++++++++++---
> > > >  4 files changed, 32 insertions(+), 5 deletions(-)
> > > > 
> > > 
> > > Sorry but I realized later that this change breaks the builtin branch test.
> > > The additional change below fixes that.
> > 
> > Please wait a bit for people to be able to review the other patches and
> > then submit a v2 series.
> 
> So I applied it manually, no need to send v2.

Please send v2 after figuring out why 'perf test "Sample parsing"'
fails,

I removed both patches for now.

- Arnaldo
