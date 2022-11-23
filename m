Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6496368E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239733AbiKWSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiKWSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F698C6BE5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:30:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED55761E72
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DA2C433D6;
        Wed, 23 Nov 2022 18:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669228204;
        bh=iweL2aDbJf3VIwboPkUdWl1ze6PxOkV2Y7EBjVVkALQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0PIhmCI0MpwYc6EBIcoQeFERPqsjU0tx2Q4evCBLCGyfgsrjTuHX5YnFZe4mxs7E
         BfaKbKGZ7LH7G77gRXeR2BBKKkXNE4nNd8QvDxIgPvpIX1dY8aWhwx2QZz+Z8FUoTC
         JkEqpOgbM/ShM2MBaUUQGq6WUN/tD5sSkn/d47I4=
Date:   Wed, 23 Nov 2022 19:30:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y35mqfhdIxnDvCn4@kroah.com>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109120415.55759-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:04:15PM +0800, Chengming Zhou wrote:
> syzbot found a lockdep warning in kernfs_find_and_get_node_by_id(),
> bisected to the commit c25491747b21 ("kernfs: Add KERNFS_REMOVING flags"),
> which didn't hold kernfs_rwsem before call kernfs_active(kn).
> 
> Since kernfs_find_and_get_node_by_id() doesn't have to get active count
> of kn, only need to get a stable refcount of kn, so it should be enough
> to just check kn has been KERNFS_ACTIVATED.
> 
> Reported-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
> Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/kernfs/dir.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 6acd9c3d4cff..08f0f1570cd7 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -705,7 +705,13 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
>  			goto err_unlock;
>  	}
>  
> -	if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
> +	/*
> +	 * ACTIVATED is protected with kernfs_mutex but it was clear when
> +	 * @kn was added to idr and we just wanna see it set.  No need to
> +	 * grab kernfs_mutex.
> +	 */
> +	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
> +		     !atomic_inc_not_zero(&kn->count)))
>  		goto err_unlock;
>  
>  	spin_unlock(&kernfs_idr_lock);
> -- 
> 2.37.2
> 

Is this still needed in 6.1-rc6?

thanks,

greg k-h
