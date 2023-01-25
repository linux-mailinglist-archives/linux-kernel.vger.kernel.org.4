Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93467B601
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjAYPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjAYPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262F5974A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674660723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=el7HX/N4/qLhZTGuOS7x+JGqMjMHotsdh+vI3gtfghQ=;
        b=Y+E8DYEK71lghjPP2q5LInPOwTqXp4CqWjW8wYHs5YLTJBYlTLxeKriONRNt5pGCB+rYSL
        Y2xTk2202cY3SzGMw4bFEu5Zjo+tV+yHNxd79ownAm/oNgcMoDrSXN5lXiQ0TeFNpcvHFS
        TgfG7W+bUTfD8lciv+IEoR1UhlWRsh8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-wxBgH001M96EavfQnnWevg-1; Wed, 25 Jan 2023 10:32:02 -0500
X-MC-Unique: wxBgH001M96EavfQnnWevg-1
Received: by mail-pf1-f200.google.com with SMTP id p19-20020aa78613000000b005906fe76eb9so403631pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el7HX/N4/qLhZTGuOS7x+JGqMjMHotsdh+vI3gtfghQ=;
        b=ZZAB4F4O2R52Wd869O2jS94R28uL5yQTTK7mt+zUQRrshzDyftdOrJsdEoE+mALLA9
         lQO8RT5QNIP8cGnyRP4+XSnDWVSE2Gyj6gIg5nrrYutVch7v/7YL6elovygd2rLgq0si
         3UBDSKp6cjs/g2b9l4Zky58wvbN0+QaJypjI5G6qTx/60axUApbc7s6lMSPAupaMYJaO
         oTggqUhgsuIlHNGfh7D1ZawIVEiVuJ9RwsQKIY9g4e4s1pJLxqHMISUxH458ylRysRaQ
         5d9RQi+XWZh6YnL0TRcZzOZKlJJtrmzJ6atUwUlRAJVSKifyYTP4VciQveB3G+y4xJTf
         rxJQ==
X-Gm-Message-State: AFqh2kr+bJqJ9NGp+9/c55Zwqtmvmtgzk9vyM5uucCCiq4abzVUEwHbf
        BDwFS3S/ytKaBaChIokWRC8NcoTh4+Ft4BAItfUR4EzkKZjvqLyw6jzrw0FA5M1O9Q0FOhhAEdP
        JYYk2bsYYvpJBxkxLsewyi1+E
X-Received: by 2002:a05:6a20:699b:b0:b8:a4e7:7940 with SMTP id t27-20020a056a20699b00b000b8a4e77940mr42674770pzk.11.1674660721096;
        Wed, 25 Jan 2023 07:32:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvgoYge8da7/k/BGY+HjNf6I5P9wrJMV5+zSv28A4KrUus69yquT6hZ6bX9S1152hhuyMcupg==
X-Received: by 2002:a05:6a20:699b:b0:b8:a4e7:7940 with SMTP id t27-20020a056a20699b00b000b8a4e77940mr42674752pzk.11.1674660720784;
        Wed, 25 Jan 2023 07:32:00 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id q1-20020a63bc01000000b004b1fef0bf16sm3387567pge.73.2023.01.25.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 07:32:00 -0800 (PST)
Date:   Thu, 26 Jan 2023 00:31:56 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Subject: Re: [PATCH -next] udf: Fix a race condition between udf_rename() and
 udf_expand_dir_adinicb()
Message-ID: <Y9FLbOOna1ntLRbT@kernel-devel>
References: <20230124173015.3213309-1-syoshida@redhat.com>
 <20230125091613.6pg5ft3lpcwijw6q@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125091613.6pg5ft3lpcwijw6q@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Wed, Jan 25, 2023 at 10:16:13AM +0100, Jan Kara wrote:
> On Wed 25-01-23 02:30:15, Shigeru Yoshida wrote:
> > syzbot reported a general fault in udf_filter_write_fi() [1].  This
> > causes a stack trace like below:
> > 
> > general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> > CPU: 0 PID: 5127 Comm: syz-executor298 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
> > ...
> > Call Trace:
> >  <TASK>
> >  udf_rename+0x69d/0xb80 fs/udf/namei.c:874
> >  vfs_rename+0x1162/0x1a90 fs/namei.c:4780
> >  do_renameat2+0xb22/0xc30 fs/namei.c:4931
> >  __do_sys_rename fs/namei.c:4977 [inline]
> >  __se_sys_rename fs/namei.c:4975 [inline]
> >  __x64_sys_rename+0x81/0xa0 fs/namei.c:4975
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > The cause of this issue is a race condition between udf_rename() and
> > udf_expand_dir_adinicb().
> > 
> > If udf_rename() and udf_expand_dir_adinicb() run concurrently,
> > iinfo->i_alloc_type can be changed by udf_expand_dir_adinicb() while
> > udf_rename() is running.  This causes NULL pointer dereference for
> > iter->bh[0]->b_data in udf_fiiter_write_fi().
> > 
> > Link: https://syzkaller.appspot.com/bug?id=2811e6cdd35ea1df1fa2ef31b8d92c6408aa15d2 [1]
> > Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> 
> Thanks for the patch but I have already fixed the bug in a patch I've
> posted here [1]. A cleaner fix is actually to use i_rwsem to protect moved
> directory from other modifications (which is what I did).

