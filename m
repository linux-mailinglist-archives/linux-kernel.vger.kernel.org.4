Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4DB74EF28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGKMkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGKMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:40:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11223CE;
        Tue, 11 Jul 2023 05:40:46 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BCcgs5030601;
        Tue, 11 Jul 2023 12:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7Z4nNBiHG2CLHL7bxbHabzFzv9LKxp+K8JqoCDa9I9o=;
 b=TY943eaks+/4UDk1Vjb1f7Bn9nxGHGndwPIfRTfhwdIb9E8uuWQpG4DIOwVDy88lYag9
 ZiJ9MRYWe0Tk+jc9VTCL0f62Ij1dEBb6xayGJg538x/h3gmJ+gzJ2PnVG3FY5vbMFTd6
 K9Tfu2Wal2WqP69Px9VJ0if4nd+uQJrtuoArwMD+1wG/0IAEO4QGrZfJIXyVB6YvgcH2
 NIr4I93fi37W5sBgiA6mmFwPnl58OeAqbUlsg6fuP2D1v/PW8tVGIayCj5XU2UVqgfNy
 fV114fJFXv+Ykvx9dKupnPGf9/y/Ce+HQtNpF0MBKt1dtnOmNWJADhMmRkCLkd5y4FJD SA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rs7330bx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:40:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BBDSOP015948;
        Tue, 11 Jul 2023 12:40:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rpye51ava-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 12:40:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BCeZdf60817750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 12:40:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F11C420049;
        Tue, 11 Jul 2023 12:40:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BB6C20043;
        Tue, 11 Jul 2023 12:40:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 12:40:34 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, jolsa@kernel.org, rostedt@goodmis.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/build: fix broken dependency check for libtracefs
Date:   Tue, 11 Jul 2023 14:40:19 +0200
Message-Id: <20230711124019.3167321-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: APOskk5Y4PulSEs0AL9qErN3PdZLd2SV
X-Proofpoint-ORIG-GUID: APOskk5Y4PulSEs0AL9qErN3PdZLd2SV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=881 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Such a check is also done for libtracefs. And this check fails:

Output before:
 # rm -f test-libtracefs.bin; make test-libtracefs.bin
 gcc  -MD -Wall -Werror -o test-libtracefs.bin test-libtracefs.c \
	 > test-libtracefs.make.output 2>&1 -ltracefs
 make: *** [Makefile:211: test-libtracefs.bin] Error 1
 # cat test-libtracefs.make.output
 In file included from test-libtracefs.c:2:
 /usr/include/tracefs/tracefs.h:11:10: fatal error: \
	 event-parse.h: No such file or directory
   11 | #include <event-parse.h>
      |          ^~~~~~~~~~~~~~~
 compilation terminated.
 #

The root cause of this compile error is
commit 880885d9c22e ("libtracefs: Remove "traceevent/" from referencing libtraceevent headers")
in the libtracefs project hosted here:
 https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/

That mentioned patch removes the traceevent/ directory name from
the include statement, causing the file not to be included even
when the libtraceevent-devel package is installed. This package contains
the file referred to in tracefs/tracefs.h:
 # rpm -ql libtraceevent-devel
 /usr/include/traceevent
 /usr/include/traceevent/event-parse.h  <----- here
 /usr/include/traceevent/event-utils.h
 /usr/include/traceevent/kbuffer.h
 /usr/include/traceevent/trace-seq.h
 /usr/lib64/libtraceevent.so
 /usr/lib64/pkgconfig/libtraceevent.pc
 #

With this patch the compile succeeds.

Output after:
 # rm -f test-libtracefs.bin; make test-libtracefs.bin
 gcc  -MD -Wall -Werror -o test-libtracefs.bin test-libtracefs.c \
	 > test-libtracefs.make.output 2>&1 -I/usr/include/traceevent -ltracefs
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: jolsa@kernel.org
Cc: rostedt@goodmis.org
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 0f0aa9b7d7b5..764b0234161f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -208,7 +208,7 @@ $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
 $(OUTPUT)test-libtracefs.bin:
-	$(BUILD) -ltracefs
+	 $(BUILD) -I/usr/include/traceevent -ltracefs
 
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
-- 
2.41.0

