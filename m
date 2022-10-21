Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5864B6074D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiJUKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJUKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:16:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF56143A6C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:16:28 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5vLe6017387;
        Fri, 21 Oct 2022 10:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YBTN4+Jta8X8dJonAY3dttbWKhQZ92ZH82Q1zjZEpks=;
 b=G427AN2XjxnD7O5FHHKozQjhGI/bi9JNncwwLB8dkCAyxoUpx9apqa8uLb4dWBoyagDU
 OLM06w/gtdJmMZe7qRLAScsgFh1mwYIDaYusTZmIx/krgiHgrbFVHQzuc0qTDQqpY3pH
 ZQOVslE6BEZ9Ej12KU8H+wRBmmvXAd/KOZxzCxONs0VR0eTBWVgS7n8vyw486Cr8iBtZ
 c5R6ch7SrfOdeCAsEOjp7B8/vaZiachwPVyOh15bJOannWpQej2HwL2h76nWTZTBHKmN
 HiwLP5k5x/kfnbWHMuwav6F9BGEofb/sFQdxZF5bPIs3nhV46gHuv3faPlCVDuhuyQf/ kw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbnqt0va3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:16:22 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29LAERA6029357;
        Fri, 21 Oct 2022 10:16:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3kb7446tg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:16:22 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29LADbAv026999;
        Fri, 21 Oct 2022 10:16:21 GMT
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 29LAGL2b032647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:16:21 +0000
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 21 Oct 2022 03:16:19 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
Subject: [PATCH v3 1/1] mm/page_isolation: fix clang deadcode warning
Date:   Fri, 21 Oct 2022 18:15:55 +0800
Message-ID: <20221021101555.7992-2-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021101555.7992-1-quic_aiquny@quicinc.com>
References: <20221021101555.7992-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RpJbLxNcBUeI17IOzer-Zz_yzKCC9XSe
X-Proofpoint-ORIG-GUID: RpJbLxNcBUeI17IOzer-Zz_yzKCC9XSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxlogscore=701
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210059
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When !CONFIG_VM_BUG_ON, there is warning of
clang-analyzer-deadcode.DeadStores:
Value stored to 'mt' during its initialization
is never read.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 mm/page_isolation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 04141a9bea70..47fbc1696466 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -330,7 +330,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				      zone->zone_start_pfn);
 
 	if (skip_isolation) {
-		int mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
+		int mt __maybe_unused = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
 
 		VM_BUG_ON(!is_migrate_isolate(mt));
 	} else {
-- 
2.17.1

