Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918FA6F1B11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbjD1PDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjD1PDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:03:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B52700
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:03:10 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33SDe4us016525;
        Fri, 28 Apr 2023 15:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MvMChziDPbKmzDjW3D5kNKcLaF7qRiZICSZYLgBSpNw=;
 b=P9E7iJit7t6xsb7sTGHCympRV/V6E2U7Rq9M5U8fp6K4hMIOvaf0hU7y5esW+kfSFqoS
 3zHF69KKiSrmz2ViYd++J+THezxe9ZwtYVzykVqDN6HcH3KUhIQ//MIY4qJrfIPdMaVg
 27Za8fZtmZpNGsjgpOIM+HfF4yeeeONVO2adYdwIz2cZ+yR+RLCRgAVWh6c9gXa+MRnn
 uPo8a7SY5BdrtQ8bZEsA+Tc3ns3++iYSykhho1kLi8ARqAzvoQ5QEenJNKNkuRWVVPL/
 rT8Y9Uqp5R1MDMGv5sp/mOIxvEriEup9Ot8Ezi6IUsy3d0i7C9rsztjx20GqKhbi6cks og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7thv3d1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:02:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33SF2vaS010116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 15:02:57 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 28 Apr 2023 08:02:53 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <fvdl@google.com>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V8 1/2] mm: fadvise: move 'endbyte' calculations to helper function
Date:   Fri, 28 Apr 2023 20:32:26 +0530
Message-ID: <a34b9bc8c5725817b0f8f13a6fafc17deadb2081.1682692818.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1682692818.git.quic_charante@quicinc.com>
References: <cover.1682692818.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kUudwVprHoqD1M9JhQEoLmFroyjROCTM
X-Proofpoint-ORIG-GUID: kUudwVprHoqD1M9JhQEoLmFroyjROCTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxlogscore=755
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 'endbyte' calculations that determines last byte that fadvise
can to a helper function. This is a preparatory change made for
shmem_fadvise() functionality in the next patch. No functional changes
in this patch.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/fadvise.c  | 11 +----------
 mm/internal.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index fb7c5f4..1b3cac5 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -65,16 +65,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		return 0;
 	}
 
-	/*
-	 * Careful about overflows. Len == 0 means "as much as possible".  Use
-	 * unsigned math because signed overflows are undefined and UBSan
-	 * complains.
-	 */
-	endbyte = (u64)offset + (u64)len;
-	if (!len || endbyte < len)
-		endbyte = LLONG_MAX;
-	else
-		endbyte--;		/* inclusive */
+	endbyte = fadvise_calc_endbyte(offset, len);
 
 	switch (advice) {
 	case POSIX_FADV_NORMAL:
diff --git a/mm/internal.h b/mm/internal.h
index 7920a8b..8d96811 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -657,6 +657,27 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 }
 #endif /* !CONFIG_MMU */
 
+/*
+ * Helper function to get the endbyte of a file that fadvise can operate on.
+ */
+static inline loff_t fadvise_calc_endbyte(loff_t offset, loff_t len)
+{
+	loff_t endbyte;
+
+	/*
+	 * Careful about overflows. Len == 0 means "as much as possible".  Use
+	 * unsigned math because signed overflows are undefined and UBSan
+	 * complains.
+	 */
+	endbyte = (u64)offset + (u64)len;
+	if (!len || endbyte < len)
+		endbyte = LLONG_MAX;
+	else
+		endbyte--;		/* inclusive */
+
+	return endbyte;
+}
+
 /* Memory initialisation debug and verification */
 enum mminit_level {
 	MMINIT_WARNING,
-- 
2.7.4

