Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40F362A3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiKOVWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiKOVWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:22:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164C1E71F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:22:47 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFKD5Ug008985;
        Tue, 15 Nov 2022 21:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=B1KkfsUcxtQ9by+qW85vYVz3lYK0bd4pQJHwcBNtQ8Q=;
 b=tFm3Wfbwzsevt4tJR+d9QqXOcmAUyS7GyRYzSNbXkp2eTYyq4g878ncviBUMXml4JLmL
 a9gpVhmznWQCazf8O4JF++eQrPIvIQfbRpMxxmckyfPIJGvJTJT2s+/qchGYOghdn0O5
 2Qzf2sdvrdSN9VA11ULZHXHrOtHP2g8x6ZKIbyYRDWPxKgOVXmGpGz2k+ZydvoKgooKN
 Dk0x4UOuQIzdzyOKjfGPKaY8av4sNRCz3QLJRy/Z9wEX/2K5joJvAO/RbsCqVFvrzBjA
 9HuvzWW1iBd3baZDds79NRE5C2lpjLdlrEfxyr+QeJz4G40/uF2u1lw5uHFaSipnm20J WQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3jsjx8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFKvO67031792;
        Tue, 15 Nov 2022 21:22:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xcfvc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 21:22:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFLMSRa002082;
        Tue, 15 Nov 2022 21:22:28 GMT
Received: from dhcp-10-132-95-73.usdhcp.oraclecorp.com.com (dhcp-10-132-95-73.usdhcp.oraclecorp.com [10.132.95.73])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3kt1xcfvb0-1;
        Tue, 15 Nov 2022 21:22:28 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        almasrymina@google.com, linmiaohe@huawei.com, hughd@google.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable 00/10] convert core hugetlb functions to folios
Date:   Tue, 15 Nov 2022 13:22:07 -0800
Message-Id: <20221115212217.19539-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=647 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150146
X-Proofpoint-ORIG-GUID: rZGv0LQCfYEXwxMR5A53zOBXOp7FkL31
X-Proofpoint-GUID: rZGv0LQCfYEXwxMR5A53zOBXOp7FkL31
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

Rebased on 10/15/2022 mm-unstable


[1] https://lore.kernel.org/lkml/20220922154207.1575343-1-sidhartha.kumar@oracle.com/
[2] https://lore.kernel.org/linux-mm/20221101223059.460937-1-sidhartha.kumar@oracle.com/

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
 mm/hugetlb.c       | 379 ++++++++++++++++++++++-----------------------
 2 files changed, 204 insertions(+), 191 deletions(-)

-- 
2.38.1

