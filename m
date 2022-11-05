Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2124A61DA94
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKENVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BECDF4C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D69A4608D4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 13:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77261C433D6;
        Sat,  5 Nov 2022 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667654493;
        bh=ZwRG2hXELndg1wVawBk/zlqxL4WmmqdPxv0/iuDMSCI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g+lYi3A7TkF6OVkPV19ly78AuA+rqTSjv1n39H2CtNpqkpZUNV/BdWHqa6CMooU1G
         GW/oFulWJ6nHZby7dTVu7CLxks3IsB1py+cnncCT6h6Wv/fpMdE8hHiB0hpgxc2IKG
         oTvpGWSYV0OiWp/Gv22d3tgSqAsZhNx+ROzR157SjwnfBzfXOhJJYZTMl+wak9vQ/U
         NxFwNJ7K9b+GgegcZqsEFrX2miFOWhJQwkpFfALrQUkt73gk3tDsnUn7J6YtWnV6ml
         aBr64Ypd9ABV/a5Zib67LKd/RaT2lsYkZW68AEya8hPnZvbRk8SLKkk1I3GpftENUD
         We/bogs8h4CBQ==
Message-ID: <6bf4b9344f4c3b19332143a0e70ec627c1eeb315.camel@kernel.org>
Subject: Re: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing
 freed memory 'nf'
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date:   Sat, 05 Nov 2022 09:21:31 -0400
In-Reply-To: <202211051543.2bnSgTQW-lkp@intel.com>
References: <202211051543.2bnSgTQW-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-05 at 14:17 +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   b208b9fbbcba743fb269d15cb46a4036b01936b1
> commit: 243a5263014a30436c93ed3f1f864c1da845455e nfsd: rework hashtable h=
andling in nfsd_do_file_acquire
> config: alpha-randconfig-m041-20221030
> compiler: alpha-linux-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> smatch warnings:
> fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing freed memor=
y 'nf'
>=20
> vim +/nf +1118 fs/nfsd/filecache.c
>=20
> fb70bf124b051d Chuck Lever     2022-03-30  1036  static __be32
> be0230069fcbf7 Chuck Lever     2022-07-08  1037  nfsd_file_do_acquire(str=
uct svc_rqst *rqstp, struct svc_fh *fhp,
> fb70bf124b051d Chuck Lever     2022-03-30  1038  		     unsigned int may_=
flags, struct nfsd_file **pnf, bool open)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1039  {
> ce502f81ba884c Chuck Lever     2022-07-08  1040  	struct nfsd_file_lookup=
_key key =3D {
> ce502f81ba884c Chuck Lever     2022-07-08  1041  		.type	=3D NFSD_FILE_KE=
Y_FULL,
> ce502f81ba884c Chuck Lever     2022-07-08  1042  		.need	=3D may_flags & =
NFSD_FILE_MAY_MASK,
> ce502f81ba884c Chuck Lever     2022-07-08  1043  		.net	=3D SVC_NET(rqstp=
),
> ce502f81ba884c Chuck Lever     2022-07-08  1044  	};
> 243a5263014a30 Jeff Layton     2022-10-04  1045  	bool open_retry =3D tru=
e;
> 243a5263014a30 Jeff Layton     2022-10-04  1046  	struct nfsd_file *nf;
> ce502f81ba884c Chuck Lever     2022-07-08  1047  	__be32 status;
> 243a5263014a30 Jeff Layton     2022-10-04  1048  	int ret;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1049 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1050  	status =3D fh_verify(rq=
stp, fhp, S_IFREG,
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1051  				may_flags|NFSD_MAY_O=
WNER_OVERRIDE);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1052  	if (status !=3D nfs_ok)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1053  		return status;
> ce502f81ba884c Chuck Lever     2022-07-08  1054  	key.inode =3D d_inode(f=
hp->fh_dentry);
> ce502f81ba884c Chuck Lever     2022-07-08  1055  	key.cred =3D get_curren=
t_cred();
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1056 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1057  retry:
> 243a5263014a30 Jeff Layton     2022-10-04  1058  	rcu_read_lock();
> 243a5263014a30 Jeff Layton     2022-10-04  1059  	nf =3D rhashtable_looku=
p(&nfsd_file_rhash_tbl, &key,
> ce502f81ba884c Chuck Lever     2022-07-08  1060  			       nfsd_file_rhas=
h_params);
> ce502f81ba884c Chuck Lever     2022-07-08  1061  	if (nf)
> ce502f81ba884c Chuck Lever     2022-07-08  1062  		nf =3D nfsd_file_get(n=
f);
> 243a5263014a30 Jeff Layton     2022-10-04  1063  	rcu_read_unlock();
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1064  	if (nf)
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1065  		goto wait_for_construc=
tion;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1066 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1067  	nf =3D nfsd_file_alloc(=
&key, may_flags);
> 243a5263014a30 Jeff Layton     2022-10-04  1068  	if (!nf) {
> 54f7df7094b329 Chuck Lever     2022-07-08  1069  		status =3D nfserr_juke=
box;
> 54f7df7094b329 Chuck Lever     2022-07-08  1070  		goto out_status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1071  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1072 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1073  	ret =3D rhashtable_look=
up_insert_key(&nfsd_file_rhash_tbl,
> 243a5263014a30 Jeff Layton     2022-10-04  1074  					   &key, &nf->nf_rh=
ash,
> ce502f81ba884c Chuck Lever     2022-07-08  1075  					   nfsd_file_rhash_=
params);
> 243a5263014a30 Jeff Layton     2022-10-04  1076  	if (likely(ret =3D=3D 0=
))
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1077  		goto open_file;
> 243a5263014a30 Jeff Layton     2022-10-04  1078 =20
> 243a5263014a30 Jeff Layton     2022-10-04  1079  	nfsd_file_slab_free(&nf=
->nf_rcu);
> 243a5263014a30 Jeff Layton     2022-10-04  1080  	if (ret =3D=3D -EEXIST)
> 243a5263014a30 Jeff Layton     2022-10-04  1081  		goto retry;
> 243a5263014a30 Jeff Layton     2022-10-04  1082  	trace_nfsd_file_insert_=
err(rqstp, key.inode, may_flags, ret);
> 243a5263014a30 Jeff Layton     2022-10-04  1083  	status =3D nfserr_jukeb=
ox;
> 243a5263014a30 Jeff Layton     2022-10-04  1084  	goto out_status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1085 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1086  wait_for_construction:
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1087  	wait_on_bit(&nf->nf_fla=
gs, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1088 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1089  	/* Did construction of =
this file fail? */
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1090  	if (!test_bit(NFSD_FILE=
_HASHED, &nf->nf_flags)) {
> ce502f81ba884c Chuck Lever     2022-07-08  1091  		trace_nfsd_file_cons_e=
rr(rqstp, key.inode, may_flags, nf);
> 243a5263014a30 Jeff Layton     2022-10-04  1092  		if (!open_retry) {
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1093  			status =3D nfserr_juk=
ebox;
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1094  			goto out;
> 28c7d86bb6172f Trond Myklebust 2020-01-06  1095  		}
> 243a5263014a30 Jeff Layton     2022-10-04  1096  		open_retry =3D false;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1097  		nfsd_file_put_noref(nf=
);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1098  		goto retry;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1099  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1100 =20
> 4a0e73e635e3f3 Chuck Lever     2022-07-08  1101  	nfsd_file_lru_remove(nf=
);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1102  	this_cpu_inc(nfsd_file_=
cache_hits);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1103 =20
> 23ba98de6dcec6 Jeff Layton     2022-07-29  1104  	status =3D nfserrno(nfs=
d_open_break_lease(file_inode(nf->nf_file), may_flags));
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1105  out:
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1106  	if (status =3D=3D nfs_o=
k) {
> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1107  		if (open)
> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1108  			this_cpu_inc(nfsd_fil=
e_acquisitions);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1109  		*pnf =3D nf;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1110  	} else {
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1111  		nfsd_file_put(nf);
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1112  		nf =3D NULL;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1113  	}
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1114 =20
> 54f7df7094b329 Chuck Lever     2022-07-08  1115  out_status:
> ce502f81ba884c Chuck Lever     2022-07-08  1116  	put_cred(key.cred);
> be0230069fcbf7 Chuck Lever     2022-07-08  1117  	if (open)
> ce502f81ba884c Chuck Lever     2022-07-08 @1118  		trace_nfsd_file_acquir=
e(rqstp, key.inode, may_flags, nf, status);
>=20
> Passing freed pointers to the trace code is a border line case...  Not
> sure if we care.
>=20

We do care -- that's definitely a bug. I'll plan to spin up a patch to
address it. Nice catch!

-- Jeff

> 65294c1f2c5e72 Jeff Layton     2019-08-18  1119  	return status;
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1120 =20
> 65294c1f2c5e72 Jeff Layton     2019-08-18  1121  open_file:
> b40a2839470cd6 Chuck Lever     2022-07-08  1122  	trace_nfsd_file_alloc(n=
f);
> 427f5f83a3191c Chuck Lever     2022-07-08  1123  	nf->nf_mark =3D nfsd_fi=
le_mark_find_or_create(nf, key.inode);
> fb70bf124b051d Chuck Lever     2022-03-30  1124  	if (nf->nf_mark) {
> 0122e882119ddb Chuck Lever     2022-03-27  1125  		if (open) {
> f4d84c52643ae1 Chuck Lever     2022-03-27  1126  			status =3D nfsd_open_=
verified(rqstp, fhp, may_flags,
> f4d84c52643ae1 Chuck Lever     2022-03-27  1127  						    &nf->nf_file);
> 0122e882119ddb Chuck Lever     2022-03-27  1128  			trace_nfsd_file_open(=
nf, status);
>=20

--=20
Jeff Layton <jlayton@kernel.org>
