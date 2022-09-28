Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027995EDEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiI1OS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbiI1OS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BCA7218;
        Wed, 28 Sep 2022 07:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F045061ECA;
        Wed, 28 Sep 2022 14:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6ACC433D6;
        Wed, 28 Sep 2022 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664374706;
        bh=TP3Ua0r0FLuzah2dlr3q3fJFeiDzMpJFw5XL4LjfhIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bY/bgfIqNNhYNjqb82a2sJ3MDNu3RB1RJIV9b2VcCyLs26aFvsNBr0x1Z7R59SkGA
         FZ3R7tvFOqMRqsKkGYli1prGTj+dRcFlahK+M0LdlEq3757qDQZ2MnkkORiH+crtl1
         wfhrD1pLv8xmZHadQxjRb8niL9LraE/ZXHGC92Bf2rdMcrJEZ6JyF2fNPmyqOMzCIU
         f0ImGF1nS3qj5Hgd5qzjTUGJ+48EOxgXgz5Mqk08wb2gpecuwhfAJLkxpvkuGFqNkK
         VoNZG8X3VG81agjEhovtT0wt9kDWhwUS6U39b3FFIG6gpL4oejPmLA0CjPlFRILL1m
         W32G5HN9SlQCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 977E5405F0; Wed, 28 Sep 2022 11:18:23 -0300 (-03)
Date:   Wed, 28 Sep 2022 11:18:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] perf lock contention: Fix a build error on 32-bit
Message-ID: <YzRXrzrta0BrcDQ6@kernel.org>
References: <20220926215638.3931222-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926215638.3931222-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 26, 2022 at 02:56:38PM -0700, Namhyung Kim escreveu:
> It was reported that it failed to build the BPF lock contention skeleton
> on 32 bit arch due to the size of long.  The lost count is used only for
> reporting errors due to lack of stackmap space through bad_hist which type
> is 'int'.  Let's use int type then.

Thanks, applied.

- Arnaldo

 
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  tools/perf/util/lock-contention.h              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index e107d71f0f1a..1bb8628e7c9f 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -75,7 +75,7 @@ int has_task;
>  int stack_skip;
>  
>  /* error stat */
> -unsigned long lost;
> +int lost;
>  
>  static inline int can_record(void)
>  {
> diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> index 67db311fc9df..b8cb8830b7bc 100644
> --- a/tools/perf/util/lock-contention.h
> +++ b/tools/perf/util/lock-contention.h
> @@ -114,7 +114,7 @@ struct lock_contention {
>  	struct machine *machine;
>  	struct hlist_head *result;
>  	unsigned long map_nr_entries;
> -	unsigned long lost;
> +	int lost;
>  	int max_stack;
>  	int stack_skip;
>  };
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
