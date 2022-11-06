Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EED61DFCF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 01:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKFAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKFAal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 20:30:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8B1265B;
        Sat,  5 Nov 2022 17:30:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a27so5254866qtw.10;
        Sat, 05 Nov 2022 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7icr2ccwj4KXKIEFeiasLTFoXUPeV5GqVTWsb2ag74=;
        b=J4HGCixsqOHqnl7wwgpKN/wpG1l5e7HZx5SRew4/3U6oI9/krShrjd2+JVmp1jcFZ9
         zBBq1nlWov8Egp3o1UslodAR2HGZb/c4+YGJ9SUMo/TskUrwxB+s3MRm874qdBbM8xG9
         abgQmaK8tAeU3vfvGyfU/XT3aLj1IKPgoGUwt4nmoa4IwVYKaLUKWhNVH3A8Ge5QKOr4
         dnKhpX4XG92gCVoprWkH6ZMXs/dm6HfVEj7Mv7cGIoQaZHu/nl24reeIA3kJGPoGgsyE
         +2U93K5MohtYCYR/GGdabIyiXZXxb6BKtoN6Fm6iOiM4VV+R9uh23vqdt+cOaNb/zv9j
         uALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U7icr2ccwj4KXKIEFeiasLTFoXUPeV5GqVTWsb2ag74=;
        b=Tro22emqKcUBfrkqZuanxWttpf4CgTB7L4f6nI9mp/l3+9CLZQcxE92j0Qm39h1QAJ
         zc3RZR2hQJCdMYWTOeaLkymmTzY2/XXKByJJwvJv+V7Nq9zFoEk1MldmwqE2PGTxZcNe
         GJL/VuF0ZNYUH2DKQ3MoR8Uv5XhTpB4r/gxkk2VJLmLJZwEdS0vs7Eno8LapdE/1S2T4
         +HD9RzbKsvnLTZ4yLzD16DUh+jUNB0Ucq1nROiEBbhcsAuCwdPwGWaxxGyTYnxaTlaj2
         bq1u+/F6JZlyzfe/2YMLGVDwtxTzd0s36FyzvbEQNewyjvKTjnEUkZ3bW42b8GcQP8m/
         kDeQ==
X-Gm-Message-State: ACrzQf0Rd9vPaTB0U05IDfKZ5R7efb27sq4mOXVPUdnaHm8K376uey/R
        4ruMhiSYS6wBipuT0VstPQ==
X-Google-Smtp-Source: AMsMyM5DO/1XqMmBZ2bNaxOTQmx8u0/IZ2EubMZ0oerO/KAUsl3l/boidddsW0tbhwz3X62yEzFqww==
X-Received: by 2002:a05:622a:40d:b0:397:bd61:ef1d with SMTP id n13-20020a05622a040d00b00397bd61ef1dmr35514956qtx.404.1667694639370;
        Sat, 05 Nov 2022 17:30:39 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a0d4e00b006eef13ef4c8sm2960643qkl.94.2022.11.05.17.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 17:30:38 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:56b3:6d0f:b2b0:c9a9])
        by serve.minyard.net (Postfix) with ESMTPSA id F14E8180044;
        Sun,  6 Nov 2022 00:30:36 +0000 (UTC)
Date:   Sat, 5 Nov 2022 19:30:35 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH] ipmi/watchdog: Include <linux/kstrtox.h> when appropriate
Message-ID: <Y2cAKyqilb7v9tFi@minyard.net>
Reply-To: minyard@acm.org
References: <37daa028845d90ee77f1e547121a051a983fec2e.1667647002.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37daa028845d90ee77f1e547121a051a983fec2e.1667647002.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:16:54PM +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, in order to eventually remove <linux/kernel.h> from <linux/watchdog.h>,
> include the latter directly in the appropriate files.

This is in my queue.  Thanks.

-corey

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 5b4e677929ca..47365150e431 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -23,6 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/completion.h>
>  #include <linux/kdebug.h>
> +#include <linux/kstrtox.h>
>  #include <linux/rwsem.h>
>  #include <linux/errno.h>
>  #include <linux/uaccess.h>
> -- 
> 2.34.1
> 
