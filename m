Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2365746E46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGDKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:09:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CDBEE;
        Tue,  4 Jul 2023 03:09:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3649mxc9009597;
        Tue, 4 Jul 2023 10:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=hIOOORGKchniqO/ljMV0WdlZFmGdCm3uJig2Sk2ciks=;
 b=aVhFg3VsJFHRyy9NgKUkdw0B8DEGSA2vfQY1RZ9NxAPC6lMACKpla3mPZpT/GdDmM5pn
 kptqwVnfoiA59H1X4ocwdWCcPEEJSlGNyNm4pwuVSV6kggwS8eRXDbrKaKlUYtow8hOj
 Wnk4bG0ovS4Bvgj/FXKV750SicT4q5ftWRKDyeCAlxEhU+C9IQ8csAylWrLFJErCEO2a
 YrtsWTAcko+Xh0nfB2vCy3i1rDV52/NlBCDGjDON4Q/CISRtXtgbo19MHjzTufS5T1al
 ivpJfKTsGuiX8BcVqrn8GBlXcRH3i8IHGGpt1qm/IhSF+kGPEWX7Y2wUVR/mjhL+pq68 CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3cd8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 10:09:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3648GwoV040268;
        Tue, 4 Jul 2023 10:09:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjaka7chv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 10:09:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364A9HcN013879;
        Tue, 4 Jul 2023 10:09:17 GMT
Received: from t460.home (dhcp-10-175-46-67.vpn.oracle.com [10.175.46.67])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rjaka7cdp-1;
        Tue, 04 Jul 2023 10:09:17 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] module: always complete idempotent loads
Date:   Tue,  4 Jul 2023 12:08:52 +0200
Message-Id: <20230704100852.23452-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
In-Reply-To: <20230704092309.22669-1-vegard.nossum@oracle.com>
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040084
X-Proofpoint-GUID: pGNn9Duf_TvizPL9OBKB_r5ogqocdSf7
X-Proofpoint-ORIG-GUID: pGNn9Duf_TvizPL9OBKB_r5ogqocdSf7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9b9879fc0327 added a hashtable storing lists of concurrent module
loads. However, it didn't fix up all the error paths in
init_module_from_file(); this would lead to leaving the function while an
on-stack 'struct idempotent' element is still in the hash table, which
leads to all sorts of badness as spotted by syzkaller:

    BUG: soft lockup in sys_finit_module
    BUG: unable to handle kernel paging request in init_module_from_file
    general protection fault in init_module_from_file
    INFO: task hung in init_module_from_file
    KASAN: out-of-bounds Read in init_module_from_file
    KASAN: slab-out-of-bounds Read in init_module_from_file
    KASAN: slab-use-after-free Read in init_module_from_file
    KASAN: slab-use-after-free Read in set_powered_sync
    KASAN: stack-out-of-bounds Read in init_module_from_file
    KASAN: use-after-free in init_module_from_file
    KASAN: use-after-free Read in init_module_from_file

Fixes: 9b9879fc0327 ("modules: catch concurrent module loads, treat them as idempotent")
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reported-by: syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com
Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rudi Heitbaum <rudi@heitbaum.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 kernel/module/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d6de66a6a1ac..6100d0373f2f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3121,39 +3121,42 @@ static void idempotent_complete(struct idempotent *u, int ret)
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
 {
 	struct idempotent idem;
 	struct load_info info = { };
 	void *buf = NULL;
 	int len, ret;
 
 	if (!f || !(f->f_mode & FMODE_READ))
 		return -EBADF;
 
 	if (idempotent(&idem, file_inode(f))) {
 		wait_for_completion(&idem.complete);
 		return idem.ret;
 	}
 
 	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
 	if (len < 0) {
 		mod_stat_inc(&failed_kreads);
 		mod_stat_add_long(len, &invalid_kread_bytes);
-		return len;
+		ret = len;
+		goto out;
 	}
 
 	if (flags & MODULE_INIT_COMPRESSED_FILE) {
 		int err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
-			return err;
+			ret = err;
+			goto out;
 		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
 	}
 
 	ret = load_module(&info, uargs, flags);
+out:
 	idempotent_complete(&idem, ret);
 	return ret;
 }
-- 

