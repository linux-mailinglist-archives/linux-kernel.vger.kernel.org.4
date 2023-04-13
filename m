Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1816E113B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjDMPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDMPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484BE19A4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA773634C4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637B2C433D2;
        Thu, 13 Apr 2023 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681400098;
        bh=5b1IzpQyge6KH+O/dVzMPOkhGkuOm+Ss22lyL9Jiwg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DL0eJVp3YYnrmtYR9co6LopRabVAVkS7Whb4L5S6ypLDygawuooYmHz56w1T0u+2X
         iQb/IaoTN1DuZJ5JPQVC38E0d6pCfVtd5DeXKinfcclvyr6gNq2JQvLOJ/0R2A0LRP
         EYbmUgXAaPo5ycXnxSaR81u83Ug0Lj8ltrLgr3gMUuvD/7DQFn9DWDbJaNOs7hOuO9
         gMtBTnmUtIws/OHTw4y+ldIRi6o4yG6uxixGq7btqe3HuxX8VoHWsrfMFu7OQSB+ko
         fXS7qCYKQxshN4rmtiXoet46bsutdG5aX+iWe7OLcvi1FlVXMBlGgYpWOF7yqliKZn
         NXxrXnT+9vylQ==
Message-ID: <e5dbb307-7337-1f5e-4bfd-b4736616bf57@kernel.org>
Date:   Thu, 13 Apr 2023 23:34:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] f2fs: export gc_mode in debugfs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230412165055.38461-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230412165055.38461-1-frank.li@vivo.com>
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

On 2023/4/13 0:50, Yangtao Li wrote:
> This patch exports gc_mode to debugfs. Since gc_urgent and gc_idle
> nodes can get gc mode, so remove gc_mode node.

What if some app/script is using gc_mode....it breaks its use.

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ------
>   fs/f2fs/debug.c                         | 13 ++++++++++++-
>   fs/f2fs/sysfs.c                         | 18 ------------------
>   3 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 8140fc98f5ae..3b78b8324263 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -643,12 +643,6 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	Show the accumulated total revoked atomic write block count after boot.
>   		If you write "0" here, you can initialize to "0".
>   
> -What:		/sys/fs/f2fs/<disk>/gc_mode
> -Date:		October 2022
> -Contact:	"Yangtao Li" <frank.li@vivo.com>
> -Description:	Show the current gc_mode as a string.
> -		This is a read-only entry.
> -
>   What:		/sys/fs/f2fs/<disk>/discard_urgent_util
>   Date:		November 2022
>   Contact:	"Yangtao Li" <frank.li@vivo.com>
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 61c35b59126e..5172b2417c08 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -366,6 +366,16 @@ static const char *ipu_mode_names[F2FS_IPU_MAX] = {
>   	[F2FS_IPU_HONOR_OPU_WRITE]	= "HONOR_OPU_WRITE",
>   };
>   
> +static const char *gc_mode_names[MAX_GC_MODE] = {
> +	[GC_NORMAL]		= "GC_NORMAL",
> +	[GC_IDLE_CB]		= "GC_IDLE_CB",
> +	[GC_IDLE_GREEDY]	= "GC_IDLE_GREEDY",
> +	[GC_IDLE_AT]		= "GC_IDLE_AT",
> +	[GC_URGENT_HIGH]	= "GC_URGENT_HIGH",
> +	[GC_URGENT_LOW]		= "GC_URGENT_LOW",
> +	[GC_URGENT_MID]		= "GC_URGENT_MID",
> +};
> +
>   static int stat_show(struct seq_file *s, void *v)
>   {
>   	struct f2fs_stat_info *si;
> @@ -409,7 +419,8 @@ static int stat_show(struct seq_file *s, void *v)
>   			for_each_set_bit(j, &policy, F2FS_IPU_MAX)
>   				seq_printf(s, " %s", ipu_mode_names[j]);
>   		}
> -		seq_puts(s, " ]\n\n");
> +		seq_puts(s, " ]\n");
> +		seq_printf(s, "  - GC: [ %s ]\n\n", gc_mode_names[sbi->gc_mode]);
>   
>   		if (test_opt(sbi, DISCARD))
>   			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 4d6263e556fa..c2873a94f7b2 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -41,16 +41,6 @@ enum {
>   	ATGC_INFO,	/* struct atgc_management */
>   };
>   
> -static const char *gc_mode_names[MAX_GC_MODE] = {
> -	"GC_NORMAL",
> -	"GC_IDLE_CB",
> -	"GC_IDLE_GREEDY",
> -	"GC_IDLE_AT",
> -	"GC_URGENT_HIGH",
> -	"GC_URGENT_LOW",
> -	"GC_URGENT_MID"
> -};
> -
>   struct f2fs_attr {
>   	struct attribute attr;
>   	ssize_t (*show)(struct f2fs_attr *a, struct f2fs_sb_info *sbi, char *buf);
> @@ -143,12 +133,6 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>   				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>   }
>   
> -static ssize_t gc_mode_show(struct f2fs_attr *a,
> -		struct f2fs_sb_info *sbi, char *buf)
> -{
> -	return sysfs_emit(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
> -}
> -
>   static ssize_t features_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -916,7 +900,6 @@ F2FS_GENERAL_RO_ATTR(encoding);
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
>   F2FS_GENERAL_RO_ATTR(pending_discard);
> -F2FS_GENERAL_RO_ATTR(gc_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -1008,7 +991,6 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(max_ordered_discard),
>   	ATTR_LIST(pending_discard),
> -	ATTR_LIST(gc_mode),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),
>   	ATTR_LIST(min_fsync_blocks),
