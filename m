Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFC67CBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjAZNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjAZNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B8C69532
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:38 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCQbss005037;
        Thu, 26 Jan 2023 13:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=7r2mDRtDMM+WwBgVFZDwhKhdqARVKa701LAzYRRKgZw=;
 b=qo34bdf4FTrHDe9NgWhHP0uhlt1bHmcE27uwBdl4Zbalx2j1HlFWSiVOFKsZ4Zm2exwc
 vxB0gqlIHHN+J8JkKLTGwYRvfQjOxrYlSkTxneKg9WSX5iybalJJq2BkG8XfOfHv6v4w
 4S2Rpmra8qPDVBDVTMywQyhTAM+129he45IDyY7kV8JFJQsdX6tEgYPqO/7yZVA6xLlU
 XR6snQbZuDXeMOQt7Kn7eoB/k3blyT8E5QDKdme24SkhK/rb8aqNmVJc9KKnwS38T6oj
 cKVOVI6/nG+jHjISm09SPzUgPukSlMvHTFv7hO3NMs1FDIgK4zaEM36RIhD04jzptMO9 rw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbshdh6wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q3rEOb027380;
        Thu, 26 Jan 2023 13:14:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n87p64kas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEVia36700586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 371AA20040;
        Thu, 26 Jan 2023 13:14:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 042402004B;
        Thu, 26 Jan 2023 13:14:31 +0000 (GMT)
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
Subject: [PATCH 7/8] lib/zlib: DFLTCC support inflate with small window
Date:   Thu, 26 Jan 2023 14:14:27 +0100
Message-Id: <20230126131428.1222214-8-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qDRetewmgAVgNF7wKmpCBy68e0naAze1
X-Proofpoint-GUID: qDRetewmgAVgNF7wKmpCBy68e0naAze1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no hardware control for DFLTCC window size.
After this change, software and hardware window formats no longer
match: the software will use wbits and wsize, and the hardware will use
HB_BITS and HB_SIZE.

Since neither dictionary manipulation nor internal allocation functions
are relevant to kernel zlib and zlib_inflate_workspacesize() always use
MAX_WBITS for window size calculation, only dfltcc_can_inflate() and
dfltcc_inflate() functions are affected by this patch.

This commit is based on:
  https://github.com/zlib-ng/zlib-ng/commit/3eab317

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_inflate.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/zlib_dfltcc/dfltcc_inflate.c b/lib/zlib_dfltcc/dfltcc_inflate.c
index a16f416c8811..5786030c6dc2 100644
--- a/lib/zlib_dfltcc/dfltcc_inflate.c
+++ b/lib/zlib_dfltcc/dfltcc_inflate.c
@@ -22,10 +22,6 @@ int dfltcc_can_inflate(
             zlib_dfltcc_support == ZLIB_DFLTCC_DEFLATE_ONLY)
         return 0;
 
-    /* Unsupported compression settings */
-    if (state->wbits != HB_BITS)
-        return 0;
-
     /* Unsupported hardware */
     return is_bit_set(dfltcc_state->af.fns, DFLTCC_XPND) &&
                is_bit_set(dfltcc_state->af.fmts, DFLTCC_FMT0);
@@ -129,8 +125,6 @@ dfltcc_inflate_action dfltcc_inflate(
     /* Translate stream to parameter block */
     param->cvt = CVT_ADLER32;
     param->sbb = state->bits;
-    param->hl = state->whave; /* Software and hardware history formats match */
-    param->ho = (state->write - state->whave) & ((1 << HB_BITS) - 1);
     if (param->hl)
         param->nt = 0; /* Honor history for the first block */
     param->cv = state->check;
@@ -144,8 +138,6 @@ dfltcc_inflate_action dfltcc_inflate(
     strm->msg = oesc_msg(dfltcc_state->msg, param->oesc);
     state->last = cc == DFLTCC_CC_OK;
     state->bits = param->sbb;
-    state->whave = param->hl;
-    state->write = (param->ho + param->hl) & ((1 << HB_BITS) - 1);
     state->check = param->cv;
     if (cc == DFLTCC_CC_OP2_CORRUPT && param->oesc != 0) {
         /* Report an error if stream is corrupted */
-- 
2.34.1

