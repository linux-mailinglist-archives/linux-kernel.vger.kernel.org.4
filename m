Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC26632FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKUWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKUWSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8854B01;
        Mon, 21 Nov 2022 14:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5704FB8169E;
        Mon, 21 Nov 2022 22:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82DBC433D6;
        Mon, 21 Nov 2022 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669069088;
        bh=fnLEGCWU0CZRgBgvaBbuBKGV/UYuFQTTg3KVwwtUnK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jz0lZtAB4JavAh0z4IOW5wDsEgkPlXszZH099BDoMFZaZ3So9nqgYTHo+Wgq4gO7M
         dR+wz34rtB3pWwGaMlT1iS66iV06T9LdU4gyxKyfDHmmHgTPFCmstYGJE/sZHyzRb6
         ITVlYokpK1A2uosAtx6dp87P1Zl670aPD9MhogZ9IT52bwcsa+0pCqH6oHm3xAvukg
         TGxYBwSw8be/Pyf/mlJeVfmDHaxgSNA3CVbXxhRwzOBxuZrWg9y30y9DmmWOVLwNDH
         bzRXJF8oY7vYiFqNdaX9jlbF/L9BAy19YvhdTv6tT/gFSgFl2PKZnpXYf1NOAspfKL
         HcFrIVb/BpU7g==
Date:   Tue, 22 Nov 2022 07:18:05 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing/osnoise: Fix duration type
Message-Id: <20221122071805.49e316a39fb86859b5a3156d@kernel.org>
In-Reply-To: <a93d8a8378c7973e9c609de05826533c9e977939.1668692096.git.bristot@kernel.org>
References: <cover.1668692096.git.bristot@kernel.org>
        <a93d8a8378c7973e9c609de05826533c9e977939.1668692096.git.bristot@kernel.org>
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

On Thu, 17 Nov 2022 14:46:17 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> The duration type is a 64 long value, not an int. This was
> causing some long noise to report wrong values.
> 
> Change the duration to a 64 bits value.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/trace_osnoise.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 78d536d3ff3d..4300c5dc4e5d 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -917,7 +917,7 @@ void osnoise_trace_irq_entry(int id)
>  void osnoise_trace_irq_exit(int id, const char *desc)
>  {
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> -	int duration;
> +	s64 duration;
>  
>  	if (!osn_var->sampling)
>  		return;
> @@ -1048,7 +1048,7 @@ static void trace_softirq_entry_callback(void *data, unsigned int vec_nr)
>  static void trace_softirq_exit_callback(void *data, unsigned int vec_nr)
>  {
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> -	int duration;
> +	s64 duration;
>  
>  	if (!osn_var->sampling)
>  		return;
> @@ -1144,7 +1144,7 @@ thread_entry(struct osnoise_variables *osn_var, struct task_struct *t)
>  static void
>  thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
>  {
> -	int duration;
> +	s64 duration;
>  
>  	if (!osn_var->sampling)
>  		return;
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
