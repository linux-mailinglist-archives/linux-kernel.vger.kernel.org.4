Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8167CBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjAZNP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbjAZNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085569515
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:37 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCvE8o024932;
        Thu, 26 Jan 2023 13:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=xZnK30byH773TSlmzCY8FkqJLqxkE35ZGt5rDfbB3AQ=;
 b=sjZgNM8gGykl6+aE/qeCiuyijmbNc0q6rOkgQLJxU2Ju7E6Gruz3NWZgFOMFVndwwUb8
 nQJdFd3XAaMKXA8YeTmQ7BEYVHumnRN6OVaF9HwiQ+HvoS93s8aKI0hI7Q+JNBV8kWDl
 NnxYAwKABOJwwQrqvAHPKoJ1w8l8QVoPRSsEnZpSBsGEuz+X7CeoQDbJYiAI3uHdWazC
 654+VhxB0mrUOfW9hHlK8ZRq40+b9mcTOY2dACQpmplc+wr7MZFTVp+/7Z/XNggx9IxJ
 Tdjis8sVU48ioO6WAqYtOdJYb1PkTe0RvSzqrai8qOw+yWZdyOJG8uz4ZSou4zr1gadW qA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsymrh0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QApjVV015356;
        Thu, 26 Jan 2023 13:14:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87afeds4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEUia47251910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 270F920040;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7B512004B;
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
Subject: [PATCH 3/8] lib/zlib: Fix DFLTCC not flushing EOBS when creating raw streams
Date:   Thu, 26 Jan 2023 14:14:23 +0100
Message-Id: <20230126131428.1222214-4-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KLd4gjgFqewnrScAbuH9bAGRAo3XtEgo
X-Proofpoint-ORIG-GUID: KLd4gjgFqewnrScAbuH9bAGRAo3XtEgo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=758 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is based on:
  https://github.com/zlib-ng/zlib-ng/commit/ca99a88

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_deflate/deflate.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/zlib_deflate/deflate.c b/lib/zlib_deflate/deflate.c
index 8a878d0d892c..f30d6b8a69b2 100644
--- a/lib/zlib_deflate/deflate.c
+++ b/lib/zlib_deflate/deflate.c
@@ -451,17 +451,24 @@ int zlib_deflate(
     Assert(strm->avail_out > 0, "bug2");
 
     if (flush != Z_FINISH) return Z_OK;
-    if (s->noheader) return Z_STREAM_END;
 
-    /* Write the zlib trailer (adler32) */
-    putShortMSB(s, (uInt)(strm->adler >> 16));
-    putShortMSB(s, (uInt)(strm->adler & 0xffff));
+    if (!s->noheader) {
+	/* Write zlib trailer (adler32) */
+	putShortMSB(s, (uInt)(strm->adler >> 16));
+	putShortMSB(s, (uInt)(strm->adler & 0xffff));
+    }
     flush_pending(strm);
     /* If avail_out is zero, the application will call deflate again
      * to flush the rest.
      */
-    s->noheader = -1; /* write the trailer only once! */
-    return s->pending != 0 ? Z_OK : Z_STREAM_END;
+    if (!s->noheader) {
+	s->noheader = -1; /* write the trailer only once! */
+    }
+    if (s->pending == 0) {
+	Assert(s->bi_valid == 0, "bi_buf not flushed");
+	return Z_STREAM_END;
+    }
+    return Z_OK;
 }
 
 /* ========================================================================= */
-- 
2.34.1

