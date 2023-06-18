Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3162734612
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFRMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFRMKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 08:10:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34531B3;
        Sun, 18 Jun 2023 05:10:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35IC1xHl029496;
        Sun, 18 Jun 2023 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=zNHDB4mne5Mh07dWM3OfrbNBeOyhODIhoAblqGKDb0E=;
 b=QdJPq/owm3viMRfJdyIn3P6KPn9nX71LX32XJmMEvoPo6e849SCR2hTPAwuxZeXrp8dZ
 yZZtiLOM1RrHGrPMOnLg0mkaKr0MCRd1+igCznmbopJA0SFmknWb9Myh9MNhkbuNsQpS
 SXnoLp3O88cE99pbCG+relchrXmsQ9gb3RM1K0p9AIESlH/WjKQYWryXN+DOnl6Zv8q3
 RjlK3Ay9/XOFTsCWEDjkQnewMDUgH9ZfQ4dEyw1CtLCqHnkFMjQEU14z4vEUsS+ubvIf
 cljzagffzd65UnQKUAIGbTompqUF3Xp+sE8j2t7pDm8Jtpm4EvNNfSDlkwT23H4g4f9G lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r94e4sm8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Jun 2023 12:10:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35ICA4q1011716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Jun 2023 12:10:04 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 18 Jun 2023 05:10:01 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC during pullup
Date:   Sun, 18 Jun 2023 17:39:49 +0530
Message-ID: <20230618120949.14868-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q-hHFiyDjrZ2C_VnAoTHxgKKMCfFMxXr
X-Proofpoint-GUID: q-hHFiyDjrZ2C_VnAoTHxgKKMCfFMxXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306180116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scenarios where pullup relies on resume (get sync) to initialize
the controller and set the run stop bit, then core_init is followed by
gadget_resume which will eventually set run stop bit.

But in cases where the core_init fails, the return value is not sent
back to udc appropriately. So according to UDC the controller has
started but in reality we never set the run stop bit.

On systems like Android, there are uevents sent to HAL depending on
whether the configfs_bind / configfs_disconnect were invoked. In the
above mentioned scnenario, if the core init fails, the run stop won't
be set and the cable plug-out won't result in generation of any
disconnect event and userspace would never get any uevent regarding
cable plug out and we never call pullup(0) again. Furthermore none of
the next Plug-In/Plug-Out's would be known to configfs.

Return back the appropriate result to UDC to let the userspace/
configfs know that the pullup failed so they can take appropriate
action.

Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
Changes in v3: Added changelog mising in v2
Changes in v2: Added Fixes tag

 drivers/usb/dwc3/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 578804dc29ca..27cb671e18e3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	ret = pm_runtime_get_sync(dwc->dev);
 	if (!ret || ret < 0) {
 		pm_runtime_put(dwc->dev);
-		return 0;
+		if (ret < 0)
+			pm_runtime_set_suspended(dwc->dev);
+		return ret;
 	}
 
 	if (dwc->pullups_connected == is_on) {
-- 
2.40.0

