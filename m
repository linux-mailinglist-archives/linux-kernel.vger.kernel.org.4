Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEF65ECC32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiI0SgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiI0SgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:36:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89792101960
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:36:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RIPubj019800;
        Tue, 27 Sep 2022 18:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=Zv5+rHipBcgS8FwB2WOhjPJORx2DH06MRLcvr4/hF0E=;
 b=DwVrq7ZebKRhWYU6TaungOD27I7jubkrDn+eCpCG6As4cfElfRLD4itoBNecKqEMq65x
 iIKoNIYbPM0Pn6wEy6RZiqRbgb861hjxwDXjw7+vmOExaMIu29oWW2cfILBvw5Th7zeU
 PsSCK+cDNxQ4gDQ7beQJxROXwQiFdy4X3d5ZlYvIa9BB6oy9At8wEQdslSPa7hfkQbGb
 HceC+2kveoTxYWypk9SmhkPWjvRNIbi6jwtVjFGOO/+myabTuFAQeNNw2SbQZ6iFveAi
 3MWa9jgH1PuyW2gsd/0/N66R3GthKJr+BRayuS2UYpTpEdkTte5A00tB3v+liq0vgyA1 Nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwfpwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 18:33:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RH5Jp8001468;
        Tue, 27 Sep 2022 18:33:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv0skn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 18:33:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28RIXe8E032462;
        Tue, 27 Sep 2022 18:33:40 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jtpv0skmp-1;
        Tue, 27 Sep 2022 18:33:40 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, reinette.chatre@intel.co,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, thomas.tai@oracle.com
Subject: [PATCH] x86/sgx: Add code to inject hwpoison into SGX memory
Date:   Tue, 27 Sep 2022 14:34:11 -0400
Message-Id: <20220927183411.910077-1-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270115
X-Proofpoint-ORIG-GUID: OFIMB3-3QhE5kdQqiQ5rWyj2L9ETlZ9_
X-Proofpoint-GUID: OFIMB3-3QhE5kdQqiQ5rWyj2L9ETlZ9_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by commit c6acb1e7bf46 (x86/sgx: Add hook to error injection
address validation), add a similar code in hwpoison_inject function to
check if the address is located in SGX Memory. The error will then be
handled by the arch_memory_failure function in the SGX driver.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 Documentation/mm/hwpoison.rst | 44 +++++++++++++++++++++++++++++++++++
 mm/hwpoison-inject.c          |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index b9d5253c1305..8a542aca4744 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -162,6 +162,50 @@ Testing
 
   Some portable hwpoison test programs in mce-test, see below.
 
+* Special notes for injection into SGX enclaves
+
+  1) Determine physical address of enclave page
+
+	dmesg | grep "sgx: EPC"
+
+	sgx: EPC section 0x8000c00000-0x807f7fffff
+	sgx: EPC section 0x10000c00000-0x1007fffffff
+
+  2) Convert the EPC address to page frame number.
+
+	For 4K page size, the page frame number for 0x8000c00000 is
+	0x8000c00000 / 0x1000 = 0x8000c00.
+
+  3) Trace memory_failure
+
+	echo nop > /sys/kernel/tracing/current_tracer
+	echo *memory_failure > /sys/kernel/tracing/set_ftrace_filter
+	echo function > /sys/kernel/tracing/current_tracer
+
+  4) Inject a memory error
+
+	modprobe hwpoison-inject
+	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
+
+  5) Check the trace output
+
+	cat /sys/kernel/tracing/trace
+
+	# tracer: function
+	#
+	# entries-in-buffer/entries-written: 2/2   #P:128
+	#
+	#                            _-----=> irqs-off
+	#                           / _----=> need-resched
+	#                          | / _---=> hardirq/softirq
+	#                          || / _--=> preempt-depth
+	#                          ||| / _-=> migrate-disable
+	#                          |||| /     delay
+	#       TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+	#          | |         |   |||||     |         |
+	        bash-12167   [002] .....   113.136808: memory_failure<-simple_attr_write
+	        bash-12167   [002] .....   113.136810: arch_memory_failure<-memory_failure
+
 References
 ==========
 
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 65e242b5a432..8134dc983699 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -21,6 +21,9 @@ static int hwpoison_inject(void *data, u64 val)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		goto inject;
+
 	if (!pfn_valid(pfn))
 		return -ENXIO;
 
-- 
2.31.1

