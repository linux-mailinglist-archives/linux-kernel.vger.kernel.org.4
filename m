Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D95864B3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiLMK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiLMK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:57:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755251165;
        Tue, 13 Dec 2022 02:57:46 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD9AQDf003783;
        Tue, 13 Dec 2022 10:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XiK7J/1ktzDbjREs0kGxte/ZhmscYe+yynabo/BcqMw=;
 b=YBLMACewwYCORaVD+d5e6U+9VSSOeqP9ZWPp9cGOqeCih6Sre05HjEkJEbRxbZuHIZvx
 35aaDUu1GrZYQOidpYJSIypzcdrR83I5/5EBBmtKykd5e2JrnJS/v7pDgNgQIWVViQCr
 tC1G+3m/UvIPqi6CVY59t/13QVM6W5fFui9eAn1TeqaaraimFnVdDzy27zoHUHkrHiBS
 UKlk3CpUAlJgjJ9RBk+Bx0pfqmFj/3877cWs9qNlVMVpNhBdA4QKn32Fvnwo2i59myJd
 d+YT8QpBOOvhPqFcqln2QHkxx1Ay26NSLX++gxRdWrwpSMCM+X5mBAmJAqMI7ct4wB+K Yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mep3vu4yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:57:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD4ehfU028390;
        Tue, 13 Dec 2022 10:57:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mchr641nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:57:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDAvcKp48234926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 10:57:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8118F20049;
        Tue, 13 Dec 2022 10:57:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AEBB20040;
        Tue, 13 Dec 2022 10:57:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 10:57:38 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf/test: Fix perf test 89 on x86
Date:   Tue, 13 Dec 2022 11:57:29 +0100
Message-Id: <20221213105729.1447368-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213105729.1447368-1-tmricht@linux.ibm.com>
References: <20221213105729.1447368-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qZ5WhW-iuQGi-tMAX1nZTD_QWgKgF7Q3
X-Proofpoint-GUID: qZ5WhW-iuQGi-tMAX1nZTD_QWgKgF7Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test '89: probe libc's inet_pton & backtrace it with ping'
fails on x86. Debugging revealed a changed stack trace for the
ping command using probes:

ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
                  12be50 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
                  4fca main+0x139b (/usr/bin/ping)

The line getaddrinfo.... in the call stack is gone.
It was introduced with glibc version 2.36.8 released
with Fedora 37.

Output before on x86
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : FAILED!
 #

Output after on x86:
 # ./perf test 89
 89: probe libc's inet_pton & backtrace it with ping   : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 0f01c62cbee9..51ae8b906055 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -50,7 +50,6 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	*)
 		eventattr='max-stack=3'
-		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
 	esac
-- 
2.38.1

