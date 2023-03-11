Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CC6B5B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCKLWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCKLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:21:47 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE711E97
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=4TvOdkKIzJlisioGTQqyrn/AqrN6FeeQpMMQk2PT44Q=; b=VJVj9abWMgNguRjHNq3K7GaVYP
        ji4ey1JrT/AYdBec7ZUYFP5ps8cyolUBlNYlO2TiLBmoC29Y6psYZrWh4L/2Wm413X9fqZ3bnt7QZ
        8DtAWw0i6pn25o2pGkI36Zd4WxC2Tz7ChUj16W7i3clBNL1EtZkC4M06bgmJ+kik86zqBj7MJXy/T
        mGC2vtprSscfqjKAbvr1JyHIpLflIfw8COt1eFrmBVcCBGaCNKQVVFxwKZEM1tJZaUr33Tb6PhkCu
        MdG+dYLGlk24jbJB4ua8onun9kfHdIGb/+tvhVcHtWeBTZrYbrg0FcNQFSWdAgPX7jHBy0noNYFw4
        DSktYYQYNThG/1aLE6lQkuR9tLexm4+/kVYY1oAb1VSF1xc+4eHA4h2/MdnVZKd8HsLYSUwPLZGaG
        Zwi/2y9Xnx4l/D/M7KcKgtO76bnwrnFknb4inppxIf0x7rmmvM1y6JYW26WDoTDKSPNg2/fhhnx01
        +KY4hXlmIgdt12+2+6xp1/tqUF1gzvmlO7rEvzVA7dfd5RvBB8bPsckMgnWGpEKywfV9wdze7I85B
        3rHyvX8UEJgWfHe6dMtCdGX6gk0Ys3WtX+30AQgxk+YNAKc4aJOJXYstvDbifYjz3ifQsO8kbrnyM
        vzX6OtvCVqZFHOo0FeBmQzzoNCbcVcV6dK1p/a/Qc=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Date:   Sat, 11 Mar 2023 12:17:43 +0100
Message-ID: <15987509.0H6QrEVh2d@silver>
In-Reply-To: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
References: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 11, 2023 7:34:11 AM CET Ivan Orlov wrote:
> KASAN reported the following issue:
> [   36.825817][ T5923] BUG: KASAN: wild-memory-access in v9fs_get_acl+0x1a4/0x390
> [   36.827479][ T5923] Write of size 4 at addr 9fffeb37f97f1c00 by task syz-executor798/5923
> [   36.829303][ T5923]
> [   36.829846][ T5923] CPU: 0 PID: 5923 Comm: syz-executor798 Not tainted 6.2.0-syzkaller-18302-g596b6b709632 #0
> [   36.832110][ T5923] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
> [   36.834464][ T5923] Call trace:
> [   36.835196][ T5923]  dump_backtrace+0x1c8/0x1f4
> [   36.836229][ T5923]  show_stack+0x2c/0x3c
> [   36.837100][ T5923]  dump_stack_lvl+0xd0/0x124
> [   36.838103][ T5923]  print_report+0xe4/0x4c0
> [   36.839068][ T5923]  kasan_report+0xd4/0x130
> [   36.840052][ T5923]  kasan_check_range+0x264/0x2a4
> [   36.841199][ T5923]  __kasan_check_write+0x2c/0x3c
> [   36.842216][ T5923]  v9fs_get_acl+0x1a4/0x390
> [   36.843232][ T5923]  v9fs_mount+0x77c/0xa5c
> [   36.844163][ T5923]  legacy_get_tree+0xd4/0x16c
> [   36.845173][ T5923]  vfs_get_tree+0x90/0x274
> [   36.846137][ T5923]  do_new_mount+0x25c/0x8c8
> [   36.847066][ T5923]  path_mount+0x590/0xe58
> [   36.848147][ T5923]  __arm64_sys_mount+0x45c/0x594
> [   36.849273][ T5923]  invoke_syscall+0x98/0x2c0
> [   36.850421][ T5923]  el0_svc_common+0x138/0x258
> [   36.851397][ T5923]  do_el0_svc+0x64/0x198
> [   36.852398][ T5923]  el0_svc+0x58/0x168
> [   36.853224][ T5923]  el0t_64_sync_handler+0x84/0xf0
> [   36.854293][ T5923]  el0t_64_sync+0x190/0x194
> 
> Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
> following chain of function calls:
> 
> __v9fs_get_acl
> 	v9fs_fid_get_acl
> 		v9fs_fid_xattr_get
> 			p9_client_xattrwalk
> 
> Function p9_client_xattrwalk accepts a pointer to u64-typed
> variable attr_size and puts some u64 value into it. However,
> after the executing the p9_client_xattrwalk, in some circumstances
> we assign the value of u64-typed variable 'attr_size' to the
> variable 'retval', which we will return. However, the type of
> 'retval' is ssize_t, and if the value of attr_size is larger
> than SSIZE_MAX, we will face the signed type overflow. If the
> overflow occurs, the result of v9fs_fid_xattr_get may be
> negative, but not classified as an error. When we try to allocate
> an acl with 'broken' size we receive an error, but don't process
> it. When we try to free this acl, we face the 'wild-memory-access'
> error (because it wasn't allocated).
> 
> This patch will add new condition to the 'v9fs_fid_xattr_get'
> function, so it will return an EOVERFLOW error if the 'attr_size'
> is larger than SSIZE_MAX.
> 
> In this version of the patch I removed explicit type conversion and
> added separate condition to check the possible overflow and return
> an error (in v1 version I've just modified the existing condition).
> 
> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  fs/9p/xattr.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index 50f7f3f6b55e..6affd6b3f5e6 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -35,10 +35,14 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>  		return retval;
>  	}
>  	if (attr_size > buffer_size) {
> -		if (!buffer_size) /* request to get the attr_size */
> -			retval = attr_size;
> -		else
> +		if (!buffer_size) {/* request to get the attr_size */
> +			if (attr_size > SSIZE_MAX)
> +				retval = -EOVERFLOW;
> +			else
> +				retval = attr_size;
> +		} else {
>  			retval = -ERANGE;
> +		}

I would have written it in different style:

    if (buffer_size)
        retval = -ERANGE;
    else if (attr_size > SSIZE_MAX)
        retval = -EOVERFLOW;
    else
        retval = attr_size; /* request to get the attr_size */

But the behaviour change itself makes sense, so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  	} else {
>  		iov_iter_truncate(&to, attr_size);
>  		retval = p9_client_read(attr_fid, 0, &to, &err);
> 


