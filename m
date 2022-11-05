Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCA61D9A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKELRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKELRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:17:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083B113D2C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 04:17:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h9so10214600wrt.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 04:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Si94ZMOqZApo/tqZlFfwM+8QQ9+VSKuozugTWexiopk=;
        b=FZudOjhTEyATx22mqCzPBdqZtdiLw/ZQsxDbUYQg69eVMJVEkDv8KkdbJyOG1RnjaX
         t8U/rcjRHgUT8+Ksq47CcJQNfeLU0iOwRfct/eTPJXeqZZZ8USvyDs+if1b7hc3ANjFw
         TC82ULBhqqmB9ixGrN6bjdWuBXS8wFlTe3bRY7hMHPETh2gEM5W7kz0Fob4bwrl6JEc4
         NchrkQ5nw5EQM+cnvAorTtUtgdwkNqtUKjFrLsT3ifMU7ZOXMqOyWmARiZaffjELwsLu
         0NToNfY+DzLHr3uKsc32qHjsFQQ4xj2D/FP28qUnta/FzRUptfRpGguDajTCe0DWBIab
         3ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Si94ZMOqZApo/tqZlFfwM+8QQ9+VSKuozugTWexiopk=;
        b=DFi2wmx1UdepSpHyIWnCMlMmrFl4JzEyBGgOwoVjcE80CIx+XfuxzOC7cPNd+Adyj3
         nx9+v7wQScGCMtn9tNd+K+TQfWZsUtkMx82cEr502r3JJdkwrS3VKvcEr70axhhgA+wq
         Sm0TR1+jKVL6LLsbRIWvSgKL56QmGXTDrZCj3FRRIQIwrsG4OPnW2xcoVg+fGEY8ru1p
         6810X09IQqWQ9MAN2hwgSPXbHvT/steNNn+aDb/ZCEy/UOYPVwqcgM9U9XhGp0IedSl+
         V9agY0qy88iI0I24Y+ziFGpdtFktfC70MrwvrbN6PM95XDdqpD0rvY8wrxdZhDrPg/Ec
         nM6Q==
X-Gm-Message-State: ACrzQf307hZphC8LK+Dp+/aze1csIG4thn4vIr/kVD3VdKSjRsGIMpcv
        VxPuVNUv9nFJm5nQtscVLRs=
X-Google-Smtp-Source: AMsMyM4nf41/lp9JammxVZcK55Sf6kQmNHZsIlvqeE93InYqSuQbXAypyCRg/dLIMwdLm6lU/y1PwA==
X-Received: by 2002:adf:feca:0:b0:236:b258:c19b with SMTP id q10-20020adffeca000000b00236b258c19bmr25022844wrs.57.1667647069528;
        Sat, 05 Nov 2022 04:17:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c320800b003b4935f04a4sm2533392wmp.5.2022.11.05.04.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:17:49 -0700 (PDT)
Date:   Sat, 5 Nov 2022 14:17:46 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Jeff Layton <jlayton@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing freed
 memory 'nf'
Message-ID: <202211051543.2bnSgTQW-lkp@intel.com>
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
head:   b208b9fbbcba743fb269d15cb46a4036b01936b1
commit: 243a5263014a30436c93ed3f1f864c1da845455e nfsd: rework hashtable handling in nfsd_do_file_acquire
config: alpha-randconfig-m041-20221030
compiler: alpha-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing freed memory 'nf'

vim +/nf +1118 fs/nfsd/filecache.c

