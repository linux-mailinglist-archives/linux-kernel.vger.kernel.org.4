Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4973D865
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFZHXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFZHXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:23:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EDDE0;
        Mon, 26 Jun 2023 00:23:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6682909acadso1167606b3a.3;
        Mon, 26 Jun 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687764213; x=1690356213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAoHpYkt2lBs67uUYdErp3v/viJTQC8Dihr6kiw5jT0=;
        b=JF7SLFjjJojECO7To1D2VB9yhY0eyzwOtsZ9C6as64pdYMLvep8qXrA9DXDpsezGyA
         sa5Q+4ZJjGXhJVmxoQY9hnOFth+za+46Vs9se9172javfESFXTo/bAyrBvRXcwBMFo0+
         7JKN4sMcMMeghXjo8TzpyYdsRLU799lTKoSQhIaF/QIEWtOQYhaFqlVrkr7PEXuO1Q+A
         Gm6z5TepsnfeKZ9AJX5yG8zvFGq0kHuJeCxWB8Clxh9Bz59i+uZIhVSzXvQDrvYilpvI
         iypANLaV2THFVwBUqDprMO93x+BzWwzR4kcT8LeTI6hGX/m4+MbaKiBW2ZToF2HIOR0q
         6cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687764213; x=1690356213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAoHpYkt2lBs67uUYdErp3v/viJTQC8Dihr6kiw5jT0=;
        b=LI9Y8iAno56jMUoYilZC7qhlRcgkuJIqAg46reFjev576jFBzpdWMl5oR0+qna0o14
         44e4fq9sv7Gg2qDCL23HMHfqg+vu9hMzdc6D/9c4xa8Rms91iAuOoYHEfdu25RuXPCqe
         /dsEF6sYzQhiTHzKcBB9agaH4AUXXUpVlYRvJiTHJ6qVJItBsHup/DDIXfoYlPMw3/bv
         Xku6sSXncLCPmKyZA/dbJp9wAchJMSzz+edPK/R+VPf+CeI5XoN54WM3FHvpZAgax8l/
         tmT7A9d4pXl0KR65KbHij20y2RIh7o6E6BEekKb2EwTdYolcLQdja+x604sT9tKVsonX
         2U0A==
X-Gm-Message-State: AC+VfDyHms4bMuopgaFxyJeO7EV44gro+S9fNjUA0SaCwehVg0cv01mm
        4Rzm/RwkaM777eRjkkVxgCP5lrxGdO4=
X-Google-Smtp-Source: ACHHUZ4rYOSEmn3CtaffZSSiMXxV2WwV5WlljV233A0cvBcVDENylrF0yQW7CLWEHPuEqJuGYaNrCg==
X-Received: by 2002:a05:6a00:3a0e:b0:661:4a00:1ea5 with SMTP id fj14-20020a056a003a0e00b006614a001ea5mr23090693pfb.20.1687764212616;
        Mon, 26 Jun 2023 00:23:32 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id e17-20020a62aa11000000b00625037cf695sm3218213pff.86.2023.06.26.00.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 00:23:32 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:23:26 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     YE Chengfeng <cyeaa@connect.ust.hk>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Message-ID: <ZJk87rWsDj7pWJIP@sol>
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:45:12PM +0000, YE Chengfeng wrote:
> linereq_put_event is called from both interrupt context (e.g.,
> edge_irq_thread) and process context (process_hw_ts_thread).
> Therefore, interrupt should be disabled before acquiring lock
> &lr->wait.lock inside linereq_put_event to avoid deadlock when
> the lock is held in process context and edge_irq_thread comes.
> 
> Similarly, linereq_read_unlocked running in process context
> also acquies the same lock. It also need to disable interrupt
> otherwise deadlock could happen if the irq edge_irq_thread
> comes to execution while the lock is held.
> 

So, in both cases, a process context holding the lock is interrupted, on
the same CPU, and the edge_irq_thread() deadlocks on that lock, as the
interrupted process holds the lock and cannot proceed.
That makes sense to me, but it would be good for Bart to confirm as he
knows a lot more about the kfifo locking than I do.

