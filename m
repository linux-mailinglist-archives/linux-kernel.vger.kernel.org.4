Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE327501A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjGLIfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGLIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:34:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77D46A1;
        Wed, 12 Jul 2023 01:31:12 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8Lees002969;
        Wed, 12 Jul 2023 08:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=jf6odRfBfMhCoLLCi3/EFoWJ+oADv8iSXTDyUmCpUjc=;
 b=dEhLVonKjY5w63xh1Pi1vOWYf43DaTpEc223FbT4Xf2RTNxK+v37wRWCNI9JOY6InsY4
 j8TokxC1PNGlaml1VKLN0FZOU7GiSWgXCb1KmoUuFB19OEiqGmXulfeaRQoGaaOo6WXR
 w3GX1/8qoyMfGE6iCb87Bm70mxjynQAjek8Y9Ia5q8jQbg2ATpzi98pAUEFDSDxT7nxc
 RwkjVvONL7LueRnstrM6KSd8jI1uMF7cE8qBHC9fQaZArG+SvSGt0ArMzgIeAplWD84L
 fTpR+uQo45tqiYL89JTKYwyiiXy+vgWAhRRkm97gvkx32ak+PDT6RbI4b+ztSdG2VT5q BQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsrkmg5qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:31:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C4q8tA012827;
        Wed, 12 Jul 2023 08:30:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rpye5hupa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 08:30:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36C8Us0o43188534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 08:30:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97F9820043;
        Wed, 12 Jul 2023 08:30:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38A0020040;
        Wed, 12 Jul 2023 08:30:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 08:30:54 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Fix broken feature check for clang due to C++ standard and changed library packaging
Date:   Wed, 12 Jul 2023 10:30:37 +0200
Message-Id: <20230712083037.4081444-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712083037.4081444-1-tmricht@linux.ibm.com>
References: <20230712083037.4081444-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zNQWBdYkHHxlzT3QmHedOVIINGTECUd-
X-Proofpoint-ORIG-GUID: zNQWBdYkHHxlzT3QmHedOVIINGTECUd-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

Such a check is also done for clang. And this check fails.

Fix this and update to the latest C++ standard and use the
new library provided by clang (which contains new packaging)
see this link for reference:
 https://fedoraproject.org/wiki/Changes/Stop-Shipping-Individual-Component-Libraries-In-clang-lib-Package

Output before:
 # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
	ll test-clang.make.output
 g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
	 	> test-clang.make.output 2>&1 -std=gnu++14 \
	-I/usr/include 		\
	-L/usr/lib64		\
	-Wl,--start-group -lclangBasic -lclangDriver	\
	  -lclangFrontend -lclangEdit -lclangLex	\
	  -lclangAST -Wl,--end-group 			\
	-lLLVM-16	\
			\
	> test-clang.make.output 2>&1
 make: *** [Makefile:356: test-clang.bin] Error 1
 -bash: ./test-clang.bin: No such file or directory
 -rw-r--r--. 1 root root 252041 Jul 12 09:56 test-clang.make.output
 #

File test-clang.make.output contains many lines of unreferenced
symbols.

Output after:
 # rm -f ./test-clang.bin; make test-clang.bin; ./test-clang.bin; \
	cat test-clang.make.output
 g++  -MD -Wall -Werror -o test-clang.bin test-clang.cpp \
	 > test-clang.make.output 2>&1 -std=gnu++17	\
	-I/usr/include 		\
	-L/usr/lib64		\
	-Wl,--start-group -lclang-cpp -Wl,--end-group	\
	-lLLVM-16	\
			\
	> test-clang.make.output 2>&1
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/build/feature/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f8db69654791..0b4a6e43c5cc 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -353,12 +353,10 @@ $(OUTPUT)test-llvm-version.bin:
 		> $(@:.bin=.make.output) 2>&1
 
 $(OUTPUT)test-clang.bin:
-	$(BUILDXX) -std=gnu++14					\
+	$(BUILDXX) -std=gnu++17					\
 		-I$(shell $(LLVM_CONFIG) --includedir) 		\
 		-L$(shell $(LLVM_CONFIG) --libdir)		\
-		-Wl,--start-group -lclangBasic -lclangDriver	\
-		  -lclangFrontend -lclangEdit -lclangLex	\
-		  -lclangAST -Wl,--end-group 			\
+		-Wl,--start-group -lclang-cpp -Wl,--end-group	\
 		$(shell $(LLVM_CONFIG) --libs Core option)	\
 		$(shell $(LLVM_CONFIG) --system-libs)		\
 		> $(@:.bin=.make.output) 2>&1
-- 
2.41.0

