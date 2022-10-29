Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12235611FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ2ESS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2ESR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AF160ED9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B87B82C9E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 04:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7964EC433C1;
        Sat, 29 Oct 2022 04:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017093;
        bh=bfmSe1xdl/TsRAPmZ7VtlLBP4R3hq8IJflIoAGQwlg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y/SDIuRoo7qMZgpwVx2nk+36jXpqXKjZoZuFJMSkNBhlfpYVPkl7770BuaOrjZlvu
         MpmXVB+BdddHZOxWo0il+ZRN2M/uZi0Y9O3QciuecUGf54lT+H6hECpOVE1Og28nv0
         +MQfeoGMDsqsuBKw+qcMmtXJ+L7PrnEotJkd6ZgMFd5gCWi7lY8G7xINgWKnBykLFJ
         Ao7bzln3ghPbd1tnOBbaFFnQ5hggvb1D0bDb1bCMXDNonk6dKClw3c8/maPFV4N/yQ
         6aSPYbfcTtBlZrr2HXKtdclzBT7UHdDIVlT7ojjKqIa32AC54X6BTVIPCTwco7TVQp
         5zoBGLffShSug==
Message-ID: <423b0738-e72a-7ae8-72dc-40f924d9fe0d@kernel.org>
Date:   Sat, 29 Oct 2022 12:18:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to set flush_merge opt and show
 noflush_merge
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221026130504.26312-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221026130504.26312-1-frank.li@vivo.com>
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

On 2022/10/26 21:05, Yangtao Li via Linux-f2fs-devel wrote:
> Some minor modifications to flush_merge and related parameters:
> 
>    1.The FLUSH_MERGE opt is set by default only in non-ro mode.
>    2.When ro and merge are set at the same time, an error is reported.
>    3.Display noflush_merge mount opt.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3834ead04620..475fa10c6007 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1347,6 +1347,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   		return -EINVAL;
>   	}
>   
> +	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb))
> +		 && test_opt(sbi, FLUSH_MERGE)) {

One more blank before &&.

> +		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
> +		return -EINVAL;
> +	}
> +
>   	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
>   		f2fs_err(sbi, "Allow to mount readonly mode only");
>   		return -EROFS;
> @@ -1935,8 +1941,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_puts(seq, ",inline_dentry");
>   	else
>   		seq_puts(seq, ",noinline_dentry");
> -	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
> +	if (test_opt(sbi, FLUSH_MERGE))
>   		seq_puts(seq, ",flush_merge");
> +	else
> +		seq_puts(seq, ",noflush_merge");
>   	if (test_opt(sbi, NOBARRIER))
>   		seq_puts(seq, ",nobarrier");
>   	if (test_opt(sbi, FASTBOOT))
> @@ -2065,7 +2073,8 @@ static void default_options(struct f2fs_sb_info *sbi)
>   	set_opt(sbi, MERGE_CHECKPOINT);
>   	F2FS_OPTION(sbi).unusable_cap = 0;
>   	sbi->sb->s_flags |= SB_LAZYTIME;
> -	set_opt(sbi, FLUSH_MERGE);
> +	if (!(f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)))

How about using more explicit condition?

if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)))

> +		set_opt(sbi, FLUSH_MERGE);
>   	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
>   		set_opt(sbi, DISCARD);
>   	if (f2fs_sb_has_blkzoned(sbi)) {