fb70bf124b051d Chuck Lever     2022-03-30  1036  static __be32
be0230069fcbf7 Chuck Lever     2022-07-08  1037  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
fb70bf124b051d Chuck Lever     2022-03-30  1038  		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
65294c1f2c5e72 Jeff Layton     2019-08-18  1039  {
ce502f81ba884c Chuck Lever     2022-07-08  1040  	struct nfsd_file_lookup_key key = {
ce502f81ba884c Chuck Lever     2022-07-08  1041  		.type	= NFSD_FILE_KEY_FULL,
ce502f81ba884c Chuck Lever     2022-07-08  1042  		.need	= may_flags & NFSD_FILE_MAY_MASK,
ce502f81ba884c Chuck Lever     2022-07-08  1043  		.net	= SVC_NET(rqstp),
ce502f81ba884c Chuck Lever     2022-07-08  1044  	};
243a5263014a30 Jeff Layton     2022-10-04  1045  	bool open_retry = true;
243a5263014a30 Jeff Layton     2022-10-04  1046  	struct nfsd_file *nf;
ce502f81ba884c Chuck Lever     2022-07-08  1047  	__be32 status;
243a5263014a30 Jeff Layton     2022-10-04  1048  	int ret;
65294c1f2c5e72 Jeff Layton     2019-08-18  1049  
65294c1f2c5e72 Jeff Layton     2019-08-18  1050  	status = fh_verify(rqstp, fhp, S_IFREG,
65294c1f2c5e72 Jeff Layton     2019-08-18  1051  				may_flags|NFSD_MAY_OWNER_OVERRIDE);
65294c1f2c5e72 Jeff Layton     2019-08-18  1052  	if (status != nfs_ok)
65294c1f2c5e72 Jeff Layton     2019-08-18  1053  		return status;
ce502f81ba884c Chuck Lever     2022-07-08  1054  	key.inode = d_inode(fhp->fh_dentry);
ce502f81ba884c Chuck Lever     2022-07-08  1055  	key.cred = get_current_cred();
65294c1f2c5e72 Jeff Layton     2019-08-18  1056  
65294c1f2c5e72 Jeff Layton     2019-08-18  1057  retry:
243a5263014a30 Jeff Layton     2022-10-04  1058  	rcu_read_lock();
243a5263014a30 Jeff Layton     2022-10-04  1059  	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
ce502f81ba884c Chuck Lever     2022-07-08  1060  			       nfsd_file_rhash_params);
ce502f81ba884c Chuck Lever     2022-07-08  1061  	if (nf)
ce502f81ba884c Chuck Lever     2022-07-08  1062  		nf = nfsd_file_get(nf);
243a5263014a30 Jeff Layton     2022-10-04  1063  	rcu_read_unlock();
65294c1f2c5e72 Jeff Layton     2019-08-18  1064  	if (nf)
65294c1f2c5e72 Jeff Layton     2019-08-18  1065  		goto wait_for_construction;
65294c1f2c5e72 Jeff Layton     2019-08-18  1066  
243a5263014a30 Jeff Layton     2022-10-04  1067  	nf = nfsd_file_alloc(&key, may_flags);
243a5263014a30 Jeff Layton     2022-10-04  1068  	if (!nf) {
54f7df7094b329 Chuck Lever     2022-07-08  1069  		status = nfserr_jukebox;
54f7df7094b329 Chuck Lever     2022-07-08  1070  		goto out_status;
65294c1f2c5e72 Jeff Layton     2019-08-18  1071  	}
65294c1f2c5e72 Jeff Layton     2019-08-18  1072  
243a5263014a30 Jeff Layton     2022-10-04  1073  	ret = rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
243a5263014a30 Jeff Layton     2022-10-04  1074  					   &key, &nf->nf_rhash,
ce502f81ba884c Chuck Lever     2022-07-08  1075  					   nfsd_file_rhash_params);
243a5263014a30 Jeff Layton     2022-10-04  1076  	if (likely(ret == 0))
65294c1f2c5e72 Jeff Layton     2019-08-18  1077  		goto open_file;
243a5263014a30 Jeff Layton     2022-10-04  1078  
243a5263014a30 Jeff Layton     2022-10-04  1079  	nfsd_file_slab_free(&nf->nf_rcu);
243a5263014a30 Jeff Layton     2022-10-04  1080  	if (ret == -EEXIST)
243a5263014a30 Jeff Layton     2022-10-04  1081  		goto retry;
243a5263014a30 Jeff Layton     2022-10-04  1082  	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, ret);
243a5263014a30 Jeff Layton     2022-10-04  1083  	status = nfserr_jukebox;
243a5263014a30 Jeff Layton     2022-10-04  1084  	goto out_status;
65294c1f2c5e72 Jeff Layton     2019-08-18  1085  
65294c1f2c5e72 Jeff Layton     2019-08-18  1086  wait_for_construction:
65294c1f2c5e72 Jeff Layton     2019-08-18  1087  	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
65294c1f2c5e72 Jeff Layton     2019-08-18  1088  
65294c1f2c5e72 Jeff Layton     2019-08-18  1089  	/* Did construction of this file fail? */
65294c1f2c5e72 Jeff Layton     2019-08-18  1090  	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
ce502f81ba884c Chuck Lever     2022-07-08  1091  		trace_nfsd_file_cons_err(rqstp, key.inode, may_flags, nf);
243a5263014a30 Jeff Layton     2022-10-04  1092  		if (!open_retry) {
28c7d86bb6172f Trond Myklebust 2020-01-06  1093  			status = nfserr_jukebox;
28c7d86bb6172f Trond Myklebust 2020-01-06  1094  			goto out;
28c7d86bb6172f Trond Myklebust 2020-01-06  1095  		}
243a5263014a30 Jeff Layton     2022-10-04  1096  		open_retry = false;
65294c1f2c5e72 Jeff Layton     2019-08-18  1097  		nfsd_file_put_noref(nf);
65294c1f2c5e72 Jeff Layton     2019-08-18  1098  		goto retry;
65294c1f2c5e72 Jeff Layton     2019-08-18  1099  	}
65294c1f2c5e72 Jeff Layton     2019-08-18  1100  
4a0e73e635e3f3 Chuck Lever     2022-07-08  1101  	nfsd_file_lru_remove(nf);
65294c1f2c5e72 Jeff Layton     2019-08-18  1102  	this_cpu_inc(nfsd_file_cache_hits);
65294c1f2c5e72 Jeff Layton     2019-08-18  1103  
23ba98de6dcec6 Jeff Layton     2022-07-29  1104  	status = nfserrno(nfsd_open_break_lease(file_inode(nf->nf_file), may_flags));
65294c1f2c5e72 Jeff Layton     2019-08-18  1105  out:
65294c1f2c5e72 Jeff Layton     2019-08-18  1106  	if (status == nfs_ok) {
29d4bdbbb910f3 Chuck Lever     2022-07-08  1107  		if (open)
29d4bdbbb910f3 Chuck Lever     2022-07-08  1108  			this_cpu_inc(nfsd_file_acquisitions);
65294c1f2c5e72 Jeff Layton     2019-08-18  1109  		*pnf = nf;
65294c1f2c5e72 Jeff Layton     2019-08-18  1110  	} else {
65294c1f2c5e72 Jeff Layton     2019-08-18  1111  		nfsd_file_put(nf);
65294c1f2c5e72 Jeff Layton     2019-08-18  1112  		nf = NULL;
65294c1f2c5e72 Jeff Layton     2019-08-18  1113  	}
65294c1f2c5e72 Jeff Layton     2019-08-18  1114  
54f7df7094b329 Chuck Lever     2022-07-08  1115  out_status:
ce502f81ba884c Chuck Lever     2022-07-08  1116  	put_cred(key.cred);
be0230069fcbf7 Chuck Lever     2022-07-08  1117  	if (open)
ce502f81ba884c Chuck Lever     2022-07-08 @1118  		trace_nfsd_file_acquire(rqstp, key.inode, may_flags, nf, status);

Passing freed pointers to the trace code is a border line case...  Not
sure if we care.

65294c1f2c5e72 Jeff Layton     2019-08-18  1119  	return status;
65294c1f2c5e72 Jeff Layton     2019-08-18  1120  
65294c1f2c5e72 Jeff Layton     2019-08-18  1121  open_file:
b40a2839470cd6 Chuck Lever     2022-07-08  1122  	trace_nfsd_file_alloc(nf);
427f5f83a3191c Chuck Lever     2022-07-08  1123  	nf->nf_mark = nfsd_file_mark_find_or_create(nf, key.inode);
fb70bf124b051d Chuck Lever     2022-03-30  1124  	if (nf->nf_mark) {
0122e882119ddb Chuck Lever     2022-03-27  1125  		if (open) {
f4d84c52643ae1 Chuck Lever     2022-03-27  1126  			status = nfsd_open_verified(rqstp, fhp, may_flags,
f4d84c52643ae1 Chuck Lever     2022-03-27  1127  						    &nf->nf_file);
0122e882119ddb Chuck Lever     2022-03-27  1128  			trace_nfsd_file_open(nf, status);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