Thanks for your feedback.  I've missed the patch you mentioned and
your patch is more elegant than mine.

Thank you~
Shigeru

> 
> [1] https://lore.kernel.org/all/20230124121814.25951-14-jack@suse.cz
> 
> 								Honza
> 
> > ---
> >  fs/udf/namei.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> > index 06f066ba3072..5048652c6cd4 100644
> > --- a/fs/udf/namei.c
> > +++ b/fs/udf/namei.c
> > @@ -149,6 +149,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  	uint8_t *impuse;
> >  	int ret;
> >  
> > +	down_write(&iinfo->i_data_sem);
> > +
> >  	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
> >  		alloctype = ICBTAG_FLAG_AD_SHORT;
> >  	else
> > @@ -157,7 +159,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  	if (!inode->i_size) {
> >  		iinfo->i_alloc_type = alloctype;
> >  		mark_inode_dirty(inode);
> > -		return NULL;
> > +		goto out;
> >  	}
> >  
> >  	/* alloc block, and copy data to it */
> > @@ -165,15 +167,15 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  			       iinfo->i_location.partitionReferenceNum,
> >  			       iinfo->i_location.logicalBlockNum, err);
> >  	if (!(*block))
> > -		return NULL;
> > +		goto out;
> >  	newblock = udf_get_pblock(inode->i_sb, *block,
> >  				  iinfo->i_location.partitionReferenceNum,
> >  				0);
> >  	if (!newblock)
> > -		return NULL;
> > +		goto out;
> >  	dbh = udf_tgetblk(inode->i_sb, newblock);
> >  	if (!dbh)
> > -		return NULL;
> > +		goto out;
> >  	lock_buffer(dbh);
> >  	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
> >  	memset(dbh->b_data + inode->i_size, 0,
> > @@ -197,7 +199,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  	if (ret < 0) {
> >  		*err = ret;
> >  		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
> > -		return NULL;
> > +		goto out;
> >  	}
> >  	mark_inode_dirty(inode);
> >  
> > @@ -213,6 +215,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  			impuse = NULL;
> >  		udf_fiiter_write_fi(&iter, impuse);
> >  	}
> > +	up_write(&iinfo->i_data_sem);
> > +
> >  	/*
> >  	 * We don't expect the iteration to fail as the directory has been
> >  	 * already verified to be correct
> > @@ -221,6 +225,9 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
> >  	udf_fiiter_release(&iter);
> >  
> >  	return dbh;
> > +out:
> > +	up_write(&iinfo->i_data_sem);
> > +	return NULL;
> >  }
> >  
> >  static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
> > @@ -766,6 +773,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> >  	bool has_diriter = false;
> >  	int retval;
> >  	struct kernel_lb_addr tloc;
> > +	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
> >  
> >  	if (flags & ~RENAME_NOREPLACE)
> >  		return -EINVAL;
> > @@ -780,11 +788,13 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> >  		goto out_oiter;
> >  	}
> >  
> > +	down_read(&old_iinfo->i_data_sem);
> > +
> >  	if (S_ISDIR(old_inode->i_mode)) {
> >  		if (new_inode) {
> >  			retval = -ENOTEMPTY;
> >  			if (!empty_dir(new_inode))
> > -				goto out_oiter;
> > +				goto out_unlock;
> >  		}
> >  		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
> >  					       &diriter);
> > @@ -795,7 +805,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> >  			retval = -EFSCORRUPTED;
> >  		}
> >  		if (retval)
> > -			goto out_oiter;
> > +			goto out_unlock;
> >  		has_diriter = true;
> >  		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
> >  		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
> > @@ -805,25 +815,25 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> >  				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
> >  				old_inode->i_ino, old_dir->i_ino,
> >  				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
> > -			goto out_oiter;
> > +			goto out_unlock;
> >  		}
> >  	}
> >  
> >  	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
> >  	if (retval && retval != -ENOENT)
> > -		goto out_oiter;
> > +		goto out_unlock;
> >  	/* Entry found but not passed by VFS? */
> >  	if (!retval && !new_inode) {
> >  		retval = -EFSCORRUPTED;
> >  		udf_fiiter_release(&niter);
> > -		goto out_oiter;
> > +		goto out_unlock;
> >  	}
> >  	/* Entry not found? Need to add one... */
> >  	if (retval) {
> >  		udf_fiiter_release(&niter);
> >  		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
> >  		if (retval)
> > -			goto out_oiter;
> > +			goto out_unlock;
> >  	}
> >  
> >  	/*
> > @@ -882,7 +892,10 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> >  			mark_inode_dirty(new_dir);
> >  		}
> >  	}
> > +	up_read(&old_iinfo->i_data_sem);
> >  	return 0;
> > +out_unlock:
> > +	up_read(&old_iinfo->i_data_sem);
> >  out_oiter:
> >  	if (has_diriter)
> >  		udf_fiiter_release(&diriter);
> > -- 
> > 2.39.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

