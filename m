Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569F5718E72
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjEaW1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjEaW1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:27:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A39D;
        Wed, 31 May 2023 15:27:35 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLN6wq004816;
        Wed, 31 May 2023 22:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NioG84benTqgh2FgyViWa+iQXvzohB7fZ1EUffswWPM=;
 b=McYh0Sjoz0+GsKQH6BDdoLUf5vfPoN8Om0Q05GWebnIv5kLZYYfZ7jGI/1IOkGBcCA1O
 TESEo/IVVPZ3UDQUHRPfcigLyDMER78tHbh41vM2A8j7Y+f+vhKp4pfaZNdabTAVWYPX
 L2iTFNV/9RkI6DrCzG+HAH8OCeP0OvSox7o1ch7Ks9KLQipkBdBGq9tO7lFjkXQtMBuD
 MFCeC8t1zf9Fryc7oY5Vjg6JwQ9JqhJyzNQWAV33kirZDxPJwRhwh7xW9hd4Idbw6BRY
 4Xv6g3MRVOIjLDyGKu7kECuHTz6nHr39gUGOloThyKftsZGHFfLttXt4MppXMFGe5xFu vQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8qae02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VMRWgn007459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 22:27:32 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 15:27:32 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 2/2] usb: host: xhci-plat: Set XHCI_STATE_REMOVING before resuming XHCI HC
Date:   Wed, 31 May 2023 15:27:19 -0700
Message-ID: <20230531222719.14143-3-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: nA6Ysp8rqCH_H2jetBJTEgGnyi0wnrRj
X-Proofpoint-GUID: nA6Ysp8rqCH_H2jetBJTEgGnyi0wnrRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=831 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are situations during the xhci_resume() sequence, which allows for
re-initializing of the XHCI HC.  However, in case the HCD is being removed,
these operations may not be needed.  Set the removal state before issuing
the runtime PM get on the XHCI device, so that the XHCI resume routine will
know when to bypass the re-init logic.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a666b21c21bb..a1e552d9da09 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -403,8 +403,8 @@ int xhci_plat_remove(struct platform_device *dev)
 	struct clk *reg_clk = xhci->reg_clk;
 	struct usb_hcd *shared_hcd = xhci->shared_hcd;
 
-	pm_runtime_get_sync(&dev->dev);
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
+	pm_runtime_get_sync(&dev->dev);
 
 	if (shared_hcd) {
 		usb_remove_hcd(shared_hcd);
