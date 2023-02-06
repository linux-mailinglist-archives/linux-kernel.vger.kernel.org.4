Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE00568BFF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjBFOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBFOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:22:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91B30D6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:22:31 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316BMGSg022772;
        Mon, 6 Feb 2023 14:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wzCZ9/SzNTONcWU7bNN6TFRXX6N3AyuqU22WW+kLAGI=;
 b=CbdBKVR+0joO17jmjxiSRmIesShn6fUW7DoNLKYNrK1raZIWzzh0UJcR1sy5nzOUNAYb
 rlsSSRpQ4kWmTpNMbeyT36QF9Uo2TTvHUAaw/d5iFgyjWu7BWGsMme9T8W1pmGnKUl3v
 T1K/cOr7QfMDoxrHFbWaj+ZoS/eqyeOfy/R/hUq++xDBZ8LwHZa8118E3Rjtb5SEkhbj
 eikwrqhnG/khLGRsjaW2ikenRJGNQiAlcjuQuHyxtbKdDAcWx8QhkmBEMQNrJppR8WIn
 JOycWO0ZVjg7ao9rZZCaJXo9Jazq155B4HaRkjAYNWbOZsPvvfFxzWuVMUSrzzgxXt/5 mA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhechbx9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:22:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 316EMDDq024859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Feb 2023 14:22:13 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 6 Feb 2023 06:22:09 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <willy@infradead.org>, <markhemm@googlemail.com>,
        <rientjes@google.com>, <surenb@google.com>, <shakeelb@google.com>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V6 1/2] mm: fadvise: move 'endbyte' calculations to helper function
Date:   Mon, 6 Feb 2023 19:51:32 +0530
Message-ID: <f33155c964c2485b0d9217617a21ef1759f90884.1675690847.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1675690847.git.quic_charante@quicinc.com>
References: <cover.1675690847.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WUGLv_jSvpjhDXLissC4DuFRDJhKQlJm
X-Proofpoint-ORIG-GUID: WUGLv_jSvpjhDXLissC4DuFRDJhKQlJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=841 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index bf04fec..10169c6 100644
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
index bcf75a8..47858af 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -637,6 +637,27 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
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

