Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE065EA54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjAEMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAEMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:03:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343F57925
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:03:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11456619F4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BEEC433D2;
        Thu,  5 Jan 2023 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672920207;
        bh=Olq4llFADQ37LztDGtm6LBY/OdJBU6l+F2sgZ/VJ2Pg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SFlHEN1eKJo5EFUN/aFC3K8Cy+istYSUjBhNwLYl8TGK/FGODAOjF027kyIIE/KkK
         fxnbbe80UskAvVTYMH0n4pj0+c+giy4x4p8eRCUc+Oe8pIm+2pizcc3I2S+9s2FBnH
         jEx9/oCiA4AjBjchHCTCtm3ly+pxu8FvowvxRBfp3O7Xl1iKo+RxrCJUMwm4Q3F7/W
         lx5M+bF1eytolq/5ZSPNw+GhzMAvZzQgQyX8E5qonuVitkw4AjdKDr1p07m/t66bIt
         wzfNGztj9YomQI7Gk30ixpCUhwbKHI0kqjT8QV0esfmpK+ZM7R+6KVw+Aut67aNFUo
         oGht3smRX5KmA==
Message-ID: <b6242093f5d8ad25e9db761255797414287c1f96.camel@kernel.org>
Subject: Re: fs/nfsd/nfs4state.c:7045 nfsd4_lock() error: double free of
 'nbl'
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 05 Jan 2023 07:03:25 -0500
In-Reply-To: <202301050409.DGc5CuDh-lkp@intel.com>
References: <202301050409.DGc5CuDh-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-05 at 07:27 +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   69b41ac87e4a664de78a395ff97166f0b2943210
> commit: 47446d74f1707049067fee038507cdffda805631 nfsd4: add refcount for =
nfsd4_blocked_lock
> config: i386-randconfig-m021-20230102
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>=20
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> New smatch warnings:
> fs/nfsd/nfs4state.c:7045 nfsd4_lock() error: double free of 'nbl'
>=20
> Old smatch warnings:
> fs/nfsd/nfs4state.c:6744 init_lock_stateid() warn: inconsistent returns '=
&stp->st_mutex'.
>=20
> vim +/nbl +7045 fs/nfsd/nfs4state.c
>=20
> b37ad28bcaa7c4 Al Viro              2006-10-19  6843  __be32
> ca3643171bc6e0 J.Bruce Fields       2006-12-13  6844  nfsd4_lock(struct s=
vc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> eb69853da94592 Christoph Hellwig    2017-05-08  6845  	   union nfsd4_op_=
u *u)
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6846  {
> eb69853da94592 Christoph Hellwig    2017-05-08  6847  	struct nfsd4_lock =
*lock =3D &u->lock;
> fe0750e5c43189 J. Bruce Fields      2011-07-30  6848  	struct nfs4_openow=
ner *open_sop =3D NULL;
> fe0750e5c43189 J. Bruce Fields      2011-07-30  6849  	struct nfs4_lockow=
ner *lock_sop =3D NULL;
> 3d0fabd5a48fbf Trond Myklebust      2014-07-29  6850  	struct nfs4_ol_sta=
teid *lock_stp =3D NULL;
> 0667b1e9d8a7c0 Trond Myklebust      2014-07-29  6851  	struct nfs4_ol_sta=
teid *open_stp =3D NULL;
> 7214e8600eee14 Jeff Layton          2014-07-10  6852  	struct nfs4_file *=
fp;
> eb82dd39374410 Jeff Layton          2019-08-18  6853  	struct nfsd_file *=
nf =3D NULL;
> 76d348fadff52e Jeff Layton          2016-09-16  6854  	struct nfsd4_block=
ed_lock *nbl =3D NULL;
> 21179d81f1de37 Jeff Layton          2012-08-21  6855  	struct file_lock *=
file_lock =3D NULL;
> 21179d81f1de37 Jeff Layton          2012-08-21  6856  	struct file_lock *=
conflock =3D NULL;
> b37ad28bcaa7c4 Al Viro              2006-10-19  6857  	__be32 status =3D =
0;
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6858  	int lkflg;
> b8dd7b9ab194d9 Al Viro              2006-10-19  6859  	int err;
> 5db1c03feb00a7 Jeff Layton          2014-07-29  6860  	bool new =3D false=
;
> 76d348fadff52e Jeff Layton          2016-09-16  6861  	unsigned char fl_t=
ype;
> 76d348fadff52e Jeff Layton          2016-09-16  6862  	unsigned int fl_fl=
ags =3D FL_POSIX;
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6863  	struct net *net =
=3D SVC_NET(rqstp);
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6864  	struct nfsd_net *n=
n =3D net_generic(net, nfsd_net_id);
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6865 =20
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6866  	dprintk("NFSD: nfs=
d4_lock: start=3D%Ld length=3D%Ld\n",
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6867  		(long long) lock-=
>lk_offset,
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6868  		(long long) lock-=
>lk_length);
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6869 =20
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6870  	if (check_lock_len=
gth(lock->lk_offset, lock->lk_length))
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6871  		 return nfserr_in=
val;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6872 =20
> ca3643171bc6e0 J.Bruce Fields       2006-12-13  6873  	if ((status =3D fh=
_verify(rqstp, &cstate->current_fh,
> 8837abcab3d166 Miklos Szeredi       2008-06-16  6874  				S_IFREG, NFSD_M=
AY_LOCK))) {
> a6f6ef2f1d7329 Andy Adamson         2006-01-18  6875  		dprintk("NFSD: nf=
sd4_lock: permission denied!\n");
> a6f6ef2f1d7329 Andy Adamson         2006-01-18  6876  		return status;
> a6f6ef2f1d7329 Andy Adamson         2006-01-18  6877  	}
> a6f6ef2f1d7329 Andy Adamson         2006-01-18  6878 =20
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6879  	if (lock->lk_is_ne=
w) {
> 684e563858018d J. Bruce Fields      2011-11-04  6880  		if (nfsd4_has_ses=
sion(cstate))
> 684e563858018d J. Bruce Fields      2011-11-04  6881  			/* See rfc 5661 =
18.10.3: given clientid is ignored: */
> 76f6c9e176dda6 Kinglong Mee         2015-07-13  6882  			memcpy(&lock->lk=
_new_clientid,
> ec59659b4972ec J. Bruce Fields      2021-01-21  6883  				&cstate->clp->c=
l_clientid,
> 684e563858018d J. Bruce Fields      2011-11-04  6884  				sizeof(clientid=
_t));
> 684e563858018d J. Bruce Fields      2011-11-04  6885 =20
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6886  		/* validate and u=
pdate open stateid and open seqid */
> c0a5d93efbbb79 J. Bruce Fields      2011-09-06  6887  		status =3D nfs4_p=
reprocess_confirmed_seqid_op(cstate,
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6888  				        lock->l=
k_new_open_seqid,
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6889  		                 =
       &lock->lk_new_open_stateid,
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6890  					&open_stp, nn)=
;
> 375151773125f5 NeilBrown            2005-07-07  6891  		if (status)
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6892  			goto out;
> feb9dad5209280 Oleg Drokin          2016-06-14  6893  		mutex_unlock(&ope=
n_stp->st_mutex);
> fe0750e5c43189 J. Bruce Fields      2011-07-30  6894  		open_sop =3D open=
owner(open_stp->st_stateowner);
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6895  		status =3D nfserr=
_bad_stateid;
> 684e563858018d J. Bruce Fields      2011-11-04  6896  		if (!same_clid(&o=
pen_sop->oo_owner.so_client->cl_clientid,
> 76f6c9e176dda6 Kinglong Mee         2015-07-13  6897  						&lock->lk_new=
_clientid))
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6898  			goto out;
> 64a284d07c7d84 J. Bruce Fields      2011-10-20  6899  		status =3D lookup=
_or_create_lock_state(cstate, open_stp, lock,
> 5db1c03feb00a7 Jeff Layton          2014-07-29  6900  							&lock_stp, &=
new);
> 3d0fabd5a48fbf Trond Myklebust      2014-07-29  6901  	} else {
> dd453dfd70538c Benny Halevy         2009-04-03  6902  		status =3D nfs4_p=
reprocess_seqid_op(cstate,
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6903  				       lock->lk=
_old_lock_seqid,
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6904  				       &lock->l=
k_old_lock_stateid,
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6905  				       NFS4_LOC=
K_STID, &lock_stp, nn);
> 3d0fabd5a48fbf Trond Myklebust      2014-07-29  6906  	}
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6907  	if (status)
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6908  		goto out;
> fe0750e5c43189 J. Bruce Fields      2011-07-30  6909  	lock_sop =3D locko=
wner(lock_stp->st_stateowner);
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6910 =20
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6911  	lkflg =3D setlkflg=
(lock->lk_type);
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6912  	status =3D nfs4_ch=
eck_openmode(lock_stp, lkflg);
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6913  	if (status)
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6914  		goto out;
> b34f27aa5da75b J. Bruce Fields      2011-08-22  6915 =20
> 0dd395dc76071a NeilBrown            2005-07-07  6916  	status =3D nfserr_=
grace;
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6917  	if (locks_in_grace=
(net) && !lock->lk_reclaim)
> 0dd395dc76071a NeilBrown            2005-07-07  6918  		goto out;
> 0dd395dc76071a NeilBrown            2005-07-07  6919  	status =3D nfserr_=
no_grace;
> 3320fef19b542b Stanislav Kinsbursky 2012-11-14  6920  	if (!locks_in_grac=
e(net) && lock->lk_reclaim)
> 0dd395dc76071a NeilBrown            2005-07-07  6921  		goto out;
> 0dd395dc76071a NeilBrown            2005-07-07  6922 =20
> bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6923  	if (lock->lk_recla=
im)
> bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6924  		fl_flags |=3D FL_=
RECLAIM;
> bb0a55bb7148a4 J. Bruce Fields      2021-08-20  6925 =20
> 11b9164adad7cd Trond Myklebust      2014-07-29  6926  	fp =3D lock_stp->s=
t_stid.sc_file;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6927  	switch (lock->lk_t=
ype) {
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6928  		case NFS4_READW_L=
T:
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6929  			if (nfsd4_has_se=
ssion(cstate))
> 76d348fadff52e Jeff Layton          2016-09-16  6930  				fl_flags |=3D F=
L_SLEEP;
> df561f6688fef7 Gustavo A. R. Silva  2020-08-23  6931  			fallthrough;
> 76d348fadff52e Jeff Layton          2016-09-16  6932  		case NFS4_READ_LT=
:
> 7214e8600eee14 Jeff Layton          2014-07-10  6933  			spin_lock(&fp->f=
i_lock);
> eb82dd39374410 Jeff Layton          2019-08-18  6934  			nf =3D find_read=
able_file_locked(fp);
> eb82dd39374410 Jeff Layton          2019-08-18  6935  			if (nf)
> 0997b173609b92 J. Bruce Fields      2011-03-02  6936  				get_lock_access=
(lock_stp, NFS4_SHARE_ACCESS_READ);
> 7214e8600eee14 Jeff Layton          2014-07-10  6937  			spin_unlock(&fp-=
>fi_lock);
> 76d348fadff52e Jeff Layton          2016-09-16  6938  			fl_type =3D F_RD=
LCK;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6939  			break;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6940  		case NFS4_WRITEW_=
LT:
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6941  			if (nfsd4_has_se=
ssion(cstate))
> 76d348fadff52e Jeff Layton          2016-09-16  6942  				fl_flags |=3D F=
L_SLEEP;
> df561f6688fef7 Gustavo A. R. Silva  2020-08-23  6943  			fallthrough;
> 76d348fadff52e Jeff Layton          2016-09-16  6944  		case NFS4_WRITE_L=
T:
> 7214e8600eee14 Jeff Layton          2014-07-10  6945  			spin_lock(&fp->f=
i_lock);
> eb82dd39374410 Jeff Layton          2019-08-18  6946  			nf =3D find_writ=
eable_file_locked(fp);
> eb82dd39374410 Jeff Layton          2019-08-18  6947  			if (nf)
> 0997b173609b92 J. Bruce Fields      2011-03-02  6948  				get_lock_access=
(lock_stp, NFS4_SHARE_ACCESS_WRITE);
> 7214e8600eee14 Jeff Layton          2014-07-10  6949  			spin_unlock(&fp-=
>fi_lock);
> 76d348fadff52e Jeff Layton          2016-09-16  6950  			fl_type =3D F_WR=
LCK;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6951  			break;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6952  		default:
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6953  			status =3D nfser=
r_inval;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6954  		goto out;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6955  	}
> 76d348fadff52e Jeff Layton          2016-09-16  6956 =20
> eb82dd39374410 Jeff Layton          2019-08-18  6957  	if (!nf) {
> f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6958  		status =3D nfserr=
_openmode;
> f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6959  		goto out;
> f9d7562fdb9dc0 J. Bruce Fields      2010-07-08  6960  	}
> aef9583b234a4e Kinglong Mee         2014-08-22  6961 =20
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6962  	/*
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6963  	 * Most filesystem=
s with their own ->lock operations will block
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6964  	 * the nfsd thread=
 waiting to acquire the lock.  That leads to
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6965  	 * deadlocks (we d=
on't want every nfsd thread tied up waiting
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6966  	 * for file locks)=
, so don't attempt blocking lock notifications
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6967  	 * on those filesy=
stems:
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6968  	 */
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6969  	if (nf->nf_file->f=
_op->lock)
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6970  		fl_flags &=3D ~FL=
_SLEEP;
> 40595cdc93edf4 J. Bruce Fields      2021-12-16  6971 =20
> 76d348fadff52e Jeff Layton          2016-09-16  6972  	nbl =3D find_or_al=
locate_block(lock_sop, &fp->fi_fhandle, nn);
> 76d348fadff52e Jeff Layton          2016-09-16  6973  	if (!nbl) {
> 76d348fadff52e Jeff Layton          2016-09-16  6974  		dprintk("NFSD: %s=
: unable to allocate block!\n", __func__);
> 76d348fadff52e Jeff Layton          2016-09-16  6975  		status =3D nfserr=
_jukebox;
> 76d348fadff52e Jeff Layton          2016-09-16  6976  		goto out;
> 76d348fadff52e Jeff Layton          2016-09-16  6977  	}
> 76d348fadff52e Jeff Layton          2016-09-16  6978 =20
> 76d348fadff52e Jeff Layton          2016-09-16  6979  	file_lock =3D &nbl=
->nbl_lock;
> 76d348fadff52e Jeff Layton          2016-09-16  6980  	file_lock->fl_type=
 =3D fl_type;
> aef9583b234a4e Kinglong Mee         2014-08-22  6981  	file_lock->fl_owne=
r =3D (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
> 21179d81f1de37 Jeff Layton          2012-08-21  6982  	file_lock->fl_pid =
=3D current->tgid;
> eb82dd39374410 Jeff Layton          2019-08-18  6983  	file_lock->fl_file=
 =3D nf->nf_file;
> 76d348fadff52e Jeff Layton          2016-09-16  6984  	file_lock->fl_flag=
s =3D fl_flags;
> 21179d81f1de37 Jeff Layton          2012-08-21  6985  	file_lock->fl_lmop=
s =3D &nfsd_posix_mng_ops;
> 21179d81f1de37 Jeff Layton          2012-08-21  6986  	file_lock->fl_star=
t =3D lock->lk_offset;
> 21179d81f1de37 Jeff Layton          2012-08-21  6987  	file_lock->fl_end =
=3D last_byte_offset(lock->lk_offset, lock->lk_length);
> 21179d81f1de37 Jeff Layton          2012-08-21  6988  	nfs4_transform_loc=
k_offset(file_lock);
> 21179d81f1de37 Jeff Layton          2012-08-21  6989 =20
> 21179d81f1de37 Jeff Layton          2012-08-21  6990  	conflock =3D locks=
_alloc_lock();
> 21179d81f1de37 Jeff Layton          2012-08-21  6991  	if (!conflock) {
> 21179d81f1de37 Jeff Layton          2012-08-21  6992  		dprintk("NFSD: %s=
: unable to allocate lock!\n", __func__);
> 21179d81f1de37 Jeff Layton          2012-08-21  6993  		status =3D nfserr=
_jukebox;
> 21179d81f1de37 Jeff Layton          2012-08-21  6994  		goto out;
> 21179d81f1de37 Jeff Layton          2012-08-21  6995  	}
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  6996 =20
> 76d348fadff52e Jeff Layton          2016-09-16  6997  	if (fl_flags & FL_=
SLEEP) {
> 20b7d86f29d39e Arnd Bergmann        2019-11-04  6998  		nbl->nbl_time =3D=
 ktime_get_boottime_seconds();
> 0cc11a61b80a1a Jeff Layton          2016-10-20  6999  		spin_lock(&nn->bl=
ocked_locks_lock);
> 76d348fadff52e Jeff Layton          2016-09-16  7000  		list_add_tail(&nb=
l->nbl_list, &lock_sop->lo_blocked);
> 7919d0a27f1e7c Jeff Layton          2016-09-16  7001  		list_add_tail(&nb=
l->nbl_lru, &nn->blocked_locks_lru);
> 47446d74f17070 Vasily Averin        2021-12-17  7002  		kref_get(&nbl->nb=
l_kref);
> 0cc11a61b80a1a Jeff Layton          2016-10-20  7003  		spin_unlock(&nn->=
blocked_locks_lock);
> 76d348fadff52e Jeff Layton          2016-09-16  7004  	}
> 76d348fadff52e Jeff Layton          2016-09-16  7005 =20
> eb82dd39374410 Jeff Layton          2019-08-18  7006  	err =3D vfs_lock_f=
ile(nf->nf_file, F_SETLK, file_lock, conflock);
> 76d348fadff52e Jeff Layton          2016-09-16  7007  	switch (err) {
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7008  	case 0: /* success=
! */
> 9767feb2c64b29 Jeff Layton          2015-10-01  7009  		nfs4_inc_and_copy=
_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
> b8dd7b9ab194d9 Al Viro              2006-10-19  7010  		status =3D 0;
> 03f318ca652889 J. Bruce Fields      2018-06-08  7011  		if (lock->lk_recl=
aim)
> 03f318ca652889 J. Bruce Fields      2018-06-08  7012  			nn->somebody_rec=
laimed =3D true;
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7013  		break;
> 76d348fadff52e Jeff Layton          2016-09-16  7014  	case FILE_LOCK_DEF=
ERRED:
> 47446d74f17070 Vasily Averin        2021-12-17  7015  		kref_put(&nbl->nb=
l_kref, free_nbl);
> 76d348fadff52e Jeff Layton          2016-09-16  7016  		nbl =3D NULL;
> df561f6688fef7 Gustavo A. R. Silva  2020-08-23  7017  		fallthrough;
> 76d348fadff52e Jeff Layton          2016-09-16  7018  	case -EAGAIN:		/* =
conflock holds conflicting lock */
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7019  		status =3D nfserr=
_denied;
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7020  		dprintk("NFSD: nf=
sd4_lock: conflicting lock found!\n");
> 21179d81f1de37 Jeff Layton          2012-08-21  7021  		nfs4_set_lock_den=
ied(conflock, &lock->lk_denied);
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7022  		break;
> 76d348fadff52e Jeff Layton          2016-09-16  7023  	case -EDEADLK:
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7024  		status =3D nfserr=
_deadlock;
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7025  		break;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7026  	default:
> fd85b8170dabbf Marc Eshel           2006-11-28  7027  		dprintk("NFSD: nf=
sd4_lock: vfs_lock_file() failed! status %d\n",err);
> 3e77246393c0a4 J. Bruce Fields      2011-08-10  7028  		status =3D nfserr=
no(err);
> eb76b3fda1f7c2 Andy Adamson         2006-03-26  7029  		break;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7030  	}
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7031  out:
> 76d348fadff52e Jeff Layton          2016-09-16  7032  	if (nbl) {
> 76d348fadff52e Jeff Layton          2016-09-16  7033  		/* dequeue it if =
we queued it before */
> 76d348fadff52e Jeff Layton          2016-09-16  7034  		if (fl_flags & FL=
_SLEEP) {
> 0cc11a61b80a1a Jeff Layton          2016-10-20  7035  			spin_lock(&nn->b=
locked_locks_lock);
> 47446d74f17070 Vasily Averin        2021-12-17  7036  			if (!list_empty(=
&nbl->nbl_list) &&
> 47446d74f17070 Vasily Averin        2021-12-17  7037  			    !list_empty(=
&nbl->nbl_lru)) {
> 76d348fadff52e Jeff Layton          2016-09-16  7038  				list_del_init(&=
nbl->nbl_list);
> 7919d0a27f1e7c Jeff Layton          2016-09-16  7039  				list_del_init(&=
nbl->nbl_lru);
> 47446d74f17070 Vasily Averin        2021-12-17  7040  				kref_put(&nbl->=
nbl_kref, free_nbl);
>=20
> This looks like a free?  The test tries to take refcounting into
> consideration but I've also advocated for a NOP kref function if
> we know that free_nbl() cannot be called here.
>=20

Thanks Dan. I think this is a false positive.

IIUC, if the nbl is on the list or lru, then it carries an extra
reference, and that reference is what is being put here with the
kref_put. That reference shouldn't be the last one.

> 47446d74f17070 Vasily Averin        2021-12-17  7041  			}
> 47446d74f17070 Vasily Averin        2021-12-17  7042  			/* nbl can use o=
ne of lists to be linked to reaplist */
> 0cc11a61b80a1a Jeff Layton          2016-10-20  7043  			spin_unlock(&nn-=
>blocked_locks_lock);
> 76d348fadff52e Jeff Layton          2016-09-16  7044  		}
> 76d348fadff52e Jeff Layton          2016-09-16 @7045  		free_blocked_lock=
(nbl);
>=20
> Double free.
>=20

This is putting the original reference that was acquired when
find_or_allocate_block was called, so I don't think there is a double
free.

> 76d348fadff52e Jeff Layton          2016-09-16  7046  	}
> eb82dd39374410 Jeff Layton          2019-08-18  7047  	if (nf)
> eb82dd39374410 Jeff Layton          2019-08-18  7048  		nfsd_file_put(nf)=
;
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7049  	if (lock_stp) {
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7050  		/* Bump seqid man=
ually if the 4.0 replay owner is openowner */
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7051  		if (cstate->repla=
y_owner &&
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7052  		    cstate->repla=
y_owner !=3D &lock_sop->lo_owner &&
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7053  		    seqid_mutatin=
g_err(ntohl(status)))
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7054  			lock_sop->lo_own=
er.so_seqid++;
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7055 =20
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7056  		/*
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7057  		 * If this is a n=
ew, never-before-used stateid, and we are
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7058  		 * returning an e=
rror, then just go ahead and release it.
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7059  		 */
> 2502072058b35e J. Bruce Fields      2018-01-17  7060  		if (status && new=
)
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7061  			release_lock_sta=
teid(lock_stp);
> beeca19cf1249a Trond Myklebust      2017-11-03  7062 =20
> beeca19cf1249a Trond Myklebust      2017-11-03  7063  		mutex_unlock(&loc=
k_stp->st_mutex);
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7064 =20
> 3d0fabd5a48fbf Trond Myklebust      2014-07-29  7065  		nfs4_put_stid(&lo=
ck_stp->st_stid);
> 5db1c03feb00a7 Jeff Layton          2014-07-29  7066  	}
> 0667b1e9d8a7c0 Trond Myklebust      2014-07-29  7067  	if (open_stp)
> 0667b1e9d8a7c0 Trond Myklebust      2014-07-29  7068  		nfs4_put_stid(&op=
en_stp->st_stid);
> 9411b1d4c7df26 J. Bruce Fields      2013-04-01  7069  	nfsd4_bump_seqid(c=
state, status);
> 21179d81f1de37 Jeff Layton          2012-08-21  7070  	if (conflock)
> 21179d81f1de37 Jeff Layton          2012-08-21  7071  		locks_free_lock(c=
onflock);
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7072  	return status;
> ^1da177e4c3f41 Linus Torvalds       2005-04-16  7073  }
>=20

--=20
Jeff Layton <jlayton@kernel.org>
