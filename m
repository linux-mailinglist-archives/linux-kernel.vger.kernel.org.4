Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB569743B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjBOCOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjBOCOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:14:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D125BB2;
        Tue, 14 Feb 2023 18:14:18 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0USEi003544;
        Wed, 15 Feb 2023 02:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=N/Q8xRUrARuZkyS2T3bXq8Rd0gjrCy25ZIRj4zn3x8Y=;
 b=ogD4Q9kRzIcb8Kf0+SrgjTtv2pYRrQIypgdVvW8GT2cOLzhsWktFwTcR19Bg5j77BNfB
 2CmDt/C78ZjTHnSwYVFCU0yPxucTMj1XhfCnoBHaGzJhgYSuDs+9eGe+AWOdvztqoE8i
 3+gl3Ect2R/4K/C31y96z2aeiPmV/tAOFDQhOStnoQOv5qq9GhhJ5XbtgGTcjak35z9H
 NGVa/L9p7kK63I2SjV3+hYUAYrWWSaJh6zPBRZ0o69kx1+/6XC0KWnO9xzbdbizAOmpn
 ZRAsCG6kx/BVzObg3ufUDJ+iGToHpvtyr34N4D5L9KDJHBm4sRsElERa4X9b+33gXWtv Yw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7v2vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:14:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F2EE50012239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:14:14 GMT
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 18:14:13 -0800
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
Subject: [PATCH 1/1] lib/bitmap: Export __bitmap_or_equal
Date:   Tue, 14 Feb 2023 18:14:07 -0800
Message-ID: <20230215021407.13369-1-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJcsGtzBXpODc1oBUIrsrcMWlVfKAX1d
X-Proofpoint-ORIG-GUID: pJcsGtzBXpODc1oBUIrsrcMWlVfKAX1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=757 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9fa6442f704 ("cpumask: Implement cpumask_or_equal()") missed out on
exporting __bitmap_or_equal() while introducing it. Fix this.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 lib/bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1c81413c51f8..316079e39431 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -80,6 +80,7 @@ bool __bitmap_or_equal(const unsigned long *bitmap1,
 	tmp = (bitmap1[k] | bitmap2[k]) ^ bitmap3[k];
 	return (tmp & BITMAP_LAST_WORD_MASK(bits)) == 0;
 }
+EXPORT_SYMBOL(__bitmap_or_equal);
 
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
 {
-- 
2.39.1

