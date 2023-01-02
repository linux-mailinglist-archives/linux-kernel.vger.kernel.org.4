Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7965B009
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjABKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjABKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B760F8;
        Mon,  2 Jan 2023 02:52:06 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3029h56C021097;
        Mon, 2 Jan 2023 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KbtA/QSegqSd00MHD8ogZ8QdkXrcydGR1GzD64HyzoA=;
 b=WdfxpVADB5wOqszCTbaBPAxYrRpMe/NuhHR8uzy9guk8dtplCjMNMKoMCsCoRp13JGeF
 IJSKrO7a0jsYgyw4DVHOXRjp8nTe0tRYmtEwg6sEonshj9MRPU3lWIbEHuU3PUbM0SIz
 ULgRD34w3ss+pDRRNJOmC1k+zpw5L88uRPwhuIqa62wtlOfg9XzX1wXyWJ864sOrllUC
 DBeEPZ2tcNiA/0SxmDzpgiezdiyiHq0t2Nldyb+bMA76L2YZECQDY1nxxPLf+2AbwOWx
 ag5weTGDpGrAqZVt5+kQMSjVPo+moN4RLvCKjFbMOz066fTmj/9IpDZlyoo81O8VBRWH Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxhhewcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:36 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302Ai8w9020833;
        Mon, 2 Jan 2023 10:51:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxhhewc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3018xKEB023584;
        Mon, 2 Jan 2023 10:51:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6hp9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302ApUrK18743610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 10:51:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD34620043;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC58C20040;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 85F19E08FE; Mon,  2 Jan 2023 11:51:30 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/5] nolibc: fix fd_set type
Date:   Mon,  2 Jan 2023 11:51:08 +0100
Message-Id: <20230102105112.1661651-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102105112.1661651-1-svens@linux.ibm.com>
References: <20230102105112.1661651-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zBRoqc5Ry0zBxrkn3BIC6xCGNdU7U9fa
X-Proofpoint-GUID: zx343A3Dwe0xR0F3I-Ihc-GjkGigbHHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_05,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 adultscore=0 mlxlogscore=818 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301020096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel uses unsigned long for the fd_set bitmap,
but nolibc use u32. This works fine on little endian
machines, but fails on big endian. Convert to unsigned
long to fix this.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 tools/include/nolibc/types.h | 53 ++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 959997034e55..300e0ff1cd58 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -89,39 +89,46 @@
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
+#define FD_SETIDXMASK (8 * sizeof(unsigned long))
+#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
+
 /* for select() */
 typedef struct {
-	uint32_t fd32[(FD_SETSIZE + 31) / 32];
+	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
 } fd_set;
 
-#define FD_CLR(fd, set) do {                                            \
-		fd_set *__set = (set);                                  \
-		int __fd = (fd);                                        \
-		if (__fd >= 0)                                          \
-			__set->fd32[__fd / 32] &= ~(1U << (__fd & 31)); \
+#define FD_CLR(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] &=		\
+				~(1U << (__fd & FX_SETBITMASK));	\
 	} while (0)
 
-#define FD_SET(fd, set) do {                                            \
-		fd_set *__set = (set);                                  \
-		int __fd = (fd);                                        \
-		if (__fd >= 0)                                          \
-			__set->fd32[__fd / 32] |= 1U << (__fd & 31);    \
+#define FD_SET(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] |=		\
+				1 << (__fd & FD_SETBITMASK);		\
 	} while (0)
 
-#define FD_ISSET(fd, set) ({                                                  \
-		fd_set *__set = (set);                                        \
-		int __fd = (fd);                                              \
-		int __r = 0;                                                  \
-		if (__fd >= 0)                                                \
-			__r = !!(__set->fd32[__fd / 32] & 1U << (__fd & 31)); \
-		__r;                                                          \
+#define FD_ISSET(fd, set) ({						\
+			fd_set *__set = (set);				\
+			int __fd = (fd);				\
+		int __r = 0;						\
+		if (__fd >= 0)						\
+			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
+1U << (__fd & FD_SET_BITMASK));						\
+		__r;							\
 	})
 
-#define FD_ZERO(set) do {                                               \
-		fd_set *__set = (set);                                  \
-		int __idx;                                              \
-		for (__idx = 0; __idx < (FD_SETSIZE+31) / 32; __idx ++) \
-			__set->fd32[__idx] = 0;                         \
+#define FD_ZERO(set) do {						\
+		fd_set *__set = (set);					\
+		int __idx;						\
+		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
+		for (__idx = 0; __idx < __size; __idx++)		\
+			__set->fds[__idx] = 0;				\
 	} while (0)
 
 /* for poll() */
-- 
2.34.1

