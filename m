Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7265677657
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAWIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAWIdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:33:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A18E1CAFC;
        Mon, 23 Jan 2023 00:32:58 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N7MpYB005165;
        Mon, 23 Jan 2023 08:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vTAjVjUD2Bx8RbzMfrZSM1izm0jUPvkT5n1cgO3yShM=;
 b=adw36Si9MumagBZ/6Ml+Xxz4gUVhUl9dXP9OgkP03pfBl4Zkge3bhIteH6C/H6TDaGR4
 MZablMRy2v5TQdSof12JjOB44+84XgNQFowsig13IYGvoKyNlPGXpddZogZViTGuzR4t
 AV7lfEpOi+MyNMbgah4gj+CYKhtuihduvyGDN9YnVGKkUobg7xOPurlNvl9QarLbVE+3
 U/GLfxrfC0lQTJXXVITWFGfM3mGfVUHZYaF52sKRJIM1huc+S7F4/HwiZ5qtb2i7yPr4
 Xk3nry5pxvBMYONYi1w0IsUZJ/p1/4Cal5gUKeH/LaZZ3qCdNq8Umij9HvM/AcFqno9d jw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9nsyhcdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 08:32:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30N5Uh6d010402;
        Mon, 23 Jan 2023 08:32:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6j12w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 08:32:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30N8WhdG22872482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 08:32:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67F620040;
        Mon, 23 Jan 2023 08:32:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98FAE20043;
        Mon, 23 Jan 2023 08:32:42 +0000 (GMT)
Received: from li-NotSettable.ibm.com (unknown [9.124.31.208])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 08:32:42 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Disha Goel <disgoel@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: [PATCH] perf test: Switch basic bpf filtering test to use syscall tracepoint
Date:   Mon, 23 Jan 2023 14:02:24 +0530
Message-Id: <20230123083224.276404-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dWMEpBmkTrARYmSKd-G7m-vXpKRLgCki
X-Proofpoint-ORIG-GUID: dWMEpBmkTrARYmSKd-G7m-vXpKRLgCki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_05,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF filtering tests can sometime fail. Running the test in verbose mode
shows the following:
  $ sudo perf test 42
  42: BPF filter                                                      :
  42.1: Basic BPF filtering                                           : FAILED!
  42.2: BPF pinning                                                   : Skip
  42.3: BPF prologue generation                                       : Skip
  $ perf --version
  perf version 4.18.0-425.3.1.el8.ppc64le
  $ sudo perf test -v 42
  42: BPF filter                                                      :
  42.1: Basic BPF filtering                                           :
  --- start ---
  test child forked, pid 711060
  ...
  bpf: config 'func=do_epoll_wait' is ok
  Looking at the vmlinux_path (8 entries long)
  Using /usr/lib/debug/lib/modules/4.18.0-425.3.1.el8.ppc64le/vmlinux for symbols
  Open Debuginfo file: /usr/lib/debug/.build-id/81/56f5a07f92ccb62c5600ba0e4aacfb5f3a7534.debug
  Try to find probe point from debuginfo.
  Matched function: do_epoll_wait [4ef8cb0]
  found inline addr: 0xc00000000061dbe4
  Probe point found: __se_compat_sys_epoll_pwait+196
  found inline addr: 0xc00000000061d9f4
  Probe point found: __se_sys_epoll_pwait+196
  found inline addr: 0xc00000000061d824
  Probe point found: __se_sys_epoll_wait+36
  Found 3 probe_trace_events.
  Opening /sys/kernel/tracing//kprobe_events write=1
  ...
  BPF filter result incorrect, expected 56, got 56 samples
  test child finished with -1
  ---- end ----
  BPF filter subtest 1: FAILED!

The statement above about the result being incorrect looks weird, and it
is due to that particular perf build missing commit 3e11300cdfd5f1
("perf test: Fix bpf test sample mismatch reporting"). In reality, due
to commit 4b04e0decd2518 ("perf test: Fix basic bpf filtering test"),
perf expects there to be 56*3 samples.

However, the number of samples we receive is going to be dependent on
where the probes are installed, which is dependent on where
do_epoll_wait gets inlined. On s390x, it looks like probes at all the
inlined locations are hit. But, that is not the case on ppc64le.

Fix this by switching the test to instead use the syscall tracepoint.
This ensures that we will only ever install a single event enabling us
to reliably determine the sample count.

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/tests/bpf-script-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index 7981c69ed1b456..b638cc99d5ae56 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -43,7 +43,7 @@ struct {
 	__type(value, int);
 } flip_table SEC(".maps");
 
-SEC("func=do_epoll_wait")
+SEC("syscalls:sys_enter_epoll_pwait")
 int bpf_func__SyS_epoll_pwait(void *ctx)
 {
 	int ind =0;

base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
-- 
2.39.1

