Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4260321F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJRSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJRSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243BB7D1DE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666116970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bi3UXDoOhSvHYMSqV3f8cMz1Lx9Ymc9310FFrQMZwUI=;
        b=ZwpJ5my9SzlIOe48LEf0Sk4MU4lLY8lwcAOqjLAzpQOy/B+Q1DrwMqt+tWGkrJ1AYRD0/q
        8D0v1DjdAkZdd5DI2mJrOSbZUP3TVjBf5pVdfwLD3FYQB36izFLmQXQiqpzfG/acFxa8Yv
        XwgL7FRsGyIntBIBOJ4MxPcXO23KfPk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-8rXjhWObPGmBTtZAXX91wA-1; Tue, 18 Oct 2022 14:16:09 -0400
X-MC-Unique: 8rXjhWObPGmBTtZAXX91wA-1
Received: by mail-qt1-f197.google.com with SMTP id a19-20020a05622a02d300b0039a3711179dso11146562qtx.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi3UXDoOhSvHYMSqV3f8cMz1Lx9Ymc9310FFrQMZwUI=;
        b=10jvdWN/dDGX7GnuOGsFGnNB9o4S5rBxIZa9llTjzdi1mlCFePSMg74UZgHJDttYNh
         KWtPV81xNqxO7gO9XP29t5IZrDKG/x0SX9L1jyVdzy0FBTinuDNmmM81QepTtXd4QzRI
         7Ec+OYZVf8J00864PUe/4QVhrojcuziC9jOky+PZovcRI0kSMfWNyF6DQ+QBa+vP269W
         C1eLYL4AAnhQh+cQjK70PQr6Zith9Mh0RcmiFmeXN3utMcyMaG3JYsDpDBkCwOkv6cRf
         msasMQmG5xb0oZoNOMxIkfAMLr/FVAGID70ggWI467V9TemNcAkBSONRHJDTpq5vfFIj
         mvHQ==
X-Gm-Message-State: ACrzQf2jrQ5LsK2lQar9wxk3cVuyq9M+mPXqVGD5CQCl7PgtnfZwz5GY
        hWV07x06MTWhz0oHxXxnxdFjQkGbx2W7VeUQdXfVWVv725FaVdSA4FBz1zWf+sd/jGM+K1zT+LW
        HHCkDBsRrmpiOOoON8PY64h70
X-Received: by 2002:a05:620a:28cc:b0:6ee:78fe:c519 with SMTP id l12-20020a05620a28cc00b006ee78fec519mr2662244qkp.345.1666116968435;
        Tue, 18 Oct 2022 11:16:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6d4u1M/zEGDuoIdGOtQEacFeSPPDvdDif+5gVCutuLGU+ZanCMx8KVOkO4E3Z1LJgYHAmnMg==
X-Received: by 2002:a05:620a:28cc:b0:6ee:78fe:c519 with SMTP id l12-20020a05620a28cc00b006ee78fec519mr2662225qkp.345.1666116968200;
        Tue, 18 Oct 2022 11:16:08 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id l3-20020a37f903000000b006ee2953fac4sm2720759qkj.136.2022.10.18.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:16:07 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:16:10 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v3] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y07taqdJ/J3EyJoB@bfoster>
References: <20221018045844.37697-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045844.37697-1-ivan@cloudflare.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:58:44PM -0700, Ivan Babrou wrote:
> Many monitoring tools include open file count as a metric. Currently
> the only way to get this number is to enumerate the files in /proc/pid/fd.
> 
> The problem with the current approach is that it does many things people
> generally don't care about when they need one number for a metric.
> In our tests for cadvisor, which reports open file counts per cgroup,
> we observed that reading the number of open files is slow. Out of 35.23%
> of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
> `proc_fill_cache`, which is responsible for filling dentry info.
> Some of this extra time is spinlock contention, but it's a contention
> for the lock we don't want to take to begin with.
> 
> We considered putting the number of open files in /proc/pid/status.
> Unfortunately, counting the number of fds involves iterating the open_files
> bitmap, which has a linear complexity in proportion with the number
> of open files (bitmap slots really, but it's close). We don't want
> to make /proc/pid/status any slower, so instead we put this info
> in /proc/pid/fd as a size member of the stat syscall result.
> Previously the reported number was zero, so there's very little
> risk of breaking anything, while still providing a somewhat logical
> way to count the open files with a fallback if it's zero.
> 
> RFC for this patch included iterating open fds under RCU. Thanks
> to Frank Hofmann for the suggestion to use the bitmap instead.
> 
> Previously:
> 
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 0         	Blocks: 0          IO Block: 1024   directory
> ```
> 
> With this patch:
> 
> ```
> $ sudo stat /proc/1/fd | head -n2
>   File: /proc/1/fd
>   Size: 65        	Blocks: 0          IO Block: 1024   directory
> ```
> 
> Correctness check:
> 
> ```
> $ sudo ls /proc/1/fd | wc -l
> 65
> ```
> 
> I added the docs for /proc/<pid>/fd while I'm at it.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> 
> ---
> v3: Made use of bitmap_weight() to count the bits.
> v2: Added missing rcu_read_lock() / rcu_read_unlock(),
>     task_lock() / task_unlock() and put_task_struct().
> ---
>  Documentation/filesystems/proc.rst | 17 +++++++++++++
>  fs/proc/fd.c                       | 41 ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
...
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..439a62c59381 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -279,6 +279,31 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  	return 0;
>  }
>  
> +static int proc_readfd_count(struct inode *inode)
> +{
> +	struct task_struct *p = get_proc_task(inode);
> +	struct fdtable *fdt;
> +	unsigned int open_fds = 0;
> +
> +	if (!p)
> +		return -ENOENT;

Maybe this shouldn't happen, but do you mean to assign the error code to
stat->size in the caller? Otherwise this seems reasonable to me.

Brian

> +
> +	task_lock(p);
> +	if (p->files) {
> +		rcu_read_lock();
> +
> +		fdt = files_fdtable(p->files);
> +		open_fds = bitmap_weight(fdt->open_fds, fdt->max_fds);
> +
> +		rcu_read_unlock();
> +	}
> +	task_unlock(p);
> +
> +	put_task_struct(p);
> +
> +	return open_fds;
> +}
> +
>  static int proc_readfd(struct file *file, struct dir_context *ctx)
>  {
>  	return proc_readfd_common(file, ctx, proc_fd_instantiate);
> @@ -319,9 +344,25 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
>  	return rv;
>  }
>  
> +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> +			const struct path *path, struct kstat *stat,
> +			u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_inode(path->dentry);
> +
> +	generic_fillattr(&init_user_ns, inode, stat);
> +
> +	/* If it's a directory, put the number of open fds there */
> +	if (S_ISDIR(inode->i_mode))
> +		stat->size = proc_readfd_count(inode);
> +
> +	return 0;
> +}
> +
>  const struct inode_operations proc_fd_inode_operations = {
>  	.lookup		= proc_lookupfd,
>  	.permission	= proc_fd_permission,
> +	.getattr	= proc_fd_getattr,
>  	.setattr	= proc_setattr,
>  };
>  
> -- 
> 2.37.3
> 

