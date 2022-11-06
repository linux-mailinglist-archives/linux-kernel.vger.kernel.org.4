Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C165661E660
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKFVP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:15:23 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D76417
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:15:21 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1322d768ba7so10851168fac.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwkxxBKJ7V4EqKvtrPeC8yM9Dv+8XRyEgUtVEOcFIt8=;
        b=dN3/8QVDoJiMJnNCeIPmqfVDojGcocS0q52h6RG81w1aGbbYg9xGc9faf4UaSWtYrY
         dm0Jsn6yGwXOWOFaNAukJaBN8lpuvUDkf4/UVaFwYeffX0ru0l2yNyzrc24ewR/J6bII
         I5bzVW36FQH546dGU3Ol9UlbHjza5HiRUyRgN+aJ6MEaBZUO8D1zgoP6G8LrSbV0v8fb
         yWuEi8AU5QFhEKbwpMvHuixqN2bRGeVcWm7UNZqf36txmqPB3J1RKUKxx2w+qcthsGsJ
         cVIYnclkyiZDbQmA9oSkoK5ff3MA87GLQb0J32tV98CCR5LIGNUNaQDHrRghyLaAZBP4
         Vehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwkxxBKJ7V4EqKvtrPeC8yM9Dv+8XRyEgUtVEOcFIt8=;
        b=HALyjMotiVhq5H7uu/2Ch3KO9lwOSkqXoxrIm+pNibOyAoWtxwVoqtvQxEH2+PJm5M
         oqZn0mxT41Tl5bw/kjNBj9ICCvGpaN3Y3VR6NzwNOcLngWoMmiGWgEfH16R8KZlnCVzg
         0/uMv+Vw3kcP4nS9bTfOBRh+z81d2whRn+g0b26NUUjDijv8KeUZKw1zjKvnFvhMtSFI
         Fwb4ap3ToehefcO6Air4CE5Im7AXJplPw3fg10GGrolcd4el71R82MxZLNIdRlzRj6dF
         rwb9VoLlk+iJ5XDGS0EOJffB5HcgyiCNyXEN68cDyMfLlMUEBB6oyoVSMI2fjreNrbVR
         dTsA==
X-Gm-Message-State: ACrzQf2/3XsxXKuqxyoRJ/4g7XzfxDE3AeXkFIXJsCIVOOG854JTOREo
        7Te02oQ1kNtjN2NpHKm5taw=
X-Google-Smtp-Source: AMsMyM7/mSCOuCAnAZeuUPxF7Ql4Qqg9kNYayhJxC/gWDJHFslWFDzS0DZzzfVfILj9MOmLGlKHcXw==
X-Received: by 2002:a05:6870:b295:b0:13a:f1f2:c433 with SMTP id c21-20020a056870b29500b0013af1f2c433mr37377343oao.257.1667769320659;
        Sun, 06 Nov 2022 13:15:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i5-20020a4aab05000000b0049ded99501bsm1625311oon.40.2022.11.06.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:15:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Nov 2022 13:15:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
Message-ID: <20221106211518.GA162439@roeck-us.net>
References: <20221106054535.709068702@goodmis.org>
 <20221106054649.099333291@goodmis.org>
 <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
 <20221106160956.2414d73f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106160956.2414d73f@rorschach.local.home>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 04:09:56PM -0500, Steven Rostedt wrote:
> On Sun, 6 Nov 2022 12:51:46 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Thanks, this looks reasonable.
> > 
> > On Sat, Nov 5, 2022 at 10:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > The coccinelle script:
> > >
> > > @@
> > > expression E;
> > > identifier ptr, timer, rfield, slab;  
> > 
> > I think Julia suggested making 'ptr' be an expression too, and I think
> 
> And I forgot to add Julia to the Cc :-/
> 
> > she's right. Probably 'slab' should be too - there's no reason to
> > limit it to just one identifier.
> > 
> > >   ... when strict
> > >       when != ptr->timer.function = E;  
> > 
> > I suspect any "ptr->timer" access anywhere between the
> > del_timer_sync() and the freeing should disable things.
> > 
> > Although hopefully there aren't any other odd cases than that one
> > "clear timer function by hand" one.
> 
> OK, I did the following with this new script:
> 
> $ cat timer.cocci
> @@
> expression E,ptr,slab;
> identifier timer, rfield;
> @@
> (
> -       del_timer(&ptr->timer);
> +       timer_shutdown(&ptr->timer);
> |
> -       del_timer_sync(&ptr->timer);
> +       timer_shutdown_sync(&ptr->timer);
> )
>   ... when strict
>       when != ptr->timer.function = E;
> (
>         kfree_rcu(ptr, rfield);
> |
>         kmem_cache_free(slab, ptr);
> |
>         kfree(ptr);
> )
> 

Same modified script, same results. I am curious, though:

> --- a/net/netfilter/xt_IDLETIMER.c
> +++ b/net/netfilter/xt_IDLETIMER.c
> @@ -413,7 +413,7 @@ static void idletimer_tg_destroy(const struct xt_tgdtor_param *par)
>                 pr_debug("deleting timer %s\n", info->label);
>  
...
> @@ -441,7 +441,7 @@ static void idletimer_tg_destroy_v1(const struct xt_tgdtor_param *par)
>                 if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
>                         alarm_cancel(&info->timer->alarm);

Does that mean something similar may be needed for alarms ?

>                 } else {
> -                       del_timer_sync(&info->timer->timer);
> +                       timer_shutdown_sync(&info->timer->timer);
>                 }
>                 cancel_work_sync(&info->timer->work);
>                 sysfs_remove_file(idletimer_tg_kobj, &info->timer->attr.attr);
> 
> 
> Which all look legit.
> 
I checked as well and agree.

Guenter
