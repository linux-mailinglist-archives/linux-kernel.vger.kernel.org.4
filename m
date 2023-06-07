Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FF7267A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjFGRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjFGRnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5371BF7;
        Wed,  7 Jun 2023 10:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56CDE616A8;
        Wed,  7 Jun 2023 17:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDCDC4339C;
        Wed,  7 Jun 2023 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686159794;
        bh=q4PVStJooopCfB8r4NpuPzaJZNPVyKO/PVJffa5elvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gr2q8V1cj3uFpQtnQogaYaSsgPB/SaeDtKVJlNYzvloSjzvrTRCe4cx4JZSmZqSkM
         3Tm46ZXv0PcDSdEdxL+Qf0Ayy+es5FSfsOzKLvY4NKKhBHtJcbMmaWJr6HWIGAUJph
         qa0gRYvWhLHyxPP7Z/joqH8MA8DhNXivNnHmmiyc=
Date:   Wed, 7 Jun 2023 10:43:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     hughd@google.com, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] shmem: Use ramfs_kill_sb() for kill_sb method of
 ramfs-based tmpfs
Message-Id: <20230607104313.2909afb61021a1431dc56a28@linux-foundation.org>
In-Reply-To: <20230607161523.2876433-1-roberto.sassu@huaweicloud.com>
References: <20230607161523.2876433-1-roberto.sassu@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc's added)

On Wed,  7 Jun 2023 18:15:23 +0200 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> As the ramfs-based tmpfs uses ramfs_init_fs_context() for the
> init_fs_context method, which allocates fc->s_fs_info, use ramfs_kill_sb()
> to free it and avoid a memory leak.
> 
> Cc: stable@vger.kernel.org # v5.4.x
> Fixes: f32356261d44 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/ramfs/inode.c      | 2 +-
>  include/linux/ramfs.h | 1 +
>  mm/shmem.c            | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 5ba580c7883..fef477c7810 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -278,7 +278,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
>  	return 0;
>  }
>  
> -static void ramfs_kill_sb(struct super_block *sb)
> +void ramfs_kill_sb(struct super_block *sb)
>  {
>  	kfree(sb->s_fs_info);
>  	kill_litter_super(sb);
> diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
> index 917528d102c..d506dc63dd4 100644
> --- a/include/linux/ramfs.h
> +++ b/include/linux/ramfs.h
> @@ -7,6 +7,7 @@
>  struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
>  	 umode_t mode, dev_t dev);
>  extern int ramfs_init_fs_context(struct fs_context *fc);
> +extern void ramfs_kill_sb(struct super_block *sb);
>  
>  #ifdef CONFIG_MMU
>  static inline int
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e40a08c5c6d..74abb97ea55 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4196,7 +4196,7 @@ static struct file_system_type shmem_fs_type = {
>  	.name		= "tmpfs",
>  	.init_fs_context = ramfs_init_fs_context,
>  	.parameters	= ramfs_fs_parameters,
> -	.kill_sb	= kill_litter_super,
> +	.kill_sb	= ramfs_kill_sb,
>  	.fs_flags	= FS_USERNS_MOUNT,
>  };
>  
> -- 
> 2.25.1
