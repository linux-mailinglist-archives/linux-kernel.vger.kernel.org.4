Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEF6ACEDD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCFUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCFUGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:06:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087FC74334;
        Mon,  6 Mar 2023 12:06:12 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326He8ZH002484;
        Mon, 6 Mar 2023 20:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9vJWmm8MxUmkFCvg8hWCRyR+rVKxw+Jb3hxc5UOhDdw=;
 b=A3LmlLbJ0ZYii83RfytQIVP4FdyEyLgi0OhTKFhvTuP6KBmBF97RZH7oCEiUb1nh/ABB
 gnDuuYNyUrf+Cv7sAp26FFHfQsuieEMhGqLJ4yunKOLqKykpCfccayfSWaTmjBtx0Oaz
 fJZHZX7FoMyNeS3EY9AIQyhH2N0Sshg4OOUf0dGtrfop77Er6C30cpih6Z5/gjjY7rka
 eVmKGr94aZsy7IdMwwcGfGM7VqX3zxDDdF7/GJTD8CPBxhMNp9BhezYeanOay0jYY6cb
 FZOlQ91qFdUiJVVjDh4RrBQKIVIkkArpeRj1KwLhSxUDibIt6jkk/JMQUCn2gc6sQ0+e cw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p415hwwdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 20:06:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326K69Va021723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 20:06:09 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 12:06:09 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v5] usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
Date:   Mon, 6 Mar 2023 12:05:57 -0800
Message-ID: <20230306200557.29387-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hwM4MS4WYmgYBGVl13_X816I1ASkOLEq
X-Proofpoint-GUID: hwM4MS4WYmgYBGVl13_X816I1ASkOLEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_13,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=615 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060175
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, there was a 100uS delay inserted after issuing an end transfer
command for specific controller revisions.  This was due to the fact that
there was a GUCTL2 bit field which enabled synchronous completion of the
end transfer command once the CMDACT bit was cleared in the DEPCMD
register.  Since this bit does not exist for all controller revisions and
the current implementation heavily relies on utizling the EndTransfer
command completion interrupt, add the delay back in for uses where the
interrupt on completion bit is not set, and increase the duration to 1ms
for the controller to complete the command.

An issue was seen where the USB request buffer was unmapped while the DWC3
controller was still accessing the TRB.  However, it was confirmed that the
end transfer command was successfully submitted. (no end transfer timeout)
In situations, such as dwc3_gadget_soft_disconnect() and
__dwc3_gadget_ep_disable(), the dwc3_remove_request() is utilized, which
will issue the end transfer command, and follow up with
dwc3_gadget_giveback().  At least for the USB ep disable path, it is
required for any pending and started requests to be completed and returned
to the function driver in the same context of the disable call.  Without
the GUCTL2 bit, it is not ensured that the end transfer is completed before
the buffers are unmapped.

Fixes: cf2f8b63f7f1 ("usb: dwc3: gadget: Remove END_TRANSFER delay")
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
Changes in v5:
- Updated commit text with more details
- Added fixes tag

Changes in v4:
- Updated DWC3 revision check logic to look for !DWC3 based IP (ie DWC32 and
DWC31 variants)
- Fixed incorrect delay reference in comments

Changes in v3:
- Fixed subject title and modified commit text to reference the new 1ms
delay

Changes in v2:
- Increase delay value to 1ms
- Make this applicable to DWC32 revisions as well

 drivers/usb/dwc3/gadget.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3c63fa97a680..cf5b4f49c3ed 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1699,6 +1699,7 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
+	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1722,10 +1723,13 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt) {
+		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
+			mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
+	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
@@ -3774,7 +3778,11 @@ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
 	 * enabled, the EndTransfer command will have completed upon
 	 * returning from this function.
 	 *
-	 * This mode is NOT available on the DWC_usb31 IP.
+	 * This mode is NOT available on the DWC_usb31 IP.  In this
+	 * case, if the IOC bit is not set, then delay by 1ms
+	 * after issuing the EndTransfer command.  This allows for the
+	 * controller to handle the command completely before DWC3
+	 * remove requests attempts to unmap USB request buffers.
 	 */
 
 	__dwc3_stop_active_transfer(dep, force, interrupt);
