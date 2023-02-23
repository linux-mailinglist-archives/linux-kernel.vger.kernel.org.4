Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E386A0445
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjBWI6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjBWI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:58:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717967AAB;
        Thu, 23 Feb 2023 00:57:59 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N5p6eb018940;
        Thu, 23 Feb 2023 08:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fKcbdrkmtoXtMBijts+Czd5VFyClZMjyl2A/N0+XDpc=;
 b=Gb7wwXCndhAUO+Zmeam3AoGmB/ZdPutoE9qIiIvYCnHDLPm+noNJVczHqwxqDEOlLtZM
 T4eXyH1LkdwhV3npqzBCUNr1NrcYPNiP1M3d8n8/sRWBLTTACvIDd+Pc0QwikGjy+Odn
 CCuWaYA3So4T+hhhqLv1GXAceRQDaqG/dsffzV+moXbh5+1l4pc/AJet0kJY8xvcemD+
 9VZDip8NZywFh+k3LFlJrUdDv75kX/H37akxcep9GClw5h16Gu1hJhKHlfq/fPGngaxJ
 VZPjr+4iv17ZIGiT12YX9j0Exu/OSCMxaRE1SMUNGe8asC+KAY7siGCrLZv5jLt64lhN 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwypbrsfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:57:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31N8vrXE019387
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:57:54 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Feb 2023 00:57:50 -0800
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
Subject: [PATCH v2 0/2] Fix vbus draw of dwc3 gadget
Date:   Thu, 23 Feb 2023 14:27:43 +0530
Message-ID: <1677142665-8686-1-git-send-email-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n8fKAPfuXlhw67inoy9bgGrWPaqFuaEq
X-Proofpoint-GUID: n8fKAPfuXlhw67inoy9bgGrWPaqFuaEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_04,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=327 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/gadget/composite.c |  3 +++
 2 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.7.4

