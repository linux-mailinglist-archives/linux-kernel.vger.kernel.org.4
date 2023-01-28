Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9241667F6AC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjA1JYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjA1JYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 04:24:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4BB79232
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 01:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A0D60A24
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 09:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050BDC433EF;
        Sat, 28 Jan 2023 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674897848;
        bh=ZygXwzVIvC311zvalg/mGsFQF8J4IwJ5WLIdnWTWFAU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A6yltsA6Xohe0XTSMjGBlWB9lRdpOzcdYA8JzZluu3AGZI3GllCWwOU3bQFYV0WFD
         DM+A6AsyLulK873tMTJFA1vr8Z1bsnHfqf4Vis3RBBwSIjPeyUKeni73CmBWYA8m+M
         IAfkrr7/cyqd+LbSLiy+fB72TpoL3IqAhyyBloMv0I8aUdpHStgSl6T/F9h25/W7Th
         S2k59+lieNKbMvz9+06517ld6MHS8t6r4vQx47cnxyTbOSK4Zmw7uSyRyf2AexToOp
         1TKiwnzkGtrsBJZS5QXm26kSB8uTeJferRkWUbY9V41GCS5dDyJ2XHI3kDiapcxli8
         MvH1P3E6Kkk8g==
Message-ID: <b1f8ba44-dd87-b3c1-c249-10d424c6ccd0@kernel.org>
Date:   Sat, 28 Jan 2023 17:24:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] f2fs: fix to set ipu policy
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230120134029.69200-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230120134029.69200-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 21:40, Yangtao Li wrote:
> For LFS mode, it should update outplace and no need inplace update.
> When using LFS mode for small-volume devices, IPU will not be used,
> and the OPU writing method is actually used, but F2FS_IPU_FORCE can
> be read from the ipu_policy node, which is different from the actual
> situation. And after remount, ipu should be disabled when convert to
> lfs mode, let's fix it.
> 
> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> warning") increased the limit to 100 columns. BTW modify some unnecessary
> newlines.
> 
> Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.h |  2 ++
>   fs/f2fs/super.c   | 20 +++++++++-----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index ad6a9c19f46a..0b0eb8f03cba 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -670,6 +670,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>   
>   #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
>   
> +#define F2FS_IPU_DISABLE	0
> +
>   enum {
>   	F2FS_IPU_FORCE,
>   	F2FS_IPU_SSR,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d8a65645ee48..ebc76683f05d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2272,6 +2272,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	if (err)
>   		goto restore_opts;
>   
> +	if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)

if (f2fs_lfs_mode())

> +		SM_I(sbi)->ipu_policy = F2FS_IPU_DISABLE;

How about adding such restriction to f2fs_tuning_parameters()? For
f2fs_remount() and __sbi_store() cases, how about returning -EINVAL if
there is a conflict?

Thanks,

> +
>   	/*
>   	 * Previous and new state of filesystem is RO,
>   	 * so skip checking GC and FLUSH_MERGE conditions.
> @@ -4080,10 +4083,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	/* adjust parameters according to the volume size */
>   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
>   		if (f2fs_block_unit_discard(sbi))
> -			SM_I(sbi)->dcc_info->discard_granularity =
> -						MIN_DISCARD_GRANULARITY;
> -		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
> -					BIT(F2FS_IPU_HONOR_OPU_WRITE);
> +			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
> +		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS)
> +			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
>   	}
>   
>   	sbi->readdir_ra = true;
> @@ -4310,9 +4312,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   			test_opt(sbi, MERGE_CHECKPOINT)) {
>   		err = f2fs_start_ckpt_thread(sbi);
>   		if (err) {
> -			f2fs_err(sbi,
> -			    "Failed to start F2FS issue_checkpoint_thread (%d)",
> -			    err);
> +			f2fs_err(sbi, "Failed to start F2FS issue_checkpoint_thread (%d)", err);
>   			goto stop_ckpt_thread;
>   		}
>   	}
> @@ -4320,14 +4320,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   	/* setup f2fs internal modules */
>   	err = f2fs_build_segment_manager(sbi);
>   	if (err) {
> -		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
> -			 err);
> +		f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)", err);
>   		goto free_sm;
>   	}
>   	err = f2fs_build_node_manager(sbi);
>   	if (err) {
> -		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
> -			 err);
> +		f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)", err);
>   		goto free_nm;
>   	}
>   
