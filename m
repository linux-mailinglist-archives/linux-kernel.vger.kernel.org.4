Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303136F52E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjECIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECIPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:15:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9FF133;
        Wed,  3 May 2023 01:15:30 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3438FGd8018031;
        Wed, 3 May 2023 08:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oq+VBQkSfSWiiK+RENjjb9DICXFg41U0XSB8KRndZq4=;
 b=GtclZbAwH3elBpjPu1ng23cNGJ0t/zF4inWNB2ZMWbK1Yz77xF8wdOgx0NBA3qAU7fzV
 iX4GjOSrWumS7HN1XAi0O3fPvWPtqa5ZT5vmRH1ky8LfbdU02/DByq7tGj2YJ94H0hpK
 uIIW/GlYal/kqCvLVpHt8o8xlPo/GV9rVAsBbhzKZmVP1PGXjnp7DKBasJ8fafAu3Bw9
 zyWumLNkld0kx9WYaGy6N8mLh3gTq7xnjDBUfwHG2X+PmJHN/MQXmqBtRd5ZMzaTFrJA
 w5o+EM7eG+YhyNYFYexjHzzmualbhYAiXuafpeGIzPEkujrR/ZEEfPhgrSU2kYfjBQ7R Ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qbhjbbkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 08:15:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342NcDAu014756;
        Wed, 3 May 2023 08:13:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6t289-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 08:13:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3438Cvq944630608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 May 2023 08:12:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CB7320040;
        Wed,  3 May 2023 08:12:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB20B2004B;
        Wed,  3 May 2023 08:12:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  3 May 2023 08:12:56 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] Fix perf test probe libc's inet_pton on x86_64
Date:   Wed,  3 May 2023 10:12:55 +0200
Message-Id: <20230503081255.3372986-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N2BoDKQMWFzeQ_-n6o8q4q4tqIFlUNaN
X-Proofpoint-GUID: N2BoDKQMWFzeQ_-n6o8q4q4tqIFlUNaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=949 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case probe libc's inet_pton & backtrace it with ping
fails with Fedora 38 on x86_64.

Function getaddrinfo() does not show up in the call chain anymore:
 # ./perf script
 ping  1803 [000] 728.567146: probe_libc:inet_pton: (7f5275afc840)
           133840 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
            27b4a __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)
            27c0b __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6)

 ping  1803 [000]   728.567184: probe_libc:inet_pton: (7f5275afc840)
           133840 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
             493e main+0xcde (/usr/bin/ping)
            27b4a __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)

 #
which causes the test case to fail. Remove function getaddrinfo()
from list of expected functions.

Output before:
 # ./perf test 'libc'
 91: probe libc's inet_pton & backtrace it with ping    : FAILED!
 #

Output after:
 # ./perf test 'libc'
 91: probe libc's inet_pton & backtrace it with ping    : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index b4149b2db4c6..8d5915d3ad6f 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -51,7 +51,6 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	*)
 		eventattr='max-stack=3'
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
-- 
2.40.1

