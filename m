Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A050D6C0995
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCTEJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCTEJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:09:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06631EF99;
        Sun, 19 Mar 2023 21:09:00 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K239vM007733;
        Mon, 20 Mar 2023 04:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+c0v0f+QowBSsrYxlfwLSKzDuPmAMcXRbidWbkS9Di0=;
 b=AqC2cZxbpptE9ygbWlD4eLnIMhV5eIjL8MMS4ZYRnwT2D6mQDlGGX/0eILzcvQtRT7a2
 64n9IfIKKK0TNsVX2Emu2FcJwjCTbjzMBM15aLFyn5RQu0Iy84sOBBlstRvrnZNwFIan
 vK60k4TZNNZ/MN/VvJj2uqAeaNfjRFu1+932++ZfI23SnJla3eF/AiXiQNwwbm5ZXeJ3
 D/HC03lB0GB6PA72PUEIyxQ0Lry9JaF0c//bfaOzoNC+ekdvBaeh5+L8cR3S4iunRwRY
 RyzZHW5fP6n7kruR/xWocuQGSyjkYQXk/yNGfIOjTZRxzpI7sqyPbGWytYDa9fbxRS3l FA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pdq5p54b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 04:08:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32JARoTU017094;
        Mon, 20 Mar 2023 04:08:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6an1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 04:08:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32K48tKo23396922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 04:08:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 580112004D;
        Mon, 20 Mar 2023 04:08:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBAD220040;
        Mon, 20 Mar 2023 04:08:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Mar 2023 04:08:54 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E247E602FE;
        Mon, 20 Mar 2023 15:08:49 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 1/2] initramfs: Check negative timestamp to prevent broken cpio archive
Date:   Mon, 20 Mar 2023 15:08:38 +1100
Message-Id: <20230320040839.660475-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EMHSJnVCmMQhS9ullXJc7ze42ztu3ZUs
X-Proofpoint-GUID: EMHSJnVCmMQhS9ullXJc7ze42ztu3ZUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_01,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 4c9d410f32b3 ("initramfs: Check timestamp to prevent
broken cpio archive"), except asserts that the timestamp is
non-negative. This can happen when the KBUILD_BUILD_TIMESTAMP is a value
before UNIX epoch, which may be set when making reproducible builds that
don't want to look like they use a valid date.

While support for dates before 1970 might not be supported, this is more
about preventing undetected CPIO corruption. The printf's use a minimum
length format specifier, and will happily make the field longer than 8
characters if they need to.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>

---

Ran into this when setting KBUILD_BUILD_TIMESTAMP=0000-01-01. The kernel
builds and boots to an initramfs just fine, but inexplicably failed to
load any root disks. It was a pain to debug, because the first sign of
an issue was so deep into the boot sequence.
---
 usr/gen_init_cpio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index ee01e40e8bc6..61230532fef1 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -353,6 +353,12 @@ static int cpio_mkfile(const char *name, const char *location,
 		buf.st_mtime = 0xffffffff;
 	}
 
+	if (buf.st_mtime < 0) {
+		fprintf(stderr, "%s: Timestamp negative, clipping.\n",
+			location);
+		buf.st_mtime = 0;
+	}
+
 	if (buf.st_size > 0xffffffff) {
 		fprintf(stderr, "%s: Size exceeds maximum cpio file size\n",
 			location);
@@ -602,10 +608,10 @@ int main (int argc, char *argv[])
 	/*
 	 * Timestamps after 2106-02-07 06:28:15 UTC have an ascii hex time_t
 	 * representation that exceeds 8 chars and breaks the cpio header
-	 * specification.
+	 * specification. Negative timestamps similarly exceed 8 chars.
 	 */
-	if (default_mtime > 0xffffffff) {
-		fprintf(stderr, "ERROR: Timestamp too large for cpio format\n");
+	if (default_mtime > 0xffffffff || default_mtime < 0) {
+		fprintf(stderr, "ERROR: Timestamp out of range for cpio format\n");
 		exit(1);
 	}
 

base-commit: 065ffaee73892e8a3629b4cfbe635697807a3c6f
-- 
2.39.2

