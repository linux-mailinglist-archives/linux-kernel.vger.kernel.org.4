Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA162E649
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiKQVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbiKQVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:03:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8D022BEA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:03:43 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKY74p016799;
        Thu, 17 Nov 2022 21:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=MiU74nK64gYccmwmRIXU9lqMFSAbnA0iBagipReue0M=;
 b=K8oAexBz8+qS8Rw+6jSrRgUhagYjsGLjYRZOjZixa7tQIWfN+RQ1nEAMxDLqizt3TBWF
 PB3lRDOpV5w2YOPAQEA3cJ0mg9xu69lF+MbN3STTWRjD91Sxwnummet/2jcS9I1KIMTE
 zkTONLo8+ghtuZtDZ6C718wH53s683CAY+IsQnFPnUVDIWW7ZLfdCy2GRGGvvvQfcdIr
 I4tXaLyyQsXDQNxGT+yyR/rBPxDAi7ZZuONFXJ2szChxY/uUYT774BMxkiq0PrbsjwD4
 xL1y1Y1ypRtRo5cwTnEYAYdv/ffDReYKL17EkupMLm4eg82vmurNvfr77EzR+ADbrw74 5A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8yktgkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHKeRoc010857;
        Thu, 17 Nov 2022 21:03:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kagy1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 21:03:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHL37Fb032582;
        Thu, 17 Nov 2022 21:03:07 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kagy08-1;
        Thu, 17 Nov 2022 21:03:07 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v2 00/10] convert core hugetlb functions to folios
Date:   Thu, 17 Nov 2022 13:02:48 -0800
Message-Id: <20221117210258.12732-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=886 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170150
X-Proofpoint-GUID: Dxcto2aWTr9yjCwghAGnTNJdrNxzVGS5
X-Proofpoint-ORIG-GUID: Dxcto2aWTr9yjCwghAGnTNJdrNxzVGS5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
Now that many hugetlb helper functions that deal with hugetlb specific
flags[1] and hugetlb cgroups[2] are converted to folios, higher level
allocation, prep, and freeing functions within hugetlb can also be
converted to operate in folios.

Patch 1 of this series implements the wrapper functions around setting
the compound destructor and compound order for a folio. Besides the user
added in patch 1, patch 2 and patch 9 also use these helper functions.

Patches 2-10 convert the higher level hugetlb functions to folios.

============== TESTING ===========================
LTP:
	Ran 10 back to back rounds of the LTP hugetlb test suite.

Gigantic Huge Pages:
	Test allocation and freeing via hugeadm commands:
		hugeadm --pool-pages-min 1GB:10
		hugeadm --pool-pages-min 1GB:0

Demote:
	Demote 1 1GB hugepages to 512 2MB hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
		echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
		cat /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
			# 512
		cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
			# 0

Rebased on 10/17/2022 mm-unstable

[1] https://lore.kernel.org/lkml/20220922154207.1575343-1-sidhartha.kumar@oracle.com/
[2] https://lore.kernel.org/linux-mm/20221101223059.460937-1-sidhartha.kumar@oracle.com/

v1 -> v2:
	- fix conflict with "mm,thp,rmap: simplify compound page mapcount handling"

Sidhartha Kumar (10):
  mm: add folio dtor and order setter functions
  mm/hugetlb: convert destroy_compound_gigantic_page() to folios
  mm/hugetlb: convert dissolve_free_huge_page() to folios
  mm/hugetlb: convert remove_hugetlb_page() to folios
  mm/hugetlb: convert update_and_free_page() to folios
  mm/hugetlb: convert add_hugetlb_page() to folios and add
    hugetlb_cma_folio()
  mm/hugetlb: convert enqueue_huge_page() to folios
  mm/hugetlb: convert free_gigantic_page() to folios
  mm/hugetlb: convert hugetlb prep functions to folios
  mm/hugetlb: change hugetlb allocation functions to return a folio

 include/linux/mm.h |  16 ++
 mm/hugetlb.c       | 383 ++++++++++++++++++++++-----------------------
 2 files changed, 206 insertions(+), 193 deletions(-)

-- 
2.38.1

