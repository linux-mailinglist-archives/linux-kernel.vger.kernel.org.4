Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3003F699FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBPWaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBPW36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:29:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305323CE3B;
        Thu, 16 Feb 2023 14:29:57 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GKKDVT030796;
        Thu, 16 Feb 2023 22:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=lpVCu4frIeTVWj3wV1N9ym3m5alD6BJcUNwHq1/bUBk=;
 b=ADIlkV2fVYlK6wzwqt7SVxsfSXmSRE9RdeyiGifigs8JOe6XsLhMcVHSG6aRuXAaqatT
 bnCNCTgRN5Y9bPyeqIILvDOZJgSdXIEWrDUrO9U78kn4T0cPvQyONjam33OUNnUgYeCS
 3hUwA0LxV4zxpir69yQLNAPSnKewQflZSvlRT5YkVytjy6XKPHaaVIE7mpYgCWjSXvLG
 OJsftkwLTNt+ZAbMDlZPQkt7O4kQXg7XZQPgqyHkOpPnZFGQVr9Y6dYVSQWLOquYAOS5
 UsqO1x2pAUeUujD8GUz5luRisur0vyPEbQJYQvws1mubDmabgHtoM4I2Luw4opHOQaWC wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns0hkmg8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 22:29:53 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31GMTqc9005977;
        Thu, 16 Feb 2023 22:29:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3ns328g791-1;
        Thu, 16 Feb 2023 22:29:52 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GMTqUl005963;
        Thu, 16 Feb 2023 22:29:52 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 31GMTqBH005959;
        Thu, 16 Feb 2023 22:29:52 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 28AE420E4C; Thu, 16 Feb 2023 14:29:52 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v5 0/5] Add function suspend/resume and remote wakeup support
Date:   Thu, 16 Feb 2023 14:29:43 -0800
Message-Id: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nDANb55CKc5JFjTCoZ-YL7ZM2LG5WCh3
X-Proofpoint-GUID: nDANb55CKc5JFjTCoZ-YL7ZM2LG5WCh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_16,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=627
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160192
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5
 - Add wakeup_armed check in patch2 in the link status change event handler
   so that resume gets triggeed only in the remote wakeup context.
 - Costmetic changes in patch3 and patch4 

Changes in v4
 - Moved the wakeup bit check to bind function for warning the user at an early
   stage itself.
 - Added the remote wakeup configured check to gadget_wakeup() and func_wakeup()
   routines so that wakeup can be triggered only if user has configured it.
 - Cosmetic changes with respect to renaming the variables to reflect the operation
   better.

Changes in v3
 - Modified rw_capable flag to reflect the gadgets capability for wakeup
   signalling.
 - Added a check to configure wakeup bit in bmAttributes only if gadget
   is capable of triggering wakeup.
 - Implemented a gadget op for composite layer to inform UDC whether device
   is configured for remote wakeup.
 - Added a check in __usb_gadget_wakeup() API to trigger wakeup only if the
   device is configured for it.
 - Cosmetic changes in dwc3_gadget_func_wakeup() API.

Changes in v2
 - Added a flag to indicate whether the device is remote wakeup capable.
 - Added an async parameter to _dwc3_gadget_wakeup() API and few cosmetic
   changes.
 - Added flags to reflect the state of  function suspend and function remote
   wakeup to usb_function struct rather than function specific struct (f_ecm).
 - Changed the dwc3_gadget_func__wakeup() API to run synchronously by first
   checking the link state and then sending the device notification. Also
   added debug log for DEVICE_NOTIFICATION generic cmd.
 - Added changes to arm the device for remotewakeup/function remotewakeup
   only if device is capable.

An usb device can initate a remote wakeup and bring the link out of
suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
To achieve this an interface can invoke gadget_wakeup op and wait for the
device to come out of LPM. But the current polling based implementation
fails if the host takes a long time to drive the resume signaling specially
in high speed capable devices. Switching to an interrupt based approach is
more robust and efficient. This can be leveraged by enabling link status
change events and triggering a gadget resume when the link comes to active
state.

If the device is enhanced super-speed capable, individual interfaces can
also be put into suspend state. An interface can be in function suspend
state even when the device is not in suspend state. Function suspend state
is retained throughout the device suspend entry and exit process.
A function can be put to function suspend through FUNCTION_SUSPEND feature
selector sent by the host. This setup packet also decides whether that
function is capable of initiating a function remote wakeup. When the
function sends a wakeup notification to the host the link must be first
brought to a non-U0 state and then this notification is sent.

This change adds the infrastructure needed to support the above
functionalities.

Elson Roy Serrao (5):
  usb: gadget: Properly configure the device for remote wakeup
  usb: dwc3: Add remote wakeup handling
  usb: gadget: Add function wakeup support
  usb: dwc3: Add function suspend and function wakeup support
  usb: gadget: f_ecm: Add suspend/resume and remote wakeup support

 drivers/usb/dwc3/core.h               |   5 ++
 drivers/usb/dwc3/debug.h              |   2 +
 drivers/usb/dwc3/ep0.c                |  16 ++---
 drivers/usb/dwc3/gadget.c             | 118 ++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/composite.c        |  42 ++++++++++++
 drivers/usb/gadget/configfs.c         |   3 +
 drivers/usb/gadget/function/f_ecm.c   |  68 ++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c |  63 ++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |   4 ++
 drivers/usb/gadget/udc/core.c         |  48 ++++++++++++++
 drivers/usb/gadget/udc/trace.h        |   5 ++
 include/linux/usb/composite.h         |   8 +++
 include/linux/usb/gadget.h            |  12 ++++
 13 files changed, 380 insertions(+), 14 deletions(-)

-- 
2.7.4

