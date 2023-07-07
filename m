Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD174B577
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGGQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGGQz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F1EB2;
        Fri,  7 Jul 2023 09:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69974612D3;
        Fri,  7 Jul 2023 16:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E350C433C7;
        Fri,  7 Jul 2023 16:55:57 +0000 (UTC)
Date:   Fri, 7 Jul 2023 12:55:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobes: Add a comment why fprobe_kprobe_handler exits
 if kprobe is running
Message-ID: <20230707125551.641ca475@gandalf.local.home>
In-Reply-To: <168874788299.159442.2485957441413653858.stgit@devnote2>
References: <168874788299.159442.2485957441413653858.stgit@devnote2>
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

On Sat,  8 Jul 2023 01:38:03 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a comment the reason why fprobe_kprobe_handler() exits if any other
> kprobe is running.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Link: https://lore.kernel.org/all/20230706120916.3c6abf15@gandalf.local.home/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/trace/fprobe.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 75517667b54f..133b31f44945 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -100,6 +100,12 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  		return;
>  	}
>  
> +	/*
> +	 * This user handler is shared with other kprobes and is not expected to be
> +	 * called recursively. So if any other kprobe handler is running, this will
> +	 * exit as kprobe does. See the section 'Share the callbacks with kprobes'
> +	 * in Documentation/trace/fprobe.rst for more information.
> +	 */
>  	if (unlikely(kprobe_running())) {
>  		fp->nmissed++;
>  		return;

