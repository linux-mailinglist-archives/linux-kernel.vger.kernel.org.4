Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E326701DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjENOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 10:51:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0230D7;
        Sun, 14 May 2023 07:51:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EEpWLV015121;
        Sun, 14 May 2023 14:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Coni0niPflmtDmugwFIdUZvxTydtfDWnIgWJ9AfzHUs=;
 b=S0uDi9TziT55qbcHFJr6LKYZXM3Zs/+pUk0i+GoVwPXILcFVlUQx5va90q/pnqCJKu83
 xh+ZILYdemkqDuV6ULfh8bhg58F/r4YrA6bLGL0KO5Vc9feBpyXo4ZlDH3I3Y8coHVjV
 Adekj+ciI17+ywMBGb5kSK6NJTfnMTS82LxolKMNB7TIRDOVro0/pzzWn0vo8xhlAzVV
 /qh4VPWHmJn2ouzDkWRAKOv9GLyugdMVvSJC5HY8bj/26Ai9f0/u1vAC4rPioCM/MeXl
 /pkqcImpEUDHwxXUxoi2N3ApeGZwbg5hmHL5I6csOTCiAtPQ+qKKBy2uuNEfZRtCkiag Og== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj1vr1xeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 14:51:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34EEpV67021727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 14:51:31 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 14 May 2023 07:51:28 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
Date:   Sun, 14 May 2023 20:21:18 +0530
Message-ID: <20230514145118.20973-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wQKi0G2Rfl0dTJ-rBlPku6ie3qmQy3LQ
X-Proofpoint-ORIG-GUID: wQKi0G2Rfl0dTJ-rBlPku6ie3qmQy3LQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=983
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305140136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for dwc3_usb31 controller, if maximum_speed is limited to
super-speed in DT, then device mode is limited to SS, but host mode
still works in SSP.

The documentation for max-speed property is as follows:

"Tells USB controllers we want to work up to a certain speed.
Incase  this isn't passed via DT, USB controllers should default to
their maximum HW capability."

It doesn't specify that the property is only for device mode.
There are cases where we need to limit the host's maximum speed to
SuperSpeed only. Use this property for host mode to contrain host's
speed to SuperSpeed.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v1: https://lore.kernel.org/all/20230512170107.18821-1-quic_kriskura@quicinc.com/

Discussion regarding the same at:
https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/

 drivers/usb/dwc3/core.c | 8 ++++++++
 drivers/usb/dwc3/core.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 278cd1c33841..33bc72595e74 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1262,6 +1262,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		}
 	}
 
+	if ((hw_mode != DWC3_GHWPARAMS0_MODE_GADGET) &&
+	    (DWC3_IP_IS(DWC31)) &&
+	    (dwc->maximum_speed == USB_SPEED_SUPER)) {
+		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
+		reg |= DWC3_LLUCTL_FORCE_GEN1;
+		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+	}
+
 	return 0;
 
 err_power_off_phy:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1968638f29ed..5a251da309d4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -172,6 +172,8 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
+#define DWC3_LLUCTL		0xd024
+
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
@@ -655,6 +657,9 @@
 #define DWC3_OSTS_VBUSVLD		BIT(1)
 #define DWC3_OSTS_CONIDSTS		BIT(0)
 
+/* Force Gen1 speed on Gen2 link */
+#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
+
 /* Structures */
 
 struct dwc3_trb;
-- 
2.40.0

