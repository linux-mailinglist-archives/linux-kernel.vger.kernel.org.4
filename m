Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BFD6F52D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjECIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjECIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:12:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C07B5;
        Wed,  3 May 2023 01:11:50 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3438BVEp023737;
        Wed, 3 May 2023 08:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TZTIlAYz5Xrm3wa3jxWVgbAqiZepf8IQvMmA42vTCVY=;
 b=dFlXR9l856fIKbI2J1x7YENN7vnr/HZ7SWw5QkAxZ8OhEF1mKCpgU5cn/G+WxVRtbJpX
 Am6p/W7j2v/iAu6jcgLbBaBtQb+/JXW+Bu2S+M9Kpg0Z7Bvrir9KFUghuzfwcpY1Xj51
 q8WGwzfolZQBWdT9qZmWWiULXqicPoA3k6D+dgO6uNNMigOl3NrvHkwgcHvHT9aGlZ0l
 AZ+7eSd7s9fwjnGZf65B9A/D/bGsM+Y2fATHOjc2Vcf1GwVwtiV5n0j18xWWWaSs20Bl
 4Ose0A/aq84eXbd+N3j4bpadmtkXKfsh5ebU40pk4xnp393Uyr8pBxY3bafdfKNjn7Di lw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qbjqfhv6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 08:11:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342437qa027740;
        Wed, 3 May 2023 08:11:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q8tv6t26w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 08:11:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3438BeaV34865832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 May 2023 08:11:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD5B12004B;
        Wed,  3 May 2023 08:11:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69D72004F;
        Wed,  3 May 2023 08:11:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  3 May 2023 08:11:40 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] Fix perf test probe libc's inet_pton on s390
Date:   Wed,  3 May 2023 10:11:34 +0200
Message-Id: <20230503081134.3372415-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mJOiGhctZuvIl8KHMKcJs6DhbHoeAf0u
X-Proofpoint-ORIG-GUID: mJOiGhctZuvIl8KHMKcJs6DhbHoeAf0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With Fedora 38 the perf test 86 probe libc's inet_pton
fails on s390. The call chain of the ping command changed.
The functions text_to_binary_address() and gaih_inet() do
not show up in the call chain anymore.

Output before:
 # ./perf test -v 86
 86: probe libc's inet_pton & backtrace it with ping                 :
 --- start ---
 test child forked, pid 541050
 fgrep: warning: fgrep is obsolescent; using grep -F
 fgrep: warning: fgrep is obsolescent; using grep -F
 BFD: DWARF error: could not find variable specification at offset 0x22011
 ...

 ping 541078 [002] 348826.679581: probe_libc:inet_pton_1: (3ffad84b940)
 14b940 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
 10e9c3 __GI_getaddrinfo+0xeb3 (inlined)
 4397 main+0x737 (/usr/bin/ping)
  FAIL: expected backtrace entry "gaih_inet.*\+0x[[:xdigit:]]\
         +[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$"
         got "4397 main+0x737 (/usr/bin/ping)"
 test child finished with -1
 ---- end ----
 probe libc's inet_pton & backtrace it with ping: FAILED!
 #

Output after:
 # ./perf test -v 86
 86: probe libc's inet_pton & backtrace it with ping                 :
 --- start ---
 test child forked, pid 541098
 fgrep: warning: fgrep is obsolescent; using grep -F
 fgrep: warning: fgrep is obsolescent; using grep -F
 BFD: DWARF error: could not find variable specification at offset 0x309d1
 ...

 ping 541126 [006] 349309.099067: probe_libc:inet_pton_1: (3ffb7f4b940)
 14b940 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
 10e9c3 __GI_getaddrinfo+0xeb3 (inlined)
 4397 main+0x737 (/usr/bin/ping)
 test child finished with 0
 ---- end ----
 probe libc's inet_pton & backtrace it with ping: Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index b4149b2db4c6..4c739056cb65 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -38,8 +38,6 @@ trace_libc_inet_pton_backtrace() {
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
-		echo "text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
-		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
-- 
2.40.0

