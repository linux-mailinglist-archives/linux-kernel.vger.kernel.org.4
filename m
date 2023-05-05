Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99886F8B94
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjEEVtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjEEVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372D98;
        Fri,  5 May 2023 14:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EEA64113;
        Fri,  5 May 2023 21:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A37C433EF;
        Fri,  5 May 2023 21:48:58 +0000 (UTC)
Date:   Fri, 5 May 2023 17:48:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v9.1 07/11] tracing/probes: Add $$args meta argument for
 all function args
Message-ID: <20230505174856.04ca1e6a@gandalf.local.home>
In-Reply-To: <168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
References: <168299383880.3242086.7182498102007986127.stgit@mhiramat.roam.corp.google.com>
        <168299390127.3242086.2714570777321787734.stgit@mhiramat.roam.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 May 2023 11:18:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the '$$args' meta fetch argument for function-entry probe events. This

Hmm, couldn't we just use $args ? That would be different from $arg1,
$arg2, etc.

The $$ to me would be either the bash pid of current, or perhaps it would
be just to use a dollar sign. I don't see the precedence of $$args being a
"full expand".

-- Steve


> will be expanded to the all arguments of the function and the tracepoint
> using BTF function argument information.
> 
> e.g.
>  #  echo 'p vfs_read $$args' >> dynamic_events
>  #  echo 'f vfs_write $$args' >> dynamic_events
>  #  echo 't sched_overutilized_tp $$args' >> dynamic_events
>  # cat dynamic_events
> p:kprobes/p_vfs_read_0 vfs_read file=file buf=buf count=count pos=pos
> f:fprobes/vfs_write__entry vfs_write file=file buf=buf count=count pos=pos
> t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=rd overutilized=overutilized
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
