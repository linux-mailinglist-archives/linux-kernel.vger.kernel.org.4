Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177C966102A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 17:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjAGQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 11:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjAGQBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 11:01:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551F4FCC1;
        Sat,  7 Jan 2023 08:01:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87107B80951;
        Sat,  7 Jan 2023 16:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56549C433D2;
        Sat,  7 Jan 2023 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673107287;
        bh=QUKH+nV5nAM3iDCayBAyCxMO7h1lYJlWIjFspuYJpUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAyJeXWzaLvdJOHtdfLorpHZj8CCjtm/i+sWNtvPHKiCNQRahEj0cBPeLSi2UetKV
         InQvd+jra/TGcuKZ8iGMdI/cqO4/2EF8ja7FOPkJZy5XPPX/n1pvpK+/WcV0nZ/B7C
         La5D8CpvS0Jzd3DZHy9gxVX++CJJoU6jt9c1itx70uz6MG9fl2yWdMTAmfLLhoHLpe
         84d5Mh4RDrkmoI4NQysZSTAEMhZFwgz5BZcxLkrbi1hgx1CVdP8zt06Zq/mDUWWtgI
         LIu0+XFnJUsf/enixCl/Ud0vXAIxPE190NUy/UyMF4ZIblTWadMw+3DZIsxyxBhvSb
         qatJ80Cre6QJg==
Date:   Sun, 8 Jan 2023 01:01:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
Message-Id: <20230108010124.96e4ceb68b8dfb8e291f501d@kernel.org>
In-Reply-To: <20230107034557.1156022-1-quanfafu@gmail.com>
References: <20230107034557.1156022-1-quanfafu@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Jan 2023 11:45:57 +0800
Quanfa Fu <quanfafu@gmail.com> wrote:

> Since this memory will be filled soon below, I feel that there is
> no need for a memory of all zeros here. 'snprintf' does not return
> negative num according to ISO C99, so I feel that no judgment is
> needed here.
> 
> No functional change intended.
> 

Ah, good catch. I didn't notice that snprintf() doesn't return
error code. (I confirmed that the linux internal snprintf() also
doesn't return the error code)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> ---
>  kernel/trace/trace_eprobe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 352b65e2b910..cd1d271a74e7 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>  	for (i = 0; i < argc; i++)
>  		len += strlen(argv[i]) + 1;
>  
> -	ep->filter_str = kzalloc(len, GFP_KERNEL);
> +	ep->filter_str = kmalloc(len, GFP_KERNEL);
>  	if (!ep->filter_str)
>  		return -ENOMEM;
>  
>  	p = ep->filter_str;
>  	for (i = 0; i < argc; i++) {
>  		ret = snprintf(p, len, "%s ", argv[i]);
> -		if (ret < 0)
> -			goto error;
>  		if (ret > len) {
>  			ret = -E2BIG;
>  			goto error;
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
