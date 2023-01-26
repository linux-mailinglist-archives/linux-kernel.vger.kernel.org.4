Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6567CBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbjAZNPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbjAZNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCF66FBA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:36 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QBgG5s015214;
        Thu, 26 Jan 2023 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=YgFIywuUEopc3ChgAdbXsdUgSWsLi3fA2zApwH+LBsc=;
 b=igncZ3Qo1E3Caw3gBvpyTlODIVf7uXHq0v9mFza/OnxsHMFRy9Ai5IUHG+5a8kFXdlj/
 a7evaulxVoQ6y2+b5qnw68TGXKrrDCw6v9nXvJN1q4SEom+3KZosqqW4xFhukQ36Y8wV
 XLfa1y/ECXFiLsR8W3cpTIRC0DwlLovKoiHnF2HettWTQPplYWBOKnsOogBldyLOfXsl
 a65l1AIVNdnmv3QfzwOZ2XF98cxIkOneoIE17IsHpx5B36N2fmk5MQ7ClaIzlHo3DxMR
 O46udSj8Wx6CYO16/s5lUN2BDcL6lB0vK9psIxUiVNf+sOFAwZmkLG1RRQS4xujyE/Vy cQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbn5b6wq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:35 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QAlWRh014468;
        Thu, 26 Jan 2023 13:14:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n87p6cmjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDETP848693646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD3020040;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A92F120043;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:29 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 2/8] lib/zlib: Implement switching between DFLTCC and software
Date:   Thu, 26 Jan 2023 14:14:22 +0100
Message-Id: <20230126131428.1222214-3-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bDsiIdKX97KHrIICD7h_9VtwSLHIbDVe
X-Proofpoint-ORIG-GUID: bDsiIdKX97KHrIICD7h_9VtwSLHIbDVe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=875 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is based on:
  https://github.com/zlib-ng/zlib-ng/commit/fc04275

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_deflate.c | 38 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index 6c946e8532ee..dc85ec890163 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -112,30 +112,36 @@ int dfltcc_deflate(
     int soft_bcc;
     int no_flush;
 
-    if (!dfltcc_can_deflate(strm))
+    if (!dfltcc_can_deflate(strm)) {
+        /* Clear history. */
+        if (flush == Z_FULL_FLUSH)
+            param->hl = 0;
         return 0;
+    }
 
 again:
     masked_avail_in = 0;
     soft_bcc = 0;
     no_flush = flush == Z_NO_FLUSH;
 
-    /* Trailing empty block. Switch to software, except when Continuation Flag
-     * is set, which means that DFLTCC has buffered some output in the
-     * parameter block and needs to be called again in order to flush it.
+    /* No input data. Return, except when Continuation Flag is set, which means
+     * that DFLTCC has buffered some output in the parameter block and needs to
+     * be called again in order to flush it.
      */
-    if (flush == Z_FINISH && strm->avail_in == 0 && !param->cf) {
-        if (param->bcf) {
-            /* A block is still open, and the hardware does not support closing
-             * blocks without adding data. Thus, close it manually.
-             */
+    if (strm->avail_in == 0 && !param->cf) {
+        /* A block is still open, and the hardware does not support closing
+         * blocks without adding data. Thus, close it manually.
+         */
+        if (!no_flush && param->bcf) {
             send_eobs(strm, param);
             param->bcf = 0;
         }
-        return 0;
-    }
-
-    if (strm->avail_in == 0 && !param->cf) {
+        /* Let one of deflate_* functions write a trailing empty block. */
+        if (flush == Z_FINISH)
+            return 0;
+        /* Clear history. */
+        if (flush == Z_FULL_FLUSH)
+            param->hl = 0;
         *result = need_more;
         return 1;
     }
@@ -189,7 +195,7 @@ int dfltcc_deflate(
     param->cvt = CVT_ADLER32;
     if (!no_flush)
         /* We need to close a block. Always do this in software - when there is
-         * no input data, the hardware will not nohor BCC. */
+         * no input data, the hardware will not hohor BCC. */
         soft_bcc = 1;
     if (flush == Z_FINISH && !param->bcf)
         /* We are about to open a BFINAL block, set Block Header Final bit
@@ -204,8 +210,8 @@ int dfltcc_deflate(
     param->sbb = (unsigned int)state->bi_valid;
     if (param->sbb > 0)
         *strm->next_out = (Byte)state->bi_buf;
-    if (param->hl)
-        param->nt = 0; /* Honor history */
+    /* Honor history and check value */
+    param->nt = 0;
     param->cv = strm->adler;
 
     /* When opening a block, choose a Huffman-Table Type */
-- 
2.34.1

