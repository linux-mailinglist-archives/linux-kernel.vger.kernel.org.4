Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A267E533
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjA0MaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjA0MaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:30:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CC2EF;
        Fri, 27 Jan 2023 04:30:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B88CB82050;
        Fri, 27 Jan 2023 12:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2078C433D2;
        Fri, 27 Jan 2023 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674822604;
        bh=vH2S3QTL88n8UkKlzXAG+HLWuxF+TDSqv4WGt7x7NKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdeoVrfTGv8Z2UEsUYqY5j2xlNjlukeIpc6w73uHkA8HWvJsbSV9jozKLUZdzR+b+
         oxm0ZkMa1phas/Z4CAG1ez4LyXrRvzZHoCimyWp+PbsBFjL6GOE7GEk3I538ahyKuI
         SrJ5stOb7faFgEJ6XhK/H1FQJRPUr5y61due82yOV1htLYsh07UYlj3mFkaIt8VLfe
         NKhHK3c/bs38YIIAObak4fxQohu3oWpG3IUT04gAVHzbojZM4CV8Z/FsntTGgCEEzo
         b/V090NvLJkj2JaUevNWVXl5/8NrZq+7Ohonq86K4LjfTyVjlstEWLMiK/dn81OHqN
         CF5MtkWZ9a4FQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A409405BE; Fri, 27 Jan 2023 09:30:01 -0300 (-03)
Date:   Fri, 27 Jan 2023 09:30:01 -0300
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
Message-ID: <Y9PDycrODMfeUSA2@kernel.org>
References: <20230120134039.17788-1-mpetlan@redhat.com>
 <20230120134039.17788-3-mpetlan@redhat.com>
 <Y9PC2+Yqh3W8wyNU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PC2+Yqh3W8wyNU@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 27, 2023 at 09:26:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jan 20, 2023 at 02:40:39PM +0100, Michael Petlan escreveu:
