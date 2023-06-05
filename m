Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F128D7224E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjFELvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFELvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:51:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1FA4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:51:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 444A921B39;
        Mon,  5 Jun 2023 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685965904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWXI6wt2+qrPxokyP3MIOhyYU83+GbflH+z5Ur+r09w=;
        b=C/x8MXiGoGdezEmbhVM5AWo590QdfJNC5rTKr+zfYsF9rfvPLXtE6K0Fwe7fuA6FDqOH88
        wEeK8VdNj0w96RJNBl9kS/LQp4CkoHZbHhnFFp2c77m7X12lrvd1xfyHHBvaaSNRpKTedA
        Z0R5Il8RK59dy7h82UV0kLIpyfnUPNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685965904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mWXI6wt2+qrPxokyP3MIOhyYU83+GbflH+z5Ur+r09w=;
        b=2REczRNi2OWX+1b576rp1is0Me8n12Y9vz+gzjxxrOTn3wr9Bk6yE0Ap+imxk3rc5xu78u
        0EALgkNZAi95Y6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37DA8139C7;
        Mon,  5 Jun 2023 11:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wfySDVDMfWTWegAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Jun 2023 11:51:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5F4CA0754; Mon,  5 Jun 2023 13:51:43 +0200 (CEST)
Date:   Mon, 5 Jun 2023 13:51:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com,
        linux-kernel@vger.kernel.org,
        syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] quota: fix null-ptr-deref in ext4_acquire_dquot()
Message-ID: <20230605115143.i3squdbqmqebu5ue@quack3>
References: <20230527014018.47396-1-yebin10@huawei.com>
 <20230527014018.47396-2-yebin10@huawei.com>
 <20230530095726.t2grmww5rzofx5gp@quack3>
 <647ADA33.5010508@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m5qv73rr3afoouf3"
Content-Disposition: inline
In-Reply-To: <647ADA33.5010508@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m5qv73rr3afoouf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat 03-06-23 14:14:11, yebin (H) wrote:
> 
> 
> On 2023/5/30 17:57, Jan Kara wrote:
> > On Sat 27-05-23 09:40:17, Ye Bin wrote:
> > > Syzbot found the following issue:
> > > Unable to handle kernel paging request at virtual address dfff800000000005
> > > KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> > ...
> > > CPU: 0 PID: 6080 Comm: syz-executor747 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > pc : ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
> > > lr : dquot_to_inode fs/ext4/super.c:6740 [inline]
> > > lr : ext4_acquire_dquot+0x1ac/0x398 fs/ext4/super.c:6766
> > OK, this is bad...
> > 
> > > Above issue may happens as follows:
> > > ProcessA              ProcessB                    ProcessC
> > > sys_fsconfig
> > >    vfs_fsconfig_locked
> > >     reconfigure_super
> > >       ext4_remount
> > >        dquot_suspend -> suspend all type quota
> > > 
> > >                   sys_fsconfig
> > > 		  vfs_fsconfig_locked
> > > 		    reconfigure_super
> > > 		     ext4_remount
> > > 		      dquot_resume
> > > 		       ret = dquot_load_quota_sb
> > >                          add_dquot_ref
> > > 		                           do_open  -> open file O_RDWR
> > > 					    vfs_open
> > > 					     do_dentry_open
> > > 					      get_write_access
> > > 					       atomic_inc_unless_negative(&inode->i_writecount)
> > >                                                ext4_file_open
> > > 					       dquot_file_open
> > > 					        dquot_initialize
> > > 						  __dquot_initialize
> > > 						   dqget
> > > 						    if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
> > > 
> > > 			  __dquot_initialize
> > > 			   __dquot_initialize
> > > 			    dqget
> > > 			     if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
> > > 	                       ext4_acquire_dquot -> Return error
> > > 		       if (ret < 0)
> > > 	                 vfs_cleanup_quota_inode
> > > 			  dqopt->files[type] = NULL;
> > But I don't see how this can happen. The code in dquot_load_quota_sb()
> > looks like:
> > 
> >          error = add_dquot_ref(sb, type);
> >          if (error)
> >                  dquot_disable(sb, type, flags);
> > 
> > So if an error happens in add_dquot_ref(), we'll call dquot_disable().
> > dquot_disable() then does:
> > 
> >                  drop_dquot_ref(sb, cnt);
> >                  invalidate_dquots(sb, cnt);
> > 
> > and invalidate_dquots() waits for reference count of all dquots to drop to
> > 0. Hence if dqget() returned a dquot pointer to ProcessC, then ProcessB
> > should wait until ProcessC drops the dquot reference (hence
> > ext4_acquire_dquot() is done).
> > 
> > What am I missing?
> > 
> > 								Honza
> My reproduction condition is:
> mkfs.ext4 -F /dev/sda
> tune2fs  -Q usrquota /dev/sda
> 
> dquot_disable
> ...
>          if ((flags & DQUOT_USAGE_ENABLED && !(flags &
> DQUOT_LIMITS_ENABLED))
>              || (flags & DQUOT_SUSPENDED && flags & (DQUOT_LIMITS_ENABLED |
>              DQUOT_USAGE_ENABLED)))
>                  return -EINVAL;
> ...
> If without enable DQUOT_LIMITS_ENABLED dquot_disable() will just return
> -EINVAL.

Aha, that is the bug! Does attached patch fix your problem?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--m5qv73rr3afoouf3
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-quota-Properly-disable-quotas-when-add_dquot_ref-fai.patch"

From 2bb758bff7f9c92a25af7156cdeedc1f39201eba Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 5 Jun 2023 13:39:28 +0200
Subject: [PATCH] quota: Properly disable quotas when add_dquot_ref() fails

When add_dquot_ref() fails (usually due to IO error or ENOMEM), we want
to disable quotas we are trying to enable. However dquot_disable() call
was passed just the flags we are enabling so in case flags ==
DQUOT_USAGE_ENABLED dquot_disable() call will just fail with EINVAL
instead of properly disabling quotas. Fix the problem by always passing
DQUOT_LIMITS_ENABLED | DQUOT_USAGE_ENABLED to dquot_disable() in this
case.

Reported-by: Ye Bin <yebin10@huawei.com>
Reported-by: syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 226eb3cba1fb..e42cf387fa78 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2409,7 +2409,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
-- 
2.35.3


--m5qv73rr3afoouf3--
