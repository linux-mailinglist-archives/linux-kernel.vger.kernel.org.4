Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87931715B40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjE3KPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjE3KP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:15:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AF9C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:15:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C01821A8B;
        Tue, 30 May 2023 10:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685441722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOquBtmYmWj6wRA30maxRoyQDgTMn6qUidToX23Hay0=;
        b=0HUHB5Qf2l5uWCEo482grI/uQxW0dS7EAV4uCWkTp6e/EykCSnPbGGjiNhtz1TKtDG8EK1
        Wbkob4MaHa5ae0Q8K1JS5Chppm3WybrXpLKZy1VE6fvFLxQrWGURsQ8jOnarYnpNgpk3Nx
        5wasnviQC2EvX20A7ZTgBvEgu024yuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685441722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOquBtmYmWj6wRA30maxRoyQDgTMn6qUidToX23Hay0=;
        b=C+qerUkK+7NZw23RHZeNLZjIhwxEA1lfGxMT/24cq2xA3+AKtWkj/f8vQnLeVbOeQnmkcu
        7CqIg1xMwUkjVMBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ED8413478;
        Tue, 30 May 2023 10:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zjIuG7rMdWTmTwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 10:15:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 05E4BA0754; Tue, 30 May 2023 12:15:22 +0200 (CEST)
Date:   Tue, 30 May 2023 12:15:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] quota: fix warning in dqgrab()
Message-ID: <20230530101521.37k7hcjyly2tqj5g@quack3>
References: <20230527014018.47396-1-yebin10@huawei.com>
 <20230527014018.47396-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527014018.47396-3-yebin10@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-05-23 09:40:18, Ye Bin wrote:
> There's issue as follows when do fault injection:
> WARNING: CPU: 1 PID: 14870 at include/linux/quotaops.h:51 dquot_disable+0x13b7/0x18c0
> Modules linked in:
> CPU: 1 PID: 14870 Comm: fsconfig Not tainted 6.3.0-next-20230505-00006-g5107a9c821af-dirty #541
> RIP: 0010:dquot_disable+0x13b7/0x18c0
> RSP: 0018:ffffc9000acc79e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88825e41b980
> RDX: 0000000000000000 RSI: ffff88825e41b980 RDI: 0000000000000002
> RBP: ffff888179f68000 R08: ffffffff82087ca7 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffed102f3ed026 R12: ffff888179f68130
> R13: ffff888179f68110 R14: dffffc0000000000 R15: ffff888179f68118
> FS:  00007f450a073740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffe96f2efd8 CR3: 000000025c8ad000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  dquot_load_quota_sb+0xd53/0x1060
>  dquot_resume+0x172/0x230
>  ext4_reconfigure+0x1dc6/0x27b0
>  reconfigure_super+0x515/0xa90
>  __x64_sys_fsconfig+0xb19/0xd20
>  do_syscall_64+0x39/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Above issue may happens as follows:
> ProcessA              ProcessB                    ProcessC
> sys_fsconfig
>   vfs_fsconfig_locked
>    reconfigure_super
>      ext4_remount
>       dquot_suspend -> suspend all type quota
> 
>                  sys_fsconfig
>                   vfs_fsconfig_locked
>                     reconfigure_super
>                      ext4_remount
>                       dquot_resume
>                        ret = dquot_load_quota_sb
>                         add_dquot_ref
>                                            do_open  -> open file O_RDWR
>                                             vfs_open
>                                              do_dentry_open
>                                               get_write_access
>                                                atomic_inc_unless_negative(&inode->i_writecount)
>                                               ext4_file_open
>                                                dquot_file_open
>                                                 dquot_initialize
>                                                   __dquot_initialize
>                                                    dqget
> 						    atomic_inc(&dquot->dq_count);
> 
>                           __dquot_initialize
>                            __dquot_initialize
>                             dqget
>                              if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>                                ext4_acquire_dquot
> 			        -> Return error DQ_ACTIVE_B flag isn't set
>                          dquot_disable
> 			  invalidate_dquots
> 			   if (atomic_read(&dquot->dq_count))
> 	                    dqgrab
> 			     WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
> 	                      -> Trigger warning
> 
> In the above scenario, 'dquot->dq_flags' has no DQ_ACTIVE_B is normal when
> dqgrab().
> So just remove 'WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))'
> in dqgrab().
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch! Actually rather than deleting the assertion from
dqgrab() (which can be and is used by filesystems) I'd replace the dqgrab()
use in invalidate_dquots() with plain:

	atomic_inc(&dquot->dq_count);

								Honza

> ---
>  include/linux/quotaops.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 11a4becff3a9..cb5e4c11e503 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -48,7 +48,6 @@ static inline struct dquot *dqgrab(struct dquot *dquot)
>  {
>  	/* Make sure someone else has active reference to dquot */
>  	WARN_ON_ONCE(!atomic_read(&dquot->dq_count));
> -	WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
>  	atomic_inc(&dquot->dq_count);
>  	return dquot;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
