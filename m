Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B92D612F82
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJaEuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaEuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:50:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954B95B5;
        Sun, 30 Oct 2022 21:50:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so9319482pjd.4;
        Sun, 30 Oct 2022 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HZ6crvrNBTL6o/aXnYYfBzUet5Ca72Allf+X0NXNiw=;
        b=gtXgfOOETY0QbgHWKjBz11xbn0px9egOMV/kBPSZhOaiDM4RRxoD7QvhI9STewMTmV
         EK7Fmwd9VkrA5ze2tHotTsoqIvxNQFiUCAGm6LRHlvWKsWsIu36ANx2M0CmhgnXSear7
         GcZ18DkFZd2agAhE3WVxEcFh40rgdaDd+9wQV35rAg93Ntoqhdp+AeSId+swffyFjyO0
         /ZP1UYdrHoZ2RDCPoy0f750CPZdY86CBYjYdzw3bnAaDzz15HBVT0nT8MG6sP0z3foov
         Cx9i/qBMfBxK1wGCd2xnI4DNTfIWWuqBWAXDixYzbuAEXjaJXtV4rajk98uWFQBARauN
         22/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HZ6crvrNBTL6o/aXnYYfBzUet5Ca72Allf+X0NXNiw=;
        b=jDTZptCelkKymQgJkEVye1HwX3bWKAJ0EmmRt28nrXR88YDN0v0wMt5rwzBZlQ+r7n
         oO9bNKSk4NAdyLo4r7N6hIiX9692uTbRgXxb/C7/wMSIcntQ8hec8diqn6qhozdHhBQK
         RGdzRHr3TqNAW3xnOGXEnYuwkn2RrwiMZzmxov8D8kdAWEJPux7lUVQHaoLWfle1prto
         /il9OUAi4L0GVTH70PQndAStg/H4Zz3z8wy5nYjiJtBUenBg7Vm4AzNGaqiNouE3J3QB
         +KkdS7OIyH7lTmAy3yM0hmORH5aeff23aoDaEf4zDIzaYJsE8WorkxNlCBAYRn0IaURf
         fMJg==
X-Gm-Message-State: ACrzQf3R33hqtHRT5t67JQjd8VzH/5V69o+T50c+052m7OW7PnSZSr4c
        EluMPlNyu14ESPJ7lKCDHOY=
X-Google-Smtp-Source: AMsMyM7fXepLdyYMhRAs75ivz/K1l9q2W0RwknokTx5nUUOp+dYm/CzGshsyTPnjeg7LlBlV7mjroA==
X-Received: by 2002:a17:902:c7c1:b0:186:b766:5dde with SMTP id r1-20020a170902c7c100b00186b7665ddemr12839009pla.93.1667191814821;
        Sun, 30 Oct 2022 21:50:14 -0700 (PDT)
Received: from biggie ([103.230.148.186])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b00183e2a96414sm3445911plg.121.2022.10.30.21.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 21:50:14 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:20:09 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers/media/rc: Fix a race condition in send_packet()
Message-ID: <Y19UAV8R4xN7HMAo@biggie>
References: <20221019050214.107448-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019050214.107448-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:32:14AM +0530, Gautam Menghani wrote:
> The function send_packet() has a race condition as follows:
> func send_packet()
> {
>     // do work
>     call usb_submit_urb()
>     mutex_unlock()
>     wait_for_event_interruptible()  <-- lock gone
>     mutex_lock()
> }
> 
> func vfd_write()
> {
>     mutex_lock()
>     call send_packet()  <- prev call is not completed
>     mutex_unlock()
> }
> 
> When the mutex is unlocked and the function send_packet() waits for the
> call to complete, vfd_write() can start another call, which leads to the
> "URB submitted while active" warning in usb_submit_urb(). 
> Fix this by removing the mutex_unlock() call in send_packet() and using
> mutex_lock_interruptible().
> 
> Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
> Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
> Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  drivers/media/rc/imon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> index 735b925da998..91d8056666ec 100644
> --- a/drivers/media/rc/imon.c
> +++ b/drivers/media/rc/imon.c
> @@ -646,15 +646,14 @@ static int send_packet(struct imon_context *ictx)
>  		pr_err_ratelimited("error submitting urb(%d)\n", retval);
>  	} else {
>  		/* Wait for transmission to complete (or abort) */
> -		mutex_unlock(&ictx->lock);
>  		retval = wait_for_completion_interruptible(
>  				&ictx->tx.finished);
>  		if (retval) {
>  			usb_kill_urb(ictx->tx_urb);
>  			pr_err_ratelimited("task interrupted\n");
>  		}
> -		mutex_lock(&ictx->lock);
>  
> +		ictx->tx.busy = false;
>  		retval = ictx->tx.status;
>  		if (retval)
>  			pr_err_ratelimited("packet tx failed (%d)\n", retval);
> @@ -955,7 +954,8 @@ static ssize_t vfd_write(struct file *file, const char __user *buf,
>  	if (ictx->disconnected)
>  		return -ENODEV;
>  
> -	mutex_lock(&ictx->lock);
> +	if (mutex_lock_interruptible(&ictx->lock))
> +		return -ERESTARTSYS;
>  
>  	if (!ictx->dev_present_intf0) {
>  		pr_err_ratelimited("no iMON device present\n");
> -- 
> 2.34.1
> 

Hi,

Please review the above fix and let me know if any changes are required.

Thanks,
Gautam
