Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453AA715AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjE3J5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjE3J5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:57:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41A9C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:57:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF09021A8B;
        Tue, 30 May 2023 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685440646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmXj3HNTjsUwVAZezuPc0zuSiCPXa6fgrbpfIWY+R8U=;
        b=vvDaECXS3ILXXNdMW9yXGRGoLHwq8YjsDeUoY2fXGCAzOX9jhc5obY0kCvplyfurFfE3AL
        FdFaEkqC1H+/fulIeNJBkfXIyX3+i5el4zAJ5U9EQd+2v2//o0ZyLItx0Lp7/cJUWTqhma
        H29ikzU84adIpL/9LqfP0PSuFY1JKY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685440646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nmXj3HNTjsUwVAZezuPc0zuSiCPXa6fgrbpfIWY+R8U=;
        b=czpzyc6GPWcA/FxkC5ui0/uS5ewWZ0qGTzHFtgxPQlCNspAqvOSIpOTIkE/dXybRCIewAp
        8zaaT+adGGoQu6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C310D13478;
        Tue, 30 May 2023 09:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aHqUL4bIdWTSSQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 09:57:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 54A34A0754; Tue, 30 May 2023 11:57:26 +0200 (CEST)
Date:   Tue, 30 May 2023 11:57:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] quota: fix null-ptr-deref in ext4_acquire_dquot()
Message-ID: <20230530095726.t2grmww5rzofx5gp@quack3>
References: <20230527014018.47396-1-yebin10@huawei.com>
 <20230527014018.47396-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527014018.47396-2-yebin10@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 27-05-23 09:40:17, Ye Bin wrote:
> Syzbot found the following issue:
> Unable to handle kernel paging request at virtual address dfff800000000005
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]

...
> CPU: 0 PID: 6080 Comm: syz-executor747 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
> lr : dquot_to_inode fs/ext4/super.c:6740 [inline]
> lr : ext4_acquire_dquot+0x1ac/0x398 fs/ext4/super.c:6766

OK, this is bad...

> Above issue may happens as follows:
> ProcessA              ProcessB                    ProcessC
> sys_fsconfig
>   vfs_fsconfig_locked
>    reconfigure_super
>      ext4_remount
>       dquot_suspend -> suspend all type quota
> 
>                  sys_fsconfig
> 		  vfs_fsconfig_locked
> 		    reconfigure_super
> 		     ext4_remount
> 		      dquot_resume
> 		       ret = dquot_load_quota_sb
>                         add_dquot_ref
> 		                           do_open  -> open file O_RDWR
> 					    vfs_open
> 					     do_dentry_open
> 					      get_write_access
> 					       atomic_inc_unless_negative(&inode->i_writecount)
>                                               ext4_file_open
> 					       dquot_file_open
> 					        dquot_initialize
> 						  __dquot_initialize
> 						   dqget
> 						    if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
> 
> 			  __dquot_initialize
> 			   __dquot_initialize
> 			    dqget
> 			     if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
> 	                       ext4_acquire_dquot -> Return error
> 		       if (ret < 0)
> 	                 vfs_cleanup_quota_inode
> 			  dqopt->files[type] = NULL;

But I don't see how this can happen. The code in dquot_load_quota_sb()
looks like:

        error = add_dquot_ref(sb, type);
        if (error)
                dquot_disable(sb, type, flags);

So if an error happens in add_dquot_ref(), we'll call dquot_disable().
dquot_disable() then does:

                drop_dquot_ref(sb, cnt);
                invalidate_dquots(sb, cnt);

and invalidate_dquots() waits for reference count of all dquots to drop to
0. Hence if dqget() returned a dquot pointer to ProcessC, then ProcessB
should wait until ProcessC drops the dquot reference (hence
ext4_acquire_dquot() is done).

What am I missing?

								Honza

> 
> 			                              ext4_acquire_dquot
> 						       -->dquot_to_inode(dquot) is NULL
> 
> To solve above issue, if quota has been loaded, there's unneed to cleaup quota
> inode if dquot_load_quota_sb() return failed when do dquot_resume();
> 
> Reported-by: syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/quota/dquot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index ffd40dc3e4e9..4b913faa48ec 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2476,7 +2476,7 @@ int dquot_resume(struct super_block *sb, int type)
>  		flags = dquot_generic_flag(flags, cnt);
>  		ret = dquot_load_quota_sb(sb, cnt, dqopt->info[cnt].dqi_fmt_id,
>  					  flags);
> -		if (ret < 0)
> +		if (ret < 0 && !sb_has_quota_loaded(sb, cnt))
>  			vfs_cleanup_quota_inode(sb, cnt);
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
