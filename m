Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F418F600CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJQKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJQKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:55:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC145C374
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:55:39 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H9xU3G015691;
        Mon, 17 Oct 2022 10:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tsqIIjV1OmHHpwIFajuWshLPaUIZLjoNIetQuBpgifw=;
 b=Pe8rxRP6PsAJtiBi62M1aDDXSDajc3um+IsNIdDcyDMBm9OQTvbm5jX/fXURBf3h3nDj
 PgJAVWc9G2RRxDfViVjN39/WfFjil+40n5qn56b81oyJ0M53Y7njjP9r9jiEisUobMTY
 /Al4UfeqeIAIATF74sVl2T/xTE+yeWEux6SlzmczoMf0xKrjUXZPFJx9p6LWtoTo7797
 u8YNJODSUjJ46XZy9hFMKympAi1e03EI0bOKXBn6bM81f/G+F0ro2O1+z/Qw3xckL5lO
 z4hxoZmuvFK40pO2EgXKVVpjP/Tcbggj+h2kTcpBd/biJLl/yh8gRnf8kxCQ8fmdAtIC eQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86ntn8qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 10:55:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29HArUFG013566;
        Mon, 17 Oct 2022 10:55:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3k7m4ja6f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 10:55:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29HAtUPX5898986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 10:55:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73EEC11C04C;
        Mon, 17 Oct 2022 10:55:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8E5311C04A;
        Mon, 17 Oct 2022 10:55:28 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.71.171])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Oct 2022 10:55:28 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH] selftests/ftrace: Limit number of lines processed in 'trace'
Date:   Mon, 17 Oct 2022 16:25:02 +0530
Message-Id: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6NBNg0sxzDXA3VLh_MgyaEh66dayaHvZ
X-Proofpoint-GUID: 6NBNg0sxzDXA3VLh_MgyaEh66dayaHvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_08,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On very large machines, ftracetest can seem to hang or otherwise take a
very long time to complete individual tests. This can be attributed to
statements that try to process the entire contents of 'trace'.

Limit the number of lines processed from 'trace' to resolve this. Apart
from the change in test.d/functions to add TRACENL, this commit is the
result of running the below command (and fixing some whitespace errors):
  grep -l -R 'cat trace |' -- ./tools/testing/selftests/ftrace/test.d/ | \
	xargs -n 1 sed --in-place -e "s/cat trace |/head -\$\{TRACENL\} trace |/g"

Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../testing/selftests/ftrace/test.d/event/event-enable.tc | 6 +++---
 .../testing/selftests/ftrace/test.d/event/event-no-pid.tc | 4 ++--
 tools/testing/selftests/ftrace/test.d/event/event-pid.tc  | 6 +++---
 .../selftests/ftrace/test.d/event/subsystem-enable.tc     | 6 +++---
 .../selftests/ftrace/test.d/event/toplevel-enable.tc      | 2 +-
 .../selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc | 8 ++++----
 .../selftests/ftrace/test.d/ftrace/fgraph-filter.tc       | 4 ++--
 .../ftrace/test.d/ftrace/func-filter-notrace-pid.tc       | 8 ++++----
 .../selftests/ftrace/test.d/ftrace/func-filter-pid.tc     | 8 ++++----
 tools/testing/selftests/ftrace/test.d/functions           | 3 +++
 .../selftests/ftrace/test.d/kprobe/kretprobe_args.tc      | 2 +-
 11 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
index cfe5bd2d426794..0a2d236cd94822 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:sched_switch' > set_event
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | wc -l`
 if [ $count -ne 0 ]; then
     fail "sched_switch events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
index 9933ed24f90124..711301a36b69b6 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-no-pid.tc
@@ -23,12 +23,12 @@ fail() { #msg
 
 count_pid() {
     pid=$@
-    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep $pid | wc -l
+    head -${TRACENL} trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep $pid | wc -l
 }
 
 count_no_pid() {
     pid=$1
-    cat trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep -v $pid | wc -l
+    head -${TRACENL} trace | grep -v '^#' | sed -e 's/[^-]*-\([0-9]*\).*/\1/' | grep -v $pid | wc -l
 }
 
 enable_system() {
diff --git a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
index 7f5f97dffdc3dd..8ecdc211ac0432 100644
--- a/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/event-pid.tc
@@ -23,7 +23,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events are not recorded"
 fi
@@ -38,7 +38,7 @@ echo 'sched:sched_switch' > set_event
 
 yield
 
-count=`cat trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
 if [ $count -ne 0 ]; then
     fail "sched_switch events from other task are recorded"
 fi
@@ -51,7 +51,7 @@ echo 1 > events/sched/sched_switch/enable
 
 yield
 
