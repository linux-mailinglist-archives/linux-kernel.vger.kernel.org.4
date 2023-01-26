Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B40267CBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjAZNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbjAZNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:52 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C702B67786
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:14:36 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QD0CJ9007255;
        Thu, 26 Jan 2023 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=PAn+dHflp2HX8qjUM0ZtsYPKZ9xsKmu5OnG1Dj3Iljk=;
 b=Ot5LMrGVIgrlue1ujEVHAqOD5mtlKm5qI4IQGKxqejck1IVobwjEYkOai+qs3BrDkjPJ
 VwG0OfTwagt6axZY2Mw1SdlpQ4FxcT2UjykDWvAjlxAS4ys/mNxIUClZ9yeSVC6luyEL
 MJNot4Zbhx+3lOyH34qJmlD7hJi768vzyvyGJXxzWISql3OvQwej7hzGkRqBeAWti20y
 1KWzsnPbcryOCvsWxgEsZ12Advqn95bNMr2J/H5CbniZvY6KVTLwH9r0WyFll3otdX+4
 3J6i2wdCXWIKqk+3hq/8ELRqv7oCRCZJcJzHgjfYgU2ialAzZ4e4/EnHiH6AtKq37tAI iw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbsb1sdjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QCLmfV019104;
        Thu, 26 Jan 2023 13:14:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6pdjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 13:14:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QDEU6C47251912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DC7320040;
        Thu, 26 Jan 2023 13:14:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D7E20043;
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
Subject: [PATCH 4/8] lib/zlib: Fix DFLTCC ignoring flush modes when avail_in == 0
Date:   Thu, 26 Jan 2023 14:14:24 +0100
Message-Id: <20230126131428.1222214-5-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
References: <20230126131428.1222214-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SBa6gkwlLfS6xCJajZS5tvDav8CNnH8D
X-Proofpoint-ORIG-GUID: SBa6gkwlLfS6xCJajZS5tvDav8CNnH8D
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 mlxscore=0 mlxlogscore=709 classifier=spam adjust=0 reason=mlx scancount=1
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
  https://github.com/zlib-ng/zlib-ng/commit/40acb3f

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc_deflate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
index dc85ec890163..211d344710d5 100644
--- a/lib/zlib_dfltcc/dfltcc_deflate.c
+++ b/lib/zlib_dfltcc/dfltcc_deflate.c
@@ -142,7 +142,8 @@ int dfltcc_deflate(
         /* Clear history. */
         if (flush == Z_FULL_FLUSH)
             param->hl = 0;
-        *result = need_more;
+        /* Trigger block post-processing if necessary. */
+        *result = no_flush ? need_more : block_done;
         return 1;
     }
 
-- 
2.34.1

