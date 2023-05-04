Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62E6F6DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjEDOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjEDOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:40:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1332D43;
        Thu,  4 May 2023 07:40:39 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344EdXHl030081;
        Thu, 4 May 2023 14:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bGpmwO8CNHgB/VUTWxghbR2Zxwr3spTuGVNeeNtfl/A=;
 b=tMwtLaqotOHf4/JZB9Bb3l6PJjwLLvx9EluheiLEsPrzjwwlxxZw7wXGuiISxiOz8fOg
 KaaGsbYXIh5yB1qRitrL76C402tCwrfssmFYl0TWytq8vR5ay7ZgK4fD+pJi6QzxePhi
 EAjG70a7f8WnoHW2nlRE2YCcf3vES5kf9ZZ3TNPV5DzWVSO7UTzlkFyl9lGhqz8gryAK
 YAZFPhoBAfRCMSE5789+VwvQA1w3G7DbgWCKnVDvVrdCGi4B3JD6uu3HL4A5zsC3R057
 vup0P5/F8MoFUdqps3PqEc6eVqhnlxSboOD1/DN54IJG9Jw3DztMj9Xe61+n6hjEuHLR 5w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qcav0ypm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 344Dc7Wt020202;
        Thu, 4 May 2023 14:40:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6tdnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 14:40:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 344EeVrR4522542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 May 2023 14:40:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA91C20040;
        Thu,  4 May 2023 14:40:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 076C920049;
        Thu,  4 May 2023 14:40:31 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.60.220])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  4 May 2023 14:40:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] statfs: Enforce statfs[64] structure intialization
Date:   Thu,  4 May 2023 16:40:20 +0200
Message-Id: <20230504144021.808932-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504144021.808932-1-iii@linux.ibm.com>
References: <20230504144021.808932-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y2Wfn83BKyDPOVyPSKKOQOZZEaneWj8P
X-Proofpoint-ORIG-GUID: y2Wfn83BKyDPOVyPSKKOQOZZEaneWj8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s390's struct statfs and struct statfs64 contain padding, which
field-by-field copying does not set. Initialize the respective structs
with zeros before filling them and copying them to userspace, like it's
already done for the compat versions of these structs.

Found by KMSAN.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fs/statfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 0ba34c135593..96d1c3edf289 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -130,6 +130,7 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		if (sizeof buf.f_blocks == 4) {
 			if ((st->f_blocks | st->f_bfree | st->f_bavail |
 			     st->f_bsize | st->f_frsize) &
@@ -158,7 +159,6 @@ static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
@@ -171,6 +171,7 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 	if (sizeof(buf) == sizeof(*st))
 		memcpy(&buf, st, sizeof(*st));
 	else {
+		memset(&buf, 0, sizeof(buf));
 		buf.f_type = st->f_type;
 		buf.f_bsize = st->f_bsize;
 		buf.f_blocks = st->f_blocks;
@@ -182,7 +183,6 @@ static int do_statfs64(struct kstatfs *st, struct statfs64 __user *p)
 		buf.f_namelen = st->f_namelen;
 		buf.f_frsize = st->f_frsize;
 		buf.f_flags = st->f_flags;
-		memset(buf.f_spare, 0, sizeof(buf.f_spare));
 	}
 	if (copy_to_user(p, &buf, sizeof(buf)))
 		return -EFAULT;
-- 
2.40.1

