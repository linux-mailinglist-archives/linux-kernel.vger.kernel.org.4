Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9674741196
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjF1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjF1Mo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5630F3;
        Wed, 28 Jun 2023 05:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF6661320;
        Wed, 28 Jun 2023 12:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D13C433C0;
        Wed, 28 Jun 2023 12:44:34 +0000 (UTC)
Date:   Wed, 28 Jun 2023 08:44:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     mhiramat@kernel.org, dan.carpenter@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Message-ID: <20230628084428.7bb32d65@rorschach.local.home>
In-Reply-To: <20230628121811.338655-1-tz.stoyanov@gmail.com>
References: <20230628121811.338655-1-tz.stoyanov@gmail.com>
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

On Wed, 28 Jun 2023 15:18:11 +0300
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> The enable_trace_eprobe() function enables all event probes, attached
> to given trace probe. If an error occurs in enabling one of the event
> probes, all others should be roll backed. There is a bug in that roll
> back logic - instead of all event probes, only the failed one is
> disabled.
> 
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

If one was enabled and the second one failed, that should only happen
if there's a bug in the kernel (unless the failure was due to a memory
problem).

I wonder if we should add:

			int cnt = 0;

> +			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {

				/*
				 * It's a bug if one failed for something other than memory
				 * not being available but another eprobe succeeded.
				 */
				WARN_ON_ONCE(cnt++ && ret != -ENOMEM);

-- Steve


> +				ep = container_of(pos, struct trace_eprobe, tp);
> +				disable_eprobe(ep, file->tr);
> +			}
> +		}
>  		if (file)
>  			trace_probe_remove_file(tp, file);
>  		else

