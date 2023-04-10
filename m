Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3D6DC2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDJCic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDJCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:38:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C43C05
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:38:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id px4so768127pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681094309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCtGUQFe5Dbm6hG4sTfRdcAn7odOh+gle3cljKvZY1A=;
        b=HO0JdJmIvIlkeoqzcxm4OquQFOW5UQPR8tciBqzwYuMnvnaNbD0TvRUyoG7T8ZbODD
         Jr3O3ucLkb4EYdU/pC37Xh3ZrYEuRYbIcx3fZarqPgNGpyhtp7VoxQzOy2paGNzWqE/r
         A13dC4fKnhWNSdbiZGLXk+fquwXoIPMDdTUNZCDHqFH1LQNdEJPcazrbm0iS1plSOrnE
         rMEzQPRVYRlbDGisPNI2KOUQZe8JdmvNbm5Gjy4tXxNQS/IuLcdpNjMDe0z/JACV4fGx
         KmcwS6oFO+6w2ju6O+kiNhmKhWfxsS6j3vBPZMiuS67WQ84ZQwa0fxSZM6qMBxuDhcwN
         ac1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681094309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCtGUQFe5Dbm6hG4sTfRdcAn7odOh+gle3cljKvZY1A=;
        b=JknBLC++ZMPdKgw3CoppTEw7BnXgc1sVQeYIeOO/EPTJBhLMm4uN7Z7IMtySfDeLWm
         gEITQlj9gB8TosNSAOaC/bxFF03Pao5h3VxT8hJBAQhwhxPgtBobS0V6MBTR3MfNEwbe
         Zj/fq1v7/93PR2Na60wx14iO6WSTzXqb7bb+zxECDF1Du48onnKagtH/B5EAlH61sYEF
         VISzR+zYW5lmJOEE1ROlm3wF5MGuLbBwGo2QF6LBfKGwikb8NPxoGeqIkNsg3azsKfQw
         fZMkLLOAsj0o/s/vT91QEMPaVGtClHXNIv1kjBklOXXF5r/wt3CBG0M9wdTXLa0KkUav
         AiFQ==
X-Gm-Message-State: AAQBX9cAVxoD2oi8N6zCMfylre8ea5EoxiqtdBveNz63WkutSjGLOuHO
        UNXW3cSvfxCEtIQX6gny0SlLP6TcsoU=
X-Google-Smtp-Source: AKy350YmT/B2xIHq1k5QPFp0mwZibS3LCgetSwB+W8Tvl5wdry74Po3rJy4g1mvxEqMICzO9iU2AVA==
X-Received: by 2002:a05:6a20:3b28:b0:de:6e42:e0e5 with SMTP id c40-20020a056a203b2800b000de6e42e0e5mr9400995pzh.13.1681094308667;
        Sun, 09 Apr 2023 19:38:28 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j11-20020aa78dcb000000b005e4c3e2022fsm6740568pfr.72.2023.04.09.19.38.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Apr 2023 19:38:28 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:45:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 3/7] erofs: move packed inode out of the compression
 part
Message-ID: <20230410104532.000034fa.zbestahu@gmail.com>
In-Reply-To: <20230407141710.113882-4-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
        <20230407141710.113882-4-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Apr 2023 22:17:06 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> packed inode could be used in more scenarios which are independent of
> compression in the future.
> 
> For example, packed inode could be used to keep extra long xattr
> prefixes with the help of following patches.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h | 2 +-
>  fs/erofs/super.c    | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index caea9dc1cd82..8b5168f94dd2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -134,8 +134,8 @@ struct erofs_sb_info {
>  	struct inode *managed_cache;
>  
>  	struct erofs_sb_lz4_info lz4;
> -	struct inode *packed_inode;
>  #endif	/* CONFIG_EROFS_FS_ZIP */
> +	struct inode *packed_inode;
>  	struct erofs_dev_context *devs;
>  	struct dax_device *dax_dev;
>  	u64 dax_part_off;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 325602820dc8..8f2f8433db61 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -810,7 +810,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	erofs_shrinker_register(sb);
>  	/* sb->s_umount is already locked, SB_ACTIVE and SB_BORN are not set */
> -#ifdef CONFIG_EROFS_FS_ZIP
>  	if (erofs_sb_has_fragments(sbi) && sbi->packed_nid) {
>  		sbi->packed_inode = erofs_iget(sb, sbi->packed_nid);
>  		if (IS_ERR(sbi->packed_inode)) {
> @@ -819,7 +818,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  			return err;
>  		}
>  	}
> -#endif
>  	err = erofs_init_managed_cache(sb);
>  	if (err)
>  		return err;
> @@ -986,9 +984,9 @@ static void erofs_put_super(struct super_block *sb)
>  #ifdef CONFIG_EROFS_FS_ZIP
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
> +#endif
>  	iput(sbi->packed_inode);
>  	sbi->packed_inode = NULL;
> -#endif
>  	erofs_free_dev_context(sbi->devs);
>  	sbi->devs = NULL;
>  	erofs_fscache_unregister_fs(sb);

