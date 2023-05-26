Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973A9713021
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjEZWqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEZWpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:45:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F0AA7;
        Fri, 26 May 2023 15:45:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QMhIvS015208;
        Fri, 26 May 2023 22:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=9TzElTBqBiWGy3ITsFgRPqH7LyPfTiugFHYUUA8u5Jo=;
 b=C995BIOlS7yNxzxWTKaxgcr1AUZDBUsBEuG9xqTXryU/g8kjaR7NmDTC6/CM8hBlDGju
 ubFiKer1rdRRA46aLRqD2MRtVtod3sKcWweCCQZt3ZGTsy0zLDJ1rPq8rcMvFTmy2q9Z
 /z+g8RyH2J2X39LiodcTUZDnxJsppp/OR3SWdnMXORdb3jZWrKaM70fZNzf+jD3UvUhn
 C997a+DCz670q/dfSEpP6wKeY4glDUmRmjt3piwXOjQw0mTcS8eb3leGBenWnDNB296n
 WhE73zcQmTBHuralaAyn6S4C0Ga02LOi2AOU9Wzl0nBiuHjkjIpAc/To1CmrserHu+yv ig== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qttejhm2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 22:45:52 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34QMjoTs001432;
        Fri, 26 May 2023 22:45:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3qtvwvaejv-1;
        Fri, 26 May 2023 22:45:50 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QMjohA001414;
        Fri, 26 May 2023 22:45:50 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 34QMjoH7001321;
        Fri, 26 May 2023 22:45:50 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 6A51720E0C; Fri, 26 May 2023 15:45:50 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 0/2] Support dwc3 runtime suspend during bus suspend
Date:   Fri, 26 May 2023 15:45:38 -0700
Message-Id: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Mqg8E3r70CloSq8p_eZuH5MVtSoIkBAd
X-Proofpoint-ORIG-GUID: Mqg8E3r70CloSq8p_eZuH5MVtSoIkBAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=40 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=40 mlxlogscore=17
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=40 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260195
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
received.

The series is organized in below fashion:
Patch 1: This includes the modification needed from function driver u_ether
to let UDC enter low power mode.
Patch 2: This has the modification needed in the UDC driver to trigger runtime
suspend whene a bus suspend interrupt is received. This also handles resume
and remote wakeup features from power management perspective.

Elson Roy Serrao (2):
  usb: function: u_ether: Handle rx requests during suspend/resume
  usb: dwc3: Modify runtime pm ops to handle bus suspend

 drivers/usb/dwc3/core.c               | 19 ++++++++++++++
 drivers/usb/dwc3/gadget.c             | 40 +++++++++++++++++++++++------
 drivers/usb/gadget/function/u_ether.c | 47 ++++++++++++++++++++++++++++-------
 3 files changed, 90 insertions(+), 16 deletions(-)

-- 
2.7.4

