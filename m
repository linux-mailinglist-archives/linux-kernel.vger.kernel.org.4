Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E9609ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJXHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJXHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:01:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FF84B986;
        Mon, 24 Oct 2022 00:01:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l14so7461674wrw.2;
        Mon, 24 Oct 2022 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf30fYZResxam67c9aMaLSjwho0a6HRO04f+jUNDyZ8=;
        b=iptHmJ3rI6G3ek/d9anqxtRcDGzTB9pEPgdn3tMNrY5Wywyham1lx2RcAEDdjzg0Y1
         SWwuPwa8G8CAf/DwS0GGUF1N40r24Z9yvWTMnUGYdBKJSE3pujwVCp9Mj416DY0Lbo0h
         fgXxxir+JHdff5nwNVl5BR7/q1GQ8pBJW+RJxKZJZLJ0F4KcvkeCEv/XAWriXAfzfcAq
         fV0+nxtwTrC6GcUj2ADU0PIp+7htiMfB2ab7xjsZZtTGAoPLMA9UVU82uvTQdmdWCtQ8
         R3bEUem3VZbTMJojnYyl/HoM3KZcPxijpTU4TDqsSYLjyQ01rVAJvb3eJ++LW7uAyMDJ
         8jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf30fYZResxam67c9aMaLSjwho0a6HRO04f+jUNDyZ8=;
        b=ChWKYZyZBckBMv2FMNo4gWC8xhGZdE1tx/PTHvN4WDnNdIZkyygv4RlNO2oWE6+rdE
         cYVNjKq7C/OlVtRjJtmBgKXzzjvrNRLClF22Ue7HUkd6vcLBeGHLwKnqpzjS6jIoRIbl
         zqyWqEyIDTa0MQa5g2wIpKtgoJ1GwDByBWyU8hFV0CTb/ra0mtV9RM7cWgk/m/3dXTW6
         iThGIRwlwSQ3XHSqF/6VlbqtN7Uxzse9UcGrnLAObN0Rijk5xxeUEqQC/MvUXQ25K+bD
         TAPPJh/JOUoTNIegO/q+KK1ADXpU64Vb8UbkUwvt6exbDXY/hIJ8hM05wyiBZ7L431dS
         uJ+g==
X-Gm-Message-State: ACrzQf3XcsvfNg8VR6AiQpzkO1QTKzBw7iWKYUkPzEYOXI4G1njdljWp
        a/d5eIIpcBl99Dk8ZKyDiIVPnCaNdRo=
X-Google-Smtp-Source: AMsMyM6uWrGzh1aJJti931dbc+eHQI+dWaI7zmjrEQl++CpXAvXRkCdbG4rXL/N1m9AP+jQe3OPOmA==
X-Received: by 2002:a05:6000:1143:b0:236:5ede:cdad with SMTP id d3-20020a056000114300b002365edecdadmr6892673wrx.410.1666594876145;
        Mon, 24 Oct 2022 00:01:16 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b0022da3977ec5sm4157129wrs.113.2022.10.24.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 00:01:15 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 24 Oct 2022 09:01:13 +0200
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing/fprobe: Fix to check whether fprobe is
 registered correctly
Message-ID: <Y1Y4OYrPl8E3rN8J@krava>
References: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166653477373.988423.13256491425983587550.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 11:19:33PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since commit ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag
> for fprobe") introduced fprobe_kprobe_handler() for fprobe::f_op::func,
> unregister_fprobe() fails to unregister the registered if user specifies
> FPROBE_FL_KPROBE_SHARED flag.
> To check it correctly, it should confirm the fprobe::f_op::func is either
> fprobe_handler() or fprobe_kprobe_handler().
> 
> Fixes: ab51e15d535e ("fprobe: Introduce FPROBE_FL_KPROBE_SHARED flag for fprobe")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/fprobe.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index aac63ca9c3d1..9000d8ea6274 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -301,7 +301,8 @@ int unregister_fprobe(struct fprobe *fp)
>  {
>  	int ret;
>  
> -	if (!fp || fp->ops.func != fprobe_handler)
> +	if (!fp || (fp->ops.func != fprobe_handler &&
> +		    fp->ops.func != fprobe_kprobe_handler))
>  		return -EINVAL;
>  
>  	/*
> 
