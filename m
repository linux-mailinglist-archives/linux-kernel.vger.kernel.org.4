Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E5170AD70
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 12:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjEUKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjEUKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 06:07:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEC184;
        Sun, 21 May 2023 03:03:45 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LA1aSD004786;
        Sun, 21 May 2023 10:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=68kLvzwuNwZkgyfDs3LEwKDRLCkN60rJMtgAlw5OSlI=;
 b=MdlldXfZtKMmfKA03uFPYnd4AGE2kwuRGHMGIkA0lnlDvqqxfMG5DlL3TRo+3nxkqw85
 CnklEhLhfJUYZp3qWRIgBzzo5dnxotI5g/6VwSsiIDjk97mnAFILJIThmW+RZ8Un+qDj
 iL0W5UiDRpb2L7NHt0Epn58SlDV8VOq/1kamc/pDxlkKpYQhsRKjlyDHMXB9uKl7Qa6a
 htEQF3kt6dNDEEoVck9nqp7IFEVcNRONisWfj1W021hi7laN9b8WSwmcZ0FboQJQkr/I
 f4iyQRC9N9FdrVaI9DyI8TW2i9+5mn660hbS5DjxNs53MDRkNB6UiB/lTc6Dw52cStNh Kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqgf1fdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 10:03:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LA3gsL003800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 10:03:42 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 03:03:39 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf to cache
Date:   Sun, 21 May 2023 15:33:30 +0530
Message-ID: <20230521100330.22478-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tgts-eL5NTbPitm1W5NwuNnnMcUEg0zC
X-Proofpoint-GUID: tgts-eL5NTbPitm1W5NwuNnnMcUEg0zC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=759 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation, the check_event_buf call reads the
GEVNTCOUNT register to determine the amount of event data generated
and copies it from ev->buf to ev->cache after masking interrupt.

During copy if the amount of data to be copied is more than
(length - lpos), we fill the ev->cache till the end of 4096 byte
buffer allocated and then start filling from the top (lpos = 0).

In one instance of SMMU crash it is observed that GEVNTCOUNT register
reads more than 4096 bytes:

dwc3_readl   base=0xffffffc0091dc000  offset=50188  value=63488

(offset = 50188 -> 0xC40C)  -> reads 63488 bytes

As per crash dump:
dwc->lpos = 2056

and evt->buf is at 0xFFFFFFC009185000 and the crash is at
0xFFFFFFC009186000. The diff which is exactly 0x1000 bytes.

We first memcpy 2040 bytes from (buf + lpos) to (buf + 0x1000).

And then we copy the rest of the data (64388 - 2040) from beginning
of dwc->ev_buf. While doing so we go beyond bounds as we are trying
to memcpy 62348 bytes into a 4K buffer resulting in crash.

Fix this by limiting the total data being copied to ev->length to
avoid copying data beyond bounds. Moreover this is logical because if
the controller generated events more than the size of ring buffer,
some of them might have been overwritten by the controller.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Only one instance of this crash was observed so far. As per the
databook:

"The controller always leaves one entry free in each Event Buffer.
When the Event Buffer is almost full, hardware writes the Event
Buffer Overflow event and the USB eventually gets stalled when
endpoints start responding NRDY or the link layer stops returning
credits (in SuperSpeed). This event is an indication to software that
it is not processing events quickly enough. During this time, events
are queued up internally. When software frees up Event Buffer space,
the queued up events are written out and the USB returns to normal
operation"

I didn't see any overflow event in the event buffer after parsing
crash dump. Although this could be some HW issue, I thought we can
include this fix in software as well to avoid such scenario.

 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5965796bc5d5..cff043ab9017 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4457,6 +4457,9 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length)
+		count  = evt->length;
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.40.0

