Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E03657918
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiL1O5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiL1O50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:57:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6DE11C0F;
        Wed, 28 Dec 2022 06:57:24 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSCrBTB010328;
        Wed, 28 Dec 2022 14:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HePxARbsuRBd6hmSKzzNhdQxFYzPJUJJD0eoCjZR9Xw=;
 b=C6rGyr7D2oy1BSzPr0nUpvlYTvpL6CUKhgemDdn36VlEd5O6ykTLwRaEcRol4OiyWUip
 2S4XRrrblcURHU84gzMsT/p0g6DWMKBiy1eqs0WbMjySJA3cNSXYhzqraYvxuxTUeG/w
 MEfYwO2TJZnJBvkLtiSowrwoC6SroIK4jC1LSfSSFuZmhSxUW2CsL4sZZ7ED5COPn2gA
 8VpgZ+E5Say2qXOQddGXIZui5NC2UVFQN2Y1yt2GsLQIZ0VFx3Roc3gTdk3GbZsm+hFI
 DfUY1uIv/0qtFt+KtrVgKUSe3lXTtKZdahNykF18yaJho7q6zsik62Xg+R75S6XUkeT6 Zw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mrb9ywrj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 14:57:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BS7b0rv029303;
        Wed, 28 Dec 2022 14:57:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3mns26bxc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 14:57:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BSEv9gi45875648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Dec 2022 14:57:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8C0B2004B;
        Wed, 28 Dec 2022 14:57:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFCBD20043;
        Wed, 28 Dec 2022 14:57:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Dec 2022 14:57:09 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2 1/2] perf/test: Fix perf test 84 on s390
Date:   Wed, 28 Dec 2022 15:57:03 +0100
Message-Id: <20221228145704.2702487-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jKxPRqLco4NlQy_mur0J8YEtMABkY7ow
X-Proofpoint-ORIG-GUID: jKxPRqLco4NlQy_mur0J8YEtMABkY7ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_12,2022-12-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212280124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test '84: probe libc's inet_pton & backtrace it with ping'
fails on s390. Debugging revealed a changed stack trace for the
ping command using probes:

ping 35729 [002]  8006.365063: probe_libc:inet_pton: (3ff9603e7c0)
                  13e7c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
          --->    104371 text_to_binary_address+0xef1 (inlined)
                  104371 gaih_inet+0xef1 (inlined)
                  104371 __GI_getaddrinfo+0xef1 (inlined)
                    5d4b main+0x139b (/usr/bin/ping)

The line ---> text_to_binary_address ...
is new. It was introduced with glibc version 2.36.7.2 released
with Fedora 37 for s390.

Output before
 # ./perf test 84
 84: probe libc's inet_pton & backtrace it with ping   : FAILED!
 #

Output after:
 # ./perf test 84
 84: probe libc's inet_pton & backtrace it with ping   : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 34c400ccbe04..4e9de55d871a 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -37,6 +37,7 @@ trace_libc_inet_pton_backtrace() {
 	case "$(uname -m)" in
 	s390x)
 		eventattr='call-graph=dwarf,max-stack=4'
+		echo "text_to_binary_address.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "(__GI_)?getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
 		echo "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$" >> $expected
-- 
2.38.1

