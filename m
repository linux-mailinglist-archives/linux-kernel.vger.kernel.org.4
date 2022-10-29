Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AF612012
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ2Ebd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2Eba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5F844C2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6015960A72
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F098C433D6;
        Sat, 29 Oct 2022 04:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017888;
        bh=nNh0/3K59uwZRZdDbebdJv0jIr90dVOrNs4fblMpaXg=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=U1gW/fTSoNfO8Mnd39FMhWKgBkP05152TE5rFWnlcWdYrTnnOxE1IMO8OlNgK0WV4
         515BdS3UCDQA9pdH1heV25VmyTorIEDpDjkpXLWRT/TMJfEnKv0nyIekdlIGOHaTB4
         sZrFvey637RII1SvbWnzHYROUTRTbnSdmHHWkPwBF8qAx9lcs3kJv1xohYbuOrNp39
         GQlvuBbqSNSeIxxRoEkau02TQw/X58/muhsMqoUzqMjvoY1xtEFd076kypVhMDfbKv
         iaUL7PeaaKgO6QZSCTj4NQDCpZ9ScA3HWKe1T8bsxEsgPa+YjYdnLw320z0CP+/g8p
         dQvM46kU3d4uQ==
Message-ID: <38fcacaf-fd22-6216-adf7-8f72fb0ca580@kernel.org>
Date:   Sat, 29 Oct 2022 12:31:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025033217.14840-1-frank.li@vivo.com>
 <20221025033217.14840-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: introduce gc_mode sysfs node
In-Reply-To: <20221025033217.14840-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor comments below.

On 2022/10/25 11:32, Yangtao Li wrote:
> gc_mode sysfs node can show the current gc_mode as a string.
> Introducing it increases readability.
Introducing it to increase readability.

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>   fs/f2fs/f2fs.h                          |  1 +
>   fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 483639fb727b..6466f3b1f0a9 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -634,3 +634,9 @@ Date:		July 2022
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	Show the accumulated total revoked atomic write block count after boot.
>   		If you write "0" here, you can initialize to "0".
> +
> +What:		/sys/fs/f2fs/<disk>/gc_mode
> +Date:		October 2022
> +Contact:	"Yangtao Li" <frank.li@vivo.com>
> +Description:	Show the current gc_mode as a string.
> +		This is a read-only entry.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e6355a5683b7..80f23e44a442 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1318,6 +1318,7 @@ enum {
>   	MAX_TIME,
>   };
>   
> +/* Note that you need to keep synchronization with this gc_mode_names array */

Good point.

/* Modification on enum should be synchronized with gc_mode_names array */

>   enum {
>   	GC_NORMAL,
>   	GC_IDLE_CB,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 49898a7243ba..058857d8b3b9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -41,6 +41,16 @@ enum {
>   	ATGC_INFO,	/* struct atgc_management */
>   };
>   
> +static const char *gc_mode_names[MAX_GC_MODE] = {
> +		"GC_NORMAL",
> +		"GC_IDLE_CB",
> +		"GC_IDLE_GREEDY",
> +		"GC_IDLE_AT",
> +		"GC_URGENT_HIGH",
> +		"GC_URGENT_LOW",
> +		"GC_URGENT_MID"
> +};
> +
>   struct f2fs_attr {
>   	struct attribute attr;
>   	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
> @@ -133,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>   				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>   }
>   
> +static ssize_t gc_mode_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
> +}
> +
>   static ssize_t features_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> @@ -823,6 +839,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
>   F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(gc_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>   F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -904,6 +921,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(max_discard_issue_time),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(pending_discard),
> +	ATTR_LIST(gc_mode),
>   	ATTR_LIST(batched_trim_sections),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),
