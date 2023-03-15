Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B916BB4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjCONbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjCONbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F7974BF;
        Wed, 15 Mar 2023 06:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B596661D97;
        Wed, 15 Mar 2023 13:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D0C433EF;
        Wed, 15 Mar 2023 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678887053;
        bh=++bKB4oS9vZ1gn+XGEOhRptCdRrXqRvQkYHWuuXpgjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlrSML9XqaN+5WDrn+B0QRgEEGtAML66JWraXTuS9cy2pgzhjqw5VaYfeE7w/phI+
         pBGK0NpRlAZWSBEhoNVJRMZyg5ypmpDWGMgY4cFM8NnkjE1N/JDLD5NbX6f/22GCrt
         LOWSGXycbGnXl1JJiCJhkkmPY6Fts4khvI3sCrCrJcutxDIrkMob67k5e+ObpbW99J
         BBcmnv3JLAMqfNgpEsfToL8q32Fje8YF/zDCvVQA6pism14zDtY5qVwEJXieq2Hm8Z
         vwwyatdfC0BpX0ZRoa2/p3E66HY2UZ8RsFmFCcpGSsHvlCdlnpEv22f639xlBrFAJS
         5d8nrbqeGby9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF12D4049F; Wed, 15 Mar 2023 10:30:49 -0300 (-03)
Date:   Wed, 15 Mar 2023 10:30:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "liuwenyu (D)" <liuwenyu7@huawei.com>
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, brauner@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        "hewenliang (C)" <hewenliang4@huawei.com>, yeyunfeng@huawei.com
Subject: Re: [PATCH v2 RESEND] perf top: Fix rare segfault in
 thread__comm_len()
Message-ID: <ZBHIifoDwAMwz/Qv@kernel.org>
References: <322bfb49-840b-f3b6-9ef1-f9ec3435b07e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322bfb49-840b-f3b6-9ef1-f9ec3435b07e@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 15, 2023 at 02:42:17PM +0800, liuwenyu (D) escreveu:
> In thread__comm_len(),strlen() is called outside of the
> thread->comm_lock critical section,which may cause a UAF
> problems if comm__free() is called by the process_thread
> concurrently.

Applied, next time you resend a patch just to fix formatting, without
changing what the patch does, please collect tags provided for the
previous version, like the one from Namhyung:

Acked-by: Namhyung Kim <namhyung@kernel.org>

I did it because I saw it for v1, so added now.

Thanks,

- Arnaldo
 
> backtrace of the core file is as follows:
> 
>     (gdb) bt
>     #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
>     #1  0x000055ad15d31de5 in thread__comm_len (thread=0x7f627d20e300) at util/thread.c:320
>     #2  0x000055ad15d4fade in hists__calc_col_len (h=0x7f627d295940, hists=0x55ad1772bfe0)
>         at util/hist.c:103
>     #3  hists__calc_col_len (hists=0x55ad1772bfe0, h=0x7f627d295940) at util/hist.c:79
>     #4  0x000055ad15d52c8c in output_resort (hists=hists@entry=0x55ad1772bfe0, prog=0x0,
>         use_callchain=false, cb=cb@entry=0x0, cb_arg=0x0) at util/hist.c:1926
>     #5  0x000055ad15d530a4 in evsel__output_resort_cb (evsel=evsel@entry=0x55ad1772bde0,
>         prog=prog@entry=0x0, cb=cb@entry=0x0, cb_arg=cb_arg@entry=0x0) at util/hist.c:1945
>     #6  0x000055ad15d53110 in evsel__output_resort (evsel=evsel@entry=0x55ad1772bde0,
>         prog=prog@entry=0x0) at util/hist.c:1950
>     #7  0x000055ad15c6ae9a in perf_top__resort_hists (t=t@entry=0x7ffcd9cbf4f0) at builtin-top.c:311
>     #8  0x000055ad15c6cc6d in perf_top__print_sym_table (top=0x7ffcd9cbf4f0) at builtin-top.c:346
>     #9  display_thread (arg=0x7ffcd9cbf4f0) at builtin-top.c:700
>     #10 0x00007f6282fab4fa in start_thread (arg=<optimized out>) at pthread_create.c:443
>     #11 0x00007f628302e200 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> The reason is that strlen() get a pointer to a memory that has been freed.
> 
> The string pointer is stored in the structure comm_str, which corresponds
> to a rb_tree node,when the node is erased, the memory of the string is also freed.
> 
> In thread__comm_len(),it gets the pointer within the thread->comm_lock critical section,
> but passed to strlen() outside of the thread->comm_lock critical section, and the perf
> process_thread may called comm__free() concurrently, cause this segfault problem.
> 
> The process is as follows:
> 
> display_thread                                  process_thread
> --------------                                  --------------
> 
> thread__comm_len
>   -> thread__comm_str
>        # held the comm read lock
>     -> __thread__comm_str(thread)
>        # release the comm read lock
>                                                 thread__delete
>                                                      # held the comm write lock
>                                                   -> comm__free
>                                                     -> comm_str__put(comm->comm_str)
>                                                       -> zfree(&cs->str)
>                                                      # release the comm write lock
>       # The memory of the string pointed
>         to by comm has been free.
>     -> thread->comm_len = strlen(comm);
> 
> This patch expand the critical section range of thread->comm_lock in thread__comm_len(),
> to make strlen() called safe.
> 
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
> ---
> v1 -> v2
>  - format the patch to be applied
> 
>  tools/perf/util/thread.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index e3e5427e1c3c..a2490a20eb56 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -311,17 +311,30 @@ const char *thread__comm_str(struct thread *thread)
>  	return str;
>  }
>  
> +static int __thread__comm_len(struct thread *thread, const char *comm)
> +{
> +	if (!comm)
> +		return 0;
> +	thread->comm_len = strlen(comm);
> +
> +	return thread->comm_len;
> +}
> +
>  /* CHECKME: it should probably better return the max comm len from its comm list */
>  int thread__comm_len(struct thread *thread)
>  {
> -	if (!thread->comm_len) {
> -		const char *comm = thread__comm_str(thread);
> -		if (!comm)
> -			return 0;
> -		thread->comm_len = strlen(comm);
> +	int comm_len = thread->comm_len;
> +
> +	if (!comm_len) {
> +		const char *comm;
> +
> +		down_read(&thread->comm_lock);
> +		comm = __thread__comm_str(thread);
> +		comm_len = __thread__comm_len(thread, comm);
> +		up_read(&thread->comm_lock);
>  	}
>  
> -	return thread->comm_len;
> +	return comm_len;
>  }
>  
>  size_t thread__fprintf(struct thread *thread, FILE *fp)
> -- 
> 2.36.1

-- 

- Arnaldo
