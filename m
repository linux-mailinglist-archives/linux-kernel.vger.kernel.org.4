Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893416362FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiKWPMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238490AbiKWPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:12:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9442DBF70
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:12:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CBD3B820BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950E7C433C1;
        Wed, 23 Nov 2022 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669216319;
        bh=E32LuTeewdv4LvRn43Fa4lz46cUSqIZ9KO69kapAzDQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=e1tBjLgkLI3ItIdUiZjmw+zk9GRtMBASep1CcRYCeSFQmcWN/gCX96cmqsfYSMXmk
         qvAtafUkufZK0T3ao79tZwW5k8C6EUMQ6RjciVOsKJohL7w6GblAzpB9kCG2IhgNO2
         /iyaRuT8ERmzp0qpsEmx9iAeZOV4wBkYgVrZBsw3NLPrWpuX2Nfn2RbEPeOde3gl0H
         V1uxNN8/EYTvsh9TtsNkfoFnP+SvkeYQIwpvnjbo2YZRj0AkRLKp+RCj822TKGHrer
         4YkC/8jc4LIGfa1d7/WSg4Oq56XDUrUG9qUF1A9pcCnaqQvg23h3LTgqRDrCQYvHIK
         aIO7mHe47R+TQ==
Message-ID: <c8145b2b-f8fa-9065-73dd-497c48a10a46@kernel.org>
Date:   Wed, 23 Nov 2022 23:11:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221115184023.78070-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to set DISCARD opt
In-Reply-To: <20221115184023.78070-1-frank.li@vivo.com>
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

On 2022/11/16 2:40, Yangtao Li wrote:
> Some minor modifications to discard opt and related parameters:
> 
>    1.introduce f2fs_is_readonly() and use it to simplify code
>    2.The FLUSH_MERGE opt is set by default only in non-ro mode.
>    3.When ro and DISCARD are set at the same time, an error is reported.
>    4.Display discard_unit mount opt when has discard opt.
>    5.clear DISCARD when remount as ro.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h  |  5 +++++
>   fs/f2fs/super.c | 53 +++++++++++++++++++++++++++----------------------
>   2 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b89b5d755ce0..be23059344b4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4579,4 +4579,9 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>   #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>   
> +static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
> +{
> +	return !!f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
> +}
> +
>   #endif /* _LINUX_F2FS_H */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 75027ff85cd9..baa8f0860192 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1353,12 +1353,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   		return -EINVAL;
>   	}
>   
> -	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
> -		test_opt(sbi, FLUSH_MERGE)) {
> +	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
>   		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
>   		return -EINVAL;
>   	}
>   
> +	if (f2fs_is_readonly(sbi) && test_opt(sbi, DISCARD)) {
> +		f2fs_err(sbi, "DISCARD not compatible with readonly mode");
> +		return -EINVAL;
> +	}

Well, it looks ext4 support mounting image w/ both discard and ro option.

And I guess for the case device is rw, and filesystem is ro, it may allow
filesystem itself issue command to trim device, and that won't break semantic
of readonly filesystem?

> +
>   	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
>   		f2fs_err(sbi, "Allow to mount readonly mode only");
>   		return -EROFS;
> @@ -2035,12 +2039,14 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   	if (test_opt(sbi, ATGC))
>   		seq_puts(seq, ",atgc");
>   
> -	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
> -		seq_printf(seq, ",discard_unit=%s", "block");
> -	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
> -		seq_printf(seq, ",discard_unit=%s", "segment");
> -	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
> -		seq_printf(seq, ",discard_unit=%s", "section");
> +	if (test_opt(sbi, DISCARD)) {
> +		if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK)
> +			seq_printf(seq, ",discard_unit=%s", "block");
> +		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
> +			seq_printf(seq, ",discard_unit=%s", "segment");
> +		else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
> +			seq_printf(seq, ",discard_unit=%s", "section");
> +	}
>   
>   	if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_NORMAL)
>   		seq_printf(seq, ",memory=%s", "normal");
> @@ -2081,9 +2087,10 @@ static void default_options(struct f2fs_sb_info *sbi)
>   	set_opt(sbi, MERGE_CHECKPOINT);
>   	F2FS_OPTION(sbi).unusable_cap = 0;
>   	sbi->sb->s_flags |= SB_LAZYTIME;
> -	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
> +	if (!f2fs_is_readonly(sbi))
>   		set_opt(sbi, FLUSH_MERGE);
> -	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
> +	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
> +		!f2fs_is_readonly(sbi))
>   		set_opt(sbi, DISCARD);
>   	if (f2fs_sb_has_blkzoned(sbi)) {
>   		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
> @@ -2221,7 +2228,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
>   	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
>   	bool no_atgc = !test_opt(sbi, ATGC);
> -	bool no_discard = !test_opt(sbi, DISCARD);
>   	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
>   	bool block_unit_discard = f2fs_block_unit_discard(sbi);
>   	struct discard_cmd_control *dcc;
> @@ -2398,19 +2404,18 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		need_stop_flush = true;
>   	}
>   
> -	if (no_discard == !!test_opt(sbi, DISCARD)) {
> -		if (test_opt(sbi, DISCARD)) {
> -			err = f2fs_start_discard_thread(sbi);
> -			if (err)
> -				goto restore_flush;
> -			need_stop_discard = true;
> -		} else {
> -			dcc = SM_I(sbi)->dcc_info;
> -			f2fs_stop_discard_thread(sbi);
> -			if (atomic_read(&dcc->discard_cmd_cnt))
> -				f2fs_issue_discard_timeout(sbi);
> -			need_restart_discard = true;
> -		}
> +	if ((*flags & SB_RDONLY) || !test_opt(sbi, DISCARD)) {
> +		clear_opt(sbi, DISCARD);
> +		dcc = SM_I(sbi)->dcc_info;
> +		f2fs_stop_discard_thread(sbi);
> +		if (atomic_read(&dcc->discard_cmd_cnt))
> +			f2fs_issue_discard_timeout(sbi);
> +		need_restart_discard = true;
> +	} else {
> +		err = f2fs_start_discard_thread(sbi);
> +		if (err)
> +			goto restore_flush;
> +		need_stop_discard = true;
>   	}
>   
>   	if (enable_checkpoint == !!test_opt(sbi, DISABLE_CHECKPOINT)) {
