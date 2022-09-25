Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702C5E908D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiIYAoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 20:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIYAn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 20:43:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8054660F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 17:43:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3619425pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 17:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DppxKsLVh6ZmQmzczDJR/PGILiF3xOVpf3GavpeSXaA=;
        b=PTFJq7iMk3rsXWUCAWedsEyvuAXeHIOF8teXd+MnIZnk3qgxrvlvm2me4WDgNSZUfl
         eGR9e4eFxMgHfT9ZmIi/2JZsGHSKvYvrxJIDfUwHUcixdPaLO/SJSH3o4BX+IapDDcPC
         qL1mZQNBznXZkr/wiN/so0gi6hVxMKNlxGmmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DppxKsLVh6ZmQmzczDJR/PGILiF3xOVpf3GavpeSXaA=;
        b=lvZ9E5/fBNZN98ToQ9V0PqjJVCwL42pY4dd5xsDRLyO7uDgi+m4DFCL+pvIJGida47
         f/vMot5wyaGsbfAt61eSgr8q5h8dUn7t4wu5jf5Ou0CxBxvYTkx+q6o4a2YK1y3h05Hh
         dqurZC5C6Ee3/9RdIiBi1jKpH8FbtcgGds+VjK2CL6pRppqZ9eteKgguRCum5ESoAr4o
         D3xr+J/8bNx48kK2a6bICrAQ+cV3Q3/55B+XSyz0xcun2giPduDoUzTht/Y4CcxhhVI4
         RsNDXetlgGM4HeS4vP/1uaCr1/QvZOwUZtiXKrpewMRk6/qihlEW7FdNniBt2CR209b3
         uonA==
X-Gm-Message-State: ACrzQf0uVDhSLem9/SlRu/j5lViMVKyJXi6Um0BTGWe52tyieiGB5Oo7
        P9dgc4NTLZwJssYCoVI6FXJLfA==
X-Google-Smtp-Source: AMsMyM4NUDNkq7A9diS6bPTvQqeHy0cuaRfHyEiOkh3ifh7MMCqujGgF4GGVp/Yop81CdGxrou4pWA==
X-Received: by 2002:a17:902:b68f:b0:178:627d:b38d with SMTP id c15-20020a170902b68f00b00178627db38dmr15532832pls.87.1664066631991;
        Sat, 24 Sep 2022 17:43:51 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:cfca:1243:a69b:bb70])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001743ba85d39sm8549293plh.110.2022.09.24.17.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 17:43:50 -0700 (PDT)
Date:   Sun, 25 Sep 2022 09:43:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Helge Deller <deller@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Message-ID: <Yy+kQf0yQcth4kyT@google.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
 <Yy88ZIIzEXtfb+m6@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy88ZIIzEXtfb+m6@p100>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/24 19:20), Helge Deller wrote:
> diff --git a/arch/parisc/kernel/pdc_cons.c b/arch/parisc/kernel/pdc_cons.c
> index 3f9abf0263ee..f15998aa47a8 100644
> --- a/arch/parisc/kernel/pdc_cons.c
> +++ b/arch/parisc/kernel/pdc_cons.c
> @@ -262,8 +262,6 @@ void __init pdc_console_init(void)
>   */
>  void pdc_console_restart(bool hpmc)
>  {
> -	struct console *console;
> -
>  	if (pdc_console_initialized)
>  		return;
> 
> @@ -275,8 +273,8 @@ void pdc_console_restart(bool hpmc)
>  		pdc_cons.flags &= ~CON_PRINTBUFFER;
> 
>  	while (!hlist_empty(&console_list)) {
> -		unregister_console(READ_ONCE(hlist_entry(console_list.first,
> -							 struct console, node)));
> +		unregister_console(hlist_entry(console_list.first,
> +						 struct console, node));

In this case we maybe can use cons_first() macro here (perhaps
give it a little more clear name (first_console()?) and move to
printk.h) and also do READ_ONCE there
