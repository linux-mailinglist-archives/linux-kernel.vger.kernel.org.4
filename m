Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E667FDCD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjA2JSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjA2JSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:18:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F211722033
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:18:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93E160C1E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAB8C433D2;
        Sun, 29 Jan 2023 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674983930;
        bh=ZO4R5GFH7plmtZcgYUOM0lIZ0IXWpK3idGVmrhNgHOU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eArWcfJes/FWOM+lE7l3eNmivCdFXfzdMN/pNYoFwBbo3NzdkAr3dbWzKoFSC/84T
         i49RWo6GcY8iI+Rs82tDJiQvHYVs06YepQHCsARS6aZp6Zg1kDmn9FNg6zJxsANNqL
         EH0xBR6T6Kqd+xNtAPvBzrSRnErW2PjIzhJ0vw42sI4PsSTJ5FrpJyMyL2KxShwKdQ
         +uX0SXMlnCL9HMeWkz/06+rEGDrxYmFbnCVyM4XrVrN5bnR4XA92latmhy5bdOefXn
         4g14W6e79I2mKV4GkVBlISS9v/JCj35V6Fh6fC6C+t6Bn630XEFqcQTFibXQe2LmeU
         cbs4N0g3U6cLA==
Message-ID: <5ad98a40-aa15-c6ea-e717-62b1364f18cb@kernel.org>
Date:   Sun, 29 Jan 2023 17:18:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: fix shift-out-of-bounds in f2fs_fill_super
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+fea4bcda5eb938ee88ed@syzkaller.appspotmail.com
References: <20230129075509.37107-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230129075509.37107-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/29 15:55, Yangtao Li wrote:
> syzbot reported a bug which could cause shift-out-of-bounds issue:
> 
> UBSAN: shift-out-of-bounds in fs/f2fs/super.c:4184:41
> shift exponent 613 is too large for 64-bit type 'loff_t' (aka 'long long')
> CPU: 1 PID: 5467 Comm: syz-executor.0 Not tainted 6.2.0-rc5-syzkaller #0
> Hardware name: Google Compute Engine/Google Compute Engine,
> 	BIOS Google 01/12/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:151 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x33d/0x3a0 lib/ubsan.c:321
>   f2fs_fill_super+0x5518/0x6ee0 fs/f2fs/super.c:4184
>   mount_bdev+0x26c/0x3a0 fs/super.c:1359
>   legacy_get_tree+0xea/0x180 fs/fs_context.c:610
>   vfs_get_tree+0x88/0x270 fs/super.c:1489
>   do_new_mount+0x289/0xad0 fs/namespace.c:3145
>   do_mount fs/namespace.c:3488 [inline]
>   __do_sys_mount fs/namespace.c:3697 [inline]
>   __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
> 
> Since currently only 4kb block size is supported by f2fs,
> let's use 4kb directly to avoid triggering UBSAN exception.

It doesn't fix the root cause...

How can we get invalid raw_super->log_blocksize value after below sanity check
in sanity_check_raw_super():

	/* Currently, support only 4KB block size */
	if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS) {
		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
			  le32_to_cpu(raw_super->log_blocksize),
			  F2FS_BLKSIZE_BITS);
		return -EFSCORRUPTED;
	}

Thanks,

> 
> Reported-by: syzbot+fea4bcda5eb938ee88ed@syzkaller.appspotmail.com
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d8a65645ee48..41c2bbd3e719 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4174,8 +4174,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   	if (err)
>   		goto free_options;
>   
> -	sb->s_maxbytes = max_file_blocks(NULL) <<
> -				le32_to_cpu(raw_super->log_blocksize);
> +	/* Currently, support only 4KB block size */
> +	sb->s_maxbytes = max_file_blocks(NULL) << F2FS_BLKSIZE_BITS;
>   	sb->s_max_links = F2FS_LINK_MAX;
>   
>   	err = f2fs_setup_casefold(sbi);
