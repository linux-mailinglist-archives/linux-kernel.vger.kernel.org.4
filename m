Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BA65E4A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjAEE2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjAEE2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:28:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8213FA08
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 20:28:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so187569wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 20:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aoxot8ZM1g8fMMi7IiUuPmBsI2+JKfsrfVYsoMpknb0=;
        b=RXgrqaKRJNlHRmheg/0sPdX03j55hkMrfQ6cc60Hki3A5uju3SjbNVg0H6LRnWFo7h
         li7ifQnYtyqBHRz1EdySjSoQ6MZcOrn2UyVxf38qCrPGmU9lpJ+UenqK7sGsStVqDGNt
         75whi8b9DjkhlMbJSX/l28UWr0v++9dnUaYGvxKd/P3jabqg+szJxHPCJG7gSRK2I3XI
         n+2mR99WWou47eApti0stPRKIqSBa01EB4HDUIqhB90G9dJgF5sItKjh/0WBIbPu0H+/
         DOwOT9c632wBhkHa1JjQCeOnCIftlWiHxtj0u8l15UikNs/w/GO5HPfjxwCHESzEGldl
         3+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aoxot8ZM1g8fMMi7IiUuPmBsI2+JKfsrfVYsoMpknb0=;
        b=3eKZsHygRLQ3Yx0UF+6KamMvSSynmOvDO29P1bABbFNYWDyBlFxFA/xn1z9CIFHzZd
         8bBUj0rFkxcmxTpF0kKyFx0nrNpDu8LKiXK/pPAnkcvZRhRYJY7GKjN11+70bax5rZt4
         ryZZomLK8JDGqHvaeiKKsprXs4DNcKyAuax/ct1W0dXeXdrsl/eit07XU/QVrf6ulxhZ
         Xw77p/zS3Y741Ys7ehONqzgxr4MDEMUXjE7AJN3tMTViISKYLdWpJGL39wboWl/cSeIG
         zGtvcsQ1CfKb1CNc6FjJGBwDfpKMvcbisS7u6Cs4TJ5Y2Em371pNDbukEXb7yNsV9NB/
         Jiqw==
X-Gm-Message-State: AFqh2koLsecozN5Ot88yA7Y9dYGWszZpBqfOwXTPLjSc9fOzh5O6VcP8
        pnogG5e0CyhLJDrBgKNvscC8wdb5SwwrRg==
X-Google-Smtp-Source: AMrXdXvzM64/NH+M6XdqBP7t4z8fWa01MLRxNligjb/NyIx1yaPN8Fr11RuB2ZrnUmMh5g/4/MUlnw==
X-Received: by 2002:adf:f305:0:b0:277:2e27:61fa with SMTP id i5-20020adff305000000b002772e2761famr25143378wro.9.1672892883071;
        Wed, 04 Jan 2023 20:28:03 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k6-20020adff5c6000000b002a01e64f7a1sm5555464wrp.88.2023.01.04.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 20:28:02 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:27:59 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Vasily Averin <vvs@virtuozzo.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: fs/nfsd/nfs4state.c:7045 nfsd4_lock() error: double free of 'nbl'
Message-ID: <202301050409.DGc5CuDh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69b41ac87e4a664de78a395ff97166f0b2943210
commit: 47446d74f1707049067fee038507cdffda805631 nfsd4: add refcount for nfsd4_blocked_lock
config: i386-randconfig-m021-20230102
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
fs/nfsd/nfs4state.c:7045 nfsd4_lock() error: double free of 'nbl'

Old smatch warnings:
fs/nfsd/nfs4state.c:6744 init_lock_stateid() warn: inconsistent returns '&stp->st_mutex'.

vim +/nbl +7045 fs/nfsd/nfs4state.c

