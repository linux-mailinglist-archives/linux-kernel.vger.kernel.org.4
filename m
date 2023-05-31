Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC6718E77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjEaW1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjEaW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:27:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6013121;
        Wed, 31 May 2023 15:27:35 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VL0Ser014433;
        Wed, 31 May 2023 22:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XYphsjpFQZ8qoW0HxD5fU0fwEGPiJV9LRkSsjbqnP9k=;
 b=R0psU+9YGwnkQkRzEIlFCJ6qEn+siZoo0qpfzhEMUtyED67e0mwZ1+icd68+5/VsR4Wq
 0wGGR3l53CMY7xzGisB2bjygYLSZJIzSCfJ9Hh3ayY/EpQs1dLlc9tN9m6E54LeCLeTV
 oaTWH7Bl+QRHzRUDO857nMWaoKWWfce+i59lKVoDq2VuWdV9590UzCz50iKgEJ5MXvUP
 cOPP/4jozPF0kKjOdyMO5JbXRoCJXLcDBF0rgxnYXhxFedNnj+23HSGX/2jvqRCGUe9i
 0/fu36fIbd4LOMrOUziWk+V+vTkSsyD5qOatHm6nSbFYudyOajIv/TPTw/1PnOYPridx OQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxdr984wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VMRWN0009728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:32 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 15:27:31 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 1/2] usb: host: xhci: Do not re-initialize the XHCI HC if being removed
Date:   Wed, 31 May 2023 15:27:18 -0700
Message-ID: <20230531222719.14143-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531222719.14143-1-quic_wcheng@quicinc.com>
References: <20230531222719.14143-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: usDMe0dUJbpodKc9F1h83bCyQxWrYyqg
X-Proofpoint-GUID: usDMe0dUJbpodKc9F1h83bCyQxWrYyqg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=803 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During XHCI resume, if there was a host controller error detected the
routine will attempt to re-initialize the XHCI HC, so that it can return
back to an operational state.  If the XHCI host controller is being
removed, this sequence would be already handled within the XHCI halt path,
leading to a duplicate set of reg ops/calls.  In addition, since the XHCI
bus is being removed, the overhead added in restarting the HCD is
unnecessary.  Check for the XHC state before setting the reinit_xhc
parameter, which is responsible for triggering the restart.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b81313ffeb76..02a30b883bde 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1028,7 +1028,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	temp = readl(&xhci->op_regs->status);
 
 	/* re-initialize the HC on Restore Error, or Host Controller Error */
-	if (temp & (STS_SRE | STS_HCE)) {
+	if ((temp & (STS_SRE | STS_HCE)) &&
+	    !(xhci->xhc_state & XHCI_STATE_REMOVING)) {
 		reinit_xhc = true;
 		if (!xhci->broken_suspend)
 			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
