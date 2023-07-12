Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F087501AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGLIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGLIfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:35:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14530E5;
        Wed, 12 Jul 2023 01:31:54 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8L5EY028658;
        Wed, 12 Jul 2023 08:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uRT61NFpDTRsJjOg1gEjy4NqWCRo3v9MyRHkp85FAXk=;
 b=ImxhnBPBLc+J3iaHZnppBDKMf9w/jrSDVzRKCxdM4RHzcc/p9tw8QXjCjSGpJR148lLS
 YvIkQSiMF9AcjZfkz3zdT7NuLiwMKYjydKOFSfjAMCfjDafFCJXfRmGAJ29ep1wAX1Zj
 6P1t8uPJlZa7OFa7ZkA1vUFd3/cpWoL4gOyEwwTMFUdHpERYmTG+e6st0/dorpTALxF0
 cV5Z3+gK8TMOXEEBk2N1ZeNYINi3hDkcMp9C6MINB2jRzEw3+z3xLK9S13VdQgkIAiQg
 qiAO2zhRKe5IoYOmuoRPNNxV724P0ePkRKZpSoqQoF41qhQMhMWU5Jlgbodj60IqjFou 8Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsrkag7q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:31:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C4JFnj001199;
        Wed, 12 Jul 2023 08:30:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye5ahy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:30:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36C8Uk0m26608176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 08:30:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D65D2004B;
        Wed, 12 Jul 2023 08:30:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C9EF20043;
        Wed, 12 Jul 2023 08:30:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 08:30:45 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Fix broken feature check for llvm due to C++ standard
Date:   Wed, 12 Jul 2023 10:30:36 +0200
Message-Id: <20230712083037.4081444-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dmSb8W6CpCX_SVXsxCHLsGWgeCxe6Wc6
X-Proofpoint-ORIG-GUID: dmSb8W6CpCX_SVXsxCHLsGWgeCxe6Wc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build auto-detects features and packages already installed
for its build. This is done in directory tools/build/feature. This
directory contains small sample programs. When they successfully
compile the necessary prereqs in form of libraries and header
files are present.

Such a check is also done for llvm. And this check fails.
Fix this and update to the latest C++ standard.

Output before:
 # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
 g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
	 	> test-llvm.make.output 2>&1 -std=gnu++14 \
	-I/usr/include 		\
	-L/usr/lib64		\
	-lLLVM-16		\
			\
	> test-llvm.make.output 2>&1

 make: *** [Makefile:343: test-llvm.bin] Error 1
 -bash: ./test-llvm.bin: No such file or directory
 #

Output after:
 # rm -f ./test-llvm.bin; make test-llvm.bin; ./test-llvm.bin
 g++  -MD -Wall -Werror -o test-llvm.bin test-llvm.cpp \
	 	> test-llvm.make.output 2>&1 -std=gnu++17 \
	-I/usr/include 		\
	-L/usr/lib64		\
	-lLLVM-16		\
			\
	> test-llvm.make.output 2>&1
 Hello World!
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0f0aa9b7d7b5..f8db69654791 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -340,7 +340,7 @@ $(OUTPUT)test-jvmti-cmlr.bin:
 	$(BUILD)
 
 $(OUTPUT)test-llvm.bin:
-	$(BUILDXX) -std=gnu++14 				\
+	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
 		$(shell $(LLVM_CONFIG) --libs Core BPF)		\
-- 
2.41.0

