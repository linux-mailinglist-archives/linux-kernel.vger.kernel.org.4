Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B86B7526
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCMLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCMLDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:03:53 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD92278D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=YLAfiCANXVZtch650KOlx6EsyebdJXkPvCt8bLo4sWI=; b=OWnQ6GDSOK3pJsLBCYQRkDL4S5
        KgHTD3meBFbrtLNlUrFhaqGmn3l7qXPg918jfODc/6TzDdD8JQCO8VuwLAleGLb+eip2A51DX0WtN
        +ucG332jNIgDe4GpNGdGTriHtpgma9LnSzdtYsXa/BAeZDaXIB4IGkbF1E3xZFBXLDr6WEZ1YNr6W
        NwBO06AuGWVn5wFDUJ/Hk21yOibkkeynmYvBVV/xTk5ynZGSsiqSX6sugR7yRkqQOIAwX7hUh8u+L
        K6944+86tQsXGoJxnppyNLH07VjbiO+t146cEegPS/Tw3gL3zroCP1n1ZtX+4SdkMlUyEQcnTSdvU
        sIjH+TSG99QkdiXDEw0LGtNhpnIOsXWw63AvNBlNkzW5c+/g9l/FVsy8NquWiBHoQcseLDH5Flf5a
        Nz8ide653jtvOKbBPARMEQP0/7s8XcIpF70Uy5AeVySVpyGTJpHevQw9/3UCTxM7ar/psWcHoNeZN
        qe1X9UyOEGyo2XvfVXsxNm6DaYQ03hYFmyzSsWduLk/PoK1J4+Oshe11TTYKqhc9u+At0NaQxzSbl
        ++SO4JU6F0sb0buTY0XLHlLvRetRmm62LIIPpw0/SCTU8hhKROXbp0mJy2xVdYtWcrXt/JW/asJ8R
        BJwGZk98gwLIQIuARvQO0PulEgON70EyZ33s7/6DA=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Date:   Mon, 13 Mar 2023 12:03:38 +0100
Message-ID: <1894056.UjuiS2pzi0@silver>
In-Reply-To: <20230311125025.24605-1-ivan.orlov0322@gmail.com>
References: <20230311125025.24605-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, March 11, 2023 1:50:25 PM CET Ivan Orlov wrote:
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
> In this version of the patch I simplified the condition.
> 
> In previous (v2) version of the patch I removed explicit type conversion
> and added separate condition to check the possible overflow and return
> an error (in v1 version I've just modified the existing condition).
> 
> Tested via syzkaller.
> 
> Suggested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/xattr.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index 50f7f3f6b55e..1974a38bce20 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -35,10 +35,12 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>  		return retval;
>  	}
>  	if (attr_size > buffer_size) {
> -		if (!buffer_size) /* request to get the attr_size */
> -			retval = attr_size;
> -		else
> +		if (buffer_size)
>  			retval = -ERANGE;
> +		else if (attr_size > SSIZE_MAX)
> +			retval = -EOVERFLOW;
> +		else /* request to get the attr_size */
> +			retval = attr_size;
>  	} else {
>  		iov_iter_truncate(&to, attr_size);
>  		retval = p9_client_read(attr_fid, 0, &to, &err);
> 



