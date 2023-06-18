Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5577734923
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFRWaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFRWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E27C6;
        Sun, 18 Jun 2023 15:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB8060EFB;
        Sun, 18 Jun 2023 22:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C7AC433C0;
        Sun, 18 Jun 2023 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687127405;
        bh=PxFPJAnxN3cKRQK3+ECEA0/TdGuerlBwY5Rs6xYatTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MjECvK9abjZamF93IqUPjCF0eK22V4xOceUE5+Zebeeimia11wV+nKwaS0EqSGFCW
         pQqEa3uJopZxuipc29xPtLuouCPkcw2ki5sBIs0ZLz3rFLiFWKctEguSCfLrqEmgUF
         HAzC7GwcJCJybNY9fd06+3XkhhfkobrLEfXAVYMgq5T1ZpaOOKvddHa8671NmzRcd0
         t+8jLpfIGSS2gw/jORtRq0U5jl+BXYZpt1HOqVyO3jLaM7NmdxQGtN24vgiFe7XILt
         tgetdT1bIZXmuPWQyjrUpoDf9NesJOJRa9Xz3pytTpKsw3XWhZGfd5dq2LTKo4sClT
         fcoI1nqPGHaQA==
Date:   Mon, 19 Jun 2023 07:30:01 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Message-Id: <20230619073001.ed0058623b238bb1f2069c88@kernel.org>
In-Reply-To: <20230615180420.400769-1-azeemshaikh38@gmail.com>
References: <20230615180420.400769-1-azeemshaikh38@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 15 Jun 2023 18:04:20 +0000
Azeem Shaikh <azeemshaikh38@gmail.com> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
> v2:
>  * Use "< 0" instead of -E2BIG.
> 
> v1:
>  * https://lore.kernel.org/all/20230613004125.3539934-1-azeemshaikh38@gmail.com/
> 
>  kernel/trace/trace_boot.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 778200dd8ede..7ccc7a8e155b 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
>  
>  	/* Common ftrace options */
>  	xbc_node_for_each_array_value(node, "options", anode, p) {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
>  	const char *p;
>  
>  	xbc_node_for_each_array_value(node, "events", anode, p) {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	p = xbc_node_find_value(enode, "filter", NULL);
>  	if (p && *p != '\0') {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
>  			pr_err("filter string is too long: %s\n", p);
>  		else if (apply_event_filter(file, buf) < 0)
>  			pr_err("Failed to apply filter: %s\n", buf);
> @@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
>  		xbc_node_for_each_array_value(enode, "actions", anode, p) {
> -			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> +			if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
>  				pr_err("action string is too long: %s\n", p);
>  			else if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply an action: %s\n", p);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
