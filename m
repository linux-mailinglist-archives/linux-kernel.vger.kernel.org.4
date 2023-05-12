Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A08700D76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjELQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjELQzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:55:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25FA5F8;
        Fri, 12 May 2023 09:55:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CFmlxn013426;
        Fri, 12 May 2023 16:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=lhOZ/2oeK/GzhajdlT28ZnFZVcUORQeus79WVFMsRe8=;
 b=pJHdfZxzg1bu3lEHergll7r16yk1vYwKJZ3qbQpwP8OJQs6+0ra/cJGYaw9fok4x+Pi8
 Bp8WVb3CQr8JreF6HNqdKHg8TmqUTK23sejvz01oZLj24LofAxKY346vrbuKrh7QKBTp
 Sr270liz5hRYSINna6VECE5whNNlfKae4hHBmD2uCOCIuOTRxoQAZRrSpi9vCC/VL6bt
 524m80DV1E1iuoh5Tlc7+hSv6HmyBBoOIqi6umLZVI7b1wpM3iR3wy5F51UB0oduc/sx
 BcIR1M9mKIk6ZzIJ8p0BbQdi/efgacBLHb9/Svj6oj8y2WZAK5YQB70Et4OVD18fcMLc ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhrdsg575-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:55:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CGtT0C013555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:55:30 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 09:55:29 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
CC:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, "Luca Weiss" <luca@z3ntu.xyz>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] leds: qcom-lpg: Fix PWM period limits
Date:   Fri, 12 May 2023 09:55:24 -0700
Message-ID: <20230512165524.3367443-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3ChKbdQx5m952mOgKS35nGwEALo8L5k6
X-Proofpoint-GUID: 3ChKbdQx5m952mOgKS35nGwEALo8L5k6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=797 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of high resolution PWM support moved the parenthesis of
the divisions in the calculation of min and max period. The result in
both divisions is in most cases truncation to 0, which limits the period
to the range of [0, 0].

Both numerators (and denominators) are within 64 bits, so the whole
expression can be put directly into the div64_u64, instead of doing it
partially.

Fixes: b00d2ed37617 ("leds: rgb: leds-qcom-lpg: Add support for high resolution PWM")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

This fixes the regression in v6.4-rc1.

 drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index c9cea797a697..7287fadc00df 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -312,14 +312,14 @@ static int lpg_calc_freq(struct lpg_channel *chan, uint64_t period)
 		max_res = LPG_RESOLUTION_9BIT;
 	}
 
-	min_period = (u64)NSEC_PER_SEC *
-			div64_u64((1 << pwm_resolution_arr[0]), clk_rate_arr[clk_len - 1]);
+	min_period = div64_u64((u64)NSEC_PER_SEC * (1 << pwm_resolution_arr[0]),
+			       clk_rate_arr[clk_len - 1]);
 	if (period <= min_period)
 		return -EINVAL;
 
 	/* Limit period to largest possible value, to avoid overflows */
-	max_period = (u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV *
-			div64_u64((1 << LPG_MAX_M), 1024);
+	max_period = div64_u64((u64)NSEC_PER_SEC * max_res * LPG_MAX_PREDIV * (1 << LPG_MAX_M),
+			       1024);
 	if (period > max_period)
 		period = max_period;
 
-- 
2.25.1

