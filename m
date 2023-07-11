Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B228A74F76E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGKRnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:43:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA5E77;
        Tue, 11 Jul 2023 10:43:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BH8mPf031415;
        Tue, 11 Jul 2023 17:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=CoZJFcJ+gZSb1Ys4vo5pJSFGi6tUjQmeWnLGrdvTqqo=;
 b=UgJNKz0QPxwrzbQvDDIWhm1o7K/Hp7+TDiDNWaFVapFA78ZwHGqdTXE1iN675cRczsJp
 v/sfEndM/5wSzct43Bp4brayKyQsReDzRw+HLAvcHY6a81A9p7WzX61DVILHmu+lYAxe
 qMvJV9hlw08KT8b42Gjs5kY42E59tPTbPe5o6P/zaueOyuxo6lW5gDfCKQLdrupZS3Hl
 WY7ayXCf9WN6Ak0F6EbkOKfUVIV8dr//rzcNMjzA/iR/xvEAjMQk0EbOZlmDP/g8lIP8
 SEi9s1rQelri+NBTyWpHts6J8noXxd6P7sMsOY6cjnGhZochBNmz5v6Us4o7mlCXvbG/ eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsb7dr2jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:43:25 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36BHdam0003641;
        Tue, 11 Jul 2023 17:43:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 3rrpxwktxd-1;
        Tue, 11 Jul 2023 17:43:23 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36BHhNUR008052;
        Tue, 11 Jul 2023 17:43:23 GMT
Received: from hu-devc-lv-u18-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.27])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTP id 36BHhNEL008045;
        Tue, 11 Jul 2023 17:43:23 +0000
Received: by hu-devc-lv-u18-c.qualcomm.com (Postfix, from userid 464172)
        id 4970A5000A8; Tue, 11 Jul 2023 10:43:23 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, rogerq@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v3 0/3] Support dwc3 runtime suspend during bus suspend
Date:   Tue, 11 Jul 2023 10:43:17 -0700
Message-Id: <20230711174320.24058-1-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L4LiMQi7KxqtnjGurIIEJm9DXBe3Ejb0
X-Proofpoint-GUID: L4LiMQi7KxqtnjGurIIEJm9DXBe3Ejb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=385 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307110159
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3
 - Added a dt property 'snps,allow-rtsusp-on-u3' to make this feature platform
   dependent as per the feedback from Thinh N.
 - Changed the RT idle/suspend/resume handling to device mode specific and dt
   property dependent.
 - Modified the cover letter to document how resume is handled on qcom platforms.
 
Changes in v2
 - Used pm_runtime_resume_and_get() API instead of pm_runtime_get_sync()
   as suggested by Dan.
 - Handled the return value in ether_wakeup_host to print error message.

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
received. The assumption here is that the dwc3 hibernation feature is not
enabled and the platform is responsible in detecting the resume events to
bring the controller out of suspend.

On Qualcomm platforms the bus resume is handled through Phy and informed to
software through wakeup capable phy interrupts.
usb2 PHY is configured to detect the Resume K event and sends an interrupt
when this event is detected. This would trigger the runtime resume of the
glue driver which would intrinsically wakeup the dwc3 child. In case of usb3 PHY,
it is configured to detect the LFPS wake signal during bus resume and the
corresponding interrupt triggers the runtime resume of the glue driver.

The series is organized in below fashion:
Patch 1: This includes the modification needed from function drivers to let
UDC enter low power mode with u_ether as an example.
Patch 2: New dt property to allow dwc3 runtime suspedn during bus suspend scenario. 
Patch 3: This has the modification needed in the UDC driver to trigger runtime
suspend whene a bus suspend interrupt is received. Since this is a platform
dependent change it is made applicable through a dt property. This also handles
resume and remote wakeup modifications from power management perspective.

Elson Roy Serrao (3):
  usb: function: u_ether: Handle rx requests during suspend/resume
  dt-bindings: usb: snps,dwc3: Add allow-rtsusp-on-u3 property
  usb: dwc3: Modify runtime pm ops to handle bus suspend

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  5 ++
 drivers/usb/dwc3/core.c                       | 26 ++++++++--
 drivers/usb/dwc3/core.h                       |  3 ++
 drivers/usb/dwc3/gadget.c                     | 40 +++++++++++++---
 drivers/usb/gadget/function/u_ether.c         | 47 +++++++++++++++----
 5 files changed, 102 insertions(+), 19 deletions(-)

-- 
2.17.1

