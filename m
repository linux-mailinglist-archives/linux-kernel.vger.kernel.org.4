Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258E6369A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbiKWTMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiKWTMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:12:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A58DA1B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:12:09 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ci10so10457729pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QA+yAL06ySNz02sxUF8x/UDuflnKKFyHryfYiGnxg8=;
        b=q7glId5iAYE1SXwULrXl4AkDpMcQjOY/W+wshGb4lcJHWA6PW9Ykp0Lt+Isq7gAvwQ
         aW8ShG/bQafQPXRYYhSjUXKjJznIh6+xq0CGox0p4oFiA2lrSV5KGlt87LD1K3BdDMIp
         A/42gP/xuewqyX5rkO4iHxsNWiB0GPHzbtnD8qOGI8Q5+CTF8zM+1dE3HC8hNW2Qdsfz
         zktkj/DynPgD4li9c0O533jKiYDitQFo6lVZuVzNSBOs5PHxhqV1dzg8IJUpC+bZQIxU
         dhfAh6dVtn8QB6pRq2VGhn7XqI4iMnW5YwQXyVJjxz9SQSwl/vwpApnJ9YATNVTTzbx2
         HDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QA+yAL06ySNz02sxUF8x/UDuflnKKFyHryfYiGnxg8=;
        b=qNfg79u38iscxvzRZAiIMxReI1V2WBxyP/GcjM9MU2DbAIQZpqWRK0HHLyeoChnYwC
         sePUqX+3Keo3aEtegSJdA3XfnhPIrRPK+XlMl16aMcXxEyhd6xBh1H0n39CKHuK0Qvr2
         fGvcUgHxB8F1zYRniOmwcFryXZXFmuxUUhu89DcqelKxC9uOZrqjuPBaMw7AC8llSt7Z
         lonAswYyQyRlx27SXwoQjdKpoXoVW0nJ/cWaF6+YKvuwkpYIbQK2J0JKupBGqKuPwTXn
         AZANsn0Qs8tVOXmjiKjxs0geXGRBb+cTMiHXjodZAO57PpaSS5Daqxfz14rPgpLt39W2
         HlBg==
X-Gm-Message-State: ANoB5plZWsjDonEbMqZd3uREanjk0n05gYhJVs4a9Nc7SAc2aAFH41TP
        oWwibY50YbG27qAc+178FKxyog==
X-Google-Smtp-Source: AA0mqf7KHwclj9+xMrG7yYqYd/3m5atoOHX4zcDfPI4UsivsL98pigAUUmZtQguTDLkXwUDJfNvC1A==
X-Received: by 2002:a17:903:2591:b0:179:e1f6:d24d with SMTP id jb17-20020a170903259100b00179e1f6d24dmr9995587plb.91.1669230728649;
        Wed, 23 Nov 2022 11:12:08 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lt11-20020a17090b354b00b0020ad86f4c54sm1805746pjb.16.2022.11.23.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 11:12:07 -0800 (PST)
Date:   Wed, 23 Nov 2022 19:12:03 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     "Jiazi.Li" <jqqlijiazi@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, arve@android.com,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        "Jiazi.Li" <jiazi.li@transsion.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: remove unneeded size check code
Message-ID: <Y35wg8/lyyam+dfP@google.com>
References: <20221115120351.2769-1-jiazi.li@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120351.2769-1-jiazi.li@transsion.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:03:51PM +0800, Jiazi.Li wrote:
> In binder_ioctl function, the legitimacy check of cmd size has been
> done in switch-case code:
> switch (cmd) {
> 	case BINDER_WRITE_READ;//BINDER_WRITE_READ contains size info
> 
> So unneeded do size check in binder_ioctl and binder_ioctl_write_read
> again.
> 
> In the following version of Google GKI:
> 
> Linux version 5.10.110-android12-9-00011-g2c814f559132-ab8969555
> 
> It seems that the compiler has made optimization and has not passed
> cmd parameters to binder_ioctl_write_read:
> <binder_ioctl+628>:  mov     w8, #0x6201                     // #25089
> <binder_ioctl+632>:  movk    w8, #0xc030, lsl #16
> <binder_ioctl+636>:  cmp     w20, w8
> <binder_ioctl+640>:  b.ne    0xffffffda8aa97880 <binder_ioctl+3168>
> <binder_ioctl+644>:  mov     x0, x23 //filp
> <binder_ioctl+648>:  mov     x1, x27 //arg
> <binder_ioctl+652>:  mov     x2, x22 //thread
> <binder_ioctl+656>:  bl      0xffffffda8aa9e6e4 <binder_ioctl_write_read>
> <binder_ioctl+660>:  mov     w26, w0
> 
> Signed-off-by: Jiazi.Li <jiazi.li@transsion.com>
> ---
>  drivers/android/binder.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 880224ec6abb..48e5a3531282 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5006,20 +5006,14 @@ static __poll_t binder_poll(struct file *filp,
>  	return 0;
>  }
>  
> -static int binder_ioctl_write_read(struct file *filp,
> -				unsigned int cmd, unsigned long arg,
> +static int binder_ioctl_write_read(struct file *filp, unsigned long arg,
>  				struct binder_thread *thread)
>  {
>  	int ret = 0;
>  	struct binder_proc *proc = filp->private_data;
> -	unsigned int size = _IOC_SIZE(cmd);
>  	void __user *ubuf = (void __user *)arg;
>  	struct binder_write_read bwr;
>  
> -	if (size != sizeof(struct binder_write_read)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
>  	if (copy_from_user(&bwr, ubuf, sizeof(bwr))) {
>  		ret = -EFAULT;
>  		goto out;
> @@ -5296,7 +5290,6 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	int ret;
>  	struct binder_proc *proc = filp->private_data;
>  	struct binder_thread *thread;
> -	unsigned int size = _IOC_SIZE(cmd);
>  	void __user *ubuf = (void __user *)arg;
>  
>  	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
> @@ -5318,7 +5311,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	switch (cmd) {
>  	case BINDER_WRITE_READ:
> -		ret = binder_ioctl_write_read(filp, cmd, arg, thread);
> +		ret = binder_ioctl_write_read(filp, arg, thread);
>  		if (ret)
>  			goto err;
>  		break;
> @@ -5361,10 +5354,6 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	case BINDER_VERSION: {
>  		struct binder_version __user *ver = ubuf;
>  
> -		if (size != sizeof(struct binder_version)) {
> -			ret = -EINVAL;
> -			goto err;
> -		}
>  		if (put_user(BINDER_CURRENT_PROTOCOL_VERSION,
>  			     &ver->protocol_version)) {
>  			ret = -EINVAL;
> -- 
> 2.17.1
> 

Looks good, thanks!

Acked-by: Carlos Llamas <cmllamas@google.com>
