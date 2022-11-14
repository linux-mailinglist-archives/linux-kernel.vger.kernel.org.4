Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7210627B72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiKNLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiKNLFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:05:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171B51EED3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:05:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3A351FE87;
        Mon, 14 Nov 2022 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668423899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgofHueQsfs3qNuA1dNiSo+gMhUOLAfS3Mb/1AKlvTA=;
        b=bBlz5WkiSPCc6SphSadmU37rgQBDHDFpA6ABdxoxk9iehm7LSsgeo2ytx9/0rBI2SPhRSm
        axKzmBpFl3hvHvbFBSlFD0/rOHaRMxsn6LN1D4mfSFgNG7LbKibDsmYX6YmEgdaxjgvmp4
        /zXIG0BDdoZm6/lE6r1O3fNhBR7UZ9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668423899;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RgofHueQsfs3qNuA1dNiSo+gMhUOLAfS3Mb/1AKlvTA=;
        b=JPsg0s5iYd4HI9BhGNwKpUsgNrV7fN9tzxhujwLVjQTrSD069SIZS8du+dErnWj+5no2Qs
        /v7Q89gQOFLFZvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0AC713A8C;
        Mon, 14 Nov 2022 11:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bocxJ9sgcmNZbgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 11:04:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3634EA0709; Mon, 14 Nov 2022 12:04:59 +0100 (CET)
Date:   Mon, 14 Nov 2022 12:04:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     willy@infradead.org, damien.lemoal@opensource.wdc.com,
        akpm@linux-foundation.org, jack@suse.cz, qhjin.dev@gmail.com,
        songmuchun@bytedance.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix UBSAN detected shift-out-bounds error for bad
 superblock
Message-ID: <20221114110459.x7yb6rhgwpi6kyjj@quack3>
References: <20221114024957.60916-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114024957.60916-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-11-22 10:49:57, Liao Chang wrote:
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

Thanks for the patch. Just one nit:

> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index da8bdd1712a7..f1d1c2312817 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -166,6 +166,12 @@ static bool minix_check_superblock(struct super_block *sb)
>  	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
>  		return false;
>  
> +	/* the total size of zones must no exceed the limitation of U32_MAX. */
> +	if (sbi->s_log_zone_size && (sbi->s_nzones - sbi->s_firstdatazone) &&
> +	    (__builtin_clzl((__u32)(sbi->s_nzones - sbi->s_firstdatazone)) <=

Why this strange __builtin_clzl() function? We have a ffs() function in
the kernel for this :)

								Honza

> +	     sbi->s_log_zone_size))
> +		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
