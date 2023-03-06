Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4F6ACF24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCFU2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCFU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:28:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891445FE0;
        Mon,  6 Mar 2023 12:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC75F61173;
        Mon,  6 Mar 2023 20:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4D8C433D2;
        Mon,  6 Mar 2023 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678134493;
        bh=8ipyoXT7xu4DS1uRz9vZ7xh7DVUS5MQbWPMAd+tdU6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMh0rq6To5u7U1Z3xWbz2fXmlvmZgU5g3KdOaZWbxrrS2BdUAfqhur6ROMDuabbVW
         5priioDHvNgN4xJnoo2sl0PW86PSVu+ckCAxayE132fkYtp/AxSZa57mDAIF5gHxQ3
         veGCZPHxZOgpe/zz+tutYuPC9JXASsF0sHH7e3u66wqU8Svkny0qFe8W0/RBtt1oco
         kIBk5RTXG/zo2TfntRrvZf/WS+swv6bJbg7DDX2ffbHDkJzgpIO1bq61597NcLyHI6
         zKXCiDREV58V0YBRVV5JVmi78qWN5YNqfiqRUHd1rgNFscjrTZ1tN7GAhz0TSDzHTN
         iYmI0xvk9l47Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A89B84049F; Mon,  6 Mar 2023 17:28:10 -0300 (-03)
Date:   Mon, 6 Mar 2023 17:28:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "liuwenyu (D)" <liuwenyu7@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, brauner@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        "hewenliang (C)" <hewenliang4@huawei.com>, yeyunfeng@huawei.com
Subject: Re: [PATCH] perf top: Fix rare segfault in thread__comm_len()
Message-ID: <ZAZM2smdb04miWqY@kernel.org>
References: <a60e9257-0874-223c-0cd8-7ab284cd0a1f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a60e9257-0874-223c-0cd8-7ab284cd0a1f@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 03, 2023 at 06:02:17PM +0800, liuwenyu (D) escreveu:
> In thread__comm_len(),strlen() is called outside of the
> thread->comm_lock critical section,which may cause a UAF
> problems if comm__free() is called by the process_thread
> concurrently.
> 
> backtrace of the core file is as follows:
> 
>     (gdb) bt
>     #0  __strlen_evex () at ../sysdeps/x86_64/multiarch/strlen-evex.S:77
>     #1  0x000055ad15d31de5 in thread__comm_len (thread=0x7f627d20e300) at
> util/thread.c:320
>     #2  0x000055ad15d4fade in hists__calc_col_len (h=0x7f627d295940,
> hists=0x55ad1772bfe0)
>         at util/hist.c:103
>     #3  hists__calc_col_len (hists=0x55ad1772bfe0, h=0x7f627d295940) at
> util/hist.c:79
>     #4  0x000055ad15d52c8c in output_resort
> (hists=hists@entry=0x55ad1772bfe0, prog=0x0,
>         use_callchain=false, cb=cb@entry=0x0, cb_arg=0x0) at
> util/hist.c:1926
>     #5  0x000055ad15d530a4 in evsel__output_resort_cb
> (evsel=evsel@entry=0x55ad1772bde0,
>         prog=prog@entry=0x0, cb=cb@entry=0x0, cb_arg=cb_arg@entry=0x0) at
> util/hist.c:1945
>     #6  0x000055ad15d53110 in evsel__output_resort
> (evsel=evsel@entry=0x55ad1772bde0,
>         prog=prog@entry=0x0) at util/hist.c:1950
>     #7  0x000055ad15c6ae9a in perf_top__resort_hists
> (t=t@entry=0x7ffcd9cbf4f0) at builtin-top.c:311
>     #8  0x000055ad15c6cc6d in perf_top__print_sym_table (top=0x7ffcd9cbf4f0)
> at builtin-top.c:346
>     #9  display_thread (arg=0x7ffcd9cbf4f0) at builtin-top.c:700
>     #10 0x00007f6282fab4fa in start_thread (arg=<optimized out>) at
> pthread_create.c:443
>     #11 0x00007f628302e200 in clone3 () at
> ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> The reason is that strlen() get a pointer to a memory that has been freed.
> 
> The string pointer is stored in the structure comm_str, which corresponds
> to a rb_tree node,when the node is erased, the memory of the string is also
> freed.
> 
> In thread__comm_len(),it gets the pointer within the thread->comm_lock
> critical section,
> but passed to strlen() outside of the thread->comm_lock critical section,
> and the perf
> process_thread may called comm__free() concurrently, cause this segfault
> problem.
> 
> The process is as follows:
> 
> display_thread                                  process_thread
> --------------                                  --------------
> 
> thread__comm_len
>   -> thread__comm_str
>        # held the comm read lock
>     -> __thread__comm_str(thread)
>        # release the comm read lock
>                                                 thread__delete
>                                                      # held the comm write
> lock
>                                                   -> comm__free
>                                                     ->
> comm_str__put(comm->comm_str)
>                                                       -> zfree(&cs->str)
>                                                      # release the comm
> write lock
>       # The memory of the string pointed
>         to by comm has been free.
>     -> thread->comm_len = strlen(comm);
> 
> This patch expand the critical section range of thread->comm_lock in
> thread__comm_len(),
> to make strlen() called safe.