Note that the same problem also exists in lineevent_read_unlocked() - the
uAPI v1 equivalent of linereq_read_unlocked().

> Fix the two potential deadlock issues by spin_lock_irqsave.
> 

spin_lock_bh() should be sufficient, given that edge_irq_thread() is run
in a softirq?  That is faster and would allow the hard irq handlers to
still run, and timestamp the event, but inhibit the edge_irq_thread()
from being called on that CPU until the lock is released.
(hmmm, gpio_desc_to_lineinfo() also uses spin_lock_irqsave() but it is
never called from hard irq context, so there is a good chance I'm missing
something here??)
More on spin_lock choice below.

This should have a Fixes tag.
For v2, it has been there since it was added, so:

73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")

And it also applies to lineevent_read_unlocked() from uAPI v1, so there
should be a separate fix for that, or at least a separate tag.

I looks to me that it was first introduced in uAPI v1 here:

dea9c80ee672 ("gpiolib: rework the locking mechanism for lineevent kfifo")

> Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> ---
>  drivers/gpio/gpiolib-cdev.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0a33971c964c..714631fde9a8 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -614,14 +614,15 @@ static void linereq_put_event(struct linereq *lr,
>  			      struct gpio_v2_line_event *le)
>  {
>  	bool overflow = false;
> +	unsigned long flags;
>  
> -	spin_lock(&lr->wait.lock);
> +	spin_lock_irqsave(&lr->wait.lock, flags);

linereq_put_event() is never called from hard irq context, so
spin_lock_irq() or spin_lock_bh() should suffice?

>  	if (kfifo_is_full(&lr->events)) {
>  		overflow = true;
>  		kfifo_skip(&lr->events);
>  	}
>  	kfifo_in(&lr->events, le, 1);
> -	spin_unlock(&lr->wait.lock);
> +	spin_unlock_irqrestore(&lr->wait.lock, flags);
>  	if (!overflow)
>  		wake_up_poll(&lr->wait, EPOLLIN);
>  	else
> @@ -1505,6 +1506,7 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
>  	struct linereq *lr = file->private_data;
>  	struct gpio_v2_line_event le;
>  	ssize_t bytes_read = 0;
> +	unsigned long flags;
>  	int ret;
>  
>  	if (!lr->gdev->chip)
> @@ -1514,28 +1516,28 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
>  		return -EINVAL;
>  
>  	do {
> -		spin_lock(&lr->wait.lock);
> +		spin_lock_irqsave(&lr->wait.lock, flags);

linereq_read_unlocked() is only ever called in process context, so this
could be spin_lock_irq() or even spin_lock_bh()?

>  		if (kfifo_is_empty(&lr->events)) {
>  			if (bytes_read) {
> -				spin_unlock(&lr->wait.lock);
> +				spin_unlock_irqrestore(&lr->wait.lock, flags);
>  				return bytes_read;
>  			}
>  
>  			if (file->f_flags & O_NONBLOCK) {
> -				spin_unlock(&lr->wait.lock);
> +				spin_unlock_irqrestore(&lr->wait.lock, flags);
>  				return -EAGAIN;
>  			}
>  
>  			ret = wait_event_interruptible_locked(lr->wait,
>  					!kfifo_is_empty(&lr->events));

wait_event_interruptible_locked() works with locks that are
spin_lock()/spin_unlock(), so this will leave irqs disabled while
waiting for a new event??

And while there is a wait_event_interruptible_locked_irq(), there is
no wait_event_interruptible_locked_bh() form that I can see, so using
spin_lock_bh() would require some extra work.

>  			if (ret) {
> -				spin_unlock(&lr->wait.lock);
> +				spin_unlock_irqrestore(&lr->wait.lock, flags);
>  				return ret;
>  			}
>  		}
>  
>  		ret = kfifo_out(&lr->events, &le, 1);
> -		spin_unlock(&lr->wait.lock);
> +		spin_unlock_irqrestore(&lr->wait.lock, flags);
>  		if (ret != 1) {
>  			/*
>  			 * This should never happen - we were holding the
> -- 
> 2.17.1

Anyway, good catch.

Cheers,
Kent.
