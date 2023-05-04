Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25026F6DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEDOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEDOkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:40:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5F0358C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:40:45 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344EZpRF015478;
        Thu, 4 May 2023 14:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AJyZqaB1bab4U3tvgHgrP+C2mc3Jtlr5vUnHOB90K2c=;
 b=QETFLT08Dpc/TdYi8xIay84+LW4/xM+GOOg8UxJG91XjPTQzdQC1GaNNaMyu1mnmdPEa
 /DQZ27/aXEGLTk76RdoXz6umMykQdFfG68Lvsrjp4y9xM7qIkss+qhL9uT0B/8wpGflY
 Fs/hlsO3JeZKFPckAc62+Gmj8KhSxxR4IOS+k6z5R0WTei3AhrdLfWNje3W9BQ4EJAl3
 YpXh90+eAJ7DaRhaTU17dCCHDZw6HlK7JuAxjqkyc9fBOZil3I0q89wtEoLLh/7vhGvZ
 40skUyaLzn1iXYgXoSHk+IvHRCTS47qbfSB3rY4k9mR9W74PYcj/eu1CY1tQZ+gVJ46Z yw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qceec8h7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3440gM7L020923;
        Thu, 4 May 2023 14:40:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6tx2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 344EeYuh37094092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 May 2023 14:40:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4F3520043;
        Thu,  4 May 2023 14:40:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AA6120040;
        Thu,  4 May 2023 14:40:34 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.60.220])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  4 May 2023 14:40:34 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/2] s390/uapi: Cover statfs padding by growing f_spare
Date:   Thu,  4 May 2023 16:40:21 +0200
Message-Id: <20230504144021.808932-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504144021.808932-1-iii@linux.ibm.com>
References: <20230504144021.808932-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C9BKYqGboMPIY73_0YqYDN94ubRFVMPW
X-Proofpoint-GUID: C9BKYqGboMPIY73_0YqYDN94ubRFVMPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=948 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pahole says:

	struct compat_statfs64 {
		...
		u32			f_spare[4];		/*    68    16 */
		/* size: 88, cachelines: 1, members: 12 */
		/* padding: 4 */

	struct statfs {
		...
		unsigned int		f_spare[4];		/*    68    16 */
		/* size: 88, cachelines: 1, members: 12 */
		/* padding: 4 */

	struct statfs64 {
		...
		unsigned int		f_spare[4];		/*    68    16 */
		/* size: 88, cachelines: 1, members: 12 */
		/* padding: 4 */

One has to keep the existence of padding in mind when working with
these structs. Grow f_spare arrays to 5 in order to simplify things.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/compat.h      | 2 +-
 arch/s390/include/uapi/asm/statfs.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index a386070f1d56..3cb9d813f022 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -112,7 +112,7 @@ struct compat_statfs64 {
 	u32		f_namelen;
 	u32		f_frsize;
 	u32		f_flags;
-	u32		f_spare[4];
+	u32		f_spare[5];
 };
 
 /*
diff --git a/arch/s390/include/uapi/asm/statfs.h b/arch/s390/include/uapi/asm/statfs.h
index 72604f7792c3..f85b50723dd3 100644
--- a/arch/s390/include/uapi/asm/statfs.h
+++ b/arch/s390/include/uapi/asm/statfs.h
@@ -30,7 +30,7 @@ struct statfs {
 	unsigned int	f_namelen;
 	unsigned int	f_frsize;
 	unsigned int	f_flags;
-	unsigned int	f_spare[4];
+	unsigned int	f_spare[5];
 };
 
 struct statfs64 {
@@ -45,7 +45,7 @@ struct statfs64 {
 	unsigned int	f_namelen;
 	unsigned int	f_frsize;
 	unsigned int	f_flags;
-	unsigned int	f_spare[4];
+	unsigned int	f_spare[5];
 };
 
 #endif
-- 
2.40.1

