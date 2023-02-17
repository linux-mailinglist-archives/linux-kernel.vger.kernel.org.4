Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8469AF9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBQPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:34:56 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1126F3CE;
        Fri, 17 Feb 2023 07:34:54 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HEGqjK031700;
        Fri, 17 Feb 2023 15:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3/nvZvlPBSvFuarRwkZcp3qDM6TpMDgFiQlHedMBWP4=;
 b=HFUMr5+9KmJ8NBzQo5eLKJLIqifSiPX/01D3EwZNhyhyaC3/5/9ea7X9Qfr8WnqAkxEN
 QFALNgX7HhZ3S6Iai9yhWODkiEpuwRuiqB0yrXIu8sS5ur9daY2+9OZV1WK2FSuixiJg
 DizBEDU8FMOqcPmey7XLku57/haoLy7AeRCsM369nl/59MSdUepY02R1QOT+yATf27RO
 72tEeYYRHaFPmmEO6slYShUVOkTLlE7OQaVUuosBnKO4v3pdNlMPVYTJhFJevAFWEoJ8
 mlMcnbPfed48mr5/WecksawWD60qXqEwhBQCsRbt6EIKPWQ5d/6doHVKLi+jHCBsuvoa EA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nswjpj5nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:34:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HFYljA029244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 15:34:47 GMT
