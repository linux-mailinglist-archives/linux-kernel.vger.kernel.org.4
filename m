Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC39631E58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKUK2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKUK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:28:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900CF1DF3B;
        Mon, 21 Nov 2022 02:28:35 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALA0kHV025901;
        Mon, 21 Nov 2022 10:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=D/hh7DEq8C7afgU8Ly2ABga2BgcTiw2WRowCgfSv4Bc=;
 b=X6s55OINhevZC2ga8RYjK7r05ncruvtSVJQ4tef4AXwv05eZNA/F9AmvNfei3SEPKn9a
 0Kivu0/9KyB6zvuhRI4PkOvOiwlhpLprbloyg8Rb7zgDSNUNNt4LGAQpozIscy5YAZ4X
 VfRWfSvxExzH6L3+DnqJjLOlvOQQquT6063D+bSHrvG8r4TrhVDi08vzrxg0uHrWX4+Y
 N5jt0HJxhkzF516jZVGcrJFufDy11H6GggzNAHBk80O/rdNU4f1Br0dNY933YvtpW014
 HPIQUNRBr46squIZ0aF6+DSDK+XGgMBj/YYhfqwO0JsN8a1mSAYis3amuOdqNipCBGPS gA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky9a25uvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:28:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALAKpva002080;
        Mon, 21 Nov 2022 10:28:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kxps8tg2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 10:28:17 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALAM5xQ40567070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 10:22:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D0DD11C04A;
        Mon, 21 Nov 2022 10:28:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6EF211C054;
        Mon, 21 Nov 2022 10:28:13 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.68.13])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 10:28:13 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Disha Goel <disgoel@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] perf test: Skip watchpoint tests if no watchpoints available
Date:   Mon, 21 Nov 2022 15:57:47 +0530
Message-Id: <20221121102747.208289-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tRRaPVTLEBLEIcsJe37p0t0tZ10F4Ho_
X-Proofpoint-GUID: tRRaPVTLEBLEIcsJe37p0t0tZ10F4Ho_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On IBM Power9, perf watchpoint tests fail since no hardware breakpoints
are available. Detect this by checking the error returned by
perf_event_open() and skip the tests in that case.

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/tests/wp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 56455da30341b4..cc8719609b19ea 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -59,8 +59,10 @@ static int __event(int wp_type, void *wp_addr, unsigned long wp_len)
 	get__perf_event_attr(&attr, wp_type, wp_addr, wp_len);
 	fd = sys_perf_event_open(&attr, 0, -1, -1,
 				 perf_event_open_cloexec_flag());
-	if (fd < 0)
+	if (fd < 0) {
+		fd = -errno;
 		pr_debug("failed opening event %x\n", attr.bp_type);
+	}
 
 	return fd;
 }
@@ -77,7 +79,7 @@ static int test__wp_ro(struct test_suite *test __maybe_unused,
 
 	fd = __event(HW_BREAKPOINT_R, (void *)&data1, sizeof(data1));
 	if (fd < 0)
-		return -1;
+		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
 	WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
@@ -101,7 +103,7 @@ static int test__wp_wo(struct test_suite *test __maybe_unused,
 
 	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
 	if (fd < 0)
-		return -1;
+		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
 	WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
@@ -126,7 +128,7 @@ static int test__wp_rw(struct test_suite *test __maybe_unused,
 	fd = __event(HW_BREAKPOINT_R | HW_BREAKPOINT_W, (void *)&data1,
 		     sizeof(data1));
 	if (fd < 0)
-		return -1;
+		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	tmp = data1;
 	WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 1);
@@ -150,7 +152,7 @@ static int test__wp_modify(struct test_suite *test __maybe_unused, int subtest _
 
 	fd = __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
 	if (fd < 0)
-		return -1;
+		return fd == -ENODEV ? TEST_SKIP : -1;
 
 	data1 = tmp;
 	WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);

base-commit: 63a3bf5e8d9e79ce456c8f73d4395a5a51d841b1
-- 
2.38.1

