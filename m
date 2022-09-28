Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14E5EE0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiI1Pkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiI1Pkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:40:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BF78216
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:40:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SE4gbk020450;
        Wed, 28 Sep 2022 15:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=4gDtf1VTCSEbPZjaJfwdpJTT2vkmaPA/gXXZw6DdLQA=;
 b=S11zi76H9d6DoGjxQe69b7HIX8etHVwPQWajbkw1tcm1syco8VRFP9QjsdNB23wg1BV6
 ec1tsOqr3GZ3aZ0WqTSzEFHnv/lVAt076zWlsnU4m+2oERm2x0ye5xdwN8sMrd7t9tk0
 q2RB6ttrqye7jcrQcSDLvsBzXbt7sYzb9YPfvEP0wmaCCak0pvL7EfEGs2/ys8oxvclQ
 IZp5YV24wRfKbVp7wpNhQX9EzEYYHVS+gOfNGrnQgRvnwA8LoF99VJZU27Z6RUDxtNbP
 siPvIECGy2P2AMFIhBKoMjKSmPFBt9IFm41yDK8humndcRmkjphsGJSNKEgDqAHAKk5B BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssrwj94u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 15:38:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28SDbA8x002239;
        Wed, 28 Sep 2022 15:38:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps6e58b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 15:38:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28SFc1nt022830;
        Wed, 28 Sep 2022 15:38:02 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3jtps6e576-2;
        Wed, 28 Sep 2022 15:38:02 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, reinette.chatre@intel.co,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, thomas.tai@oracle.com
Subject: [PATCH V2 1/1] x86/sgx: Add code to inject hwpoison into SGX memory
Date:   Wed, 28 Sep 2022 11:38:32 -0400
Message-Id: <20220928153832.1032566-2-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220928153832.1032566-1-thomas.tai@oracle.com>
References: <20220928153832.1032566-1-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280092
X-Proofpoint-ORIG-GUID: 8o_tb834flok7Fk44DWrDJfgK_AKrSYz
X-Proofpoint-GUID: 8o_tb834flok7Fk44DWrDJfgK_AKrSYz
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
 mm/hwpoison-inject.c          |  4 ++++
 2 files changed, 48 insertions(+)

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
index 65e242b5a432..bf83111c1d9b 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -21,6 +21,10 @@ static int hwpoison_inject(void *data, u64 val)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Inject the error if the page is part of the processor reserved memory */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		goto inject;
+
 	if (!pfn_valid(pfn))
 		return -ENXIO;
 
-- 
2.31.1

