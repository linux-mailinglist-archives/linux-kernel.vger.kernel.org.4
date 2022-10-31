Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08122613DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJaStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJaStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:49:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41FBD2C8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so6654476pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7OCJ+L+xgAJwntbzzIY7jIEAB6GsC4e1YXzlRewDDY=;
        b=pkxGvmKZlfL1s4XFqRlTdmcQB8M6i8TS9MxG7lT1TGTaArCpnIDnwjS4VMZpmeoLhk
         qGjJTp21+qSVHQ8t0Il+zMl1hFW59sX1LaKBMtQvviLmQhkLrhGP0gFdRYKWoC/x0UHw
         OcKblEgkYJbSi7p9hYIUueVRf/hA3KI/MgJP7VuCvmDZWfgXYqrJlr9YSrmOW6QuyBG+
         hHyeDpT6Ey7KdMuiJa50dad9pJBHatI75ayDPXvcGbTdCRWlbqIsUcRThiqBe7E/CyrU
         ib06bsvWgndnrIyPZWP1ogK1jfNlTEiRVd//AQdUZr/sNd6mJBOsYKXFI0bznLX7qwI9
         7zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7OCJ+L+xgAJwntbzzIY7jIEAB6GsC4e1YXzlRewDDY=;
        b=eqWSBTftURvcqjnlw3kQdobAij5tWb8FA4yY2nDLr6Kn/WWh7mnTULYGwRvxoXa9a1
         OlSq+hIC5QbEWg6rNlunaUxbnYV8FU90kqSC1AKJbKqtwwHEZt89TTWxnqHGsupi0EUU
         x/HDK/bj765f5pgJ5BtOididWp1VdCWZ2MmOf7TcdfKWvQh3Ht3qriu/k4aARpALCfAa
         G/25fthCi5fL7Ts9uNt0zp5iT/snpW+FKI1XD1ekTdv1wN6ks/6bDU4CfCv/s2Xku7AL
         u/qhycXU4DpxV3Ch9XvDYuO8GSR+g+2fmFyJuTQLA6AC1kh87+5scISAiYWis1/OIC9i
         vIlQ==
X-Gm-Message-State: ACrzQf1grydw7Ym47CpWMSuKWTDlvfH5JspwBvjBZRr3bm5AoXfxa5ZG
        l3kBZ9g1ornwfOAeXMBTABI=
X-Google-Smtp-Source: AMsMyM5f00sdEqaNBai09DERNEWeZnxN1bCdvSJngdGh5/ui/xSMeFxG1ata3lOqQ5OHLx2J/TsbEQ==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr15194505plh.41.1667242158267;
        Mon, 31 Oct 2022 11:49:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001865c298588sm4732870pll.258.2022.10.31.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:49:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 08:49:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 3/4] workqueue: Convert the idle_timer to a
 delayed_work
Message-ID: <Y2AYrG8q+I3VhHoF@slm.duckdns.org>
References: <20221004150521.822266-1-vschneid@redhat.com>
 <20221004150521.822266-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004150521.822266-4-vschneid@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 04, 2022 at 04:05:20PM +0100, Valentin Schneider wrote:
> +static void idle_reaper_fn(struct work_struct *work)
>  {
> -	struct worker_pool *pool = from_timer(pool, t, idle_timer);
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct worker_pool *pool = container_of(dwork, struct worker_pool, idle_reaper_work);
>  
>  	raw_spin_lock_irq(&pool->lock);
>  
>  	while (too_many_workers(pool)) {
>  		struct worker *worker;
>  		unsigned long expires;
> +		unsigned long now = jiffies;
>  
> -		/* idle_list is kept in LIFO order, check the last one */
> +		/* idle_list is kept in LIFO order, check the oldest entry */
>  		worker = list_entry(pool->idle_list.prev, struct worker, entry);
>  		expires = worker->last_active + IDLE_WORKER_TIMEOUT;
>  
> -		if (time_before(jiffies, expires)) {
> -			mod_timer(&pool->idle_timer, expires);

So, one thing which bothers me is that the idle timer is supposed to go off
spuriously periodically. The idea being that letting it expire spuriously
should usually be cheaper than trying to update it constantly as workers
wake up and sleep. Converting the timer to a delayed work makes spurious
wakeups significantly more expensive tho as it's now a full scheduling
event.

Can we separate the timer and work item out so that we can kick off the work
item iff there actually are tasks to kill?

Thanks.

-- 
tejun
