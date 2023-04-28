Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058246F118F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjD1F77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjD1F75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:59:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA62689;
        Thu, 27 Apr 2023 22:59:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RKPCrD031856;
        Fri, 28 Apr 2023 05:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=fUeCGzF2E/MJpwwWsgeCABFqdUqiBLxFGm1C7ZyiMnU=;
 b=CRVuBVELEk0nDpCg8ePKt3xe+lEoLxsuSnoHdkmKLnsG7OkE0+zM85dghSwtfjeH8Shq
 s/QonyhCHF4I+XCh9MJjYUHl2UEQ/iB7/zifzVvaS3mcBosBS2hdObzRZxlk07QNbD8r
 gPfwVAAiqzSW67NalW8304EbrjkbKnLiVK/10D3Grkl3zMzNcly7lLyVepyfWJjYw9Pk
 kDkA3F+/5mqSLo/hNUpCGcnmiFkvEgNmULzuIXfJXNmOy7qm3N2gqxVLpya7wsDFCntF
 ALRalrrV7eZ/w8VExUBJGZLb60N/UhCjF1F32MXAcxLZfYfcDKw1teNoslohauPMUXWD HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u5e9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 05:59:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33S4XU2E008644;
        Fri, 28 Apr 2023 05:59:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q461ahpm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Apr 2023 05:59:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33S5v0aN014799;
        Fri, 28 Apr 2023 05:59:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q461ahpm4-1;
        Fri, 28 Apr 2023 05:59:50 +0000
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     mcgrof@kernel.org, linux-modules@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, error27@gmail.com,
        kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] module: Fix use-after-free bug in read_file_mod_stats()
Date:   Thu, 27 Apr 2023 22:59:33 -0700
Message-Id: <20230428055933.2699308-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_02,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280048
X-Proofpoint-GUID: _VFUwZeukZMWnvtc5VMW4LkaK160HGLs
X-Proofpoint-ORIG-GUID: _VFUwZeukZMWnvtc5VMW4LkaK160HGLs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch warns:
	kernel/module/stats.c:394 read_file_mod_stats()
	warn: passing freed memory 'buf'

We are passing 'buf' to simple_read_from_buffer() after freeing it.

Fix this by changing the order of 'simple_read_from_buffer' and 'kfree'.

Fixes: df3e764d8e5c ("module: add debug stats to help identify memory pressure")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Found with statis analysis, only compile tested.
---
 kernel/module/stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/module/stats.c b/kernel/module/stats.c
index ad7b6ada29f2..6ab2c94d6bc3 100644
--- a/kernel/module/stats.c
+++ b/kernel/module/stats.c
@@ -276,6 +276,7 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 	struct mod_fail_load *mod_fail;
 	unsigned int len, size, count_failed = 0;
 	char *buf;
+	int ret;
 	u32 live_mod_count, fkreads, fdecompress, fbecoming, floads;
 	unsigned long total_size, text_size, ikread_bytes, ibecoming_bytes,
 		idecompress_bytes, imod_bytes, total_virtual_lost;
@@ -390,8 +391,9 @@ static ssize_t read_file_mod_stats(struct file *file, char __user *user_buf,
 out_unlock:
 	mutex_unlock(&module_mutex);
 out:
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, len);
 	kfree(buf);
-        return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return ret;
 }
 #undef MAX_PREAMBLE
 #undef MAX_FAILED_MOD_PRINT
-- 
2.40.0

