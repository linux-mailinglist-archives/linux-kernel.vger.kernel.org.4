Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA3639FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiK1CqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiK1CqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:46:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E233511814;
        Sun, 27 Nov 2022 18:46:00 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AS0eS9u012364;
        Mon, 28 Nov 2022 02:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vhG9ad//RbYIQjWGxr0QEn/V/Bjh+vj0Xe+bnB9Rl5A=;
 b=tskeKFYWDq59Z9Q7tEPk6NNmpjLg0xN/D/ssd9/7IQ5BymSKODR1+iU7ivkphxj5MGzE
 AEof156OthIhaQrkbk8U1ZFzviCS+QHlIe3fyVMwPyf+Vja9I39Cbs7twOwLlIOt/hl2
 Xo5dScT23kVyW8cnUcOuydbChStyRSgMsov6E67CyJHI+HIXhvrC8PfpDPkhf+urY0m4
 SxuMjJhU1rl/TzDoy0gidaoTTYHXMpc5NFLKhGCO7zlua6d/Fuk5I1wN7UswLFEIJ27B
 qU+lq2PyIZrqKrT5B+ScPFYUG3yneoIGk+GVhx7UAyW0etfGTxHE2N4fX7i4/T7nuLQA 0Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vpkke8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AS2ZJsE023138;
        Mon, 28 Nov 2022 02:45:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3m3ae99uey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 02:45:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AS2kR0l1245720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 02:46:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 077E7AE04D;
        Mon, 28 Nov 2022 02:45:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5C5AAE045;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 02:45:44 +0000 (GMT)
Received: from li-0d7fa1cc-2c9d-11b2-a85c-aed20764436d.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 61CCA60863;
        Mon, 28 Nov 2022 13:45:39 +1100 (AEDT)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, ruscur@russell.cc, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, cmr@bluescreens.de,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [RFC PATCH 09/13] selftests/powerpc: Add more utility macros
Date:   Mon, 28 Nov 2022 13:44:54 +1100
Message-Id: <20221128024458.46121-10-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128024458.46121-1-bgray@linux.ibm.com>
References: <20221128024458.46121-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zbh_HHLX08Nl8ZxDJDbqRRLlWB1yRvzF
X-Proofpoint-GUID: Zbh_HHLX08Nl8ZxDJDbqRRLlWB1yRvzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds more assertion variants to provide more context behind why a
failure occurred.

The SIGSAFE_FAIL_* variants are to allow safely asserting conditions
in a signal handler (though we are about to exit, so it's unlikely to
run into an issue with regular FAIL_IF_EXIT).

Also adds an ARRAY_SIZE macro.

These will be used by the following DEXCR selftests.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 .../testing/selftests/powerpc/include/utils.h | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index 95f3a24a4569..b03d2192c6f6 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -9,12 +9,19 @@
 #define __cacheline_aligned __attribute__((aligned(128)))
 
 #include <stdint.h>
+#include <stdio.h>
 #include <stdbool.h>
+#include <string.h>
+#include <unistd.h>
 #include <linux/auxvec.h>
 #include <linux/perf_event.h>
 #include <asm/cputable.h>
 #include "reg.h"
 
+#ifndef ARRAY_SIZE
+# define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
 /* Avoid headaches with PRI?64 - just use %ll? always */
 typedef unsigned long long u64;
 typedef   signed long long s64;
@@ -111,6 +118,16 @@ do {								\
 	}							\
 } while (0)
 
+#define FAIL_IF_MSG(x, msg)					\
+do {								\
+	if ((x)) {						\
+		fprintf(stderr,					\
+		"[FAIL] Test FAILED on line %d: %s\n", 		\
+		__LINE__, msg);					\
+		return 1;					\
+	}							\
+} while (0)
+
 #define FAIL_IF_EXIT(x)						\
 do {								\
 	if ((x)) {						\
@@ -120,6 +137,16 @@ do {								\
 	}							\
 } while (0)
 
+#define FAIL_IF_EXIT_MSG(x, msg)				\
+do {								\
+	if ((x)) {						\
+		fprintf(stderr,					\
+		"[FAIL] Test FAILED on line %d: %s\n", 		\
+		__LINE__, msg);					\
+		_exit(1);					\
+	}							\
+} while (0)
+
 /* The test harness uses this, yes it's gross */
 #define MAGIC_SKIP_RETURN_VALUE	99
 
@@ -149,6 +176,23 @@ do {								\
 		ssize_t nbytes __attribute__((unused)); \
 		nbytes = write(STDERR_FILENO, msg, strlen(msg)); })
 
+#define SIGSAFE_FAIL_IF_EXIT(x)							\
+do {										\
+	if ((x)) {								\
+		sigsafe_err("[FAIL] Test FAILED on line " str(__LINE__) "\n");	\
+		_exit(1);							\
+	}									\
+} while (0)
+
+#define SIGSAFE_FAIL_IF_EXIT_MSG(x, msg)					\
+do {										\
+	if ((x)) {								\
+		sigsafe_err("[FAIL] Test FAILED on line " 			\
+			    str(__LINE__) ": " msg "\n");			\
+		_exit(1);							\
+	}									\
+} while (0)
+
 /* POWER9 feature */
 #ifndef PPC_FEATURE2_ARCH_3_00
 #define PPC_FEATURE2_ARCH_3_00 0x00800000
-- 
2.38.1

