Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA973299C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbjFPIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245443AbjFPIPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:15:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34106212B;
        Fri, 16 Jun 2023 01:15:00 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G7uQBD004275;
        Fri, 16 Jun 2023 08:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VByZWeWzZ3naFS8fcpvdWgQYsr2M5Fb1oU3dSy5AMDw=;
 b=WWXV8LSXK9AoR78PjQIFNSX3lbn39/4H62YNYmAT8dnXZ3nS/mwdDT0oc0thJNswufK7
 GzXTekU7Zdt0oHoLGhcwy7K0g+qEDwptzkaNSkRcZ0xUiV8DWEpax79k0oKXGxbiAI5P
 UVM4FnWHN9I8I0S0AHcDjwS+4iLM2AKHjlwliQaGlYi2AHL2DdxW6WL+bvGaVAQnwAv0
 C5izWi9eokaBmmFC2YNSGZuLtDLDfDcFH2Wv7t4/tNUQRGM4Y0wyBJPVH3F0pgggIkPO
 ZgByKAChwEVolQ6PY80x+a5y7BKXINFJAlU+rX8vz+Ww3gkkVfI3zvB4SxYrm/flpZgu uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8ksgghkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:14:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35G80RbF018723;
        Fri, 16 Jun 2023 08:14:56 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r8ksgghj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:14:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35G81lY7001479;
        Fri, 16 Jun 2023 08:14:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r4gt5341t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 08:14:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35G8Eopn22217462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 08:14:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F38B20043;
        Fri, 16 Jun 2023 08:14:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E48C92004B;
        Fri, 16 Jun 2023 08:14:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jun 2023 08:14:49 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: fix failing test cases on linux-next for s390
Date:   Fri, 16 Jun 2023 10:14:37 +0200
Message-Id: <20230616081437.1932003-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kaei6I5nu2Pv-FGyHVjV3uP6Xk5OBY2M
X-Proofpoint-GUID: Ls4JWOa7kelEnYyjPu1JrufdfFzxRnW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_04,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-next tree the many test cases fail on s390x when running the
perf test suite, sometime the perf tool dumps core.

Output before:
  6.1: Test event parsing                               : FAILED!
 10.3: Parsing of PMU event table metrics               : FAILED!
 10.4: Parsing of PMU event table metrics with fake PMUs: FAILED!
 17: Setup struct perf_event_attr                       : FAILED!
 24: Number of exit events of a simple workload         : FAILED!
 26: Object code reading                                : FAILED!
 28: Use a dummy software event to keep tracking        : FAILED!
 35: Track with sched_switch                            : FAILED!
 42.3: BPF prologue generation                          : FAILED!
 66: Parse and process metrics                          : FAILED!
 68: Event expansion for cgroups                        : FAILED!
 69.2: Perf time to TSC                                 : FAILED!
 74: build id cache operations                          : FAILED!
 86: Zstd perf.data compression/decompression           : FAILED!
 87: perf record tests                                  : FAILED!
106: Test java symbol                                   : FAILED!

The reason for all these failure is a missing PMU. On s390x
the PMU is named cpum_cf which is not detected as core PMU.
A similar patch was added before, see
commit 9bacbced0e32 ("perf list: Add s390 support for detailed PMU event description")
which got lost during the recent reworks. Add it again.

Output after:
 10.2: PMU event map aliases                            : FAILED!
 42.3: BPF prologue generation                          : FAILED!

Most test cases now work and there is not core dump anymore.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index fe64ad292d36..6142e4710a2f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1419,7 +1419,7 @@ void perf_pmu__del_formats(struct list_head *formats)
 
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
+	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
-- 
2.39.2

