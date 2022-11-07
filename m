Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3102061EAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiKGFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGFre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:47:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACCCE38
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:47:33 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b62so9560708pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 21:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prS9/4s/KH6GPj6BklralGgu+34y9Wj2d+z0KXjiYNg=;
        b=SzjsIrzw1v55jU2Oh27QGJAFaSHzkaGfmUJje8fRkYwecxzETDSO8s/eE9nE2Ry+W5
         u3fXvOFSpd2PeKPfgvClreIVwft/lL9lFC29K5zkx4yLV1u4tn0vGmC7c8BDRh6cpms4
         p3sbTzW60pns4FnNb/5cB3cLOstJgTtH0RpDLbXmM+JupRX2hzjp47ZBQXKrrSVq+DV1
         59DdyBpi+lOE4DuXz+5O1NCeBonLXVrNfKtzTJ1p7YSj841kh50kmS+0u2l8g7yQnALE
         PLqPPfIdRBCOICNtvJHRTkynotSGNRmvYgLttIf+0m/LEztpAXjdwSSVE+2+qeY2p7EJ
         E6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prS9/4s/KH6GPj6BklralGgu+34y9Wj2d+z0KXjiYNg=;
        b=th6QBJxxj5Jhi9WT6Tj1B1GGiDGoHRE0nvhFslbpeemYo85Tg2qGbiPx6BstOM7RC0
         KVXNp/K6aDiYMQpNHTEZcYfv8ZmKnpUJiMjUOPFgLVta0PnIoYqcnVVBS7FJncHYJwRg
         QZmZ+Mm9b63wXkmcgxKDlUCJfmzNJ8h1ZOFiMJhbw36zQcRroQc5d/UMZTNNc0WzYQIE
         vkx0i+u6jvAGOoODbnJHnLtVN6GU8LrD5YMNPbSlc48YquP7wfeKMBjLR+7yHi9tPNZL
         91hOpygl7UPvwE1U7eHpyxw7AaNdJOsIxX4gGU/J97AmKokbuCAEzGqdgOKJD1+d5zl4
         SRbg==
X-Gm-Message-State: ACrzQf2p4wS9Cq/l+SymhBZTzUDizFxApJaO6rPxAcEaaxqZBbeKJjSz
        b2dmswyr7jjSNFIuOLmvuqBR6w==
X-Google-Smtp-Source: AMsMyM5iAjeBgfM0MTSjxIuXe3Y826zQ6iSKU6Vp04/YG3qFNpDgYyXt4Uj+7lL0T4Y3xhF++hsM5Q==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr40732583pgk.501.1667800052857;
        Sun, 06 Nov 2022 21:47:32 -0800 (PST)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b00186a437f4d7sm4025891pld.147.2022.11.06.21.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 21:47:32 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:17:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5a 1/5] ARM: spear: Do not use timer namespace for
 timer_shutdown() function
Message-ID: <20221107054730.jngxacbdtzwhn77l@vireshk-i7>
References: <20221106054535.709068702@goodmis.org>
 <20221106054648.367234222@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106054648.367234222@goodmis.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-22, 01:45, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> A new "shutdown" timer state is being added to the generic timer code. One
> of the functions to change the timer into the state is called
> "timer_shutdown()". This means that there can not be other functions
> called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> 
> Rename timer_shutdown() to spear_timer_shutdown() to avoid this conflict.
> 
> Link: https://lore.kernel.org/all/20221105060155.228348078@goodmis.org/
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: soc@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I just replied to the previous version, ignore that now :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks.

-- 
viresh
