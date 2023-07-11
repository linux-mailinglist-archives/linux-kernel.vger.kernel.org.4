Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098474F304
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjGKPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGKPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:08:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14957A0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:08:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66872d4a141so3918729b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689088106; x=1691680106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3prod4c9QA2/0vQNLICwadpog/5ZuAP2FNyp7zUh9c=;
        b=B9Pr4E1CcW13FrdsOADwCuQQuj83U1Saxiu8zS72C34ueY3G+zuqMVVtG7Gp69QyuK
         baMuWov+4CpHjXGYpl/V4C/xMW/MhwyJNvmkH5fkbXtWO7RlVG1yX7D3kLnsis1Z8zTr
         ZvtpuhVmxRtn2aO1VtzHZ3qZJoEgQvy5W7oow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689088106; x=1691680106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3prod4c9QA2/0vQNLICwadpog/5ZuAP2FNyp7zUh9c=;
        b=bEkzeOOxAGYbnKz5jgbKxe7mcghe+INKd7f62jw4KV5BEW+Nk6P4F5LIa9rB+pSy84
         tscHvpQap0Md8GcZLsfmu4td19QxF8cVkQt8+S1x7MjLoWR6v0kRl1kwdns+cNbbmE+O
         FzvAOPbp8nal2tw/LqolruV29O8AnjO/c839Kowr9m9Q2K1oMmblxQPeT/O4UMXT753m
         e9KP98jVBVuEuzFUTK+bovn1EfVgCgIjEGuV46g113GErmtWTmCzP8zEhL/T5xnFHtoO
         x7n4rFbThMSk1SBS58Tqfr9f+c2EsBFE8OZNULHf5NcKnQ3RpnfXNycsrBSP+Ytu92E4
         flIA==
X-Gm-Message-State: ABy/qLZkj+tj/bzIEoWJtrBqpUBS/IQl2j9PikVOgdqELMnumuQEykBP
        fLMAb1GrV9esOH7Q7FakvHMIZA==
X-Google-Smtp-Source: APBJJlHbUcCal0Hox5mVjm5n43BWnI1zGEtARwVGsmV9FPqxrmgWC1nbDMn9oX5aIQts/M1CzrVZcg==
X-Received: by 2002:a05:6a20:387:b0:12d:3d9e:2934 with SMTP id 7-20020a056a20038700b0012d3d9e2934mr11073563pzt.44.1689088106492;
        Tue, 11 Jul 2023 08:08:26 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id g12-20020a63ad0c000000b00553d42a7cb5sm1700436pgf.68.2023.07.11.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:08:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 00:08:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/5] printk: Add per-console suspended state
Message-ID: <20230711150819.GC12154@google.com>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/10 15:51), John Ogness wrote:
[..]
> @@ -2623,8 +2647,6 @@ void console_lock(void)
>  		msleep(1000);
>  
>  	down_console_sem();
> -	if (console_suspended)
> -		return;
>  	console_locked = 1;
>  	console_may_schedule = 1;
>  }
> @@ -2645,10 +2667,6 @@ int console_trylock(void)
>  		return 0;
>  	if (down_trylock_console_sem())
>  		return 0;
> -	if (console_suspended) {
> -		up_console_sem();
> -		return 0;
> -	}
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	return 1;

Interesting. console_locked previously would not be set if
console is suspended, but now it's always set, which in theory
changes the way WARN_CONSOLE_UNLOCKED() macro works in some
cases?
