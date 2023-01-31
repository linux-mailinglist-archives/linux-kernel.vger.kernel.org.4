Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC368224B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjAaCkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAaCkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:40:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88086C16F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E1C61368
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821C9C433EF;
        Tue, 31 Jan 2023 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675132813;
        bh=gr3FF40RG7/jDbW76y2ObtVa388zzZP+2j5XpXFzoc0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=keDLHmhYTNnr0o7BZuDMWFGH3mnGIRB7tbemk0N9Vcy+HvpUZw7fBP8BKyzvfxBOi
         RuuYCs9LVS84RGdE14UQEPOc+NTNB+PfWtmdf+jgqUxCx+FVli8rhUO1ptNTfXdTfZ
         1J/h2N45iyYImfLYpaQ81kV8unD6n+AH0oHGLdoRhlnhWziD7YR/5EXwAaFrLjhdqg
         icmubEvP6E73ZEgk8+7eGsqgihRmAldBMQL9Qd0KUUi2bq57W66cTyHr/zuI8cAya5
         3GoWqSiMmVLaqbp/RuhhKP+Y0G3GtldZvT1JFfgYe2I63VJYghYswZ+KlEaBdtyqwU
         3aHVxUakW8QGQ==
Message-ID: <44982c50-49d6-5f04-f6d4-9d7d0dc5b92d@kernel.org>
Date:   Tue, 31 Jan 2023 10:40:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] f2fs: fix to set ipu policy
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230121051204.81251-1-frank.li@vivo.com>
 <20230121051204.81251-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230121051204.81251-2-frank.li@vivo.com>
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

On 2023/1/21 13:12, Yangtao Li wrote:
> For LFS mode, it should update outplace and no need inplace update.
> When using LFS mode for small-volume devices, IPU will not be used,
> and the OPU writing method is actually used, but F2FS_IPU_FORCE can
> be read from the ipu_policy node, which is different from the actual
> situation. And after remount, ipu should be disabled when convert to
> lfs mode, let's fix it.
> 
> Fixes: 84b89e5d943d ("f2fs: add auto tuning for small devices")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -restore old_ipu_policy for fail case in remount
>   fs/f2fs/segment.h | 2 ++
>   fs/f2fs/super.c   | 9 ++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index ad6a9c19f46a..704d27ad682d 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -670,6 +670,8 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>   
>   #define SMALL_VOLUME_SEGMENTS	(16 * 512)	/* 16GB */
>   
> +#define F2FS_IPU_DISABLE 0
> +
>   enum {
>   	F2FS_IPU_FORCE,
>   	F2FS_IPU_SSR,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0cedb693db58..1d2796863f8c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2156,6 +2156,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>   	struct f2fs_mount_info org_mount_opt;
>   	unsigned long old_sb_flags;
> +	unsigned int old_ipu_policy;
>   	int err;
>   	bool need_restart_gc = false, need_stop_gc = false;
>   	bool need_restart_ckpt = false, need_stop_ckpt = false;
> @@ -2179,6 +2180,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	 */
>   	org_mount_opt = sbi->mount_opt;
>   	old_sb_flags = sb->s_flags;
> +	old_ipu_policy = SM_I(sbi)->ipu_policy;
>   
>   #ifdef CONFIG_QUOTA
>   	org_mount_opt.s_jquota_fmt = F2FS_OPTION(sbi).s_jquota_fmt;
> @@ -2212,6 +2214,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
> @@ -2417,6 +2422,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		F2FS_OPTION(sbi).s_qf_names[i] = org_mount_opt.s_qf_names[i];
>   	}
>   #endif
> +	SM_I(sbi)->ipu_policy = old_ipu_policy;
>   	sbi->mount_opt = org_mount_opt;
>   	sb->s_flags = old_sb_flags;
>   	return err;
> @@ -3944,7 +3950,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>   	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
>   		if (f2fs_block_unit_discard(sbi))
>   			SM_I(sbi)->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
> -		SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
> +		if (F2FS_OPTION(sbi).fs_mode != FS_MODE_LFS)
> +			SM_I(sbi)->ipu_policy = BIT(F2FS_IPU_FORCE) | BIT(F2FS_IPU_HONOR_OPU_WRITE);
>   	}
>   
>   	sbi->readdir_ra = true;
