Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8564E082
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiLOSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLOSSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:18:08 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA547314
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:18:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id md9-20020a17090b23c900b00218fa3308a9so6172335pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zYd8pjM+h9ZXywEkUSyHttrKqV0HoqJqNzSbDuyoPU=;
        b=QEecPBb/5PjJcWOAy10Z7ojCqt+SK1vQNF17KM+NZE4XAeHuudIMyBAP5bZoCg4SfS
         zq8wQjHHa0IE8Y7IHsQVhfTw2IEXrOqTCQzZYXUOT4QNgJlewLWLijpZlDp56GIU4CAH
         Z5+Yk474Fhto01x4AIjhTig4Hr0kw27aL2RNBhzM27TUvoiYBxWXmbgk4Os4G7SVibJl
         Yiy14r5WEKWK7TLITUwQ6PdLDah3yXbJb4EYyB42AFzq/FbZAre5xEBJrlO69bIL9B6F
         erJ5Nj7adcQ25emu3FWWjJjAI+wWAAs0e29AR3ra2OiHhxHXKUVhmu7G23HHnbNxAXBC
         ADnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zYd8pjM+h9ZXywEkUSyHttrKqV0HoqJqNzSbDuyoPU=;
        b=p3RYVLwKgYyUKOtFNuzjAhPqMf7QKXfyJn00KN2BTyMZ8ZVwGU+mGIEj+DE5EHk7Ap
         ery+aSbRM4xFpUkX9+kplPzhS8w0fe3xjEWRf3FbfLMLuOsI+bklkONxXQph+RN60wQa
         PAD48LXL+nIREZnAmAHNRo6l3gIW4oYzgBwIALwh60xS723srwBY+09E6tHBLOQ1YPYe
         Q9Mi/uQloYamE3J3N5Vdar1Hw9c7ZX0UAKQS0a9MPngvbgtnAdaUpE4cGbJ7lEcBGanM
         DBzzwi8Aw8RnmV+1Meu/qn9vGfuBhxHo+NC4Tao0YFOu+B3hvupvSlQTj9kQ5jPHWi9D
         ZI4g==
X-Gm-Message-State: ANoB5pmZEb3bFltHDKNS2n4Q5Vw3eBZxCJnE4dmOL6mkJdGUP4X8IHdb
        4uaMEByNHNplNbnR3tLopwaEN+s/HrbEwg==
X-Google-Smtp-Source: AA0mqf5jnzmQSpwE0GvclzeEATSymmXibKDumwzmrbSfLhBcsjQyxZITSBd/SenLherKv8wSZEHbd0GBjsUZSA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:aa7:9acc:0:b0:577:81cb:4761 with SMTP id
 x12-20020aa79acc000000b0057781cb4761mr8441913pfp.46.1671128287622; Thu, 15
 Dec 2022 10:18:07 -0800 (PST)
Date:   Thu, 15 Dec 2022 18:18:03 +0000
In-Reply-To: <20221215091907.763801-1-haifeng.xu@shopee.com>
Mime-Version: 1.0
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
Message-ID: <20221215181803.ome46pkh6g7qu3t4@google.com>
Subject: Re: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
From:   Shakeel Butt <shakeelb@google.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
> The memory events aren't supported on root cgroup, so there is no need
> to account MEMCG_OOM_KILL on root memcg.
> 

Can you explain the scenario where this is happening and causing issue
for you?

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  include/linux/memcontrol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 567f12323f55..09f75161a3bc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1142,7 +1142,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> -	if (likely(memcg))
> +	if (likely(memcg && !mem_cgroup_is_root(memcg)))

Even if we need this additional check, this is not the right place.

>  		memcg_memory_event(memcg, event);
>  	rcu_read_unlock();
>  }
> -- 
> 2.25.1
> 
