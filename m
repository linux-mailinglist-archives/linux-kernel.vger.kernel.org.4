Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7CF68805A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBBOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:47:38 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BA8626E;
        Thu,  2 Feb 2023 06:47:36 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id eq11so2232273edb.6;
        Thu, 02 Feb 2023 06:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=601oxxxBeinhNLRTJ3S2FQaYaH++QEK37cxFtsi0SZA=;
        b=JxD2th0z+MoI356p/PtyNwiuLfI0GR2A25TnowogIHFuNQkT4H9v9vOfNqHtm01V6D
         e4X4xN03nxjQsm9s2OfWYhqi3PsY5ipAy9ZPaDe6NMuOLlOypE/MY1BvwMzz7X8D//OJ
         RpAe7ZQZR45XZV9nj37u74NKmOBmLtXM/0OvFbF/XkcY1m/l28JBGowuhyZKt6/SDknb
         qtuyyD6v17vOGrtD4MS53qFz5PeiSpNj7f0dtrKpDsP4S+u9EatN7jvXvCBvPoRGt8ft
         7RpKwrKqWEa7atpmvFZ/yUxPiunGi7mEEqBQhqaeMN1Dj0siCtoCwxNNhSqG5bpWkvSb
         5yHw==
X-Gm-Message-State: AO0yUKUR3x8u5HL12gwgYfYWtK8Ouh1FKQ3Y7UqwBxNlstm5gDqI/QSG
        7rHpVLRDWQoOSu854cZ6yyEfRMQEl7vJwF7qUms=
X-Google-Smtp-Source: AK7set9Pc6LVlQ7F/NOwSTllNQZ5pB5l5V9fD4TTaCIKXoclszx/n4UqOo0OnRsUmMad8+YhQV9BsKaJeUcEmO9FVH0=
X-Received: by 2002:a50:cd8e:0:b0:4a2:480b:e164 with SMTP id
 p14-20020a50cd8e000000b004a2480be164mr1923360edi.50.1675349255307; Thu, 02
 Feb 2023 06:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20230130181915.1113313-1-zwisler@google.com> <20230130181915.1113313-6-zwisler@google.com>
In-Reply-To: <20230130181915.1113313-6-zwisler@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Feb 2023 15:47:24 +0100
Message-ID: <CAJZ5v0hSJGb59rYRN=uJq2-39Rz5pk2yV7jufrWgWMPO397hZw@mail.gmail.com>
Subject: Re: [PATCH 5/9] tools/power: use canonical ftrace path
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 7:20 PM Ross Zwisler <zwisler@chromium.org> wrote:
>
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
>
> But, from Documentation/trace/ftrace.rst:
>
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
>
>   /sys/kernel/debug/tracing
>
> A few scripts in tools/power still refer to this older debugfs path, so
> let's update them to avoid confusion.
>
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  tools/power/pm-graph/sleepgraph.py                     |  4 ++--
>  tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py  |  4 ++--
>  .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
> index cfe343306e08..eddf8101ddf6 100755
> --- a/tools/power/pm-graph/sleepgraph.py
> +++ b/tools/power/pm-graph/sleepgraph.py
> @@ -120,9 +120,9 @@ class SystemValues:
>         cgexp = False
>         testdir = ''
>         outdir = ''
> -       tpath = '/sys/kernel/debug/tracing/'
> +       tpath = '/sys/kernel/tracing/'
>         fpdtpath = '/sys/firmware/acpi/tables/FPDT'
> -       epath = '/sys/kernel/debug/tracing/events/power/'
> +       epath = '/sys/kernel/tracing/events/power/'
>         pmdpath = '/sys/power/pm_debug_messages'
>         s0ixpath = '/sys/module/intel_pmc_core/parameters/warn_on_s0ix_failures'
>         s0ixres = '/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us'
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index 2dea4032ac56..904df0ea0a1e 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -248,7 +248,7 @@ def signal_handler(signal, frame):
>          ipt.free_trace_buffer()
>          sys.exit(0)
>
> -trace_file = "/sys/kernel/debug/tracing/events/amd_cpu/enable"
> +trace_file = "/sys/kernel/tracing/events/amd_cpu/enable"
>  signal.signal(signal.SIGINT, signal_handler)
>
>  interval = ""
> @@ -319,7 +319,7 @@ print(cur_version)
>  cleanup_data_files()
>
>  if interval:
> -    file_name = "/sys/kernel/debug/tracing/trace"
> +    file_name = "/sys/kernel/tracing/trace"
>      ipt.clear_trace_file()
>      ipt.set_trace_buffer_size(memory)
>      ipt.enable_trace(trace_file)
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index b46e9eb8f5aa..ec3323100e1a 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -373,7 +373,7 @@ def clear_trace_file():
>      """ Clear trace file """
>
>      try:
> -        f_handle = open('/sys/kernel/debug/tracing/trace', 'w')
> +        f_handle = open('/sys/kernel/tracing/trace', 'w')
>          f_handle.close()
>      except:
>          print('IO error clearing trace file ')
> @@ -401,7 +401,7 @@ def set_trace_buffer_size(memory):
>      """ Set trace buffer size """
>
>      try:
> -       with open('/sys/kernel/debug/tracing/buffer_size_kb', 'w') as fp:
> +       with open('/sys/kernel/tracing/buffer_size_kb', 'w') as fp:
>            fp.write(memory)
>      except:
>         print('IO error setting trace buffer size ')
> @@ -411,7 +411,7 @@ def free_trace_buffer():
>      """ Free the trace buffer memory """
>
>      try:
> -       open('/sys/kernel/debug/tracing/buffer_size_kb'
> +       open('/sys/kernel/tracing/buffer_size_kb'
>                   , 'w').write("1")
>      except:
>          print('IO error freeing trace buffer ')
> @@ -495,7 +495,7 @@ def signal_handler(signal, frame):
>          sys.exit(0)
>
>  if __name__ == "__main__":
> -    trace_file = "/sys/kernel/debug/tracing/events/power/pstate_sample/enable"
> +    trace_file = "/sys/kernel/tracing/events/power/pstate_sample/enable"
>      signal.signal(signal.SIGINT, signal_handler)
>
>      interval = ""
> @@ -569,7 +569,7 @@ if __name__ == "__main__":
>      cleanup_data_files()
>
>      if interval:
> -        filename = "/sys/kernel/debug/tracing/trace"
> +        filename = "/sys/kernel/tracing/trace"
>          clear_trace_file()
>          set_trace_buffer_size(memory)
>          enable_trace(trace_file)
> --

Applied as 6.3 material, thanks!
