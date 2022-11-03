Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E26184DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKCQio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiKCQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:38:19 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D21DA72;
        Thu,  3 Nov 2022 09:35:06 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 9F6BC7FC21;
        Thu,  3 Nov 2022 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1667493261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7oeyOE9y+SCE0Fp1mehfx0R2Rb8YrWpiTFfBzwVnbE=;
        b=A/1/IKG1KpNtZhg+9WqvL6/jgQa6rGajHLy3ic5Bme0VfEK1IHzSnukadQAEuBZ28Gu7+B
        8jiA1IiBGxC9W2ymqpOFxlp7g/ckpa+u+bCDt+5XnsJBUqo15qEKdMh9WmvqcFHfOwlcl1
        xardnrPb3Ah1qZ08IIbGaDHIctH5rlEfe05yvHZwLscMCxQJMomFFQgAuezfaQXgaejG5+
        vTyzkQJYiCFgpfeZGEHea0YMGv/tlGvzdR3J6orRmax8in0OnE0cjzzRHlDu5UiF5hYSXa
        PYuHrPtSGMTP1WlYRpMn4KTytQjHAugGjUGlKcmE3dCATYu1POmvpeCKgsQhUA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, sfrench@samba.org,
        lsahlber@redhat.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, chenxiaosong2@huawei.com,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] cifs: fix use-after-free on the link name
In-Reply-To: <20221102061659.920334-1-chenxiaosong2@huawei.com>
References: <20221102061659.920334-1-chenxiaosong2@huawei.com>
Date:   Thu, 03 Nov 2022 13:35:30 -0300
Message-ID: <875yfw0ze5.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChenXiaoSong <chenxiaosong2@huawei.com> writes:

> xfstests generic/011 reported use-after-free bug as follows:
>
>   BUG: KASAN: use-after-free in __d_alloc+0x269/0x859
>   Read of size 15 at addr ffff8880078933a0 by task dirstress/952
>
>   CPU: 1 PID: 952 Comm: dirstress Not tainted 6.1.0-rc3+ #77
>   Call Trace:
>    __dump_stack+0x23/0x29
>    dump_stack_lvl+0x51/0x73
>    print_address_description+0x67/0x27f
>    print_report+0x3e/0x5c
>    kasan_report+0x7b/0xa8
>    kasan_check_range+0x1b2/0x1c1
>    memcpy+0x22/0x5d
>    __d_alloc+0x269/0x859
>    d_alloc+0x45/0x20c
>    d_alloc_parallel+0xb2/0x8b2
>    lookup_open+0x3b8/0x9f9
>    open_last_lookups+0x63d/0xc26
>    path_openat+0x11a/0x261
>    do_filp_open+0xcc/0x168
>    do_sys_openat2+0x13b/0x3f7
>    do_sys_open+0x10f/0x146
>    __se_sys_creat+0x27/0x2e
>    __x64_sys_creat+0x55/0x6a
>    do_syscall_64+0x40/0x96
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>   Allocated by task 952:
>    kasan_save_stack+0x1f/0x42
>    kasan_set_track+0x21/0x2a
>    kasan_save_alloc_info+0x17/0x1d
>    __kasan_kmalloc+0x7e/0x87
>    __kmalloc_node_track_caller+0x59/0x155
>    kstrndup+0x60/0xe6
>    parse_mf_symlink+0x215/0x30b
>    check_mf_symlink+0x260/0x36a
>    cifs_get_inode_info+0x14e1/0x1690
>    cifs_revalidate_dentry_attr+0x70d/0x964
>    cifs_revalidate_dentry+0x36/0x62
>    cifs_d_revalidate+0x162/0x446
>    lookup_open+0x36f/0x9f9
>    open_last_lookups+0x63d/0xc26
>    path_openat+0x11a/0x261
>    do_filp_open+0xcc/0x168
>    do_sys_openat2+0x13b/0x3f7
>    do_sys_open+0x10f/0x146
>    __se_sys_creat+0x27/0x2e
>    __x64_sys_creat+0x55/0x6a
>    do_syscall_64+0x40/0x96
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>   Freed by task 950:
>    kasan_save_stack+0x1f/0x42
>    kasan_set_track+0x21/0x2a
>    kasan_save_free_info+0x1c/0x34
>    ____kasan_slab_free+0x1c1/0x1d5
>    __kasan_slab_free+0xe/0x13
>    __kmem_cache_free+0x29a/0x387
>    kfree+0xd3/0x10e
>    cifs_fattr_to_inode+0xb6a/0xc8c
>    cifs_get_inode_info+0x3cb/0x1690
>    cifs_revalidate_dentry_attr+0x70d/0x964
>    cifs_revalidate_dentry+0x36/0x62
>    cifs_d_revalidate+0x162/0x446
>    lookup_open+0x36f/0x9f9
>    open_last_lookups+0x63d/0xc26
>    path_openat+0x11a/0x261
>    do_filp_open+0xcc/0x168
>    do_sys_openat2+0x13b/0x3f7
>    do_sys_open+0x10f/0x146
>    __se_sys_creat+0x27/0x2e
>    __x64_sys_creat+0x55/0x6a
>    do_syscall_64+0x40/0x96
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> When opened a symlink, link name is from 'inode->i_link', but it may be
> reset to a new value when revalidate the dentry. If some processes get the
> link name on the race scenario, then UAF will happen on link name.
>
> Fix this by implementing 'get_link' interface to duplicate the link name.
>
> Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
> ---
>  fs/cifs/cifsfs.c | 21 ++++++++++++++++++++-
>  fs/cifs/inode.c  |  5 -----
>  2 files changed, 20 insertions(+), 6 deletions(-)

Good catch.  I was also able to reproduce it with CONFIG_KASAN=y when
running xfstests generic/011 multiple times.

> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index d0b9fec111aa..bb9592594fcc 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1143,8 +1143,27 @@ const struct inode_operations cifs_file_inode_ops = {
>  	.fiemap = cifs_fiemap,
>  };
>  
> +const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
> +			    struct delayed_call *done)
> +{

Aren't you supposed to return ERR_PTR(-ECHILD) when !dentry
(e.g. rcu-walk mode)?

> +	char *target_path = NULL;
> +
> +	spin_lock(&inode->i_lock);
> +	if (likely(CIFS_I(inode)->symlink_target))
> +		target_path = kstrdup(CIFS_I(inode)->symlink_target,
> +				      GFP_ATOMIC);
> +	spin_unlock(&inode->i_lock);

Can't you get rid of above kmalloc() inside spin lock and do something
like

        target_path = kmalloc(PATH_MAX, GFP_KERNEL);
        if (!target_path)
                return ERR_PTR(-ENOMEM);

        spin_lock(&inode->i_lock);
        if (likely(CIFS_I(inode)->symlink_target))
                strscpy(target_path, CIFS_I(inode)->symlink_target, PATH_MAX);
        else {
                kfree(target_path);
                target_path = ERR_PTR(-EOPNOTSUPP);
        }
        spin_unlock(&inode->i_lock);

        if (!IS_ERR(target_path))
                set_delayed_call(done, kfree_link, target_path);

        return target_path;
