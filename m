Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7265B4FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjABQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjABQUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:20:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C5B1CC;
        Mon,  2 Jan 2023 08:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4D461031;
        Mon,  2 Jan 2023 16:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958DBC433EF;
        Mon,  2 Jan 2023 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672676443;
        bh=GnrVQfrJDeWockBVbBbLNMa+OfUeF0RdqTCu6xxj7GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KV8VR+taOC4oI4/UAyrOlyMMek6wLGvohpiGejzIEfcjLHBJeMe917X2TAsLRlX+7
         JTnNX3CYeCLkxWLepZVKGlwSMpZEig1ZMGBmO9EplsdUpUT+rXvE8Q7lquyBMWx3xX
         cCiXPJNPYOt3xlm4B0/zz/WLTKaB/Hh+Z4CCWHKHBB2DxxvZtdbFR61/7UxEn4VsS6
         +YSVxjI4M/Tn1S2JonHfZY9f6XPdN0FTkliSS3Ef5yz62mlZO21CzjNg6WDvwaLiiC
         NfYNDlg/jRHnHmxa5Qv8z/Mu1IjMyeWwY2tv87geFkKTqRBKlqKfzRsGnJfBq00eD2
         I2CXxmfbq7z0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1CF040468; Mon,  2 Jan 2023 13:20:40 -0300 (-03)
Date:   Mon, 2 Jan 2023 13:20:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        jiwei.sun@windriver.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf record: Fix coredump with --overwrite and
 --max-size
Message-ID: <Y7MEWK/z19QCaNoi@kernel.org>
References: <20221229124728.66515-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229124728.66515-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 29, 2022 at 12:47:28PM +0000, Yang Jihong escreveu:
> When --overwrite and --max-size options of perf record are used together,
> a segmentation fault occurs. The following is an example:
> 
>  # perf record -e sched:sched* --overwrite --max-size 1M -a -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   perf: Segmentation fault
>   Obtained 1 stack frames.
>   [0xc4c67f]
>   Segmentation fault (core dumped)
> 
> backtrace of the core file is as follows:
> 
>   #0  0x0000000000417990 in process_locked_synthesized_event (tool=0x0, event=0x15, sample=0x1de0, machine=0xf8) at builtin-record.c:630
>   #1  0x000000000057ee53 in perf_event__synthesize_threads (nr_threads_synthesize=21, mmap_data=<optimized out>, needs_mmap=<optimized out>, machine=0x17ad9b0, process=<optimized out>, tool=0x0) at util/synthetic-events.c:1950
>   #2  __machine__synthesize_threads (nr_threads_synthesize=0, data_mmap=<optimized out>, needs_mmap=<optimized out>, process=<optimized out>, threads=0x8, target=0x8, tool=0x0, machine=0x17ad9b0) at util/synthetic-events.c:1936
>   #3  machine__synthesize_threads (machine=0x17ad9b0, target=0x8, threads=0x8, needs_mmap=<optimized out>, data_mmap=<optimized out>, nr_threads_synthesize=0) at util/synthetic-events.c:1947
>   #4  0x000000000040165d in record__synthesize (tail=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2010
>   #5  0x0000000000403989 in __cmd_record (argc=<optimized out>, argv=<optimized out>, rec=0xbe2520 <record>) at builtin-record.c:2810
>   #6  0x00000000004196ba in record__init_thread_user_masks (rec=0xbe2520 <record>, cpus=0x17a65f0) at builtin-record.c:3837
>   #7  record__init_thread_masks (rec=0xbe2520 <record>) at builtin-record.c:3938
>   #8  cmd_record (argc=1, argv=0x7ffdd692dc60) at builtin-record.c:4241
>   #9  0x00000000004b701d in pager_command_config (var=0x0, value=0x15 <error: Cannot access memory at address 0x15>, data=0x1de0) at perf.c:117
>   #10 0x00000000004b732b in get_leaf_frame_caller_aarch64 (sample=0xfffffffb, thread=0x0, usr_idx=<optimized out>) at util/arm64-frame-pointer-unwind-support.c:56
>   #11 0x0000000000406331 in execv_dashed_external (argv=0x7ffdd692d9e8) at perf.c:410
>   #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:431
>   #13 main (argc=<optimized out>, argv=0x7ffdd692d9e8) at perf.c:562
> 
> The reason is that record__bytes_written accesses the freed memory rec->thread_data,
> The process is as follows:
>   __cmd_record
>     -> record__free_thread_data
>       -> zfree(&rec->thread_data)         // free rec->thread_data
>     -> record__synthesize
>       -> perf_event__synthesize_id_index
>         -> process_synthesized_event
>           -> record__write
>             -> record__bytes_written     // access rec->thread_data
> 
> we only need to check the value of done first.
> Also add variable check in record__bytes_written for code hardening,
> and save bytes_written separately to reduce one calculation.
> 
> Fixes: 6d57581659f7 ("perf record: Add support for limit perf output file size")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Add variable check in record__bytes_written for code hardening.
>  - Save bytes_written separately to reduce one calculation.
>  - Remove rec->opts.tail_synthesize check.

Namhyung, are you ok with this now?

- Arnaldo
 
>  tools/perf/builtin-record.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 29dcd454b8e2..acba9e43e519 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -230,16 +230,29 @@ static u64 record__bytes_written(struct record *rec)
>  	u64 bytes_written = rec->bytes_written;
>  	struct record_thread *thread_data = rec->thread_data;
>  
> +	if (thread_data == NULL)
> +		return bytes_written;
> +
>  	for (t = 0; t < rec->nr_threads; t++)
>  		bytes_written += thread_data[t].bytes_written;
>  
>  	return bytes_written;
>  }
>  
> -static bool record__output_max_size_exceeded(struct record *rec)
> +static void record__check_output_max_size_exceeded(struct record *rec)
>  {
> -	return rec->output_max_size &&
> -	       (record__bytes_written(rec) >= rec->output_max_size);
> +	u64 bytes_written;
> +
> +	if (rec->output_max_size == 0 || done)
> +		return;
> +
> +	bytes_written = record__bytes_written(rec);
> +	if (bytes_written >= rec->output_max_size) {
> +		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> +			" stopping session ]\n", bytes_written >> 10);
> +
> +		done = 1;
> +	}
>  }
>  
>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> @@ -260,12 +273,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  	else
>  		rec->bytes_written += size;
>  
> -	if (record__output_max_size_exceeded(rec) && !done) {
> -		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
> -				" stopping session ]\n",
> -				record__bytes_written(rec) >> 10);
> -		done = 1;
> -	}
> +	record__check_output_max_size_exceeded(rec);
>  
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
> -- 
> 2.30.GIT

-- 

- Arnaldo
