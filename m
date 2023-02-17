Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8469A367
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBQBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:30:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908192DE51;
        Thu, 16 Feb 2023 17:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33C90B8285C;
        Fri, 17 Feb 2023 01:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04815C433EF;
        Fri, 17 Feb 2023 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676597423;
        bh=mjauMyOdatAJHhqWE568zlBnBZ7b0HvIVlGXrGxfNWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kqJSULRaZNwPOTQUlCWiFi2yZo/AXgD4eJpz9LQCKO54jnPRZzRiMskV/QoeFmowM
         96jvll5p+6rKif6wRtlmY87Hsc397qQFL8jvfHz9z3pQ7d0eh8nHA0sdXEFSIOhXzr
         18+gRYvcrD2N3TGO4OKn660w/YlBwdmado12sy3I7Xma5qiilTRBSf8PJLm7+UOZxa
         L9I5CLXCsFdlWA6qfNKfbPybS3djxLdy8DJv/ddPUx3NP0PDmgcd/7UOjKYoFWOYTt
         imRcawAJLAEYpGwF1B8xaWDY6Ihgrw0zhhTqAl7W4yWpXiQKCyIdYUO+kjnThotLaX
         YCenB7y7QUPxA==
Date:   Fri, 17 Feb 2023 10:30:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probe: trace_probe_primary_from_call(): checked
 list_first_entry
Message-Id: <20230217103019.c182a1f6aa0f55f6a8ab5896@kernel.org>
In-Reply-To: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
References: <20230128-list-entry-null-check-v1-1-8bde6a3da2ef@diag.uniroma1.it>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2023 16:23:41 +0000
Pietro Borrello <borrello@diag.uniroma1.it> wrote:

> All callers of trace_probe_primary_from_call() check the return
> value to be non NULL. However, the function returns
> list_first_entry(&tpe->probes, ...) which can never be NULL.
> Additionally, it does not check for the list being possibly empty,
> possibly causing a type confusion on empty lists.
> Use list_first_entry_or_null() which solves both problems.
> 
> Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And

Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
Cc: stable@vger.kernel.org

Thank you!

> ---
>  kernel/trace/trace_probe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 23acfd1c3812..f6b565dced56 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -307,7 +307,7 @@ trace_probe_primary_from_call(struct trace_event_call *call)
>  {
>  	struct trace_probe_event *tpe = trace_probe_event_from_call(call);
>  
> -	return list_first_entry(&tpe->probes, struct trace_probe, list);
> +	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
>  }
>  
>  static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
> 
> ---
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> change-id: 20230128-list-entry-null-check-37778efda18c
> 
> Best regards,
> -- 
> Pietro Borrello <borrello@diag.uniroma1.it>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
