Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8953567B2A2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjAYMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAYMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:35:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C2B1CF59;
        Wed, 25 Jan 2023 04:35:14 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PBaMN4019043;
        Wed, 25 Jan 2023 12:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LGod0DSUnYmavsx4AKzFufAQIzxD17jONrKB6uaXPnY=;
 b=n8JhDgN/+hEEhl7BtbrMuRPJ5OBZQz2kUnxPwvDPvMh8B9Y5YoEDs+bfbNx6wmcNJQka
 0MwJ3eQSPYUqJd1rStpf1OP5iq3c5Ozbzj4AtDBJ3Lq8Xu3kdVqWrtzKq+QwOEoiy7JP
 +PcP7lqPXF3oXjEcXlQ76to2f5GvciMD9GPSqag63/xmPF3Pd5F+O9s7HrPTjtA00heB
 mmJWFHZ1eldT+c617gfIwIHiLKDvQBL1JQMj1NHe4kgJXyMcu+ip8BbzVVJZvZ94RtiQ
 /5Ad47ZlEamGvagPgfiDIHyIAhCwVPUUZQ1GuK7cDo9vveasD0laaRR6rNc3zm4njx6L ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac20uusn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 12:35:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30P1FJbr010329;
        Wed, 25 Jan 2023 12:35:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6n3rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 12:35:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PCZ3W346727676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 12:35:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8795C20049;
        Wed, 25 Jan 2023 12:35:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5AE20040;
        Wed, 25 Jan 2023 12:35:02 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.44.248])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 12:35:01 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: [PATCH] perf test: Fix dwarf unwind test
Date:   Wed, 25 Jan 2023 18:04:42 +0530
Message-Id: <20230125123442.107156-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GkR9415fmCKHV4UH46j1dizefkCj4KBE
X-Proofpoint-ORIG-GUID: GkR9415fmCKHV4UH46j1dizefkCj4KBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_07,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwarf unwind perf test can sometimes fail:
  $ perf test -v 74
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   74: Test dwarf unwind                                               :
  --- start ---
  test child forked, pid 3785254
  Problems creating module maps, continuing anyway...
  Problems creating module maps, continuing anyway...
  unwind: test__arch_unwind_sample:ip = 0x102d0ad4c (0x36ad4c)
  unwind: access_mem addr 0x7fffc33128c8, val 1031c3228, offset 120
  unwind: access_mem addr 0x7fffc33128d0, val 12427cc70, offset 128
  <snip>
  unwind: test_dwarf_unwind__krava_3:ip = 0x102b8768b (0x1e768b)
  unwind: access_mem addr 0x7fffc3313048, val 7fffc3313050, offset 2040
  unwind: access_mem addr 0x7fffc3313060, val 102b8777c, offset 2064
  unwind: test_dwarf_unwind__krava_2:ip = 0x102b8770b (0x1e770b)
  unwind: access_mem addr 0x7fffc3313088, val 7fffc3313090, offset 2104
  unwind: access_mem addr 0x7fffc33130a0, val 102b87890, offset 2128
  unwind: test_dwarf_unwind__krava_1:ip = 0x102b8777b (0x1e777b)
  unwind: access_mem addr 0x7fffc3313108, val 10323a274, offset 2232
  unwind: access_mem addr 0x7fffc3313110, val ffffffffffffffff, offset 2240
  unwind: access_mem addr 0x7fffc3313118, val 102c08ed0, offset 2248
  unwind: access_mem addr 0x7fffc3313120, val 1031db000, offset 2256
  unwind: access_mem addr 0x7fffc3313128, val 7fffc3313130, offset 2264
  unwind: access_mem addr 0x7fffc3313140, val 102b45ee8, offset 2288
  unwind: '':ip = 0x102b8788f (0x1e788f)
  failed: got unresolved address 0x102b8788f
  unwind: failed with 'no error'
  got wrong number of stack entries 0 != 8
  test child finished with -1
  ---- end ----
  Test dwarf unwind: FAILED!

We expect to resolve test__dwarf_unwind as the last symbol, but that
function can be optimized away:
  $ objdump -tT /usr/bin/perf | grep dwarf_unwind
  000000000083b018 g    DO .data	0000000000000040  Base        tests__dwarf_unwind
  00000000001e7750 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_1
  00000000001e76e0 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_2
  00000000001e7620 g    DF .text	00000000000000b4  Base        0x60 test_dwarf_unwind__krava_3
  00000000001e74f0 g    DF .text	0000000000000128  Base        0x60 test_dwarf_unwind__compare
  00000000001e7350 g    DF .text	000000000000019c  Base        0x60 test_dwarf_unwind__thread
  000000000083b000 g    DO .data	0000000000000018  Base        suite__dwarf_unwind

Fix this similar to commit fdf7c49c200d1b ("perf tests: Fix dwarf unwind
for stripped binaries") by marking the function as a global and adding
the 'noinline' attribute to it.

With this patch:
  $ objdump -tT perf | grep dwarf_unwind
  000000000083b018 g    DO .data	0000000000000040  Base        tests__dwarf_unwind
  00000000001e80f0 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_1
  00000000001e8080 g    DF .text	0000000000000068  Base        0x60 test_dwarf_unwind__krava_2
  00000000001e7fc0 g    DF .text	00000000000000b4  Base        0x60 test_dwarf_unwind__krava_3
  00000000001e7e90 g    DF .text	0000000000000128  Base        0x60 test_dwarf_unwind__compare
  00000000001e7cf0 g    DF .text	000000000000019c  Base        0x60 test_dwarf_unwind__thread
  00000000001e8160 g    DF .text	0000000000000248  Base        0x60 test__dwarf_unwind
  000000000083b000 g    DO .data	0000000000000018  Base        suite__dwarf_unwind
  $ ./perf test 74
   74: Test dwarf unwind                                               : Ok

Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/tests/dwarf-unwind.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index afdca7f2959f07..ee983b677a6ae0 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -67,6 +67,7 @@ int test_dwarf_unwind__compare(void *p1, void *p2);
 int test_dwarf_unwind__krava_3(struct thread *thread);
 int test_dwarf_unwind__krava_2(struct thread *thread);
 int test_dwarf_unwind__krava_1(struct thread *thread);
+int test__dwarf_unwind(struct test_suite *test, int subtest);
 
 #define MAX_STACK 8
 
@@ -195,8 +196,8 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 	return ret;
 }
 
-static int test__dwarf_unwind(struct test_suite *test __maybe_unused,
-			      int subtest __maybe_unused)
+noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
+				int subtest __maybe_unused)
 {
 	struct machine *machine;
 	struct thread *thread;

base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
-- 
2.39.1

