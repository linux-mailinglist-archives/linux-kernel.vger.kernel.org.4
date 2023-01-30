Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E7681B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjA3UJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjA3UJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:09:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF434C06;
        Mon, 30 Jan 2023 12:09:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39D761251;
        Mon, 30 Jan 2023 20:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18659C433EF;
        Mon, 30 Jan 2023 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675109353;
        bh=lYpvEwgqu8muRzn2ZBfUUeLCMSfrhWuoPpSDmY5HUKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jgrx3dRmkh1AU5AtQJA6aaDO5GzHZq3TFRNO30hUbUiSCaPsk8M6EFTEZwiBNAuxt
         ZUORfPdB7rhiusmzV0ig6hb/UlPE1y6vbDGqiFfrcjftZlwV23VdYqPSLFF8CEXK2T
         L8uwsoYT0ID1Pg28PhGFYGaIdoiNApGzM8ZzOubxy7LoqUSeYfnjKwej7jGo/sZY7i
         E9320cZubpkfEkAhD2vsyrUNudcYVBK7MxYZRj+y/Rl8tpgFzVrYOWnbJuuycpwXxm
         M0I4RI74OkbcYJtgs77s2MrIHrC74We21dSqh6+3p7u+OnGDLNEFb9CneGt5vkbFD1
         brYLX29sKyKoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35784405BE; Mon, 30 Jan 2023 17:09:10 -0300 (-03)
Date:   Mon, 30 Jan 2023 17:09:10 -0300
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
Message-ID: <Y9gj5spCa8JcTY/X@kernel.org>
References: <cover.1675057032.git.sandipan.das@amd.com>
 <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
 <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 04:04:58PM +0530, Sandipan Das escreveu:
> On 1/30/2023 11:29 AM, Sandipan Das wrote:
> > Show the branch speculation info if provided by the branch recording
> > hardware feature. This can be useful for optimizing code further.
> > 
> > The speculation info is appended to the end of the list of fields so any
> > existing tools that use "/" as a delimiter for access fields via an index
> > remain unaffected. Also show "-" instead of "N/A" when speculation info
> > is unavailable because "/" is used as the field separator.
> > 
> > E.g.
> > 
> >   $ perf record -j any,u,save_type ./test_branch
> >   $ perf script --fields brstacksym
> > 
> > Before:
> > 
> >   [...]
> >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL
> >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
> >   [...]
> > 
> > After:
> > 
> >   [...]
> >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> >   [...]
> > 
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >  tools/perf/builtin-script.c |  5 +++--
> >  tools/perf/util/branch.c    | 15 +++++++++++++++
> >  tools/perf/util/branch.h    |  2 ++
> >  tools/perf/util/evsel.c     | 15 ++++++++++++---
> >  4 files changed, 32 insertions(+), 5 deletions(-)
> > 
> 
> Sorry but I realized later that this change breaks the builtin branch test.
> The additional change below fixes that.

Please wait a bit for people to be able to review the other patches and
then submit a v2 series.

- Arnaldo
 
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> index 59195eb80052..1c49d8293003 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,14 +30,14 @@ test_user_branches() {
>         #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> 
>         set -x
> -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"        $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"      $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"    $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"    $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"               $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET$"     $TMPDIR/perf.script
> -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"  $TMPDIR/perf.script
> -       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"            $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"     $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"   $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"            $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"  $TMPDIR/perf.script
> +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"       $TMPDIR/perf.script
> +       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"         $TMPDIR/perf.script
>         set +x
> 
>         # some branch types are still not being tested:
> @@ -57,7 +57,7 @@ test_filter() {
> 
>         # fail if we find any branch type that doesn't match any of the expected ones
>         # also consider UNKNOWN branch types (-)
> -       if grep -E -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
> +       if grep -E -vm1 "^[^ ]*/($expect|-|( *))/.*$" $TMPDIR/perf.script; then
>                 return 1
>         fi
>  }
> 
> 
> - Sandipan

-- 

- Arnaldo
