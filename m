Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB564B34F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiLMKhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLMKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:37:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45D13D24;
        Tue, 13 Dec 2022 02:37:31 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDABtPg018718;
        Tue, 13 Dec 2022 10:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1NN0Rppdl5utQouzpbeF67DiosgrDFg5Cdov7E8HXuE=;
 b=YOl8ofvk1YOX/OdbnG3mYtDLJ4zLuz5QuP9JKDGklqCEHVHh7Nx1lbJe02Ydb2ktM9Yx
 b6PtFG8cwaY0yaerkbcVa+5pmbDeHNlK71Cehty1EXbmTsWuuqjuzYLOR2oKJhL7shKB
 uHDmT3bfDDm2vehYFekaWhDZZGxdC1H61sYrZyREgaLEToNfFa1bASzgiwqSaBi4QKlZ
 BOyXTaJ/zMpo0APBOV5RRMKKgQmR+tnOUfA4COZ2X0xeyZQIrtx2M31s88TvsNIDMU6O
 4/8Mm+cO3gvrOdeEGFM/q8cv6YjE8fbVX77bymw9CVJ952CH5LY8Xw5q1MzCl5PX1jFq dQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3meqe5rh2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:37:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD4xhcR007765;
        Tue, 13 Dec 2022 10:37:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf41e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 10:37:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDAbMAH19595762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 10:37:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E3272004B;
        Tue, 13 Dec 2022 10:37:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45B8020049;
        Tue, 13 Dec 2022 10:37:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 10:37:21 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, Thomas Richter <richter@de.ibm.com>
Subject: [PATCH 2/2] perf/test: Fix perf test 89 on x86
Date:   Tue, 13 Dec 2022 11:37:08 +0100
Message-Id: <20221213103708.1287991-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213103708.1287991-1-tmricht@linux.ibm.com>
References: <20221213103708.1287991-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5dSLTgzRAoQOf0AeAOX0hywuIiv_STvz
X-Proofpoint-ORIG-GUID: 5dSLTgzRAoQOf0AeAOX0hywuIiv_STvz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <richter@de.ibm.com>

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

Signed-off-by: Thomas Richter <richter@de.ibm.com>
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

