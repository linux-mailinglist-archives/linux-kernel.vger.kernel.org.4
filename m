Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C107745E95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGCOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjGCOgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:36:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7B7E69
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:36:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D12C41FEB5;
        Mon,  3 Jul 2023 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688395003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71USX0E8uxJRhdrwFtwHUBM0OTncRS714ApHzQ/UV7Q=;
        b=kKSLyGgZ4plUmjPQZGndFXoy4hMkYaWJ62y1IfW0GtY6eJJktJAD0Lmv5mhkeZLsk0/1sG
        ESQv0EfkNGF/PMAyfqqlHHeF5mpf8dH2cVxeF7r1+oPm+LndLtyBpnkULopsrtXlf9mH+3
        /7Y8YDg0a2KkH4n9Qtftgvzw1tHycDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688395003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=71USX0E8uxJRhdrwFtwHUBM0OTncRS714ApHzQ/UV7Q=;
        b=cbc+pHSv3SB2J2yUndPvPMZD9eqHJfKCAEQTkOV1JZDUPczvfbwpncvsNjmivTs6vwN23n
        5eq5mNZFwcqt9/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C27AE13276;
        Mon,  3 Jul 2023 14:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tZNpL/vcomRvQgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Jul 2023 14:36:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 557F9A0722; Mon,  3 Jul 2023 16:36:43 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:36:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Jan Kara <jack@suse.cz>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: fs/namei.c:4875 vfs_rename() warn: variable dereferenced before
 check 'source' (see line 4830)
Message-ID: <20230703143643.e7qlewcgwfhdcrdq@quack3>
References: <a8200507-8e52-422d-85ad-22be78930099@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8200507-8e52-422d-85ad-22be78930099@kadam.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-07-23 15:16:36, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   995b406c7e972fab181a4bb57f3b95e59b8e5bf3
> commit: 28eceeda130f5058074dd007d9c59d2e8bc5af2e fs: Lock moved directories
> config: x86_64-randconfig-m001-20230702 (https://download.01.org/0day-ci/archive/20230703/202307030026.9sE2pk2x-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230703/202307030026.9sE2pk2x-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202307030026.9sE2pk2x-lkp@intel.com/
> 
> New smatch warnings:
> fs/namei.c:4875 vfs_rename() warn: variable dereferenced before check 'source' (see line 4830)

Yeah, the check for source being non-NULL in:

	if (source)
		inode_unlock(source);

is pointless. When we are renaming something, we are guaranteed "something"
exists ;). I'll send a cleanup patch.

								Honza

