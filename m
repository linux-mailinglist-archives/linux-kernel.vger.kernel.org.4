Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14386627D58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiKNMHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiKNMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:07:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A016CE34
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:07:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0175C2273D;
        Mon, 14 Nov 2022 12:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668427653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jruMgBY5bV0IXTFQWV3qYvuLQLTE5ZFImlMF2xpEA5Y=;
        b=sEfZ7E1DbAUbXgkCZIRMQBKYjhXWPZLUTuP/QJOjUKZ38ukEIIqjuSLbFf+nP6Y/uXC3YO
        g3tVfmjTroj0w1pKMIu7IF8FibtgDEr7Rvhzu0SiTWLwINV/PSdqjydbOq8WMaeh8R247G
        ouDPiCuQFhNJiz7rutSmXtsi3z6Md4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668427653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jruMgBY5bV0IXTFQWV3qYvuLQLTE5ZFImlMF2xpEA5Y=;
        b=Zwz2Ev7xCTDiFs9XtgZx8PRSSNNW90giG+TDpHPMY98qrn+h7ZxAWYXGyDto3tuhPD9fiJ
        +oVfU9bvluhFWJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3FAC13A92;
        Mon, 14 Nov 2022 12:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xF6kN4QvcmMaEQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Nov 2022 12:07:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7089EA0709; Mon, 14 Nov 2022 13:07:32 +0100 (CET)
Date:   Mon, 14 Nov 2022 13:07:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, willy@infradead.org,
        damien.lemoal@opensource.wdc.com, akpm@linux-foundation.org,
        qhjin.dev@gmail.com, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix UBSAN detected shift-out-bounds error for bad
 superblock
Message-ID: <20221114120732.vephphzzpdkv2zam@quack3>
References: <20221114024957.60916-1-liaochang1@huawei.com>
 <20221114110459.x7yb6rhgwpi6kyjj@quack3>
 <90ca400b-050a-ec3e-b052-2cf1cd34c020@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90ca400b-050a-ec3e-b052-2cf1cd34c020@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-11-22 19:59:03, liaochang (A) wrote:
> 
> 
> 在 2022/11/14 19:04, Jan Kara 写道:
> > On Mon 14-11-22 10:49:57, Liao Chang wrote:
> >> UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
> >> shift exponent 8192 is too large for 32-bit type 'unsigned int'
> >> CPU: 1 PID: 32273 Comm: syz-executor.0 Tainted: G        W
> >> 6.1.0-rc4-dirty #11
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> >> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> >> Call Trace:
> >>  <TASK>
> >>  dump_stack_lvl+0xcd/0x134
> >>  ubsan_epilogue+0xb/0x50
> >>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x18d
> >>  minix_count_free_blocks.cold+0x16/0x1b
> >>  minix_statfs+0x22a/0x490
> >>  statfs_by_dentry+0x133/0x210
> >>  user_statfs+0xa9/0x160
> >>  __do_sys_statfs+0x7a/0xf0
> >>  do_syscall_64+0x35/0x80
> >>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >>
> >> The superblock stores on disk contains the size of a data zone, which is
> >> too large to used as the shift when kernel try to calculate the total
> >> size of zones, so it needs to check the superblock when kernel mounts
> >> MINIX-FS.
> >>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > 
> > Thanks for the patch. Just one nit:
> > 
> >> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> >> index da8bdd1712a7..f1d1c2312817 100644
> >> --- a/fs/minix/inode.c
> >> +++ b/fs/minix/inode.c
> >> @@ -166,6 +166,12 @@ static bool minix_check_superblock(struct super_block *sb)
> >>  	    sb->s_maxbytes > (7 + 512 + 512*512) * BLOCK_SIZE)
> >>  		return false;
> >>  
> >> +	/* the total size of zones must no exceed the limitation of U32_MAX. */
> >> +	if (sbi->s_log_zone_size && (sbi->s_nzones - sbi->s_firstdatazone) &&
> >> +	    (__builtin_clzl((__u32)(sbi->s_nzones - sbi->s_firstdatazone)) <=
> > 
> > Why this strange __builtin_clzl() function? We have a ffs() function in
> > the kernel for this :)
> 
> Great suggestion, i should use a compiler neutral API to caclulate leading zero count,
> what about count_leading_zeros()?

Yeah, that would work as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
