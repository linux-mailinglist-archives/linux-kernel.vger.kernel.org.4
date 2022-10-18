Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE4602DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJROEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJROEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:04:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7A5D03AE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:04:16 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IDPdWG008480;
        Tue, 18 Oct 2022 14:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3xCvfhPsbclwHDbgf/plPrMlOtES/xpwnsdnKcR/Mk4=;
 b=JelZKKzccfFrGZhyQs4gqworl4RwG22LmeTJgYVqprOMyREKZayGnO/UpB0LMCAS/9iH
 tQiomY+Bk/CjrzwGAxLljfGNIztTj8JHh0aCnLAKgbKyBbwa8Q9sc7Qj+i5vKY//QPs+
 Gt14wlChTUj6CDa7FQb2ztBDl3np+B9L9BbDVkrVwlQNm0Tsu1j7TWGJKpExoFbhpCtz
 JsDbRqkSWU1q+FfifrHOVM6sDCwSNwPyj7sX5FmYdKm8LXsuY3fqUZBUaY9e21PiMz6p
 4xjiSwCkO47I+fE1+hkZhTAzHLBeQTzs3MhOlB+fxeTBhR/xBPw8J6Bn85me9cfUdQ/E 4A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k9w139tmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:04:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29IDtLNJ022006;
        Tue, 18 Oct 2022 14:03:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3k7mg95cxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:03:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29IE4R7W52363684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 14:04:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A510DA4040;
        Tue, 18 Oct 2022 14:03:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDBD8A4051;
        Tue, 18 Oct 2022 14:03:52 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.89.190])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Oct 2022 14:03:52 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] selftests/ftrace: Add check for ping command for trigger tests
Date:   Tue, 18 Oct 2022 19:33:40 +0530
Message-Id: <4ec67d1b5c5d4e693a4826a89c9fd4eca5343eb6.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wm_vRCtpsSz00DlHjBVUolwA4WYFcDXa
X-Proofpoint-ORIG-GUID: Wm_vRCtpsSz00DlHjBVUolwA4WYFcDXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_04,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these tests depend on the ping command and will fail if it is not
found. Allow tests to specify dependencies on programs through the
'requires' field. Add dependency on 'ping' for some of the trigger
tests.

Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/functions           | 8 +++++++-
 .../trigger/inter-event/trigger-field-variable-support.tc | 2 +-
 .../inter-event/trigger-inter-event-combined-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onchange-action-hist.tc   | 2 +-
 .../trigger/inter-event/trigger-onmatch-action-hist.tc    | 2 +-
 .../inter-event/trigger-onmatch-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-onmax-action-hist.tc      | 2 +-
 .../trigger/inter-event/trigger-snapshot-action-hist.tc   | 2 +-
 .../inter-event/trigger-synthetic-event-dynstring.tc      | 2 +-
 .../trigger/inter-event/trigger-trace-action-hist.tc      | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5f6cbec847fc99..779f3e62ec9005 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -142,9 +142,15 @@ finish_ftrace() {
 
 check_requires() { # Check required files and tracers
     for i in "$@" ; do
+	p=${i%:program}
         r=${i%:README}
         t=${i%:tracer}
-        if [ $t != $i ]; then
+	if [ $p != $i ]; then
+	    if ! which $p ; then
+                echo "Required program $p is not found."
+                exit_unresolved
+	    fi
+        elif [ $t != $i ]; then
             if ! grep -wq $t available_tracers ; then
                 echo "Required tracer $t is not configured."
                 exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 41119e0440e960..04c5dd7d0acc4b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test field variable support
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 9098f1e7433fd0..f7447d800899ac 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index adaabb873ed4ab..91339c1308324b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onchange action
-# requires: set_event "onchange(var)":README
+# requires: set_event "onchange(var)":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 20e39471052e9a..d645abcf11c4f7 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index f4b03ab7c28714..c369247efb3501 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmatch-onmax action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 71c9b5911c7067..e28dc5f11b2be0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger onmax action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 67fa328b830f5f..147967e86584ac 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger snapshot action
-# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README
+# requires: set_event snapshot events/sched/sched_process_fork/hist "onchange(var)":README "snapshot()":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 3d65c856eca3e6..213d890ed1886e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README ping:program
 
 fail() { #msg
     echo $1
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c126d2350a6d41..d7312047ce2818 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist "trace(<synthetic_event>":README ping:program
 
 fail() { #msg
     echo $1
-- 
2.38.0