> 
> vim +/source +4875 fs/namei.c
> 
> 9fe61450972d39 Christian Brauner     2021-01-21  4752  int vfs_rename(struct renamedata *rd)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4753  {
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4754  	int error;
> 9fe61450972d39 Christian Brauner     2021-01-21  4755  	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
> 9fe61450972d39 Christian Brauner     2021-01-21  4756  	struct dentry *old_dentry = rd->old_dentry;
> 9fe61450972d39 Christian Brauner     2021-01-21  4757  	struct dentry *new_dentry = rd->new_dentry;
> 9fe61450972d39 Christian Brauner     2021-01-21  4758  	struct inode **delegated_inode = rd->delegated_inode;
> 9fe61450972d39 Christian Brauner     2021-01-21  4759  	unsigned int flags = rd->flags;
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4760  	bool is_dir = d_is_dir(old_dentry);
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4761  	struct inode *source = old_dentry->d_inode;
> 9055cba711891a Sage Weil             2011-05-24  4762  	struct inode *target = new_dentry->d_inode;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4763  	bool new_is_dir = false;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4764  	unsigned max_links = new_dir->i_sb->s_max_links;
> 49d31c2f389acf Al Viro               2017-07-07  4765  	struct name_snapshot old_name;
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4766  
> 8d3e2936375bac Miklos Szeredi        2016-12-16  4767  	if (source == target)
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4768  		return 0;
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4769  
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4770  	error = may_delete(rd->old_mnt_idmap, old_dir, old_dentry, is_dir);
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4771  	if (error)
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4772  		return error;
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4773  
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4774  	if (!target) {
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4775  		error = may_create(rd->new_mnt_idmap, new_dir, new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4776  	} else {
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4777  		new_is_dir = d_is_dir(new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4778  
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4779  		if (!(flags & RENAME_EXCHANGE))
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4780  			error = may_delete(rd->new_mnt_idmap, new_dir,
> 6521f891708292 Christian Brauner     2021-01-21  4781  					   new_dentry, is_dir);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4782  		else
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4783  			error = may_delete(rd->new_mnt_idmap, new_dir,
> 6521f891708292 Christian Brauner     2021-01-21  4784  					   new_dentry, new_is_dir);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4785  	}
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4786  	if (error)
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4787  		return error;
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4788  
> 2773bf00aeb9bf Miklos Szeredi        2016-09-27  4789  	if (!old_dir->i_op->rename)
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4790  		return -EPERM;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4791  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4792  	/*
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4793  	 * If we are going to change the parent - check write permissions,
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4794  	 * we'll need to flip '..'.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4795  	 */
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4796  	if (new_dir != old_dir) {
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4797  		if (is_dir) {
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4798  			error = inode_permission(rd->old_mnt_idmap, source,
> 47291baa8ddfda Christian Brauner     2021-01-21  4799  						 MAY_WRITE);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4800  			if (error)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4801  				return error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4802  		}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4803  		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
> 4609e1f18e19c3 Christian Brauner     2023-01-13  4804  			error = inode_permission(rd->new_mnt_idmap, target,
> 47291baa8ddfda Christian Brauner     2021-01-21  4805  						 MAY_WRITE);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4806  			if (error)
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4807  				return error;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4808  		}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4809  	}
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4810  
> 0b3974eb04c487 Miklos Szeredi        2014-04-01  4811  	error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry,
> 0b3974eb04c487 Miklos Szeredi        2014-04-01  4812  				      flags);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4813  	if (error)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4814  		return error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4815  
> 49d31c2f389acf Al Viro               2017-07-07  4816  	take_dentry_name_snapshot(&old_name, old_dentry);
> 1d2ef590148300 Al Viro               2011-09-14  4817  	dget(new_dentry);
> 28eceeda130f50 Jan Kara              2023-06-01  4818  	/*
> 28eceeda130f50 Jan Kara              2023-06-01  4819  	 * Lock all moved children. Moved directories may need to change parent
> 28eceeda130f50 Jan Kara              2023-06-01  4820  	 * pointer so they need the lock to prevent against concurrent
> 28eceeda130f50 Jan Kara              2023-06-01  4821  	 * directory changes moving parent pointer. For regular files we've
> 28eceeda130f50 Jan Kara              2023-06-01  4822  	 * historically always done this. The lockdep locking subclasses are
> 28eceeda130f50 Jan Kara              2023-06-01  4823  	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
> 28eceeda130f50 Jan Kara              2023-06-01  4824  	 * regular files and directories so it's difficult to tell which
> 28eceeda130f50 Jan Kara              2023-06-01  4825  	 * subclasses to use.
> 28eceeda130f50 Jan Kara              2023-06-01  4826  	 */
> 28eceeda130f50 Jan Kara              2023-06-01  4827  	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
> 9055cba711891a Sage Weil             2011-05-24  4828  
> 51cc3a6620a6ca Hugh Dickins          2021-09-02  4829  	error = -EPERM;
> 51cc3a6620a6ca Hugh Dickins          2021-09-02 @4830  	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
>                                                                         ^^^^^^
> Dereferenced.
> 
> 51cc3a6620a6ca Hugh Dickins          2021-09-02  4831  		goto out;
>                                                                 ^^^^^^^^
> 51cc3a6620a6ca Hugh Dickins          2021-09-02  4832  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4833  	error = -EBUSY;
> 7af1364ffa64db Eric W. Biederman     2013-10-04  4834  	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
> 9055cba711891a Sage Weil             2011-05-24  4835  		goto out;
> 9055cba711891a Sage Weil             2011-05-24  4836  
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4837  	if (max_links && new_dir != old_dir) {
> 8de52778798fe3 Al Viro               2012-02-06  4838  		error = -EMLINK;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4839  		if (is_dir && !new_is_dir && new_dir->i_nlink >= max_links)
> 8de52778798fe3 Al Viro               2012-02-06  4840  			goto out;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4841  		if ((flags & RENAME_EXCHANGE) && !is_dir && new_is_dir &&
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4842  		    old_dir->i_nlink >= max_links)
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4843  			goto out;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4844  	}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4845  	if (!is_dir) {
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4846  		error = try_break_deleg(source, delegated_inode);
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4847  		if (error)
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4848  			goto out;
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4849  	}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4850  	if (target && !new_is_dir) {
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4851  		error = try_break_deleg(target, delegated_inode);
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4852  		if (error)
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4853  			goto out;
> 8e6d782cab5088 J. Bruce Fields       2011-09-20  4854  	}
> e18275ae55e07a Christian Brauner     2023-01-13  4855  	error = old_dir->i_op->rename(rd->new_mnt_idmap, old_dir, old_dentry,
> 520c8b16505236 Miklos Szeredi        2014-04-01  4856  				      new_dir, new_dentry, flags);
> 51892bbb57e878 Sage Weil             2011-05-24  4857  	if (error)
> 51892bbb57e878 Sage Weil             2011-05-24  4858  		goto out;
> 51892bbb57e878 Sage Weil             2011-05-24  4859  
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4860  	if (!(flags & RENAME_EXCHANGE) && target) {
> 8767712f26d18a Al Viro               2018-05-27  4861  		if (is_dir) {
> 8767712f26d18a Al Viro               2018-05-27  4862  			shrink_dcache_parent(new_dentry);
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4863  			target->i_flags |= S_DEAD;
> 8767712f26d18a Al Viro               2018-05-27  4864  		}
> d83c49f3e36cec Al Viro               2010-04-30  4865  		dont_mount(new_dentry);
> 8ed936b5671bfb Eric W. Biederman     2013-10-01  4866  		detach_mounts(new_dentry);
> bc27027a73e8b8 Miklos Szeredi        2014-04-01  4867  	}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4868  	if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE)) {
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4869  		if (!(flags & RENAME_EXCHANGE))
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4870  			d_move(old_dentry, new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4871  		else
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4872  			d_exchange(old_dentry, new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4873  	}
> 51892bbb57e878 Sage Weil             2011-05-24  4874  out:
> 28eceeda130f50 Jan Kara              2023-06-01 @4875  	if (source)
>                                                             ^^^^^^
> This check could be removed.
> 
> 28eceeda130f50 Jan Kara              2023-06-01  4876  		inode_unlock(source);
> 28eceeda130f50 Jan Kara              2023-06-01  4877  	if (target)
> 5955102c9984fa Al Viro               2016-01-22  4878  		inode_unlock(target);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4879  	dput(new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4880  	if (!error) {
> f4ec3a3d43bcdc Al Viro               2019-04-26  4881  		fsnotify_move(old_dir, new_dir, &old_name.name, is_dir,
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4882  			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4883  		if (flags & RENAME_EXCHANGE) {
> f4ec3a3d43bcdc Al Viro               2019-04-26  4884  			fsnotify_move(new_dir, old_dir, &old_dentry->d_name,
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4885  				      new_is_dir, NULL, new_dentry);
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4886  		}
> da1ce0670c14d8 Miklos Szeredi        2014-04-01  4887  	}
> 49d31c2f389acf Al Viro               2017-07-07  4888  	release_dentry_name_snapshot(&old_name);
> 0eeca28300df11 Robert Love           2005-07-12  4889  
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4890  	return error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  4891  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
