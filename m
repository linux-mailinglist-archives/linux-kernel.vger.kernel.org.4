Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5286F6954EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjBMXpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBMXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:45:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67F912041;
        Mon, 13 Feb 2023 15:45:43 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DKu4xA020382;
        Mon, 13 Feb 2023 23:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=vSjO40FZtfWwsVKd5C4OykQPZmscAHXtdR9bbtyDPvk=;
 b=Y7iMR1XlvUofs58YeivFRLQ5nmQJWp11sO3DcIff53gD06ZjaDjd2hbCj+yUc9uvRDId
 GE1UhAC1sFq5EMjeiXV2imJtNj0jqH74BswV9+038zcpcTgF4Dv5mXzDV1NKjEdOI+zY
 JEFHGGrZuvReIxuJyBnyeGEh0z2ry/6nKnfS66whsCLWjc5iCUB5NoxvdwmecsFZnTAv
 KC24LsrNtNyCwBKUebQGNDlbOw9dV1QJle6zIX9Z/o68G42oPE7sLfWn4tZoz+nqdRWo
 RFAFG5SEy44zSV0bFL/asSF9L/SME5NBbxh+izwj6pkkJ6no57lteYK9lz4+/YtCf1TA YA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np0qpwf9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 23:45:39 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DNjch0001055;
        Mon, 13 Feb 2023 23:45:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3np43mc0wd-1;
        Mon, 13 Feb 2023 23:45:38 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DNjc85001050;
        Mon, 13 Feb 2023 23:45:38 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 31DNjcXM001049;
        Mon, 13 Feb 2023 23:45:38 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 2116520E2A; Mon, 13 Feb 2023 15:45:38 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH] usb: gadget: Do not handle OS Descriptors config separately
Date:   Mon, 13 Feb 2023 15:45:25 -0800
Message-Id: <1676331925-4771-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UagVi-b6d9kb-NS-uCMtL5cxkBWbyRs6
X-Proofpoint-ORIG-GUID: UagVi-b6d9kb-NS-uCMtL5cxkBWbyRs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=585
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130208
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a multi-configuration composition in which the last
configuration uses OS descriptors. Since this configuration will
be sent first, the host may choose this config if it matches the
choosing criteria and ignore the user configured order of the
multi-config composition. Moreover linux based hosts do not re-order
the received configurations based on their indices but process them
in FIFO order. This may result in the host never choosing the user
desired configuration because of the re-order caused by sending the
OS descriptor config first. To avoid this, follow the user configured
order and do not handle OS descriptor config separately.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
---
 drivers/usb/gadget/composite.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index fa7dd6c..685003a 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -589,18 +589,9 @@ static int config_desc(struct usb_composite_dev *cdev, unsigned w_value)
 	w_value &= 0xff;
 
 	pos = &cdev->configs;
-	c = cdev->os_desc_config;
-	if (c)
-		goto check_config;
-
 	while ((pos = pos->next) !=  &cdev->configs) {
 		c = list_entry(pos, typeof(*c), list);
 
-		/* skip OS Descriptors config which is handled separately */
-		if (c == cdev->os_desc_config)
-			continue;
-
-check_config:
 		/* ignore configs that won't work at this speed */
 		switch (speed) {
 		case USB_SPEED_SUPER_PLUS:
-- 
2.7.4