Received: from [10.216.18.25] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 07:34:44 -0800
Message-ID: <2af9e9b3-8c36-a0ca-8328-76e2be937bd5@quicinc.com>
Date:   Fri, 17 Feb 2023 21:04:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/6] tracing: always use canonical ftrace path
Content-Language: en-US
To:     Ross Zwisler <zwisler@chromium.org>, <linux-kernel@vger.kernel.org>
CC:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-2-zwisler@google.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230215223350.2658616-2-zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGWFguVymceQGrCObLBIO1i-TmTQQmS6
X-Proofpoint-ORIG-GUID: YGWFguVymceQGrCObLBIO1i-TmTQQmS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_10,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170140
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 4:03 AM, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>    Before 4.1, all ftrace tracing control files were within the debugfs
>    file system, which is typically located at /sys/kernel/debug/tracing.
>    For backward compatibility, when mounting the debugfs file system,
>    the tracefs file system will be automatically mounted at:
> 
>    /sys/kernel/debug/tracing
> 
> Many comments and Kconfig help messages in the tracing code still refer
> to this older debugfs path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>   include/linux/kernel.h                    |  2 +-
>   include/linux/tracepoint.h                |  4 ++--
>   kernel/trace/Kconfig                      | 20 ++++++++++----------
>   kernel/trace/kprobe_event_gen_test.c      |  2 +-
>   kernel/trace/ring_buffer.c                |  2 +-
>   kernel/trace/synth_event_gen_test.c       |  2 +-
>   kernel/trace/trace.c                      |  2 +-
>   samples/user_events/example.c             |  4 ++--
>   scripts/tracing/draw_functrace.py         |  6 +++---
>   tools/lib/api/fs/tracing_path.c           |  4 ++--
>   tools/tracing/latency/latency-collector.c |  2 +-
>   11 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index fe6efb24d151..40bce7495af8 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -297,7 +297,7 @@ bool mac_pton(const char *s, u8 *mac);
>    *
>    * Use tracing_on/tracing_off when you want to quickly turn on or off
>    * tracing. It simply enables or disables the recording of the trace events.
> - * This also corresponds to the user space /sys/kernel/debug/tracing/tracing_on
> + * This also corresponds to the user space /sys/kernel/tracing/tracing_on
>    * file, which gives a means for the kernel and userspace to interact.
>    * Place a tracing_off() in the kernel where you want tracing to end.
>    * From user space, examine the trace, and then echo 1 > tracing_on
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 4b33b95eb8be..fa1004fcf810 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -471,7 +471,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>    *	* This is how the trace record is structured and will
>    *	* be saved into the ring buffer. These are the fields
>    *	* that will be exposed to user-space in
> - *	* /sys/kernel/debug/tracing/events/<*>/format.
> + *	* /sys/kernel/tracing/events/<*>/format.
>    *	*
>    *	* The declared 'local variable' is called '__entry'
>    *	*
> @@ -531,7 +531,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>    * tracepoint callback (this is used by programmatic plugins and
>    * can also by used by generic instrumentation like SystemTap), and
>    * it is also used to expose a structured trace record in
> - * /sys/kernel/debug/tracing/events/.
> + * /sys/kernel/tracing/events/.
>    *
>    * A set of (un)registration functions can be passed to the variant
>    * TRACE_EVENT_FN to perform any (un)registration work.
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d7043043f59c..5f5e64f9e715 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -239,7 +239,7 @@ config DYNAMIC_FTRACE
>   	  enabled, and the functions not enabled will not affect
>   	  performance of the system.
>   
> -	  See the files in /sys/kernel/debug/tracing:
> +	  See the files in /sys/kernel/tracing:
>   	    available_filter_functions
>   	    set_ftrace_filter
>   	    set_ftrace_notrace
> @@ -299,7 +299,7 @@ config STACK_TRACER
>   	select KALLSYMS
>   	help
>   	  This special tracer records the maximum stack footprint of the
> -	  kernel and displays it in /sys/kernel/debug/tracing/stack_trace.
> +	  kernel and displays it in /sys/kernel/tracing/stack_trace.
>   
>   	  This tracer works by hooking into every function call that the
>   	  kernel executes, and keeping a maximum stack depth value and
> @@ -339,7 +339,7 @@ config IRQSOFF_TRACER
>   	  disabled by default and can be runtime (re-)started
>   	  via:
>   
> -	      echo 0 > /sys/kernel/debug/tracing/tracing_max_latency
> +	      echo 0 > /sys/kernel/tracing/tracing_max_latency
>   
>   	  (Note that kernel size and overhead increase with this option
>   	  enabled. This option and the preempt-off timing option can be
> @@ -363,7 +363,7 @@ config PREEMPT_TRACER
>   	  disabled by default and can be runtime (re-)started
>   	  via:
>   
> -	      echo 0 > /sys/kernel/debug/tracing/tracing_max_latency
> +	      echo 0 > /sys/kernel/tracing/tracing_max_latency
>   
>   	  (Note that kernel size and overhead increase with this option
>   	  enabled. This option and the irqs-off timing option can be
> @@ -515,7 +515,7 @@ config TRACER_SNAPSHOT
>   	  Allow tracing users to take snapshot of the current buffer using the
>   	  ftrace interface, e.g.:
>   
> -	      echo 1 > /sys/kernel/debug/tracing/snapshot
> +	      echo 1 > /sys/kernel/tracing/snapshot
>   	      cat snapshot
>   
>   config TRACER_SNAPSHOT_PER_CPU_SWAP
> @@ -527,7 +527,7 @@ config TRACER_SNAPSHOT_PER_CPU_SWAP
>   	  full swap (all buffers). If this is set, then the following is
>   	  allowed:
>   
> -	      echo 1 > /sys/kernel/debug/tracing/per_cpu/cpu2/snapshot
> +	      echo 1 > /sys/kernel/tracing/per_cpu/cpu2/snapshot
>   
>   	  After which, only the tracing buffer for CPU 2 was swapped with
>   	  the main tracing buffer, and the other CPU buffers remain the same.
> @@ -574,7 +574,7 @@ config PROFILE_ANNOTATED_BRANCHES
>   	  This tracer profiles all likely and unlikely macros
>   	  in the kernel. It will display the results in:
>   
> -	  /sys/kernel/debug/tracing/trace_stat/branch_annotated
> +	  /sys/kernel/tracing/trace_stat/branch_annotated
>   
>   	  Note: this will add a significant overhead; only turn this
>   	  on if you need to profile the system's use of these macros.
> @@ -587,7 +587,7 @@ config PROFILE_ALL_BRANCHES
>   	  taken in the kernel is recorded whether it hit or miss.
>   	  The results will be displayed in:
>   
> -	  /sys/kernel/debug/tracing/trace_stat/branch_all
> +	  /sys/kernel/tracing/trace_stat/branch_all
>   
>   	  This option also enables the likely/unlikely profiler.
>   
> @@ -638,8 +638,8 @@ config BLK_DEV_IO_TRACE
>   	  Tracing also is possible using the ftrace interface, e.g.:
>   
>   	    echo 1 > /sys/block/sda/sda1/trace/enable
> -	    echo blk > /sys/kernel/debug/tracing/current_tracer
> -	    cat /sys/kernel/debug/tracing/trace_pipe
> +	    echo blk > /sys/kernel/tracing/current_tracer
> +	    cat /sys/kernel/tracing/trace_pipe
>   
>   	  If unsure, say N.
>   
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index c736487fc0e4..4850fdfe27f1 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -21,7 +21,7 @@
>    * Then:
>    *
>    * # insmod kernel/trace/kprobe_event_gen_test.ko
> - * # cat /sys/kernel/debug/tracing/trace
> + * # cat /sys/kernel/tracing/trace
>    *
>    * You should see many instances of the "gen_kprobe_test" and
>    * "gen_kretprobe_test" events in the trace buffer.
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c366a0a9ddba..4cdb2feccff3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2886,7 +2886,7 @@ rb_check_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
>   		  sched_clock_stable() ? "" :
>   		  "If you just came from a suspend/resume,\n"
>   		  "please switch to the trace global clock:\n"
> -		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
> +		  "  echo global > /sys/kernel/tracing/trace_clock\n"
>   		  "or add trace_clock=global to the kernel command line\n");
>   }
>   
> diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
> index 8d77526892f4..8dfe85499d4a 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -22,7 +22,7 @@
>    * Then:
>    *
>    * # insmod kernel/trace/synth_event_gen_test.ko
> - * # cat /sys/kernel/debug/tracing/trace
> + * # cat /sys/kernel/tracing/trace
>    *
>    * You should see several events in the trace buffer -
>    * "create_synth_test", "empty_synth_test", and several instances of
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c9e40f692650..1101220052b3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1142,7 +1142,7 @@ void tracing_snapshot_instance(struct trace_array *tr)
>    *
>    * Note, make sure to allocate the snapshot with either
>    * a tracing_snapshot_alloc(), or by doing it manually
> - * with: echo 1 > /sys/kernel/debug/tracing/snapshot
> + * with: echo 1 > /sys/kernel/tracing/snapshot
>    *
>    * If the snapshot buffer is not allocated, it will stop tracing.
>    * Basically making a permanent snapshot.
> diff --git a/samples/user_events/example.c b/samples/user_events/example.c
> index d06dc24156ec..18e34c9d708e 100644
> --- a/samples/user_events/example.c
> +++ b/samples/user_events/example.c
> @@ -23,8 +23,8 @@
>   #endif
>   
>   /* Assumes debugfs is mounted */
> -const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
> -const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
> +const char *data_file = "/sys/kernel/tracing/user_events_data";
> +const char *status_file = "/sys/kernel/tracing/user_events_status";
>   
>   static int event_status(long **status)
>   {
> diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
> index 438516bdfb3c..42fa87300941 100755
> --- a/scripts/tracing/draw_functrace.py
> +++ b/scripts/tracing/draw_functrace.py
> @@ -12,9 +12,9 @@ calls. Only the functions's names and the call time are provided.
>   
>   Usage:
>   	Be sure that you have CONFIG_FUNCTION_TRACER
> -	# mount -t debugfs nodev /sys/kernel/debug
> -	# echo function > /sys/kernel/debug/tracing/current_tracer
> -	$ cat /sys/kernel/debug/tracing/trace_pipe > ~/raw_trace_func
> +	# mount -t tracefs nodev /sys/kernel/tracing
> +	# echo function > /sys/kernel/tracing/current_tracer
> +	$ cat /sys/kernel/tracing/trace_pipe > ~/raw_trace_func
>   	Wait some times but not too much, the script is a bit slow.
>   	Break the pipe (Ctrl + Z)
>   	$ scripts/tracing/draw_functrace.py < ~/raw_trace_func > draw_functrace
> diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
> index b8e457c841ab..7ba3e81274e8 100644
> --- a/tools/lib/api/fs/tracing_path.c
> +++ b/tools/lib/api/fs/tracing_path.c
> @@ -14,8 +14,8 @@
>   #include "tracing_path.h"
>   
>   static char tracing_mnt[PATH_MAX]  = "/sys/kernel/debug";
> -static char tracing_path[PATH_MAX]        = "/sys/kernel/debug/tracing";
> -static char tracing_events_path[PATH_MAX] = "/sys/kernel/debug/tracing/events";
> +static char tracing_path[PATH_MAX]        = "/sys/kernel/tracing";
> +static char tracing_events_path[PATH_MAX] = "/sys/kernel/tracing/events";
>   
>   static void __tracing_path_set(const char *tracing, const char *mountpoint)
>   {
> diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
> index 59a7f2346eab..0fd9c747d396 100644
> --- a/tools/tracing/latency/latency-collector.c
> +++ b/tools/tracing/latency/latency-collector.c
> @@ -1584,7 +1584,7 @@ static void *do_printloop(void *arg)
>   		/*
>   		 * Toss a coin to decide if we want to sleep before printing
>   		 * out the backtrace. The reason for this is that opening
> -		 * /sys/kernel/debug/tracing/trace will cause a blackout of
> +		 * /sys/kernel/tracing/trace will cause a blackout of
>   		 * hundreds of ms, where no latencies will be noted by the
>   		 * latency tracer. Thus by randomly sleeping we try to avoid
>   		 * missing traces systematically due to this. With this option


LGTM.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
