Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75866292F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjAIO7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjAIO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:59:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88AA17068;
        Mon,  9 Jan 2023 06:59:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70E3161165;
        Mon,  9 Jan 2023 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3939C433D2;
        Mon,  9 Jan 2023 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673276356;
        bh=WSuuqqqC0VC3G+Vlaj/ghfDY3b0eTRSPadxQXC50zlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I1b2s5nMSnLEEL88uWjemd2TSZy/f9oNaEt8W2BhUyDbWJuNm2iRcJYpcyPbS8TUo
         BY7tqUzCcfCp/AsAbhkA37dxGq4hZtjES27t07dqyu/mcqidkOLKpZqlD30JjDYGYk
         +PcObFtb2K1+3j9ZDhUuo6WLB+egCARAcliFrvsEyVk3q6R31A8P/lRbJaDujaHyqx
         QsdkI5LcLzdog3NNSdywtbKuFPnDym+M0UvGWoHFMyLVprvHESrnuzeMhwUHYXeQZl
         0CUq/uG5EEwAGSWPeoIGjEHcZIlPINDJ5/79tHPeUhLdQtNdUiIMAEwDGOD+Eo2FBF
         Bh6Luq/ZPfhOg==
Date:   Mon, 9 Jan 2023 23:59:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Quanfa Fu <quanfafu@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/eprobe: no need to check for negative ret
 value for snprintf
Message-Id: <20230109235913.8ac99d54cff8b7c3fc5dcfa4@kernel.org>
In-Reply-To: <20230109040625.3259642-1-quanfafu@gmail.com>
References: <20230109040625.3259642-1-quanfafu@gmail.com>
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

On Mon,  9 Jan 2023 12:06:25 +0800
Quanfa Fu <quanfafu@gmail.com> wrote:

> No need to check for negative return value from snprintf() as the
> code does not return negative values.
> 

Thanks for simplifying, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> 
> -----
> V2 -> V3: continue to use snprintf
> V1 -> V2: memory allc uses kzalloc and replace snprintf with memcpy
> ---
>  kernel/trace/trace_eprobe.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 352b65e2b910..594ac1d086aa 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -923,17 +923,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
>  
>  	p = ep->filter_str;
>  	for (i = 0; i < argc; i++) {
> -		ret = snprintf(p, len, "%s ", argv[i]);
> -		if (ret < 0)
> -			goto error;
> -		if (ret > len) {
> -			ret = -E2BIG;
> -			goto error;
> -		}
> +		if (i)
> +			ret = snprintf(p, len, " %s", argv[i]);
> +		else
> +			ret = snprintf(p, len, "%s", argv[i]);
>  		p += ret;
>  		len -= ret;
>  	}
> -	p[-1] = '\0';
>  
>  	/*
>  	 * Ensure the filter string can be parsed correctly. Note, this
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
