Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB30A6E9DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjDTV2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjDTV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:28:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1A1992;
        Thu, 20 Apr 2023 14:28:15 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KKxw9Q016401;
        Thu, 20 Apr 2023 21:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=U7UpkUhTftXG9M2L8KSmPzF9/d6cKDHeX2VFkDIoXFo=;
 b=O7j5glLEG92Uk1AQgLpZXUeVQtGSsgadc89GoIrk2PPYFZl0pJJDe4K5N2LAUiUMynHn
 XXNvYSq7lS0PwJaA0OlvUDuG0XCXordJQ2AhkzbtXleBrotI0EbMTvsxg5CKx3Rtq2Py
 5LIGbIgceo0ufRd6NkmC1TA0xSyp7et4V3+lKK5W6qRYw9zypsd5XRLc0ptUzUxfLMQ3
 NdVlnVlC8pyxCRMOTVr3CGCH5Z7uRMcEPw+Gk1TiZlUVmqwf24TrPdwlDuBSPYcU/q8l
 qNXBLO8/CVuQcj/OyDhGpvGKbtwEnNfstxyKoEHALQ5Qw6+WcyQ4pZaSYM3WyAWmbt0p mQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2nn83b26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 21:28:12 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KLSBb2028402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 21:28:11 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 14:28:10 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_jackp@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v6 0/2] Avoid having pending end transfers on soft disconnect
Date:   Thu, 20 Apr 2023 14:27:57 -0700
Message-ID: <20230420212759.29429-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9WYr-6JPLhh0QOesTTJFs8cVUEZbkeDa
X-Proofpoint-GUID: 9WYr-6JPLhh0QOesTTJFs8cVUEZbkeDa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=709
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case there is a host which takes time to complete a SETUP transaction,
during the soft disconnect sequence multiple DWC3 EPs will have their
DWC3_EP_DELAY_STOP flag set w/o issuing the end transfer command.  Once the
controller halt sequence occurs, the soft disconnect is successful, and
the subsequent soft connect will attempt to flush the pending end transfers.

Soft disconnect sequence:
  dwc3_gadget_ep_disable   name=ep8in flags=0x3009  direction=1
  dwc3_gadget_ep_disable   name=ep4in flags=1  direction=1
  dwc3_gadget_ep_disable   name=ep3out flags=1  direction=0
  usb_gadget_disconnect   deactivated=0  connected=0  ret=0

Soft connect bug:
  BUG: spinlock already unlocked on CPU
  spin_bug+0x0
  dwc3_remove_requests+0x278
  dwc3_ep0_out_start+0xb0
  __dwc3_gadget_start+0x25c

The bug occurs due to the flush of the pending end transfers, as the gadget
start routine is not held with a spinlock.  However, if the DWC3_EP_DELAY_STOP
is set, it will call the giveback API, which attempts to unlock the dwc->lock.
Ideally, the DWC3 gadget should not have pending end transfers on a soft
connect, so fix this by:

 1. Re-locating the SETUP phase check after stop active transfers, since
 that is where the DWC3_EP_DELAY_STOP is potentially set.  This also allows
 for handling of a host that may be unresponsive by using the completion
 timeout to trigger the stall and restart for EP0.

 2. Do not call gadget stop until the poll for controller halt is
 completed.  DEVTEN is cleared as part of gadget stop, so the intention to
 allow ep0 events to continue while waiting for controller halt is not
 happening.

Changes in v6:
- Rebased on usb-testing

Changes in v5:
- Fixed stable tag

Changes in v4:
- Added stable to patches that address the actual issue
- Re-ordered patch series to include the refactor change at the end to remove
  any dependencies to the actual fix.

Changes in v3:
- Removed fixes tag in the refactor change
Wesley Cheng (2):
  usb: dwc3: gadget: Execute gadget stop after halting the controller
  usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate
    API

 drivers/usb/dwc3/gadget.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

