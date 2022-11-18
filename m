Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F362FFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiKRWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKRWUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:20:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C079A255
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 14:20:29 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIMBUY4008967;
        Fri, 18 Nov 2022 22:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=QCVjbMI/o39hUEYDf2MdMGRk1loHul9EeN/L0r83sUs=;
 b=wVYLypxjh/k9ZITJnXAG/0jd8aZfEUwmvUzAGxMt/0oAgDn97w+rIIDVEeRhXptVY015
 C8Y/zXKPEXZgwqLhkuKl/mOwtmiT++tSoVB2CaBuuMU7iMHIYxcolBqVR5a69RBYqFcj
 MM0OKRdsQLqQzQsy8c64EQIEVvtzLtT2jMQOBmnlA0nAiuxaAfsOQu2lVgStqxkllQgg
 ShFB74MIetcowt8crq1UX3O51/cfHF04OO1YJPK30Eko+TL5b8Hf75g+DAfwGYy69bpm
 1WhlJWtrbTqeXFHnOOmggOoMIPsq5gjlKyHLLedUY0JH7aPaHCgguzDGfvi7W63bGnzC +g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx9699wac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKFW9Q001400;
        Fri, 18 Nov 2022 22:20:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kc1eu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:20:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AIMK7qN040370;
        Fri, 18 Nov 2022 22:20:07 GMT
Received: from sid-dell.us.oracle.com (dhcp-10-159-141-24.vpn.oracle.com [10.159.141.24])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3kc1esc-1;
        Fri, 18 Nov 2022 22:20:06 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v4 00/10] convert core hugetlb functions to folios
Date:   Fri, 18 Nov 2022 14:19:52 -0800
Message-Id: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=895 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180133
X-Proofpoint-GUID: q0S9KASSnxfYQaluovfyehcycJFw_Vwh
X-Proofpoint-ORIG-GUID: q0S9KASSnxfYQaluovfyehcycJFw_Vwh
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
v2 -> v3:
	- v2 contained wrong version of patch 1
v3 -> v4:
  - change instances of folio_{clear, set}_head() to __folio_{clear, set}_head()
  - rebase on top of hugetlb: Fix __prep_compound_gigantic_page page flag setting

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
 mm/hugetlb.c       | 385 ++++++++++++++++++++++-----------------------
 2 files changed, 207 insertions(+), 194 deletions(-)

-- 
2.38.1

