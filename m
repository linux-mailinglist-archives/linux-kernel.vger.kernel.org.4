Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5D6FE40A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjEJSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEJSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:33:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB73AA6;
        Wed, 10 May 2023 11:33:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab05018381so70950095ad.2;
        Wed, 10 May 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683743596; x=1686335596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrIXb3rILUjqnvJI4HytLruR+ZhwlVR0U+ngyl13d/M=;
        b=hjuAvVrfpmL/H0H10iA1qoTncoA35hxR+aek7S4OaTcoBf+bQ0sPb1SWBzecuMm1zQ
         df9dCHBFHhmDcgh/fj69sgMiehVUlVxQNdQV1ZNcChrEE9wXxP4BdqvIkP06Hsl7g+YT
         BHlQ7qUotnLF83loZP6JqyCC0+ITvyVamdy2klMSllNuH31Nf9vGk/EhHwX6AM3Oh8+5
         ot7OO61i+aPkmXTEFo9CbE74M8UzeIB/gDIu8YQGQ9KGjaEWlU45EDchn0G/qUmzH1Aa
         JnXaGcBFJjuaj2fMeKlPC+3K4mm7b2MUh2QDunxbUcvIMZy8R9IEfbdrp3uhyXBabBxU
         5cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683743596; x=1686335596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrIXb3rILUjqnvJI4HytLruR+ZhwlVR0U+ngyl13d/M=;
        b=gC93uD+3m63P3v2K1x3E0ZYukDV3ewYiOjKHIyuuEefhvfHqvIaGVx+xa2wbdGua9I
         XG1AlKz5WDytQ6AvuK7vg2IjRUzudPR23DLbFgUh4v0M7zxvV6XyW1dEuO3i7L9cI+m5
         NRAd9OXkVejkvkgWqdvj8PlkwKm58faFqtzByNeLk2YUu0SdvTFPm27PRuBbsGZDcdGZ
         2zuYSsJi9eGqlh98oJ6sFduZVOlKHayLXONm67dSkDZqyx5qb7ulUhZfnrhWBrDUc5IW
         O+ujinul0s9FJPlplBsjibCR8boxJEw32JdNHP+xiSsHRT5dAyp7u3ZzHxBtbDmExB24
         8fWg==
X-Gm-Message-State: AC+VfDxFphO/HSd4vLJkBD+rOPMcy9RjTrz8FyTXrHyplVqEs7Jag1tI
        7mrw0yMxMZXdXZN/jPAgjIg=
X-Google-Smtp-Source: ACHHUZ55UWFs88Sxg3YPoJJpSg4xVTGAaV1kZdUoQ43YkICgd72FxTV5FyoNPnRFiH+w+E2AGHIuhg==
X-Received: by 2002:a17:903:24e:b0:1ac:3b6f:c141 with SMTP id j14-20020a170903024e00b001ac3b6fc141mr22362262plh.11.1683743596265;
        Wed, 10 May 2023 11:33:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bh3-20020a170902a98300b00192aa53a7d5sm4155350plb.8.2023.05.10.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:33:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 08:33:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 1/4] workqueue: support pausing ordered workqueues
Message-ID: <ZFvjahvVPqWH0XBR@slm.duckdns.org>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
 <20230510175846.85cb30389c22.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510175846.85cb30389c22.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This looks great to me in general.

On Wed, May 10, 2023 at 06:04:25PM +0200, Johannes Berg wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b8b541caed48..418d99ff8325 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3863,10 +3863,16 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
>  	struct workqueue_struct *wq = pwq->wq;
>  	bool freezable = wq->flags & WQ_FREEZABLE;
>  	unsigned long flags;
> +	int new_max_active;
>  
> -	/* for @wq->saved_max_active */
> +	/* for @wq->saved_max_active and @wq->flags */
>  	lockdep_assert_held(&wq->mutex);
>  
> +	if (wq->flags & __WQ_PAUSED)
> +		new_max_active = 0;
> +	else
> +		new_max_active = wq->saved_max_active;

Nothing is using new_max_active and I think we can probably combine this
with the freezing test.

> +void __workqueue_pause_resume(struct workqueue_struct *wq, bool pause)
> +{
> +	struct pool_workqueue *pwq;
> +
> +	mutex_lock(&wq->mutex);
> +	if (pause)
> +		wq->flags |= __WQ_PAUSED;
> +	else
> +		wq->flags &= ~__WQ_PAUSED;
> +
> +	for_each_pwq(pwq, wq)
> +		pwq_adjust_max_active(pwq);
> +	mutex_unlock(&wq->mutex);
> +
> +	if (pause)
> +		flush_workqueue(wq);
> +}
> +EXPORT_SYMBOL_GPL(__workqueue_pause_resume);

I'd just make pause and resume separate functions. The sharing ratio doesn't
seem that high.

Thanks.

-- 
tejun