b37ad28bcaa7c4 Al Viro              2006-10-19  6843  __be32
ca3643171bc6e0 J.Bruce Fields       2006-12-13  6844  nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
eb69853da94592 Christoph Hellwig    2017-05-08  6845  	   union nfsd4_op_u *u)
^1da177e4c3f41 Linus Torvalds       2005-04-16  6846  {
eb69853da94592 Christoph Hellwig    2017-05-08  6847  	struct nfsd4_lock *lock = &u->lock;
fe0750e5c43189 J. Bruce Fields      2011-07-30  6848  	struct nfs4_openowner *open_sop = NULL;
fe0750e5c43189 J. Bruce Fields      2011-07-30  6849  	struct nfs4_lockowner *lock_sop = NULL;
3d0fabd5a48fbf Trond Myklebust      2014-07-29  6850  	struct nfs4_ol_stateid *lock_stp = NULL;
0667b1e9d8a7c0 Trond Myklebust      2014-07-29  6851  	struct nfs4_ol_stateid *open_stp = NULL;
7214e8600eee14 Jeff Layton          2014-07-10  6852  	struct nfs4_file *fp;
eb82dd39374410 Jeff Layton          2019-08-18  6853  	struct nfsd_file *nf = NULL;
76d348fadff52e Jeff Layton          2016-09-16  6854  	struct nfsd4_blocked_lock *nbl = NULL;
21179d81f1de37 Jeff Layton          2012-08-21  6855  	struct file_lock *file_lock = NULL;
21179d81f1de37 Jeff Layton          2012-08-21  6856  	struct file_lock *conflock = NULL;
b37ad28bcaa7c4 Al Viro              2006-10-19  6857  	__be32 status = 0;
b34f27aa5da75b J. Bruce Fields      2011-08-22  6858  	int lkflg;
b8dd7b9ab194d9 Al Viro              2006-10-19  6859  	int err;
5db1c03feb00a7 Jeff Layton          2014-07-29  6860  	bool new = false;
76d348fadff52e Jeff Layton          2016-09-16  6861  	unsigned char fl_type;
76d348fadff52e Jeff Layton          2016-09-16  6862  	unsigned int fl_flags = FL_POSIX;
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6863  	struct net *net = SVC_NET(rqstp);
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6864  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
^1da177e4c3f41 Linus Torvalds       2005-04-16  6865  
^1da177e4c3f41 Linus Torvalds       2005-04-16  6866  	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
^1da177e4c3f41 Linus Torvalds       2005-04-16  6867  		(long long) lock->lk_offset,
^1da177e4c3f41 Linus Torvalds       2005-04-16  6868  		(long long) lock->lk_length);
^1da177e4c3f41 Linus Torvalds       2005-04-16  6869  
^1da177e4c3f41 Linus Torvalds       2005-04-16  6870  	if (check_lock_length(lock->lk_offset, lock->lk_length))
^1da177e4c3f41 Linus Torvalds       2005-04-16  6871  		 return nfserr_inval;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6872  
ca3643171bc6e0 J.Bruce Fields       2006-12-13  6873  	if ((status = fh_verify(rqstp, &cstate->current_fh,
8837abcab3d166 Miklos Szeredi       2008-06-16  6874  				S_IFREG, NFSD_MAY_LOCK))) {
a6f6ef2f1d7329 Andy Adamson         2006-01-18  6875  		dprintk("NFSD: nfsd4_lock: permission denied!\n");
a6f6ef2f1d7329 Andy Adamson         2006-01-18  6876  		return status;
a6f6ef2f1d7329 Andy Adamson         2006-01-18  6877  	}
a6f6ef2f1d7329 Andy Adamson         2006-01-18  6878  
^1da177e4c3f41 Linus Torvalds       2005-04-16  6879  	if (lock->lk_is_new) {
684e563858018d J. Bruce Fields      2011-11-04  6880  		if (nfsd4_has_session(cstate))
684e563858018d J. Bruce Fields      2011-11-04  6881  			/* See rfc 5661 18.10.3: given clientid is ignored: */
76f6c9e176dda6 Kinglong Mee         2015-07-13  6882  			memcpy(&lock->lk_new_clientid,
ec59659b4972ec J. Bruce Fields      2021-01-21  6883  				&cstate->clp->cl_clientid,
684e563858018d J. Bruce Fields      2011-11-04  6884  				sizeof(clientid_t));
684e563858018d J. Bruce Fields      2011-11-04  6885  
^1da177e4c3f41 Linus Torvalds       2005-04-16  6886  		/* validate and update open stateid and open seqid */
c0a5d93efbbb79 J. Bruce Fields      2011-09-06  6887  		status = nfs4_preprocess_confirmed_seqid_op(cstate,
^1da177e4c3f41 Linus Torvalds       2005-04-16  6888  				        lock->lk_new_open_seqid,
^1da177e4c3f41 Linus Torvalds       2005-04-16  6889  		                        &lock->lk_new_open_stateid,
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6890  					&open_stp, nn);
375151773125f5 NeilBrown            2005-07-07  6891  		if (status)
^1da177e4c3f41 Linus Torvalds       2005-04-16  6892  			goto out;
feb9dad5209280 Oleg Drokin          2016-06-14  6893  		mutex_unlock(&open_stp->st_mutex);
fe0750e5c43189 J. Bruce Fields      2011-07-30  6894  		open_sop = openowner(open_stp->st_stateowner);
b34f27aa5da75b J. Bruce Fields      2011-08-22  6895  		status = nfserr_bad_stateid;
684e563858018d J. Bruce Fields      2011-11-04  6896  		if (!same_clid(&open_sop->oo_owner.so_client->cl_clientid,
76f6c9e176dda6 Kinglong Mee         2015-07-13  6897  						&lock->lk_new_clientid))
b34f27aa5da75b J. Bruce Fields      2011-08-22  6898  			goto out;
64a284d07c7d84 J. Bruce Fields      2011-10-20  6899  		status = lookup_or_create_lock_state(cstate, open_stp, lock,
5db1c03feb00a7 Jeff Layton          2014-07-29  6900  							&lock_stp, &new);
3d0fabd5a48fbf Trond Myklebust      2014-07-29  6901  	} else {
dd453dfd70538c Benny Halevy         2009-04-03  6902  		status = nfs4_preprocess_seqid_op(cstate,
^1da177e4c3f41 Linus Torvalds       2005-04-16  6903  				       lock->lk_old_lock_seqid,
^1da177e4c3f41 Linus Torvalds       2005-04-16  6904  				       &lock->lk_old_lock_stateid,
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6905  				       NFS4_LOCK_STID, &lock_stp, nn);
3d0fabd5a48fbf Trond Myklebust      2014-07-29  6906  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  6907  	if (status)
^1da177e4c3f41 Linus Torvalds       2005-04-16  6908  		goto out;
fe0750e5c43189 J. Bruce Fields      2011-07-30  6909  	lock_sop = lockowner(lock_stp->st_stateowner);
^1da177e4c3f41 Linus Torvalds       2005-04-16  6910  
b34f27aa5da75b J. Bruce Fields      2011-08-22  6911  	lkflg = setlkflg(lock->lk_type);
b34f27aa5da75b J. Bruce Fields      2011-08-22  6912  	status = nfs4_check_openmode(lock_stp, lkflg);
b34f27aa5da75b J. Bruce Fields      2011-08-22  6913  	if (status)
b34f27aa5da75b J. Bruce Fields      2011-08-22  6914  		goto out;
b34f27aa5da75b J. Bruce Fields      2011-08-22  6915  
0dd395dc76071a NeilBrown            2005-07-07  6916  	status = nfserr_grace;
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6917  	if (locks_in_grace(net) && !lock->lk_reclaim)
0dd395dc76071a NeilBrown            2005-07-07  6918  		goto out;
0dd395dc76071a NeilBrown            2005-07-07  6919  	status = nfserr_no_grace;
3320fef19b542b Stanislav Kinsbursky 2012-11-14  6920  	if (!locks_in_grace(net) && lock->lk_reclaim)
0dd395dc76071a NeilBrown            2005-07-07  6921  		goto out;
0dd395dc76071a NeilBrown            2005-07-07  6922  
bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6923  	if (lock->lk_reclaim)
bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6924  		fl_flags |= FL_RECLAIM;
bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6925  
11b9164adad7cd Trond Myklebust      2014-07-29  6926  	fp = lock_stp->st_stid.sc_file;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6927  	switch (lock->lk_type) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  6928  		case NFS4_READW_LT:
40595cdc93edf4 J. Bruce Fields      2021-12-16  6929  			if (nfsd4_has_session(cstate))
76d348fadff52e Jeff Layton          2016-09-16  6930  				fl_flags |= FL_SLEEP;
df561f6688fef7 Gustavo A. R. Silva  2020-08-23  6931  			fallthrough;
76d348fadff52e Jeff Layton          2016-09-16  6932  		case NFS4_READ_LT:
7214e8600eee14 Jeff Layton          2014-07-10  6933  			spin_lock(&fp->fi_lock);
eb82dd39374410 Jeff Layton          2019-08-18  6934  			nf = find_readable_file_locked(fp);
eb82dd39374410 Jeff Layton          2019-08-18  6935  			if (nf)
0997b173609b92 J. Bruce Fields      2011-03-02  6936  				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
7214e8600eee14 Jeff Layton          2014-07-10  6937  			spin_unlock(&fp->fi_lock);
76d348fadff52e Jeff Layton          2016-09-16  6938  			fl_type = F_RDLCK;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6939  			break;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6940  		case NFS4_WRITEW_LT:
40595cdc93edf4 J. Bruce Fields      2021-12-16  6941  			if (nfsd4_has_session(cstate))
76d348fadff52e Jeff Layton          2016-09-16  6942  				fl_flags |= FL_SLEEP;
df561f6688fef7 Gustavo A. R. Silva  2020-08-23  6943  			fallthrough;
76d348fadff52e Jeff Layton          2016-09-16  6944  		case NFS4_WRITE_LT:
7214e8600eee14 Jeff Layton          2014-07-10  6945  			spin_lock(&fp->fi_lock);
eb82dd39374410 Jeff Layton          2019-08-18  6946  			nf = find_writeable_file_locked(fp);
eb82dd39374410 Jeff Layton          2019-08-18  6947  			if (nf)
0997b173609b92 J. Bruce Fields      2011-03-02  6948  				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
7214e8600eee14 Jeff Layton          2014-07-10  6949  			spin_unlock(&fp->fi_lock);
76d348fadff52e Jeff Layton          2016-09-16  6950  			fl_type = F_WRLCK;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6951  			break;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6952  		default:
^1da177e4c3f41 Linus Torvalds       2005-04-16  6953  			status = nfserr_inval;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6954  		goto out;
^1da177e4c3f41 Linus Torvalds       2005-04-16  6955  	}
76d348fadff52e Jeff Layton          2016-09-16  6956  
eb82dd39374410 Jeff Layton          2019-08-18  6957  	if (!nf) {
f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6958  		status = nfserr_openmode;
f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6959  		goto out;
f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6960  	}
aef9583b234a4e Kinglong Mee         2014-08-22  6961  
40595cdc93edf4 J. Bruce Fields      2021-12-16  6962  	/*
40595cdc93edf4 J. Bruce Fields      2021-12-16  6963  	 * Most filesystems with their own ->lock operations will block
40595cdc93edf4 J. Bruce Fields      2021-12-16  6964  	 * the nfsd thread waiting to acquire the lock.  That leads to
40595cdc93edf4 J. Bruce Fields      2021-12-16  6965  	 * deadlocks (we don't want every nfsd thread tied up waiting
40595cdc93edf4 J. Bruce Fields      2021-12-16  6966  	 * for file locks), so don't attempt blocking lock notifications
40595cdc93edf4 J. Bruce Fields      2021-12-16  6967  	 * on those filesystems:
40595cdc93edf4 J. Bruce Fields      2021-12-16  6968  	 */
40595cdc93edf4 J. Bruce Fields      2021-12-16  6969  	if (nf->nf_file->f_op->lock)
40595cdc93edf4 J. Bruce Fields      2021-12-16  6970  		fl_flags &= ~FL_SLEEP;
40595cdc93edf4 J. Bruce Fields      2021-12-16  6971  
76d348fadff52e Jeff Layton          2016-09-16  6972  	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
76d348fadff52e Jeff Layton          2016-09-16  6973  	if (!nbl) {
76d348fadff52e Jeff Layton          2016-09-16  6974  		dprintk("NFSD: %s: unable to allocate block!\n", __func__);
76d348fadff52e Jeff Layton          2016-09-16  6975  		status = nfserr_jukebox;
76d348fadff52e Jeff Layton          2016-09-16  6976  		goto out;
76d348fadff52e Jeff Layton          2016-09-16  6977  	}
76d348fadff52e Jeff Layton          2016-09-16  6978  
76d348fadff52e Jeff Layton          2016-09-16  6979  	file_lock = &nbl->nbl_lock;
76d348fadff52e Jeff Layton          2016-09-16  6980  	file_lock->fl_type = fl_type;
aef9583b234a4e Kinglong Mee         2014-08-22  6981  	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
21179d81f1de37 Jeff Layton          2012-08-21  6982  	file_lock->fl_pid = current->tgid;
eb82dd39374410 Jeff Layton          2019-08-18  6983  	file_lock->fl_file = nf->nf_file;
76d348fadff52e Jeff Layton          2016-09-16  6984  	file_lock->fl_flags = fl_flags;
21179d81f1de37 Jeff Layton          2012-08-21  6985  	file_lock->fl_lmops = &nfsd_posix_mng_ops;
21179d81f1de37 Jeff Layton          2012-08-21  6986  	file_lock->fl_start = lock->lk_offset;
21179d81f1de37 Jeff Layton          2012-08-21  6987  	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
21179d81f1de37 Jeff Layton          2012-08-21  6988  	nfs4_transform_lock_offset(file_lock);
21179d81f1de37 Jeff Layton          2012-08-21  6989  
21179d81f1de37 Jeff Layton          2012-08-21  6990  	conflock = locks_alloc_lock();
21179d81f1de37 Jeff Layton          2012-08-21  6991  	if (!conflock) {
21179d81f1de37 Jeff Layton          2012-08-21  6992  		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
21179d81f1de37 Jeff Layton          2012-08-21  6993  		status = nfserr_jukebox;
21179d81f1de37 Jeff Layton          2012-08-21  6994  		goto out;
21179d81f1de37 Jeff Layton          2012-08-21  6995  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  6996  
76d348fadff52e Jeff Layton          2016-09-16  6997  	if (fl_flags & FL_SLEEP) {
20b7d86f29d39e Arnd Bergmann        2019-11-04  6998  		nbl->nbl_time = ktime_get_boottime_seconds();
0cc11a61b80a1a Jeff Layton          2016-10-20  6999  		spin_lock(&nn->blocked_locks_lock);
76d348fadff52e Jeff Layton          2016-09-16  7000  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
7919d0a27f1e7c Jeff Layton          2016-09-16  7001  		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
47446d74f17070 Vasily Averin        2021-12-17  7002  		kref_get(&nbl->nbl_kref);
0cc11a61b80a1a Jeff Layton          2016-10-20  7003  		spin_unlock(&nn->blocked_locks_lock);
76d348fadff52e Jeff Layton          2016-09-16  7004  	}
76d348fadff52e Jeff Layton          2016-09-16  7005  
eb82dd39374410 Jeff Layton          2019-08-18  7006  	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
76d348fadff52e Jeff Layton          2016-09-16  7007  	switch (err) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  7008  	case 0: /* success! */
9767feb2c64b29 Jeff Layton          2015-10-01  7009  		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
b8dd7b9ab194d9 Al Viro              2006-10-19  7010  		status = 0;
03f318ca652889 J. Bruce Fields      2018-06-08  7011  		if (lock->lk_reclaim)
03f318ca652889 J. Bruce Fields      2018-06-08  7012  			nn->somebody_reclaimed = true;
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7013  		break;
76d348fadff52e Jeff Layton          2016-09-16  7014  	case FILE_LOCK_DEFERRED:
47446d74f17070 Vasily Averin        2021-12-17  7015  		kref_put(&nbl->nbl_kref, free_nbl);
76d348fadff52e Jeff Layton          2016-09-16  7016  		nbl = NULL;
df561f6688fef7 Gustavo A. R. Silva  2020-08-23  7017  		fallthrough;
76d348fadff52e Jeff Layton          2016-09-16  7018  	case -EAGAIN:		/* conflock holds conflicting lock */
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7019  		status = nfserr_denied;
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7020  		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
21179d81f1de37 Jeff Layton          2012-08-21  7021  		nfs4_set_lock_denied(conflock, &lock->lk_denied);
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7022  		break;
76d348fadff52e Jeff Layton          2016-09-16  7023  	case -EDEADLK:
^1da177e4c3f41 Linus Torvalds       2005-04-16  7024  		status = nfserr_deadlock;
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7025  		break;
^1da177e4c3f41 Linus Torvalds       2005-04-16  7026  	default:
fd85b8170dabbf Marc Eshel           2006-11-28  7027  		dprintk("NFSD: nfsd4_lock: vfs_lock_file() failed! status %d\n",err);
3e77246393c0a4 J. Bruce Fields      2011-08-10  7028  		status = nfserrno(err);
eb76b3fda1f7c2 Andy Adamson         2006-03-26  7029  		break;
^1da177e4c3f41 Linus Torvalds       2005-04-16  7030  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  7031  out:
76d348fadff52e Jeff Layton          2016-09-16  7032  	if (nbl) {
76d348fadff52e Jeff Layton          2016-09-16  7033  		/* dequeue it if we queued it before */
76d348fadff52e Jeff Layton          2016-09-16  7034  		if (fl_flags & FL_SLEEP) {
0cc11a61b80a1a Jeff Layton          2016-10-20  7035  			spin_lock(&nn->blocked_locks_lock);
47446d74f17070 Vasily Averin        2021-12-17  7036  			if (!list_empty(&nbl->nbl_list) &&
47446d74f17070 Vasily Averin        2021-12-17  7037  			    !list_empty(&nbl->nbl_lru)) {
76d348fadff52e Jeff Layton          2016-09-16  7038  				list_del_init(&nbl->nbl_list);
7919d0a27f1e7c Jeff Layton          2016-09-16  7039  				list_del_init(&nbl->nbl_lru);
47446d74f17070 Vasily Averin        2021-12-17  7040  				kref_put(&nbl->nbl_kref, free_nbl);

This looks like a free?  The test tries to take refcounting into
consideration but I've also advocated for a NOP kref function if
we know that free_nbl() cannot be called here.

47446d74f17070 Vasily Averin        2021-12-17  7041  			}
47446d74f17070 Vasily Averin        2021-12-17  7042  			/* nbl can use one of lists to be linked to reaplist */
0cc11a61b80a1a Jeff Layton          2016-10-20  7043  			spin_unlock(&nn->blocked_locks_lock);
76d348fadff52e Jeff Layton          2016-09-16  7044  		}
76d348fadff52e Jeff Layton          2016-09-16 @7045  		free_blocked_lock(nbl);

Double free.

76d348fadff52e Jeff Layton          2016-09-16  7046  	}
eb82dd39374410 Jeff Layton          2019-08-18  7047  	if (nf)
eb82dd39374410 Jeff Layton          2019-08-18  7048  		nfsd_file_put(nf);
5db1c03feb00a7 Jeff Layton          2014-07-29  7049  	if (lock_stp) {
5db1c03feb00a7 Jeff Layton          2014-07-29  7050  		/* Bump seqid manually if the 4.0 replay owner is openowner */
5db1c03feb00a7 Jeff Layton          2014-07-29  7051  		if (cstate->replay_owner &&
5db1c03feb00a7 Jeff Layton          2014-07-29  7052  		    cstate->replay_owner != &lock_sop->lo_owner &&
5db1c03feb00a7 Jeff Layton          2014-07-29  7053  		    seqid_mutating_err(ntohl(status)))
5db1c03feb00a7 Jeff Layton          2014-07-29  7054  			lock_sop->lo_owner.so_seqid++;
5db1c03feb00a7 Jeff Layton          2014-07-29  7055  
5db1c03feb00a7 Jeff Layton          2014-07-29  7056  		/*
5db1c03feb00a7 Jeff Layton          2014-07-29  7057  		 * If this is a new, never-before-used stateid, and we are
5db1c03feb00a7 Jeff Layton          2014-07-29  7058  		 * returning an error, then just go ahead and release it.
5db1c03feb00a7 Jeff Layton          2014-07-29  7059  		 */
2502072058b35e J. Bruce Fields      2018-01-17  7060  		if (status && new)
5db1c03feb00a7 Jeff Layton          2014-07-29  7061  			release_lock_stateid(lock_stp);
beeca19cf1249a Trond Myklebust      2017-11-03  7062  
beeca19cf1249a Trond Myklebust      2017-11-03  7063  		mutex_unlock(&lock_stp->st_mutex);
5db1c03feb00a7 Jeff Layton          2014-07-29  7064  
3d0fabd5a48fbf Trond Myklebust      2014-07-29  7065  		nfs4_put_stid(&lock_stp->st_stid);
5db1c03feb00a7 Jeff Layton          2014-07-29  7066  	}
0667b1e9d8a7c0 Trond Myklebust      2014-07-29  7067  	if (open_stp)
0667b1e9d8a7c0 Trond Myklebust      2014-07-29  7068  		nfs4_put_stid(&open_stp->st_stid);
9411b1d4c7df26 J. Bruce Fields      2013-04-01  7069  	nfsd4_bump_seqid(cstate, status);
21179d81f1de37 Jeff Layton          2012-08-21  7070  	if (conflock)
21179d81f1de37 Jeff Layton          2012-08-21  7071  		locks_free_lock(conflock);
^1da177e4c3f41 Linus Torvalds       2005-04-16  7072  	return status;
^1da177e4c3f41 Linus Torvalds       2005-04-16  7073  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

