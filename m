Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E507762830D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiKNOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:43:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9541E707
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:43:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3943C6121B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A3EC433D7;
        Mon, 14 Nov 2022 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668436979;
        bh=w4GrNzhovrN80KKmTP2OEJZe9pNiPh8tGOWQIrUQZus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ncvG4DeWFq6xXs+ZW79xASuvQr7k2XuWyvfIPei5CXCWhpdppn3qUlKZq2OpObWy1
         snozfaLE4xN5Bnn4j96gNbHbIw8zOmmScXzdCsPNuCntlT7SCdr66IP66CgX+XvuAl
         psqFTm4OKPWDYN/La0sU9No1J3NRL0r22KrS/dvI3TMeLyGXDLlIVXtIsCw/OjVLTY
         xW4GaZz6xe4AeNcrt+dpTsmZEZaaJQ2YIUwnwdXg83JpUg0F7Z1riWjpJuf43Qf4iY
         +AoOgpUfFKFLj5qxJlNELviCCkL02L57/LzUI7FKNz5rw5J+mdJzumS88TVlULreGR
         021NfSwdR2pwg==
Message-ID: <983de611-a9e7-56d0-d375-f2b54e1f4d05@kernel.org>
Date:   Mon, 14 Nov 2022 22:42:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] f2fs: fix to alloc_mode changed after remount on a
 small volume device
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221112083250.295700-1-Yuwei.Guan@zeekrlife.com>
 <20221112083250.295700-2-Yuwei.Guan@zeekrlife.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221112083250.295700-2-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/12 16:32, Yuwei Guan wrote:
> The commit 84b89e5d943d8 ("f2fs: add auto tuning for small devices") add
> tuning for small volume device, now support to tune alloce_mode to 'reuse'
> if it's small size. But the alloc_mode will change to 'default' when do
> remount on this small size dievce.
> 
> The commit 4cac90d5491c9 ("f2fs: relocate readdir_ra configure
> initialization") relocates readdir_ra variable to tuning process.
> 
> This patch fo fix alloc_mode changed when do remount for a small volume
> device.
> 
> For a small device,
> - alloc_mode will keep 'reuse', if no alloc_mode option in remount
>    command,
> - alloc_mode will be set as remount command, if it has 'alloc_mode='.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> ---
>   fs/f2fs/super.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3834ead04620..2f36824ff84b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2190,6 +2190,23 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>   	f2fs_flush_ckpt_thread(sbi);
>   }
>   
> +static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi, bool is_remount)
> +{
> +	struct f2fs_sm_info *sm_i = SM_I(sbi);
> +
> +	/* adjust parameters according to the volume size */
> +	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
> +		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;

How about moving above logic into default_options()?

Thanks,

> +		if (f2fs_block_unit_discard(sbi))
> +			sm_i->dcc_info->discard_granularity = 1;
> +		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
> +					1 << F2FS_IPU_HONOR_OPU_WRITE;
> +	}
> +
> +	if (!is_remount)
> +		sbi->readdir_ra = 1;
> +}
> +
>   static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -2248,6 +2265,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   
>   	default_options(sbi);
>   
> +	f2fs_tuning_parameters(sbi, true);
> +
>   	/* parse mount options */
>   	err = parse_options(sb, data, true);
>   	if (err)
> @@ -4054,22 +4073,6 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
>   	return 0;
>   }
>   
> -static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
> -{
> -	struct f2fs_sm_info *sm_i = SM_I(sbi);
> -
> -	/* adjust parameters according to the volume size */
> -	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
> -		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
> -		if (f2fs_block_unit_discard(sbi))
> -			sm_i->dcc_info->discard_granularity = 1;
> -		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
> -					1 << F2FS_IPU_HONOR_OPU_WRITE;
> -	}
> -
> -	sbi->readdir_ra = 1;
> -}
> -
>   static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   {
>   	struct f2fs_sb_info *sbi;
> @@ -4475,7 +4478,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   
>   	f2fs_join_shrinker(sbi);
>   
> -	f2fs_tuning_parameters(sbi);
> +	f2fs_tuning_parameters(sbi, false);
>   
>   	f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
>   		    cur_cp_version(F2FS_CKPT(sbi)));
