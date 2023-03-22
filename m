Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9716C46EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCVJs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCVJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBE49755;
        Wed, 22 Mar 2023 02:48:02 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M9OrKs025525;
        Wed, 22 Mar 2023 09:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7Ack44PB3zTTbzytb5hEniJhenc7E3k7ShJ83XU9AFs=;
 b=cAGnV2rdW112EV2xjo0TNQO5aE3AMq39Ipo+MmBNhazIJcOZJsuvmzzgMTcNSDkkZqR4
 pJAa8d4Dz+7B6ks3UpOLFXvblBqzW408iBVlnMKBR2c3jj5+9TDJ7fgJtc5JafsvV/tC
 q02On1zEeprVQg+c4kDg1sARkFSloTtxHxWsmbDWOT40uVJvs7bknpgIkJTcr5GurmP5
 Ib6R0iHUDavluucIRI5bH6ODDf5UulGmvRAR5EPRwbKSFaf0S2iXPV7N9qtZZGoQ/Svb
 su8DhHtMtA+rM/+KjeSU/KWAZbtoIQU5TpiUbCAVoZKaOnxqWeZlknDPTYTo6ltDC0qI tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfy0y8ed6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:47:43 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32M9OmRU025302;
        Wed, 22 Mar 2023 09:47:42 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfy0y8ec7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:47:42 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32M2erQr001485;
        Wed, 22 Mar 2023 09:47:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6cs38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 09:47:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32M9la6p43188512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 09:47:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7F5C2004E;
        Wed, 22 Mar 2023 09:47:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 629DA2004B;
        Wed, 22 Mar 2023 09:47:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 09:47:36 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, acme@redhat.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [Ping PATCH] perf/test: Fix wrong size for perf test Setup struct perf_event_attr
Date:   Wed, 22 Mar 2023 10:47:31 +0100
Message-Id: <20230322094731.1768281-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oBv38gsgOCrgTPqOKrgCyAVsoBVza19j
X-Proofpoint-ORIG-GUID: j1v-wpUGbGS7pVQuZlsQLFK087frg8wi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_06,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220070
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case ./perf test 'Setup struct perf_event_attr' fails.
On s390 this output is observed:

 # ./perf test -Fvvvv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 running './tests/attr/test-stat-C0'
 Using CPUID IBM,8561,703,T01,3.6,002f
 .....
 Event event:base-stat
      fd = 1
      group_fd = -1
      flags = 0|8
      cpu = *
      type = 0
      size = 128     <<<--- wrong, specified in file base-stat
      config = 0
      sample_period = 0
      sample_type = 65536
      ...
 'PERF_TEST_ATTR=/tmp/tmpgw574wvg ./perf stat -o \
	/tmp/tmpgw574wvg/perf.data -e cycles -C 0 kill >/dev/null \
	2>&1 ret '1', expected '1'
  loading result events
    Event event-0-0-4
      fd = 4
      group_fd = -1
      cpu = 0
      pid = -1
      flags = 8
      type = 0
      size = 136     <<<--- actual size used in system call
      .....
  compare
    matching [event-0-0-4]
      to [event:base-stat]
      [cpu] 0 *
      [flags] 8 0|8
      [type] 0 0
      [size] 136 128
    ->FAIL
    match: [event-0-0-4] matches []
  expected size=136, got 128
  FAILED './tests/attr/test-stat-C0' - match failure

This mismatch is caused by
commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
which enlarges the structure perf_event_attr by 8 bytes.

Fix this by adjusting the expected value of size.

Output after:
 # ./perf test -Fvvvv 17
 17: Setup struct perf_event_attr                                    :
 --- start ---
 running './tests/attr/test-stat-C0'
 Using CPUID IBM,8561,703,T01,3.6,002f
 ...
  matched
  compare
    matching [event-0-0-4]
      to [event:base-stat]
      [cpu] 0 *
      [flags] 8 0|8
      [type] 0 0
      [size] 136 136
      ....
   ->OK
   match: [event-0-0-4] matches ['event:base-stat']
 matched

Fixes: 09519ec3b19e ("perf: Add perf_event_attr::config3")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/attr/base-record       | 2 +-
 tools/perf/tests/attr/base-stat         | 2 +-
 tools/perf/tests/attr/system-wide-dummy | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 3ef07a12aa14..27c21271a16c 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=128
+size=136
 config=0
 sample_period=*
 sample_type=263
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index 408164456530..a21fb65bc012 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=128
+size=136
 config=0
 sample_period=0
 sample_type=65536
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 8fec06eda5f9..2f3e3eb728eb 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=128
+size=136
 config=9
 sample_period=4000
 sample_type=455
-- 
2.39.1

