Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5596872E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBBBS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBBBSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26431EF8C;
        Wed,  1 Feb 2023 17:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F4B619A5;
        Thu,  2 Feb 2023 01:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C40EC433EF;
        Thu,  2 Feb 2023 01:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300724;
        bh=ho8EUnBbpt5/Dr9N4HX5AE0tdqFpcj1JCqTlt/TNsKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8nBKNjbJr/WGIqc6C7x88ABBXdcdTN4fzFS7v9Jg25W+USCoXEoNfCZZ17eBYy+9
         sPm5FmayDwqL6Ljrw2o9czg6NsdNe17b3IEmF94IDNbGkuM4DlGbbYx1RotzMr+lZN
         OIYJSHvanmHZ5X/rFLDDNi3VuG3BQ8BH2rqUzUaLJexiKiYkFhrFL+QXD4Oe77wD9T
         Rw3cDElAAVG2NWBsoRrrPQQwJyXDMPTU7exuW+EWqNa59cAZhZpbIOfF0QkpgmkSLB
         wEceviQAaaNxvzlvjkQ7aQwGtd0kg8Yn9NqciPoTq25w7j6kBG51ElGMMU1iKrXKTE
         No2kB92bIeeeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23DC2405BE; Wed,  1 Feb 2023 22:18:41 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:18:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        qzhao@redhat.com, cjense@google.com,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf test: Fix JSON format linter test checks
Message-ID: <Y9sPcfnJJ3BDHUA0@kernel.org>
References: <20230120134039.17788-1-mpetlan@redhat.com>
 <20230120134039.17788-3-mpetlan@redhat.com>
 <Y9PC2+Yqh3W8wyNU@kernel.org>
 <Y9PDycrODMfeUSA2@kernel.org>
 <alpine.LRH.2.20.2301311803440.5281@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2301311803440.5281@Diego>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 31, 2023 at 06:14:17PM +0100, Michael Petlan escreveu:
