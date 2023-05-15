Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6BC702B15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjEOLIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjEOLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B390172B;
        Mon, 15 May 2023 04:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D14D62294;
        Mon, 15 May 2023 11:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12552C433D2;
        Mon, 15 May 2023 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148908;
        bh=MtwEv3vfSBVajDcCGwj+e6BsgT+xT4QSKmC6n9r79G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmhBuRXjCWOJ5j4WIbT0lPWOWCLFTgrwTArN0r3FQNdxn4jXnjWGuyCzi6BAyUoXU
         yDGyXiDuTtaEkxHSo6CgqXx16H2uSBY10vFzyrZJLZRctw4q1mB6no/9gF8/2MBpfj
         mt5Q3kWxpvPf7txYQO38JVc9q0vQVbK70W+9W4/iYTQCqWdcChGTjGS7H35q+lyshN
         yiEiXPZmAvy+d/ODr5oyMxJt7NzcgyS6/c7XFxh/NclhyfhoQ1EJNSk6xc+Y0FsSKN
         iKOl5u9zBG/uIIVSUnqtvGqLZc4ILb4hai6hAYQzBviu4pxJoqfjNSZ2Stg2Jv8sml
         wjZSLY3uUCeTA==
Date:   Mon, 15 May 2023 13:08:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ovl: get_acl: Fix null pointer dereference at
 realinode in rcu-walk mode
Message-ID: <20230515-hilfreich-zeilen-d4a8cf469896@brauner>
References: <20230505122452.405661-1-chengzhihao1@huawei.com>
 <20230505122452.405661-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505122452.405661-2-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:24:51PM +0800, Zhihao Cheng wrote:
> Following process:
>          P1                     P2
>  path_openat
>   link_path_walk
>    may_lookup
>     inode_permission(rcu)
>      ovl_permission
>       acl_permission_check
>        check_acl
>         get_cached_acl_rcu
> 	 ovl_get_inode_acl
> 	  realinode = ovl_inode_real(ovl_inode)
> 	                      drop_cache
> 		               __dentry_kill(ovl_dentry)
> 				iput(ovl_inode)
> 		                 ovl_destroy_inode(ovl_inode)
> 		                  dput(oi->__upperdentry)
> 		                   dentry_kill(upperdentry)
> 		                    dentry_unlink_inode
> 				     upperdentry->d_inode = NULL
> 	    ovl_inode_upper
> 	     upperdentry = ovl_i_dentry_upper(ovl_inode)
> 	     d_inode(upperdentry) // returns NULL
> 	  IS_POSIXACL(realinode) // NULL pointer dereference
> , will trigger an null pointer dereference at realinode:
>   [  205.472797] BUG: kernel NULL pointer dereference, address:
>                  0000000000000028
>   [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
>                  6.3.0-12064-g2edfa098e750-dirty #1216
>   [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
>   [  205.489584] Call Trace:
>   [  205.489812]  <TASK>
>   [  205.490014]  ovl_get_inode_acl+0x26/0x30
>   [  205.490466]  get_cached_acl_rcu+0x61/0xa0
>   [  205.490908]  generic_permission+0x1bf/0x4e0
>   [  205.491447]  ovl_permission+0x79/0x1b0
>   [  205.491917]  inode_permission+0x15e/0x2c0
>   [  205.492425]  link_path_walk+0x115/0x550
>   [  205.493311]  path_lookupat.isra.0+0xb2/0x200
>   [  205.493803]  filename_lookup+0xda/0x240
>   [  205.495747]  vfs_fstatat+0x7b/0xb0
> 
> Fetch a reproducer in [Link].
> 
> Fix it by checking realinode whether to be NULL before accessing it.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217404
> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  fs/overlayfs/inode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 541cf3717fc2..38cfdf9e2b44 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -563,16 +563,16 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
>  	struct posix_acl *acl;
>  	struct path realpath;
>  
> -	if (!IS_POSIXACL(realinode))
> -		return NULL;
> -
>  	/* Careful in RCU walk mode */
>  	ovl_i_path_real(inode, &realpath);
> -	if (!realpath.dentry) {
> +	if (!realpath.dentry || !realinode) {
>  		WARN_ON(!rcu);
>  		return ERR_PTR(-ECHILD);
>  	}

I think the logic here is now a bit strange. I would just not bother
calling ovl_inode_real() anymore and simply use the same logic as in
ovl_permission() (Thus my comment about using a tiny helper.).
