Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA6B6950B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjBMTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBMTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:31:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407AC4EE4;
        Mon, 13 Feb 2023 11:31:28 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDuFGE021585;
        Mon, 13 Feb 2023 19:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=RZnTSrTjia7ioYJJ02vHl+H8jsIOKXAYsAItBwNZ7cs=;
 b=c2GVjhhaRFWcAu2yvusZiUo2IE25OgEYgTyr9bItuw38FI3msZzQ2pq0NGyRn3qsYARJ
 N1UOOV0TZ80zSjvr1iej3ION0AdXQz8X14StJnw8lRTXX+6rwFGByPy/V8mSL0lmTV0O
 p0792OoPCuSSmZGUkCxEyD5GrHKBKYHJ36B28CvDmO4+Imtf+LTKwZXwdfbg1WROnXSg
 +gihqmasEAv+iYvk/qaLtrItT2b+FCU1DwUJ5WgNXUFVgKpGOIPYYGLxDillax0T+Ho5
 771naw6KqYFM0Lbez9VmmhCm2Emp1O9yHFf01VtjDHB6uniu86ixz4DSSp5PqXv5pedt 2g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np389vuy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:31:22 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DJVMiX003260;
        Mon, 13 Feb 2023 19:31:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3np43m348q-1;
        Mon, 13 Feb 2023 19:31:21 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DJVLUw003248;
        Mon, 13 Feb 2023 19:31:21 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 31DJVLGB003243;
        Mon, 13 Feb 2023 19:31:21 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 89CF920E2F; Mon, 13 Feb 2023 11:31:21 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 0/5] Add function suspend/resume and remote wakeup support
Date:   Mon, 13 Feb 2023 11:31:11 -0800
Message-Id: <1676316676-28377-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZMCjyimOYyxy6BT489b9266QoGFSa1D9
X-Proofpoint-GUID: ZMCjyimOYyxy6BT489b9266QoGFSa1D9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=645 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302130170
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/dwc3/gadget.c             | 116 ++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/composite.c        |  42 ++++++++++++
 drivers/usb/gadget/configfs.c         |   3 +
 drivers/usb/gadget/function/f_ecm.c   |  68 ++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c |  63 ++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |   4 ++
 drivers/usb/gadget/udc/core.c         |  48 ++++++++++++++
 drivers/usb/gadget/udc/trace.h        |   5 ++
 include/linux/usb/composite.h         |   8 +++
 include/linux/usb/gadget.h            |  12 ++++
 13 files changed, 378 insertions(+), 14 deletions(-)

-- 
2.7.4

