Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CB72AB69
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFJMUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:20:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722A03594
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 05:20:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686399611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zf7g/lr78i/6foxSt5E0cew9w6Xu1ollzXpCt9LuA1E=;
        b=lp01q9Fq+YZbf13jlVUbe83aSS446/+/M94kP+K16+YqlQl6u0vbKzv0UvsSkxL6e6n9+0
        fF7PnPvIUJB8tDEDXEOMtdKyL8FJ92qZPr/gGzDZ7msFxdVjog+Oa2Bd/9VYdp9utfKioC
        KVxE3a4Zhquiiq6SiILp2FBTK+JIItJqP4fFILfZNk0+5z+f63y6wy7Ecs9+38PzODIc/M
        6uoeQnzjWyYltS4YpdDnZhu3YDfzJkqqItskyZJHAZGkOYHG32R9Y+h7+R52OApT+1tA9t
        6JrVqfVelfbfrw/58iznX46Lj8r6XsLGc7X2EOKdgBJh7WCYq0BZoGxFr9iCIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686399611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zf7g/lr78i/6foxSt5E0cew9w6Xu1ollzXpCt9LuA1E=;
        b=NCznKgf3V31LKMvlumBL2hQx7W/esVxX8IxORqWL9dUjUjbpgMwZCK0/slu52isT1HUkWP
        iw14UTcBga26XUDw==
To:     Li zeming <zeming@nfschina.com>, jstultz@google.com,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] time: alarmtimer: Optimization function return value
In-Reply-To: <20230609180955.4357-1-zeming@nfschina.com>
References: <20230609180955.4357-1-zeming@nfschina.com>
Date:   Sat, 10 Jun 2023 14:20:10 +0200
Message-ID: <871qija4qt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10 2023 at 02:09, Li zeming wrote:
>  	if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
> -		return -1;
> +		return -EPERM;

I know you are only replacing the -1, but EPERM does not make any sense
here. It's not a permission problem, it's the lack of a feature. So the
proper code is -ENODEV.

>  	if (!device_may_wakeup(rtc->dev.parent))
> -		return -1;
> +		return -EPERM;

Ditto
 
>  	pdev = platform_device_register_data(dev, "alarmtimer",
>  					     PLATFORM_DEVID_AUTO, NULL, 0);
> @@ -104,7 +104,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>  	spin_lock_irqsave(&rtcdev_lock, flags);
>  	if (!IS_ERR(pdev) && !rtcdev) {
>  		if (!try_module_get(rtc->owner)) {
> -			ret = -1;
> +			ret = -EPERM;

Same here.

But this error case is broken because it does not undo the

     device_init_wakeup(&pdev->dev, true);

So this needs

+  		device_init_wakeup(&pdev->dev, false);

before the goto

>  			goto unlock;
>  		}
>  
> @@ -113,7 +113,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>  		get_device(dev);
>  		pdev = NULL;
>  	} else {
> -		ret = -1;
> +		ret = -EPERM;

                ENODEV

>  	}

So please do not blindly replace something without actually analysing
it. There is a reason why these things are not just "fixed" with a
script.

Thanks,

        tglx
