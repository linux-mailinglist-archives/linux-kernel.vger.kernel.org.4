Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173767A131
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjAXShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:37:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A41DBAE;
        Tue, 24 Jan 2023 10:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2EE6B81626;
        Tue, 24 Jan 2023 18:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274CC433D2;
        Tue, 24 Jan 2023 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674585432;
        bh=hCdYGWDy8HIpUL6sAKMF4dNeucZnRYc0zxhb/g2N3z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arMTQO4Fc6t55X9qOMySU3mPdMhJJLF2z4i9492+03LnHUekQ/IHmuVQ3e3+1ZYAH
         MAsgcs8JpMgc/mk1uGiVsRwuyU/TtZbRgdJvQS3ZnO6o3+qsSBERLSY0acvgCcKIN1
         hNkX7zP55w2p0N6Vh91vB0bgux2qRZHnQfLrjko5ZPmMPrmEY/sfyU/lBpWeH1VPlp
         0piapnpjfw5EhP0EP6SIii1yD7SCmjVFxTxR/JL6Y78MSK9/v5DMgHHGyOGVbBrVgs
         cHeU9LNuC91YZW5++Cbqzdc7RaEZJegC9WsSziEOkE+PhWue6jIF5oeQOT8daB7pYP
         9eFVVFaPukZ/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80E1E405BE; Tue, 24 Jan 2023 15:37:10 -0300 (-03)
Date:   Tue, 24 Jan 2023 15:37:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.or, linux-kernel@vger.kernel.org,
        leo.yan@linaro.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf mem/c2c: Document that SPE is used for mem and c2c
 on Arm
Message-ID: <Y9AlVmA+dZLm2uwi@kernel.org>
References: <20230124145929.557891-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124145929.557891-1-james.clark@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 24, 2023 at 02:59:29PM +0000, James Clark escreveu:
> Setup is non-trivial so also link to the full SPE docs.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/Documentation/perf-c2c.txt | 8 ++++++--
>  tools/perf/Documentation/perf-mem.txt | 7 ++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index af5c3106f468..4e8c263e1721 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -22,7 +22,11 @@ you to track down the cacheline contentions.
>  On Intel, the tool is based on load latency and precise store facility events
>  provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
>  with thresholding feature. On AMD, the tool uses IBS op pmu (due to hardware
> -limitations, perf c2c is not supported on Zen3 cpus).
> +limitations, perf c2c is not supported on Zen3 cpus). On Arm64 it uses SPE to
> +sample load and store operations, therefore hardware and kernel support is
> +required. See linkperf:perf-arm-spe[1] for a setup guide. Due to the
> +statistical nature of Arm SPE sampling, not every memory operation will be
> +sampled.
>  
>  These events provide:
>    - memory address of the access
> @@ -333,4 +337,4 @@ Check Joe's blog on c2c tool for detailed use case explanation:
>  
>  SEE ALSO
>  --------
> -linkperf:perf-record[1], linkperf:perf-mem[1]
> +linkperf:perf-record[1], linkperf:perf-mem[1], linkperf:perf-arm-spe[1]
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index 005c95580b1e..19862572e3f2 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -23,6 +23,11 @@ Note that on Intel systems the memory latency reported is the use-latency,
>  not the pure load (or store latency). Use latency includes any pipeline
>  queueing delays in addition to the memory subsystem latency.
>  
> +On Arm64 this uses SPE to sample load and store operations, therefore hardware
> +and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
> +Due to the statistical nature of SPE sampling, not every memory operation will
> +be sampled.
> +
>  OPTIONS
>  -------
>  <command>...::
> @@ -93,4 +98,4 @@ all perf record options.
>  
>  SEE ALSO
>  --------
> -linkperf:perf-record[1], linkperf:perf-report[1]
> +linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]
> 
> base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
> -- 
> 2.39.1
> 

-- 

- Arnaldo