> > The test fails on CPUs with topdown metrics, where it is common to print
> > two metrics per line. Since these are included in default event set for
> > `perf stat -- something`, it causes the "no args" subtest to fail due to
> > unexpected member count. We need to accept 7 or 9 members in that case.
> > 
> > Coming to that, counting commas in the JSON line and consider it a number
> > of elements is incorrect and misleading. There should be +1 element than
> > the count of commas, while also, commas can potentially appear in the
> > event names. Count " : " substrings rather, since these better fit to
> > what should be actually counted.
> 
> Before I apply this first patch I can run, as root, the 'perf test' JSON
> lint 100 times without problems:
> 
> [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> 1 98: perf stat JSON output linter                                    : Ok
> 2 98: perf stat JSON output linter                                    : Ok
> 3 98: perf stat JSON output linter                                    : Ok
> 4 98: perf stat JSON output linter                                    : Ok
> <SNIP>
> 96 98: perf stat JSON output linter                                    : Ok
> 97 98: perf stat JSON output linter                                    : Ok
> 98 98: perf stat JSON output linter                                    : Ok
> 99 98: perf stat JSON output linter                                    : Ok
> 100 98: perf stat JSON output linter                                    : Ok
> [root@quaco ~]#
> 
> After applying it it fails seemingly randomly, I'll remove both patches
> from my tmp.perf/core branch and investigate.
> 
> [acme@quaco perf]$ git log --oneline -1
> fdafd42aac3629db (HEAD) perf stat: Fix JSON metric printout for multiple metrics per line
> [acme@quaco perf]$ perf -v
> perf version 6.2.rc5.gfdafd42aac36
> [acme@quaco perf]$
> [root@quaco ~]# perf -v
> perf version 6.2.rc5.gfdafd42aac36
> [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> [root@quaco ~]# perf -v
> perf version 6.2.rc5.gfdafd42aac36
> [root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
> 1 98: perf stat JSON output linter                                    : Ok
> 2 98: perf stat JSON output linter                                    : Ok
> 3 98: perf stat JSON output linter                                    : FAILED!
> 4 98: perf stat JSON output linter                                    : Ok

BTW, after applying the second patch, the one for 'perf test', the
problem persists:

[acme@quaco perf]$ git log --oneline -1
320cd37176508ec2 (HEAD, acme/tmp.perf/core, acme.korg/tmp.perf/core) perf test: Fix JSON format linter test checks
[acme@quaco perf]$ perf -v
perf version 6.2.rc5.g320cd3717650
[acme@quaco perf]$
[root@quaco ~]# perf -v
perf version 6.2.rc5.g320cd3717650
[root@quaco ~]# for a in $(seq 100) ; do echo -n $a ; perf test 98 ; done
1 98: perf stat JSON output linter                                    : Ok
2 98: perf stat JSON output linter                                    : FAILED!
3 98: perf stat JSON output linter                                    : Ok
4 98: perf stat JSON output linter                                    : Ok
5 98: perf stat JSON output linter                                    : FAILED!
6 98: perf stat JSON output linter                                    : Ok
7 98: perf stat JSON output linter                                    : FAILED!
8 98: perf stat JSON output linter                                    : Ok
9 98: perf stat JSON output linter                                    : Ok
10 98: perf stat JSON output linter                                    : FAILED!
11 98: perf stat JSON output linter                                    : FAILED!
12 98: perf stat JSON output linter                                    : FAILED!
13 98: perf stat JSON output linter                                    : Ok
14 98: perf stat JSON output linter                                    : Ok
15 98: perf stat JSON output linter                                    : FAILED!
16 98: perf stat JSON output linter                                    : FAILED!
17 98: perf stat JSON output linter                                    : FAILED!
18 98: perf stat JSON output linter                                    :^C
[root@quaco ~]#

When it works:

[root@quaco ~]# perf test -v 98
 98: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 62202
Checking json output: no args [Success]
Checking json output: system wide [Success]
Checking json output: interval [Success]
Checking json output: event [Success]
Checking json output: per thread [Success]
Checking json output: per node [Success]
Checking json output: system wide Checking json output: system wide no aggregation [Success]
Checking json output: per core [Success]
Checking json output: per die [Success]
Checking json output: per socket [Success]
test child finished with 0
---- end ----
perf stat JSON output linter: Ok
[root@quaco ~]#

When it fails:

[root@quaco ~]# perf test -v 98
 98: perf stat JSON output linter                                    :
--- start ---
test child forked, pid 62270
Checking json output: no args [Success]
Checking json output: system wide [Success]
Checking json output: interval [Success]
Checking json output: event [Success]
Checking json output: per thread Test failed for input:
{"thread" : "rcu_preempt-16", "counter-value" : "0.018340", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 19071, "pcnt-running" : 100.00, "metric-value" : 0.001758, "metric-unit" : "CPUs utilized"}

{"thread" : "gnome-terminal--2977", "counter-value" : "0.061868", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 62075, "pcnt-running" : 100.00, "metric-value" : 0.005930, "metric-unit" : "CPUs utilized"}

{"thread" : "perf-62294", "counter-value" : "9.398635", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 9398904, "pcnt-running" : 100.00, "metric-value" : 0.900916, "metric-unit" : "CPUs utilized"}

{"thread" : "rcu_preempt-16", "counter-value" : "4.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 15203, "pcnt-running" : 100.00, "metric-value" : 218.102508, "metric-unit" : "K/sec"}

{"thread" : "gnome-terminal--2977", "counter-value" : "1.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 62075, "pcnt-running" : 100.00, "metric-value" : 16.163445, "metric-unit" : "K/sec"}

{"thread" : "perf-62294", "counter-value" : "1.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 9388658, "pcnt-running" : 100.00, "metric-value" : 106.398429, "metric-unit" : "/sec"}

{"thread" : "rcu_preempt-16", "counter-value" : "1.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 12511, "pcnt-running" : 100.00, "metric-value" : 54.525627, "metric-unit" : "K/sec"}

{"thread" : "perf-62294", "counter-value" : "2.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 9427495, "pcnt-running" : 100.00, "metric-value" : 212.796858, "metric-unit" : "/sec"}

{"thread" : "rcu_preempt-16", "counter-value" : "41498.000000", "unit" : "", "event" : "cycles", "event-runtime" : 20944, "pcnt-running" : 100.00, "metric-value" : 2.262704, "metric-unit" : "GHz"}

{"thread" : "ksoftirqd/1-22", "counter-value" : "23883.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9949, "pcnt-running" : 100.00}

{"thread" : "perf-62294", "counter-value" : "36686750.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9439269, "pcnt-running" : 100.00, "metric-value" : 3.903413, "metric-unit" : "GHz"}

{"thread" : "rcu_preempt-16", "counter-value" : "25086.000000", "unit" : "", "event" : "instructions", "event-runtime" : 20944, "pcnt-running" : 100.00, "metric-value" : 0.604511, "metric-unit" : "insn per cycle"}

{"thread" : "ksoftirqd/1-22", "counter-value" : "13360.000000", "unit" : "", "event" : "instructions", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 0.559394, "metric-unit" : "insn per cycle"}

{"thread" : "perf-62294", "counter-value" : "7905940.000000", "unit" : "", "event" : "instructions", "event-runtime" : 9438686, "pcnt-running" : 100.00, "metric-value" : 0.215499, "metric-unit" : "insn per cycle"}

{"thread" : "rcu_preempt-16", "counter-value" : "3951.000000", "unit" : "", "event" : "branches", "event-runtime" : 16533, "pcnt-running" : 100.00, "metric-value" : 215.430752, "metric-unit" : "M/sec"}

{"thread" : "ksoftirqd/1-22", "counter-value" : "2822.000000", "unit" : "", "event" : "branches", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "/sec"}

{"thread" : "perf-62294", "counter-value" : "1691804.000000", "unit" : "", "event" : "branches", "event-runtime" : 9474118, "pcnt-running" : 100.00, "metric-value" : 180.005288, "metric-unit" : "M/sec"}

{"thread" : "rcu_preempt-16", "counter-value" : "279.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 16533, "pcnt-running" : 100.00, "metric-value" : 7.061503, "metric-unit" : "of all branches"}

{"thread" : "ksoftirqd/1-22", "counter-value" : "153.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9949, "pcnt-running" : 100.00, "metric-value" : 5.421687, "metric-unit" : "of all branches"}

{"thread" : "kworker/1:2-events-752", "counter-value" : "121.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9850, "pcnt-running" : 100.00, "metric-value" : 0.000000, "metric-unit" : "of all branches"}

{"thread" : "perf-62294", "counter-value" : "52693.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 9451948, "pcnt-running" : 100.00, "metric-value" : 3.114604, "metric-unit" : "of all branches"}

Traceback (most recent call last):
  File "/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
    check_json_output(expected_items)
  File "/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py", line 54, in check_json_output
    raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
RuntimeError: wrong number of fields. counted 6 expected [8, 10] in '{"thread" : "ksoftirqd/1-22", "counter-value" : "23883.000000", "unit" : "", "event" : "cycles", "event-runtime" : 9949, "pcnt-running" : 100.00}
'
test child finished with -1
---- end ----
perf stat JSON output linter: FAILED!
[root@quaco ~]#
