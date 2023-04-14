Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B236E252D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDNOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjDNOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:06:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49761BB98;
        Fri, 14 Apr 2023 07:06:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDZI6c017611;
        Fri, 14 Apr 2023 14:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=aSGy/6L3Sa9Hl9XV6jA3GTtSF3ICUl9iaHgYnt+Nkno=;
 b=YL0X7rRJxXnHgFzEkJne59ES4aldMSbAwpsTRrXnAnzIFR8TyYiAq/oWn/K5kn/GvA9Y
 pR/vl4JEil0jHnya8HEO93NOClCo6bfLftQvfqnluiOyRCvtAHKZBtOq9RHSxaDoyXXW
 JLAZLeQCpf68zpN8YSAOYQzLkxARurs4h+bAsPujdMIvooFuQsFTDy4hRM3/O4NoZS9n
 qhzmJt8R8uoSwt9onGHtCmS3ddUfb0RdAg0Oux3ai3Wl/ZpgeDsyMHhV1fTl6WyFgIEp
 sw0UGDJ41gPH5DPIWVMV5xl8+jy+1ViPjhDYv3U8+hUjIolvZtLnXonhU9I6XZE1uuoz pg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3py20e0un2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 14:06:04 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 33EE60W0024678;
        Fri, 14 Apr 2023 14:06:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3pu1bkwpw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Apr 2023 14:06:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33EE5vlE024643;
        Fri, 14 Apr 2023 14:06:00 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 33EE60Et024670;
        Fri, 14 Apr 2023 14:06:00 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id B85A4466C; Fri, 14 Apr 2023 19:35:59 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
Date:   Fri, 14 Apr 2023 19:35:52 +0530
Message-Id: <1681481153-24036-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R06U7P0wMMqJ2OWwe99qFtnzJkXnAUm2
X-Proofpoint-ORIG-GUID: R06U7P0wMMqJ2OWwe99qFtnzJkXnAUm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_07,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=608
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140127
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of DMA mode support to qspi driver.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v2 -> v3:
- modified commit message
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 31728f4..03a55b8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3432,6 +3432,7 @@
 		qspi: spi@88dc000 {
 			compatible = "qcom,sc7280-qspi", "qcom,qspi-v1";
 			reg = <0 0x088dc000 0 0x1000>;
+			iommus = <&apps_smmu 0x20 0x0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

