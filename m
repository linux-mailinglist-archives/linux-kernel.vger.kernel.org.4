Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4161960A1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJXLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJXLfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCE1D64E;
        Mon, 24 Oct 2022 04:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A14B61253;
        Mon, 24 Oct 2022 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFB3C433D7;
        Mon, 24 Oct 2022 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666611265;
        bh=JkOQ6WyabfkoI3q+9qrAUefuJ3P6cm/3vGI16+EmqAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d790ngUq795WrMpKK/ZPfEunnRX8x+iwfT+3vtWAu8L5VT4uyxyZg/Q7ElVyuSO9m
         +jCiakZjwTBcFU773gFkfbs5UmDMXdJZpS4il7yxiU/wk1u4OmLqjPUvruC82V7DuP
         RxtEq/YV45v63nd6GPFvyz3/MkUNAlz3d75Nsk8A5p/2YnVACbdfBTLHWlewKLe4RT
         mng9A2Drlnmfq+KIBMo4jLeHm+r/z4DmGEUaLZ2hbPI665y1FYVueblH0BWCm/fFfD
         iCWRY9bSZQlUqHIkUaxfkS9jE+x8vWaBoiRQcvn3ijDpJk1UPwhqIEAub8YEdNby8V
         Q2UHlO70/DQaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01C03404BE; Mon, 24 Oct 2022 08:34:23 -0300 (-03)
Date:   Mon, 24 Oct 2022 08:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 8/8] perf test: Do not set TEST_SKIP for record subtests
Message-ID: <Y1Z4P5e/CT0O23jr@kernel.org>
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-9-namhyung@kernel.org>
 <CAP-5=fVRCaTJseQA_AGZ8nc0H65iNsPUfjDNtopd++JK53kYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVRCaTJseQA_AGZ8nc0H65iNsPUfjDNtopd++JK53kYWQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 20, 2022 at 05:05:49PM -0700, Ian Rogers escreveu:
> On Thu, Oct 20, 2022 at 10:26 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It now has 4 sub tests and one of them should run at least.
> > But once TEST_SKIP (= 2) return value is set, it won't be overwritten
> > unless there's a failure.  I think we should return success when one
> > or more tested are skipped but the remaining subtests are passed.
> >
> > So update the test code not to set the err variable when it skips
> > the test.
> >
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Perhaps we can have proper sub-tests in shell tests like we do for the C ones.

Yeah, giving info about the various subtests helps in giving progress
information and overal confidence that more stuff is being tested.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/record.sh | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> > index 01aa9531b369..e93b3a8871fe 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -81,10 +81,6 @@ test_per_thread() {
> >    if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
> >    then
> >      echo "Per-thread record [Skipped event not supported]"
> > -    if [ $err -ne 1 ]
> > -    then
> > -      err=2
> > -    fi
> >      return
> >    fi
> >    if ! perf record --per-thread -o "${perfdata}" ${testprog} 2> /dev/null
> > @@ -131,10 +127,6 @@ test_register_capture() {
> >    if ! perf list | grep -q 'br_inst_retired.near_call'
> >    then
> >      echo "Register capture test [Skipped missing event]"
> > -    if [ $err -ne 1 ]
> > -    then
> > -      err=2
> > -    fi
> >      return
> >    fi
> >    if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> > @@ -159,10 +151,6 @@ test_system_wide() {
> >    if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
> >    then
> >      echo "System-wide record [Skipped not supported]"
> > -    if [ $err -ne 1 ]
> > -    then
> > -      err=2
> > -    fi
> >      return
> >    fi
> >    if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
> > --
> > 2.38.0.135.g90850a2211-goog
> >

-- 

- Arnaldo
