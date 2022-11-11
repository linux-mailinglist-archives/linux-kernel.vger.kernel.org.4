Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911D625AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiKKMtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKKMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:48:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FCA42F68;
        Fri, 11 Nov 2022 04:48:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBB66B825FE;
        Fri, 11 Nov 2022 12:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC6C433D6;
        Fri, 11 Nov 2022 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668170933;
        bh=mitaukNCb/hYAbTGvUtPs3BXT+tqSAvOYU4AGeN6OCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQPlqYJaTpOFi44ChAALquCTgyBXRwo6csMhPvf78cp7LsuwRqhhQGYJMfa0WDLSO
         1vNcSjSBFeR3q6qfXxrbpkwP6YfRvTAyJji+b2lbwKU5V+qvI14shZql6XDpvgDvWS
         g+a8yajtrFB7iXMRyERYAP3MzuAAd+aMAm2mAR+WcfV0kw0yh5F3YGBblMlnZZXx8+
         oh8GyQlbyxlEZ8g9c6O3w67Y558n4JX0FSyaYDc32NfEG0UK+CM5hr3vB6y7sdiUPC
         6p46hjqM7ouSdjWDY4KJxkI7003iDnOZhh2gS3GJqSDjWLvpXlr/Xuh5VOtAsXjNzo
         tGO/TL+CQTAQg==
Date:   Fri, 11 Nov 2022 21:48:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Aashish Sharma <shraash@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arun Easi <aeasi@marvell.com>, linux-kernel@vger.kernel.org,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Fix warning on variable 'struct trace_array'
Message-Id: <20221111214849.895359f49037ec6cf21292a3@kernel.org>
In-Reply-To: <20221107160556.2139463-1-shraash@google.com>
References: <20221107160556.2139463-1-shraash@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Nov 2022 21:35:56 +0530
Aashish Sharma <shraash@google.com> wrote:

> Move the declaration of 'struct trace_array' out of #ifdef
> CONFIG_TRACING block, to fix the following warning when CONFIG_TRACING
> is not set:
> 
> >> include/linux/trace.h:63:45: warning: 'struct trace_array' declared
> inside parameter list will not be visible outside of this definition or
> declaration
> 

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: 1a77dd1c2bb5 ("scsi: tracing: Fix compile error in trace_array calls when TRACING is disabled")
> Cc: Arun Easi <aeasi@marvell.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
>  include/linux/trace.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index b5e16e438448..80ffda871749 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -26,13 +26,13 @@ struct trace_export {
>  	int flags;
>  };
>  
> +struct trace_array;
> +
>  #ifdef CONFIG_TRACING
>  
>  int register_ftrace_export(struct trace_export *export);
>  int unregister_ftrace_export(struct trace_export *export);
>  
> -struct trace_array;
> -
>  void trace_printk_init_buffers(void);
>  __printf(3, 4)
>  int trace_array_printk(struct trace_array *tr, unsigned long ip,
> -- 
> 2.38.1.431.g37b22c650d-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
