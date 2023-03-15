Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5DF6BA425
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCOAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCOAjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:39:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47D56507;
        Tue, 14 Mar 2023 17:39:52 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F0FBoY013475;
        Wed, 15 Mar 2023 00:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=khNSAa+z7F2W6g+sEotm79izrVqHGu8ZF/4RorDH/vg=;
 b=VQm/DGqOGytBCDwko77IxpPqp4q18Lpte02kJo2OlH50jWio/yjo/1zHeXbEKSI6ixNc
 xYwVQOpemHxdLzePzfObu0T040ttuoqNR5PepCb0p1bxxrYqYogaWbj1oOPJyASNnTbW
 Bwuhddw+hXUp+qIUqwtBRo1PpGxnqqTE22h0erxMWm2mpRABVT9Tlzx1HZmTFizmcAuP
 lHW//5FEJwx6YK8aKUPdkXCKbgjncEaGbc8k0Rtsu8t731QJgC9WB9dJFVA0lu3ibBFJ
 tI0Ze9QzAhX0GsPphewy/Q8v47SYJn0R2VAgmrJkW/cUFm3NgYIuqg0ur/GtzoeO6Udt ZA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c5r4b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 00:39:46 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32F0djT4030571;
        Wed, 15 Mar 2023 00:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 3pb1rh8ee2-1;
        Wed, 15 Mar 2023 00:39:45 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32F0djtt030558;
        Wed, 15 Mar 2023 00:39:45 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTP id 32F0diNx030549;
        Wed, 15 Mar 2023 00:39:45 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id DA28020E54; Tue, 14 Mar 2023 17:39:44 -0700 (PDT)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v9 0/5] Add function suspend/resume and remote wakeup support
Date:   Tue, 14 Mar 2023 17:39:38 -0700
Message-Id: <1678840783-15472-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rDGfrec783A0ZHpJeycZ3QUWN9StDogO
X-Proofpoint-GUID: rDGfrec783A0ZHpJeycZ3QUWN9StDogO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_16,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=816
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150004
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9
 - Added bmAtrributes wakeup bit check for arming the function for function
   remote wakeup and also in get_status api

Changes in v8
 - Added else case to return error value while setting remote wakeup feature
   selector so that device will respond with a protocl stall

Changes in v7
 - Added a check to set device remote wakeup feature selector in ep0.c based on whether
   the device is configured for remote wakeup.
 - Commit message and usb_func_wakeup documentation changes.

Changes in v6
 - Combined usb_gadget_func_wakeup API with usb_func_wakeup API in composite layer
   so that there is only 1 API for triggering function remote wakeup for better error
   handling. Since function suspend is something specific to usb functions, better to
   keep the related APIs in composite layer and above. Also documented the usage and
   applicability of the usb_func_wakeup API.

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
 drivers/usb/dwc3/ep0.c                |  19 +++---
 drivers/usb/dwc3/gadget.c             | 118 ++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/composite.c        |  58 +++++++++++++++++
 drivers/usb/gadget/configfs.c         |   3 +
 drivers/usb/gadget/function/f_ecm.c   |  76 ++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c |  63 ++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |   4 ++
 drivers/usb/gadget/udc/core.c         |  27 ++++++++
 drivers/usb/gadget/udc/trace.h        |   5 ++
 include/linux/usb/composite.h         |   8 +++
 include/linux/usb/gadget.h            |   9 +++
 13 files changed, 383 insertions(+), 14 deletions(-)

-- 
2.7.4

