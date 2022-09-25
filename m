Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9315E5E934D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIYNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D523BF7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 06:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA80613EF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 13:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F32C433D6;
        Sun, 25 Sep 2022 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664111613;
        bh=xI1MH4K5jKuCYe3uZod9HQefKR1LvfjnsEysg+QnaIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmjz4CxSCF2KNN8ekHgF9BobGafvVafCDzF4UA5cvLY5EXjmZZIiIjv+/xLGRycc3
         K+ugY2CAcz0gA8uWBD3yBIfp8Bnjsj4TikhNiOU313Hft1b2YVdP6/0qSB/1tV6AJn
         OBTJCJXeycs80R9y4OOi+OFwmXrLGKnT+96ZPahQ=
Date:   Sun, 25 Sep 2022 15:13:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] kernfs: fix UAF race condition in __kernfs_remove()
Message-ID: <YzBT+hJ/fmp75j1P@kroah.com>
References: <000000000000646c9605e714ec6e@google.com>
 <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 09:29:32PM +0900, Tetsuo Handa wrote:
> syzbot is reporting use-after-free read at __kernfs_remove() [1], for
> commit 35beab0635f3cdd4 ("kernfs: restructure removal path to fix possible
> premature return") missed that we need to keep a ref on "kn" as well as
> "pos".
> 
> This race condition happens when two concurrent removers "T1" and "T2"
> interfere due to kernfs_drain() temporarily dropping kernfs_rwsem.
> 
>   T1:                     T2:
>   down_write(&root->kernfs_rwsem);
>   do {
>     pos = kernfs_leftmost_descendant(kn);
>     kernfs_get(pos);
>     kernfs_drain(pos) {
>       up_write(&root->kernfs_rwsem);
>                           down_write(&root->kernfs_rwsem);
>                           do {
>                             // Removes all children and "kn", but won't
>                             // free T1's "pos" and "kn", for T1 has a ref
>                             // on T1's "pos", and T1's "pos" in turn keeps
>                             // a ref on "kn".
>                             pos = kernfs_leftmost_descendant(kn);
>                             kernfs_put(pos);
>                           } while (pos != kn) // Will break.
>                           up_write(&root->kernfs_rwsem);
>       down_write(&root->kernfs_rwsem);
>     }
>     // Frees "pos" because this was the last ref, and also frees "kn"
>     // because a ref by "pos" was gone (i.e. "kn" no longer has ref)
>     // via "goto repeat;" inside kernfs_put().
>     kernfs_put(pos);
>   } while (pos != kn) // Will continue, despite "kn" already freed.
> 
> Link: https://syzkaller.appspot.com/bug?extid=8bee3285b9e190f1509e [1]
> Reported-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com
> Fixes: 35beab0635f3cdd4 ("kernfs: restructure removal path to fix possible premature return")
> Tested-by: syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com
> Co-developed-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/kernfs/dir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 1cc88ba6de90..effb461d34fa 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1365,6 +1365,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
>  
>  	/* deactivate and unlink the subtree node-by-node */
> +	/*
> +	 * kernfs_put(pos) will invoke kernfs_put(kn) if @pos was the last
> +	 * reference to @kn. Make sure @kn doesn't go away underneath us.
> +	 */
> +	kernfs_get(kn);
>  	do {
>  		pos = kernfs_leftmost_descendant(kn);
>  
> @@ -1406,6 +1411,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
>  
>  		kernfs_put(pos);
>  	} while (pos != kn);
> +	kernfs_put(kn);
>  }
>  
>  /**
> -- 
> 2.34.1
> 

Isn't this already handled by:
	https://lore.kernel.org/r/20220913121723.691454-1-lk@c--e.de

that will show up in the next linux-next tree.

thanks,

greg k-h
