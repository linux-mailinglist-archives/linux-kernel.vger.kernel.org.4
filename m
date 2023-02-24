Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7815D6A1970
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBXKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBXKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC120041;
        Fri, 24 Feb 2023 02:03:17 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31O8OjmX021873;
        Fri, 24 Feb 2023 10:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l6hfr2TPJ8B8NKe7xbDlRZ0HjFIueFW+X6e7USoZ0Ko=;
 b=LZoYy7hvrQekT3d0l5SYBzzcloAI6jeNHoHM3JBR0jZNmoptIDBwK3A+JNat713nQ19F
 f00SkvH8yFQ+cQP7hX+DZh7qUE3sjKiMOC7Zr1JgfgGXIFB7Ght3kg2X2UQsZ5zSN9py
 9PagkQD9xxrGk9c8fa0kq+jRM+nWSplH/dbjyGyyrlM42xYvRWDgCHf3XdKIevkeIlfi
 Q2Fb90qh7eaF1+w7gFboDX5uTX6CNpQg0b2o8QLHLSHzquyErJX0BPVcSnBZT4+VBXHa
 Okxs9vHrGkHuMWsAjyeaPTJjPmH0DA9oPVqC+qfPcSzxX98wq2+WVhdM9UVEeXsYRAen xA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nxsq1j10f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31NNJ42U019945;
        Fri, 24 Feb 2023 10:02:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ntnxf7t0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:02:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31OA2cNt54002050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 10:02:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DFD720043;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D93F20067;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Feb 2023 10:02:38 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] s390/rwonce: add READ_ONCE_ALIGNED_128() macro
Date:   Fri, 24 Feb 2023 11:02:36 +0100
Message-Id: <20230224100237.3247871-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230224100237.3247871-1-hca@linux.ibm.com>
References: <20230224100237.3247871-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J_h9P7IN1UOkpYBB3G8Im60BZqZve3pu
X-Proofpoint-GUID: J_h9P7IN1UOkpYBB3G8Im60BZqZve3pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_04,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 mlxlogscore=780 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an s390 specific READ_ONCE_ALIGNED_128() helper, which can be used for
fast block concurrent (atomic) 128-bit accesses.

The used lpq instruction requires 128-bit alignment. This is also the
reason why the compiler doesn't emit this instruction if __READ_ONCE() is
used for 128-bit accesses.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/rwonce.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/s390/include/asm/rwonce.h

diff --git a/arch/s390/include/asm/rwonce.h b/arch/s390/include/asm/rwonce.h
new file mode 100644
index 000000000000..91fc24520e82
--- /dev/null
+++ b/arch/s390/include/asm/rwonce.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_S390_RWONCE_H
+#define __ASM_S390_RWONCE_H
+
+#include <linux/compiler_types.h>
+
+/*
+ * Use READ_ONCE_ALIGNED_128() for 128-bit block concurrent (atomic) read
+ * accesses. Note that x must be 128-bit aligned, otherwise a specification
+ * exception is generated.
+ */
+#define READ_ONCE_ALIGNED_128(x)			\
+({							\
+	union {						\
+		typeof(x) __x;				\
+		__uint128_t val;			\
+	} __u;						\
+							\
+	BUILD_BUG_ON(sizeof(x) != 16);			\
+	asm volatile(					\
+		"	lpq	%[val],%[_x]\n"		\
+		: [val] "=d" (__u.val)			\
+		: [_x] "QS" (x)				\
+		: "memory");				\
+	__u.__x;					\
+})
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_S390_RWONCE_H */
-- 
2.37.2

