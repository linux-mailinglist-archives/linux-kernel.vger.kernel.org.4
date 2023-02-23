Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5176A08BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjBWMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:42:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136D54A22;
        Thu, 23 Feb 2023 04:42:14 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NBcPlF014748;
        Thu, 23 Feb 2023 12:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=npYmGH4wMPz5aLRtLbn2HyhO0pC0Ed0vtXnCx3ApF5s=;
 b=dzp4sKx3/8zGEuPTcMCyMh43EWHOjxk4cmVumtg3KeQJqgUUseIk9ULMmY1CSU9vkE4q
 DyI3mqqFCfO3Ou8hk/dwD7TZ9NJTXULCLmwl0SCGmNRMHPJLTMAXBQuQuVtQLymHIKgG
 nzvAV2PPjFUCEMMWiAWt020I/exiKle9ulMk0RbHlBwHvdzsn6IPqt4HP00h8MQFMzSN
 5ek7FfMzIM7FnmKU0Z7J/DUCCaDGXLVwHeL7s85NkNZjJh7JdhQ2rffpkmYPnGd0Wawn
 s2dYuOHi/8vm8MmHeEjA8YfEXk4HKg9wsQMPY/Lw4BzNC2uMaFWMJj/o0qpGTDlGgo7j SQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwywd1852-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:42:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NCg97o002458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 12:42:09 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Feb 2023 04:42:06 -0800
From:   Prashanth K <quic_prashk@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH v3 0/2] Fix vbus draw of dwc3 gadget
Date:   Thu, 23 Feb 2023 18:11:59 +0530
Message-ID: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 67zeVVOYTYzQxPg2dJmnohv5baEdER09
X-Proofpoint-ORIG-GUID: 67zeVVOYTYzQxPg2dJmnohv5baEdER09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_06,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=357
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3
 - Fixed minor syntax error and warnings

Changes in v2
 - Added min() calculation against CONFIG_USB_GADGET_VBUS_DRAW in case
  of unconfigured state.

Currently dwc3 gadget processes the suspend interrupt event only
if the device is in configured state. But consider a case where
device is not configured and got suspend interrupt, in that case
our gadget would still use 100mA as composite_suspend didn't happen.
But battery charging specification (BC1.2) expects a downstream
device to draw less than 2.5mA when unconnected OR suspended.

And while resuming, the gadget can draw upto 100mA if its not
configured, but the current implementation of composite_resume
doesn't consider the case of unconfigured device. This series
addresses the above mentioned issues.

Prashanth K (2):
  usb: dwc3: gadget: Change condition for processing suspend event
  usb: gadget: composite: Draw 100mA current if not configured

 drivers/usb/dwc3/gadget.c      | 11 ++---------
 drivers/usb/gadget/composite.c |  4 ++++
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.7.4

