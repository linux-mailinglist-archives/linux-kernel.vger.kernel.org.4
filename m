Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47885740C35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjF1JBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjF1IpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C374694;
        Wed, 28 Jun 2023 01:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC0FC6126B;
        Wed, 28 Jun 2023 08:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27BBC433C8;
        Wed, 28 Jun 2023 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687941376;
        bh=OIo+iQ1NbQ0Q/3QbREXXSDKg5tSJjXYtebmMPeule1o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qRhjFW5caRw09aD/J+66ROTCSqmKTZzlbW1fyj9VQ6DVlRaIGj9lVOw8OeudEqznx
         TprARDTLZqJDdjbMvXOlqqaaqh+KQ97Ly9rpSl7EAaYCYYsZ2RGUbDoX31r1mLfzZz
         Kmm4QWQp5eR7W3S4274x98TxURU19IOD8owD4Twb4dux+RrGjxGyvr/S4x3MydVJcs
         OpS59BHGH1s6GHGNZE4xZoj0XGlTXFMlv2hneGHzO+pJV1Ym6RNorxkWdpiJjirWsd
         y5XoiQjl9O9stmv4aMjaKkCCUnQMWZFEOXpuAK/VHMq8I/gDZFXJrR4LJ33/mvY96Q
         J568AcMf4LTXA==
Message-ID: <e4ee00c4-c20a-4613-87ec-3b144d6252ed@kernel.org>
Date:   Wed, 28 Jun 2023 16:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] f2fs: fix deadlock in i_xattr_sem and inode page lock
 and fix the original issue
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
References: <20230613233940.3643362-1-jaegeuk@kernel.org>
 <e5788348-b547-8e10-21af-90544f3aa75c@kernel.org>
 <ZJvqZTX1SIwvDCUn@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZJvqZTX1SIwvDCUn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/28 16:08, Jaegeuk Kim wrote:
> Thread #1:
> 
> [122554.641906][   T92]  f2fs_getxattr+0xd4/0x5fc
>      -> waiting for f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
> 
> [122554.641927][   T92]  __f2fs_get_acl+0x50/0x284
> [122554.641948][   T92]  f2fs_init_acl+0x84/0x54c
> [122554.641969][   T92]  f2fs_init_inode_metadata+0x460/0x5f0
> [122554.641990][   T92]  f2fs_add_inline_entry+0x11c/0x350
>      -> Locked dir->inode_page by f2fs_get_node_page()
> 
> [122554.642009][   T92]  f2fs_do_add_link+0x100/0x1e4
> [122554.642025][   T92]  f2fs_create+0xf4/0x22c
> [122554.642047][   T92]  vfs_create+0x130/0x1f4
> 
> Thread #2:
> 
> [123996.386358][   T92]  __get_node_page+0x8c/0x504
>      -> waiting for dir->inode_page lock
> 
> [123996.386383][   T92]  read_all_xattrs+0x11c/0x1f4
> [123996.386405][   T92]  __f2fs_setxattr+0xcc/0x528
> [123996.386424][   T92]  f2fs_setxattr+0x158/0x1f4
>      -> f2fs_down_write(&F2FS_I(inode)->i_xattr_sem);
> 
> [123996.386443][   T92]  __f2fs_set_acl+0x328/0x430
> [123996.386618][   T92]  f2fs_set_acl+0x38/0x50
> [123996.386642][   T92]  posix_acl_chmod+0xc8/0x1c8
> [123996.386669][   T92]  f2fs_setattr+0x5e0/0x6bc
> [123996.386689][   T92]  notify_change+0x4d8/0x580
> [123996.386717][   T92]  chmod_common+0xd8/0x184
> [123996.386748][   T92]  do_fchmodat+0x60/0x124
> [123996.386766][   T92]  __arm64_sys_fchmodat+0x28/0x3c

Back to the race condition, my question is why we can chmod on inode before
it has been created?

Thanks,

> 
> Fixes: 27161f13e3c3 "f2fs: avoid race in between read xattr & write xattr"
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/dir.c   | 9 ++++++++-
>   fs/f2fs/xattr.c | 6 ++++--
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 887e55988450..d635c58cf5a3 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -775,8 +775,15 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
>   {
>   	int err = -EAGAIN;
>   
> -	if (f2fs_has_inline_dentry(dir))
> +	if (f2fs_has_inline_dentry(dir)) {
> +		/*
> +		 * Should get i_xattr_sem to keep the lock order:
> +		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
> +		 */
> +		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
>   		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
> +		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
> +	}
>   	if (err == -EAGAIN)
>   		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
>   
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 213805d3592c..476b186b90a6 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -528,10 +528,12 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>   	if (len > F2FS_NAME_LEN)
>   		return -ERANGE;
>   
> -	f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
> +	if (!ipage)
> +		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
>   	error = lookup_all_xattrs(inode, ipage, index, len, name,
>   				&entry, &base_addr, &base_size, &is_inline);
> -	f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
> +	if (!ipage)
> +		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
>   	if (error)
>   		return error;
>   
