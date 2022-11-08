Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132B6208DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiKHFRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKHFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:17:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AB118B17
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 21:17:07 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A84B9Ga015264;
        Tue, 8 Nov 2022 05:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=S6jK9mufNCZcXvT9ZcdkVQeTAQ2zKq0t0XbX+dTy02k=;
 b=itXwuCDEja/yhYGD8SDehbKhuehPKfv8uHvGyXhqkV5YpFOTGyqluw/bXLSxEE3wgKdK
 G/AfNgUjkj2MawyrvwvaEWAPE2QNKQdcQ+LOBQ3Dag2M3HCDESWdjA0wEW81YvGlmFN0
 W6hzVAyCwSbPGAjE54ngDm9CPxKOfu7NuBI7f9fR+/QwFUS0mzq+9e4JnzdNuCqbBvd/
 TGUcsTX/6ap3Gv+1Vl7lnrzfjXRLzE5x9EcBxAF+/F6+U5ef2qtVXeVh0SRqDB69pIPW
 PY+FPC86e7XL+0l9uWO4qpriw6cOfnqEYwWqwFjpwbunN8HEsOO6OyMwzvWK2Sq9a6jC Lg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqby8rmyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 05:17:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A85H0r4016881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 05:17:00 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 21:16:57 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <vbabka@suse.cz>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: fix compiler warning with make W=1
Date:   Tue, 8 Nov 2022 10:46:22 +0530
Message-ID: <1667884582-2465-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LcIJ4o3qaFCkyAOlWkR3qqF7fF7YlcMR
X-Proofpoint-GUID: LcIJ4o3qaFCkyAOlWkR3qqF7fF7YlcMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=448 bulkscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below compiler warnings reported with 'make W=1 mm/'.
mm/page_ext.c:178: warning: Function parameter or member 'page_ext' not
described in 'page_ext_put'.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/page_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index affe8024..ddf1968 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -166,7 +166,7 @@ struct page_ext *page_ext_get(struct page *page)
 
 /**
  * page_ext_put() - Working with page extended information is done.
- * @page_ext - Page extended information received from page_ext_get().
+ * @page_ext: Page extended information received from page_ext_get().
  *
  * The page extended information of the page may not be valid after this
  * function is called.
-- 
2.7.4