-count=`cat trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
+count=`head -${TRACENL} trace | grep sched_switch | grep -v "pid=$mypid" | wc -l`
 if [ $count -eq 0 ]; then
     fail "sched_switch events from other task are not recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
index b1ede624986676..d5a1faff71773c 100644
--- a/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc
@@ -18,7 +18,7 @@ echo 'sched:*' > set_event
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -${TRACENL} trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -29,7 +29,7 @@ echo 1 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -${TRACENL} trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -lt 3 ]; then
     fail "at least fork, exec and exit events should be recorded"
 fi
@@ -40,7 +40,7 @@ echo 0 > events/sched/enable
 
 yield
 
-count=`cat trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
+count=`head -${TRACENL} trace | grep -v ^# | awk '{ print $5 }' | sort -u | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of scheduler events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
index 93c10ea42a6868..1b7d4700a21b1e 100644
--- a/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc
@@ -43,7 +43,7 @@ echo 0 > events/enable
 
 yield
 
-count=`cat trace | grep -v ^# | wc -l`
+count=`head -${TRACENL} trace | grep -v ^# | wc -l`
 if [ $count -ne 0 ]; then
     fail "any of events should not be recorded"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
index cf3ea42b12b09f..2861aaaec3908b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter-stack.tc
@@ -40,14 +40,14 @@ clear_trace
 enable_tracing
 sleep 1
 
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`head -${TRACENL} trace | grep '()' | grep -v schedule | wc -l`
 
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working with stack tracer?"
 fi
 
 # Make sure we did find something
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`head -${TRACENL} trace | grep 'schedule()' | wc -l`
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
@@ -57,13 +57,13 @@ clear_trace
 sleep 1
 
 
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`head -${TRACENL} trace | grep '()' | grep -v schedule | wc -l`
 
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working after stack tracer disabled?"
 fi
 
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`head -${TRACENL} trace | grep 'schedule()' | wc -l`
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
index b3ccdaec2a61ba..679eed983ef931 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/fgraph-filter.tc
@@ -26,13 +26,13 @@ enable_tracing
 sleep 1
 # search for functions (has "()" on the line), and make sure
 # that only the schedule function was found
-count=`cat trace | grep '()' | grep -v schedule | wc -l`
+count=`head -${TRACENL} trace | grep '()' | grep -v schedule | wc -l`
 if [ $count -ne 0 ]; then
     fail "Graph filtering not working by itself?"
 fi
 
 # Make sure we did find something
-count=`cat trace | grep 'schedule()' | wc -l` 
+count=`head -${TRACENL} trace | grep 'schedule()' | wc -l`
 if [ $count -eq 0 ]; then
     fail "No schedule traces found?"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
index 80541964b9270b..088ec11d87fa46 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
@@ -52,8 +52,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`head -${TRACENL} trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`head -${TRACENL} trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_pid should be 0
     if [ $count_pid -ne 0 -o $count_other -eq 0 ]; then
@@ -78,8 +78,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`head -${TRACENL} trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`head -${TRACENL} trace | grep -v ^# | grep -v $PID | wc -l`
 
     # both should be zero
     if [ $count_pid -ne 0 -o $count_other -ne 0 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
index 2f7211254529ba..fed002ed262b1d 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
@@ -52,8 +52,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`head -${TRACENL} trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`head -${TRACENL} trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_other should be 0
     if [ $count_pid -eq 0 -o $count_other -ne 0 ]; then
@@ -73,8 +73,8 @@ do_test() {
     enable_tracing
     yield
 
-    count_pid=`cat trace | grep -v ^# | grep $PID | wc -l`
-    count_other=`cat trace | grep -v ^# | grep -v $PID | wc -l`
+    count_pid=`head -${TRACENL} trace | grep -v ^# | grep $PID | wc -l`
+    count_other=`head -${TRACENL} trace | grep -v ^# | grep -v $PID | wc -l`
 
     # count_other should NOT be 0
     if [ $count_pid -eq 0 -o $count_other -eq 0 ]; then
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5f6cbec847fc99..6a9a794bde11f7 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -174,6 +174,9 @@ yield() {
 FUNCTION_FORK=`(if grep '\bkernel_clone\b' /proc/kallsyms > /dev/null; then
                 echo kernel_clone; else echo '_do_fork'; fi)`
 
+# TRACENL controls the number of lines processed from the 'trace' file
+TRACENL=3000
+
 # Since probe event command may include backslash, explicitly use printf "%s"
 # to NOT interpret it.
 ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
index 197cc2afd4046b..804d6a6e3a99dd 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_args.tc
@@ -11,7 +11,7 @@ test -d events/kprobes/testprobe2
 echo 1 > events/kprobes/testprobe2/enable
 ( echo "forked")
 
-cat trace | grep testprobe2 | grep -q "<- $FUNCTION_FORK"
+head -${TRACENL} trace | grep testprobe2 | grep -q "<- $FUNCTION_FORK"
 
 echo 0 > events/kprobes/testprobe2/enable
 echo '-:testprobe2' >> kprobe_events

base-commit: 6c0f39e87b6ab1a3009e3a49d3e6f6db8dc756a8
-- 
2.38.0

