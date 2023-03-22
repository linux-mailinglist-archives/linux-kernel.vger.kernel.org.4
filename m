Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BCB6C5536
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCVTx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCVTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC933588;
        Wed, 22 Mar 2023 12:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2C2622B0;
        Wed, 22 Mar 2023 19:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EAC433EF;
        Wed, 22 Mar 2023 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514802;
        bh=EGfL4wE35fMS5oDaoUpz/hYODYp4mxJqoH76jji9RMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofPgkeX4sJ9kjTTldjKJui3kiZ1za7IA8Zq3EjhKjPyQhfJcMoGpCmVGoOAqd3Gbi
         zTAX7t/jbnhnJlApGpEosA9WdhhaJ1ynxb44j/aaGuwkd6C9JLjmWX03TX/nkml8hz
         LZzZ/KF/zKN8Qv/mrmMolP+MP1ko8sIg46We8B+qHzeFmaQP9igadP6LMo+QEPRp5S
         g62QolZAHRs1pOdfOO1SejxzhICW5Vu/LM5L60nCvH0t3jEH5liPV3d6g8aNcqpG6b
         XsmvU5aXystQf3ANqNaGwjoTXGxE7V7xp15rhF7L5TGYAz5tH1BpDD5zObq0vTISyD
         eQRjck3nyJASA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 125334052D; Wed, 22 Mar 2023 16:53:19 -0300 (-03)
Date:   Wed, 22 Mar 2023 16:53:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@redhat.com, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [Ping PATCH] perf/test: Fix wrong size for perf test Setup
 struct perf_event_attr
Message-ID: <ZBtcrxcljttJXyhM@kernel.org>
References: <20230322094731.1768281-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322094731.1768281-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 22, 2023 at 10:47:31AM +0100, Thomas Richter escreveu:
> The test case ./perf test 'Setup struct perf_event_attr' fails.
> On s390 this output is observed:

Thanks, applied.

- Arnaldo

 
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  .....
>  Event event:base-stat
>       fd = 1
>       group_fd = -1
>       flags = 0|8
>       cpu = *
>       type = 0
>       size = 128     <<<--- wrong, specified in file base-stat
>       config = 0
>       sample_period = 0
>       sample_type = 65536
>       ...
>  'PERF_TEST_ATTR=/tmp/tmpgw574wvg ./perf stat -o \
> 	/tmp/tmpgw574wvg/perf.data -e cycles -C 0 kill >/dev/null \
> 	2>&1 ret '1', expected '1'
>   loading result events
>     Event event-0-0-4
>       fd = 4
>       group_fd = -1
>       cpu = 0
>       pid = -1
>       flags = 8
>       type = 0
>       size = 136     <<<--- actual size used in system call
>       .....
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 128
>     ->FAIL
>     match: [event-0-0-4] matches []
>   expected size=136, got 128
>   FAILED './tests/attr/test-stat-C0' - match failure
> 
> This mismatch is caused by
> commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> which enlarges the structure perf_event_attr by 8 bytes.
> 
> Fix this by adjusting the expected value of size.
> 
> Output after:
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  ...
>   matched
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 136
>       ....
>    ->OK
>    match: [event-0-0-4] matches ['event:base-stat']
>  matched
> 
> Fixes: 09519ec3b19e ("perf: Add perf_event_attr::config3")
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/attr/base-record       | 2 +-
>  tools/perf/tests/attr/base-stat         | 2 +-
>  tools/perf/tests/attr/system-wide-dummy | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index 3ef07a12aa14..27c21271a16c 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0|1
> -size=128
> +size=136
>  config=0
>  sample_period=*
>  sample_type=263
> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
> index 408164456530..a21fb65bc012 100644
> --- a/tools/perf/tests/attr/base-stat
> +++ b/tools/perf/tests/attr/base-stat
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0
> -size=128
> +size=136
>  config=0
>  sample_period=0
>  sample_type=65536
> diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> index 8fec06eda5f9..2f3e3eb728eb 100644
> --- a/tools/perf/tests/attr/system-wide-dummy
> +++ b/tools/perf/tests/attr/system-wide-dummy
> @@ -7,7 +7,7 @@ cpu=*
>  pid=-1
>  flags=8
>  type=1
> -size=128
> +size=136
>  config=9
>  sample_period=4000
>  sample_type=455
> -- 
> 2.39.1
> 

-- 

- Arnaldo
