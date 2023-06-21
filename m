Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE745738B81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFUQhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 12:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjFUQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176CE69
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFE0615CB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF61C433C8;
        Wed, 21 Jun 2023 16:36:29 +0000 (UTC)
Date:   Wed, 21 Jun 2023 12:36:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 01/13] fgraph: Add declaration of "struct
 fgraph_ret_regs"
Message-ID: <20230621123628.2f9d438f@gandalf.local.home>
In-Reply-To: <20230621162944.507694485@goodmis.org>
References: <20230621162923.953123395@goodmis.org>
        <20230621162944.507694485@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sending manually, as quilt mail didn't acknowledge some character in this
email, and it was rejected by lkml as wrong mime type.

-- Steve

On Wed, 21 Jun 2023 12:29:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In final testing of:
> 
>   https://patchwork.kernel.org/project/linux-trace-kernel/patch/1fc502712c981e0e6742185ba242992170ac9da8.1680954589.git.pengdonglin@sangfor.com.cn/
>   "function_graph: Support recording and printing the return value of function"
> 
> The test failed due to a new warning found in the build:
> 
> kernel/trace/fgraph.c:243:56: warning: ‘struct fgraph_ret_regs’ declared inside parameter list will not be visible outside of this definition or declaration
> 
> Instead of asking to send another patch series, just add it and then apply
> the updates.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 218cd95bf8e4..ea3d7bb235d3 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -236,6 +236,9 @@ static struct notifier_block ftrace_suspend_notifier = {
>  	.notifier_call = ftrace_suspend_notifier_call,
>  };
>  
> +/* fgraph_ret_regs is not defined without CONFIG_FUNCTION_GRAPH_RETVAL */
> +struct fgraph_ret_regs;
> +
>  /*
>   * Send the trace to the ring-buffer.
>   * @return the original return address.

