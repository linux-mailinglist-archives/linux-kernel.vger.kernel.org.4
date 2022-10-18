Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC26602DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiJROEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiJROEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:04:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A58D25B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:04:06 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDNeIG014331;
        Tue, 18 Oct 2022 14:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q7zIZbq8bl/WgD9Febs1/muk7cb1YTij7a3YfpRq9GY=;
 b=cwA/Nj2Y1Em/yc+JUJ0A7htH+xoaFof2WyT4UJsnQN+L8RFFumbyhnSrK4z1IUaYARB5
 RMPsGDsuVn8X8Avt5REDO8S3OIgzF3wTlpTkgGWTd1BH+xg+A4qJJKTXPf3KF8Sj47QC
 ovmqhgCy4GOn/uaZY5po49jqC9mi65QrAmHzRTt57gpcGfTzmunYfWrq+X77LTuLHKmm
 yK4j5joqpiUQdIqRcF40Omr6Ziw+uQNzN9mYvtAMN7oXf0j/I2pVgmAah8iYGJZnYaKY
 qfMSmf7r834d1NFeLwedoymFxP+yn4TXKTqtYxW6fzDGrFFp/65jc9fXLwmlZYLwgI0j NQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9tqn7fxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:04:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IDt8h4021950;
        Tue, 18 Oct 2022 14:03:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg95cxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IE3unp59048414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:03:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB3B2A404D;
        Tue, 18 Oct 2022 14:03:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1183AA4040;
        Tue, 18 Oct 2022 14:03:55 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.89.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Oct 2022 14:03:54 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] selftests/ftrace: Convert tracer tests to use 'requires' to specify program dependency
Date:   Tue, 18 Oct 2022 19:33:41 +0530
Message-Id: <3a4e12586f82561c154092b2ea87b094c3d4740e.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1XEgeyVtkxNDxwm3vdREcnT2QxNajmaz
X-Proofpoint-ORIG-GUID: 1XEgeyVtkxNDxwm3vdREcnT2QxNajmaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=926 malwarescore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a good way to specify dependency of tests on programs,
convert some of the tracer tests to use this method for specifying
dependency on 'chrt'.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc    | 7 +------
 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc | 7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
index 11be10e1bf966a..e8f0fac9a110cc 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup tracer
-# requires: wakeup:tracer
-
-if ! which chrt ; then
-  echo "chrt is not found. This test requires nice command."
-  exit_unresolved
-fi
+# requires: wakeup:tracer chrt:program
 
 echo wakeup > current_tracer
 echo 1 > tracing_on
diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
index 3a77198b3c6902..79807656785b0f 100644
--- a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
+++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
@@ -1,12 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: Test wakeup RT tracer
-# requires: wakeup_rt:tracer
-
-if ! which chrt ; then
-  echo "chrt is not found. This test requires chrt command."
-  exit_unresolved
-fi
+# requires: wakeup_rt:tracer chrt:program
 
 echo wakeup_rt > current_tracer
 echo 1 > tracing_on
-- 
2.38.0

