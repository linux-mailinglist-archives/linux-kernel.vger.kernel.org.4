Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6AC611886
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJ1Q7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJ1Q7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12F7694A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39835B82BAF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D63C433C1;
        Fri, 28 Oct 2022 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976352;
        bh=/M2mrINHIA7P8HhyfSe/oGbwQhTLhA4oDq7xRt+Q2+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X23/rnsUUJLgNKoChlEbr7A0oe2azCDzIAaQElWoHKsaEiwbv+atCnERO4INTR4Bw
         QiiUjACAUg9WB5dZ5RLrzdHtieFbrcZ2o5ZcZx8KLJnXc01zks/sMLofw/JHTvnQyH
         Lg3aqDsuUzbpkfXZ0aSIfo3i8OZhl2iDCi/XlD2Wt8BReavQveT6MyetmWUR7GrD/f
         mrtPB0X4flPUzDTgHZGy0JA7SaRXbyIpqC4o0KYO6Zwxj7GfdG2m20k68n0l337CR3
         F7Ssey37tLAxi2JXAGXJLUq0HVU523Xtb/PEWLOKJBv7d1SnHEkgShMMSjerHh9PhY
         PBr9HQcfXDwcA==
Date:   Fri, 28 Oct 2022 09:59:11 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: introduce gc_mode sysfs node
Message-ID: <Y1wKXwLqse/kB6A9@google.com>
References: <20221025033217.14840-1-frank.li@vivo.com>
 <20221025033217.14840-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025033217.14840-2-frank.li@vivo.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I merged two patches and modified a bit. Please take a look.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=28ea9479410bab555db26e8437ea61b180e768d6

On 10/25, Yangtao Li wrote:
> gc_mode sysfs node can show the current gc_mode as a string.
> Introducing it increases readability.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
>  fs/f2fs/f2fs.h                          |  1 +
>  fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 483639fb727b..6466f3b1f0a9 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -634,3 +634,9 @@ Date:		July 2022
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
>  Description:	Show the accumulated total revoked atomic write block count after boot.
>  		If you write "0" here, you can initialize to "0".
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
>  	MAX_TIME,
>  };
>  
> +/* Note that you need to keep synchronization with this gc_mode_names array */
>  enum {
>  	GC_NORMAL,
>  	GC_IDLE_CB,
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 49898a7243ba..058857d8b3b9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -41,6 +41,16 @@ enum {
>  	ATGC_INFO,	/* struct atgc_management */
>  };
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
>  struct f2fs_attr {
>  	struct attribute attr;
>  	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
> @@ -133,6 +143,12 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
>  				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
>  }
>  
> +static ssize_t gc_mode_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	return sprintf(buf, "%s\n", gc_mode_names[sbi->gc_mode]);
> +}
> +
>  static ssize_t features_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -823,6 +839,7 @@ F2FS_GENERAL_RO_ATTR(encoding);
>  F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>  F2FS_GENERAL_RO_ATTR(main_blkaddr);
>  F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(gc_mode);
>  #ifdef CONFIG_F2FS_STAT_FS
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
>  F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
> @@ -904,6 +921,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(max_discard_issue_time),
>  	ATTR_LIST(discard_granularity),
>  	ATTR_LIST(pending_discard),
> +	ATTR_LIST(gc_mode),
>  	ATTR_LIST(batched_trim_sections),
>  	ATTR_LIST(ipu_policy),
>  	ATTR_LIST(min_ipu_util),
> -- 
> 2.25.1
