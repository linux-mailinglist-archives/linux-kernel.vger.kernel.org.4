Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F126701BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 07:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjENFux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjENFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 01:50:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB20B26BB;
        Sat, 13 May 2023 22:50:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E5kXDk009903;
        Sun, 14 May 2023 05:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=sUR6tkHmzYXJ5+xIiFecMJXeRayKW9w6X+HL/jJGuMs=;
 b=n0P9GrLXJ1HxMFP1S7lANQYrQ6DXPBSUWoZY+EYcBpSCFwIs0SugMF5CUrZH4mOCYIi7
 BwlnA2YY3DgIQRM4s4xhe2j20rxHce25FtJr91SJZ6pnzWD+oPiGL5JzuBKEwCHaA9+2
 tazeId7ifWwoVCZWjX8mzMxvWEfKXkvGOaP1aumParjWUBk04Vmskiz6U8DeKjTBej0I
 tjZi7+nJjBtCchQFEXwqnvOZKaqH6RZNitDrmW/ImWBPliwaYkzVXm8HbZVxU9efR3AQ
 gICT6+QFJAfsOyUh7LIUdK81f4qSvWxd3SvwO5RjxTqwsAZkfULZwCvrycHC8qa23JaN Pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj257semp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 05:49:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34E5nwbB013509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 05:49:58 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 13 May 2023 22:49:51 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v8 4/9] usb: dwc3: core: Skip setting event buffers for host only controllers
Date:   Sun, 14 May 2023 11:19:12 +0530
Message-ID: <20230514054917.21318-5-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230514054917.21318-1-quic_kriskura@quicinc.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9dwOO-2lRFP9TwpLCKylIGo4-Jp0Wy5j
X-Proofpoint-GUID: 9dwOO-2lRFP9TwpLCKylIGo4-Jp0Wy5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305140050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoC's like SA8295P where the tertiary controller is host-only
capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
Trying to setup them up during core_init leads to a crash.

For DRD/Peripheral supported controllers, event buffer setup is done
again in gadget_pullup. Skip setup or cleanup of event buffers if
controller is host-only capable.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e983aef1fb93..46192d08d1b6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -505,6 +505,11 @@ static int dwc3_alloc_event_buffers(struct dwc3 *dwc, unsigned int length)
 int dwc3_event_buffers_setup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	unsigned int			hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
+		return 0;
 
 	evt = dwc->ev_buf;
 	evt->lpos = 0;
@@ -522,6 +527,11 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	unsigned int			hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST)
+		return;
 
 	evt = dwc->ev_buf;
 
-- 
2.40.0

