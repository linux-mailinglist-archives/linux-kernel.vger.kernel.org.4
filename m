Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A25BE43D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiITLQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:16:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0494E6FA0D;
        Tue, 20 Sep 2022 04:16:00 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KB0HWW007387;
        Tue, 20 Sep 2022 11:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PoTT7rLq6kWSImDHRaFEIjlxRKHBE/QY5rFUGCmFcJE=;
 b=iK6mbhJC6B8azSydtKZrC+pjNnSbANnvEhHSqk+Kt2+FKMnMZwp2s1TZRCKh06y+5WcT
 G3B6+wiHycTAzMLPa2+1JUVjW85oQ/4jAlyN5X3BPm+vcqvFuQlnVazKbeXAx/mdX5e7
 zoc+gEe/Gf3kONVdtxL5raLralihPL/HBYsrmEbuYZo3+WYiv0Pe7yPIeO0+0Agx4U+o
 xJW4ie/0Ups7MuK/NyNo+GI6NJELY2FKMon4pUMtlh8XNgpGRFQ7vRPUdPFOKS7Xaaax
 Wxvvu5I/wjVLw9m7Mo5lPAda221jQsAiTcup23mq03oingOQop6fQIue5HNSKMmMiL3C sQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq4r09gu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:15:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KBFoGa008280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 11:15:51 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 04:15:46 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mka@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>, <quic_kriskura@quicinc.com>,
        <dianders@chromium.org>, <linux-clk@vger.kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET support
Date:   Tue, 20 Sep 2022 16:45:15 +0530
Message-ID: <20220920111517.10407-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y3Z4wARIr89kpMBMlGB9IJ1aZcXN44b0
X-Proofpoint-GUID: y3Z4wARIr89kpMBMlGB9IJ1aZcXN44b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200068
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
the parent domain transitions to power collapse/power off state.

On some platforms where the parent domains lowest power state
itself is Retention, just leaving the GDSC in ON (without any
RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
it to Retention.

The existing logic handling the PWRSTS_RET seems to set the
RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
but then explicitly turns the GDSC OFF as part of _gdsc_disable().
Fix that by leaving the GDSC in ON state.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
v3:
Updated changelog

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

