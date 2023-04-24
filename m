Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74D6ED3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjDXRpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A12E9;
        Mon, 24 Apr 2023 10:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77A960EDE;
        Mon, 24 Apr 2023 17:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC165C433D2;
        Mon, 24 Apr 2023 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682358350;
        bh=808DQgGPAc1pXUH4EhUIf4sYh1ZGvIS8hF1msuy+Dlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkyQPcDyY6n9DkPX6QFR0hKxuEJXcIeXfroyhmpUY76ONRKMVlX2MwjpXZ+8pAa7H
         2bJJN+MGtO05MirZQDbkqImenMB5dvcDw+zOw4TRnCKqPUV57KDEZCxle55/evBK6C
         VrAMhtH1JyW5upI4ha/qAk/riiq5QyuAe1LtxqWw+TQt/zmi6ARblMQa3Ewls5QO0X
         yAS7VZYdl5DDFkEdSq5+0ot8QhRSNEtL3xZhBmWe6eks52i1mh7m31vfIjQdOB1B36
         trYpKzoXXkbwtKO1aPknzPBJDjT0kGEX+bDAmQnMFZuniwoaYdRqi93ISq7iXo5Kna
         extIWAtGxTSgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 440F3403C5; Mon, 24 Apr 2023 14:45:47 -0300 (-03)
Date:   Mon, 24 Apr 2023 14:45:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] perf tools: Add util function for overriding user
 set config values
Message-ID: <ZEbAS2yx2fguW60w@kernel.org>
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-3-james.clark@arm.com>
 <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7940a4a-fc62-17ca-834b-73628a54cc2a@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 24, 2023 at 06:36:14PM +0300, Adrian Hunter escreveu:
> On 24/04/23 16:47, James Clark wrote:
> > There is some duplicated code to only override config values if they
> > haven't already been set by the user so make a util function for this.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> One minor comment, nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

I just moved to  evsel__set_config_if_unset() to util/pmu.c, next to
some other evsel__ functions to not break the python.so binding, before
I was getting:

[acme@quaco perf-tools-next]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 19: 'import perf' in python                                         :
--- start ---
test child forked, pid 500086
python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: perf_pmu__format_bits
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[acme@quaco perf-tools-next]$

Please run 'perf test' and 'make -C tools/perf build-test' prior to
sending pull requests,

Thanks, applied.

- Arnaldo

