Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0055628B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiKNVJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiKNVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:09:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67BC646F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sZ30F5obsFPS17sC1C07XeSVxIc97v+uSS5VSrqnm5Y=; b=JoX0BBAX1sgZDAnJmUzWe9h+5U
        6ExK3Fp5ni2PEi9stx3qAnhfEQ3700QOWSQPyLtzzuaQzUI7PqtkoMndCUXC9RwLfbxG1Yzd24pBc
        m6YiUNezNcltF9udb5p9cZgJW1xxP/43lQGor5pjB4vgcvKrWFCvUOxqd20ZVrxESl0EKUvYgvFV3
        i2xaoqomMeh2FOYkMKkI5i2jHC3YznVew5cEUEBwLOzcBooe8xdX+j0sb1CoxTh8WIqgtE0yC1wJO
        2prGP6JaIjdWuy9SR79nmHCz+trmArxp7NljIUJoRWtg/LCRIVwaH2sNxd50h9ZyjExBjkaDjnIDx
        JAG/f8BA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oughX-0053mI-OO; Mon, 14 Nov 2022 21:09:07 +0000
Message-ID: <e781f927-07f4-9165-1123-f9b501c552b1@infradead.org>
Date:   Mon, 14 Nov 2022 13:09:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] fs: Fix UBSAN detected shift-out-bounds error for bad
 superblock
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, willy@infradead.org,
        damien.lemoal@opensource.wdc.com, akpm@linux-foundation.org,
        jack@suse.cz, qhjin.dev@gmail.com, songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org
References: <20221114024957.60916-1-liaochang1@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221114024957.60916-1-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/22 18:49, Liao Chang wrote:
> UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
> shift exponent 8192 is too large for 32-bit type 'unsigned int'
> CPU: 1 PID: 32273 Comm: syz-executor.0 Tainted: G        W
> 6.1.0-rc4-dirty #11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xcd/0x134
>  ubsan_epilogue+0xb/0x50
>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x18d
>  minix_count_free_blocks.cold+0x16/0x1b
>  minix_statfs+0x22a/0x490
>  statfs_by_dentry+0x133/0x210
>  user_statfs+0xa9/0x160
>  __do_sys_statfs+0x7a/0xf0
>  do_syscall_64+0x35/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The superblock stores on disk contains the size of a data zone, which is
> too large to used as the shift when kernel try to calculate the total
> size of zones, so it needs to check the superblock when kernel mounts
> MINIX-FS.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  fs/minix/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index da8bdd1712a7..f1d1c2312817 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -166,6 +166,12 @@ static bool minix_check_superblock(struct super_block *sb)
>  	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
>  		return false;
>  
> +	/* the total size of zones must no exceed the limitation of U32_MAX. */

	                           must not exceed

> +	if (sbi->s_log_zone_size && (sbi->s_nzones - sbi->s_firstdatazone) &&
> +	    (__builtin_clzl((__u32)(sbi->s_nzones - sbi->s_firstdatazone)) <=
> +	     sbi->s_log_zone_size))
> +		return false;
> +
>  	return true;
>  }
>  

-- 
~Randy
