Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B26659742
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiL3K0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiL3K0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:26:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF57648;
        Fri, 30 Dec 2022 02:26:48 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BU7iLYj040913;
        Fri, 30 Dec 2022 10:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xXY6Uc2QEJ8u+4R1yUcvmo2PgvRykdLOP/G/aMvJNNw=;
 b=JrO0Hv1wdtnVtqW2M7ROQSNTM0mNBuvetE4O8XZ86znntBz2qO/HdZfSN/SKJCWkLkMV
 hJ/2kXOd9TlHI6F5kK83OqXiLo6V1QnWXidZpzgCmQIJQA5ETj6cYHUhMLDh66ypCDS5
 6wlbreyH8FVdcMyPkCaZt2bKotjMUhY3948/Vf6YrqL9m3r+moEKyA7ID8gJRWkf01SG
 A2CsD3hUpFpo7aCfNjmYICNneJ/F8ZHqA9ixe3WW5dF70qLARB4GpNT1QnEHLnvHo3aX
 L2zEHGX7x0np8huhEPvLO7aT719ljxjMwek3Ram/fvLq8fchyszMr6ZeiveEh5MhCwJl cQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3msuv4je8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 10:26:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BU92Fot003534;
        Fri, 30 Dec 2022 10:26:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mnrpfr337-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 10:26:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BUAQYTB47120726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 10:26:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11FDC20075;
        Fri, 30 Dec 2022 10:26:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24F920073;
        Fri, 30 Dec 2022 10:26:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 30 Dec 2022 10:26:33 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf lock: Fix core dump in command perf lock contention
Date:   Fri, 30 Dec 2022 11:26:27 +0100
Message-Id: <20221230102627.2410847-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: owIXJVDiYEEKkCgV86OK-fQdVHMPBeEt
X-Proofpoint-ORIG-GUID: owIXJVDiYEEKkCgV86OK-fQdVHMPBeEt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_07,2022-12-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case perf lock contention dumps core on s390. Run the following
commands:
 # ./perf lock record -- ./perf bench sched messaging
 # Running 'sched/messaging' benchmark:
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 2.799 [sec]
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.073 MB perf.data (100 samples) ]
 #
 # ./perf lock contention
 Segmentation fault (core dumped)
 #

The function call stack is lengthy, here are the top 5 functions:
 # gdb ./perf core.24048
 GNU gdb (GDB) Fedora Linux 12.1-6.fc37
 Copyright (C) 2022 Free Software Foundation, Inc.
 Core was generated by `./perf lock contention'.
 Program terminated with signal SIGSEGV, Segmentation fault.
 #0  0x00000000011dd25c in machine__is_lock_function (machine=0x3029e28,
         addr=1789230) at util/machine.c:3356
         3356 machine->sched.text_end = kmap->unmap_ip(kmap, sym->start);

 (gdb) where
  #0  0x00000000011dd25c in machine__is_lock_function (machine=0x3029e28,\
         addr=1789230) at util/machine.c:3356
  #1  0x000000000109f244 in callchain_id (evsel=0x30313e0,\
         sample=0x3ffea4f77d0) at builtin-lock.c:957
  #2  0x000000000109e094 in get_key_by_aggr_mode (key=0x3ffea4f7290,\
         addr=27758136, evsel=0x30313e0, sample=0x3ffea4f77d0) \
         at builtin-lock.c:586
  #3  0x000000000109f4d0 in report_lock_contention_begin_event \
         (evsel=0x30313e0, sample=0x3ffea4f77d0)
         at builtin-lock.c:1004
  #4  0x00000000010a00ae in evsel__process_contention_begin \
         (evsel=0x30313e0, sample=0x3ffea4f77d0)
         at builtin-lock.c:1254
  #5  0x00000000010a0e14 in process_sample_event (tool=0x3ffea4f8480, \
         event=0x3ff85601ef8, sample=0x3ffea4f77d0,
         evsel=0x30313e0, machine=0x3029e28) at builtin-lock.c:1464
          sample=0x3ffea4f77d0, evsel=0x30313e0, machine=0x3029e28) \
	 at util/session.c:1523
  .....

The issue is in function machine__is_lock_function() in file
./util/machine.c lines 3355:
   /* should not fail from here */
   sym = machine__find_kernel_symbol_by_name(machine, "__sched_text_end",
		                             &kmap);
   machine->sched.text_end = kmap->unmap_ip(kmap, sym->start)

On s390 the symbol __sched_text_end is *NOT* in the symbol list and the
resulting pointer sym is set to NULL. The sym->start is then a NULL pointer
access and generates the core dump.

The reason why __sched_text_end is not in the symbol list on s390 is
simple:
When the symbol list is created at perf start up with function calls
  dso__load
  +--> dso__load_vmlinux_path
       +--> dso__load_vmlinux
            +--> dso__load_sym
	         +--> dso__load_sym_internal (reads kernel symbols)
		 +--> symbols__fixup_end
		 +--> symbols__fixup_duplicate

The issue is in function symbols__fixup_duplicate(). It deletes all
symbols with have the same address. On s390
 # nm -g  ~/linux/vmlinux| fgrep c68390
 0000000000c68390 T __cpuidle_text_start
 0000000000c68390 T __sched_text_end
 #
two symbols have identical addresses and __sched_text_end is considered
duplicate (in ascending sort order) and removed from the symbol list.
Therefore it is missing and an invalid pointer reference occurs.
The code checks for symbol __sched_text_start and when it exists assumes
symbol __sched_text_end is also in the symbol table. However this is
not the case on s390.

Same situation exists for symbol __lock_text_start:
0000000000c68770 T __cpuidle_text_end
0000000000c68770 T __lock_text_start
This symbol is also removed from the symbol table but used in function
machine__is_lock_function().

To fix this and keep duplicate symbols in the symbol table, set
symbol_conf.allow_aliases to true. This prevents the removal of duplicate
symbols in function symbols__fixup_duplicate().

Output After:
 # ./perf lock contention
 contended total wait  max wait  avg wait    type   caller

        48   124.39 ms 123.99 ms   2.59 ms rwsem:W unlink_anon_vmas+0x24a
        47    83.68 ms  83.26 ms   1.78 ms rwsem:W free_pgtables+0x132
         5    41.22 us  10.55 us   8.24 us rwsem:W free_pgtables+0x140
         4    40.12 us  20.55 us  10.03 us rwsem:W copy_process+0x1ac8
 #

Fixes: cc2367eebb0c ("machine: Adopt is_lock_function() from builtin-lock.c")
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/builtin-lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 718b82bfcdff..506c2fe42d52 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1670,6 +1670,7 @@ static int __cmd_report(bool display_info)
 
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
+	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
 	if (!data.is_pipe) {
@@ -1757,6 +1758,7 @@ static int __cmd_contention(int argc, const char **argv)
 
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
+	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
 	if (use_bpf) {
-- 
2.38.1

