Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5059663600
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjAJAEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjAJAD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:03:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F81095;
        Mon,  9 Jan 2023 16:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EC1DB807E9;
        Tue, 10 Jan 2023 00:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE06C433D2;
        Tue, 10 Jan 2023 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673309035;
        bh=OaLzYnvyIIb5IEz5HQgHMyamldsrvh2YVOvR3GSiTMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=omxAb8kWHSVWvLrdP8zDS3ppGYk/t5v2pIbPHqv2ELf5hrjgTvWjBzCflENYCgbjU
         K99w7QGJ2j+Tc/XwdtSFbqTNA36Bs6MoWCTzmpla3o/c56f+e44Tfgz9wSt1OMlBuO
         3lAREFhf8EcPenIScZbf/c8BRp2HHgEzwNnDlHTwiY/gVyfB/oInDRWSSTfaCUfGoB
         o/cB/vKOJM7HP8D18Xe/+EXJJLtoZ0Pm/t0UONFug1bI/1ZMAkf4f19Y5xajAklPWV
         Ho5mC+Kw0ranX6eEQFkJTFKGgDlzLaHh2mGHu2uUEBG+oMBmrmpoS9Jz3IMM3AXOeF
         QqOn68Yfd8NKw==
Date:   Tue, 10 Jan 2023 09:03:51 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     <yang.yang29@zte.com.cn>
Cc:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>
Subject: Re: [PATCH linux-next] tracing: use strscpy() to instead of
 strncpy()
Message-Id: <20230110090351.e3c80a1f7a36ac897ddc3746@kernel.org>
In-Reply-To: <202301091939219689840@zte.com.cn>
References: <202301091939219689840@zte.com.cn>
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

On Mon, 9 Jan 2023 19:39:21 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  kernel/trace/trace_events_synth.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 67592eed0be8..cd636edd045e 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -195,8 +195,7 @@ static int synth_field_string_size(char *type)
>  	if (len == 0)
>  		return 0; /* variable-length string */
> 
> -	strncpy(buf, start, len);
> -	buf[len] = '\0';
> +	strscpy(buf, start, len + 1);
> 
>  	err = kstrtouint(buf, 0, &size);
>  	if (err)
> -- 
> 2.15.2


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
