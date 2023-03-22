Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419A6C5530
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCVTuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCVTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:50:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EF34ECE4;
        Wed, 22 Mar 2023 12:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BE7CB81DC6;
        Wed, 22 Mar 2023 19:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5918AC433D2;
        Wed, 22 Mar 2023 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679514647;
        bh=5v6hCla1ZU7x7GPUKTYMyc2K+buglnhEtB13j0YWNGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=af0JDe+rbLx8wgW58K9HqfCcTpqOqvRNZRLyaljX6ljwWZSh2k/2Tn/lzWX9baZuJ
         IPgUxB/dB4a1xsZeOpu7zkmPg6SvXwANhbYvCkg4vrT6jaUM89zItK5uhaVwZIOw4r
         xDN0ZT6m/3Z6HZQE6Go8JUzOZAUwBw0Cg0ko9LJ1GQBKKv5sfK+qvBdFdA57a/Krks
         JCqyez9SrP1Q/97++K5h3k+WsIF38sgoTctvhHNBJHHkZcexE9GvgJs6Flayzbg0Wq
         GBIeGAdBbdi76qfjb8iZWoDjlkHqeU/qvrrqR7TCj+9BKVv1Yo7yJ3iUM+PxECuROP
         by01zla384w7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE11F4052D; Wed, 22 Mar 2023 16:50:44 -0300 (-03)
Date:   Wed, 22 Mar 2023 16:50:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] perf build: Add warning for when vmlinux.h generation
 fails
Message-ID: <ZBtcFHMsdUPGrPX4@kernel.org>
References: <20230322183108.1380882-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322183108.1380882-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 22, 2023 at 11:31:08AM -0700, Ian Rogers escreveu:
> The warning advises on the NO_BPF_SKEL=1 option.

Looks ok, applying.

- Arnaldo
 
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index ed6b6a070f79..48aba186ceb5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1072,7 +1072,11 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>  
>  $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>  ifeq ($(VMLINUX_H),)
> -	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> +	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
> +	(echo "Failure to generate vmlinux.h needed for the recommended BPF skeleton support." && \
> +	echo "To disable this use the build option NO_BPF_SKEL=1." && \
> +	echo "Alternatively point at a pre-generated vmlinux.h with VMLINUX_H=<path>." && \
> +	false)
>  else
>  	$(Q)cp "$(VMLINUX_H)" $@
>  endif
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
