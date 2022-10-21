Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD5606F54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJUFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUFUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:20:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525C74359
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 22:20:08 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L57j8i016953;
        Fri, 21 Oct 2022 05:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6nW+WJlBFsHk7JFin27cvLWx+IgUry3lsfRoYGa70l4=;
 b=Dds7efkJ3W0nG9xR6l1rrrJWsyziT/q+H+YIT4fTLmemXbW6FLM6AJI99dI8gmU3eXYd
 Aj/nZW+rC2Gy2lFRjRFW7XsWld4wl/sjIdTpz1ecKtReKkASR72rbIP3LG5KV9+2cRay
 yQVA7Z+ybWv/91phzwud5muMK2oZ71FHenKVJ4bCiiyPc+Evaygdaa6V8ZzNjU2aaXBT
 VcWSUSV8soNShRvlEJ/CIK6/G8eoIUPdtFNzcjbMg8QVBVYtF8pipYKdLkSt9vzfgXVi
 JFMuxbuMKCysNDEvoFnqdPDSRcWnPJkL57YNz2ewPtmtFNsmexC7G5b/0x5okFV3TrDn 9A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kb5pyj6vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:20:04 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5K3Wv009762;
        Fri, 21 Oct 2022 05:20:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kaa8crqty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:20:03 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29L5K3gM009749;
        Fri, 21 Oct 2022 05:20:03 GMT
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 29L5K3IW009747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 05:20:03 +0000
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 22:20:01 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <akpm@linux-foundation.org>, <ziy@nvidia.com>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>, <mike.kravetz@oracle.com>,
        <opendmb@gmail.com>
Subject: [PATCH v2 1/1] mm/page_isolation: fix clang deadcode warning
Date:   Fri, 21 Oct 2022 13:19:36 +0800
Message-ID: <20221021051936.15346-2-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021051936.15346-1-quic_aiquny@quicinc.com>
References: <20221021051936.15346-1-quic_aiquny@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KkP45b8xa0BfHK9rPi1IOtgADjuYQA6k
X-Proofpoint-ORIG-GUID: KkP45b8xa0BfHK9rPi1IOtgADjuYQA6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_01,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=658 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210030
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
 mm/page_isolation.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 04141a9bea70..a7a478a22123 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -330,9 +330,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				      zone->zone_start_pfn);
 
 	if (skip_isolation) {
-		int mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-
-		VM_BUG_ON(!is_migrate_isolate(mt));
+		VM_BUG_ON(!is_migrate_isolate(get_pageblock_migratetype(
+						pfn_to_page(isolate_pageblock))));
 	} else {
 		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), migratetype,
 				flags, isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
-- 
2.17.1

