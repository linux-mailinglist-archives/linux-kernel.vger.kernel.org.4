Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB36DC223
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 02:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDJALv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 20:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJALt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 20:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4330F9;
        Sun,  9 Apr 2023 17:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C4760C20;
        Mon, 10 Apr 2023 00:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB400C433EF;
        Mon, 10 Apr 2023 00:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681085507;
        bh=m4KESy/j+9ECvkRJ45ajjuLcL693X/JZZ7O1WAEA4+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IW528YQD/oab1TY1HyME74zZO/3jJVUogJAeB5DaKSGTuaMpdf2evdOBzCvgqgaYA
         zwVYO+HNNGD74ZKgNLJoXhP5G7daxYoZwAvwDijNjf/8AshCEWbVugWpB9fb6Igm2Y
         95ecYAyQSQidoEMGhnjKKl5NHcSlRyoq0x1LDMfiQKnq5V5W62RTTSNbAnxo731HZ2
         OKTMS/B2rsvoszCENotnQq2zuJgZUkcm0RZWnTUgd2yCwPg6oXSAjc0feTWItVIsBP
         0XifjLtK4BU6en/wU0/KET0kutuK/xK8MacIItnZpVMrEfFmcBtwccYKJ+5A1yqcL1
         OPubq2V/Vd6Xg==
Date:   Mon, 10 Apr 2023 09:11:43 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 2/3] tracing/probes: Add fprobe events for tracing
 function entry and exit.
Message-Id: <20230410091143.2a0f581740a4c6fe26647bc3@kernel.org>
In-Reply-To: <168035965700.397811.1413689791818663330.stgit@mhiramat.roam.corp.google.com>
References: <168035963900.397811.6647648816464443553.stgit@mhiramat.roam.corp.google.com>
        <168035965700.397811.1413689791818663330.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Apr 2023 23:34:17 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> index 000000000000..e9e071af243d
> --- /dev/null
> +++ b/kernel/trace/trace_fprobe.c
> @@ -0,0 +1,1073 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fprobe-based tracing events
> + * Copyright (C) 2022 Google LLC.
> + */
> +#define pr_fmt(fmt)	"trace_fprobe: " fmt
> +
> +#include <linux/security.h>
> +#include <linux/fprobe.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/rculist.h>
> +
> +#include "trace_dynevent.h"
> +#include "trace_probe.h"
> +#include "trace_probe_kernel.h"
> +#include "trace_probe_tmpl.h"
> +
> +#define FPROBE_EVENT_SYSTEM "fprobes"
> +#define RETHOOK_MAXACTIVE_MAX 4096
> +
> +static int trace_fprobe_create(const char *raw_command);
> +static int trace_fprobe_show(struct seq_file *m, struct dyn_event *ev);
> +static int trace_fprobe_release(struct dyn_event *ev);
> +static bool trace_fprobe_is_busy(struct dyn_event *ev);
> +static bool trace_fprobe_match(const char *system, const char *event,
> +			int argc, const char **argv, struct dyn_event *ev);
> +
> +static struct dyn_event_operations trace_fprobe_ops = {
> +	.create = trace_fprobe_create,
> +	.show = trace_fprobe_show,
> +	.is_busy = trace_fprobe_is_busy,
> +	.free = trace_fprobe_release,
> +	.match = trace_fprobe_match,
> +};
> +
> +/*
> + * Kprobe event core functions

Oops, I forgot to update this comment. Let me update it.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
