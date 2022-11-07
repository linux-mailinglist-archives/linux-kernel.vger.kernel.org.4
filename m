Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D805161F42E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiKGNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiKGNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:20:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE11B784
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:20:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g12so16135179wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQkhty8T6POVcU0azwPlKsIEvLSkT2jpd0kdC7pkzz0=;
        b=ew4Bjy04DI9e5uryHgtndcjXp7MrPHICFFUqFV3AugH3b1UShyzEM/SAirrVHiAl83
         PVmFgozsEbeu6JDph10T15ypDT+tLWM653yGhNcnL3qWab7Wp0ueNotW7YUWIYs9HQ3h
         I6OVDxc3D176IlpO8mTZ34in308iaW6xkLWh+hEVyY5MwlM2E2jbNfH0+3ogAqfaSS58
         3S19a/4DM9vKUaT8B9CUc/0++7ZFOWmgk0ZmnWHnCRX//F6eKCwElFNwgI/K2L6MejIQ
         tgfEMzbF3cAuOa2GYXwISRtsHS/uM/D0Dbc6pjZpDS64kz7bzYsK8/0c01s+x6ZdRo5q
         x/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQkhty8T6POVcU0azwPlKsIEvLSkT2jpd0kdC7pkzz0=;
        b=3kgIXfuLxXt2LBuj4xF2RFx9/Y3hXWouz6KkS6FWnqQXrBZU7y09ozrPXhPPeBcLBI
         wpMxqO8ETrPaTttPt1GooalnHBODzyEtAyzQTpk0zBZsrChuCdIOXagKnRq1JqFDj1h7
         8gg+Gwiwg/0H0Dd4jYKcD0o6lzFkCRhZIBDLTz3TbZqYcrJJK5q9icJ6SKSo3GlrpBpW
         IO5BbIzkgD2wEvwht1sQFKveCnvHvzOL7M4I6g7DNJCrTkWaa39D/ztnnFV3L1+19CKk
         exTnuRIPc+RC00euEcytgEMDT/kOGpsfg0EBuQ4mi5zpgZ/2sv023Nb7X05o3BXo7RzB
         SgjA==
X-Gm-Message-State: ACrzQf0qT9iWVnPaXWSlwynWUQxL51PzWAfcg8JBx5eJVxG5OUeDKXp6
        1syjnEcO+1DtSbALtI9Z8BA=
X-Google-Smtp-Source: AMsMyM67ieLID2xmpb5tqDsb0FoMSwND0Ma2RaIdA+o1o/Ikv6l0mI6mTXhxzxUplvxTUH8HZwcyMg==
X-Received: by 2002:adf:f2c5:0:b0:236:aad0:b361 with SMTP id d5-20020adff2c5000000b00236aad0b361mr30264804wrp.228.1667827230815;
        Mon, 07 Nov 2022 05:20:30 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bw9-20020a0560001f8900b00236c1f2cecesm8935240wrb.81.2022.11.07.05.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:20:30 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:20:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: video: use min_t() for comparison and
 assignment
Message-ID: <Y2kGG3zuvvDLZKWq@kadam>
References: <Y2iHl5CuqyR2vEc8@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2iHl5CuqyR2vEc8@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 09:50:39AM +0530, Deepak R Varma wrote:
> Simplify code by using min_t helper macro for logical evaluation
> and value assignment. Use the _t variant of min macro since the
> variable types are not same.
> This issue is identified by coccicheck using the minmax.cocci file.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> 
> Changes in v2:
>    1. Revise patch description. No functional change.
> 
>  drivers/staging/most/video/video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index ffa97ef21ea5..d5cc7eea3b52 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -173,7 +173,7 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
>  	while (count > 0 && data_ready(mdev)) {
>  		struct mbo *const mbo = get_top_mbo(mdev);
>  		int const rem = mbo->processed_length - fh->offs;
> -		int const cnt = rem < count ? rem : count;
> +		int const cnt = min_t(int, rem, count);

TL;DR use size_t instead of int.

Using "int" here is wrong.  size_t is unsigned long meaning that it has
64 bits to use to represent positive values.  (Let's ignore 32 bit
arches).  You have chopped it down to say that it now has 31 bits for
positives and if BIT(31) is set then treat it as negative.  Everything
which is larger than INT_MAX will be broken.

Fortunately, in this code the value of count will never go higher than
"INT_MAX - PAGE_SIZE" because Linus understands that it's easy to
introduce bugs like this.

regards,
dan carpenter

