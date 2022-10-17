Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB8601C76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQWc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiJQWc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:32:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC79B193C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:32:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HLmiLi014364;
        Mon, 17 Oct 2022 22:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=omFflEA4Zqf8SXB/HW7nlsOaWW3mD9EGR8pICNAZB0g=;
 b=klwvTzgVvTo6OmMOYD7Nk+zhy0O8v4k8iQ07W6LPVaQ0wovIRZtw851i2fOlIzGAKfqE
 w67B3db52+WsNGnq3ETTyW5Bl2K/gieXW1qNIqr0DeanOKmFFLg72Zd2hQ7fHTl9lPnI
 SwsqLYnIn99aDrSDePG6qvBGh5vzn1FG0MKe0+ul+IF166tZwBFa/wJkStY4ux98/F0M
 s+whPLGRXDGNE6ksEmp4Omeb/cBbrj0coGIRk/yWpNyzEMRpJ8RT7aiU1Qi5K1TWBRd6
 NMtZbHLEt8JyFbO7vWjtM/D4HeN7n9iitqztucT+Fo3FUjVjniBC7vxEc2zL4yD1gWu8 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtdby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:32:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJmnnh015967;
        Mon, 17 Oct 2022 22:32:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr9hvqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 22:32:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29HMWcTv026010;
        Mon, 17 Oct 2022 22:32:38 GMT
Received: from brm-x62-20.us.oracle.com (brm-x62-20.us.oracle.com [10.80.150.35])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3k8hr9hvqj-2;
        Mon, 17 Oct 2022 22:32:38 +0000
From:   Thomas Tai <thomas.tai@oracle.com>
To:     tony.luck@intel.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, reinette.chatre@intel.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        thomas.tai@oracle.com
Subject: [PATCH V3 1/1] x86/sgx: Add code to inject hwpoison into SGX memory
Date:   Mon, 17 Oct 2022 18:33:05 -0400
Message-Id: <20221017223305.578073-2-thomas.tai@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017223305.578073-1-thomas.tai@oracle.com>
References: <20221017223305.578073-1-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170128
X-Proofpoint-ORIG-GUID: NRcC0v9zG0OfQpOJWVnmfGiVAxvmZmRW
X-Proofpoint-GUID: NRcC0v9zG0OfQpOJWVnmfGiVAxvmZmRW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by commit c6acb1e7bf46 ("x86/sgx: Add hook to error injection
address validation"), add a similar code in hwpoison_inject function to
check if the address is located in SGX Memory. The error will then be
handled by the arch_memory_failure function in the SGX driver. After
injection, the action_result() will print out the page type and the
action taken.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 Documentation/mm/hwpoison.rst | 24 ++++++++++++++++++++++++
 include/linux/mm.h            |  1 +
 include/ras/ras_event.h       |  1 +
 mm/hwpoison-inject.c          |  4 ++++
 mm/memory-failure.c           |  5 ++++-
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
index b9d5253c1305..100894bb020c 100644
--- a/Documentation/mm/hwpoison.rst
+++ b/Documentation/mm/hwpoison.rst
@@ -162,6 +162,30 @@ Testing
 
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
+  3) Inject a memory error
+
+	modprobe hwpoison-inject
+	echo "0x8000c00" > /sys/kernel/debug/hwpoison/corrupt-pfn
+
+  4) Check dmesg output
+
+        dmesg | grep "Memory failure"
+        Memory failure: 0x8000c00: recovery action for sgx page: Recovered
+
 References
 ==========
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..cdca3ff1418c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3248,6 +3248,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
+	MF_MSG_SGX,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..ee3a925c1e9d 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -373,6 +373,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_SGX, "sgx page" )					\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 65e242b5a432..141eeeb793b1 100644
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
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14439806b5ef..40a22b23b50a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -781,6 +781,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_SGX]			= "sgx page",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1990,8 +1991,10 @@ int memory_failure(unsigned long pfn, int flags)
 	p = pfn_to_online_page(pfn);
 	if (!p) {
 		res = arch_memory_failure(pfn, flags);
-		if (res == 0)
+		if (res == 0) {
+			action_result(pfn, MF_MSG_SGX, MF_RECOVERED);
 			goto unlock_mutex;
+		}
 
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
-- 
2.31.1

