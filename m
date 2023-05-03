Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376986F4FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECFh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:37:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3171FED
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 22:37:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24de62e16bcso864476a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683092250; x=1685684250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JjfdBQKWddesiz0zBd3Yea5rtI42XolSs6tsa7a6CQ=;
        b=V1QMUS+w5m2iMUhnryEXJQ5hp9bWG/4XNDAaVB2El7xdM3hJHGy6eRVOkalz+KHwc/
         Af5z8C9M2URn1pZS02/6bGs6FFJ4BAW43OXNu/NLFfllx6WRqoD7CvGIyXccGllkM7RB
         hrEcf+iHl6uoB+b06GO1Ax84xWwruvbirJ3RAg2VliGDpjHgsDd0Pb47nmmJsWZb0aN1
         M7ja5Sm+6uTpKzeCpnLTjS29GjuEm2uQFutjg3Tyx8+GJMbxsme2kVd6SNkY2ZwQrG4H
         /HX4TUulFwn0sTJP0n17GwomkX9JyULs4RW5q6zc4j6gUGOhUdJ/qFnnPEJI+1n+ye0V
         ezOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683092250; x=1685684250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JjfdBQKWddesiz0zBd3Yea5rtI42XolSs6tsa7a6CQ=;
        b=HmeflDKmpEBR3Yt+tYfnQp14F7iL33JRcuiog3h+7bhMMdGg8rnxafmltWNxE/XYwW
         KWWZaOq9kBkSybv8ZQwRVDR2n4QFXIP+dc/uy46siHXRiQe3quFBeisP4eqr3B2KfjBd
         9BpnG1mz0Mg0PoqTKUzEnjW2DLJ1+opIIw3qInBENQwmnA8s1q3DZwsABmh0QTJMZuRx
         uDo1+FwS3sihWOx/2eCBhgKWZX3abQjqW38HhE4bsQ/miskaCWU1VmrNZRPG9DXoZIAO
         z9mSdtabrNPh7qJ0pCZI7//0LxrkRx4b/HYmBWP7iKNsXQK7CsBWXM1+hdyu+ucMAuNj
         xSfA==
X-Gm-Message-State: AC+VfDyLqbglYqnYSfcj8qHNtldIdDTg3SV2ywz3PcqIS+cIc0EfZNnd
        +L+/PvpxzQMW3DTRi4dYu7DSTQ==
X-Google-Smtp-Source: ACHHUZ6kDods6gEgJFoH7bX+YnxyPHYhCydB3iUVz0hDb0R+q/Ryzifl1cM52GauicIloxTHuP1brg==
X-Received: by 2002:a17:90a:348:b0:246:fbef:790e with SMTP id 8-20020a17090a034800b00246fbef790emr4495489pjf.3.1683092249854;
        Tue, 02 May 2023 22:37:29 -0700 (PDT)
