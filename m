Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED6636E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKWXjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKWXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:39:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628EDD5382;
        Wed, 23 Nov 2022 15:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BCA61F65;
        Wed, 23 Nov 2022 23:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F7C433D6;
        Wed, 23 Nov 2022 23:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669246759;
        bh=6kodh2P7k6X62fYIdexaP2ea3dCieg1VAyeyZpkPx48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+UH/B0cbCB6vWMWCIvruNoqi02Fz59PKeuoaij/LzxBuyYO3RSZEFXV+hF/M+nxE
         A9M5pXQqn8ceTzotMkcLqxTEkYIRj7mFrOCsB+XfnGb0TEQ83+dgqr5aAKDOcMveMn
         hIyvmxjcGNef6oM0g6nH91g2v2dxE4QflvYsda8/kxfEHnpsyJIr3XgOA1b2E9UeiQ
         9GocH9yY70xwaJ/gpjyAAfzomG1b73pkvNnG9mF78G0fzYoFGH/32bulDcK1DGq7ad
         eYyHh1W/7AwD5JjFzLfMdYl1Q01qkqlw2QFe7vuqFK5JPSZFhxQ+C5Qa7Cvm3R7xPs
         HhgnYywWZpiYA==
Date:   Thu, 24 Nov 2022 08:39:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Fix race where histograms can be called before
 the event
Message-Id: <20221124083916.667a68cfe38f6fadd84000f4@kernel.org>
In-Reply-To: <20221123164323.03450c3a@gandalf.local.home>
References: <20221123164323.03450c3a@gandalf.local.home>
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

On Wed, 23 Nov 2022 16:43:23 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> commit 94eedf3dded5 ("tracing: Fix race where eprobes can be called before
> the event") fixed an issue where if an event is soft disabled, and the
> trigger is being added, there's a small window where the event sees that
> there's a trigger but does not see that it requires reading the event yet,
> and then calls the trigger with the record == NULL.
> 
> This could be solved with adding memory barriers in the hot path, or to
> make sure that all the triggers requiring a record check for NULL. The
> latter was chosen.
> 
> Commit 94eedf3dded5 set the eprobe trigger handle to check for NULL, but
> the same needs to be done with histograms.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20221118211809.701d40c0f8a757b0df3c025a@kernel.org/
> 
> Cc: stable@vger.kernel.org
> Fixes: 7491e2c442781 ("tracing: Add a probe that attaches to trace events")
> Reported-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I confirmed that other trigger callbacks only use the event_trigger_data,
So this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  kernel/trace/trace_events_hist.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 087c19548049..1c82478e8dff 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5143,6 +5143,9 @@ static void event_hist_trigger(struct event_trigger_data *data,
>  	void *key = NULL;
>  	unsigned int i;
>  
> +	if (unlikely(!rbe))
> +		return;
> +
>  	memset(compound_key, 0, hist_data->key_size);
>  
>  	for_each_hist_key_field(i, hist_data) {
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
