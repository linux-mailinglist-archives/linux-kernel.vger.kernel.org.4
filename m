Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9B67CBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjAZNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbjAZNOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F1F6952C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:39 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCEDhp016689;
        Thu, 26 Jan 2023 13:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=8gE6mK45lDqgsDNu1OfK5EkeRgwy2GF3MN9FQh0hxkI=;
 b=pZtHwRQJ13qxmLQIF3Jt8yOdeKjHKNBlW0kuSaSksP8Xo8du2RObcsem+yUyoGoqR1Fj
 PCRe/paPZroWbubEgQpkg2tOH/v7Wjj3tkoqBPa13WjyHh8OCV2Um/LrAYkynEJGUyv+
 hgPL+KEA+Amnlszgovme7qzIPHHsF9/3njmUn2i6dcN3JJV07ZTxebUOlKCv/OVLucUn
 bk+WTEJMe1NaR85l8cmtrf5CK2WjXvX0sl3C3cNSm/s7LaPo2sGSmITE1afP5rfhjvkB
 V4mYfJLFsiyEOU4lJpUKDTfSuJBUxKmWHClODAppEtLNfyduIJ/1dYy5TLkb4b6uRIvn /A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsbe1cay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PEm5SY031955;
        Thu, 26 Jan 2023 13:14:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p64kar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEU0247448484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB1D820040;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77E6A2004E;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH 5/8] lib/zlib: DFLTCC not writing header bits when avail_out == 0
Date:   Thu, 26 Jan 2023 14:14:25 +0100
Message-Id: <20230126131428.1222214-6-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X5Wz3b56pYRq5y1Zk6XneiEpKyjN0dl-
X-Proofpoint-GUID: X5Wz3b56pYRq5y1Zk6XneiEpKyjN0dl-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=976
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
  https://github.com/zlib-ng/zlib-ng/commit/ce409c6

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_deflate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index 211d344710d5..d4c92f99808e 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -170,13 +170,18 @@ int dfltcc_deflate(
             param->bcf = 0;
             dfltcc_state->block_threshold =
                 strm->total_in + dfltcc_state->block_size;
-            if (strm->avail_out == 0) {
-                *result = need_more;
-                return 1;
-            }
         }
     }
 
+    /* No space for compressed data. If we proceed, dfltcc_cmpr() will return
+     * DFLTCC_CC_OP1_TOO_SHORT without buffering header bits, but we will still
+     * set BCF=1, which is wrong. Avoid complications and return early.
+     */
+    if (strm->avail_out == 0) {
+        *result = need_more;
+        return 1;
+    }
+
     /* The caller gave us too much data. Pass only one block worth of
      * uncompressed data to DFLTCC and mask the rest, so that on the next
      * iteration we start a new block.
-- 
2.34.1

