Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7E69E121
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjBUNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:16:27 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A6B29149
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 05:16:24 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LD8L8u031006;
        Tue, 21 Feb 2023 13:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=t570j4iKRFdEqVsJz64LsyMM/AFJq94Bu5NtctLEiV4=;
 b=rBfJw4+PlTpeLQcpqCRW/NeSMF+LitJn6A/aOHUj3aKcal9NwOzzOuxPLu3/WQEg3CtW
 L+c0wH5ZN8Fz8QuphC2CHmrqgUYptJBRZZDN0smuFDkw/bHhV2ctEEnmxFCQR0aiZRuF
 jI54Y28zHQ6DmkrB7ucXN9QUk/ktbaqtn87BLhwi3aJew8tDQitTaX8JswD9G0t10cfM
 mzfMLxBoYlJDfpcJ3DzoaXZEG18Ta12JFeOK+CQ180flwEO93LHcM4Q13EWJHw+mjWiZ
 klEbqHec0q3B6CGKz38eC7nSGRovbS0BSnAUNEbkSZlF2KgLrPTHvlyS1170VakPwmZ9 Og== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nvragseb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:16:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31L8UuQj019836;
        Tue, 21 Feb 2023 13:16:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf41u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 13:16:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31LDGIiR54133198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 13:16:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F68120040;
        Tue, 21 Feb 2023 13:16:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF09D2004E;
        Tue, 21 Feb 2023 13:16:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Feb 2023 13:16:17 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, zaslonko@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] lib/zlib: DFLTCC deflate does not write all available bits for Z_NO_FLUSH
Date:   Tue, 21 Feb 2023 14:16:17 +0100
Message-Id: <20230221131617.3369978-2-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221131617.3369978-1-zaslonko@linux.ibm.com>
References: <20230221131617.3369978-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ieto8a3QUNRm5pcPNjDn8OqyqzugWHx-
X-Proofpoint-ORIG-GUID: Ieto8a3QUNRm5pcPNjDn8OqyqzugWHx-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DFLTCC deflate with Z_NO_FLUSH might generate a corrupted stream when
the output buffer is not large enough to fit all the deflate output at
once. The problem takes place on closing the deflate block since
flush_pending() might leave some output bits not written.
Similar problem for software deflate with Z_BLOCK flush option (not
supported by kernel zlib deflate) has been fixed a while ago in userspace
zlib but the fix never got to the kernel.
Now flush_pending() flushes the bit buffer before copying out the byte buffer,
in order to really flush as much as possible.
Currently there are no users of DFLTCC deflate with Z_NO_FLUSH option in the
kernel so the problem remained hidden for a while.

This commit is based on the old zlib commit:
https://github.com/madler/zlib/commit/0b828b4

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_deflate/defutil.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/zlib_deflate/defutil.h b/lib/zlib_deflate/defutil.h
index 385333b22ec6..4ea40f5a279f 100644
--- a/lib/zlib_deflate/defutil.h
+++ b/lib/zlib_deflate/defutil.h
@@ -420,9 +420,11 @@ static inline void flush_pending(
 	z_streamp strm
 )
 {
+    unsigned len;
     deflate_state *s = (deflate_state *) strm->state;
-    unsigned len = s->pending;
 
+    bi_flush(s);
+    len = s->pending;
     if (len > strm->avail_out) len = strm->avail_out;
     if (len == 0) return;
 
-- 
2.37.2

