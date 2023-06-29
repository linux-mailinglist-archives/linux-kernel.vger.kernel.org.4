Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A3D741D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF2BEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjF2BEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921602690;
        Wed, 28 Jun 2023 18:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3026E6146E;
        Thu, 29 Jun 2023 01:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE1C433C8;
        Thu, 29 Jun 2023 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688000683;
        bh=OGglsy19OA3jQrxtGR0uERKGoZjdKQBPLNOf+RMSjMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A8IQFl2f/ObKHFVALUcYEMqMdsYk4T9X3pOrwFbC7l3SCeHieSz2XFkXChxB/g/vZ
         fXVfU/jUHZdWhwtBFSr0z9V8QeGXEYImlrWq5h/CLyj1udG2XuJEjyBnSG6v1kCPu2
         XaLEpt+Tmu8qL/3QBi9Dt64g1g5Uix0ZmbLtpZCGO1YFgjrEsC8U2qKnSPr6MJhZ8n
         JF/Ou0bmoxb1JkAXi4W9jb6FAUv0dLc+9bhavybwR3hsqYAymlSBOJhZ3w4lpSDcNU
         lN8zjPqLk6KBZRHGaxTsTwI0Hd2qgcCUMW6xKbWyTZECfIi8zHGdKz7cHHYXVTgial
         PN+EqF4wC/gCQ==
Date:   Thu, 29 Jun 2023 10:04:39 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Message-Id: <20230629100439.ff373368c40b3ad2284ef07f@kernel.org>
In-Reply-To: <20230628121811.338655-1-tz.stoyanov@gmail.com>
References: <20230628121811.338655-1-tz.stoyanov@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 15:18:11 +0300
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> The enable_trace_eprobe() function enables all event probes, attached
> to given trace probe. If an error occurs in enabling one of the event
> probes, all others should be roll backed. There is a bug in that roll
> back logic - instead of all event probes, only the failed one is
> disabled.
> 

Thanks, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---
>  kernel/trace/trace_eprobe.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 67e854979d53..ba9a28bc773f 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -702,8 +702,12 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  
>  	if (ret) {
>  		/* Failed to enable one of them. Roll back all */
> -		if (enabled)
> -			disable_eprobe(ep, file->tr);
> +		if (enabled) {
> +			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +				ep = container_of(pos, struct trace_eprobe, tp);
> +				disable_eprobe(ep, file->tr);
> +			}
> +		}
>  		if (file)
>  			trace_probe_remove_file(tp, file);
>  		else
> -- 
> 2.41.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
