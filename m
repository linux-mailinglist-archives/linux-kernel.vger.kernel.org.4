Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E69718A96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjEaTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEaTzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:55:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA99D;
        Wed, 31 May 2023 12:55:15 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJgkmS017064;
        Wed, 31 May 2023 19:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2xUay5QeXTlatgGE6j8ek7NctWRMFPH65lsOBOP3k98=;
 b=l+DYKdd0IyRgowx7opNB4V9H8AGQ0dH2/OApbH19pToUlK1EBIkWLCmu9US/wFhd9Hba
 67D5wpTlIwwjdQ3MMGIIjV2ziQI5Gzs1J4X/owR5+d79tXQm3nl1N9A0zFB2tYtME3iq
 +J3TggCRAuOM2zFIhSPq2THl5IzxJWhEDCqBTUfv5ZiCLOul0LfnnLo88mWy35flc9xa
 cS2CF32CRpjnLEbPVeHuFyNKbXOA0KMElw4+EnOTNkMG1d+Plh3+7CmMa7QekhV8sT/O
 TtmHurNwbwENs55dB4/DXN+sHqli1YpCBmJDHFzUeZJ/kc1TdSZnapBRqQQzbC5yeNDl wA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx30f9h07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 19:54:41 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34VJsei4026527;
        Wed, 31 May 2023 19:54:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxm8yaq-1;
        Wed, 31 May 2023 19:54:40 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VJseRn026522;
        Wed, 31 May 2023 19:54:40 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTP id 34VJse6e026520;
        Wed, 31 May 2023 19:54:40 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 0B96E20E4A; Wed, 31 May 2023 12:54:40 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH] usb: dwc3: Skip TRBs while removing requests in disconnect path
Date:   Wed, 31 May 2023 12:54:31 -0700
Message-Id: <1685562871-17024-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lgQEWHqD0ojYAbPBiN_I_3aHgm_xGYc1
X-Proofpoint-ORIG-GUID: lgQEWHqD0ojYAbPBiN_I_3aHgm_xGYc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=634 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310169
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a scenario where cable disconnect happens when there is an active
usb reqest queued to the UDC. As part of the disconnect we would issue an
end transfer with no interrupt-on-completion before giving back this
request. Since we are giving back the request without skipping TRBs the
num_trbs field of dwc3_request still holds the stale value previously used.
Function drivers re-use same request for a given bind-unbind session and
hence their dwc3_request context gets preserved across cable
disconnect/connect. When such a request gets re-queued after cable connect,
we would increase the num_trbs field on top of the previous stale value
thus incorrectly representing the number of TRBs used. Fix this by invoking
skip_trbs() in the ep disable path.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 578804d..b45e917 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -986,6 +986,8 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	return 0;
 }
 
+static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req);
+
 void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
@@ -1000,6 +1002,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
 
+		dwc3_gadget_ep_skip_trbs(dep, req);
 		dwc3_gadget_giveback(dep, req, status);
 	}
 
@@ -1012,6 +1015,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 	while (!list_empty(&dep->cancelled_list)) {
 		req = next_request(&dep->cancelled_list);
 
+		dwc3_gadget_ep_skip_trbs(dep, req);
 		dwc3_gadget_giveback(dep, req, status);
 	}
 }
-- 
2.7.4

