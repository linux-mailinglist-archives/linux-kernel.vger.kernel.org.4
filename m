Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8A72EBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjFMT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjFMT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:27:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C91BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:27:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-665a18f5643so1614039b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686684477; x=1689276477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyTIwvqamgOUde9UASV31tFM32VvFNi5Vj8Se3aE7pw=;
        b=LJP9glI2LVFyXXSnI2dgCVvzfMDNTIFr2+lqfMhD0h5ARIxqsmhuZYy2XnmbQBssLd
         k58qG914eVhBDqJANJGKw1L6iR/OGTqZUv+4sJAJ1gC+R0b0hZLuk61YR9Ij6mSvO4O6
         kDXdB6w7v2yApLPDsUuktquQfCkuJmfzQNbG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684477; x=1689276477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyTIwvqamgOUde9UASV31tFM32VvFNi5Vj8Se3aE7pw=;
        b=U6DdgFls+a3BdLU/WRPDVnA0UIENUpkQfOuTw7DdKYII/HlIpSGyR0bCdfgn00LPNb
         rnQdRGGK5TfAB6a84T4NijToca2wTgIP92n7eRvKeS4ZA3LCUoazvrjWtQuWvYTIHKmx
         UlhfrspdoaYBE9rxzOofBCjVBtZ3mg5z2yx6wpDiD6bz/7ANhkSUpiOXOvyass+kRfw+
         ImrNhj65dJmj9qbYBo/JIP7DL9aLkO21wzFV/FO+hNmBLIFYY22iVM2cu/XdCUftevzX
         QnsKmgqiZYY+8AztZhY3pUod7W81bdm4+Xcm6OFU48sBoNr5yCnXaUHO9tQCN2jFnzWG
         xlEA==
X-Gm-Message-State: AC+VfDy7YDIPmE8K0DgoHPT07QgA7d7ObsGBdqMeqgCdLpjt5kziFsfU
        OcWnyuSRaZ/mzjqCp8OePfJu7A==
X-Google-Smtp-Source: ACHHUZ4k3OouNy0Xd2fC1UPpDyXvsDNUWB07HJRJtqIZbd18fV+fG6UFpBL0p8BBn0gzAachax+GYw==
X-Received: by 2002:a05:6a20:258a:b0:117:3c00:77ea with SMTP id k10-20020a056a20258a00b001173c0077eamr15666596pzd.0.1686684477151;
        Tue, 13 Jun 2023 12:27:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7904f000000b0063d29df1589sm3845453pfo.136.2023.06.13.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:27:56 -0700 (PDT)
Date:   Tue, 13 Jun 2023 12:27:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/boot: Replace strlcpy with strscpy
Message-ID: <202306131227.26F90584F7@keescook>
References: <20230613004125.3539934-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613004125.3539934-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:41:25AM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -E2BIG
> is used to check for truncation instead of sizeof(dest).

This looks technically correct, but I wonder if "< 0" is a better test?

> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Either way

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/trace/trace_boot.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index 778200dd8ede..5fe525f1b8cc 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
>  
>  	/* Common ftrace options */
>  	xbc_node_for_each_array_value(node, "options", anode, p) {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
>  	const char *p;
>  
>  	xbc_node_for_each_array_value(node, "events", anode, p) {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
>  			pr_err("String is too long: %s\n", p);
>  			continue;
>  		}
> @@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	p = xbc_node_find_value(enode, "filter", NULL);
>  	if (p && *p != '\0') {
> -		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> +		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
>  			pr_err("filter string is too long: %s\n", p);
>  		else if (apply_event_filter(file, buf) < 0)
>  			pr_err("Failed to apply filter: %s\n", buf);
> @@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
>  
>  	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
>  		xbc_node_for_each_array_value(enode, "actions", anode, p) {
> -			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
> +			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
>  				pr_err("action string is too long: %s\n", p);
>  			else if (trigger_process_regex(file, buf) < 0)
>  				pr_err("Failed to apply an action: %s\n", p);
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
> 

-- 
Kees Cook
