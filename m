Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2D064D29F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLNWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:53:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F3379FC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:53:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so8571785pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlgvRMbpIAARM7VWvJ1shJhqY7lLim2WICuRaB7wHAI=;
        b=kzsg/G9Ebw67hwz+E8fsrhhhk2zVVF7lra4bSA2thRrKuW/BvpjdtI493yQoHLpqpg
         BrvsySo7DQXeI5+OUyaAsCfmwzRDv++H/q5T4ICZUgREQWnZ0wv3RUpUKORiMUkGmcq+
         H+p4sCoi3f2/UMYn8uCcUuhV1wFRVWIOfFu4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlgvRMbpIAARM7VWvJ1shJhqY7lLim2WICuRaB7wHAI=;
        b=ANVOTLQUrpMOMmliFC1skiGmx/i62fEM+4k0dFL2Kh5dUJa+RcgWdxW9OuWY2mlKPN
         CPSP9YU5bBs+o4ksbFMHJL/+EsGW60sQEfDfmvICNicTss5h54NXvcPzb1ada6rSJK1a
         k/6SXXneLzeVlbr6GFKeuBxvJickhh5SMPtH2k6JSOnYk0pBCbC/gvl9DpArcMi5BCUk
         FYfGiNOMMMZTjKcz/TEHkdpbZnvHKXfnPwjqHI/ROuilKUgtt5yvWNE1/of5vjcQ790K
         O3tKyYQxXI6KQIbOHPNqpj92rAJfdMLlPCPvrYWDIeyVAsAUBSqbXP+saAz3Dvpxu6Vc
         qojw==
X-Gm-Message-State: ANoB5pkps1KfSh5G2guTi9KmOoKTD2RjV/ErSz3sV+MkNyxX1UKOJ36X
        G1sidsIpKnf/+DqMqFvby6gfnw==
X-Google-Smtp-Source: AA0mqf7Dc3+pdTXmuf6kh0SCmvCHLRQ4jRA5shQMTqWX4ShcLIJAVLzuL2360gXtYnaS/Td7mKsSpA==
X-Received: by 2002:a05:6a20:a001:b0:9d:efbf:48e3 with SMTP id p1-20020a056a20a00100b0009defbf48e3mr36811505pzj.39.1671058408484;
        Wed, 14 Dec 2022 14:53:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h25-20020a63f919000000b0047681fa88d1sm325349pgi.53.2022.12.14.14.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:53:28 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:53:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Connor O'Brien <connoro@google.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com
Subject: Re: [RFC PATCH] pstore: Switch pmsg_lock to an rt_mutex to avoid
 priority inversion
Message-ID: <202212141453.C79E68F@keescook>
References: <20221205203253.3923812-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205203253.3923812-1-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 08:32:53PM +0000, John Stultz wrote:
> Wei Wang reported seeing priority inversion caused latencies
> caused by contention on pmsg_lock, and suggested it be switched
> to a rt_mutex.
> 
> I was initially hesitant this would help, as the tasks in that
> trace all seemed to be SCHED_NORMAL, so the benefit would be
> limited to only nice boosting.
> 
> However, another similar issue was raised where the priority
> inversion was seen did involve a blocked RT task so it is clear
> this would be helpful in that case.
> 
> Feedback would be appreciate!

This looks fine to me. Is there an appropriate "Fixes:" tag that could
be used?

-Kees

> 
> Cc: Wei Wang <wvw@google.com>
> Cc: Midas Chien<midaschieh@google.com>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: kernel-team@android.com
> Reported-by: Wei Wang <wvw@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  fs/pstore/pmsg.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
> index d8542ec2f38c..18cf94b597e0 100644
> --- a/fs/pstore/pmsg.c
> +++ b/fs/pstore/pmsg.c
> @@ -7,9 +7,10 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
> +#include <linux/rtmutex.h>
>  #include "internal.h"
>  
> -static DEFINE_MUTEX(pmsg_lock);
> +static DEFINE_RT_MUTEX(pmsg_lock);
>  
>  static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  			  size_t count, loff_t *ppos)
> @@ -28,9 +29,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
>  	if (!access_ok(buf, count))
>  		return -EFAULT;
>  
> -	mutex_lock(&pmsg_lock);
> +	rt_mutex_lock(&pmsg_lock);
>  	ret = psinfo->write_user(&record, buf);
> -	mutex_unlock(&pmsg_lock);
> +	rt_mutex_unlock(&pmsg_lock);
>  	return ret ? ret : count;
>  }
>  
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

-- 
Kees Cook
