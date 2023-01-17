Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F05E66E8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAQV4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjAQVzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:55:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA207495A;
        Tue, 17 Jan 2023 13:55:16 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HLseE5007346;
        Tue, 17 Jan 2023 21:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=tghDuCbHMOsGrQiRVjE1T+P2G7XbZvB3V2ydei7z67k=;
 b=O/G+XHaCevNE1WkrEE3paMwODi79XOroFR/1LsZzqsLwooNCgUlw8fmo3cd8jGQG8K7b
 VES2ZD/rmbuJh2sPRa88YnDsMWJKtBES47taRH7syAGM+trJzTLUMBwmo467y6EVsV0p
 zE4q1kB+JYm8wJ7hybRPm0MgWAbJ1KXd797aaYeheyPzdpt/EHLh3A9zsYBqSmrGnjJ9
 CGQsDSGKQqk6JYR4DFLLnOpJAuY+jzEZJYnyUir3eKng40izMOeXvWblGuFmD3yY5O01
 RoazoV9cACk5UIXRTH39oN0UTloolWxJlE6NmheSFZ+uVEzkXrMaYSJaGyKio99sloHu PA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n60bx0fcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 21:55:10 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30HLt901010736;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 3n3nfkd8fe-1;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HLt9uP010723;
        Tue, 17 Jan 2023 21:55:09 GMT
Received: from hu-devc-lv-c.qualcomm.com (hu-eserrao-lv.qualcomm.com [10.47.235.164])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTP id 30HLt9o1010710;
        Tue, 17 Jan 2023 21:55:09 +0000
Received: by hu-devc-lv-c.qualcomm.com (Postfix, from userid 464172)
        id 06B6D20DF5; Tue, 17 Jan 2023 13:55:09 -0800 (PST)
From:   Elson Roy Serrao <quic_eserrao@quicinc.com>
To:     gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        balbi@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 0/5] Add function suspend/resume and remote wakeup support
Date:   Tue, 17 Jan 2023 13:55:02 -0800
Message-Id: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0iFFdjL_d1XYfULpiSkSGb4SUUQeNqgO
X-Proofpoint-ORIG-GUID: 0iFFdjL_d1XYfULpiSkSGb4SUUQeNqgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=525 impostorscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170175
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  usb: gadget: Add remote wakeup capable flag
  usb: dwc3: Add remote wakeup handling
  usb: gadget: Add function wakeup support
  usb: dwc3: Add function suspend and function wakeup support
  usb: gadget: f_ecm: Add suspend/resume and remote wakeup support

 drivers/usb/dwc3/core.h               |  4 ++
 drivers/usb/dwc3/debug.h              |  2 +
 drivers/usb/dwc3/ep0.c                | 16 +++---
 drivers/usb/dwc3/gadget.c             | 93 ++++++++++++++++++++++++++++++++---
 drivers/usb/gadget/composite.c        | 29 +++++++++++
 drivers/usb/gadget/function/f_ecm.c   | 69 ++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.c | 63 ++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ether.h |  4 ++
 drivers/usb/gadget/udc/core.c         | 19 +++++++
 include/linux/usb/composite.h         |  6 +++
 include/linux/usb/gadget.h            |  4 ++
 11 files changed, 294 insertions(+), 15 deletions(-)

-- 
2.7.4