The patch isn't applying, please check this and resubmit, the first
issue is that it is malformed at that CHECKME comment, that is broken in
two lines, I fixed that and tried again, still doesn't apply:

⬢[acme@toolbox perf-tools]$ patch -p1 < ./20230303_liuwenyu7_perf_top_fix_rare_segfault_in_thread__comm_len.mbx
patching file tools/perf/util/thread.c
Hunk #1 FAILED at 311.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/thread.c.rej
⬢[acme@toolbox perf-tools]$ cat tools/perf/util/thread.c.rej
--- tools/perf/util/thread.c
+++ tools/perf/util/thread.c
@@ -311,17 +311,30 @@ const char *thread__comm_str(struct thread *thread)
      return str;
  }

+static int __thread__comm_len(struct thread *thread, const char *comm)
+{
+    if (!comm)
+        return 0;
+    thread->comm_len = strlen(comm);
+
+    return thread->comm_len;
+}
+
  /* CHECKME: it should probably better return the max comm len from its comm list */
  int thread__comm_len(struct thread *thread)
  {
-    if (!thread->comm_len) {
-        const char *comm = thread__comm_str(thread);
-        if (!comm)
-            return 0;
-        thread->comm_len = strlen(comm);
+    int comm_len = thread->comm_len;
+
+    if (!comm_len) {
+        const char *comm;
+
+        down_read(&thread->comm_lock);
+        comm = __thread__comm_str(thread);
+        comm_len = __thread__comm_len(thread, comm);
+        up_read(&thread->comm_lock);
      }

-    return thread->comm_len;
+    return comm_len;
  }

  size_t thread__fprintf(struct thread *thread, FILE *fp)
⬢[acme@toolbox perf-tools]$


 
> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
> ---
>  tools/perf/util/thread.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index e3e5427e1c3c..a2490a20eb56 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -311,17 +311,30 @@ const char *thread__comm_str(struct thread *thread)
>      return str;
>  }
> 
> +static int __thread__comm_len(struct thread *thread, const char *comm)
> +{
> +    if (!comm)
> +        return 0;
> +    thread->comm_len = strlen(comm);
> +
> +    return thread->comm_len;
> +}
> +
>  /* CHECKME: it should probably better return the max comm len from its comm
> list */
>  int thread__comm_len(struct thread *thread)
>  {
> -    if (!thread->comm_len) {
> -        const char *comm = thread__comm_str(thread);
> -        if (!comm)
> -            return 0;
> -        thread->comm_len = strlen(comm);
> +    int comm_len = thread->comm_len;
> +
> +    if (!comm_len) {
> +        const char *comm;
> +
> +        down_read(&thread->comm_lock);
> +        comm = __thread__comm_str(thread);
> +        comm_len = __thread__comm_len(thread, comm);
> +        up_read(&thread->comm_lock);
>      }
> 
> -    return thread->comm_len;
> +    return comm_len;
>  }
> 
>  size_t thread__fprintf(struct thread *thread, FILE *fp)
> -- 
> 2.36.1
> 

-- 

- Arnaldo