> On Fri, 27 Jan 2023, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jan 27, 2023 at 09:26:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> [...]
> 
> > > Before I apply this first patch I can run, as root, the 'perf test' JSON
> > > lint 100 times without problems:
> > > 
> > > [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> > > 1 98: perf stat JSON output linter                                    : Ok
> > > 2 98: perf stat JSON output linter                                    : Ok
> > > 3 98: perf stat JSON output linter                                    : Ok
> > > 4 98: perf stat JSON output linter                                    : Ok
> > > <SNIP>
> > > 96 98: perf stat JSON output linter                                    : Ok
> > > 97 98: perf stat JSON output linter                                    : Ok
> > > 98 98: perf stat JSON output linter                                    : Ok
> > > 99 98: perf stat JSON output linter                                    : Ok
> > > 100 98: perf stat JSON output linter                                    : Ok
> > > [root@quaco ~]#
> > > 
> > > After applying it it fails seemingly randomly, I'll remove both patches
> > > from my tmp.perf/core branch and investigate.
> 
> Hello Arnaldo. Have you found anything?
> 
> Which patch of the two causes the failures? The one that changes the JSON

Its described below, the first patch introduces the problem.

IT may well be due to the Intel model of my test machine, from what I
could read on the other threads about the "all metrics test", but I
haven't had time to fully investigate.

[acme@quaco pahole]$ grep -m1 ^model\ name /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
[acme@quaco pahole]$ 

- Arnaldo

> printing or the second that changes the test?
> 
> I hope that the JSON printing is now correct, it seems to be, at least on my
> machine + the SPR box I was debugging this on.
> 
> 
> > > 
> > > [acme@quaco perf]$ git log --oneline -1
> > > fdafd42aac3629db (HEAD) perf stat: Fix JSON metric printout for multiple metrics per line
> > > [acme@quaco perf]$ perf -v
> > > perf version 6.2.rc5.gfdafd42aac36
> > > [acme@quaco perf]$
> > > [root@quaco ~]# perf -v
> > > perf version 6.2.rc5.gfdafd42aac36
> > > [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> > > [root@quaco ~]# perf -v
> > > perf version 6.2.rc5.gfdafd42aac36
> > > [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> > > 1 98: perf stat JSON output linter                                    : Ok
> > > 2 98: perf stat JSON output linter                                    : Ok
> > > 3 98: perf stat JSON output linter                                    : FAILED!
> > > 4 98: perf stat JSON output linter                                    : Ok
> > 
> > BTW, after applying the second patch, the one for 'perf test', the
> > problem persists:
> > 
> > [acme@quaco perf]$ git log --oneline -1
> > 320cd37176508ec2 (HEAD, acme/tmp.perf/core, acme.korg/tmp.perf/core) perf test: Fix JSON format linter test checks
> > [acme@quaco perf]$ perf -v
> > perf version 6.2.rc5.g320cd3717650
> > [acme@quaco perf]$
> > [root@quaco ~]# perf -v
> > perf version 6.2.rc5.g320cd3717650
> > [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> > 1 98: perf stat JSON output linter                                    : Ok
> > 2 98: perf stat JSON output linter                                    : FAILED!
> > 3 98: perf stat JSON output linter                                    : Ok
> > 4 98: perf stat JSON output linter                                    : Ok
> > 5 98: perf stat JSON output linter                                    : FAILED!
> > 6 98: perf stat JSON output linter                                    : Ok
> > 7 98: perf stat JSON output linter                                    : FAILED!
> > 8 98: perf stat JSON output linter                                    : Ok
> > 9 98: perf stat JSON output linter                                    : Ok
> > 10 98: perf stat JSON output linter                                    : FAILED!
> > 11 98: perf stat JSON output linter                                    : FAILED!
> > 12 98: perf stat JSON output linter                                    : FAILED!
> > 13 98: perf stat JSON output linter                                    : Ok
> > 14 98: perf stat JSON output linter                                    : Ok
> > 15 98: perf stat JSON output linter                                    : FAILED!
> > 16 98: perf stat JSON output linter                                    : FAILED!
> > 17 98: perf stat JSON output linter                                    : FAILED!
> > 18 98: perf stat JSON output linter                                    :^C
> > [root@quaco ~]#
> > 
> > When it works:
> > 
> > [root@quaco ~]# perf test -v 98
> >  98: perf stat JSON output linter                                    :
> > --- start ---
> > test child forked, pid 62202
> > Checking json output: no args [Success]
> > Checking json output: system wide [Success]
> > Checking json output: interval [Success]
> > Checking json output: event [Success]
> > Checking json output: per thread [Success]
> > Checking json output: per node [Success]
> > Checking json output: system wide Checking json output: system wide no aggregation [Success]
> > Checking json output: per core [Success]
> > Checking json output: per die [Success]
> > Checking json output: per socket [Success]
> > test child finished with 0
> > ---- end ----
> > perf stat JSON output linter: Ok
> > [root@quaco ~]#
> > 
> > When it fails:
> > 
> > [root@quaco ~]# perf test -v 98
> >  98: perf stat JSON output linter                                    :
> > --- start ---
> > test child forked, pid 62270
> > Checking json output: no args [Success]
> > Checking json output: system wide [Success]
> > Checking json output: interval [Success]
> > Checking json output: event [Success]
> > Checking json output: per thread Test failed for input:
> > {"thread" : "rcu_preempt-16", "counter-value" : "0.018340", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 19071, "pcnt-running" : 100.00, "metric-value" : 0.001758, "metric-unit" : "CPUs utilized"}
> > 
> > {"thread" : "gnome-terminal--2977", "counter-value" : "0.061868", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 62075, "pcnt-running" : 100.00, "metric-value" : 0.005930, "metric-unit" : "CPUs utilized"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "9.398635", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 9398904, "pcnt-running" : 100.00, "metric-value" : 0.900916, "metric-unit" : "CPUs utilized"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "4.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 15203, "pcnt-running" : 100.00, "metric-value" : 218.102508, "metric-unit" : "K/sec"}
> > 
> > {"thread" : "gnome-terminal--2977", "counter-value" : "1.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 62075, "pcnt-running" : 100.00, "metric-value" : 16.163445, "metric-unit" : "K/sec"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "1.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 9388658, "pcnt-running" : 100.00, "metric-value" : 106.398429, "metric-unit" : "/sec"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "1.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 12511, "pcnt-running" : 100.00, "metric-value" : 54.525627, "metric-unit" : "K/sec"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "2.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 9427495, "pcnt-running" : 100.00, "metric-value" : 212.796858, "metric-unit" : "/sec"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "41498.000000", "unit" : "", "event" : "cycles", "event-runtime" : 20944, "pcnt-running" : 100.00, "metric-value" : 2.262704, "metric-unit" : "GHz"}
> > 
> > {"thread" : "ksoftirqd/1-22", "counter-value" : "23883.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9949, "pcnt-running" : 100.00}
> > 
> > {"thread" : "perf-62294", "counter-value" : "36686750.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9439269, "pcnt-running" : 100.00, "metric-value" : 3.903413, "metric-unit" : "GHz"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "25086.000000", "unit" : "", "event" : "instructions", "event-runtime" : 20944, "pcnt-running" : 100.00, "metric-value" : 0.604511, "metric-unit" : "insn per cycle"}
> > 
> > {"thread" : "ksoftirqd/1-22", "counter-value" : "13360.000000", "unit" : "", "event" : "instructions", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 0.559394, "metric-unit" : "insn per cycle"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "7905940.000000", "unit" : "", "event" : "instructions", "event-runtime" : 9438686, "pcnt-running" : 100.00, "metric-value" : 0.215499, "metric-unit" : "insn per cycle"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "3951.000000", "unit" : "", "event" : "branches", "event-runtime" : 16533, "pcnt-running" : 100.00, "metric-value" : 215.430752, "metric-unit" : "M/sec"}
> > 
> > {"thread" : "ksoftirqd/1-22", "counter-value" : "2822.000000", "unit" : "", "event" : "branches", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "/sec"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "1691804.000000", "unit" : "", "event" : "branches", "event-runtime" : 9474118, "pcnt-running" : 100.00, "metric-value" : 180.005288, "metric-unit" : "M/sec"}
> > 
> > {"thread" : "rcu_preempt-16", "counter-value" : "279.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 16533, "pcnt-running" : 100.00, "metric-value" : 7.061503, "metric-unit" : "of all branches"}
> > 
> > {"thread" : "ksoftirqd/1-22", "counter-value" : "153.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 5.421687, "metric-unit" : "of all branches"}
> > 
> > {"thread" : "kworker/1:2-events-752", "counter-value" : "121.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9850, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "of all branches"}
> > 
> > {"thread" : "perf-62294", "counter-value" : "52693.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9451948, "pcnt-running" : 100.00, "metric-value" : 3.114604, "metric-unit" : "of all branches"}
> > 
> > Traceback (most recent call last):
> >   File "/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
> >     check_json_output(expected_items)
> >   File "/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 54, in check_json_output
> >     raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
> > RuntimeError: wrong number of fields. counted 6 expected [8, 10] in '{"thread" : "ksoftirqd/1-22", "counter-value" : "23883.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9949, "pcnt-running" : 100.00}
> 
> Here it seems that the test finds unexpected number of entities in the
> line. It can be, 6 is not in [8, 10]. However, since the line looks OK,
> we should expand the set of accepted results to [6, 8, 10] then.
> 
> If this fails even without the test patch, so only with my JSON printing
> patch, AND it does NOT fail without it, it seems very weird. The patch
> fixes the JSON format breakage that happens when two metrics are per line.
> 
> The JSON output above looks sane, especially looking at the line that
> failed:
> 
>   {"thread" : "ksoftirqd/1-22", "counter-value" : "23883.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9949, "pcnt-running" : 100.00}
> 
> It rather seems that depending on the values counted, something gets
> computed or not, and that changes the output, so sometimes a line with
> unexpected count of elements appears there. Couldn't anything else
> cause the change of the output?
> 
> Michael
> > '
> > test child finished with -1
> > ---- end ----
> > perf stat JSON output linter: FAILED!
> > [root@quaco ~]#
> > 
> > 
> 

-- 

- Arnaldo
