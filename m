Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F335BD806
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISXRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:17:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B7E4B0F6;
        Mon, 19 Sep 2022 16:17:31 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JNG8u0030755;
        Mon, 19 Sep 2022 23:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=2JVuoeWw7OcLm2lHCaO6GKBrEbtYGJOJcDuzFLNOHOI=;
 b=JEq9OzQybJYVo8WsUDh4f5LJRy68liFQUwO4O/bodsVJYqf+HGnj8Oi8tukT4q+N9RJ7
 7XY2pz3X4htvVagQV801v3J9gyZrH8DwWZGOiH2ksXveAUZa5qLqggNNaR1FmrFGlfB/
 vxTQHRE/BGqZH7Mtn8WSzxu0bRrurhgo7TzCGynh/TcJPRXy2SR4GqszNpHJOJfj0lIH
 kEzVNbEU6/LKet26m59daaINh2bTWHXZRDknSUOFmWeksIM4c/VOBDFsqHNevgNQwEWf
 Y+a+n65KxCjaDAvEnHfutO5XNYP8jmVo2fE4PMLd23jnMkj1VTTKhzgw1tVK7bfzg42K uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpx508gm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 23:17:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JNCQvp031338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 23:12:26 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 16:12:26 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH] usb: dwc3: gadget: Do not clear ep delayed stop flag during ep disable
Date:   Mon, 19 Sep 2022 16:12:13 -0700
Message-ID: <20220919231213.21364-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TKZyqinj0kr9_UuYx6MTSuAk9_7OJHub
X-Proofpoint-GUID: TKZyqinj0kr9_UuYx6MTSuAk9_7OJHub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=889 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWC3_EP_DELAYED_STOP is utilized to defer issuing the end transfer command
until the subsequent SETUP stage, in order to avoid end transfer timeouts.
During cable disconnect scenarios, __dwc3_gadget_ep_disable() is
responsible for ensuring endpoints have no active transfers pending.  Since
dwc3_remove_request() can now exit early if the EP delayed stop is set,
avoid clearing all DEP flags, otherwise the transition back into the SETUP
stage won't issue an endxfer command.

Fixes: 2b2da6574e77 ("usb: dwc3: Avoid unmapping USB requests if endxfer is not complete")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b75e1b8b3f05..3e2baf22824b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1011,6 +1011,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
+	u32			mask;
 
 	trace_dwc3_gadget_ep_disable(dep);
 
@@ -1032,7 +1033,15 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	dep->stream_capable = false;
 	dep->type = 0;
-	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
+	mask = DWC3_EP_TXFIFO_RESIZED;
+	/*
+	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
+	 * set.  Do not clear DEP flags, so that the end transfer command will
+	 * be reattempted during the next SETUP stage.
+	 */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+	dep->flags &= mask;
 
 	return 0;
 }
