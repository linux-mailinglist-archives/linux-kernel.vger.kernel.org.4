Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E0680F37
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjA3NnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjA3NnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:43:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871069EE5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:43:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mf7so13088613ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDPn44BeAHxZKOTUZDOsKOvKzPPbsKRicdKnFkutGSs=;
        b=KkOIolv7vz8zPBu47iB5hQbKRMdTq2W6IeqYYqTAJ4Kvh8/tHKDfbQ++11ihBqV6O8
         XA2mU3sI2Ia8m+HGBq7CDGIsh1m7qfldALQRjJm+Sy5AF0kL2h1D68sMm4Ab/8OIzMu1
         kCQZSDU94GC11KeFVfr792ToEcBppL7JQn/MAbsb57QlDVDK4MpmcqtIM9sX5VWCfJYB
         1dbt6vG29w6jQL3ujLnRpQpGHsYbYL9FKcCETuDIEJR0l1d+CzDHKrj+kuD3RL5SXEi4
         N2UTU9VGF1SuXtlI0CjiHtMhueFZ2KLjUw+WM+ged3XNLA+XUHlrXOsmI27Dd64IyAIG
         wzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDPn44BeAHxZKOTUZDOsKOvKzPPbsKRicdKnFkutGSs=;
        b=AqK1oJ1aGe20He+g1NUZyfcFQwtqVfHvOjJf9E1O8vnYt2BxD/R7Ocq0kciw04ZiTL
         fY9YFRYtCTwoEephm9w6HQbMWbZw9865IjX5bviXHehem0ZwhnmG6LKjyeXkuAsxocr7
         p8xjRcdii5sNISPd9MjaeUewwrBJ0QNez+LPv4dl6R4LKtQEGufENpQFUm4h09yI/Ld6
         y1k9qvlsuVavJ5YmZJBvUEXNhXna8mMSC6NEnSztKImL8u+beF2OEr7MZzpZKhzphRkA
         p34pfRUs82BRiGx48gmfZ5o8g69+2kIrQ8ffiyc42Xtd6/W6ISxooWusqm0t/tnsqAbh
         mK4w==
X-Gm-Message-State: AO0yUKUz8qToSnU5VueqmhKQG4pFzr1KlDbOo2ggkJ+SHh2cKTZnb19x
        vlB5s2oWkm+7qloV015nctI=
X-Google-Smtp-Source: AK7set9NwCqZxXn2P0I1LTRGaCVgmrHQ+HW9RGNXgt4RkbJA48YgTw2Obpk0zPgDRQmrJgZnJSr0/g==
X-Received: by 2002:a17:906:4793:b0:87b:db62:d659 with SMTP id cw19-20020a170906479300b0087bdb62d659mr13583848ejc.19.1675086185991;
        Mon, 30 Jan 2023 05:43:05 -0800 (PST)
Received: from gmail.com ([31.46.245.95])
        by smtp.gmail.com with ESMTPSA id os25-20020a170906af7900b008874c903ec5sm2350495ejb.43.2023.01.30.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 05:43:05 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 30 Jan 2023 14:43:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: pick_next_rt_entity(): checked list_entry
Message-ID: <Y9fJZdMYbc4gRVJ+@gmail.com>
References: <20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Pietro Borrello <borrello@diag.uniroma1.it> wrote:

> Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> removed any path which could make pick_next_rt_entity() return NULL.
> However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
> pick_next_rt_entity()) still checks the error condition, which can
> never happen, since list_entry() never returns NULL. Return
> list_first_entry_or_null(queue, ...) to allow BUG to check the only
> possible error condition here: the queue being empty which should
> never happen.
> 
> Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  kernel/sched/rt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index ed2a47e4ddae..6088d5d83b75 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1777,7 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  	BUG_ON(idx >= MAX_RT_PRIO);
>  
>  	queue = array->queue + idx;
> -	next = list_entry(queue->next, struct sched_rt_entity, run_list);
> +	next = list_first_entry_or_null(queue, struct sched_rt_entity, run_list);
>  
>  	return next;

I'd much rather have something like this:

	SCHED_WARN_ON(list_empty(next));

So the debug check is part of CONFIG_SCHED_DEBUG=y, and not if it's turned 
off. Also, this makes sure we don't crash (BUG_ON()) on the error 
condition, in the hope of getting debug info out of the system.

Thanks,

	Ingo
