Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005B63FC26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLAXkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLAXkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:40:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73010BA60C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:40:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so3124844plc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAv77N6M1ad575eATsaipJQHekJzZgvIAL6CCfja80Y=;
        b=XAJgagpn8Mo2qr0iSaJyOYBHUJ5c3EZ6SbOiDxcJCJjs/sspz1uEugU1nu++AwclgH
         bkHKguWddR16rAljbUZoVMNJHa2JMRPf2jjRo8shtSWIKnTujldpei3RstDzPqjnnmwX
         XHhyuo2t8ApxkDYeBaqmgiWx7ibq+G0rVchfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAv77N6M1ad575eATsaipJQHekJzZgvIAL6CCfja80Y=;
        b=QwlUloxn1ZboRzfOj3wxTfwmZulSWy9/Aoe+h+t8VgmWtf5LwtH+lkjAZdkAC7l2ul
         E0pQ82QCSRPAMXafYwX0Ca3edTyApTJ1YAjQU3T6ONF6mdWO4K7tfCcSCdd9ICTkMH1C
         HXwuLCbCDBdCAQ0yB4fU+85pXIPpCj/PhHj5XbiSuAQIEOl6KyGWIDXflnfEt8NhAEYU
         JnbsOaLjg1szWV7FkwlvJ7WQUR+Qn8yIODpq8w8mGzM6r4ZrK9LRUVZZCGG85JISYUru
         ORCLPAZjsurGDeGflq83OrSi8kOE0xEvxCKTWP8+3UIsZmmGBHBzlYdB9SJgVvgz37Xi
         ngVw==
X-Gm-Message-State: ANoB5pl/zD9Tok8WudZGPH8QENzJAXWTOi8Rt4cjvNIheg1s7LvGxNJw
        +15XNE+MnJUpAsxDxRAxUas90A==
X-Google-Smtp-Source: AA0mqf7H8u6SqmQzqaKRyvvexzZWM71JK7q5856jplWnSJkCQTbv8tN8YPIHSM5neZ77dX2y8mLtXA==
X-Received: by 2002:a17:90a:aa12:b0:219:5a10:30b9 with SMTP id k18-20020a17090aaa1200b002195a1030b9mr14049526pjq.73.1669938016956;
        Thu, 01 Dec 2022 15:40:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a674100b002191a64b5d5sm5392788pjm.18.2022.12.01.15.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:40:16 -0800 (PST)
Date:   Thu, 1 Dec 2022 15:40:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     brauner@kernel.org, ebiederm@xmission.com, oleg@redhat.com,
        tglx@linutronix.de, peterz@infradead.org, elver@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Initialize the info in ksignal
Message-ID: <202212011537.371DD6639@keescook>
References: <20221128065606.19570-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128065606.19570-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 06:56:06AM +0000, haifeng.xu wrote:
> When handing the SIGNAL_GROUP_EXIT flag, the info in ksignal isn't cleared.
> However, the info acquired by dequeue_synchronous_signal/dequeue_signal is
> initialized and can be safely used. Fortunately, the fatal signal process
> just uses the si_signo and doesn't use any other member. Even so, the
> initialization before use is more safer.

Yeah, this patch seems correct -- get_signal() is usually called with
an uninitialized stack variable, and normally goes through dequeue_*
helpers which do a copy. The fatal path doesn't.

-Kees

> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> ---
>  kernel/signal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d140672185a4..b9b0c8c620e7 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2693,6 +2693,7 @@ bool get_signal(struct ksignal *ksig)
>  		/* Has this task already been marked for death? */
>  		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
>  		     signal->group_exec_task) {
> +			clear_siginfo(&ksig->info);
>  			ksig->info.si_signo = signr = SIGKILL;
>  			sigdelset(&current->pending.signal, SIGKILL);
>  			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> -- 
> 2.25.1
> 

-- 
Kees Cook
