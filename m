Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2069E688AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjBBXaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjBBXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:30:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99B4ED9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:30:41 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so3567185plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qIEFf4lkuaAJ41hgeWHLq+ZKzYMe5b/e69F8YhSfjI=;
        b=j39QsNfUTd1EBZ3W48xVXAEh1RrDL4eVrnVKtQ1+n7HswprcJi5w/CW5l8+EvxX+Wy
         ghEHlPYOINFHqnuPCSCJXazJQoZyXiCPpnfsWWfIGS9szBz7KuYj+Gx2oykfAMsUF9Dj
         mY+4t9jU8ORGzY+3cMjOZwtImgLFu/s9wU48cbSPcbYeP6yt1SiSo9iBCj6I9ASPoQFX
         Uwt8tYx2ULnUqQ3CoV1ZPk9FMaVh4WnTdlD93J20Ql3SmPJBDZs7O4JEDtTyN7E/hUKW
         bpa9GltOnbpMWgmiolxHKaZqi/GwAW6DVhLzWpy+s2L+t1s8O81rdwi4Sq7x8n0LhePP
         /+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qIEFf4lkuaAJ41hgeWHLq+ZKzYMe5b/e69F8YhSfjI=;
        b=rr7B88Jt+X84VKbsPCfDtvOR2OKb7pxe57sV09TZIXBCCRsDhwerNf85QowjAlqPEz
         amiXjz8AmrVjFINXd/oMg8+TLgMZYAcaGO0fZvQmJY3LhyFpwF3nKnO2O7zgzf9dUhjg
         Q7WX+qbq52aiJ3PZ9u0ru/CvUjw8AwaUje1287Ti1vhX6q5/CRat97dmmI9QjTy+s3p7
         CUF6G+LgMMYiiyELNoS3Tku42TRQr2n6B3AH1BbAKUsBQX/IgUYPUPtHUKORpppELrjG
         J8JkhdUnvSiQua2675AlmXSALit+edJtgHgJ6Ntcf/D9YQRPR+BqwKm12/taiZsnXapN
         c8bw==
X-Gm-Message-State: AO0yUKXACfGC8gih8aMxa5GqkJBOedp7wgqhFkkpqD0JTvjVmByekxLK
        z70Gtsy/sKadXCC3kTW6vQ4=
X-Google-Smtp-Source: AK7set+NJTP0qUDL+M6Eqoexnv7grgn5vgBxeXVgON1Am0uoQL7AQgraRSw4/++WfiRasx2/qMSvzA==
X-Received: by 2002:a17:902:dccb:b0:18f:a27c:fe with SMTP id t11-20020a170902dccb00b0018fa27c00femr6694377pll.55.1675380641171;
        Thu, 02 Feb 2023 15:30:41 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b00196519d8647sm233544plc.4.2023.02.02.15.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:30:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 13:30:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Koutny <mkoutny@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/5] workqueue: Warn when a new worker could not be created
Message-ID: <Y9xHnwG39IHN/BBu@slm.duckdns.org>
References: <20230201134543.13687-1-pmladek@suse.com>
 <20230201134543.13687-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201134543.13687-3-pmladek@suse.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 01, 2023 at 02:45:40PM +0100, Petr Mladek wrote:
> +static __printf(2, 3) __cold
> +void __print_create_worker_failure(long err, const char *fmt, ...)
> +{
> +	spin_lock_irq(&create_worker_failed_lock);
> +
> +	/*
> +	 * Report potentially repeated failures only once during a stall.
> +	 * Otherwise, it might be noisy. Also slow serial console drivers
> +	 * touch watchdogs so that more frequent messages would prevent
> +	 * reaching the watchdog thresh.
> +	 */
> +	if (!create_worker_failed) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		vprintk(fmt, args);
> +		va_end(args);
> +	}
> +
> +	create_worker_failed++;
> +
> +	spin_unlock_irq(&create_worker_failed_lock);
> +}

That's pretty elaborate. Why not just use printk_ratelimited()?

> @@ -1931,12 +1992,16 @@ static struct worker *create_worker(struct worker_pool *pool)
>  
>  	/* ID is needed to determine kthread name */
>  	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		print_create_worker_failure("workqueue: Failed to allocate a pool ID", id);
                                                                             ^
									  worker ID?

> @@ -5880,8 +5950,10 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
>  
>  	rcu_read_unlock();
>  
> -	if (lockup_detected)
> +	if (lockup_detected) {
> +		print_create_worker_failed_num();
>  		show_all_workqueues();
> +	}

I'd just use printk_ratelimited() and leave it at that.

Thanks.

-- 
tejun
