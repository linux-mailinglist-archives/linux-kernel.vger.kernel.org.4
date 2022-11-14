Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1864B6286DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiKNRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238113AbiKNRUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:20:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038821F9D0;
        Mon, 14 Nov 2022 09:20:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 944B661306;
        Mon, 14 Nov 2022 17:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F97C4347C;
        Mon, 14 Nov 2022 17:19:58 +0000 (UTC)
Date:   Mon, 14 Nov 2022 12:20:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
Message-ID: <20221114122040.59ac8265@gandalf.local.home>
In-Reply-To: <20221102160236.11696-1-iecedge@gmail.com>
References: <20221102160236.11696-1-iecedge@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Nov 2022 16:02:36 +0000
Jianlin Lv <iecedge@gmail.com> wrote:

> In the case of keeping the system running, the preferred method for
> tracing the kernel is dynamic tracing (kprobe), but the drawback of
> this method is that events are lost, especially when tracing packages
> in the network stack.
> 
> Livepatching provides a potential solution, which is to reimplement the
> function you want to replace and insert a static tracepoint.
> In such a way, custom stable static tracepoints can be expanded without
> rebooting the system.

Well that's definitely one way to implement dynamic trace events! :-D

-- Steve

> 
> Signed-off-by: Jianlin Lv <iecedge@gmail.com>
> ---
>  kernel/tracepoint.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index f23144af5743..8d1507dd0724 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -571,8 +571,8 @@ static void for_each_tracepoint_range(
>  bool trace_module_has_bad_taint(struct module *mod)
>  {
>  	return mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP) |
> -			       (1 << TAINT_UNSIGNED_MODULE) |
> -			       (1 << TAINT_TEST));
> +				(1 << TAINT_UNSIGNED_MODULE) | (1 << TAINT_TEST) |
> +				(1 << TAINT_LIVEPATCH));
>  }
>  
>  static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);

