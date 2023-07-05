Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7328F748658
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGEO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F80CF;
        Wed,  5 Jul 2023 07:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF4F86159F;
        Wed,  5 Jul 2023 14:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5545C433C8;
        Wed,  5 Jul 2023 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688567318;
        bh=TFMultyCiWda4KqG2aspwa/c8KG/qnRXC4jDSPWHiV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqnYitwY9oor9zy9dQd4mn6pgHajKayzFd8zuSMZxLafAukkvKo5NwCiTT3xKDTbE
         fR3tN7mbvFf4TY3QMc98egFELwbAGD2XuE4QgNE/1/KPNtEEukVHJiI19V5SZCH/MD
         pIYJrBX6iX2vm3qBX7WUKDxuoNGOE4Rj18R+vOq3uNC4jVG7KvtRE8BgsoWDwFS7j9
         Z6kQbceUYsq2q9zQYTg5KgmyFSt7PXBB7l8FbSNESlEpaUx33xEG0QmyQXw17nMdLy
         gPXtrJkkzYJ88u1S4r5cHft37ilKk2Kqahs4EFILIsI8NbBoAlgBe5ocPP8xdX2uPo
         fxhNFvViEUP5w==
Date:   Wed, 5 Jul 2023 23:28:34 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] tracing/boot: Test strscpy() against less than zero for
 error
Message-Id: <20230705232834.f71d8602c3c9d9c56abd0b15@kernel.org>
In-Reply-To: <20230704100807.707d1605@rorschach.local.home>
References: <20230704100807.707d1605@rorschach.local.home>
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

On Tue, 4 Jul 2023 10:08:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of checking for -E2BIG, it is better to just check for less than
> zero of strscpy() for error. Testing for -E2BIG is not very robust, and
> the calling code does not really care about the error code, just that
> there was an error.
> 
> One of the updates to convert strlcpy() to strscpy() had a v2 version
> that changed the test from testing against -E2BIG to less than zero, but I
> took the v1 version that still tested for -E2BIG.

Indeed. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Link: https://lore.kernel.org/linux-trace-kernel/20230615180420.400769-1-azeemshaikh38@gmail.com/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_boot.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 5fe525f1b8cc..7ccc7a8e155b 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
>  
>  	/* Common ftrace options */
>  	xbc_node_for_each_array_value(node, "options", anode, p) {
> -		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
>  	const char *p;
>  
>  	xbc_node_for_each_array_value(node, "events", anode, p) {
> -		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	p = xbc_node_find_value(enode, "filter", NULL);
>  	if (p && *p != '\0') {
> -		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
>  			pr_err("filter string is too long: %s\n", p);
>  		else if (apply_event_filter(file, buf) < 0)
>  			pr_err("Failed to apply filter: %s\n", buf);
> @@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
>  		xbc_node_for_each_array_value(enode, "actions", anode, p) {
> -			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
> +			if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
>  				pr_err("action string is too long: %s\n", p);
>  			else if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply an action: %s\n", p);
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
