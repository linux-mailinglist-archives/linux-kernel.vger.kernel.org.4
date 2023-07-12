Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9164C75041C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjGLKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGLKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:07:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF461736;
        Wed, 12 Jul 2023 03:07:01 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C9fgnv011186;
        Wed, 12 Jul 2023 10:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NScVogZcWhMEOEknnUJvZWHUuOxOKzWMoqc8BTmPVaI=;
 b=mGaFmTvP0Z6zzMbjaxt9/e0EY5d4usTLuAoMM7Ei5XgmzXq4Vhf8xItqWRhoaxc7ztik
 w9B4krHRI4WrpZbObiC5po+X7ZYKwv8b5veZ55kUPUki/bREO6tcDH4YQkqOQQ6bmg7f
 Eku2B46bfMI1yLX3o1MXqXu8GqhwZJysz+0Vv1PkzwtaYIPsySqdG05ehOi0TGTkI7g2
 ySvJGOUqRmXNIr2goho48RU9q5lpm4T3DJKl/M92dLhypgjnp/XyK/hGMEFf77aQXfxq
 hjge5LFVO0UP8EtS/A96SeDhrepZNlQ+5sRM80lKyp+kGErXJpT4MWwwu3u01FIOnvJj 6g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsss20ncf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:06:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8DpFW018511;
        Wed, 12 Jul 2023 10:06:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqmu0sw5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 10:06:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CA6VhL23528094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 10:06:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6214F2004D;
        Wed, 12 Jul 2023 10:06:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1787020043;
        Wed, 12 Jul 2023 10:06:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 10:06:31 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf build: Support llvm and clang support compiled in
Date:   Wed, 12 Jul 2023 12:06:26 +0200
Message-Id: <20230712100626.221994-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7W7CGfDVWe_shWw1qAgm4pwqXt1wQs9A
X-Proofpoint-ORIG-GUID: 7W7CGfDVWe_shWw1qAgm4pwqXt1wQs9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build suports llvm and clang support compiled in.
Test case 56 builtin clang support provides a test case
which is always skipped.

Link perf with the latest llvm and clang libraries and
enable this test case.

Use 'make LIBCLANGLLVM=1' to include this support.

Output before:
 # ./perf test 56
 56: builtin clang support                  :
 56.1: builtin clang compile C source to IR : Skip (not compiled in)
 56.2: builtin clang compile C source to ELF object: \
	 				Skip (not compiled in)

Output after:
 # ./perf test 56
 56: builtin clang support                          :
 56.1: builtin clang compile C source to IR         : Ok
 56.2: builtin clang compile C source to ELF object : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/Makefile.perf   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0609c19caabd..a90af438261c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -325,7 +325,7 @@ CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu11
 
-CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
+CXXFLAGS += -std=gnu++17 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
 CXXFLAGS += -ggdb3
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 097316ef38e6..d417d3fea818 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -426,10 +426,7 @@ EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 ifeq ($(USE_CLANG), 1)
-  CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
-  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
-  LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
+  LIBS += -lclang-cpp
 endif
 
 ifeq ($(USE_LLVM), 1)
-- 
2.41.0

