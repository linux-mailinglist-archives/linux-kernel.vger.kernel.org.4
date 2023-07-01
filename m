Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14EC744BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGAXCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGAXCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928710E3;
        Sat,  1 Jul 2023 16:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFDF60A27;
        Sat,  1 Jul 2023 23:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902C5C433C8;
        Sat,  1 Jul 2023 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688252562;
        bh=yccHqhjr7BL9VhxQ6G166svesIU9QMlzmZX0aqCUFYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jLvKx7IrBu3AyZC8V428hnMalARD48STUlQXI8L8Oamiz7VIaPxjPkOzgANZDAKWi
         yH79pI0jzGncCE518AgLSYFjipY/EnD55sSq7+3G0gmACPqw2yLOVK+TdKxvjO/WZI
         20UHTClllzoxnO6yrWx8Q2Nc4LjBGKP/cUEK/nlfMT0sbrd2Vt0P+R7l29jP/Y0lzJ
         Ai3tVR7CVmjjZwoc9uz5GYhuH8Ubi5WIG/JkARMWuIP9bbABAhdYNpk2kZmUuGXV/o
         1xEbQIY7BtQl3X6s6GuaPCDy0qsoDDpAtcWKMhDY6CCpAUFYZcC+I6xGxRBXH+p2c0
         DxGXEgopK2ocg==
Date:   Sun, 2 Jul 2023 08:02:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: Delete dead code in
 trace_eprobe_tp_update_arg()
Message-Id: <20230702080238.1379c4fe777bf22e5b146af5@kernel.org>
In-Reply-To: <f657e0c7-46c3-4e8f-a472-35ec98229660@moroto.mountain>
References: <f657e0c7-46c3-4e8f-a472-35ec98229660@moroto.mountain>
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

On Mon, 26 Jun 2023 16:35:06 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This code was recently refactored and now the "ret" variable is always
> zero.  Delete the check for non-zero.
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This code was changed in 1b8b0cd754cd (tracing/probes: Move event
> parameter fetching code to common parser)

OK, this will be picked to the 6.5 fix.

Thank you!

> 
>  kernel/trace/trace_eprobe.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index cb0077ba2b49..b5181d690b4d 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -797,10 +797,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
>  		return ret;
>  
>  	/* Handle symbols "@" */
> -	if (!ret)
> -		ret = traceprobe_update_arg(&ep->tp.args[i]);
> -
> -	return ret;
> +	return traceprobe_update_arg(&ep->tp.args[i]);
>  }
>  
>  static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
