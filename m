Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FF689387
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjBCJWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBCJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:21:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B65A817
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99C27B82614
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8B5C433D2;
        Fri,  3 Feb 2023 09:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675416015;
        bh=U9pXr/hLXKeztUm2CNX6Swf9RkjUrLc3KXyhMVqG1cs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d1/s1Vt6q0reVc7Isp9JJBkHYJ7CED5YfrxGgs+uWab63Ksfqf0X6JuziDehz/rpK
         gO11SAeLYx8SseqKLayHMsVRQD1QYPvHYwaSJMlXMwas7UXYE9FFm8h25cfP/srS4V
         KPB95SfxGgI2rQdXHtW9f+1Mgl/cx/ccLQhKenK5t03N9CTRs2Uh0GlMcSA8wHruJI
         wdmkbA4z9thuGnm0UvG20IbxrInmX2kk9Jf0SpL5nmQGgFeY1M37s9Scjut1Eiaa/o
         vGNRTMvSqPPvsIH2Om98AeLL/gjLNHWUbLmEEnnMSiSR1dK1vdFtHwKw6/obJuvkLG
         NM8JIjg29KCcQ==
Message-ID: <ff3eb77a-ef9a-164c-2572-16d56dd2d5a7@kernel.org>
Date:   Fri, 3 Feb 2023 17:20:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] f2fs: fix to set ipu policy
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230202084815.70791-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230202084815.70791-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/2 16:48, Yangtao Li wrote:
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
> v3:
> -add check in __sbi_store()
> -introduce IS_F2FS_IPU_DISABLE()
> -convert to f2fs_lfs_mode()
>   fs/f2fs/segment.h | 10 +++++++++-
>   fs/f2fs/super.c   | 13 +++++++++----
>   fs/f2fs/sysfs.c   |  9 +++++++++
>   3 files changed, 27 insertions(+), 5 deletions(-)
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
> index fddff5deaed2..f06af2af215f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2302,6 +2302,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		}
>   	}
>   #endif
> +	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> +		err = -EINVAL;
> +		f2fs_warn(sbi, "LFS not compatible with IPU");

LFS is not compatible with IPU

> +		goto restore_opts;
> +	}
> +
>   	/* disallow enable atgc dynamically */
>   	if (no_atgc == !!test_opt(sbi, ATGC)) {
>   		err = -EINVAL;
> @@ -4081,10 +4087,9 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
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
>   	}
>   
>   	sbi->readdir_ra = true;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 3c6425f9ed0a..e1f1ebfa59d6 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -697,6 +697,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "ipu_policy")) {
> +		if (f2fs_lfs_mode(sbi))
> +			return -EINVAL;
> +		if (t >= BIT(F2FS_IPU_MAX))
> +			return -EINVAL;

if (t && f2fs_lfs_mode(sbi))
	return -EINVAL;

> +		SM_I(sbi)->ipu_policy = (unsigned int)t;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
