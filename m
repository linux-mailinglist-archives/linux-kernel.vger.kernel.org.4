Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A26687CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjALXY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjALXYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:24:24 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D76625CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:24:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i1so6631081ilu.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhef6biThhIg08+giamdbkzTkDklC4TxoeMkTSe0/Dc=;
        b=FNb9+ZvbuccPQcYTlohtzkbXWuxCeJdfkyMePlSXRClbTL2OgY6QoL0ZfCAPpqkHg1
         oIlqDB44VEBYv6Elq+YzB9WxJScUPrbjQKYlUSZsKKJWsSelgB3k4r1WJkCc04Pfm0Fc
         5JRWbrdYq31Xu3CAChYwDFXzqfwpKZW6ppAdB6oy1w04G85dAjWyYWHnVgyoijYy7hUD
         ZCyOghwjEDZ7dqjtqko5OE9kJON34FD7OFT1NuyOY3SYLY0aR28zL/b2QHGAjQIyf8LD
         0YZr111FWHGlqckjT2cpeXX+T9nxtI3sK4nDXV2aayyVXlllvPCmFs3H2iAzDYgAF4hb
         2mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhef6biThhIg08+giamdbkzTkDklC4TxoeMkTSe0/Dc=;
        b=AIf51eY86r16ZTc8Tdga6SQC3NaJtRaHTjkJs+72DeKI3P/QbVArcpSO9vnZcDJ4UL
         hofYhSo+HhFtPxfxA//ULFNTq1MN1Aev0xeUe4xyK2xYRIlRbidJG5IZO//FYLznyr2d
         +I91oWQfy8xyws+tVHPv/L49G4E+b4tbFTsiZ4sw45JjlJcCtTd0K1wFw7Lrdq/NFbQ4
         bgRV951sChHLlDYR3vdGZkqf7Ja9lTnXTMDCHP0qRA0Ck9QcT6OT0mZEdMYrSOlmlFOe
         th8qKt90GiYa4FX8hQ+24Kuq8Dfr7dFcz67Hbb1lnGCEiY0Dfqyiu4n4iVSXEWFJLW96
         8e5Q==
X-Gm-Message-State: AFqh2koMq5xyWULmG1jOLbYbw5B0eZLHiWFFEKlbQYvV6aMTxIPFRwKv
        dWKmK6gNfNVJRefo5YNOPfSfrq2g+oWBCRv6
X-Google-Smtp-Source: AMrXdXtFqIENP2E50l44zzwovmHsdpY2JEjWKfHvP4D/tZQ3oLNziEOmke4rXx5m8SDweE1b8sj/lA==
X-Received: by 2002:a92:c10b:0:b0:30d:c792:5c12 with SMTP id p11-20020a92c10b000000b0030dc7925c12mr4644326ile.5.1673565862689;
        Thu, 12 Jan 2023 15:24:22 -0800 (PST)
Received: from google.com ([2620:15c:183:200:4a23:5fbb:9bb3:1279])
        by smtp.gmail.com with ESMTPSA id c2-20020a023f42000000b0039decb5b452sm5692176jaf.65.2023.01.12.15.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:24:22 -0800 (PST)
Date:   Thu, 12 Jan 2023 16:24:17 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] tracing: Add creation of instances at boot command
 line
Message-ID: <Y8CWodcFALp3MEBM@google.com>
References: <20230111145636.450953217@goodmis.org>
 <20230111145842.376427803@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111145842.376427803@goodmis.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:56:37AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add kernel command line to add tracing instances. This only creates
> instances at boot but still does not enable any events to them. Later
> changes will extend this command line to add enabling of events, filters,
> and triggers. As well as possibly redirecting trace_printk()!
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +++
>  kernel/trace/trace.c                          | 51 +++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..cec486217ccc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6272,6 +6272,12 @@
>  			comma-separated list of trace events to enable. See
>  			also Documentation/trace/events.rst
>  
> +	trace_instance=[instance-info]
> +			[FTRACE] Create an ring buffer instance early in boot up.
> +			This will be listed in:
> +
> +				/sys/kernel/tracing/instances

Should this be "/sys/kernel/debug/tracing/instances"?

Ditto for the text for 'ftrace_boot_snapshot':

	ftrace_boot_snapshot
			[FTRACE] On boot up, a snapshot will be taken of the
			ftrace ring buffer that can be read at:
			/sys/kernel/tracing/snapshot.

Everywhere else we use /sys/kernel/debug/tracing, though we do use
/sys/kernel/tracing in Documentation/trace/ftrace.txt ?

I guess either works, but having just 1 or the other will help us not confuse
users.

> +
>  	trace_options=[option-list]
>  			[FTRACE] Enable or disable tracer options at boot.
>  			The option-list is a comma delimited list of options
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a555a861b978..34ed504ffca9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -48,6 +48,9 @@
>  #include <linux/fsnotify.h>
>  #include <linux/irq_work.h>
>  #include <linux/workqueue.h>
> +#include <linux/workqueue.h>

Duplicate include 1 line above.

> +
> +#include <asm/setup.h> /* COMMAND_LINE_SIZE */
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -186,6 +189,9 @@ static char *default_bootup_tracer;
>  static bool allocate_snapshot;
>  static bool snapshot_at_boot;
>  
> +static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
> +static int boot_instance_index;
> +
>  static int __init set_cmdline_ftrace(char *str)
>  {
>  	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
> @@ -239,6 +245,23 @@ static int __init boot_snapshot(char *str)
>  __setup("ftrace_boot_snapshot", boot_snapshot);
>  
>  
> +static int __init boot_instance(char *str)
> +{
> +	char *slot = boot_instance_info + boot_instance_index;
> +	int left = COMMAND_LINE_SIZE - boot_instance_index;

A bit safer to use sizeof(boot_instance_info) instead of COMMAND_LINE_SIZE,
so we can change the allocation size of boot_instance_info without having to
keep them in sync.

These are mostly nits, you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>