Received: from [10.200.9.60] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id cf17-20020a17090aebd100b0022be36be19asm2283850pjb.53.2023.05.02.22.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 22:37:29 -0700 (PDT)
Message-ID: <2d44a1bd-eb80-7724-ff4e-a0fc3bfd8b72@bytedance.com>
Date:   Wed, 3 May 2023 13:37:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: shrinkers: fix race condition on debugfs cleanup
Content-Language: en-US
To:     =?UTF-8?Q?Joan_Bruguera_Mic=c3=b3?= <joanbrugueram@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230503013232.299211-1-joanbrugueram@gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230503013232.299211-1-joanbrugueram@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/3 09:32, Joan Bruguera Micó wrote:
> When something registers and unregisters many shrinkers, such as:
>      for x in $(seq 10000); do unshare -Ui true; done
> 
> Sometimes the following error is printed to the kernel log:
>      debugfs: Directory '...' with parent 'shrinker' already present!
> 
> This occurs since commit badc28d4924b ("mm: shrinkers: fix deadlock in
> shrinker debugfs") / v6.2: Since the call to `debugfs_remove_recursive`
> was moved outside the `shrinker_rwsem`/`shrinker_mutex` lock, but the call
>   to `ida_free` stayed inside, a newly registered shrinker can be
>   re-assigned that ID and attempt to create the debugfs directory before
> the directory from the previous shrinker has been removed.
> 
> The locking changes in commit f95bdb700bc6 ("mm: vmscan: make global slab
> shrink lockless") made the race condition more likely, though it existed
> before then.
> 
> Commit badc28d4924b ("mm: shrinkers: fix deadlock in shrinker debugfs")
> could be reverted since the issue is addressed should no longer occur
> since the count and scan operations are lockless since commit 20cd1892fcc3
> ("mm: shrinkers: make count and scan in shrinker debugfs lockless").
> However, since this is a contended lock, prefer instead moving `ida_free`
> outside the lock to avoid the race.
> 
> Fixes: badc28d4924b ("mm: shrinkers: fix deadlock in shrinker debugfs")
> Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
> ---
>   include/linux/shrinker.h | 13 +++++++++++--
>   mm/shrinker_debug.c      | 15 ++++++++++-----
>   mm/vmscan.c              |  5 +++--
>   3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 7bde8e1c228a..224293b2dd06 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -107,7 +107,10 @@ extern void synchronize_shrinkers(void);
>   
>   #ifdef CONFIG_SHRINKER_DEBUG
>   extern int shrinker_debugfs_add(struct shrinker *shrinker);
> -extern struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker);
> +extern struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
> +					      int *debugfs_id);
> +extern void shrinker_debugfs_remove(struct dentry *debugfs_entry,
> +				    int debugfs_id);
>   extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
>   						  const char *fmt, ...);
>   #else /* CONFIG_SHRINKER_DEBUG */
> @@ -115,10 +118,16 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
>   {
>   	return 0;
>   }
> -static inline struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
> +static inline struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
> +						     int *debugfs_id)
>   {
> +	*debugfs_id = -1;
>   	return NULL;
>   }
> +static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
> +					   int debugfs_id)
> +{
> +}
>   static inline __printf(2, 3)
>   int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>   {
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 3f83b10c5031..fe10436d9911 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -237,7 +237,8 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>   }
>   EXPORT_SYMBOL(shrinker_debugfs_rename);
>   
> -struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
> +struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
> +				       int *debugfs_id)
>   {
>   	struct dentry *entry = shrinker->debugfs_entry;
>   
> @@ -246,14 +247,18 @@ struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
>   	kfree_const(shrinker->name);
>   	shrinker->name = NULL;
>   
> -	if (entry) {
> -		ida_free(&shrinker_debugfs_ida, shrinker->debugfs_id);
> -		shrinker->debugfs_entry = NULL;
> -	}
> +	*debugfs_id = entry ? shrinker->debugfs_id : -1;
> +	shrinker->debugfs_entry = NULL;
>   
>   	return entry;
>   }
>   
> +void shrinker_debugfs_remove(struct dentry *debugfs_entry, int debugfs_id)
> +{

It would be better to add a check:

	if (!debugfs_entry)
		return;

> +	debugfs_remove_recursive(debugfs_entry);
> +	ida_free(&shrinker_debugfs_ida, debugfs_id);
> +}
> +
>   static int __init shrinker_debugfs_init(void)
>   {
>   	struct shrinker *shrinker;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5bde07409303..c7d0faa343e0 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -805,6 +805,7 @@ EXPORT_SYMBOL(register_shrinker);
>   void unregister_shrinker(struct shrinker *shrinker)
>   {
>   	struct dentry *debugfs_entry;
> +	int debugfs_id;
>   
>   	if (!(shrinker->flags & SHRINKER_REGISTERED))
>   		return;
> @@ -814,13 +815,13 @@ void unregister_shrinker(struct shrinker *shrinker)
>   	shrinker->flags &= ~SHRINKER_REGISTERED;
>   	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>   		unregister_memcg_shrinker(shrinker);
> -	debugfs_entry = shrinker_debugfs_remove(shrinker);
> +	debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
>   	mutex_unlock(&shrinker_mutex);
>   
>   	atomic_inc(&shrinker_srcu_generation);
>   	synchronize_srcu(&shrinker_srcu);
>   
> -	debugfs_remove_recursive(debugfs_entry);
> +	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
>   
>   	kfree(shrinker->nr_deferred);
>   	shrinker->nr_deferred = NULL;

-- 
Thanks,
Qi
