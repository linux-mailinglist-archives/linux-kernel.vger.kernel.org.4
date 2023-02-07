Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E268D93E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjBGNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjBGNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:24:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B4CA21
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9830EB81989
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A8C433EF;
        Tue,  7 Feb 2023 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675776295;
        bh=ioVmosDPxB5ukpdRdpAJ+ODAaRgvHm8xKSTWkiHnMtA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q2LE1eeIIuhpGn0Qf2hRCb0Dybire81gx5R+hxDqV904vL82YNe8Rk3esDlrmIbYA
         6p7Y+FQrr8kEWRM9eqM1xaP3royTBLXr355/1xForP7Vcqz4kIFD+P5XkQHV2GU8yE
         0++zd9k7YpoweZiRxdwOLq6eANM3qkKlyobL2JGZBcbzHYFXAJOT2iPBvHlJ4suCGP
         2EFhVgBD6aeBHFtaiZNfzVXD/VCQ7afeTtqcKRiHnLS0FZlTaE30EdqMVR8uhPhgQw
         x16wbG5WLfZHQm2sbBrppYqFFRhtWhtPVrzSSRB7kjdcW9aO3GNpPyOgQZLAed0TYl
         /P6T4fx42fiRw==
Message-ID: <5b47f58a-4c3c-a183-777c-d4750f6b4d6c@kernel.org>
Date:   Tue, 7 Feb 2023 21:24:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/3] f2fs: fix to set ipu policy
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230206144310.2344-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230206144310.2344-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/6 22:43, Yangtao Li wrote:
> For LFS mode, it should update outplace and no need inplace update.
> When using LFS mode for small-volume devices, IPU will not be used,
> and the OPU writing method is actually used, but F2FS_IPU_FORCE can
> be read from the ipu_policy node, which is different from the actual
> situation. And remount to lfs mode should be disallowed when
> f2fs ipu is enabled, let's fix it.
> 
> Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v4:
> -allow set 0 in lfs mode for ipu_policy node
>   fs/f2fs/segment.h | 10 +++++++++-
>   fs/f2fs/super.c   | 17 +++++++++++------
>   fs/f2fs/sysfs.c   |  9 +++++++++
>   3 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 0f3f05cb8c29..8ee5e5db9287 100644
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
> @@ -679,10 +681,16 @@ enum {
>   	F2FS_IPU_ASYNC,
>   	F2FS_IPU_NOCACHE,
>   	F2FS_IPU_HONOR_OPU_WRITE,
> +	F2FS_IPU_MAX,
>   };
>   
> +static inline bool IS_F2FS_IPU_DISABLE(struct f2fs_sb_info *sbi)
> +{
> +	return SM_I(sbi)->ipu_policy == F2FS_IPU_DISABLE;
> +}
> +
>   #define F2FS_IPU_POLICY(name)					\
> -static inline int IS_##name(struct f2fs_sb_info *sbi)		\
> +static inline bool IS_##name(struct f2fs_sb_info *sbi)		\
>   {								\
>   	return SM_I(sbi)->ipu_policy & BIT(name);		\
>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4ec2cbbc47eb..09696fc844ab 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1346,12 +1346,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   	}
>   
>   	if (test_opt(sbi, DISABLE_CHECKPOINT) && f2fs_lfs_mode(sbi)) {
> -		f2fs_err(sbi, "LFS not compatible with checkpoint=disable");
> +		f2fs_err(sbi, "LFS is not compatible with checkpoint=disable");
>   		return -EINVAL;
>   	}
>   
>   	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
> -		f2fs_err(sbi, "LFS not compatible with ATGC");
> +		f2fs_err(sbi, "LFS is not compatible with ATGC");
>   		return -EINVAL;
>   	}
>   
> @@ -2304,6 +2304,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		}
>   	}
>   #endif
> +	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> +		err = -EINVAL;
> +		f2fs_warn(sbi, "LFS is not compatible with IPU");
> +		goto restore_opts;
> +	}
> +
>   	/* disallow enable atgc dynamically */
>   	if (no_atgc == !!test_opt(sbi, ATGC)) {
>   		err = -EINVAL;
> @@ -4083,10 +4089,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	/* adjust parameters according to the volume size */
>   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
>   		if (f2fs_block_unit_discard(sbi))
> -			SM_I(sbi)->dcc_info->discard_granularity =
> -						MIN_DISCARD_GRANULARITY;
> -		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
> -					BIT(F2FS_IPU_HONOR_OPU_WRITE);
> +			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
> +		if (!f2fs_lfs_mode(sbi))
> +			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);

	SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) |
				BIT(F2FS_IPU_HONOR_OPU_WRITE);

I prefer to not exceed 80 lines, otherwise it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   	}
>   
>   	sbi->readdir_ra = true;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 575a5536c0e7..3c3dae3ce84e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -706,6 +706,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "ipu_policy")) {
> +		if (t >= BIT(F2FS_IPU_MAX))
> +			return -EINVAL;
> +		if (t && f2fs_lfs_mode(sbi))
> +			return -EINVAL;
> +		SM_I(sbi)->ipu_policy = (unsigned int)t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
