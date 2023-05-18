Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76635708435
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjEROs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjEROsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41F2E0;
        Thu, 18 May 2023 07:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C08E64FD0;
        Thu, 18 May 2023 14:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10FEC433D2;
        Thu, 18 May 2023 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421302;
        bh=6hR6nJQ/Rih7qcH8pK2O1ZFy9hlR/TAHBgBtNcu7FWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzPN06K6wY4jUnyFcdlQfXm49l3Kc07uQK6Fd0nUEwzfmoBTM+my690NoDHWutUU9
         Dc/6B0dZauOlRIXgEC6N8EnaGagCAajWeZ7gAsTbI7n3/ZDwNE3PT2teJXeuvCTITK
         b0fLyo+bynqzFSzy4a0BcalMIr72hgd30izCLJtdT3hkNPsZv6YA+PWEYYQl8DCH6W
         ZuI9z0J68WVR5V8SEZcdo7+Q+oharCrRF32tLcLw6Tnk24Y+OfqoPREuyDTKA1cqBZ
         z4VgzU8Wqh1hofsZNZRgoAlQqJbQ8r56z9Y8g7Cgq03+v8qxs3OItGKsEVPXmLkN4s
         ZkxL2Nh1FdWFQ==
Date:   Thu, 18 May 2023 16:48:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pid: Replace struct pid 1-element array with flex-array
Message-ID: <20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner>
References: <20230517225838.never.965-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517225838.never.965-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:58:42PM -0700, Kees Cook wrote:
> For pid namespaces, struct pid uses a dynamically sized array member,
> "numbers". This was implemented using the ancient 1-element fake flexible
> array, which has been deprecated for decades. Replace it with a C99
> flexible array, refactor the array size calculations to use struct_size(),
> and address elements via indexes. Note that the static initializer (which
> defines a single element) works as-is, and requires no special handling.
> 
> Without this, CONFIG_UBSAN_BOUNDS (and potentially CONFIG_FORTIFY_SOURCE)
> will trigger bounds checks:
> https://lore.kernel.org/lkml/20230517-bushaltestelle-super-e223978c1ba6@brauner
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: syzbot+ac3b41786a2d0565b6d5@syzkaller.appspotmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/pid.h    |  2 +-
>  kernel/pid.c           | 13 ++++++++-----
>  kernel/pid_namespace.c |  2 +-
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index b75de288a8c2..653a527574c4 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -67,7 +67,7 @@ struct pid
>  	/* wait queue for pidfd notifications */
>  	wait_queue_head_t wait_pidfd;
>  	struct rcu_head rcu;
> -	struct upid numbers[1];
> +	struct upid numbers[];
>  };
>  
>  extern struct pid init_struct_pid;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index f93954a0384d..f5008146e2e4 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -131,7 +131,7 @@ void free_pid(struct pid *pid)
>  
>  	spin_lock_irqsave(&pidmap_lock, flags);
>  	for (i = 0; i <= pid->level; i++) {
> -		struct upid *upid = pid->numbers + i;
> +		struct upid *upid = &pid->numbers[i];
>  		struct pid_namespace *ns = upid->ns;
>  		switch (--ns->pid_allocated) {
>  		case 2:
> @@ -265,7 +265,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  	init_waitqueue_head(&pid->wait_pidfd);
>  	INIT_HLIST_HEAD(&pid->inodes);
>  
> -	upid = pid->numbers + ns->level;
> +	upid = &pid->numbers[ns->level];
>  	spin_lock_irq(&pidmap_lock);
>  	if (!(ns->pid_allocated & PIDNS_ADDING))
>  		goto out_unlock;
> @@ -285,7 +285,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  out_free:
>  	spin_lock_irq(&pidmap_lock);
>  	while (++i <= ns->level) {
> -		upid = pid->numbers + i;
> +		upid = &pid->numbers[i];
>  		idr_remove(&upid->ns->idr, upid->nr);
>  	}
>  
> @@ -656,8 +656,11 @@ void __init pid_idr_init(void)
>  
>  	idr_init(&init_pid_ns.idr);
>  
> -	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
> -			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> +	init_pid_ns.pid_cachep = kmem_cache_create("pid",
> +			struct_size((struct pid *)0, numbers, 1),
> +			__alignof__(struct pid),
> +			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT,
> +			NULL);
>  }
>  
>  static struct file *__pidfd_fget(struct task_struct *task, int fd)
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index b43eee07b00c..ebb20091a9da 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -48,7 +48,7 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>  		return kc;
>  
>  	snprintf(name, sizeof(name), "pid_%u", level + 1);
> -	len = sizeof(struct pid) + level * sizeof(struct upid);
> +	len = struct_size((struct pid *)0, numbers, level + 1);

Having this open-coded is a bit ugly tbh, especially the visible cast
to 0. But fine we can probably live with this since it's really only
localized to this file.
