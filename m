Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393555B8844
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiINMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:32:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4836DC9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:32:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so14309526pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=axYPoRUhqwCbtWfWpnfaxG81kXlH/8IOYnfhTtp6nB0=;
        b=GCqSc2a+78bcoxCTglw1LN+/1Eb0Mg0EXazjToEt20tKD/cI6/m91jRRkqB76nSiAH
         IZJatkQ10iy1mNogDw6rpYaYrSMDa6gbT09Kc2Up8jt4MwRX8YV5f89/36+q1Pdv12pQ
         UaPDju5etLIl4n/zGL4beKcJS7kBRklxO2Px0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=axYPoRUhqwCbtWfWpnfaxG81kXlH/8IOYnfhTtp6nB0=;
        b=ueoXhCSzls4pUvhI7ZPsCJL7/Q6VUS8k+rOBwv0XS4p1rKj/zPTNfSDp2vmufLs/25
         kqCJlsdaW9UG6Sk51dht4nAr+oB6amkkkRl88Y0VtSKg/u5cB7DTAT0AP74zdGXIbFXH
         QsHCAuz4D2LaG8DOB83v3371YVQ5/vUI9b7kNCWPFG88vy9t8bu6Y5ghei2/qD3KBRrG
         3OC3iHy+af0Q/5S4+Y5sW8nftWgWAKMfDBQeWcHL5sP9uUwRyy+7UKB1K0ccf0wo6Tfb
         wtIy8pwQNXZJAOsv+o0JSzZSGREqg6P6WbfbYqEqg6/9T+lpt2EnYM37DQNCPDExrOVj
         Rk4g==
X-Gm-Message-State: ACgBeo2Om2Dh10sUsR7XhA7t/NipGnnu6fDZDM7vnEF6FYDemQxHwQFQ
        USb4c6z4A4y1h1IXcGNE1sEoMCTyYFsd4Q==
X-Google-Smtp-Source: AA6agR4Rv9AwcstSQHZdJtcKd9dL6V/NSNnmRrMuSsih1LiWUEzNLMRsvUGJ7yRVOfXuPmyuHXlXHA==
X-Received: by 2002:a17:902:7602:b0:172:a064:4a2f with SMTP id k2-20020a170902760200b00172a0644a2fmr35916188pll.56.1663158724017;
        Wed, 14 Sep 2022 05:32:04 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b0017854cee6ebsm2263266plg.72.2022.09.14.05.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:32:03 -0700 (PDT)
Date:   Wed, 14 Sep 2022 21:31:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 06/29] printk: Protect [un]register_console() with a
 mutex
Message-ID: <YyHJvdQbmd1wf0bZ@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.712668210@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.712668210@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/11 00:27), Thomas Gleixner wrote:
[..]
> + * console_sem protects the console_drivers list, and also provides
> + * serialization for access to the entire console driver system.
> + *
> + * console_mutex serializes register/unregister. console_sem has to be
> + * taken for any list manipulation inside the console_mutex locked
> + * section to keep the console BKL machinery happy.
>   */
> +static DEFINE_MUTEX(console_mutex);
>  static DEFINE_SEMAPHORE(console_sem);
[..]
>  /*
>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>   * macros instead of functions so that _RET_IP_ contains useful information.
> @@ -2978,17 +3008,21 @@ struct tty_driver *console_device(int *i
>  void console_stop(struct console *console)
>  {
>  	__pr_flush(console, 1000, true);
> +	console_list_lock();
>  	console_lock();
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
> +	console_list_unlock();
>  }
>  EXPORT_SYMBOL(console_stop);
>  
>  void console_start(struct console *console)
>  {
> +	console_list_lock();
>  	console_lock();
>  	console->flags |= CON_ENABLED;
>  	console_unlock();
> +	console_list_unlock();
>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);

So the comment says that list lock (console_mutex) is to serialize
register/unregister, but then we take it in stop/start as well. What
does list lock protect us against in start/stop? console->flags reader
(console_is_usable()) does not take list lock, it's called under console
lock and console->flags writers (console_unregister() and console_stop())
modify console->flags under console_lock.
