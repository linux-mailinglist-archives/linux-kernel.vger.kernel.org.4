Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF765BB28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbjACHUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjACHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:20:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A709FEF;
        Mon,  2 Jan 2023 23:20:38 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3036fnb1002423;
        Tue, 3 Jan 2023 07:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KbtA/QSegqSd00MHD8ogZ8QdkXrcydGR1GzD64HyzoA=;
 b=XTaQDZ9HLIsdt6Qr9zQpBsepNCAt5bDUuIk7nHbBhpaRhQyqYQoTPh4cqPsWzYVSJZ0r
 ydYToArZEwXyNXeQH0N0x2pcaa/YBPHx1ecGonK27cKi35tcLWz+oWYpW3WBHv8Q4N9a
 1CpDQhbDTU+p/wydXaKdFoUgchhS2kTcQGnLqo7yfuEq9ZDUSRZUus+c9E/b89h1Z1Jp
 uGIj24/qjApEkk+sOmz+sU0s6HEjjRnkWrbnx4FrqmsTGKCxeXJ+xnPi8LN+kSNomNsJ
 8EsKXk+BRD44gv+ydRSbOtipoOTAOQz1rOdXvkd20y+3U1mdq7c88NZR3Sd70iLdPf7s 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvfaprk23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:08 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303713Du000623;
        Tue, 3 Jan 2023 07:20:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvfaprk1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302GYlZH001543;
        Tue, 3 Jan 2023 07:20:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfbeek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 07:20:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3037K25U41025888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 07:20:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 965FF20040;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E522004E;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 07:20:02 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 30AF6E0945; Tue,  3 Jan 2023 08:20:02 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 1/5] nolibc: fix fd_set type
Date:   Tue,  3 Jan 2023 08:19:53 +0100
Message-Id: <20230103071957.222360-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103071957.222360-1-svens@linux.ibm.com>
References: <20230103071957.222360-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MT0mnFE2kQK2MDzTDpHFU6lzRTb97_xZ
X-Proofpoint-ORIG-GUID: 3I_WCHPinxNIZ8plKOF3_IkYTXG4sDhJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=818 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030062
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

