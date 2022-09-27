Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC25EB915
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiI0EDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiI0EDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:03:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FCAB049
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:03:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k12so5368156qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=RVeDgL58MZ/WnottLUU1JEd91S6UWqT1/tRkRRE+vRU=;
        b=epR5HFBd6WZTiwOoOcTrwHK0nEhccfHOmjrktKl+qtCLHJhx/SLK1MmYZ3OvETzJij
         pev/5Nb1gqOU4HW6sdBTnH9atIHmoj2azPRB7YdwF/suqrYlmAo9OCU2dvaXgrS6Kd9d
         lSPyYvcEcQV8rm51m3ZBG3ncAC9YyO/MK3Jb1OhehgT4WbZx6pjlEinKMhwBEQ4xBFGr
         UEwmeFcdVP90XwJLRbdqJLU7OKJVWzRdbtXkT1ZOcpNVcOVX45+3UKwP8oZYbebqKJt5
         25pWnsS9KSLMNSDrB49ymLwM4KHNAtgBV/4hDKJSyKXwISMg94qvubWiCcuOxbdMpx60
         8nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=RVeDgL58MZ/WnottLUU1JEd91S6UWqT1/tRkRRE+vRU=;
        b=HikU7Vkbt1Le57clqJen3LMuo0xWZvjpQdr5DL0S+x2kMgraTly9geRC38WtqMLq9E
         riopzYIfoqH9yUlM8zxLAy5mgzJr3QGt4PDThxwIlJdlGQzfye3YAwjIKDZFtsWm29lB
         vnsalArJb+4jueTSTBvtUNWrLk8sjkXxDOR2IOHO8iUkSLGnKz8d3Fc/JCUloCz7CGZE
         DEVZ3/msuoN9PA0iQ50K5LnNH+RsKpdoxZJwaplBp3owkUOeT2zcvP4EwFAU9r55+x+F
         xHcIanylPQKAEQWBqo6y/kvGb0zF7G4EON9Tb5Y8wZujmKvWewpJslo55S+lFILd1v0a
         VThw==
X-Gm-Message-State: ACrzQf3EdKSVA1kdGelTj+zKpLhFuDFX9SXFggjVTDcwqfEiDDjKSmJ7
        GA0sOhiLSH5UQKsk7YPH0bH6Ag==
X-Google-Smtp-Source: AMsMyM77iwhdwsmNPTD5cFhK59QYfl4INtPZKdjlZkZ+A9zp4HxaD9/Ek/bpbUMBsPNaS5INX4l2Ag==
X-Received: by 2002:a37:e107:0:b0:6ce:1a08:fbd8 with SMTP id c7-20020a37e107000000b006ce1a08fbd8mr16879136qkm.493.1664251400586;
        Mon, 26 Sep 2022 21:03:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b006bb78d095c5sm290319qkb.79.2022.09.26.21.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 21:02:31 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:02:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Hillf Danton <hdanton@sina.com>
cc:     Hugh Dickins <hughd@google.com>, Keith Busch <kbusch@kernel.org>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <20220924023047.1410-1-hdanton@sina.com>
Message-ID: <5880722-767c-16db-fc3-df50a12754b9@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com> <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <20220924023047.1410-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 24 Sep 2022, Hillf Danton wrote:
> 
> I think the lockup can be avoided by
> a) either advancing wake_index as early as I can [1],
> b) or doing wakeup in case of zero wait_cnt to kill all cases of waitqueue_active().
> 
> Only for thoughts now.

Thanks Hillf: I gave your __sbq_wake_up() patch below several tries,
and as far as I could tell, it works just as well as my one-liner.

But I don't think it's what we would want to do: doesn't it increment
wake_index on every call to __sbq_wake_up()? whereas I thought it was
intended to be incremented only after wake_batch calls (thinking in
terms of nr 1).

I'll not be surprised if your advance-wake_index-earlier idea ends
up as a part of the solution: but mainly I agree with Jan that the
whole code needs a serious redesign (or perhaps the whole design
needs a serious recode).  So I didn't give your version more thought.

Hugh

> 
> Hillf
> 
> [1] https://lore.kernel.org/lkml/afe5b403-4e37-80fd-643d-79e0876a7047@linux.alibaba.com/
> 
> +++ b/lib/sbitmap.c
> @@ -613,6 +613,16 @@ static bool __sbq_wake_up(struct sbitmap
>  	if (!ws)
>  		return false;
>  
> +	do {
> +		/* open code sbq_index_atomic_inc(&sbq->wake_index) to avoid race */
> +		int old = atomic_read(&sbq->wake_index);
> +		int new = sbq_index_inc(old);
> +
> +		/* try another ws if someone else takes care of this one */
> +		if (old != atomic_cmpxchg(&sbq->wake_index, old, new))
> +			return true;
> +	} while (0);
> +
>  	cur = atomic_read(&ws->wait_cnt);
>  	do {
>  		/*
> @@ -620,7 +630,7 @@ static bool __sbq_wake_up(struct sbitmap
>  		 * function again to wakeup a new batch on a different 'ws'.
>  		 */
>  		if (cur == 0)
> -			return true;
> +			goto out;
>  		sub = min(*nr, cur);
>  		wait_cnt = cur - sub;
>  	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> @@ -634,6 +644,7 @@ static bool __sbq_wake_up(struct sbitmap
>  
>  	*nr -= sub;
>  
> +out:
>  	/*
>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>  	 * responsible to reset wait_cnt regardless whether we've actually
> @@ -661,12 +672,6 @@ static bool __sbq_wake_up(struct sbitmap
>  	 */
>  	smp_mb__before_atomic();
>  
> -	/*
> -	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> -	 * callers can see valid wait_cnt in old waitqueue, which can cause
> -	 * invalid wakeup on the old waitqueue.
> -	 */
> -	sbq_index_atomic_inc(&sbq->wake_index);
>  	atomic_set(&ws->wait_cnt, wake_batch);
>  
>  	return ret || *nr;
