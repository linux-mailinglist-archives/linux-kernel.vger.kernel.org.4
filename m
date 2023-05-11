Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710756FF8B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjEKRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjEKRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:48:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C711BEC;
        Thu, 11 May 2023 10:48:40 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BGeTIk017385;
        Thu, 11 May 2023 17:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0sFPaubTRXUWZKoFR6NyfxjHYF7RfCIAzZFo1HfnLAI=;
 b=L53MEu2EmHc+fbi6yKHS4Rf34KewZjpI4okD1veZ4Rcw78S5938jBF6D8sifx2gYwYTe
 P60YrJcyf0UANBhj+T8FoxriO8fQDtdgW5WBDSdnbSZCcU8O154U9KGaA4TQwOviIPG1
 Ivmm1SNsYf0AG2woI6MAk4zbZZVzUeVHcAzGxK8lOdbTqKWBV3wTH6+rm6i0r3dzRRNC
 raimJrli8hCyHNlFMfydSroML0fgoh0/BQjTNDQr/1z0dx9tb/7zknf7WvQFQNAr3BaW
 BTe8YPRqVcZlMwJTdmIlmdCQhLeJmolaVIniPYGFxgj0gDWo/tt+cb+gJVEmEMc02hvf 4A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgkxmtar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 17:48:38 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34BHma1E023156;
        Thu, 11 May 2023 17:48:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdfymgtqr-1;
        Thu, 11 May 2023 17:48:37 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BHmaBN023004;
        Thu, 11 May 2023 17:48:36 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 34BHmavX022856;
        Thu, 11 May 2023 17:48:36 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 1EDB520D75; Thu, 11 May 2023 10:48:36 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH 0/2] Allow dwc3 runtime suspend during bus suspend event
Date:   Thu, 11 May 2023 10:48:29 -0700
Message-Id: <1683827311-1462-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: APj95PpRiNj8QoJ_vYf2e9ohiiMcda-e
X-Proofpoint-GUID: APj95PpRiNj8QoJ_vYf2e9ohiiMcda-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_spam policy=outbound score=67 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=67 spamscore=67 suspectscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=-30 priorityscore=1501
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110153
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a USB link is idle, the host sends a bus suspend event to the device
so that the device can save power. But true power savings during bus
suspend can be seen only if we let the USB controller enter low power
mode and turn off the clocks. Vendor drivers may have their own runtime
power management framework to power up/down the controller. But since
vendor drivers' runtime suspend/resume routines depend on the dwc3 child
node we would need a framework to trigger dwc3 runtime pm ops whenever a
bus suspend is received. If the device wants to exit from bus suspend
state it can send a wakeup signal to the host by first bringing out the
controller from low power mode. This series implements the needed
framework to achieve this functionality when a bus suspend interupt is
received.

The series is organized in below fashion:
Patch 1: This includes the modification needed from function drivers to let
UDC enter low power mode. 
Patch 2: This has the modification needed in the UDC driver to trigger runtime
suspend whene a bus suspend interrupt is received. This also handles resume
and remote wakeup features from power management perspective.

Elson Roy Serrao (2):
  usb: function: u_ether: Handle rx requests during suspend/resume
  usb: dwc3: Modify runtime pm ops to handle bus suspend

 drivers/usb/dwc3/core.c               | 19 ++++++++++++++
 drivers/usb/dwc3/gadget.c             | 40 +++++++++++++++++++++++------
 drivers/usb/gadget/function/u_ether.c | 47 +++++++++++++++++++++++++++--------
 3 files changed, 89 insertions(+), 17 deletions(-)

-- 
2.7.4

