Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7745C6B320A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCIXZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCIXZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:25:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F410339C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:25:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A77A61C11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71733C433EF;
        Thu,  9 Mar 2023 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678404351;
        bh=2br2n7KTsiZSG8vELjtJ0cA+PLd2npYRSMve4yq0f/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyIu47mZ3o0MXudfmWHgRF9SMMf/VZ/rAE8qvzHiQHrS+BtjQm5y6JEjTdOukiuLa
         nZ7nab+gLBGHc+Zj+Jb/rwHOW+39xfGy9odC/80SDUKP0jg94qnnbfUjRFBLrSfrai
         99/vIxp/LAffZukGwd76YQjJFFMniWGqh1KFpY3M1cLFmaT4kc2LKKhJIRufavQRw2
         ummbLi+HommC23JSJa9ojGPDWdDXP8s+iG5TAf+Xtj7tiwNkjmXh4YfAqK7Q8UMSKj
         +YYxLLkWeJ4chMclwWqHCPVoVzveATena/xAGSZ1eTFJEHzvEFmtXz8mLUoreZoLMk
         ujkVY+VX6M1rw==
Date:   Thu, 9 Mar 2023 15:25:49 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: Re: [PATCH] f2fs: fix unaligned field offset in 32-bits platform
Message-ID: <ZApq/Rg2sbkCuQ2i@google.com>
References: <20230307151408.58490-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307151408.58490-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07, Chao Yu wrote:
> F2FS-fs (dm-x): inconsistent rbtree, cur(3470333575168) next(3320009719808)
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/gc.c:602!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> PC is at get_victim_by_default+0x13c0/0x1498
> LR is at f2fs_check_rb_tree_consistence+0xc4/0xd4
> ....
> [<c04d98b0>] (get_victim_by_default) from [<c04d4f44>] (f2fs_gc+0x220/0x6cc)
> [<c04d4f44>] (f2fs_gc) from [<c04d4780>] (gc_thread_func+0x2ac/0x708)
> [<c04d4780>] (gc_thread_func) from [<c015c774>] (kthread+0x1a8/0x1b4)
> [<c015c774>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> 
> The reason is there is __packed attribute in struct rb_entry, but there
> is no __packed attribute in struct victim_entry, so wrong offset of key
> field will be parsed in struct rb_entry in f2fs_check_rb_tree_consistence,
> it describes memory layouts of struct rb_entry and struct victim_entry in
> 32-bits platform as below:
> 
> struct rb_entry {
>    [0] struct rb_node rb_node;
>        union {
>            struct {...};
>   [12]     unsigned long long key;
>        } __packed;
> }
> size of struct rb_entry: 20
> 
> struct victim_entry {
>    [0] struct rb_node rb_node;
>        union {
>            struct {...};
>   [16]     struct victim_info vi;

Why 16?
Don't we get the key from "unsigned long long mtime" starting at [12]?

	struct rb_node rb_node;		/* rb node located in rb-tree */
	union {
		struct {
			unsigned long long mtime;	/* mtime of section */
			unsigned int segno;		/* segment No. */
		};
		struct victim_info vi;	/* victim info */
	}; 

>        };
>   [32] struct list_head list;
> }
> size of struct victim_entry: 40
> 
> This patch tries to add __packed attribute in below structure:
> - discard_info, discard_cmd
> - extent_info, extent_node
> - victim_info, victim_entry
> in order to fix this unaligned field offset issue in 32-bits platform.
> 
> Fixes: 004b68621897 ("f2fs: use rb-tree to track pending discard commands")
> Fixes: 13054c548a1c ("f2fs: introduce infra macro and data structure of rb-tree extent cache")
> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 6 +++---
>  fs/f2fs/gc.h   | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b0ab2062038a..17fa7572ceed 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -349,7 +349,7 @@ struct discard_info {
>  	block_t lstart;			/* logical start address */
>  	block_t len;			/* length */
>  	block_t start;			/* actual start address in dev */
> -};
> +} __packed;
>  
>  struct discard_cmd {
>  	struct rb_node rb_node;		/* rb node located in rb-tree */
> @@ -361,7 +361,7 @@ struct discard_cmd {
>  		};
>  		struct discard_info di;	/* discard info */
>  
> -	};
> +	} __packed;
>  	struct list_head list;		/* command list */
>  	struct completion wait;		/* compleation */
>  	struct block_device *bdev;	/* bdev */
> @@ -660,7 +660,7 @@ struct extent_info {
>  			unsigned long long last_blocks;
>  		};
>  	};
> -};
> +} __packed;
>  
>  struct extent_node {
>  	struct rb_node rb_node;		/* rb node located in rb-tree */
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 15bd1d680f67..304937d9a084 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -58,7 +58,7 @@ struct gc_inode_list {
>  struct victim_info {
>  	unsigned long long mtime;	/* mtime of section */
>  	unsigned int segno;		/* section No. */
> -};
> +} __packed;
>  
>  struct victim_entry {
>  	struct rb_node rb_node;		/* rb node located in rb-tree */
> @@ -68,7 +68,7 @@ struct victim_entry {
>  			unsigned int segno;		/* segment No. */
>  		};
>  		struct victim_info vi;	/* victim info */
> -	};
> +	} __packed;
>  	struct list_head list;
>  };
>  
> -- 
> 2.36.1
