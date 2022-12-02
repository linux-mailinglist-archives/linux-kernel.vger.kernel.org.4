Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60D0640DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiLBSqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiLBSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:46:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17785DBF7C;
        Fri,  2 Dec 2022 10:46:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFA6B82242;
        Fri,  2 Dec 2022 18:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC0C433D6;
        Fri,  2 Dec 2022 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670006771;
        bh=YtK9Rbdr1BlS3FSUUNTiCqS+imWPNk+kOo2kMIyNNM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Veqd9XW81oxxEbsNRNDEgPtmBM9t3alXRz/iHXbDe4SWPYL2PPtB5DMMcTRheaVZF
         +VilR/FjgxMTuvnFaDiupnkksVg3HFcAHryuyd3raOqRHML2mD0Ts637Hg3+Ejktvw
         3TkMfjqKTcazHdLwsix/z/CoXD+IQP3ZgGogrRc8kV7vrHNCKtMQlRvlU3nB51RTWm
         PtbeYo0L8yloL0W3oSV6U3TnT2l7hqgGDJQNfm/kGslt+6omGXCkeLqWsCRF/1Kfdf
         Wxoi2iBDnXUNRwM1k9kxKgb/la0iFU5f/EL5CZo1TKdaymorgi2gc/LHeNpgrcjvFl
         kdOwdUGHqtyqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFAA34034E; Fri,  2 Dec 2022 15:46:08 -0300 (-03)
Date:   Fri, 2 Dec 2022 15:46:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] perf tests: Fix "perf stat JSON output linter" test
 for new output
Message-ID: <Y4pH8NEzfAPGkyW7@kernel.org>
References: <20221130111521.334152-1-james.clark@arm.com>
 <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 30, 2022 at 10:18:49AM -0800, Ian Rogers escreveu:
> On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
> >
> > Commit c4b41b83c250 ("perf stat: Rename "aggregate-number" to
> > "cpu-count" in JSON") renamed a field, so update the tests to reflect
> > this.
> >
> > This fixes the following failure:
> >
> >   $ sudo ./perf test "json output" -vvv
> >    96: perf stat JSON output linter                                    :
> >   --- start ---
> >   test child forked, pid 327720
> >   Checking json output: no args [Success]
> >   Checking json output: system wide [Success]
> >   Checking json output: interval [Success]
> >   Checking json output: event [Success]
> >   Checking json output: per thread [Success]
> >   Checking json output: per node Test failed for input:
> >   ...
> >   Traceback (most recent call last):
> >     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
> >       check_json_output(expected_items)
> >     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 78, in check_json_output
> >       raise RuntimeError(f'Unexpected key: key={key} value={value}')
> >   RuntimeError: Unexpected key: key=cpu-count value=16
> >   test child finished with -1
> >   ---- end ----
> >   perf stat JSON output linter: FAILED!
> >
> > Fixes: c4b41b83c250 ("perf stat: Rename "aggregate-number" to "cpu-count" in JSON")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Namhyung mentioned reverting change c4b41b83c250, in which case
> merging this would break the test again. I think the revert is better.

Applied the revert, with an Acked-by: you.
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > index d90f8d102eb9..9c073e257d33 100644
> > --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> > @@ -54,7 +54,7 @@ def check_json_output(expected_items):
> >            raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
> >                               f' in \'{line}\'')
> >    checks = {
> > -      'aggregate-number': lambda x: isfloat(x),
> > +      'cpu-count': lambda x: isfloat(x),
> >        'core': lambda x: True,
> >        'counter-value': lambda x: is_counter_value(x),
> >        'cgroup': lambda x: True,
> > --
> > 2.25.1
> >

-- 

- Arnaldo
