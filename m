Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159CC5BAB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIPKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIPKob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:44:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B0AEDAE;
        Fri, 16 Sep 2022 03:25:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G5weHb010809;
        Fri, 16 Sep 2022 10:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PqaWqYu0zhPesQ8AAwG22SO2TRy2izSxwEgm3Wxj4WA=;
 b=AD4DXqo/1m5qkzmvg8oSD/xmD8ZoUcSDKYgMuepIdFVNvoX6zPY8Llvm9Q34/8SBfJXc
 y0nQiiQq5MunqSZ4h204T0HvWK0Qql7LOWDZHHzYXoy+X7g9zGe4SuKKQ19nFvfsJSxL
 crwgdBBcbZkx1PC9EVSxDLczY1QNfbPuOQ1Yb3Jrhu9Pi+RTXQGwVlxzHDIGg9QcXBec
 Qzh543Nk1UUOV9PjPzSCS8yz+t105dMFn2MAhyDI96bE4LQJqUtqUSeMW7lU2l8UmlEU
 klBpuKvkRo5zIGTVhaasRO3xC4T7Z3SMHt8fV2oShANgjIj8NwrvOyYaAZM/5vrHfzMW Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm9m1ahkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:24:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28GAOgeQ021458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:24:42 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 16 Sep 2022 03:24:38 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v2 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
Date:   Fri, 16 Sep 2022 15:54:15 +0530
Message-ID: <20220916102417.24549-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _d4leHQFdQ23yRQ9nNCPdyOLzUffTKGZ
X-Proofpoint-GUID: _d4leHQFdQ23yRQ9nNCPdyOLzUffTKGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GDSCs cannot be transitioned into a Retention state in SW.
When either the RETAIN_MEM bit, or both the RETAIN_MEM and
RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
takes care of retaining the memory/logic for the domain when
the parent domain transitions to low power state.
The existing logic handling the PWRSTS_RET seems to set the
RETAIN_MEM/RETAIN_PERIPH bits but then explicitly turns the
GDSC OFF as part of _gdsc_disable(). Fix that by leaving the
GDSC in ON state.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
No changes in v2: 

There are a few existing users of PWRSTS_RET and I am not
sure if they would be impacted with this change

1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
gdsc is actually transitioning to OFF and might be left
ON as part of this change, atleast till we hit system wide
low power state.
If we really leak more power because of this
change, the right thing to do would be to update .pwrsts for
mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
I dont have a msm8974 hardware, so if anyone who has can report
any issues I can take a look further on how to fix it.

2. gpu_gx_gdsc in gpucc-msm8998.c and
   gpu_gx_gdsc in gpucc-sdm660.c
Both of these seem to add support for 3 power state
OFF, RET and ON, however I dont see any logic in gdsc
driver to handle 3 different power states.
So I am expecting that these are infact just transitioning
between ON and OFF and RET state is never really used.
The ideal fix for them would be to just update their resp.
.pwrsts to PWRSTS_OFF_ON only.

 drivers/clk/qcom/gdsc.c | 10 ++++++++++
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index d3244006c661..ccf63771e852 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -368,6 +368,16 @@ static int _gdsc_disable(struct gdsc *sc)
 	if (sc->pwrsts & PWRSTS_OFF)
 		gdsc_clear_mem_on(sc);
 
+	/*
+	 * If the GDSC supports only a Retention state, apart from ON,
+	 * leave it in ON state.
+	 * There is no SW control to transition the GDSC into
+	 * Retention state. This happens in HW when the parent
+	 * domain goes down to a Low power state
+	 */
+	if (sc->pwrsts == PWRSTS_RET_ON)
+		return 0;
+
 	ret = gdsc_toggle_logic(sc, GDSC_OFF);
 	if (ret)
 		return ret;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 5de48c9439b2..981a12c8502d 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -49,6 +49,11 @@ struct gdsc {
 	const u8			pwrsts;
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_OFF		BIT(0)
+/*
+ * There is no SW control to transition a GDSC into
+ * PWRSTS_RET. This happens in HW when the parent
+ * domain goes down to a low power state
+ */
 #define PWRSTS_RET		BIT(1)
 #define PWRSTS_ON		BIT(2)
 #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
-- 
2.17.1

