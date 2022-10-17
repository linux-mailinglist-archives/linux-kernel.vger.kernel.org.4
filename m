Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF26600C30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJQKUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJQKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:19:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82BCD7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:19:52 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H9ewKl003038;
        Mon, 17 Oct 2022 10:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dmZBp72BObwzux6XUcIUXsQzYtGpYSVgqAA7PqIgxqQ=;
 b=WSYA/P4QSTK1BCHWP00Nmo48pFmt2u2/M4hEmgEIThiJnMwHceiZwr2KgiCAjne56FlY
 VZAThC1lViSt9SFwBJyqyZ991rq6wbpErnVx0OKPTTsIPysrmvtDFtJ78/6/xcRAeUB7
 ZnOUe6GUAt0US8DNXYdTxwoH3LVKmapIR6Aio15HbsmLFpmQL70HkIudu0b4m0Qd6XRZ
 HBSb9e71iU+/BiUNgAbbDUPJkviq/wKdBU7+89QwCb3mZdcbkX5BelmtsXOA3odAjvDY
 gLjgqCpcAl90+4FEq7g7gFXT6MMxQySRYGoRAyc55a94wygBIH9ndSLzQrQQY/nk7oVy IQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5vedg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 10:19:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29HA74ux001742;
        Mon, 17 Oct 2022 10:19:45 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3k7mg92sd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 10:19:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29HAJgJx328204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 10:19:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA7BB11C050;
        Mon, 17 Oct 2022 10:19:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9134211C052;
        Mon, 17 Oct 2022 10:19:40 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.71.171])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Oct 2022 10:19:40 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: [PATCH] selftests/ftrace: Add check for ping command for trigger tests
Date:   Mon, 17 Oct 2022 15:49:27 +0530
Message-Id: <20221017101927.303547-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: joe2s1_CkxAWn2U3P9EmzolNb7XBVr_H
X-Proofpoint-ORIG-GUID: joe2s1_CkxAWn2U3P9EmzolNb7XBVr_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_07,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these tests depend on the ping command and will fail if it is not
installed. Add an explicit check and mark the tests as unresolved if it
isn't found.

Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 .../trigger/inter-event/trigger-field-variable-support.tc    | 5 +++++
 .../trigger/inter-event/trigger-inter-event-combined-hist.tc | 5 +++++
 .../trigger/inter-event/trigger-onchange-action-hist.tc      | 5 +++++
 .../trigger/inter-event/trigger-onmatch-action-hist.tc       | 5 +++++
 .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc | 5 +++++
 .../test.d/trigger/inter-event/trigger-onmax-action-hist.tc  | 5 +++++
 .../trigger/inter-event/trigger-snapshot-action-hist.tc      | 5 +++++
 .../trigger/inter-event/trigger-synthetic-event-dynstring.tc | 5 +++++
 .../test.d/trigger/inter-event/trigger-trace-action-hist.tc  | 5 +++++
 9 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 41119e0440e960..b0969e6eed8375 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test field variable support"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
 echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
 echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 9098f1e7433fd0..82875eab17f09f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
 if [ ! -d events/synthetic/waking_latency ]; then
     fail "Failed to create waking_latency synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
index adaabb873ed4ab..84b3fb08cc1519 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onchange-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test onchange action"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio) if comm=="ping"' >> events/sched/sched_waking/trigger
 
 ping $LOCALHOST -c 3
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 20e39471052e9a..25866576b0bbe4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index f4b03ab7c28714..3c4a4b11aa2421 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 71c9b5911c7067..908bb99cdc4ece 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index 67fa328b830f5f..ee06706ae51a2c 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test snapshot action"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 1 > events/sched/enable
 
 echo 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onchange($newprio).snapshot() if comm=="ping"' >> events/sched/sched_waking/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
index 3d65c856eca3e6..dc0fffbe3c1dd8 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'ping_test_latency u64 lat; char filename[]' > synthetic_events
 if [ ! -d events/synthetic/ping_test_latency ]; then
     fail "Failed to create ping_test_latency synthetic event"
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c126d2350a6d41..1a9f10826b9421 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -10,6 +10,11 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
+if ! which ping; then
+    echo "ping is not found. This test requires ping command."
+    exit_unresolved
+fi
+
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"

base-commit: 6c0f39e87b6ab1a3009e3a49d3e6f6db8dc756a8
-- 
2.38.0

