Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B40700D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjELRBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbjELRB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:01:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB95A250;
        Fri, 12 May 2023 10:01:25 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDxbt7008999;
        Fri, 12 May 2023 17:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=l+x8I3jMdw0dPpamdqg83+y7xFpkmuF7ZN4JBnW8eHY=;
 b=HXqkf8IBF3DeGkIrK5YVmcTNyPwLow5BDqfAOgMBtTb9qH5A2wBotY57sG6n0mXnO1e4
 +kWx+Kemw/AmO9HmaocjcZJ0T9Cl4fCuvGQV8qebv70TvWcdp/WVW9+oOUeTHf9Jqlaj
 t2Mh+RCnFQq/USL8k29Mi4EACnuUsYqpTlXx5kPr/9L5vGOUvs48Rt3OpCYU2wEjqYLl
 YZb4EJpippcisqlRTc1HjPrLaKehUgQo/cMZRIZjeyF9CqZFCf0giKvVAHLUKYHb7yXM
 +xRMZnv90jxdBtacFymhLZCvqBbYqJRcKBFpqnBUMclqUANAqffw2zqOD9QJWYhss5zW bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhpsdre58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:01:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CH1Ljk001778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:01:21 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 10:01:18 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
Date:   Fri, 12 May 2023 22:31:07 +0530
Message-ID: <20230512170107.18821-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bAuNgqmSHth-X4Ms25_G0nfWt_NIUVk6
X-Proofpoint-ORIG-GUID: bAuNgqmSHth-X4Ms25_G0nfWt_NIUVk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=858 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for dwc3_usb31 devices, if maximum_speed is limited to
super-speed in DT, then device mode is limited to SS, but host mode
still works in SSP.

The documentation for max-speed property is as follows:

"Tells USB controllers we want to work up to a certain speed.
Incase  this isn't passed via DT, USB controllers should default to
their maximum HW capability."

It doesn't specify that the property is only for device mode.
Fix this by forcing controller supported max speed to Gen1 by
setting LLUCTL.Force_Gen1 bit if controller is DWC3_USB31 and
max speed is mentioned as SS in DT.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Discussion regarding the same at:
https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/

 drivers/usb/dwc3/core.c | 13 +++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0beaab932e7d..989dc76ecbca 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,18 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+static void dwc3_configure_host_speed(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	if (DWC3_IP_IS(DWC31) &&
+	   (dwc->maximum_speed == USB_SPEED_SUPER)) {
+		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
+		reg |= DWC3_LLUCTL_FORCE_GEN1;
+		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+	}
+}
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -194,6 +206,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
+		dwc3_configure_host_speed(dwc);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d56457c02996..29b780a58dc6 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -121,6 +121,10 @@
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
 #define DWC3_GUCTL2		0xc19c
+#define DWC3_LLUCTL		0xd024
+
+/* Force Gen1 speed on Gen2 link */
+#define DWC3_LLUCTL_FORCE_GEN1	BIT(10)
 
 #define DWC3_VER_NUMBER		0xc1a0
 #define DWC3_VER_TYPE		0xc1a4
-- 
2.40.0

