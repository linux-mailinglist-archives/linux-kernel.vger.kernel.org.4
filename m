Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA56872DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBBBNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBBBNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:13:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AF2BF3B;
        Wed,  1 Feb 2023 17:13:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E72B8239B;
        Thu,  2 Feb 2023 01:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DD9C433EF;
        Thu,  2 Feb 2023 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300386;
        bh=lWkZDyKMI3cFxHglQv7BIHPYXCuv7+Iwih0b5gfx73s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALOYIz9Teir1Gdda/9ViBol6PXo4wykvJ6eFV87BqkYW7CIDx8zQUQCz2DEC6Q5sR
         yMDY1H5Ccsn0MAca7eUBJs7efwZzAcqpDi3KvehHGcKhfCEzrLGsHUt4Cez7BTxySj
         rE4dU+9fRtr3QFcdX/cnBMfU9JFalZmd7tpKoV3A2OaMMvV3ETGI0x3PftXNVLCXV7
         4yjWEs0n+A1T00Lnlu6kjkHA1WhGi6i8aIBPc4T+JCeythxDqdEd8pboyxOFNwyMsB
         S2/LYiVMKMpLtVnsHjfFbzFdxOr50pzitULHarHai+1fujk/VbXaeqcTsQd0tYC5fp
         nEaYPokABYq1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A444405BE; Wed,  1 Feb 2023 22:13:03 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:13:03 -0300
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
Message-ID: <Y9sOH5p6ffMi91wd@kernel.org>
References: <cover.1675057032.git.sandipan.das@amd.com>
 <87c48949f5a442dda6d4dc75d4a4303973eb04b2.1675057032.git.sandipan.das@amd.com>
 <08385b8c-0fae-3249-3dfb-5a7800928213@amd.com>
 <Y9gj5spCa8JcTY/X@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gj5spCa8JcTY/X@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 05:09:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 30, 2023 at 04:04:58PM +0530, Sandipan Das escreveu:
> > On 1/30/2023 11:29 AM, Sandipan Das wrote:
> > > Show the branch speculation info if provided by the branch recording
> > > hardware feature. This can be useful for optimizing code further.
> > > 
> > > The speculation info is appended to the end of the list of fields so any
> > > existing tools that use "/" as a delimiter for access fields via an index
> > > remain unaffected. Also show "-" instead of "N/A" when speculation info
> > > is unavailable because "/" is used as the field separator.
> > > 
> > > E.g.
> > > 
> > >   $ perf record -j any,u,save_type ./test_branch
> > >   $ perf script --fields brstacksym
> > > 
> > > Before:
> > > 
> > >   [...]
> > >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL
> > >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL
> > >   [...]
> > > 
> > > After:
> > > 
> > >   [...]
> > >   check_match+0x60/strcmp+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> > >   do_lookup_x+0x3c5/check_match+0x0/P/-/-/0/CALL/NON_SPEC_CORRECT_PATH
> > >   [...]
> > > 
> > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > > ---
> > >  tools/perf/builtin-script.c |  5 +++--
> > >  tools/perf/util/branch.c    | 15 +++++++++++++++
> > >  tools/perf/util/branch.h    |  2 ++
> > >  tools/perf/util/evsel.c     | 15 ++++++++++++---
> > >  4 files changed, 32 insertions(+), 5 deletions(-)
> > > 
> > 
> > Sorry but I realized later that this change breaks the builtin branch test.
> > The additional change below fixes that.
> 
> Please wait a bit for people to be able to review the other patches and
> then submit a v2 series.

So I applied it manually, no need to send v2.

- Arnaldo
 
> - Arnaldo
>  
> > diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
> > index 59195eb80052..1c49d8293003 100755
> > --- a/tools/perf/tests/shell/test_brstack.sh
> > +++ b/tools/perf/tests/shell/test_brstack.sh
> > @@ -30,14 +30,14 @@ test_user_branches() {
> >         #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> > 
> >         set -x
> > -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL$"        $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL$"      $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL$"    $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL$"    $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET$"               $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET$"     $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND$"  $TMPDIR/perf.script
> > -       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND$"            $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"     $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"   $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$" $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"            $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"  $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"       $TMPDIR/perf.script
> > +       grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"         $TMPDIR/perf.script
> >         set +x
> > 
> >         # some branch types are still not being tested:
> > @@ -57,7 +57,7 @@ test_filter() {
> > 
> >         # fail if we find any branch type that doesn't match any of the expected ones
> >         # also consider UNKNOWN branch types (-)
> > -       if grep -E -vm1 "^[^ ]*/($expect|-|( *))$" $TMPDIR/perf.script; then
> > +       if grep -E -vm1 "^[^ ]*/($expect|-|( *))/.*$" $TMPDIR/perf.script; then
> >                 return 1
> >         fi
> >  }
> > 
> > 
> > - Sandipan
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
